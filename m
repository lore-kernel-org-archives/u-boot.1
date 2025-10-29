Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C25CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 18:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5474A800B6;
	Wed, 29 Oct 2025 19:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p7DmKA9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF103832AD; Wed, 29 Oct 2025 19:08:03 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1968C8144A
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 19:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c3e2221217so50100a34.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761761280; x=1762366080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Y7eATklmNZ5W4PzD7Jp0xgcwaXI8Wyo7cn8xwT/sOU=;
 b=p7DmKA9gyKVkqyaE1ct6MUPF8Zg7dJBIEvKPzICed4+QCKEj6lGixItSdTUt6MOdE8
 htAH+SMJa+gJSeNDLwfjkaljQuhIoLfcEiQG0fp1uj+OsYBtmQe7fv5IgKr2s/8sUMAE
 nqZH5DKTp/dqtu7bYBEEQhxyofcb2NCQ4lclk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761761280; x=1762366080;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Y7eATklmNZ5W4PzD7Jp0xgcwaXI8Wyo7cn8xwT/sOU=;
 b=JFmIZ8h1qAmqRoeCehAm6BI60sDWqscyfofOztGRmu+uXmsoEStkKnGBnh8lPjIIkG
 D9vtWnz47I8SZaTR7GefwiHPWFiyxBkEGMIvmtBESjJuBU6pKZbtqHkhXu3jCDZujOal
 sVZzx+OPUceDAf1+37/2PTP/tKY1iNmQdN/O+rR/n2G0TeGm67qJBSrkH49+jF/o0pk1
 SFBR+S/EQiuFm7MECoWVYgGV0axrfevJfCeHd3CiSYrv4Hg8xRqyE0W/GvAAaeBAjQXX
 iUXqPbnS5Juz1/7Ok0BGOfFRfm5L03nfUegpu/oRnxATxq1j+uddDB79d4iChz2w7h5s
 MBzw==
X-Gm-Message-State: AOJu0YwEr0/9s7YSPpFJyh6voz1TfDbrpuP57VH3I/pVfIoWiZEfy6ZT
 sqeEfCIvxlXau2hlXkwuSZPKjpetl8nL+FUzx9Jhha0CJIqQCLZLVMwIB3TgrdcQtTyr7vC5ocW
 yIGKdNfULkg==
X-Gm-Gg: ASbGncv9I3prTz/LnmXUh/sgDg1Esn+CPmdeYstbIdqBbQAz3YtzVEdRHm1qCcXZb62
 F1SiSPpPAuq82fBkRXPAmO3C63iPzc3O4ejhhsndUMaHoMhE0GcdDBIQdreWQedQIDfYclfQzu/
 rvP9xz8reZdnq6ktcUBkeBQXHhmenmsfxJqzUfaEsQH5dV379bartatwrv1drZN8AFgkTy+BEoy
 VPZP2BdI9/pjbATKEV56eBIHLxAq/gRZNCQyI92fJ4GxWtsP24rcmJKY2+JIHh9F4za+vzL4QSt
 APb/pxO2aCjSodsD+LPL5N6kCJaE8jVD4yqbd0fTMRMxSrTd/tpKdDpuukSUG+16qnXwnYfoZ4p
 v9FMkydznaUD/TZLv28qjmu0r7r99uIyv5ao94kSHPxY4x6D8oMN11g42iDhbKzQxJAlZwb8F/s
 ywZUiYONCiAld/sSMIcZVi1ca0Ldk3vRt+ongAfA==
X-Google-Smtp-Source: AGHT+IHTMwOhgT/iieQfDx5wmcE+2enI8+I3DPiI8yMSitk6oAPjxmNIA/3nqQjHXG5BSi1GRvjR7Q==
X-Received: by 2002:a05:6808:3999:b0:44f:6a19:433e with SMTP id
 5614622812f47-44f7a44a203mr1903992b6e.15.1761761279859; 
 Wed, 29 Oct 2025 11:07:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e93e0esm3555356b6e.17.2025.10.29.11.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 11:07:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251029013114.113745-1-marek.vasut+usb@mailbox.org>
References: <20251029013114.113745-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <176176127880.2497692.5700163200347579279.b4-ty@konsulko.com>
Date: Wed, 29 Oct 2025 12:07:58 -0600
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

On Wed, 29 Oct 2025 02:30:47 +0100, Marek Vasut wrote:

> The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:
> 
>   Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


