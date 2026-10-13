Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA34CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BEF080D34;
	Tue, 13 Oct 2026 08:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lzlh8ozTCdr9; Tue, 13 Oct 2026 08:57:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D25D80D05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881822;
	b=iWaa3aH/Z4vLyQD9qujh78lHa0diHpxEyKIE893y+VkR3lziCkFDgcawJOxMp/rVDqgV
	 t30y5nYT4R+PHrxdbALDdUH3elRmBCI4Zki1FxD9rWa7ebPZHxlG4FUHoORMiGi0M20Uh
	 2j1bpHBuTvfM7KrmCsxJGiV1AZfaTkW4UfqJ01cpRmJRdeGVSSHwTBc+p9nNpKoWslTZZ
	 tPwV9ot67Rom0J8I08aMACsbxKqpdSEhC1Fs3Wn/0l3ytZHWpl7CJ0X0ugit3PeUdZ5mq
	 Cfvg8Wwqxf6OPozbsq7zQs+vciHrZIu7bb4Lh2/WhDVHOsq8+s9QJXQGXpxWwT90d8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t76vFfL7QM8m/Gvs8sKQSoCa7bBtO8Alwif+tASZ8PU=;
	b=RLLMV3GC0tZfG9niV2ZjCFHxrLtmjHa5U1sBr18EPxzIj20rrykECWjw2DRstBFAf2S3
	 MThmbRom/Y5ASvVHDQ/rn6sNQnNzUJHzizHTyl2bjZhoPGQGhMucoh6BNN7iM6Q1safRS
	 3+ehKPtrjplCbAAUhiF+NyvKrdnU9nxCjlMOW4nwO+hoe39WD+FLSEvyYG+2HPkL2d/yt
	 Gid9xzpxKmO8bnjdsMtOQwr+Hg4ihfRHj9cUfMY5A2KjT37C4FdhZcH4Bj7RUtQWuU4af
	 dD/vWIGPANAVSB1/Xvrvl41hgQDMr3f5J8LtTESeVKoa6cOXIxJc5TXvKSGITtiQuEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881822;
	bh=t76vFfL7QM8m/Gvs8sKQSoCa7bBtO8Alwif+tASZ8PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQ8x4jindXODo4DGxkwKFPioHMJtnNMDNZELAxu+J2wShBFKhyXXc2+ln9sQxSHd5
	 8MK8xrwEzD5E0cafaq1LczNEctQGvxcyW1xguaBBX7aLDpES3TdLIgcpLnDoUkp3Tp
	 3/QCzCY5s0MCzxFN/17Yei5ypJgiKXyKBYZP3mqnvsTK1aRC577oiiNYRx/ea72Ltz
	 hhia5iqNEgqaA395Eq1kHjfpyouOzCrm7IpdlGCEmi82VTGF+5i2Li/ukOqwsPboBv
	 5f1WiCc4/GyOBT3yjhzSP/GvwwUxPGQJhVB/+rMzk5CR3/JcyNE2h3jmDyR0hRGMfa
	 712KBIdoZyHiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D25D80D05;
	Tue, 13 Oct 2026 08:57:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 58A631E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A1B560679
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wbrHv_Idxp_0 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C64D605FD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881819;
 b=BhVVDu0L55fOhrIJxAlaw57wuhJGGLjmDAWQt9f0/3awhCwO8/RXzkl6ZBXqNUzMlspP
 KFfxBwr3AKrhnPyIO+1qLBVMPItvDOTNQVLdoPKlAtyO6wLsMeaqk628yIP0LRJdrHl+S
 nEp9TKDbMGuY+u/d1Kt5HArew1Dd9eXNGwuFHaY4WfXKRKW1A/Yj7hSk7GSumw53heBpa
 l1WT1yCWGYW3dkwKfxyRX3v5RDQY2vHGkOTcQ7w8+ofyNY0R9PbEuCnw68BRaKmHGnwCK
 6EzPBAF3dKJEdKITnrg17Pb7hvBofZ6mZ++kOW7Pqg4A50sbiUclKAKBxp0OoJBWhXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881819;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=t76vFfL7QM8m/Gvs8sKQSoCa7bBtO8Alwif+tASZ8PU=;
 b=rceBnjVaW1fyP/56NAwSMt2oew99n2A8/T0mjVkrAMtnaIjcHTSdaFfn8Sohx70KcvIb
 Jnt2hpUGkb/09gTrGhGfFtuC9Ijlft5KYm4BvQZGm6K95j1a8W+ULAfPcYCHtVHl0wwCN
 Jn7tE/D0eMFhQY6cZTuNwItjuHJiDJWYdNiDgCzrZH9gnYkA28RnFK1BvO4eF3AmLdgWK
 TG0po4E1xfh5PV/BDUQE+PkZW4EYB861kRqh8pTQ/5lMEQ3nP8EYXVPTuCiXtMdem6TDi
 mfVXPswU8fEioB6bhGqI2UkTG0807vvZtTFpm92OIvkqUOLTEeQswY9hSMPxP1rQLpQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NvHVmyIf; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NvHVmyIf
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C64D605FD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:56:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51A2641271;
 Tue, 13 Oct 2026 08:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B319E1F000FF;
 Tue, 13 Oct 2026 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791881817;
 bh=t76vFfL7QM8m/Gvs8sKQSoCa7bBtO8Alwif+tASZ8PU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NvHVmyIfgwYZs2+2JPBqPFR7ZHmTwuHSk3UWSJTANNqbPbwINzFwfxg9bQDc4DGvr
 G+3cRFbXbH/Venl0GeMWzYUjjlR2f+s894V3K5c9YPR0br9vWZ2ZdBZy9TZqRe6AcH
 +UDOPl+pIKaKmLBGMzWuPe95ZkX0vUEzqeOiWjE1JAkmW4urSjNcmomVtIeijPJRHg
 1oXbUoqGqyNobAlCcEXbAm+3Ey6p3kS1LwMAFplXqNOPVSc/7uRKdVQd7UXAMhCEiK
 nv1Fis3EwcjLLywr1vPyoGl+y7YxMZfIr6UbBNtvQlc7CQ+YX3mb0o+zE3n+8xiAZA
 ei7tmEPGW+ihw==
