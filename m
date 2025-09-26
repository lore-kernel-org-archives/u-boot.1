Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE4CCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858E583835;
	Fri, 26 Sep 2025 17:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEXlNRkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99ADD8383E; Fri, 26 Sep 2025 17:57:11 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B32F83817
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-890e5bb3100so79090939f.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758902228; x=1759507028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7gFSAYIa/DOBxnvhyVYeK2cY+Bhe27VbXTLGWei00I=;
 b=eEXlNRkXaPzcPV9R4u0sdDovLo9KJNJdUc0P2PjZQwPT3CUOJiIw1I9sBnr3FEpIjc
 Snd78+jLTttt23iouCKkrM/ybhu78UCBGFLMvyxmgGJE72TMWHAYHTnX8yd4JUGm+265
 PlHOJcRni98s4drRzhLL0EzGCreYQAv6w+hs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902228; x=1759507028;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7gFSAYIa/DOBxnvhyVYeK2cY+Bhe27VbXTLGWei00I=;
 b=i9FJpFykJQidk+EdzCztTfv1gmYAkSf2FrBVxDWzJnNcg1MEUfhI0LW3I5kqzqbqsB
 B6dio3nQwMWyzu5bPJOLzY/oRaxcu9HTf4bs37GcoVrFf3OyzcKJ/ULeijx9RGeR7yl+
 GdkWTEy9pH5Sw+N0JNj3dTPCsVhGS1oBQvsq45ELpVgJptBCuZzYsTR1q7ZIAHY5Tasz
 pZSeFHOH9cScA9vA6WzPoPZsq25/WQWeE1edOB56BW0VLmg4yGdwFPXYFqvOaZMd0NVW
 uC9FuOgYFT+IkFER31grvF/7AL+Xy+5BGvxsN5Z8P/WG841+0lzU+qJq10LrJZlD6P3m
 VMkw==
X-Gm-Message-State: AOJu0Yxg0x6e/5Mq5YfaSGlPwnUEgnrjlng1nL4GVUagC3g8UFB8yvn8
 sR3kh0mk5MYk+OPb4CU7U41jX2xwIKYBNBnwrFfhB9/D5Gf2RDSAygRFsGNK39OD9MFEjQZMszI
 7xYQmISU=
X-Gm-Gg: ASbGncv1g8+wKQzFFYeDVFA3IaYGX/GunxCSFnrqBIc1BFhwsIKuBylVqacpF0TdxxA
 H4PTDkVgnMSPfNc0tO2115bSymxRCSVJndAsEDDsBPyjN/Wzl5er2GCL1lAjFbAp9bXwVFmoH9D
 UVhLLSWGX4G/SOlw49VPcL8jp4s4QWQhjR5qN5kymGLHrDHZQDb8MH+zQCFSqtG0jllJC7qOK8g
 N12asKvlhWITQeJ1JRmo8aqr64b8HdgybXNDDyOmEh9NSUhKBK4HwE5jBkuX9NVFEqJ65S8zD5S
 UxZFbE9c4yWHe+IQZ2otE+JQ34ymEJR0c92C1eXG88tjwNKXQQubWYjmuYH/wDMtbxtLhCp9bki
 cUw5xOs7FmjJI/VZfaESJE3dEsvdW2it27bV4Jf29p3R2CFQ79hHa748=
X-Google-Smtp-Source: AGHT+IHOuoohpen5LU+SCDWRDNjcg1qRfk81xaUF22bf8nU27AsxT9b1+hTD1PsjUDWk1LYpirv9aQ==
X-Received: by 2002:a05:6e02:190f:b0:426:c373:25f5 with SMTP id
 e9e14a558f8ab-426c3732b02mr69791755ab.17.1758902228130; 
 Fri, 26 Sep 2025 08:57:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23502615ab.34.2025.09.26.08.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:57:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mathieu Othacehe <othacehe@gnu.org>
In-Reply-To: <20250925224019.181523-1-marek.vasut+renesas@mailbox.org>
References: <20250925224019.181523-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <175890222692.3683518.7177225934892352329.b4-ty@konsulko.com>
Date: Fri, 26 Sep 2025 09:57:06 -0600
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

On Fri, 26 Sep 2025 00:39:16 +0200, Marek Vasut wrote:

> RZG2 boot failure fix for boot with TFA which does not pass DT,
> and R-Car Gen4 PCIe controller driver alignment with Linux fixes.
> 
> The following changes since commit f53fe908ac3dd44f7ad63dff319636541710b98c:
> 
>   Merge patch series "Fix boot w/ scriptaddr & minor newline issue" (2025-09-24 07:50:13 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


