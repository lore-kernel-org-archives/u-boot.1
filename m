Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D0DC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 21:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F8B82E28;
	Sat, 24 May 2025 23:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="Ms49zi7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F78282E28; Sat, 24 May 2025 21:16:56 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA01A82B3D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 21:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=drew@pdp7.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso751441b3a.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 12:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1748114212; x=1748719012;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RdNhoASJecgahYk3Ab4FondD092cdDkqPMjnZvan/9w=;
 b=Ms49zi7farhBybF4mb0qBiz2U+HoxNYdoDZT0m1JuhJb803UQMIN1RQIL4P0YTsCs6
 aLOJcjppU1rcVnu+K/AdBagym+VXTtaCrfOf4+cLwR6j66v4qPT8+MRmfxQA1JhiXveR
 enAJEpt+63IVUlenjfGnxmKkoxVWZhiDLhHzwmiZ5IMDEm5bbQAc9TYxaUqwQWPtMy4n
 d0QMw3zn8v+sdSGFYZtd5E9g+iYEuWAmbROefs6xe+N88Cuav/TEFs8T1Epd4CKExK7K
 E5NqwmKDmwPGx7oJA+o2LmlO1qxvJTK5AZfWZT7mAX25s7YaGyy9lWXUr3aG8GzpjGxZ
 XWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748114212; x=1748719012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdNhoASJecgahYk3Ab4FondD092cdDkqPMjnZvan/9w=;
 b=Cog9a/kRSfDg0y64kCQjAyP2iJMrW9rvGpFILzUhg0/zJsajZPK5aQZSmRMXuzi6lz
 99nx7oOgULPpjsEy6LmyDimUMr6xhxvv21XbJwxYPx0ktJcn2EX5vCZMD4EkGflHk0sP
 KG263osus2F8+hpjYJvKJsLcfrseCzDeQQxNeW7Ce6t4YcgrqfxSCCYQeB/Bsrs/OSt8
 c5d1o0Acqyew27F6fSFr/MSECdmlQvSdqsQga/KLIYPFWgWMmNSSh6p1nnLyQlSb5GYg
 Zozd4nSppXXbw4cHLpA47TW76pfvWU1ieM8vtqBIYmAPczEKGP6j0/iArUq6py0k7oYz
 +kBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwTE10ZTPWCjhfJkxhphDzRzeUYY6DGdfZ2kskqo36QearJipZuoFn5fMThxsMWmpbn27LVek=@lists.denx.de
X-Gm-Message-State: AOJu0YzUtkKBhxHH+0H/u06fRutIq4gvqlaRVu7LX1wWRJC9qyNECQJN
 2Y8viEZJ5G0Rkyg06Xxq4UWbhbQ0VWqICHsYX63Rxha6DRrB1/zB6xHUryaEddr/acw=
X-Gm-Gg: ASbGncu+mz6SEuDRGb9DyhpCFIIdj3/4BSrmSg0/FJCcVLBgOYg5ahKHrvHjqGyGNMR
 nka734kbKvLUBBCgH0vJDckchnr7OCjiZdcAVLFYtySZhC7JF/qxar0n6lycj8jkNXXj/KMMZN+
 Cgq90sWoqM0mWmyA36piBrwaiIMe7Z3JRztNPRU84h0b1znEVMxIGusUCq0Qzaa7tqI6EfVEzex
 RYyIayvmHrlhNErNwz2231P8YvyXvgkRTrk4QOPmiSKYYNPn178supVvIy+/xPTLJ+wfiVs8JfP
 XCyhzQXLtrFgCZleULyFc1dGeGxgBZO0+He1Scu9K/ez2HRjtcdVFBU/gfIa/64=
X-Google-Smtp-Source: AGHT+IFSmmhz+SN9PwdPghNwpNAfB/dZ2yKUfExNa9xd/pIaL+DdSjJrrQ0xTEpyazjWINLEesJPvQ==
X-Received: by 2002:a05:6a00:3c83:b0:73e:1e24:5a4e with SMTP id
 d2e1a72fcca58-745fe03d5c5mr6764024b3a.24.1748114212040; 
 Sat, 24 May 2025 12:16:52 -0700 (PDT)
Received: from x1 (97-120-251-212.ptld.qwest.net. [97.120.251.212])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b86esm14511036b3a.115.2025.05.24.12.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 12:16:51 -0700 (PDT)
Date: Sat, 24 May 2025 12:16:49 -0700
From: Drew Fustini <drew@pdp7.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, u-boot@lists.denx.de,
 Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 04/10] ram: thead: Add initial DDR controller support for
 TH1520
Message-ID: <aDIbIRcPQpcVU95p@x1>
References: <20250426165704.35523-1-ziyao@disroot.org>
 <20250426165704.35523-5-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426165704.35523-5-ziyao@disroot.org>
X-Mailman-Approved-At: Sat, 24 May 2025 23:59:02 +0200
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

On Sat, Apr 26, 2025 at 04:56:58PM +0000, Yao Zi wrote:
> This patch cleans the vendor code of DDR initialization up, converts the
> driver to fit in DM framework and use a firmware[1] packaged by binman to
> ship PHY configuration.
> 
> Currently the driver is only capable of initializing the controller to
> work with dual-rank 3733MHz LPDDR4, which is shipped by 16GiB variants
> of LicheePi 4A boards and I could test with. Support for other
> configurations could be easily added later.

Thank you for this patch series. I only have the 8GB LPi4a. Do you have
any suggestions for how I can get that working?

Here is existing output at boot:

-----------------------------------------------
U-Boot SPL 2020.01-g55b713fa (Jan 12 2024 - 02:17:34 +0000)
FM[1] lpddr4x dualrank freq=3733 64bit dbi_off=n sdram init
ddr initialized, jump to uboot
it worksimage has no header

U-Boot 2020.01-g55b713fa (Jan 12 2024 - 02:17:34 +0000)

CPU:   rv64imafdcvsu
Model: T-HEAD c910 light
DRAM:  8 GiB
-----------------------------------------------

Thanks,
Drew
