Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F2CC83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A08D83826;
	Fri, 11 Jul 2025 00:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gxVtDzF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE1E835C9; Fri, 11 Jul 2025 00:42:07 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4597583754
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40af40aeef6so500502b6e.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187322; x=1752792122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3M7eI1w8ulExeq82A6lEYFFT3utrWxAH1KrDWwlA/bI=;
 b=gxVtDzF058eniP4xK4vSemxURZlFY/GxNUldSV+31GOTJcXyv7MUutDRgmlNvMLzMv
 JijbWKma4SUzaPSUjgc7+c9eMEyielJzbwO6sw5MSKVCWvEK2SQsDAFifIDccHKT7JGU
 5XBjMvNOAE8FKovn4plD+pcBPOY8chHYDNKnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187322; x=1752792122;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3M7eI1w8ulExeq82A6lEYFFT3utrWxAH1KrDWwlA/bI=;
 b=YmOnYaQG9zmB09lZUcYS+2ADYrCFEMxKs3ffI5Y+fuM5dSJDs4ZtfWztvH9Uw39acU
 D3svGxopB6NhEzluMUu2e8dEqUDxsSu1FTI2qcONR4T4L2qI+wW2aQzGplT8gTATagNh
 b369rUv9hHdZZKGKmVSzrgQFbv2j/87/f9tmdFC/Xqt6b6krs4HKYKiOfaYm7w5AH5Y5
 QOcQYnhtlZsC9BYTT3OOEb6csfg1v5NMesZX0x9zuvWFWXSGA/rb7b5JT/K4ZdjhSorZ
 mcI/MOO/dPw1Ry1KAjFZzKHnSpREKLZrPKiNQRkpFHjKqwrPLamg+4de+bqmk7meUfzp
 QVPw==
X-Gm-Message-State: AOJu0YxWPOhVoqox89dUpT3j+kDO4gI/8qkbOKfvysPqE7OLUvVX2m1y
 54Nk6DVtWLBchmO49W/6at1FtiWSxM9KJWgCX9Pll33mYhIWxCbse/Vdy9BUZVkJmwGRhL7ISt5
 03oeRV/Q=
X-Gm-Gg: ASbGnctCTEkqaF/Tz7F9M0uH9WJe1StHQPwPjpQ+KcQT0szpTVE+wzaaVNw7D90wPb/
 vGDEx6eScBt4ykmzGvsNophuGXFdXuytK7dtet+8h25RaQghnmKjsDHnjyJ8E7K247QwNchcATi
 FYnCQSutXXXTQATffFIs9+BZn4rPvPlqex8iRnUTh7O8NaXqoT1Wl+SHGelOcgtc7rIQUUUhhnA
 ztzY/UiL4QXwblWtSpSvQ3D+QvsDfoZa36Rhj+tgQSIGKQLn1VuaBDybR/hRHNlkba9fGZbvhYR
 PkFxqripBcdZ6fGRLpk0z6LtkGAWBtHbIvXogVYgdHNDImmVjJriEQLioaQ3wnCzo7sECWS70JM
 0BLxDMCwIuPn5qQPEbpJzoc3rV3cWIAEgLqYgiOetxHFckfoTGSVOGXg=
X-Google-Smtp-Source: AGHT+IFQ0wIxAUYfrDCKvh4gTMjCGrsE4hIKVh5Ly+Y9M/Haynb1rMyCfJs+Xae0oXuZHpS4a/K4wQ==
X-Received: by 2002:a05:6808:e8c:b0:406:7769:d351 with SMTP id
 5614622812f47-415116183d1mr931827b6e.23.1752187322023; 
 Thu, 10 Jul 2025 15:42:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010422.18911-1-trini@konsulko.com>
References: <20250702010422.18911-1-trini@konsulko.com>
Subject: Re: [PATCH] crypto: aspeed: Tighten some dependencies for the
 aspeed platforms
Message-Id: <175218732118.2073260.950000049619486905.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 01 Jul 2025 19:04:22 -0600, Tom Rini wrote:

> Some of the aspeed platform drivers cannot build without platform
> specific headers being available. Express those requirements in Kconfig as
> well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] crypto: aspeed: Tighten some dependencies for the aspeed platforms
      commit: dbe1fa4d260fffd094d936c27d17bf4910bf2472
-- 
Tom