Date: Tue, 13 Oct 2026 08:56:54 +0000
From: Yixun Lan <dlan@kernel.org>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, E Shattow <e@freeshell.de>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [RFC PATCH 0/2] mmc: k1: do not require max-frequency in the
 device tree
Message-ID: <20261013085654-GKA65630@kernel.org>
References: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013084448.433298-1-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Hung-Chun,

On 16:44 Tue 13 Oct     , Hung-Chun Tseng wrote:
> The K1 SDHCI driver sets the io clock to cfg.f_max, which is only
> filled in from a "max-frequency" property, so each K1 board carries
> max-frequency = <204800000> for the SD and eMMC nodes in its
> -u-boot.dtsi. E Shattow pointed out that this property is unlikely to
> be accepted in the upstream device tree and looks like a driver issue
> [1]. The Linux driver indeed does not need it: it reports the current
> io clock rate as the maximum.
> 
> Patch 1 makes the U-Boot driver do the same when max-frequency is
> absent. Patch 2 drops the property from the BPI-F3 and MusePi Pro
> overlays.
> 
> This is an RFC because I could only build-test it: spacemit_k1_defconfig
> builds (SPL and u-boot.itb), and the resulting BPI-F3 and MusePi Pro
> DTBs no longer carry max-frequency on the MMC nodes. I have not run it
> on hardware. The open question is what rate the io clock runs at when
> SPL and U-Boot probe the controllers: if the BootROM or SPL leaves it
> well below 204.8 MHz, SD and eMMC will still work but run slower, and
> the driver may need a default rate instead of the current one. A test
> on a BPI-F3 or MusePi Pro, or a pointer to the expected clock setup,
> would be very welcome.
> 
> [1] https://lore.kernel.org/u-boot/5d323a11-da4e-4071-bdeb-ab5c03e8f85e@freeshell.de/
> 
Please do not start a new thread, as there is already one discussion, see
https://lore.kernel.org/all/20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com/

> Hung-Chun Tseng (2):
>   mmc: k1: use the io clock rate when max-frequency is absent
>   riscv: dts: k1: drop max-frequency from the SD and eMMC nodes
> 
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  2 --
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 --
>  drivers/mmc/spacemit_sdhci.c              | 24 +++++++++++++++++++----
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
