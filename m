Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2BC3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 12:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE1A812BC;
	Fri,  2 May 2025 14:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BdbmbADO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC8C81FDE; Fri,  2 May 2025 14:37:21 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63729801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 14:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AB6C2A4C2A3;
 Fri,  2 May 2025 12:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286E1C4CEE4;
 Fri,  2 May 2025 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746189438;
 bh=F18jOaYg0G3ZMUKXaAp/cKev5+PwpQZBaZcfpsdZAfQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BdbmbADOMwdbm/lnTq+i1LXPuxBo7D3KrU6Q15HK3Ia2C8mMuq1AinOICs5iSlQHc
 4mEC2oZqvhTPAwTPvoeOVQR+MiwRA7yIHzWVYlB3m2lBX4yxIjCVxwlY4KR0+dNQCj
 wz7iJFZ42r4rk6ThjaFYjBBjaFI5NB0fS6f+iJ6ag5lE+36HTkktdvgml79NGinYYZ
 ShQb6a/vxttiC0IOx10SuBqaCe2/p4M0s67kgB1Xdt7SVIkMf/ybxyJFx1pCzas0Gi
 CTkc/i4oFXNFoVUVBNSscfzepC2p8jwjXslWXGBttMd26nNEel0zgKzAj5UnimnqeP
 RqHO05NCDZzLg==
Date: Fri, 2 May 2025 18:07:11 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
Message-ID: <aBS8d8sffQitinZW@sumit-X1>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
 <aBSjZ7ospvGxJrbD@sumit-X1>
 <3a56b0bb-9446-42f2-9b85-ae65de295499@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a56b0bb-9446-42f2-9b85-ae65de295499@linaro.org>
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

On Fri, May 02, 2025 at 02:16:53PM +0200, Casey Connolly wrote:
> Hi Sumit,
> 
> On 5/2/25 12:50, Sumit Garg wrote:
> > Hi Casey
> > 
> > On Fri, Apr 11, 2025 at 05:03:33PM +0200, Caleb Connolly wrote:
> > > The initial capsule update support only worked on the RB3 Gen 2 and made
> > > a lot of assumptions specific to that board.
> > > 
> > > Implement the logic necessary to update U-Boot no matter where it was
> > > flashed to, independent of any particular board.
> > > 
> > > First, we keep track of how U-Boot was loaded, specifically if we had a
> > > valid external FDT (even if we didn't use it) this indicates that we
> > > were booted via the Android bootloader, in this case the target for
> > > capsule updates is the boot partition. Otherwise, we target the uefi
> > > partition (if it exists) or the xbl partition. We handle A/B support for
> > > all 3 (currently we always flash to the currently active partition with
> > > a minor exception for the uefi partition).
> > 
> > Does this means say if we are booting from "A" partition then the update
> > gets applied to "A" partition only? IOW, we don't support dual bank
> > updates as of now?
> 
> Yes exactly, to have A/B working we would need the following:
> 
> * Implement all the fiddly GPT stuff (the vendor bits but also swapping the
> partition type GUIDs between A/B partitions)
> * Change MMC/UFS boot block/LUN
> * Support flashing all other bootloader partitions via capsule update
> 
> And really some tooling to produce said capsule update files containing all
> the bootloader related images.

Thanks for the info, those can sure be next steps.

> 
> > 
> > > 
> > > We introduce two new fw_name strings to differentiate the GUIDs based on
> > > the target partition, this means one board can support multiple boot
> > > methods with capsule update support for all of them (typically this
> > > would be chainloading OR flashing U-Boot to XBL).
> > > 
> > > Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
> > > scsi_scan() unbinds all scsi devices it breaks device handles maintained
> > > in the EFI layer for the duration of the capsule update process and
> > > causes the EFI filesystem access to delete the capsule file after the
> > > update to fail.
> > > 
> > > Boards should instead be responsible for calling scsi_scan() before
> > > initiating DFU.
> > 
> > Thanks for working on EFI firmware capsule updates feature. I think
> > currently we are missing any documentation from this patch-set. IOW, how
> > one can test updating U-Boot via EFI firmware capsules? I suppose we are
> > using here dynamic GUID generation while creating update capsules,
> > right?
> 
> Yes, we're using dynamic GUIDs. I have written a small tool and brief docs
> here for creating an LVFS cabinet which can be used with FWUPD
> 
> https://github.com/kcxt/mkcab

Thanks for working on that tooling. However, it would be better for
U-Boot documentation to instead use standard tooling like:

$ fwupdtool build-cabinet ARCHIVE FIRMWARE METAINFO

where we can provide an example meta info xml file in the docs for Qcom
platforms.

> 
> I'll write something in doc/board/qualcomm to explain things too (excluding
> the LVFS bits).

Thanks.

-Sumit

> 
> Kind regards,
> Casey (she/they)>
> > -Sumit
> > 
> > > 
> > > ---
> > > Changes in v2:
> > > - Restrict the partition hunt to either UFS storage or the first MMC
> > >    device so that we never accidentally write to some external storage
> > >    (like an sdcard) during a capsule update.
> > > - Fix typo
> > > - Link to v1: https://lore.kernel.org/r/20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org
> > > 
> > > ---
> > > Caleb Connolly (4):
> > >        mach-snapdragon: track boot source
> > >        mach-snapdragon: CapsuleUpdate: support all boot methods
> > >        dfu: scsi: don't call scsi_scan()
> > >        qcom_defconfig: enable capsule update support
> > > 
> > >   arch/arm/mach-snapdragon/board.c          |  26 +++
> > >   arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++++++------
> > >   arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
> > >   configs/qcm6490_defconfig                 |   6 -
> > >   configs/qcom_defconfig                    |   3 +
> > >   drivers/dfu/dfu_scsi.c                    |   5 -
> > >   6 files changed, 266 insertions(+), 62 deletions(-)
> > > ---
> > > base-commit: 885d68280c29b8011731b6a7cdac32b8d9a4e6fd
> > > change-id: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2
> > > 
> > > Caleb Connolly <caleb.connolly@linaro.org>
> > > 
> 
> -- 
> Casey (she/they)
> 
