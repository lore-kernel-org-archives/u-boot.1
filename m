Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9C606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fNhb5W6o;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eis/KIHJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E6EA408D3;
	Thu,  5 Nov 2026 22:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pmJsE6hx9tH; Thu,  5 Nov 2026 22:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8CDF740818
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793917663;
	b=XI4Wn6B1uQRiuzY1qCZ/SLXdZQsitmy7KUEMnQdHUdOVRV2youPq1/Xk+Vf+cq3t9nTy
	 Srw6D0Wynu2K8ejq3Q+W2bFP1MEw1d50pvni+z4mk4zTGcxevBBa8QqShxfS6NM2S/vFd
	 9J+UeVC8R1TtuHkWvgNkQTXEjirXDrdsvnFwVHnljpD6nzibbWrrOgXXgm4vOAw2Anr4b
	 OczpifRoRptOUl5DBEtzaFfj3CuCMFyHj3qeTiUa5Eon/reQS7jndjRqG+9B88fkE0ll+
	 cUmoKAzPnu2HTvlKw9l+mFdYUtQ0ykRgWVNkOpEFDxrIld7JxjMeNkwh2ZuEeXBpwrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793917663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NtJ03Vv6wtoMVrhF6bEAdt3vSLKzKeKKxMF9jEuoiV0=;
	b=G8ajvHgPCGxNSh2/0/Z16KLrJ750B9xwYD70OQEAQZZDbBLUY6FatGAysdGOMrqHTSBy
	 a/dhVzxq5s3aD6BEi7m7fTyGF21REs21VryuzwNOVRt00C++FTwOu7DFM6stGC6xdGW+q
	 z7GsVwR/vdDAxSgl/xJ1P35537ZlLkhV6osdLQqeYytaTnyJv2XC58Tmf9Iqvu5T4ZoUd
	 nA+VgTeguLCI3wAoTMDwsdhvPekeZx3iqN/76JpFukQGO5ggysK4orjNiihdHSRkQ5G7C
	 v3MtuvoHxjs3CzeLXpCec1mVi36u9wZQzkn4HR4TViwtEBIvnLBuule5IdYD1cfgU/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793917663;
	bh=NtJ03Vv6wtoMVrhF6bEAdt3vSLKzKeKKxMF9jEuoiV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNhb5W6oSdgBP829/0zoHvgj1M308j7gPh1Pq1sXXGHpR6hcp+U7OJMGbw9PHPccy
	 feo4Tj6+iq47/X2/4jvOZ0IdJ0W9ZVxzaAO4GBzJF1TrKnLAQ51nkVv80Qh4B3KDKB
	 ZhP7XQ+mn9wKG8Ijcfum28S0gn5IObwW2s7yE2QsH2lxcs07MXsOBwFmie7WRUJ04d
	 DjUjb8sln87c4Bm+05oxWY/zTZVBbO2MBfVWU8BPKMX6SmqhPK5fq40klSiWXNsiUq
	 zoR1sYl48LsPFLcNbU0UzHi8E8YPwdfx90J6NKismqf1EpK+OhBzKX3idoFUCdmQUo
	 GljoJzXRfu+Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CDF740818;
	Thu,  5 Nov 2026 22:27:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09ABAB7E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 22:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2FE7809C2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 22:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6EARW_HHbq8K for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 22:27:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC65E809A7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eis/KIHJ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC65E809A7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 22:27:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4A0441281;
 Thu,  5 Nov 2026 22:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5716C1F0089F;
 Thu,  5 Nov 2026 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917659;
 bh=NtJ03Vv6wtoMVrhF6bEAdt3vSLKzKeKKxMF9jEuoiV0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eis/KIHJQd6vmcFqAFQdFmI1joZL2dL/VZofshoid46dGr7eIZepzBlJWA83m3a4X
 dxr+uAqKjBhLDqnWNTMDNAPO8fsR0XLbHJS6eMxvZ4BaqSQSA0IzyZqei24BmccJCW
 FnL7prneGZRNDosE+p/LEaND1nKoY5YFK0gG0hq4MNMStWHA3+JaMAozEvDC91brcn
 AFYEp/iK/bRmzyfZHG/gkGClkHPwQsYpERT8PvImBY6p91IHq4HiQNp9NiGtMag3/y
 iprBPCRuZ4zdJuoGfDd2S1A8AzhiTnrQyzEK+ed47iclfX+w1AZITVfHU1/qzfhk0M
 dVdJzrZpPLpug==
Date: Thu, 5 Nov 2026 22:27:37 +0000
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
Message-ID: <20261105222737-GKB249737@kernel.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peng Fan,

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
Generally ping for mmc patches, would it be Ok if I take patch-3,4
through spacemit's custodian tree[1], I'd genuinely appreciate an
Acked-by if that's fine with you..

Link: https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit [1]

-- 
Yixun Lan (dlan)
