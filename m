Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E912AC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37DC780214;
	Thu, 16 Jan 2025 10:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L1GUA4+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0069380283; Thu, 16 Jan 2025 10:03:13 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20634801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso3966165e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737018189; x=1737622989;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EXldksElNTay5cd4V0QOG/Kepm2lR2Oe8gMZTCOPIKg=;
 b=L1GUA4+pxCrJJkToOD9OJvI9FCLtN7D5DJP8Z0msqbORdC1uWB7amZ1UBIgom3iEqn
 wTKSve086mHd+gnr/oLBTXOkuUrk3T5biIn0j/LtnjkeytK+AODktgybtsGCBP6LujcD
 xckc5FyGnRKFsuvhwj6iLIAIO04ZB9LTm9aTJl0YdqjAr9rPtJ9DvK9t/JqUUdrhChPt
 NP8eoJJD7BKce3Ux6cFgK+Govt3xLuO/dcOBkQIwhWkkJ08Zc2KKKc1S1tdSgvJUx8uD
 lWZNWgIFJU1V9dHBxgpcSBiZol/mc0WzPc+AA4bieJId8oKvqCO2JeLCeBkZvJ2gNaiF
 vbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018189; x=1737622989;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EXldksElNTay5cd4V0QOG/Kepm2lR2Oe8gMZTCOPIKg=;
 b=tMsGIOdkDbCSEUTLRLBGT1QwzK4uL96xmGWZ+Hc8nFxqQfBU2fxPsHkIQU3954ECP4
 wVgDLaAi7A8kMEjjTR3NjnNkF7sAU6xmfgVOicRgsy6/rkFk9rrDPjkkQgewGrprhMhr
 lSGAW6xYLlnCBs2ikwDWs974k3hjBwQAUJx4Ex0+fGQcjEbv0ijCOYkdQWXaMpDC/BYp
 FbmEjpieDDVuAcuwFF3Q36r7FvRWPXrzIifiBwTn3H9jH17BtLeAY/ynkYcAZ+fj9ZZF
 G/ozMyQqr3MPVE7kUCWwQi3kmmf92tLVR1/efwnJMxcNuvXdOnMFUKW8fsMt1maeN7K7
 S+Yw==
X-Gm-Message-State: AOJu0YxkQd77pLfThld/dhWNeszwAqcC81bScsYz7qGpALkgBM+Tl+kh
 JGGGpU/TLeerPC/G2Vx/Sq72yKTN1/ADn31T1iRTigzDVKpZ5pFeyp9erPaoSFw=
X-Gm-Gg: ASbGnct3oj926MwJoN82O/LAaaqtNxpLGQoGP80yMiZcQ/yL6erDw3fN5QqdGC5L9O9
 s4ARIEhdNXoeV1hntsEbD78B9+k5j8Z+rizIP2goBmcwRhEMC8/NrOQ9Uyvy7w/ai2J4Yed+1X/
 h0rvp5tBlTJZtIxXHrTFRUz1Iz+WHNfykKR0+3awhIucB4p6iUl2vDuZxZNdes1SvKOOHFlA3fx
 5ZPlyuc4tFrezKm5pxNvikfDqTzUDLGCCMrANW7qZ5LhVTGXm1hTk5lQimWNRmqWA==
X-Google-Smtp-Source: AGHT+IHhCE9771zbhl73XKAvWUGx2IICo/B+wp3XZHwf7hoN7DzMP36h5E1+1P22neVUh6tEi3ldqQ==
X-Received: by 2002:a05:600c:34d1:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-437c6af7af2mr51731595e9.4.1737018189269; 
 Thu, 16 Jan 2025 01:03:09 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c5bb5sm53317485e9.22.2025.01.16.01.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:03:08 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com,
 junhui.liu@pigmoral.tech
Subject: Re: [PATCH v4 6/8] usb: dwc2: Extract macro definitions to common
 header
In-Reply-To: <20250110-dwc2-dev-v4-6-987f4fd6f8b2@pigmoral.tech>
References: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
 <20250110-dwc2-dev-v4-6-987f4fd6f8b2@pigmoral.tech>
Date: Thu, 16 Jan 2025 10:03:07 +0100
Message-ID: <87o707871w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Junhui,

Thank you for the patch.

