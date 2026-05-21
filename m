Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89693CD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 17:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0D41846FA;
	Thu, 21 May 2026 19:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QWuRd1/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FDD184825; Thu, 21 May 2026 19:42:13 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E51846DE
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 19:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7de4be15125so6498730a34.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779385330; x=1779990130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9NeJ/eU3VcEIQM6u9Au1CwFSw5JkemjYjxOChhEJ9w=;
 b=QWuRd1/+AOf23655xdt1cGoMMC3s90twchbrOKWn21/ER1bWerDo8puc7djh1GQRKm
 NLPX12iQpjbofJ4xojcaD2CYsZQ59HLOyPfycrLCP1Lpmxe2fyCMemWhQn6WPPe+ZpK4
 2buBooKoa43MEEsKDW0bcKkc0B37ylgdnV9O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779385330; x=1779990130;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9NeJ/eU3VcEIQM6u9Au1CwFSw5JkemjYjxOChhEJ9w=;
 b=FHm0SOnfq5cfIVAO8F5DkVZiRNC053tICpSEY4PYKCOI6fGHkJEUIVfUV9hGt1ANEc
 5tlAnpwyqqmacofYo4YqtILICd7I5F5P/d9O1UvoJjOa7OM64NjOw3f4ZelT5zjrDqaF
 xb5wcIpZcdcOcCjPO3S5MpGZRgZ/UdhxRQw6NHQQdhJZAkun9mFxcoeeKdw+gy8MFuJt
 aSm7S5qGiCZIHH9c6QRZ6Ips8yBonHUXk/54nW7E9YGN/MOFeDdXbfQtR+b2KTlRO1e8
 JaobwYhCBS74no+9mkwZHNKtGXD0/IICs8K/E5JVjb2WbUi2PbLTJo1GAXTZtlsElWTy
 h18A==
X-Gm-Message-State: AOJu0Yxa44coK4hJfe2fjsRVZlO6BP97VpWC2h6UShwK5fXaMaM+G9Yi
 iDyZNUK14cs1pjKtkKG5etHpz9NYnHaKwv/autG66nwBFWSE/OlBzlM62cd39B+Lrow=
X-Gm-Gg: Acq92OFQkfavH6Uf/oH94PBwkgtN0MfbPCTtErGnIhx8dFMdPabrq46k7txex78rb6m
 qyKEDQy7lMG4n3xIRN6RPp8CDb5vOu5DvlLiTr6Zc+AP2KGXgpV6QKBTjj+ghuoMJMDSUrsPRSq
 L7XWc9x7C0pLxsg4MvYBPXcX2VMzV+aXg5A/XzvtaPsqH9q2mNnP9J39q8IDbcF5YHsVq5tQpO5
 EEqwh3Hd5PCKJV+i4rUsql4n6VW+ujmTAg+W156BKOAfqFGdkiJEN+ThO511u0vVfIpFJ6j/ix7
 b7QX079k+P/L/hKgaqkSxBce6FPczILTt4ZPqFRhMDQ8DndPGfuUUfzK7azazziHIm7x2T7XRNk
 weCu8jLS0Vh2L/dpuhYVcL3BXwiBHSb/OSZvDtTT5yIuU62b3nbSMEPMcnsCOrAagw9uTF2WVSy
 XY/j4CW9YRet2acdk2PUqQVtwlmQCPlpkjc2jlde9yHzG6OTvGcBU7Zi2wW1iUkcMC2HFN7KRyB
 68WGyQ1KGfGavX7MjSASeE+biHWjYnOp8PHYFbCdp90fe0PRhA5Et0=
X-Received: by 2002:a05:6830:498d:b0:7e4:411:7ad with SMTP id
 46e09a7af769-7e5fef39070mr62309a34.24.1779385330118; 
 Thu, 21 May 2026 10:42:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6e714cesm872525a34.14.2026.05.21.10.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 10:42:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <764624ba-30c0-46fa-a6c3-4f2cf4b17bd5@linaro.org>
References: <764624ba-30c0-46fa-a6c3-4f2cf4b17bd5@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-nvme-fixes-20260521
Message-Id: <177938532927.2085599.16018019974023105488.b4-ty@konsulko.com>
Date: Thu, 21 May 2026 11:42:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 21 May 2026 16:02:47 +0200, Neil Armstrong wrote:

> This my first NVMe fixes PR, including a couple core fixes and a fix for
> the apple NVMe driver.
> 
> Thanks,
> Neil
> 
> The following changes since commit 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


