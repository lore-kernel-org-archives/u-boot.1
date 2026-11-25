Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8355606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uuGvnzMh;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MOEt1TdM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 842896064E;
	Wed, 25 Nov 2026 11:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OiMeH6x7mwlH; Wed, 25 Nov 2026 11:44:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAA7460687
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795607058;
	b=fZ1CxGfrG/Wk+hn+T+6dOYH43zJi9ZQLYxodTPGUlfQbKGySssMQyRdYh22MKMPerdkr
	 PkucuF2yOz9ivQ98Nw8GpkTeeTD5mTJo+q6E1jlBPLoJ+TV849AkWWwqJEvQUIUKhwTh0
	 SGtYyiXJEXTccnBd92oC7009RW9A6P3IhU0XPZrq3iJiaAr5P9UKraOnjM0MISl0n+ilT
	 Je7QslcRwNrZYBSKQ5OeawIj52Oz422Txl1jwxavWi6erEai2uUDC9sGAKPBA6w/rUiL6
	 RKa/D7Q3flOl/zNk6XGoRUDn5arRRLSEueTMsRvY7IfXV67JIOsfvBf11Lqt2wv+PJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795607058;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zq2x25je+Fr7FcY12Sny/JIqd9UwIzd/SpSWk8woSiE=;
	b=VK2I3WhBVjAASUSBle72FFd9ATSn+N+pAbaO6xM2b3NPJWNQ6BqRU3gH7N8tHs20+IJG
	 QETJUltlP5UNyHbFe2hnMr7vA2/AQAiXwBBgwW0mbmIlaAaA6YntuhzHjCVg/+yhGhWSk
	 oMqbhPySdlgPWHR8cVEokLLpbp+wBSdPJp5PM9EIhFiRrZK/eeqfWXBLXSnbOEqDSXIw8
	 uvprFSdtNM00xs3OtTzpDIeytAv5XUenq7Ad231wnmzi05z7N1E3L0MQAx7D1sh62UMJX
	 ZggDKjqgqZw1kTxEbH6TbpUR+fdlbkgSGZs92SZQBr6SCqSF7NycFLKFk1VGyGLvteg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795607058;
	bh=zq2x25je+Fr7FcY12Sny/JIqd9UwIzd/SpSWk8woSiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uuGvnzMhmpW4+7pxmQfOkynpdNSiSs4XEoLo8QaIvs18v0Hm+OArwoq1FNlfMfp3t
	 LvgEHy/iP25TIp3evORmuk0nclBgHVhNyZoC7HqiGg/QRROXbq0atrevazdfLR6l32
	 hLKR3vKABVSAPIyPUih2i10sj5Yd8f6N4XwBBLdnyCD6Tm4UKt5vswsabceHGlqp8V
	 EWOhCea2Zb35SkDSXBG/GQPyR3x+CUiL9BhFrWfXzdF/oFAcDoBfdmoIT01uxk6/nb
	 z4cIuK2IuHs/si8I67hyeBbVmkyIyQsG7I+UsQnMdGR+FE/dyn2ISOl1Gs/32xF7o8
	 GTrp/WVCXt4fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAA7460687;
	Wed, 25 Nov 2026 11:44:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3604A26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27002406A4
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qShik5mcoh7X for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:44:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 044084065B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MOEt1TdM
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 044084065B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:44:14 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so50392745e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795607053; x=1796211853;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zq2x25je+Fr7FcY12Sny/JIqd9UwIzd/SpSWk8woSiE=;
 b=MOEt1TdMlNEIKUI9R1ipj//WphdWTQqBnNrvqT02fIjti04BVBgC4pyeOZrlATa06T
 vnSubzfvy+eq4sVrUN3YlujpzcYVEhvX7ayh90fvJOm6DH1ZPwvPuIG5xAWapR0Tcc8M
 1E0PfGzkbE9cfpW0da61sOA0NumVxltQfkgiVMM+1ZUBwaXKhBXYx2F9BeoBvolLuQoG
 YplzLeAE+Vh0WB7dAoo1wz5foygB2ZNMSa/XE58ZWTdA32ynMgXSw5oGLm5PybdX3ITY
 wKdDHIT/k/xqvoYQOrWDHQeyvkxB188RcDBp10v6JK5IqM7kFga7zZ/9w5cvxe3Tbt5O
 Xlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795607053; x=1796211853;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zq2x25je+Fr7FcY12Sny/JIqd9UwIzd/SpSWk8woSiE=;
 b=GPM/oGWE6rmhPtYV9p3X+1uPbxgkctOEDSYacLRZ61vF6kXc6xKK7L0L8cAaJLgDcw
 MVxFmfDOPmwSCCC6QRIycJqszySaw5/pYRO4z295ioF881R/6RfxcYMV48q4UdQAlyEA
 RrDd39Hacd4WsNC2asqhTz7e4IJEQy8n9WUsBt+A7cgFmlKidVj97ludwzmzFKEE5lgO
 5OaY10ji1vfMWNLwCKxP2U/mxcyF3CBO0W1GQgEJUGJwa9h3RsBlGzsO4GwACa2zz4ej
 uLx/2nEPXgKLC0pY9OC8Mx1ywa3EUxmf64rLzKRcfxINZvLRVjHu6B+kbQh/e+73XqWU
 7/Gw==
X-Gm-Message-State: APuU4Z9qmymo30iYJxvGbq12a/+Vu9LStSars++JHKfVikfzDzHkknEs
 pdOyx9PRetiasGFyfQ2ho4FV2mz9UFkdMDC1BBSSKGmF7Yb1yn/rzBB2OHBj7Fq93nM=
