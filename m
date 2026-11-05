Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D75606A32D
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SAfhYAVV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWLMf2+4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EAA44088F;
	Thu,  5 Nov 2026 14:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EyBp9qyaum4a; Thu,  5 Nov 2026 14:08:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D9674087E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887715;
	b=a4lIMKp8XClVpooL29/4rsPH0Gy141AjXtEmtyK+0FDFJT+mje03tmIsuUfz8cMNaTIi
	 1YxzwDuGYVQAs0rAdJTYS4mGnDtjD2WfjZCWKr7weFTBu02c/OTn4HweRc4bHB+qPVSYi
	 8QpFDd4+m5EETuZeA15v+53KsuxKlaFb+DsskFPBMWx/DNm1Ha8l2+3f5+wqDrmYWZnRc
	 vvcQScy8rUWBLJqPIjVGykk1cOeZfERtsO5u4PqidP8Yeqj/lT+vbNeEuPhazYYa1HSi9
	 NOCcwF/Ohq4umsGysxFYTjyGYYTkmwZHADmgXFE96fSJLwM3fDBhzxpqKRbtFUu9KIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LD034ZYguZ4PjurLOzA1eYqsLOyh3IPwICtjNr5j2HM=;
	b=jsplrv8TdFrKzFDXa7xoB33HZW9QCjWF5T7Q/ig56VT0dHA2/O72cd5s95K3zQfgYyQz
	 yEpKgszcA9JwF5qva/W2VHD5Wgo8/RlGamYSgik06z7YPywQpp951ENLpj7AEHqKdkRiC
	 f+w+qbvMRk9Sa2skFBI3bNHIuwhJtOO2fjYn7p80G8cz+mO+rbwT1lAa0vUGRtTtDUUGU
	 MyYEuPgHokwmcbfl/lUe3b6v61neq5N5gauijBqhy8hexwS6II9qbPoi9i6q4Z8yVLpmj
	 8kvwquPSUvnb4DD2vzbrC8yIBdWUzep07gufVcsvdNZpdRQoFiq8ij43oHILt+E5i+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887715;
	bh=LD034ZYguZ4PjurLOzA1eYqsLOyh3IPwICtjNr5j2HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SAfhYAVV/QI50qIyXBgGgAuB1zjheq25TM1YrxYkGs4J8p5MV73dGWwtDGwMfQ+jm
	 uoydhxz05YK1Qy61m4UG+WFtH4ufglWAv5SC4ly6EGtV3LlaHvmuquKD+dpa11m6De
	 CR9cZLPoao/VxIdYKzYHe0WSX9fs+pyxCYhqZ5qSiJFyfJAchO4PqAMe8y6e5L9041
	 gqwkzBAEeE7leLFrCLEjuoazW/idf5mGKCSiNAqoCPYS4w3E9ZDaRb4w4kELPL5Bqw
	 5jgjzYIU3qXHQZezheOLMMvTlESMzPwfr7TGPSfF+UcpZqxocVPwWXw7vFL4dClARI
	 /bqtKfowsetQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D9674087E;
	Thu,  5 Nov 2026 14:08:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2C54235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D085B400B4
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RKhtSXbJNrAa for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E61C64007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kWLMf2+4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E61C64007E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:08:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0169F43755;
 Thu,  5 Nov 2026 14:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517C11F00A02;
 Thu,  5 Nov 2026 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793887710;
 bh=LD034ZYguZ4PjurLOzA1eYqsLOyh3IPwICtjNr5j2HM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kWLMf2+4u7QALb6pV4CZcIDl49w6E428pz6etYxPMNK4A4j2ACn71mH20v+E5q3uF
 uqwmT3jrCkFhyT3xlHzCCJRVBLHJ/CwYPFSqo4VPx3+Wo/jk169Gd2ge4v0iOtn6Jg
 C4sk7i0smHJ6mrEHf4Zk+Dpl+q71FrILGiQ8V9Ih9OEG5ycGzqV5pI9zv5tZaYP/e6
 lbjaP7Q0L2EcdSYyZGEv5/nArM8S3k7MAQo3pcepx6ohdqxEaYIkUSK5isI0v9wwr/
 NE7DWaEZIQctlvUPCJ26kwD35CgxjLAylHRHANp6A8thtQnCid0TwABPxh6P/nFsXD
 IfJk7EeSSLPmw==
