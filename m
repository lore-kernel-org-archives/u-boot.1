Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A05FCDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DFEF86D6E;
	Fri, 13 Oct 2023 14:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vbwa80Ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B219886D62; Fri, 13 Oct 2023 14:42:34 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BB686D6E
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 14:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53db3811d8fso4188522a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697200950; x=1697805750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDJ13R1je0HENZe6vXPB+8Qhi4hks9wWOmcVyincP08=;
 b=Vbwa80MsyfIMJgO5bNA5QfS3Q7HksgrBKvRPI5mbyGPb+K9RDChnyyofNePfRV7AsP
 fwfpcVMr2xO9XWoGv80VZM32p9vmrj7gX3lIPYnQkXSpQys0Ya22Cevg2Sra4yQM8wZl
 Gykz0rtZOj0UFGkFiQx3dKiikv8y41qDXACDVD92CSVQjOpP2ZapZgtqhxMmteb2K/PB
 MErRrj5l1iXORdW0EeGF48FBIDt9N6aweYNnL14xxL7Leo1lPs189VUIqRl8DiRhHjza
 ITEF3Th4eM4m0DNUNas3/TBnrHdzvb2xKbbe+yFmrHwIme2HZmKSPk7KjTduahBkMFKf
 rSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697200950; x=1697805750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDJ13R1je0HENZe6vXPB+8Qhi4hks9wWOmcVyincP08=;
 b=oaug1p/WMJwPm6jQUyqtuj0iScgCxHfaisndJpg0o+/aXsZpsanSgPAjeFL/kzi+Or
 92z34ki6JSfTwyF6nEXXG5T7O/dGdLMJiy14z240ro0sFp+5rXYWC0UzvIbSD0hvMmXA
 z+fIM3gyHyJ7FwhGso0aDC/TRMhS3sT3FhN0NB7i6JIsLApzCbANGqzP5LdhXVAdE9W6
 w971c2vaq4AwuB1w75dHeRiUYyzdjIvvLe/mQRhGoxMz2BQCRoBsSHY5lnzMPDOkL+a0
 3y9NgQVcl1mp+Yc/35TNFIs4PtRQXYxt9VJTi6+F3AEBfqbVFcRKX8AtIHWW6A0yXRi/
 jZZA==
X-Gm-Message-State: AOJu0YyRaUq6zWV/7WQkB9zVyheL8nDb/lTI5SVyXc0PaRTWQF43SYgi
 pgXsJbd+Y6dLpaKgv8Mdypk=
X-Google-Smtp-Source: AGHT+IFun4mBYdwqfm0CfXzhdORBZO9/zMonOccR5F5UVn4vnUKBPXxE+kzL7nWto0x1IifsbHLAUA==
X-Received: by 2002:aa7:d44d:0:b0:523:2e23:a0bf with SMTP id
 q13-20020aa7d44d000000b005232e23a0bfmr23804905edr.11.1697200950631; 
 Fri, 13 Oct 2023 05:42:30 -0700 (PDT)
Received: from localhost
 (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 ck12-20020a0564021c0c00b0053e0f63ce33sm2040916edb.95.2023.10.13.05.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 05:42:29 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] tegra_mmc: get tap and trim from dts
Date: Fri, 13 Oct 2023 14:42:27 +0200
Message-ID: <169720063882.3883235.2293016511612001274.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824185332.50176-1-clamor95@gmail.com>
References: <20230824185332.50176-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Thierry Reding <treding@nvidia.com>


On Thu, 24 Aug 2023 21:53:30 +0300, Svyatoslav Ryhel wrote:
> Default-tap and default-trim values are used for eMMC setup
> mostly on T114+ devices. As for now, those values are hardcoded
> for T210 and ignored for all other Tegra generations. Fix this
> by passing tap and trim values from dts.
> 

Applied, thanks!

[1/2] ARM: tegra210: set default-tap and default-trim values in sdhci nodes
      (no commit info)
[2/2] mmc: tegra: get default-tap and default-trim from device tree
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
