Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DABF34C4E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B25839DF;
	Mon, 13 Apr 2026 15:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GLjFLQUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFB483F75; Mon, 13 Apr 2026 12:25:20 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9050D839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 12:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E052E60180;
 Mon, 13 Apr 2026 10:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17569C116C6;
 Mon, 13 Apr 2026 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776075915;
 bh=z0YuZbyTcH23iBo7qJ79EPuUyhrs7+10Oarne301sPc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GLjFLQUoHZsogHzQcNHeNM2nLsOwtzffeIR+xSV6JaK4h/MyZLkTQD3VHdFdhPxRR
 FXKaKHI1LWS0UqB+G/sp5gdBDpe/6xyUHsKtfl59lIj2t802H1Eyt6YZ0t6qNZ+1+a
 Es9IQotBVQH3hnyK6QiAP0+DqZDoMBX2mATqi8jxvdtWIFUA1hzY4eYqJ10o8/oofc
 wqD1IhoynHpBWb7eP4tRGbegzJbNcD01+6zBzduRZ/QQSnkGoXRRHeodsoHvloULZH
 d1XkhzC7rTvKL0P1eNmRQeVfELEy3U+BF7sLqK1Rlq01yM/ZD0kjUwcKhbcpd5Hmr6
 7G+H7xOiE+gxw==
Date: Mon, 13 Apr 2026 15:55:00 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] Add SPL support for Qualcomm platforms, starting
 with sdm845
Message-ID: <adzEfIuz7agjMnxr@sumit-xelite>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <adS8d1UulaxycPlU@sumit-xelite>
 <6e0aa4d2-4c65-4e84-8afc-4eae3cead426@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0aa4d2-4c65-4e84-8afc-4eae3cead426@seznam.cz>
X-Mailman-Approved-At: Mon, 13 Apr 2026 15:49:01 +0200
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