Date: Thu, 5 Nov 2026 14:08:27 +0000
From: Yixun Lan <dlan@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>,
 u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Leo Liang <leo.liang@sifive.com>,
 Tim Ouyang <tim609@andestech.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v3 0/4] mmc: k1: multi-block SD reads in SPL and a probe
 failure fix
Message-ID: <20261105140827-GKA249737@kernel.org>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tanmay Kathpalia,

On 14:54 Sat 31 Oct     , Tanmay Kathpalia wrote:
> I am taking this series over from Dave (thanks, Dave).
> 
> Testing v2 2/3 on a Banana Pi BPI-F3 and a Milk-V Jupiter showed that
> multi-block SD reads in the SPL fail because the SD I/O rail (PMIC
> aldo1) is at 1.8 V: set_vdd_mmc() sets it, and without
> SPL_MMC_IO_VOLTAGE the MMC core never sets it back to 3.3 V. Patch 1
> lets the MMC core set the rail, patch 2 drops set_vdd_mmc(), patch 3
> is Dave's multi-block change, and patch 4 is Dave's probe error path
> fix, narrowed to the resets because, as Yixun pointed out, the clocks
> are reference counted.
> 
> Not in this version:
> - v2 1/3 (missing max-frequency). As Yixun suggested, the io clock
>   should be set up with assigned-clock-parents/rates in the DT, which
>   also works for Linux; that will follow separately. Hung-Chun has
>   withdrawn his matching RFC.
> - SPL_PINCTRL. On its own it links no K1 pinctrl driver into the SPL
>   (there is no SPL Kconfig symbol for it yet), so it would not program
>   any pads. It will follow separately once it has been tested on
>   hardware.
> 
> Testing: I do not have a K1 board, so v3 itself is build-tested only.
> The changes were tested piecewise in the v2 thread, and in each case
> multi-block SD reads in the SPL worked: Zixian enabled
> SPL_MMC_IO_VOLTAGE on a BPI-F3, Yixun dropped set_vdd_mmc() alone on
> a BPI-F3, and Hung-Chun set aldo1 to 3.3 V on a Jupiter. Zixian,
> Yixun, Hung-Chun: a Tested-by on v3 would be much appreciated.
> 
> Thanks also to Anand for testing v2.
> 
> v2: https://lore.kernel.org/u-boot/20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com/
> 
> Changes in v3:
> - New: configs: k1: enable SPL_MMC_IO_VOLTAGE
> - New: spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
> - v2 2/3 -> 3/4: commit message explains the BPI-F3 and Jupiter
>   failures; code unchanged
> - v2 3/3 -> 4/4: keep clk_release_bulk(), only drop
>   reset_release_bulk()
> - Drop v2 1/3
> 
> Dave Klotz (2):
>   mmc: k1: let the SPL read SD cards more than one block at a time
>   mmc: k1: do not assert the shared AXI reset on probe failure
> 
> Tanmay Kathpalia (2):
>   configs: k1: enable SPL_MMC_IO_VOLTAGE
>   spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
> 
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 10 ++++----
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 +-
>  board/spacemit/k1/spl.c                   | 21 -----------------
>  configs/spacemit_k1_defconfig             |  1 +
>  doc/board/spacemit/k1-spl.rst             |  1 -
>  drivers/mmc/spacemit_sdhci.c              | 28 ++++++++---------------
>  6 files changed, 17 insertions(+), 46 deletions(-)
> 

The series looks good to me, also tested on BPI-F3 board

Tested-by: Yixun Lan <dlan@kernel.org>
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