On ven., janv. 10, 2025 at 21:55, Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> From: Kongyang Liu <seashell11234455@gmail.com>
>
> Some macros are shared between host and gadget code, causing duplicated
> definitions. Move DWC2 macro definitions from host and gadget code into a
> common header to reduce duplication.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/common/dwc2_core.h         | 430 +++++++++++++++++++++++++++++++++
>  drivers/usb/gadget/dwc2_udc_otg_regs.h | 154 +-----------
>  drivers/usb/host/dwc2.h                | 291 ----------------------
>  3 files changed, 431 insertions(+), 444 deletions(-)
>
> diff --git a/drivers/usb/common/dwc2_core.h b/drivers/usb/common/dwc2_core.h
> index 26483a57e7df58e2b9fe820367e1680b9251af8d..862d3b3691c9caf84590d34960df21117848df0a 100644
> --- a/drivers/usb/common/dwc2_core.h
> +++ b/drivers/usb/common/dwc2_core.h
> @@ -7,6 +7,8 @@
>  #ifndef __DWC2_CORE_H_
>  #define __DWC2_CORE_H_
>  
> +#include <linux/bitops.h>
> +
>  struct dwc2_global_regs {
>  	u32 gotgctl;	/* 0x000 */
>  	u32 gotgint;
> @@ -123,4 +125,432 @@ struct dwc2_core_regs {
>  	u8  ep_fifo[16][0x1000];		/* 0x1000 */
>  };
>  
> +/* Core Global Register */
> +#define GOTGCTL_CHIRPEN				BIT(27)
> +#define GOTGCTL_MULT_VALID_BC_MASK		GENMASK(26, 22)
> +#define GOTGCTL_CURMODE_HOST			BIT(21)
> +#define GOTGCTL_OTGVER				BIT(20)
> +#define GOTGCTL_BSESVLD				BIT(19)
> +#define GOTGCTL_ASESVLD				BIT(18)
> +#define GOTGCTL_DBNC_SHORT			BIT(17)
> +#define GOTGCTL_CONID_B				BIT(16)
> +#define GOTGCTL_DBNCE_FLTR_BYPASS		BIT(15)
> +#define GOTGCTL_DEVHNPEN			BIT(11)
> +#define GOTGCTL_HSTSETHNPEN			BIT(10)
> +#define GOTGCTL_HNPREQ				BIT(9)
> +#define GOTGCTL_HSTNEGSCS			BIT(8)
> +#define GOTGCTL_BVALOVAL			BIT(7)
> +#define GOTGCTL_BVALOEN				BIT(6)
> +#define GOTGCTL_AVALOVAL			BIT(5)
> +#define GOTGCTL_AVALOEN				BIT(4)
> +#define GOTGCTL_VBVALOVAL			BIT(3)
> +#define GOTGCTL_VBVALOEN			BIT(2)
> +#define GOTGCTL_SESREQ				BIT(1)
> +#define GOTGCTL_SESREQSCS			BIT(0)
> +
> +#define GOTGINT_DBNCE_DONE			BIT(19)
> +#define GOTGINT_A_DEV_TOUT_CHG			BIT(18)
> +#define GOTGINT_HST_NEG_DET			BIT(17)
> +#define GOTGINT_HST_NEG_SUC_STS_CHNG		BIT(9)
> +#define GOTGINT_SES_REQ_SUC_STS_CHNG		BIT(8)
> +#define GOTGINT_SES_END_DET			BIT(2)
> +
> +#define GAHBCFG_AHB_SINGLE			BIT(23)
> +#define GAHBCFG_NOTI_ALL_DMA_WRIT		BIT(22)
> +#define GAHBCFG_REM_MEM_SUPP			BIT(21)
> +#define GAHBCFG_P_TXF_EMP_LVL			BIT(8)
> +#define GAHBCFG_NP_TXF_EMP_LVL			BIT(7)
> +#define GAHBCFG_DMA_EN				BIT(5)
> +#define GAHBCFG_HBSTLEN_MASK			GENMASK(4, 1)
> +#define GAHBCFG_HBSTLEN_SINGLE			0
> +#define GAHBCFG_HBSTLEN_INCR			1
> +#define GAHBCFG_HBSTLEN_INCR4			3
> +#define GAHBCFG_HBSTLEN_INCR8			5
> +#define GAHBCFG_HBSTLEN_INCR16			7
> +#define GAHBCFG_GLBL_INTR_EN			BIT(0)
> +#define GAHBCFG_CTRL_MASK			(GAHBCFG_P_TXF_EMP_LVL | \
> +						 GAHBCFG_NP_TXF_EMP_LVL | \
> +						 GAHBCFG_DMA_EN | \
> +						 GAHBCFG_GLBL_INTR_EN)
> +
> +#define GUSBCFG_FORCEDEVMODE			BIT(30)
> +#define GUSBCFG_FORCEHOSTMODE			BIT(29)
> +#define GUSBCFG_TXENDDELAY			BIT(28)
> +#define GUSBCFG_ICTRAFFICPULLREMOVE		BIT(27)
> +#define GUSBCFG_ICUSBCAP			BIT(26)
> +#define GUSBCFG_ULPI_INT_PROT_DIS		BIT(25)
> +#define GUSBCFG_INDICATORPASSTHROUGH		BIT(24)
> +#define GUSBCFG_INDICATORCOMPLEMENT		BIT(23)
> +#define GUSBCFG_TERMSELDLPULSE			BIT(22)
> +#define GUSBCFG_ULPI_INT_VBUS_IND		BIT(21)
> +#define GUSBCFG_ULPI_EXT_VBUS_DRV		BIT(20)
> +#define GUSBCFG_ULPI_CLK_SUSP_M			BIT(19)
> +#define GUSBCFG_ULPI_AUTO_RES			BIT(18)
> +#define GUSBCFG_ULPI_FS_LS			BIT(17)
> +#define GUSBCFG_OTG_UTMI_FS_SEL			BIT(16)
> +#define GUSBCFG_PHY_LP_CLK_SEL			BIT(15)
> +#define GUSBCFG_USBTRDTIM_MASK			GENMASK(14, 10)
> +#define GUSBCFG_HNPCAP				BIT(9)
> +#define GUSBCFG_SRPCAP				BIT(8)
> +#define GUSBCFG_DDRSEL				BIT(7)
> +#define GUSBCFG_PHYSEL				BIT(6)
> +#define GUSBCFG_FSINTF				BIT(5)
> +#define GUSBCFG_ULPI_UTMI_SEL			BIT(4)
> +#define GUSBCFG_PHYIF16				BIT(3)
> +#define GUSBCFG_TOUTCAL_MASK			GENMASK(2, 0)
> +
> +#define GRSTCTL_AHBIDLE				BIT(31)
> +#define GRSTCTL_DMAREQ				BIT(30)
> +#define GRSTCTL_CSFTRST_DONE			BIT(29)
> +#define GRSTCTL_TXFNUM_MASK			GENMASK(10, 6)
> +#define GRSTCTL_TXFFLSH				BIT(5)
> +#define GRSTCTL_RXFFLSH				BIT(4)
> +#define GRSTCTL_IN_TKNQ_FLSH			BIT(3)
> +#define GRSTCTL_FRMCNTRRST			BIT(2)
> +#define GRSTCTL_HSFTRST				BIT(1)
> +#define GRSTCTL_CSFTRST				BIT(0)
> +#define GRSTCTL_TXFNUM_ALL			0x10
> +
> +#define GINTSTS_WKUPINT				BIT(31)
> +#define GINTSTS_SESSREQINT			BIT(30)
> +#define GINTSTS_DISCONNINT			BIT(29)
> +#define GINTSTS_CONIDSTSCHNG			BIT(28)
> +#define GINTSTS_LPMTRANRCVD			BIT(27)
> +#define GINTSTS_PTXFEMP				BIT(26)
> +#define GINTSTS_HCHINT				BIT(25)
> +#define GINTSTS_PRTINT				BIT(24)
> +#define GINTSTS_RESETDET			BIT(23)
> +#define GINTSTS_FET_SUSP			BIT(22)
> +#define GINTSTS_INCOMPL_IP			BIT(21)
> +#define GINTSTS_INCOMPL_SOOUT			BIT(21)
> +#define GINTSTS_INCOMPL_SOIN			BIT(20)
> +#define GINTSTS_OEPINT				BIT(19)
> +#define GINTSTS_IEPINT				BIT(18)
> +#define GINTSTS_EPMIS				BIT(17)
> +#define GINTSTS_RESTOREDONE			BIT(16)
> +#define GINTSTS_EOPF				BIT(15)
> +#define GINTSTS_ISOUTDROP			BIT(14)
> +#define GINTSTS_ENUMDONE			BIT(13)
> +#define GINTSTS_USBRST				BIT(12)
> +#define GINTSTS_USBSUSP				BIT(11)
> +#define GINTSTS_ERLYSUSP			BIT(10)
> +#define GINTSTS_I2CINT				BIT(9)
> +#define GINTSTS_ULPI_CK_INT			BIT(8)
> +#define GINTSTS_GOUTNAKEFF			BIT(7)
> +#define GINTSTS_GINNAKEFF			BIT(6)
> +#define GINTSTS_NPTXFEMP			BIT(5)
> +#define GINTSTS_RXFLVL				BIT(4)
> +#define GINTSTS_SOF				BIT(3)
> +#define GINTSTS_OTGINT				BIT(2)
> +#define GINTSTS_MODEMIS				BIT(1)
> +#define GINTSTS_CURMODE_HOST			BIT(0)
> +
> +#define GRXSTS_FN_MASK				GENMASK(31, 25)
> +#define GRXSTS_PKTSTS_MASK			GENMASK(20, 17)
> +#define GRXSTS_PKTSTS_GLOBALOUTNAK		1
> +#define GRXSTS_PKTSTS_OUTRX			2
> +#define GRXSTS_PKTSTS_HCHIN			2
> +#define GRXSTS_PKTSTS_OUTDONE			3
> +#define GRXSTS_PKTSTS_HCHIN_XFER_COMP		3
> +#define GRXSTS_PKTSTS_SETUPDONE			4
> +#define GRXSTS_PKTSTS_DATATOGGLEERR		5
> +#define GRXSTS_PKTSTS_SETUPRX			6
> +#define GRXSTS_PKTSTS_HCHHALTED			7
> +#define GRXSTS_DPID_MASK			GENMASK(16, 15)
> +#define GRXSTS_BYTECNT_MASK			GENMASK(14, 4)
> +#define GRXSTS_HCHNUM_MASK			GENMASK(3, 0)
> +
> +#define GRXFSIZ_DEPTH_MASK			GENMASK(15, 0)
> +
> +#define GI2CCTL_BSYDNE				BIT(31)
> +#define GI2CCTL_RW				BIT(30)
> +#define GI2CCTL_I2CDATSE0			BIT(28)
> +#define GI2CCTL_I2CDEVADDR_MASK			GENMASK(27, 26)
> +#define GI2CCTL_I2CSUSPCTL			BIT(25)
> +#define GI2CCTL_ACK				BIT(24)
> +#define GI2CCTL_I2CEN				BIT(23)
> +#define GI2CCTL_ADDR_MASK			GENMASK(22, 16)
> +#define GI2CCTL_REGADDR_MASK			GENMASK(15, 8)
> +#define GI2CCTL_RWDATA_MASK			GENMASK(7, 0)
> +
> +#define GGPIO_STM32_OTG_GCCFG_IDEN		BIT(22)
> +#define GGPIO_STM32_OTG_GCCFG_VBDEN		BIT(21)
> +#define GGPIO_STM32_OTG_GCCFG_PWRDWN		BIT(16)
> +
> +#define GSNPSID_ID_MASK				GENMASK(31, 16)
> +#define GSNPSID_OTG_ID				0x4f54
> +#define GSNPSID_VER_MASK			GENMASK(15, 0)
> +
> +#define GHWCFG2_OTG_ENABLE_IC_USB		BIT(31)
> +#define GHWCFG2_DEV_TOKEN_Q_DEPTH_MASK		GENMASK(30, 26)
> +#define GHWCFG2_HOST_PERIO_TX_Q_DEPTH_MASK	GENMASK(25, 24)
> +#define GHWCFG2_NONPERIO_TX_Q_DEPTH_MASK	GENMASK(23, 22)
> +#define GHWCFG2_MULTI_PROC_INT			BIT(20)
> +#define GHWCFG2_DYNAMIC_FIFO			BIT(19)
> +#define GHWCFG2_PERIO_EP_SUPPORTED		BIT(18)
> +#define GHWCFG2_NUM_HOST_CHAN_MASK		GENMASK(17, 14)
> +#define GHWCFG2_NUM_DEV_EP_MASK			GENMASK(13, 10)
> +#define GHWCFG2_FS_PHY_TYPE_MASK		GENMASK(9, 8)
> +#define GHWCFG2_FS_PHY_TYPE_NOT_SUPPORTED	0
> +#define GHWCFG2_FS_PHY_TYPE_DEDICATED		1
> +#define GHWCFG2_FS_PHY_TYPE_SHARED_UTMI		2
> +#define GHWCFG2_FS_PHY_TYPE_SHARED_ULPI		3
> +#define GHWCFG2_HS_PHY_TYPE_MASK		GENMASK(7, 6)
> +#define GHWCFG2_HS_PHY_TYPE_NOT_SUPPORTED	0
> +#define GHWCFG2_HS_PHY_TYPE_UTMI		1
> +#define GHWCFG2_HS_PHY_TYPE_ULPI		2
> +#define GHWCFG2_HS_PHY_TYPE_UTMI_ULPI		3
> +#define GHWCFG2_POINT2POINT			BIT(5)
> +#define GHWCFG2_ARCHITECTURE_MASK		GENMASK(4, 3)
> +#define GHWCFG2_SLAVE_ONLY_ARCH			0
> +#define GHWCFG2_EXT_DMA_ARCH			1
> +#define GHWCFG2_INT_DMA_ARCH			2
> +#define GHWCFG2_OP_MODE_MASK			GENMASK(2, 0)
> +#define GHWCFG2_OP_MODE_HNP_SRP_CAPABLE		0
> +#define GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE	1
> +#define GHWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE	2
> +#define GHWCFG2_OP_MODE_SRP_CAPABLE_DEVICE	3
> +#define GHWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE	4
> +#define GHWCFG2_OP_MODE_SRP_CAPABLE_HOST	5
> +#define GHWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST	6
> +#define GHWCFG2_OP_MODE_UNDEFINED		7
> +
> +#define GHWCFG4_DESC_DMA_DYN			BIT(31)
> +#define GHWCFG4_DESC_DMA			BIT(30)
> +#define GHWCFG4_NUM_IN_EPS_MASK			GENMASK(29, 26)
> +#define GHWCFG4_DED_FIFO_EN			BIT(25)
> +#define GHWCFG4_SESSION_END_FILT_EN		BIT(24)
> +#define GHWCFG4_B_VALID_FILT_EN			BIT(23)
> +#define GHWCFG4_A_VALID_FILT_EN			BIT(22)
> +#define GHWCFG4_VBUS_VALID_FILT_EN		BIT(21)
> +#define GHWCFG4_IDDIG_FILT_EN			BIT(20)
> +#define GHWCFG4_NUM_DEV_MODE_CTRL_EP_MASK	GENMASK(19, 16)
> +#define GHWCFG4_UTMI_PHY_DATA_WIDTH_MASK	GENMASK(15, 14)
> +#define GHWCFG4_UTMI_PHY_DATA_WIDTH_8		0
> +#define GHWCFG4_UTMI_PHY_DATA_WIDTH_16		1
> +#define GHWCFG4_UTMI_PHY_DATA_WIDTH_8_OR_16	2
> +#define GHWCFG4_ACG_SUPPORTED			BIT(12)
> +#define GHWCFG4_IPG_ISOC_SUPPORTED		BIT(11)
> +#define GHWCFG4_SERVICE_INTERVAL_SUPPORTED      BIT(10)
> +#define GHWCFG4_XHIBER				BIT(7)
> +#define GHWCFG4_HIBER				BIT(6)
> +#define GHWCFG4_MIN_AHB_FREQ			BIT(5)
> +#define GHWCFG4_POWER_OPTIMIZ			BIT(4)
> +#define GHWCFG4_NUM_DEV_PERIO_IN_EP_MASK	GENMASK(3, 0)
> +
> +#define FIFOSIZE_DEPTH_MASK			GENMASK(31, 16)
> +#define FIFOSIZE_STARTADDR_MASK			GENMASK(15, 0)
> +
> +/* Host Register */
> +#define HCFG_MODECHTIMEN			BIT(31)
> +#define HCFG_PERSCHEDENA			BIT(26)
> +#define HCFG_FRLISTEN_MASK			GENMASK(25, 24)
> +#define HCFG_FRLISTEN_8				0
> +#define HCFG_FRLISTEN_16			1
> +#define HCFG_FRLISTEN_32			2
> +#define HCFG_FRLISTEN_64			3
> +#define HCFG_DESCDMA				BIT(23)
> +#define HCFG_RESVALID_MASK			GENMASK(15, 8)
> +#define HCFG_ENA32KHZ				BIT(7)
> +#define HCFG_FSLSSUPP				BIT(2)
> +#define HCFG_FSLSPCLKSEL_MASK			GENMASK(2, 0)
> +#define HCFG_FSLSPCLKSEL_30_60_MHZ		0
> +#define HCFG_FSLSPCLKSEL_48_MHZ			1
> +#define HCFG_FSLSPCLKSEL_6_MHZ			2
> +
> +#define HFNUM_FRREM_MASK			GENMASK(31, 16)
> +#define HFNUM_FRNUM_MASK			GENMASK(15, 0)
> +
> +#define HPRT0_SPD_MASK				GENMASK(18, 17)
> +#define HPRT0_SPD_HIGH_SPEED			0
> +#define HPRT0_SPD_FULL_SPEED			1
> +#define HPRT0_SPD_LOW_SPEED			2
> +#define HPRT0_TSTCTL_MASK			GENMASK(16, 13)
> +#define HPRT0_PWR				BIT(12)
> +#define HPRT0_LNSTS_MASK			GENMASK(11, 10)
> +#define HPRT0_RST				BIT(8)
> +#define HPRT0_SUSP				BIT(7)
> +#define HPRT0_RES				BIT(6)
> +#define HPRT0_OVRCURRCHG			BIT(5)
> +#define HPRT0_OVRCURRACT			BIT(4)
> +#define HPRT0_ENACHG				BIT(3)
> +#define HPRT0_ENA				BIT(2)
> +#define HPRT0_CONNDET				BIT(1)
> +#define HPRT0_CONNSTS				BIT(0)
> +#define HPRT0_W1C_MASK				(HPRT0_CONNDET | \
> +						 HPRT0_ENA | \
> +						 HPRT0_ENACHG | \
> +						 HPRT0_OVRCURRCHG)
> +
> +#define HCCHAR_CHENA				BIT(31)
> +#define HCCHAR_CHDIS				BIT(30)
> +#define HCCHAR_ODDFRM				BIT(29)
> +#define HCCHAR_DEVADDR_MASK			GENMASK(28, 22)
> +#define HCCHAR_MULTICNT_MASK			GENMASK(21, 20)
> +#define HCCHAR_EPTYPE_MASK			GENMASK(19, 18)
> +#define HCCHAR_EPTYPE_CONTROL			0
> +#define HCCHAR_EPTYPE_ISOC			1
> +#define HCCHAR_EPTYPE_BULK			2
> +#define HCCHAR_EPTYPE_INTR			3
> +#define HCCHAR_LSPDDEV				BIT(17)
> +#define HCCHAR_EPDIR				BIT(15)
> +#define HCCHAR_EPNUM_MASK			GENMASK(14, 11)
> +#define HCCHAR_MPS_MASK				GENMASK(10, 0)
> +
> +#define HCSPLT_SPLTENA				BIT(31)
> +#define HCSPLT_COMPSPLT				BIT(16)
> +#define HCSPLT_XACTPOS_MASK			GENMASK(15, 14)
> +#define HCSPLT_XACTPOS_MID			0
> +#define HCSPLT_XACTPOS_END			1
> +#define HCSPLT_XACTPOS_BEGIN			2
> +#define HCSPLT_XACTPOS_ALL			3
> +#define HCSPLT_HUBADDR_MASK			GENMASK(13, 7)
> +#define HCSPLT_PRTADDR_MASK			GENMASK(6, 0)
> +
> +#define HCINTMSK_FRM_LIST_ROLL			BIT(13)
> +#define HCINTMSK_XCS_XACT			BIT(12)
> +#define HCINTMSK_BNA				BIT(11)
> +#define HCINTMSK_DATATGLERR			BIT(10)
> +#define HCINTMSK_FRMOVRUN			BIT(9)
> +#define HCINTMSK_BBLERR				BIT(8)
> +#define HCINTMSK_XACTERR			BIT(7)
> +#define HCINTMSK_NYET				BIT(6)
> +#define HCINTMSK_ACK				BIT(5)
> +#define HCINTMSK_NAK				BIT(4)
> +#define HCINTMSK_STALL				BIT(3)
> +#define HCINTMSK_AHBERR				BIT(2)
> +#define HCINTMSK_CHHLTD				BIT(1)
> +#define HCINTMSK_XFERCOMPL			BIT(0)
> +
> +#define TSIZ_DOPNG				BIT(31)
> +#define TSIZ_SC_MC_PID_MASK			GENMASK(30, 29)
> +#define TSIZ_SC_MC_PID_DATA0			0
> +#define TSIZ_SC_MC_PID_DATA2			1
> +#define TSIZ_SC_MC_PID_DATA1			2
> +#define TSIZ_SC_MC_PID_MDATA			3
> +#define TSIZ_SC_MC_PID_SETUP			3
> +#define TSIZ_PKTCNT_MASK			GENMASK(28, 19)
> +#define TSIZ_NTD_MASK				GENMASK(15, 8)
> +#define TSIZ_SCHINFO_MASK			GENMASK(7, 0)
> +#define TSIZ_XFERSIZE_MASK			GENMASK(18, 0)
> +
> +/* Device Mode Register */
> +#define DCFG_DESCDMA_EN				BIT(23)
> +#define DCFG_EPMISCNT_MASK			GENMASK(22, 18)
> +#define DCFG_IPG_ISOC_SUPPORDED			BIT(17)
> +#define DCFG_PERFRINT_MASK			GENMASK(12, 11)
> +#define DCFG_DEVADDR_MASK			GENMASK(10, 4)
> +#define DCFG_NZ_STS_OUT_HSHK			BIT(2)
> +#define DCFG_DEVSPD_MASK			GENMASK(1, 0)
> +#define DCFG_DEVSPD_HS				0
> +#define DCFG_DEVSPD_FS				1
> +#define DCFG_DEVSPD_LS				2
> +#define DCFG_DEVSPD_FS48			3
> +
> +#define DCTL_SERVICE_INTERVAL_SUPPORTED		BIT(19)
> +#define DCTL_PWRONPRGDONE			BIT(11)
> +#define DCTL_CGOUTNAK				BIT(10)
> +#define DCTL_SGOUTNAK				BIT(9)
> +#define DCTL_CGNPINNAK				BIT(8)
> +#define DCTL_SGNPINNAK				BIT(7)
> +#define DCTL_TSTCTL_MASK			GENMASK(6, 4)
> +#define DCTL_GOUTNAKSTS				BIT(3)
> +#define DCTL_GNPINNAKSTS			BIT(2)
> +#define DCTL_SFTDISCON				BIT(1)
> +#define DCTL_RMTWKUPSIG				BIT(0)
> +
> +#define DSTS_SOFFN_MASK				GENMASK(21, 8)
> +#define DSTS_ERRATICERR				BIT(3)
> +#define DSTS_ENUMSPD_MASK			GENMASK(2, 1)
> +#define DSTS_ENUMSPD_HS				0
> +#define DSTS_ENUMSPD_FS				1
> +#define DSTS_ENUMSPD_LS				2
> +#define DSTS_ENUMSPD_FS48			3
> +#define DSTS_SUSPSTS				BIT(0)
> +
> +#define DIEPMSK_NAKMSK				BIT(13)
> +#define DIEPMSK_BNAININTRMSK			BIT(9)
> +#define DIEPMSK_TXFIFOUNDRNMSK			BIT(8)
> +#define DIEPMSK_TXFIFOEMPTY			BIT(7)
> +#define DIEPMSK_INEPNAKEFFMSK			BIT(6)
> +#define DIEPMSK_INTKNEPMISMSK			BIT(5)
> +#define DIEPMSK_INTKNTXFEMPMSK			BIT(4)
> +#define DIEPMSK_TIMEOUTMSK			BIT(3)
> +#define DIEPMSK_AHBERRMSK			BIT(2)
> +#define DIEPMSK_EPDISBLDMSK			BIT(1)
> +#define DIEPMSK_XFERCOMPLMSK			BIT(0)
> +
> +#define DOEPMSK_BNAMSK				BIT(9)
> +#define DOEPMSK_BACK2BACKSETUP			BIT(6)
> +#define DOEPMSK_STSPHSERCVDMSK			BIT(5)
> +#define DOEPMSK_OUTTKNEPDISMSK			BIT(4)
> +#define DOEPMSK_SETUPMSK			BIT(3)
> +#define DOEPMSK_AHBERRMSK			BIT(2)
> +#define DOEPMSK_EPDISBLDMSK			BIT(1)
> +#define DOEPMSK_XFERCOMPLMSK			BIT(0)
> +
> +#define DAINT_OUTEP_MASK			GENMASK(31, 16)
> +#define DAINT_INEP_MASK				GENMASK(15, 0)
> +
> +#define D0EPCTL_MPS_MASK			GENMASK(1, 0)
> +#define D0EPCTL_MPS_64				0
> +#define D0EPCTL_MPS_32				1
> +#define D0EPCTL_MPS_16				2
> +#define D0EPCTL_MPS_8				3
> +
> +#define DXEPCTL_EPENA				BIT(31)
> +#define DXEPCTL_EPDIS				BIT(30)
> +#define DXEPCTL_SETD1PID			BIT(29)
> +#define DXEPCTL_SETODDFR			BIT(29)
> +#define DXEPCTL_SETD0PID			BIT(28)
> +#define DXEPCTL_SETEVENFR			BIT(28)
> +#define DXEPCTL_SNAK				BIT(27)
> +#define DXEPCTL_CNAK				BIT(26)
> +#define DXEPCTL_TXFNUM_MASK			GENMASK(25, 22)
> +#define DXEPCTL_STALL				BIT(21)
> +#define DXEPCTL_SNP				BIT(20)
> +#define DXEPCTL_EPTYPE_MASK			GENMASK(19, 18)
> +#define DXEPCTL_EPTYPE_CONTROL			0
> +#define DXEPCTL_EPTYPE_ISO			1
> +#define DXEPCTL_EPTYPE_BULK			2
> +#define DXEPCTL_EPTYPE_INTERRUPT		3
> +#define DXEPCTL_NAKSTS				BIT(17)
> +#define DXEPCTL_DPID				BIT(16)
> +#define DXEPCTL_EOFRNUM				BIT(16)
> +#define DXEPCTL_USBACTEP			BIT(15)
> +#define DXEPCTL_NEXTEP_MASK			GENMASK(14, 11)
> +#define DXEPCTL_MPS_MASK			GENMASK(10, 0)
> +
> +#define DXEPINT_SETUP_RCVD			BIT(15)
> +#define DXEPINT_NYETINTRPT			BIT(14)
> +#define DXEPINT_NAKINTRPT			BIT(13)
> +#define DXEPINT_BBLEERRINTRPT			BIT(12)
> +#define DXEPINT_PKTDRPSTS			BIT(11)
> +#define DXEPINT_BNAINTR				BIT(9)
> +#define DXEPINT_TXFIFOUNDRN			BIT(8)
> +#define DXEPINT_OUTPKTERR			BIT(8)
> +#define DXEPINT_TXFEMP				BIT(7)
> +#define DXEPINT_INEPNAKEFF			BIT(6)
> +#define DXEPINT_BACK2BACKSETUP			BIT(6)
> +#define DXEPINT_INTKNEPMIS			BIT(5)
> +#define DXEPINT_STSPHSERCVD			BIT(5)
> +#define DXEPINT_INTKNTXFEMP			BIT(4)
> +#define DXEPINT_OUTTKNEPDIS			BIT(4)
> +#define DXEPINT_TIMEOUT				BIT(3)
> +#define DXEPINT_SETUP				BIT(3)
> +#define DXEPINT_AHBERR				BIT(2)
> +#define DXEPINT_EPDISBLD			BIT(1)
> +#define DXEPINT_XFERCOMPL			BIT(0)
> +
> +#define DIEPTSIZ0_PKTCNT_MASK			GENMASK(20, 19)
> +#define DIEPTSIZ0_XFERSIZE_MASK			GENMASK(6, 0)
> +
> +#define DOEPTSIZ0_SUPCNT_MASK			GENMASK(30, 29)
> +#define DOEPTSIZ0_PKTCNT			BIT(19)
> +#define DOEPTSIZ0_XFERSIZE_MASK			GENMASK(6, 0)
> +
> +#define DXEPTSIZ_MC_MASK			GENMASK(30, 29)
> +#define DXEPTSIZ_PKTCNT_MASK			GENMASK(28, 19)
> +#define DXEPTSIZ_XFERSIZE_MASK			GENMASK(18, 0)
> +
>  #endif /* __DWC2_CORE_H_ */
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/dwc2_udc_otg_regs.h
> index 6aec55970db682ef8a21fad0b47144a4a87a47ca..5dd2d3a45bf90eb09bd681bca14df7bc3e3f9a78 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
> +++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
> @@ -10,7 +10,7 @@
>  #ifndef __ASM_ARCH_REGS_USB_OTG_HS_H
>  #define __ASM_ARCH_REGS_USB_OTG_HS_H
>  
> -#include <linux/bitops.h>
> +#include "../common/dwc2_core.h"
>  
>  struct dwc2_usbotg_phy {
>  	u32 phypwr;
> @@ -18,58 +18,6 @@ struct dwc2_usbotg_phy {
>  	u32 rstcon;
>  };
>  
> -/*===================================================================== */
> -/*definitions related to CSR setting */
> -
> -/* DWC2_UDC_OTG_GOTGCTL */
> -#define GOTGCTL_BSESVLD			BIT(19)
> -#define GOTGCTL_ASESVLD			BIT(18)
> -#define GOTGCTL_BVALOVAL		BIT(7)
> -#define GOTGCTL_BVALOEN			BIT(6)
> -#define GOTGCTL_AVALOVAL		BIT(5)
> -#define GOTGCTL_AVALOEN			BIT(4)
> -#define GOTGCTL_VBVALOVAL		BIT(3)
> -#define GOTGCTL_VBVALOEN		BIT(2)
> -
> -/* DWC2_UDC_OTG_GOTINT */
> -#define GOTGINT_SES_END_DET		BIT(2)
> -
> -/* DWC2_UDC_OTG_GAHBCFG */
> -#define GAHBCFG_AHB_SINGLE		BIT(23)
> -#define GAHBCFG_NOTI_ALL_DMA_WRIT	BIT(22)
> -#define GAHBCFG_REM_MEM_SUPP		BIT(21)
> -#define GAHBCFG_P_TXF_EMP_LVL		BIT(8)
> -#define GAHBCFG_NP_TXF_EMP_LVL		BIT(7)
> -#define GAHBCFG_DMA_EN			BIT(5)
> -#define GAHBCFG_HBSTLEN_MASK		GENMASK(4, 1)
> -#define GAHBCFG_HBSTLEN_SINGLE		0
> -#define GAHBCFG_HBSTLEN_INCR		1
> -#define GAHBCFG_HBSTLEN_INCR4		3
> -#define GAHBCFG_HBSTLEN_INCR8		5
> -#define GAHBCFG_HBSTLEN_INCR16		7
> -#define GAHBCFG_GLBL_INTR_EN		BIT(0)
> -
> -/* DWC2_UDC_OTG_GRSTCTL */
> -#define GRSTCTL_AHBIDLE			BIT(31)
> -#define GRSTCTL_CSFTRST			BIT(0)
> -
> -/* DWC2_UDC_OTG_GINTSTS/DWC2_UDC_OTG_GINTMSK core interrupt register */
> -#define GINTSTS_WKUPINT			BIT(31)
> -#define GINTSTS_DISCONNINT		BIT(29)
> -#define GINTSTS_CONIDSTSCHNG		BIT(28)
> -#define GINTSTS_OEPINT			BIT(19)
> -#define GINTSTS_IEPINT			BIT(18)
> -#define GINTSTS_ENUMDONE		BIT(13)
> -#define GINTSTS_USBRST			BIT(12)
> -#define GINTSTS_USBSUSP			BIT(11)
> -#define GINTSTS_ERLYSUSP		BIT(10)
> -#define GINTSTS_NPTXFEMP		BIT(5)
> -#define GINTSTS_RXFLVL			BIT(4)
> -#define GINTSTS_SOF			BIT(3)
> -#define GINTSTS_OTGINT			BIT(2)
> -#define GINTSTS_MODEMIS			BIT(1)
> -#define GINTSTS_CURMODE_HOST		BIT(0)
> -
>  #define FULL_SPEED_CONTROL_PKT_SIZE	8
>  #define FULL_SPEED_BULK_PKT_SIZE	64
>  
> @@ -80,69 +28,6 @@ struct dwc2_usbotg_phy {
>  #define NPTX_FIFO_SIZE			1024
>  #define PTX_FIFO_SIZE			384
>  
> -#define FIFOSIZE_DEPTH_MASK		GENMASK(31, 16)
> -#define FIFOSIZE_STARTADDR_MASK		GENMASK(15, 0)
> -
> -/* Enumeration speed */
> -#define DSTS_ENUMSPD_MASK		GENMASK(2, 1)
> -#define DSTS_ENUMSPD_HS			0
> -#define DSTS_ENUMSPD_FS			1
> -#define DSTS_ENUMSPD_LS			2
> -
> -/* DWC2_UDC_OTG_DCTL device control register */
> -#define DCTL_SFTDISCON			BIT(1)
> -#define DCTL_RMTWKUPSIG			BIT(0)
> -
> -/* DWC2_UDC_OTG_DAINT device all endpoint interrupt register */
> -#define DAINT_OUTEP_MASK		GENMASK(31, 16)
> -#define DAINT_INEP_MASK			GENMASK(15, 0)
> -
> -/* DWC2_UDC_OTG_DIEPCTL0/DOEPCTL0 device
> -   control IN/OUT endpoint 0 control register */
> -#define DXEPCTL_EPENA			BIT(31)
> -#define DXEPCTL_EPDIS			BIT(30)
> -#define DXEPCTL_SETD1PID		BIT(29)
> -#define DXEPCTL_SETODDFR		BIT(29)
> -#define DXEPCTL_SETD0PID		BIT(28)
> -#define DXEPCTL_SETEVENFR		BIT(28)
> -#define DXEPCTL_SNAK			BIT(27)
> -#define DXEPCTL_CNAK			BIT(26)
> -#define DXEPCTL_STALL			BIT(21)
> -#define DXEPCTL_EPTYPE_MASK		GENMASK(19, 18)
> -#define DXEPCTL_EPTYPE_CONTROL		0
> -#define DXEPCTL_EPTYPE_ISO		1
> -#define DXEPCTL_EPTYPE_BULK		2
> -#define DXEPCTL_EPTYPE_INTERRUPT	3
> -#define DXEPCTL_EOFRNUM			BIT(16)
> -#define DXEPCTL_USBACTEP		BIT(15)
> -#define DXEPCTL_NEXTEP_MASK		GENMASK(14, 11)
> -#define DXEPCTL_MPS_MASK		GENMASK(10, 0)
> -
> -
> -/* DWC2_UDC_OTG_DIEPMSK/DOEPMSK device IN/OUT endpoint
> -   common interrupt mask register */
> -/* DWC2_UDC_OTG_DIEPINTn/DOEPINTn device IN/OUT endpoint interrupt register */
> -#define DIEPMSK_NAKMSK			BIT(13)
> -#define DIEPMSK_BNAININTRMSK		BIT(9)
> -#define DIEPMSK_TXFIFOUNDRNMSK		BIT(8)
> -#define DIEPMSK_TXFIFOEMPTY		BIT(7)
> -#define DIEPMSK_INEPNAKEFFMSK		BIT(6)
> -#define DIEPMSK_INTKNEPMISMSK		BIT(5)
> -#define DIEPMSK_INTKNTXFEMPMSK		BIT(4)
> -#define DIEPMSK_TIMEOUTMSK		BIT(3)
> -#define DIEPMSK_AHBERRMSK		BIT(2)
> -#define DIEPMSK_EPDISBLDMSK		BIT(1)
> -#define DIEPMSK_XFERCOMPLMSK		BIT(0)
> -
> -#define DOEPMSK_BNAMSK			BIT(9)
> -#define DOEPMSK_BACK2BACKSETUP		BIT(6)
> -#define DOEPMSK_STSPHSERCVDMSK		BIT(5)
> -#define DOEPMSK_OUTTKNEPDISMSK		BIT(4)
> -#define DOEPMSK_SETUPMSK		BIT(3)
> -#define DOEPMSK_AHBERRMSK		BIT(2)
> -#define DOEPMSK_EPDISBLDMSK		BIT(1)
> -#define DOEPMSK_XFERCOMPLMSK		BIT(0)
> -
>  #define USB_PHY_CTRL_EN0                BIT(0)
>  
>  /* OPHYPWR */
> @@ -171,21 +56,6 @@ struct dwc2_usbotg_phy {
>  #define EXYNOS4X12_CLK_SEL_12MHZ	(0x02 << 0)
>  #define EXYNOS4X12_CLK_SEL_24MHZ	(0x05 << 0)
>  
> -/* Device Configuration Register DCFG */
> -#define DCFG_EPMISCNT_MASK		GENMASK(22, 18)
> -#define DCFG_DEVADDR_MASK		GENMASK(10, 4)
> -#define DCFG_DEVSPD_MASK		GENMASK(1, 0)
> -#define DCFG_DEVSPD_HS			0
> -#define DCFG_DEVSPD_FS			1
> -#define DCFG_DEVSPD_LS			2
> -#define DCFG_DEVSPD_FS48		3
> -
> -/* Core Reset Register (GRSTCTL) */
> -#define GRSTCTL_TXFNUM_MASK		GENMASK(10, 6)
> -#define GRSTCTL_TXFFLSH			BIT(5)
> -#define GRSTCTL_RXFFLSH			BIT(4)
> -#define GRSTCTL_TXFNUM_ALL		0x10
> -
>  /* Masks definitions */
>  #define GINTMSK_INIT	(GINTSTS_WKUPINT | GINTSTS_OEPINT | GINTSTS_IEPINT | GINTSTS_ENUMDONE | \
>  			 GINTSTS_USBRST | GINTSTS_USBSUSP | GINTSTS_OTGINT)
> @@ -195,26 +65,4 @@ struct dwc2_usbotg_phy {
>  			 FIELD_PREP(GAHBCFG_HBSTLEN_MASK, GAHBCFG_HBSTLEN_INCR4) | \
>  			 GAHBCFG_GLBL_INTR_EN)
>  
> -/* Device Endpoint X Transfer Size Register (DIEPTSIZX/DOEPTSIZX) */
> -#define DIEPTSIZ0_PKTCNT_MASK		GENMASK(20, 19)
> -#define DIEPTSIZ0_XFERSIZE_MASK		GENMASK(6, 0)
> -
> -#define DOEPTSIZ0_SUPCNT_MASK		GENMASK(30, 29)
> -#define DOEPTSIZ0_PKTCNT		BIT(19)
> -#define DOEPTSIZ0_XFERSIZE_MASK		GENMASK(6, 0)
> -
> -#define DXEPTSIZ_MC_MASK		GENMASK(30, 29)
> -#define DXEPTSIZ_PKTCNT_MASK		GENMASK(28, 19)
> -#define DXEPTSIZ_XFERSIZE_MASK		GENMASK(18, 0)
> -
> -/* Device Endpoint-N Control Register (DIEPCTLn/DOEPCTLn) */
> -#define DXEPCTL_TXFNUM_MASK		GENMASK(25, 22)
> -
> -/* User HW Config4 */
> -#define GHWCFG4_NUM_IN_EPS_MASK		GENMASK(29, 26)
> -
> -/* OTG general core configuration register (OTG_GCCFG:0x38) for STM32MP1 */
> -#define GGPIO_STM32_OTG_GCCFG_VBDEN	BIT(21)
> -#define GGPIO_STM32_OTG_GCCFG_IDEN	BIT(22)
> -
>  #endif
> diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
> index a01edc5eff3ac8ef89addff29d2df26952288ccc..f0bb29496490463458ad5d61e7902934fb638bcd 100644
> --- a/drivers/usb/host/dwc2.h
> +++ b/drivers/usb/host/dwc2.h
> @@ -6,297 +6,6 @@
>  #ifndef __DWC2_H__
>  #define __DWC2_H__
>  
> -#include <linux/bitops.h>
> -
> -#define GOTGCTL_CHIRPEN				BIT(27)
> -#define GOTGCTL_MULT_VALID_BC_MASK		GENMASK(26, 22)
> -#define GOTGCTL_CURMODE_HOST			BIT(21)
> -#define GOTGCTL_OTGVER				BIT(20)
> -#define GOTGCTL_BSESVLD				BIT(19)
> -#define GOTGCTL_ASESVLD				BIT(18)
> -#define GOTGCTL_DBNC_SHORT			BIT(17)
> -#define GOTGCTL_CONID_B				BIT(16)
> -#define GOTGCTL_DBNCE_FLTR_BYPASS		BIT(15)
> -#define GOTGCTL_DEVHNPEN			BIT(11)
> -#define GOTGCTL_HSTSETHNPEN			BIT(10)
> -#define GOTGCTL_HNPREQ				BIT(9)
> -#define GOTGCTL_HSTNEGSCS			BIT(8)
> -#define GOTGCTL_BVALOVAL			BIT(7)
> -#define GOTGCTL_BVALOEN				BIT(6)
> -#define GOTGCTL_AVALOVAL			BIT(5)
> -#define GOTGCTL_AVALOEN				BIT(4)
> -#define GOTGCTL_VBVALOVAL			BIT(3)
> -#define GOTGCTL_VBVALOEN			BIT(2)
> -#define GOTGCTL_SESREQ				BIT(1)
> -#define GOTGCTL_SESREQSCS			BIT(0)
> -
> -#define GOTGINT_DBNCE_DONE			BIT(19)
> -#define GOTGINT_A_DEV_TOUT_CHG			BIT(18)
> -#define GOTGINT_HST_NEG_DET			BIT(17)
> -#define GOTGINT_HST_NEG_SUC_STS_CHNG		BIT(9)
> -#define GOTGINT_SES_REQ_SUC_STS_CHNG		BIT(8)
> -#define GOTGINT_SES_END_DET			BIT(2)
> -
> -#define GAHBCFG_AHB_SINGLE			BIT(23)
> -#define GAHBCFG_NOTI_ALL_DMA_WRIT		BIT(22)
> -#define GAHBCFG_REM_MEM_SUPP			BIT(21)
> -#define GAHBCFG_P_TXF_EMP_LVL			BIT(8)
> -#define GAHBCFG_NP_TXF_EMP_LVL			BIT(7)
> -#define GAHBCFG_DMA_EN				BIT(5)
> -#define GAHBCFG_HBSTLEN_MASK			GENMASK(4, 1)
> -#define GAHBCFG_HBSTLEN_SINGLE			0
> -#define GAHBCFG_HBSTLEN_INCR			1
> -#define GAHBCFG_HBSTLEN_INCR4			3
> -#define GAHBCFG_HBSTLEN_INCR8			5
> -#define GAHBCFG_HBSTLEN_INCR16			7
> -#define GAHBCFG_GLBL_INTR_EN			BIT(0)
> -#define GAHBCFG_CTRL_MASK			(GAHBCFG_P_TXF_EMP_LVL | \
> -						 GAHBCFG_NP_TXF_EMP_LVL | \
> -						 GAHBCFG_DMA_EN | \
> -						 GAHBCFG_GLBL_INTR_EN)
> -
> -#define GUSBCFG_FORCEDEVMODE			BIT(30)
> -#define GUSBCFG_FORCEHOSTMODE			BIT(29)
> -#define GUSBCFG_TXENDDELAY			BIT(28)
> -#define GUSBCFG_ICTRAFFICPULLREMOVE		BIT(27)
> -#define GUSBCFG_ICUSBCAP			BIT(26)
> -#define GUSBCFG_ULPI_INT_PROT_DIS		BIT(25)
> -#define GUSBCFG_INDICATORPASSTHROUGH		BIT(24)
> -#define GUSBCFG_INDICATORCOMPLEMENT		BIT(23)
> -#define GUSBCFG_TERMSELDLPULSE			BIT(22)
> -#define GUSBCFG_ULPI_INT_VBUS_IND		BIT(21)
> -#define GUSBCFG_ULPI_EXT_VBUS_DRV		BIT(20)
> -#define GUSBCFG_ULPI_CLK_SUSP_M			BIT(19)
> -#define GUSBCFG_ULPI_AUTO_RES			BIT(18)
> -#define GUSBCFG_ULPI_FS_LS			BIT(17)
> -#define GUSBCFG_OTG_UTMI_FS_SEL			BIT(16)
> -#define GUSBCFG_PHY_LP_CLK_SEL			BIT(15)
> -#define GUSBCFG_USBTRDTIM_MASK			GENMASK(14, 10)
> -#define GUSBCFG_HNPCAP				BIT(9)
> -#define GUSBCFG_SRPCAP				BIT(8)
> -#define GUSBCFG_DDRSEL				BIT(7)
> -#define GUSBCFG_PHYSEL				BIT(6)
> -#define GUSBCFG_FSINTF				BIT(5)
> -#define GUSBCFG_ULPI_UTMI_SEL			BIT(4)
> -#define GUSBCFG_PHYIF16				BIT(3)
> -#define GUSBCFG_TOUTCAL_MASK			GENMASK(2, 0)
> -
> -#define GRSTCTL_AHBIDLE				BIT(31)
> -#define GRSTCTL_DMAREQ				BIT(30)
> -#define GRSTCTL_CSFTRST_DONE			BIT(29)
> -#define GRSTCTL_TXFNUM_MASK			GENMASK(10, 6)
> -#define GRSTCTL_TXFFLSH				BIT(5)
> -#define GRSTCTL_RXFFLSH				BIT(4)
> -#define GRSTCTL_IN_TKNQ_FLSH			BIT(3)
> -#define GRSTCTL_FRMCNTRRST			BIT(2)
> -#define GRSTCTL_HSFTRST				BIT(1)
> -#define GRSTCTL_CSFTRST				BIT(0)
> -#define GRSTCTL_TXFNUM_ALL			0x10
> -
> -#define GINTSTS_WKUPINT				BIT(31)
> -#define GINTSTS_SESSREQINT			BIT(30)
> -#define GINTSTS_DISCONNINT			BIT(29)
> -#define GINTSTS_CONIDSTSCHNG			BIT(28)
> -#define GINTSTS_LPMTRANRCVD			BIT(27)
> -#define GINTSTS_PTXFEMP				BIT(26)
> -#define GINTSTS_HCHINT				BIT(25)
> -#define GINTSTS_PRTINT				BIT(24)
> -#define GINTSTS_RESETDET			BIT(23)
> -#define GINTSTS_FET_SUSP			BIT(22)
> -#define GINTSTS_INCOMPL_IP			BIT(21)
> -#define GINTSTS_INCOMPL_SOOUT			BIT(21)
> -#define GINTSTS_INCOMPL_SOIN			BIT(20)
> -#define GINTSTS_OEPINT				BIT(19)
> -#define GINTSTS_IEPINT				BIT(18)
> -#define GINTSTS_EPMIS				BIT(17)
> -#define GINTSTS_RESTOREDONE			BIT(16)
> -#define GINTSTS_EOPF				BIT(15)
> -#define GINTSTS_ISOUTDROP			BIT(14)
> -#define GINTSTS_ENUMDONE			BIT(13)
> -#define GINTSTS_USBRST				BIT(12)
> -#define GINTSTS_USBSUSP				BIT(11)
> -#define GINTSTS_ERLYSUSP			BIT(10)
> -#define GINTSTS_I2CINT				BIT(9)
> -#define GINTSTS_ULPI_CK_INT			BIT(8)
> -#define GINTSTS_GOUTNAKEFF			BIT(7)
> -#define GINTSTS_GINNAKEFF			BIT(6)
> -#define GINTSTS_NPTXFEMP			BIT(5)
> -#define GINTSTS_RXFLVL				BIT(4)
> -#define GINTSTS_SOF				BIT(3)
> -#define GINTSTS_OTGINT				BIT(2)
> -#define GINTSTS_MODEMIS				BIT(1)
> -#define GINTSTS_CURMODE_HOST			BIT(0)
> -
> -#define FIFOSIZE_DEPTH_MASK			GENMASK(31, 16)
> -#define FIFOSIZE_STARTADDR_MASK			GENMASK(15, 0)
> -
> -#define GI2CCTL_BSYDNE				BIT(31)
> -#define GI2CCTL_RW				BIT(30)
> -#define GI2CCTL_I2CDATSE0			BIT(28)
> -#define GI2CCTL_I2CDEVADDR_MASK			GENMASK(27, 26)
> -#define GI2CCTL_I2CSUSPCTL			BIT(25)
> -#define GI2CCTL_ACK				BIT(24)
> -#define GI2CCTL_I2CEN				BIT(23)
> -#define GI2CCTL_ADDR_MASK			GENMASK(22, 16)
> -#define GI2CCTL_REGADDR_MASK			GENMASK(15, 8)
> -#define GI2CCTL_RWDATA_MASK			GENMASK(7, 0)
> -
> -#define GHWCFG2_OTG_ENABLE_IC_USB		BIT(31)
> -#define GHWCFG2_DEV_TOKEN_Q_DEPTH_MASK		GENMASK(30, 26)
> -#define GHWCFG2_HOST_PERIO_TX_Q_DEPTH_MASK	GENMASK(25, 24)
> -#define GHWCFG2_NONPERIO_TX_Q_DEPTH_MASK	GENMASK(23, 22)
> -#define GHWCFG2_MULTI_PROC_INT			BIT(20)
> -#define GHWCFG2_DYNAMIC_FIFO			BIT(19)
> -#define GHWCFG2_PERIO_EP_SUPPORTED		BIT(18)
> -#define GHWCFG2_NUM_HOST_CHAN_MASK		GENMASK(17, 14)
> -#define GHWCFG2_NUM_DEV_EP_MASK			GENMASK(13, 10)
> -#define GHWCFG2_FS_PHY_TYPE_MASK		GENMASK(9, 8)
> -#define GHWCFG2_FS_PHY_TYPE_NOT_SUPPORTED	0
> -#define GHWCFG2_FS_PHY_TYPE_DEDICATED		1
> -#define GHWCFG2_FS_PHY_TYPE_SHARED_UTMI		2
> -#define GHWCFG2_FS_PHY_TYPE_SHARED_ULPI		3
> -#define GHWCFG2_HS_PHY_TYPE_MASK		GENMASK(7, 6)
> -#define GHWCFG2_HS_PHY_TYPE_NOT_SUPPORTED	0
> -#define GHWCFG2_HS_PHY_TYPE_UTMI		1
> -#define GHWCFG2_HS_PHY_TYPE_ULPI		2
> -#define GHWCFG2_HS_PHY_TYPE_UTMI_ULPI		3
> -#define GHWCFG2_POINT2POINT			BIT(5)
> -#define GHWCFG2_ARCHITECTURE_MASK		GENMASK(4, 3)
> -#define GHWCFG2_SLAVE_ONLY_ARCH			0
> -#define GHWCFG2_EXT_DMA_ARCH			1
> -#define GHWCFG2_INT_DMA_ARCH			2
> -#define GHWCFG2_OP_MODE_MASK			GENMASK(2, 0)
> -#define GHWCFG2_OP_MODE_HNP_SRP_CAPABLE		0
> -#define GHWCFG2_OP_MODE_SRP_ONLY_CAPABLE	1
> -#define GHWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE	2
> -#define GHWCFG2_OP_MODE_SRP_CAPABLE_DEVICE	3
> -#define GHWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE	4
> -#define GHWCFG2_OP_MODE_SRP_CAPABLE_HOST	5
> -#define GHWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST	6
> -#define GHWCFG2_OP_MODE_UNDEFINED		7
> -
> -#define GHWCFG4_DESC_DMA_DYN			BIT(31)
> -#define GHWCFG4_DESC_DMA			BIT(30)
> -#define GHWCFG4_NUM_IN_EPS_MASK			GENMASK(29, 26)
> -#define GHWCFG4_DED_FIFO_EN			BIT(25)
> -#define GHWCFG4_SESSION_END_FILT_EN		BIT(24)
> -#define GHWCFG4_B_VALID_FILT_EN			BIT(23)
> -#define GHWCFG4_A_VALID_FILT_EN			BIT(22)
> -#define GHWCFG4_VBUS_VALID_FILT_EN		BIT(21)
> -#define GHWCFG4_IDDIG_FILT_EN			BIT(20)
> -#define GHWCFG4_NUM_DEV_MODE_CTRL_EP_MASK	GENMASK(19, 16)
> -#define GHWCFG4_UTMI_PHY_DATA_WIDTH_MASK	GENMASK(15, 14)
> -#define GHWCFG4_UTMI_PHY_DATA_WIDTH_8		0
> -#define GHWCFG4_UTMI_PHY_DATA_WIDTH_16		1
> -#define GHWCFG4_UTMI_PHY_DATA_WIDTH_8_OR_16	2
> -#define GHWCFG4_ACG_SUPPORTED			BIT(12)
> -#define GHWCFG4_IPG_ISOC_SUPPORTED		BIT(11)
> -#define GHWCFG4_SERVICE_INTERVAL_SUPPORTED      BIT(10)
> -#define GHWCFG4_XHIBER				BIT(7)
> -#define GHWCFG4_HIBER				BIT(6)
> -#define GHWCFG4_MIN_AHB_FREQ			BIT(5)
> -#define GHWCFG4_POWER_OPTIMIZ			BIT(4)
> -#define GHWCFG4_NUM_DEV_PERIO_IN_EP_MASK	GENMASK(3, 0)
> -
> -#define HCFG_MODECHTIMEN			BIT(31)
> -#define HCFG_PERSCHEDENA			BIT(26)
> -#define HCFG_FRLISTEN_MASK			GENMASK(25, 24)
> -#define HCFG_FRLISTEN_8				0
> -#define HCFG_FRLISTEN_16			1
> -#define HCFG_FRLISTEN_32			2
> -#define HCFG_FRLISTEN_64			3
> -#define HCFG_DESCDMA				BIT(23)
> -#define HCFG_RESVALID_MASK			GENMASK(15, 8)
> -#define HCFG_ENA32KHZ				BIT(7)
> -#define HCFG_FSLSSUPP				BIT(2)
> -#define HCFG_FSLSPCLKSEL_MASK			GENMASK(2, 0)
> -#define HCFG_FSLSPCLKSEL_30_60_MHZ		0
> -#define HCFG_FSLSPCLKSEL_48_MHZ			1
> -#define HCFG_FSLSPCLKSEL_6_MHZ			2
> -
> -#define HFIR_FRINT_MASK				GENMASK(15, 0)
> -#define HFIR_RLDCTRL				BIT(16)
> -
> -#define HFNUM_FRREM_MASK			GENMASK(31, 16)
> -#define HFNUM_FRNUM_MASK			GENMASK(15, 0)
> -
> -#define HPRT0_SPD_MASK				GENMASK(18, 17)
> -#define HPRT0_SPD_HIGH_SPEED			0
> -#define HPRT0_SPD_FULL_SPEED			1
> -#define HPRT0_SPD_LOW_SPEED			2
> -#define HPRT0_TSTCTL_MASK			GENMASK(16, 13)
> -#define HPRT0_PWR				BIT(12)
> -#define HPRT0_LNSTS_MASK			GENMASK(11, 10)
> -#define HPRT0_RST				BIT(8)
> -#define HPRT0_SUSP				BIT(7)
> -#define HPRT0_RES				BIT(6)
> -#define HPRT0_OVRCURRCHG			BIT(5)
> -#define HPRT0_OVRCURRACT			BIT(4)
> -#define HPRT0_ENACHG				BIT(3)
> -#define HPRT0_ENA				BIT(2)
> -#define HPRT0_CONNDET				BIT(1)
> -#define HPRT0_CONNSTS				BIT(0)
> -#define HPRT0_W1C_MASK				(HPRT0_CONNDET | \
> -						 HPRT0_ENA | \
> -						 HPRT0_ENACHG | \
> -						 HPRT0_OVRCURRCHG)
> -
> -#define HCCHAR_CHENA				BIT(31)
> -#define HCCHAR_CHDIS				BIT(30)
> -#define HCCHAR_ODDFRM				BIT(29)
> -#define HCCHAR_DEVADDR_MASK			GENMASK(28, 22)
> -#define HCCHAR_MULTICNT_MASK			GENMASK(21, 20)
> -#define HCCHAR_EPTYPE_MASK			GENMASK(19, 18)
> -#define HCCHAR_EPTYPE_CONTROL			0
> -#define HCCHAR_EPTYPE_ISOC			1
> -#define HCCHAR_EPTYPE_BULK			2
> -#define HCCHAR_EPTYPE_INTR			3
> -#define HCCHAR_LSPDDEV				BIT(17)
> -#define HCCHAR_EPDIR				BIT(15)
> -#define HCCHAR_EPNUM_MASK			GENMASK(14, 11)
> -#define HCCHAR_MPS_MASK				GENMASK(10, 0)
> -
> -#define HCSPLT_SPLTENA				BIT(31)
> -#define HCSPLT_COMPSPLT				BIT(16)
> -#define HCSPLT_XACTPOS_MASK			GENMASK(15, 14)
> -#define HCSPLT_XACTPOS_MID			0
> -#define HCSPLT_XACTPOS_END			1
> -#define HCSPLT_XACTPOS_BEGIN			2
> -#define HCSPLT_XACTPOS_ALL			3
> -#define HCSPLT_HUBADDR_MASK			GENMASK(13, 7)
> -#define HCSPLT_PRTADDR_MASK			GENMASK(6, 0)
> -
> -#define HCINTMSK_FRM_LIST_ROLL			BIT(13)
> -#define HCINTMSK_XCS_XACT			BIT(12)
> -#define HCINTMSK_BNA				BIT(11)
> -#define HCINTMSK_DATATGLERR			BIT(10)
> -#define HCINTMSK_FRMOVRUN			BIT(9)
> -#define HCINTMSK_BBLERR				BIT(8)
> -#define HCINTMSK_XACTERR			BIT(7)
> -#define HCINTMSK_NYET				BIT(6)
> -#define HCINTMSK_ACK				BIT(5)
> -#define HCINTMSK_NAK				BIT(4)
> -#define HCINTMSK_STALL				BIT(3)
> -#define HCINTMSK_AHBERR				BIT(2)
> -#define HCINTMSK_CHHLTD				BIT(1)
> -#define HCINTMSK_XFERCOMPL			BIT(0)
> -
> -#define TSIZ_DOPNG				BIT(31)
> -#define TSIZ_SC_MC_PID_MASK			GENMASK(30, 29)
> -#define TSIZ_SC_MC_PID_DATA0			0
> -#define TSIZ_SC_MC_PID_DATA2			1
> -#define TSIZ_SC_MC_PID_DATA1			2
> -#define TSIZ_SC_MC_PID_MDATA			3
> -#define TSIZ_SC_MC_PID_SETUP			3
> -#define TSIZ_PKTCNT_MASK			GENMASK(28, 19)
> -#define TSIZ_NTD_MASK				GENMASK(15, 8)
> -#define TSIZ_SCHINFO_MASK			GENMASK(7, 0)
> -#define TSIZ_XFERSIZE_MASK			GENMASK(18, 0)
> -
> -#define GSNPSID_ID_MASK				GENMASK(31, 16)
> -#define GSNPSID_OTG_ID				0x4f54
> -#define GSNPSID_VER_MASK			GENMASK(15, 0)
> -
>  /* Host controller specific */
>  #define DWC2_HC_PID_DATA0		0
>  #define DWC2_HC_PID_DATA2		1
>
> -- 
> 2.47.1
