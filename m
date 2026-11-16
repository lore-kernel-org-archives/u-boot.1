Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD9606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hNxE4ye/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE3H3DZ+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AB7380FEF;
	Mon, 16 Nov 2026 16:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0UT31z1K7Wp; Mon, 16 Nov 2026 16:31:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8EC3480D88
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846702;
	b=Oq++05MTuA3qPICY0JOjxK6W0sj6h3oleTjVSsSXN4kF0+dnwQRVyPJTOf4gxT2ZbriH
	 6Yz/VgvxVdRYDNsVG7sl3nVh2U3dQXuF/R3ksZeILDNU5nwlVi5nmDl9Kj8yw4Dl0Jq2a
	 8qSXrfw1pzcAGCyHdlXNnUD9uC0PgGPwCQcS67p5g5uPERir0C2Cr/qj3+NdoZatLsSGU
	 4UA4CHM37J8n7HFjDNeDgGVYF58LQDwjwVd8Zb/+WftzFjf8wZVUbCF8n7qhCaFEcgxDF
	 FE6bsrTUIFonP3BTWiAIPj63fyb+8P2AqlFv4THhcXeyUjPDbVN0cVn3caNp7xLCu7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8QxH7Ho6DO9CapOWzwcW8iClastYIn2e9C/hbd4TTEg=;
	b=b2gqgtYC6ylGn+OTiPGQJh/cdyuuBowbQk+BLvx6UMVLyxwKU/Hlu2VP3qUXAFSYDbl5
	 LkHGocsjLAVP5J7pEaN4JbuJUkbeplZW56dfhuXe2NfGoZQ34tAbAo8VKOeViK6TJOZIs
	 dBXZyZQCqDQzwrC0uN5cSGenCO9ohG7+YcPP6Ke7JUl+sjyFJ/VgsvrmPcmodekhhCKYh
	 3Ztpv4DurQIywbiE4NmPvF85RTAKm0dT7AyI+VlgUfrxleAgDErk9RixcV7YUaMYRAQq3
	 0sv9oPAVObyFwyAAcfc1uOjykq0EDNtGUW/Zlr69wXKCr6D5Qog4HChimlZeNHRcY4g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846702;
	bh=8QxH7Ho6DO9CapOWzwcW8iClastYIn2e9C/hbd4TTEg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hNxE4ye/hjAbgWA7DCaET7Wz0CLoDeIJJ/q4yE+TRMWl2Pd8xKGE9B9O5LOkb7+Zz
	 Zlzizu+7x+LAnmEWX3ySFs+1t+hw+nqT08/j2U1QxnqDVQ09p5JhLUESPBd/lfQhj6
	 I5Z6dxRbQbnsRB7YnDKqDlk4xGwvdvvMVqWLo1T3kxadntKcz6u+2xIsIHLK11zs5H
	 Vy/qcT4y0lyi+qurTZgr9DqkAZLRzXPdJ8KmnRjfyQ8nxrHjXFbQSgl+VCcNPX9Dse
	 RuY3UihpSYqwuydhbGc4Y8xhxrSrTLWWomnbjFzrFc+6Xam9rcqM1fzCMJYYSuelDO
	 s3t64MaMtmHOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EC3480D88;
	Mon, 16 Nov 2026 16:31:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00CD61E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6D9360721
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mo7QMNJ7BCUu for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:31:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08DF060657
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=aE3H3DZ+
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08DF060657
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:31:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B46C62F05;
 Mon, 16 Nov 2026 16:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C531F000C4;
 Mon, 16 Nov 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794846697;
 bh=8QxH7Ho6DO9CapOWzwcW8iClastYIn2e9C/hbd4TTEg=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=aE3H3DZ+1UBjCwDkqJq/XZEZD8cpheDO3XASSce0dAHyFUR4+zIwHYYFaf5UkrDI2
 2ZkVv/QtbnB+YogonRUpfIbBjmjZwsiV8yGQ3f+22angEQWrVOMvbtg3tITF3LKVYH
 asMq0MvwfSDYhGkMJt88cjt8Nfw5q3ll8drZM2DzQ4jdEN8CQk3ZxklzysASP+hjPo
 8rfBeJIqC5oOALfbJHCANANKkOpZO/T98ev/1PtLQ+5biFs+EgQKNIuKDhxqhhKU1K
 qWRBQyGIOhDoocAEQ2kSyBtfF/Hkdqs6M/YC8qWLPgHR4qhvdb99+dizhL6bLf6QBb
 c/Y2gzISAUYXw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mach-snapdragon: Kconfig: fix SYS_MALLOC_LEN regression
From: Sumit Garg <sumit.garg@kernel.org>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 marek.vasut+renesas@mailbox.org, quentin.schulz@cherry.de, 
 jbx6244@gmail.com, Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com, 
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
In-Reply-To: <20261001065559.1432598-1-sumit.dhami@oss.qualcomm.com>
References: <20261001065559.1432598-1-sumit.dhami@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 22:01:33 +0530
Message-Id: <179484669344.21534.5042091577087785028.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-01 12:25 +0530, Sumit Singh Dhami wrote:
> Set the Snapdragon default for SYS_MALLOC_LEN to 0x10000000
> at the symbol's primary Kconfig definition.
> 
> The previous duplicate-removal change retains the smaller
> 0x800000 default, which causes large image transfers via fastboot
> to fail with error: "Malloc failed for: CHUNK_TYPE_RAW"
> 
> Fixes: d3463a9ffcc6 ("mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN")
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
> Changes in v2:
> - Move the Snagdragon-specific default to the primary SYS_MALLOC_LEN definition
> - Add a "fixes" tag
> - Link to v1: https://lore.kernel.org/u-boot/20260930083339.351584-1-sumit.dhami@oss.qualcomm.com/T/#t
> ---
>  Kconfig                          | 1 +
>  arch/arm/mach-snapdragon/Kconfig | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/Kconfig b/Kconfig
> index 67ce72d4270..a9b9c9bba70 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -328,6 +328,7 @@ config SYS_MALLOC_LEN
>  	default 0x4020000 if SUNXI_MINIMUM_DRAM_MB >= 256
>  	default 0x220000 if SUNXI_MINIMUM_DRAM_MB >= 64
>  	default 0x120000 if SUNXI_MINIMUM_DRAM_MB >= 32
> +	default 0x10000000 if ARCH_SNAPDRAGON
>  	default 0x400000
>  	help
>  	  This defines memory to be allocated for Dynamic allocation
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 7f3af9b4364..2433a0a0636 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -20,9 +20,6 @@ config SPL_SYS_MALLOC_F
>  config SPL_SYS_MALLOC_F_LEN
>  	default 0x2000
>  
> -config SYS_MALLOC_LEN
> -	default 0x800000
> -
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>  	default 0x80000000
>  
> -- 
> Best regards,
> Sumit Singh Dhami
> 
> 
> 


