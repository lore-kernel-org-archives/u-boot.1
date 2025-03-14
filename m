Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444A0C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 17:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A735F81760;
	Fri, 14 Mar 2025 18:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozMVSWjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB9281ED8; Fri, 14 Mar 2025 18:56:44 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89F68001F
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c54a9d3fcaso236014385a.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741975001; x=1742579801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qF7TFEBdxhOGBLBoFBazU20BPrpISosC/CSLz2vc8g=;
 b=ozMVSWjDvv5QnkvmelnSvG4LL2hjAs+/fIBHmDT6Obx5S3NsXRmoNZSwJyswKGRS06
 47JKZotxQpA4jd5wSJAJOSulh84gWtLZxQfIervzeGKxVwBeRraVu63PHu8Ou7p7tS8B
 9L4grxk8uiAQjw18/pmEFA9SYEXnK9GnxELVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741975001; x=1742579801;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qF7TFEBdxhOGBLBoFBazU20BPrpISosC/CSLz2vc8g=;
 b=lchkwXi0EdKP7xfXHoqVrJf1UOCJtRILTvMy53m1+f98sFCPmnKCjnN/R6AGosgSwr
 GHuw/BXZnCJdG7KUQE1jo6RUCUurQiv5Hfu6I3hOM4Mb46BmKqc2B++rFIsDMykpgEr5
 J4l0nseWejCM60GxfqSTIkFrFQj87Dv4Kd79VPhj0NOtbZsRSiPNuo252DmgGNp6JjYZ
 Ipw3Yoz+poyJsdRlJ+QB13+CV5KueYIT+d1gF6mqlIwKJTaAZP/Dl5Nc7UGwQXPCYxLS
 x6kzafxEI1mDw8fCTQcLQyBQx/qD0bZUqLn72bA4ZUKMsrZIiM49bKptIn03lip59PQ4
 b+NA==
X-Gm-Message-State: AOJu0YxdDkdk1fTYXReTq3/HOSWBHP1IZZ5Eag4AqhGugrv+3fPEMXBf
 3re3HApqanBcbcO2gh+ROlLIYHazg08/GQrGymZG2/mRc2rMj/pUToOFEiZW8SM1m0OaS8njMx1
 2
X-Gm-Gg: ASbGncsuYYXMyMx269a176XiG+CnC+uHpWbND+lHQ7iFxtHDVAoK+Ma+M3cg0Ca/48j
 K8ZsxF9BiLzQtP3+aGRNsFGlED4jukS5jzs1+fyzPMbdCXQf93KV7rFKxzIwNhWToY6H+TQdJUd
 xSlcultLx9rLcdT9CAgX5Qp1DyGMrlALGlWjfAwhzEkCn4XsXcq4xjC3aBZozxhtlLckuW0F050
 Hu5/7pVvbFMRbV3L3FZegqAsqvtgWTkvt/v2SIfb8+H20F2TW5WAOtxFpblo65usdhtPic6sisS
 m9nWEMGpNJdGCho0no5qZukKEmHMnBseqGrsbdnkdG5h
X-Google-Smtp-Source: AGHT+IHVdyqnK1dx64Xv3BDcqe+3nZ0/KO5I33HNIyY8s2q2KoKnGZ7mcn11wefUk6PCrO+1nYDfXw==
X-Received: by 2002:a05:620a:4092:b0:7c5:588a:5c1e with SMTP id
 af79cd13be357-7c57c810c7fmr479263385a.30.1741975000792; 
 Fri, 14 Mar 2025 10:56:40 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c9e0c7sm282196885a.58.2025.03.14.10.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:56:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: andre.przywara@arm.com, richard.henderson@linaro.org
In-Reply-To: <20250314140726.294800-1-ilias.apalodimas@linaro.org>
References: <20250314140726.294800-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for mmu-next-14032025
Message-Id: <174197499864.3210237.9567052878081129604.b4-ty@konsulko.com>
Date: Fri, 14 Mar 2025 11:56:38 -0600
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

On Fri, 14 Mar 2025 16:07:26 +0200, Ilias Apalodimas wrote:

> The following changes since commit 9805321dfdeb5225fe5c5e0721abf49c0875637e:
> 
>   Kconfig: Introduce CONFIG_WERROR (2025-03-13 14:23:11 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/mmu-next-14032025
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


