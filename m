Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34070D0E6D8
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B8D8404D;
	Tue, 25 Nov 2025 14:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U1bmWKdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E677E8404A; Tue, 25 Nov 2025 14:02:36 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5CD8404A
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dG2sZ6HcNz9twS;
 Tue, 25 Nov 2025 14:02:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIC8DLPv57s4VsPQkSWi2jGUtNWdzX7ovbzTL4thl8A=;
 b=U1bmWKdjI1+XQlhvyF9lzk0Uhci9FilzOQVclVQSgUo2Qz0ynYPJqY6LTAVXZnjOcXeTJm
 fYgPdTWYJgGzmgtg8auEmdrEIQ0uKCINmZQkUeu4W5K5kWigDR/TEiN5iGJdVjdhK/hrIT
 GgsDcQQb4PxlhWr3DrilfEv9NuK5MawqYyvwZkES4mHkIuWat4qFESLt0PgVmBHfKNjlCN
 Zt+H49XNael0oR3b1YZvA4HLtqbqt8Mt7sZ5AFquvNalN1Ght4cR1mBik2WVKyFmne0rgf
 c3gSI4GRCL1CDrxTkU5TAhb9JgJFPr5oKJqaCLhKr0ZkIRslghFUDrD6xos4Aw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bb6bf23b-c036-4d6e-b55b-02b55b37e740@mailbox.org>
Date: Tue, 25 Nov 2025 13:16:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <28ff4f1c094e15ef1f301bcbf409ef628c9cca91.1763140421.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <28ff4f1c094e15ef1f301bcbf409ef628c9cca91.1763140421.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: spfm4pn7j43w9z6sqwqtownqq6eih756
X-MBO-RS-ID: 25fb9f0a32694e80f9d
X-Rspamd-Queue-Id: 4dG2sZ6HcNz9twS
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

On 11/14/25 6:13 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This function and the sector parameter evolved over the time. By now,
> sector is influenced by spl_mmc_get_uboot_raw_sector which allows to
> adjust the read sector with an offset that U-Boot proper may have inside
> the partition. That used to work by chance if both
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR and
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION were enabled. Since
> 2a00d73d081a they are a choice, and we need to drop the condition to
> maintain this feature.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   common/spl/spl_mmc.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index d8ce3a84614..467114f8d9a 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -136,11 +136,7 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>   		return ret;
>   	}
>   
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>   	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
> -#else
> -	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
> -#endif

Could it be, that what you need are two Kconfig options -- one sector 
offset for raw mode (default to 0) and one sector offset for partition 
(default to 0) ?