On Wed, Apr 08, 2026 at 08:16:12PM +0200, Michael Srba wrote:
> Hi,
> 
> On 4/7/26 10:12, Sumit Garg wrote:
> > Hi Michael,
> > 
> > On Sat, Apr 04, 2026 at 01:18:15AM +0200, michael.srba@seznam.cz wrote:
> > > [ context ]
> > > 
> > > Different generations of Qualcomm SoCs have differences in the boot
> > > process. msm8916 (and similar) are quite straightforward:
> > > [EL3]bootrom->sbl1->tz->[EL2]hyp->[EL1]aboot->linux (omitting non-AP
> > > cores). msm8998, sdm845, kodiak and simiar are a bit more involved:
> > > [EL3]bootrom->xbl_sec->[EL1]xbl_loader->[EL3]tz->[EL2]hyp->[EL1]uefi
> > > ->ABL->linux. Newer platforms like hamoa are even more involved.
> > > 
> > Just as a heads up, we are trying to open up the boot stack/EL3 on
> > Qcom platforms such that a developer/OEM can run OEM only signed TF-A/
> > OP-TEE stack on IoT targets. However, as you can expect it will take
> > time but we already had some success..
> > 
> > > Currently, u-boot proper can run in place of Linux, in place
> > > of aboot, or in place of hyp. The option to run in place
> > > of Linux is necessary because >99% of OEMs do not consider
> > > the sale of a device to an end user a transfer of ownership,
> > > that is, they sell the device with a hash of their public key
> > > pre-burnt in the fuses.
> > > 
> > > [ end of context ]
> > > 
> > > U-Boot SPL, as it will be built using the defconfig added in this series,
> > > replaces xbl_loader. If support for msm8916 or a similar platform
> > > is added, it would replace sbl1. This will obviously only work on
> > > the <1% of devices whose manufacturers consider the sale a transfer
> > > of ownership, and of course most SBCs.
> > > 
> > > Unfortunately, starting with (iirc) msm8998, and getting progressively
> > > worse, Qualcomm no longer consider a sale of their SoC a transfer
> > > of ownership either. While it's possible to execute your code
> > > in EL3 using either jtag or a patched devcfg, the former is impractical
> > > while the latter is irrelevant for the purposes of running u-boot SPL
> > > since the devcfg is parsed by trustzone. (this of course only applies
> > > to the <1% of the devices where the OEM didn't lock the device down
> > > prior to sale)
> > Good to see your U-Boot SPL efforts as a replacement of XBL loader.
> > 
> > > Given the above, this series uses an unintended feature in old builds
> > > of xbl_sec which allows us to elevate to EL3. We also check if we
> > > happen to already be running in EL3, in which case we proceed normally.
> > > This can be the case e.g if JTAG was used to jump to u-boot SPL in EL3,
> > > which may be the only option on e.g. kodiak. (Running in EL1 is not
> > > really viable, because xbl_sec+xbl_loader are effectively sbl1 split
> > > in half and replacing only one doesn't make much sense)
> > To begin with Kodiak/RB3Gen2, you can download XBL_SEC image using links
> > from meta-qcom recipe here [1] (firmware v00116.0 onwards) to execute
> > qtestsign'ed code to run at EL3. If you are interested in TF-A/OP-TEE
> > stack then that's available here for Kodiak too [2] [3] although you can
> > execute U-Boot proper in EL3 too.
> > 
> > [1] https://github.com/qualcomm-linux/meta-qcom/pull/1627
> > [2] https://github.com/qualcomm-linux/trusted-firmware-a
> > [3] https://github.com/qualcomm-linux/optee_os
> I was aware of this effort, however this doesn't seem to be intended
> to jump to sbl1/xbl_loader replacement in EL3, just jump to non-qcom-signed
> trustzone. I didn't explore if it's possible to simply immediately jump
> to EL3 without doing the intended xbl_loader/xbl_sec back and forth
> (which I really see no reason of supporting in u-boot SPL), but I suppose
> if the xbl_sec is willing to immediately jump to whatever the boot0.h
> assembly would tell it is trustzone, but would in fact be the rest
> of u-boot SPL, it would be usable.
>

As you may know that these SoC from Qualcomm are derivative of mobile
platforms, so there is a requirment of XBL_SEC to lock down certain
Qualcomm assets before jumping on to EL3. So surely your effort to
enable U-Boot SPL as a replacement for XBL loader is good step forward
for the open boot stack on Qcom platforms.

> From a cleanliness standpoint it would obviously make more sense to simply
> release the cros variant but without the impossible-to-satisfy fuse check,
> but bloat that never gets executed doesn't bother me as much as bloat which
> does.
> 
> As for older platforms like sdm845, it would be nice if you could simply
> publicly release whatever the oldest xbl_sec builds in your archive are.
> These are (to my understanding) already available to OEMs, but I doubt
> they're explictly allowed to share them, so you sharing them directly
> would be logistically much more straightforward than any other
> unambiguously legal approach.

I don't know which particular version of firmware you refer to for
SDM845 but unfortunately I don't see any new firmware releases coming
out for SDM845. So it would be better for the OEM to reach out to Qcom
for whichever firmware version is asked for no-login release. Feel free
to CC me if I can be of any help here.

> > > For now, only usb dfu is supported to load the next stage. Since we
> > > don't support ram initialization, the next stage will need to run from
> > > SRAM too, which is currently not supported.
> > Sadly DRAM init sequence isn't something that's available as an open
> > source driver but you can expect QcLib blobs for DRAM init in U-Boot SPL
> > just like what's already available with the coreboot project here [4].
> > 
> > [4] https://github.com/coreboot/qc_blobs/tree/main/sc7280/boot
> The problem with those blobs (well, QcLib specficically) is that it's very
> much not just DRAM init, but an ugly mess of (afaict) whatever Qcom's
> lawyers didn't feel like greenlighting for proper open source integration
> into the upstream project. I also seem to recall statistics of the blob
> being 9:1 in size compared to the entire rest of the coreboot binary,
> which is really hard to swallow.
> 
> Would it be possible to have two separate blobs, one with *just* DRAM init
> (and training? though that's hidden well enough in the aux core that it
> would be hard to argue that the AP part can't be open)
> and one with whatever else you don't feel like fighting the lawers over,
> so that the parts that are not literally dram init can be skipped
> (in case of stuff like XPU setup, which is not really *necessary* for
> a working system). I'm not sure if there's parts that can't even
> in principle be skipped, but if there are it would certainly be worthwhile
> trying to convince the lawyers to let *those* be open and properly
> integrated into u-boot, and in any case they would probably be very
> few and reasonably easy for someone to reimplement and make the only
> non-optional blob be the dram init one (as is the case for other platforms,
> e.g Rockchip)

I understand from where you are coming from and we are really trying to
change that blob situation via pushing drivers upstream when there is
no legal concern. xPU and few other drivers you can already find in the
TF-A repo here [1]. OP-TEE project is also gaining upstream drivers support
too here [2]. Rest assured you will find more drivers being opened up with
hopefully the ones left will be with a legal objection.

[1] https://github.com/qualcomm-linux/trusted-firmware-a/tree/qcom-next/drivers/qti
[2] https://github.com/qualcomm-linux/optee_os/tree/qcom-next/core/drivers/qcom

-Sumit
