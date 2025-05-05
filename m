Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A7AC369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 05:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040A980F03;
	Mon,  5 May 2025 07:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jWlAto8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C78480BAE; Mon,  5 May 2025 07:14:46 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7437D81F0D
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 07:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B4617A4C3CA;
 Mon,  5 May 2025 05:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CEC4CEE4;
 Mon,  5 May 2025 05:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746422081;
 bh=uqHpOnuYuimaiJySpq0mCGBPTDpllKHHzJrebJpkjZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jWlAto8F0p16/PaFvfDtY09Ivjm+Ou/BtXsxuTnpoaGU4CoBdp7DlTvMucKzAKO8P
 mjB2XC8C0Lj/EcssnRebs5ePrK8AjMK/SbcBwo+di6aMQavXN906FVXJZW1h+KX1d0
 vnFWcMqbDZAdX5cv3k6yQYH27TafRaXh8msxlAC/Per+NZD/kufdBro8B5CgPaD+JV
 u8L0CNX9CW0iRPdk2Jj7jXVJFAiMlzWX9DLQLjdkIvLJlUDdqTQVDjU9ulbH4Dxr8K
 NM7akvSVTrS8RmShtqn5DLgborPm+CHHXjFCz8bLIzrIQO2RpkXzZwGJPu5mM//BiQ
 nrmMLqcPPFjLg==
Date: Mon, 5 May 2025 10:44:34 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
Message-ID: <aBhJOuZnaf43hpJ5@sumit-X1>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
 <aBSjZ7ospvGxJrbD@sumit-X1>
 <3a56b0bb-9446-42f2-9b85-ae65de295499@linaro.org>
 <aBS8d8sffQitinZW@sumit-X1>
 <45555006-5086-4017-ac88-cfb86c062322@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45555006-5086-4017-ac88-cfb86c062322@linaro.org>
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

On Fri, May 02, 2025 at 04:32:44PM +0200, Casey Connolly wrote:
> 
> 
> On 5/2/25 14:37, Sumit Garg wrote:
> > On Fri, May 02, 2025 at 02:16:53PM +0200, Casey Connolly wrote:
> > > Hi Sumit,
> > > 
> > > On 5/2/25 12:50, Sumit Garg wrote:
> > > > Hi Casey
> > > > 
> > > > On Fri, Apr 11, 2025 at 05:03:33PM +0200, Caleb Connolly wrote:
> > > > > The initial capsule update support only worked on the RB3 Gen 2 and made
> > > > > a lot of assumptions specific to that board.
> > > > > 
> > > > > Implement the logic necessary to update U-Boot no matter where it was
> > > > > flashed to, independent of any particular board.
> > > > > 
> > > > > First, we keep track of how U-Boot was loaded, specifically if we had a
> > > > > valid external FDT (even if we didn't use it) this indicates that we
> > > > > were booted via the Android bootloader, in this case the target for
> > > > > capsule updates is the boot partition. Otherwise, we target the uefi
> > > > > partition (if it exists) or the xbl partition. We handle A/B support for
> > > > > all 3 (currently we always flash to the currently active partition with
> > > > > a minor exception for the uefi partition).
> > > > 
> > > > Does this means say if we are booting from "A" partition then the update
> > > > gets applied to "A" partition only? IOW, we don't support dual bank
> > > > updates as of now?
> > > 
> > > Yes exactly, to have A/B working we would need the following:
> > > 
> > > * Implement all the fiddly GPT stuff (the vendor bits but also swapping the
> > > partition type GUIDs between A/B partitions)
> > > * Change MMC/UFS boot block/LUN
> > > * Support flashing all other bootloader partitions via capsule update
> > > 
> > > And really some tooling to produce said capsule update files containing all
> > > the bootloader related images.
> > 
> > Thanks for the info, those can sure be next steps.
> > 
> > > 
> > > > 
> > > > > 
> > > > > We introduce two new fw_name strings to differentiate the GUIDs based on
> > > > > the target partition, this means one board can support multiple boot
> > > > > methods with capsule update support for all of them (typically this
> > > > > would be chainloading OR flashing U-Boot to XBL).
> > > > > 
> > > > > Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
> > > > > scsi_scan() unbinds all scsi devices it breaks device handles maintained
> > > > > in the EFI layer for the duration of the capsule update process and
> > > > > causes the EFI filesystem access to delete the capsule file after the
> > > > > update to fail.
> > > > > 
> > > > > Boards should instead be responsible for calling scsi_scan() before
> > > > > initiating DFU.
> > > > 
> > > > Thanks for working on EFI firmware capsule updates feature. I think
> > > > currently we are missing any documentation from this patch-set. IOW, how
> > > > one can test updating U-Boot via EFI firmware capsules? I suppose we are
> > > > using here dynamic GUID generation while creating update capsules,
> > > > right?
> > > 
> > > Yes, we're using dynamic GUIDs. I have written a small tool and brief docs
> > > here for creating an LVFS cabinet which can be used with FWUPD
> > > 
> > > https://github.com/kcxt/mkcab
> > 
> > Thanks for working on that tooling. However, it would be better for
> > U-Boot documentation to instead use standard tooling like:
> > 
> > $ fwupdtool build-cabinet ARCHIVE FIRMWARE METAINFO
> > 
> > where we can provide an example meta info xml file in the docs for Qcom
> > platforms.
> 
> oh lol, you mean this exact thing already exists! grrr>

Yeah but TBH the documentation is pretty limited for that tool.

-Sumit
