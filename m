Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB0C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE4880FC8;
	Fri, 21 Feb 2025 18:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uuInliY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5032D80FA4; Fri, 21 Feb 2025 18:38:17 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B7E80F67
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220e83d65e5so47649085ad.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159494; x=1740764294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp6GuEhJl6vGWsRf4rTWNggvLsUclDVIGvUL3SDyfGE=;
 b=uuInliY1JhprMgfU+AZ723xGWTcMwVidgV8erkna8kZOwulaMfAeEQIKflxyldure6
 V7p7Pk60rnyxMUO4WdRI8JRexc2jX9Lbd5/SRjWbZxxI8U+KdFt0nkgGze9h5Ok44q6n
 S7M5/ICuVgu0yV+nRLumLBecGJJZUnBd4XsIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159494; x=1740764294;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp6GuEhJl6vGWsRf4rTWNggvLsUclDVIGvUL3SDyfGE=;
 b=AccHAAus7fSAFKWPd6/Cm9XBrGgIxYAuXv6yOyh+W2OjUMg6IPjxPixJUDd3nNgM71
 QI/m1rMIHtMugjfgNb8fKa8mlxFGMF1PiWeyIn65AalqgdqzKhu5tiSrakrzJmbdVOT6
 zmHHAJlUMFR2kH7j3P5JI6n3r4iuEKSjqY0GwxX9gNLBZzMtEKoFaa+1iw8UFyFKhxKJ
 sgM6VAHU2E5qRLDQwML4isxT3V/d9aFgftfiO8CipOLY4b5/o3CI8hdJFyL9TS6ms7ye
 i+9COmNtf1MCv3rPw3XkgzSTQmlmeGBeROSf3twE9hPnMK6tPukUJmx2BwiCJJr9dp8d
 dW1A==
X-Gm-Message-State: AOJu0Yzd+/z59t1O1dqrCd7pCW+6PcNNqtffr6vh454JzIsinVlNl8Ip
 k635cvt1aOv5p61zCzk3OoUPJY9Shz9H75zRvtuPmfq5p+C/mMml9W2RLjf1Nfwezo0v8qnl5N3
 Qh8I=
X-Gm-Gg: ASbGnctediLtAhFj1v9ZBmDcncdS7o3gUieuk4wQezeyzL/D0HehHpguBFxXlNYKiUX
 QMDHn70lLLt31bQa0kyZV7QMrggkDn39wLsZs4jxilGluNrDNsjTEUkkqnLIwLzwvyWAIECbNnc
 nt1PMqnCaO0mfM5Pa9wnyvbayRrWdgPNWVvehS904L9BEt23TTN6PIRnQDOtodcdJWDc1gO8GSD
 Mw9IzprybsZzpAX+mOyNq3vYTovWQTX8AIX+Y4wu5WK0s0aLEsAXgglQMrT6DfvxdX1x6i8F5pq
 AQOgQXaMKcnUHKPypWWXe0E=
X-Google-Smtp-Source: AGHT+IG1lqdMfJ4mZ9IypfSyD9TfyeFQX8ocDREz2fKizbvoPymDbRQfIRTOPx4OC0AgJEHQLQI44g==
X-Received: by 2002:a05:6a21:99a1:b0:1ee:cb3b:3a59 with SMTP id
 adf61e73a8af0-1eef3d8d310mr7222850637.26.1740159492235; 
 Fri, 21 Feb 2025 09:38:12 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250212222346.684498-1-trini@konsulko.com>
References: <20250212222346.684498-1-trini@konsulko.com>
Subject: Re: [PATCH] dtoc: Switch to setuptools
Message-Id: <174015949139.3526942.12525955480705364550.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:11 -0600
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

On Wed, 12 Feb 2025 16:23:46 -0600, Tom Rini wrote:

> With the distutils module having been removed with Python 3.12, switch
> to using setuptools instead.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


