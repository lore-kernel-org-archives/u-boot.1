Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5731EC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4405A82B1C;
	Tue, 15 Apr 2025 19:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EdBxqhj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EEE282B07; Tue, 15 Apr 2025 19:09:47 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BF18209C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60245c7309bso1414635eaf.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744736984; x=1745341784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r+AvGBrxtXkBEMh2bbgdWeh284sv5DQ++ua0QD1SGZg=;
 b=EdBxqhj73a4/i+nBWyy1H5FtjuvShseiiNJ72GstTXFY1H1vUJUN9hkNqlij89y/LZ
 dkbecAfIHrJHLZS0VlVrMk2N9c61IstwghZGkFItT5yR139lkEHlReXGNGiWpG9OXUtL
 D99lL078q8mLZyeWSHP4fAW4ztc7A00wt6amE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744736984; x=1745341784;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+AvGBrxtXkBEMh2bbgdWeh284sv5DQ++ua0QD1SGZg=;
 b=M7vFbXLx8Jb0KldtjNbabt2fdXxq482XF6ANF91R2GEPaUfuHIwlPQVC+2c78W70Ke
 rkAWtVxSlLr+x/ZO7DTEIMKlUF7GKY8mfbAzAquNIqQhQP31TsFhI0ZLpyD6a14GV3dI
 yX0790yapwKCANWVJO0KrO4kPpnLOAUPPSUn350LJZORSoHvrvU0LvmKHvTmif7znAV4
 lalpExRy2RoaKrTgqnD0EER4gKo3uwiNovnTcGTxqXDVpxBk1fAMPA8edFHwdcJF0Z8M
 s3u9NBsVQx8c1ZROvVsacpgus0QhCOXzmfajdqgACrEstDg2mWqYkPI+x1VKK1/8+Pfu
 yJ3w==
X-Gm-Message-State: AOJu0YxVQZtJ9d+i9eZoGElJiCShnRmM01aMJ08TIlBO8G++nrnGpzll
 o/wzOjftQacDyMlpokhotRiSbZKktHsU1zWYdN4nqDyx0PpsfZPMGmTh0Hthow3JbmXt0njZaRw
 9
X-Gm-Gg: ASbGnctnmsar0Pgu+BqXy45EKRZ/O69FF1Qzk37gC3YsEmh3A5iULRE7n/DyWiiiudI
 PGKqFNhKbytSmfa1FsoSKRUCsTFKwJeNRha12FfLh2hOyL1H3J0AAxMlQwUj1mbcHIEfDqFIlhP
 Pz5vC0cdSCum6ysl1ewUxkg6O/bNYNDfF6I5nOTV6HPiJFH9mSgOt/6j1ApnIz1HC2rwA9BWtOd
 ZLFtwtOaa2p0/XAezjUCIoXdSTaxH4f04WBfgXXpKHMVFhiQvFIpe2/U9tycDmCA6+7AI/niH3q
 mfDH0TdIfEgeTFG2gftnDYx5dlkuz/s6sIaH/HckE8vo/7iiCOZeLwiC09wXwZkISvBOnHyXng2
 1
X-Google-Smtp-Source: AGHT+IGl2HgHdnDTB7YOUa1FdMWknn+fNqYOs865ax2255f/oWyNlm8gybz8d9kOhElH0zxh4Xf9pQ==
X-Received: by 2002:a05:6820:1392:b0:5fe:9edb:eafe with SMTP id
 006d021491bc7-6046f59b8a9mr9778453eaf.5.1744736984070; 
 Tue, 15 Apr 2025 10:09:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f5bdbf0sm2474209eaf.40.2025.04.15.10.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 10:09:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250415111657.3265406-1-ilias.apalodimas@linaro.org>
References: <20250415111657.3265406-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-master-14042025
Message-Id: <174473698292.645182.3180925326124858647.b4-ty@konsulko.com>
Date: Tue, 15 Apr 2025 11:09:42 -0600
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

On Tue, 15 Apr 2025 14:16:57 +0300, Ilias Apalodimas wrote:

> A small fix for the CR50 which moves testing of hardware a few steps ahead.
> Simon tests still fail later down the road, but I don't have a hardware to debug
> it
> 
> The following changes since commit 739ad58dbee874a3ad3bddd116e995212a254e07:
> 
>   efi_loader: Moved the generated ESL file to objtree (2025-04-13 08:09:17 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