X-Gm-Gg: AZFdTZcbRrbgwrLY1bC+R8fMfXjq7w/aSQF+PIPseWGc0p5BemeEScpsn1JhFxRCSi8
 AKEjgc0U2UF9ep0o1BA60xtsOjbYeqrqUqUwDluwHEh4gkXmDtsB8i4nZNBGmd78KBuu7BNGchR
 R9ysTpHvntUrqOiuewC+/Dr6fQ/rFdF4T3VlwA1IMEATV0xQRfeOKGvbVfLUHmQ65AJogfDSXAH
 B+wS5CgBr95iKKuc7JONqyOXo0G/zNFWQV4xvk7WZXpyyQHDlahaUkc9jmWK9BLrglj2pLGKX+/
 Ie/oRHFbfdvoh5c0bn9Y7qN2QdAvubzMd/bsRNnC1OTcq4yC9juDgFjz04Ossoc1Cs2wV8K++G/
 zWre9lhnPgNbD8OpLoDJZTyk9AP+1tr4LUOFdkNNU5UYE3RuewmSR79SH6s12ZKIm7+i/jTXViL
 dEZfK7yDpcoNlohRLxxzZAZ9CIGK0QC7ts+FteA9ODV+YmgxahB8AIKovIcxogkvpomLUb7835x
 CFt7qPACkDkmx0L+B77+7WeS/f2PimCcXrjHwWG2DyxiVDfQxDcaspF+A3RMbIM3h+FYAl322+y
 JnU9GGwvTMxQx6UWOJ5WuytSEgIDOtCs1tUvh8K3HhGE0YpB+K0nHKMggFIZloTC/nAcppI15YN
 BtLRULd/10iAX
X-Received: by 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id
 5b1f17b1804b1-4bb88817920mr381438395e9.22.1795607053162; 
 Wed, 25 Nov 2026 03:44:13 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm705429405e9.13.2026.11.25.03.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:44:12 -0800 (PST)
Date: Wed, 25 Nov 2026 12:44:08 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 David Lechner <dlechner@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v4 7/9] part: introduce SPL_PARTITION_GET_INFO and select
 it from consumers
Message-ID: <awbJTusr9OUDHk1l@macbook>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
 <20261019-spl_ufs-v4-7-61432d0b258c@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-spl_ufs-v4-7-61432d0b258c@oss.qualcomm.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 16:19:02 +0100, Balaji Selvanathan wrote:
> part_get_info_ptr() in include/part.h resolves the .get_info partition
> driver hook to a real function or NULL in SPL, depending on a list of
> defined() checks for the SPL features that need partition lookups.
> 
> Add an SPL_PARTITION_GET_INFO bool symbol in disk/Kconfig and have each
> consumer (EXT4, FAT, SquashFS, MMC raw-mode partition and partition
> type, and UFS raw-mode partition) select it. Replace the list of checks
> in part.h with a single check on CONFIG_SPL_PARTITION_GET_INFO, so a
> new SPL boot method only needs to select the symbol to get partition
> lookup support.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - Replace the ad-hoc part.h OR-chain check with a proper
>   SPL_PARTITION_GET_INFO Kconfig symbol selected by consumers
> - Drop Varadarajan's Reviewed-by as the approach changed
> ---
>  common/spl/Kconfig | 6 ++++++
>  disk/Kconfig       | 8 ++++++++
>  include/part.h     | 4 +---
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index a32c5fd11e6..adeb2ccc7a7 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -575,12 +575,14 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>  config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>  	bool "MMC raw mode: by partition"
>  	select SPL_LOAD_BLOCK
> +	select SPL_PARTITION_GET_INFO
>  	help
>  	  Use a partition for loading U-Boot when using MMC/SD in raw mode.
>  
>  config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>  	bool "MMC raw mode: by partition type"
>  	select SPL_LOAD_BLOCK
> +	select SPL_PARTITION_GET_INFO
>  	depends on DOS_PARTITION
>  	help
>  	  Use partition type for specifying U-Boot partition on MMC/SD in
> @@ -771,6 +773,7 @@ config SPL_ETH
>  config SPL_FS_EXT4
>  	bool "Support EXT filesystems"
>  	select SPL_CRC16 if EXT4_WRITE
> +	select SPL_PARTITION_GET_INFO
>  	help
>  	  Enable support for EXT2/3/4 filesystems with SPL. This permits
>  	  U-Boot (or Linux in Falcon mode) to be loaded from an EXT
> @@ -780,6 +783,7 @@ config SPL_FS_EXT4
>  config SPL_FS_SQUASHFS
>  	bool "Support SquashFS filesystems"
>  	select FS_SQUASHFS
> +	select SPL_PARTITION_GET_INFO
>  	help
>  	  Enable support for SquashFS filesystems with SPL. This permits
>  	  U-Boot (or Linux in Falcon mode) to be loaded from a SquashFS
> @@ -789,6 +793,7 @@ config SPL_FS_SQUASHFS
>  config SPL_FS_FAT
>  	bool "Support FAT filesystems"
>  	select FS_FAT
> +	select SPL_PARTITION_GET_INFO
>  	help
>  	  Enable support for FAT and VFAT filesystems with SPL. This
>  	  permits U-Boot (or Linux in Falcon mode) to be loaded from a FAT
> @@ -1674,6 +1679,7 @@ config SPL_UFS_RAW_U_BOOT_USE_SECTOR
>  config SPL_UFS_RAW_U_BOOT_USE_PARTITION
>  	bool "UFS raw mode: by partition"
>  	select SPL_LIBDISK_SUPPORT
> +	select SPL_PARTITION_GET_INFO
>  	help
>  	  Use a partition for loading U-Boot when using UFS in raw mode.
>  	  You can specify either a partition name or partition number.


SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC also needs to select
SPL_PARTITION_GET_INFO.

Cheers,

--
Carlo Caione 
