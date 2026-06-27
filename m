Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F853C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 13:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D335C84873;
	Sat, 27 Jun 2026 15:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gADJOFi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDD8841C2; Sat, 27 Jun 2026 15:18:54 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E491805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 15:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mani@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B488B6001A;
 Sat, 27 Jun 2026 13:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593461F000E9;
 Sat, 27 Jun 2026 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782566330;
 bh=xMUSbvpv6BQqEscOYH7NNANJ1j/nOS9Y9hQjghupvmY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gADJOFi6pfzo1wWJFZh21GpUsL4l6UY/KI75eepRUOtx851bLD0+o0TpGplx3rESh
 9c/neIhOk7WErCU5L17gszlUuWTXNWd+pkvxyQxedQssZDKyI+0cZS03dqTcV8Vfba
 tJSKt3L6LuurBpYrOjyXPuhBTJa8uzAbyWRZnoUI9gBjCFhCziVGf1KSa/QkrwXzjL
 eJzKrj1UjZKP7xPrdhGGYSnr7cFKJ4XIIkf6b9bUri+V+ba/qcGiXd1gbVY/WdYoOP
 VaL4wxTawaNdrn9AJN8LmXTsWiQedYNQR/7Ef+BM5+qWXFpOiF7K3QqiTuR7VFEHkN
 eMOc6oSaDPtsg==
Date: Sat, 27 Jun 2026 18:48:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 trini@konsulko.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] configs: qcm6490_defconfig: Enable SCSI as the Fastboot
 flash block interface
Message-ID: <5og33vkh3n4zbvrx6xh55n7d2l7iwnrsmiwtdtsgygu7kvjffu@cp2nwteziy5s>
References: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
 <95fb2056-aa96-47db-bd58-3faa870071e2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95fb2056-aa96-47db-bd58-3faa870071e2@oss.qualcomm.com>
X-Mailman-Approved-At: Sat, 27 Jun 2026 15:46:26 +0200
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

On Wed, Jun 24, 2026 at 04:25:02PM +0530, Balaji Selvanathan wrote:
> Hi Manivannan, Casey,
> 
> On 6/19/2026 1:04 PM, Manivannan Sadhasivam wrote:
> > qcom_defconfig uses EMMC as the flash interface for Fasboot, but QCS6490
> > RB3Gen2 has no on-board eMMC. So override the config to use UFS as the
> > flash medium by selecting 'scsi' interface.
> > 
> > This enables flashing the images over Fastboot on this board.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   configs/qcm6490_defconfig | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> > index b088367f86c..d599e7611c1 100644
> > --- a/configs/qcm6490_defconfig
> > +++ b/configs/qcm6490_defconfig
> > @@ -16,3 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> >   CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
> >   CONFIG_PHY_QCOM_QMP_COMBO=y
> > +
> > +CONFIG_FASTBOOT_FLASH_BLOCK=y
> > +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
> > +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
> 
> Similar patch is submitted and under review: https://lore.kernel.org/u-boot/20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com/ <https://lore.kernel.org/u-boot/20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com/>
> 
> Since most of the Dragonwing boards has UFS as default, we wanted to change
> default to UFS in qcom_defconfig itself and then for eMMC boards, we can
> modify in their board specific defconfigs.
> 

I don't have any issues. It is upto Casey to decide.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
