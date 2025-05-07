Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB60C3ABC5
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550D382958;
	Wed,  7 May 2025 10:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="ey6VG/Bt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ADE82952; Wed,  7 May 2025 10:36:48 +0200 (CEST)
Received: from sonic313-10.consmr.mail.ne1.yahoo.com
 (sonic313-10.consmr.mail.ne1.yahoo.com [66.163.185.33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8A1820EB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746607005; bh=PGNBMY9VcpMvQ75fEzj3ZrYN6PPSqTLvXXhfQoPOfos=;
 h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=ey6VG/Btijxu+vJ9W91Ms6ztxXamXV+L/+C3xD4Hk3scziIv0afu3BNIeFA95DOE18LpWj48szRNf5/cSNYvP7Ci/U9/vKUJ3lJztUKh/RV94Bs9v77XQME8Xx1k5d+vqS2MoiVnDqiG7/vqFX82j/Ll+KY6NQQGxTb4HqLtK1D6kVA2+O99+EB+5/MYAHWMnpVoiuhQiwy3njQ0CbcW5dGr4DLd1Fw6qjzl/0ACmZp6/IFyIIg5omx8vJfro6GAJEoV9n4vuuacDgYbMrfK8dEgE//ZTRaDb5JK5L6GTNldRxvDvIrdJ2MUkA4V93ExVA3kHWxETid2mDh6PiRt1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746607005; bh=FlJkRzD/OV3wRg+IhoHj79uNHysB6zqe7Qn6cfk2ax1=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=n/HkdhPMM1HBSBMo7Ejkx7x8Orqa9Eu0vZqjm5fJlmYWZ39t1qIb6EdEgQwQsSH/dbIhRDa+WfY56J7E/SlY7xU/cMjUnGMklRo9sH0qoKE2SuzcVjbafhqxCq7XIkeY6ghBXYPLqOkWP4ZRzTgAfhx2+1TW2VL5o+f8Dq7m0H5rg5bqYM6+/+2oMycTlznyc+hDugCWwLXQGnomKMx7tfiZIoQ3uNhPCZEhhddQr9+dy/5pqr343o+vM64QheV3wn9vgOusF2NJJgzABwWx5IcdpsBo0KVNmVoF26Fzm3SeCSIIPGghqamwwXChRoBNsbD6ifeBvSyxVuLuBir5fw==
X-YMail-OSG: Nm.N8hQVM1nekFhTzyDB5r3ik7MSlqcXUWDS5N4CU8hZKYznN8wweevGzHB7mee
 4gf35Uk.oBrD.aBQlKjjLujRMwF2sZHpr0aYVs0Jextx9gdl0GCjpKOvP8G1bzkr17JrZnTr7eT4
 MmP_z25m5XYvNeGgek0gFHxQ1ddddSK1CY54QRXX4CRwP.Irn.XFNtYObiDh1cEQ5_hRGt6kYmSg
 Pk.873OnQH0tJIygNjbJ7zTkpRuBays4WyQ2rZYtRiWedTlg1va_OTsl63c6LI8obOzBhqUO6764
 t3E4tsnw7muzY4W8.58WuEBbK7d5IjF4ZSVVPl8QWhhZKYoYGbN82T3zs9tQcJoXXgPCzPO3_CdQ
 ZUBhggqxXtyMY9R64_Kg7B2n6gF0kus1hlMEnzKXqsKIgJY46UWGs5sWGFgTiDn_OHKtsmUzmZq8
 rLYvJLp6uG5Lq85XOvwqdYg8xpY.g6olm3qH85aZ3Qj2xcQdwChM8FN5WV.1icX6hDFPpDfJX1aV
 LeVUSn6Yxwm6yEhK.KIQXMgHOd6rh4lNwol7_ASVlhiuhlKyvzQfi2E2ET_ZyDIVVcbS7r1V9MOb
 AhfcjYgb0xTFt3405S2O1AGswyJJLw7ZF.MLwbkNLLO4rA6vtrVtheMB9cFnwkSOHAynIuDTB2jj
 nTiSfL_qP1_tofhPSoSS2euXqCJQVjTkoyF9A8jlEJGM5S9Or4wqO7xzdhIJb1m_5OCTrJ9uRh7b
 vVPRB3WMFzLTZD5vksFSuF9G4QzQ5pQTwIg.6QZAwDclZKOD.IiKol.gZjhewZhpUVVv3.acz2u1
 W3xopc98zaei_HqiLqpCC1Ws8JOTHb_TSIKWejzeghMe0g6qFzgIUaFpN2LSylvg3NoucL4Nz.p3
 THsAnaRZlOSfK36hhyPSfpe8Tc4VMOF55ebaOwx1BZ8eYI.A0REt01HLJ1TceOPRbgK05AIY5TL2
 sluT5YqRY7VIMhtsxFxmHTowIldgYOqHPU0rqx5ci5nuwP_DL7bBVKAoiqcNpvA33sjPMeW6ueeX
 aD5Tp3na6KJ3uBXbGUZ4tEvZIwXSy.LR.UZfsbnMjhFKbj1.f8XEg_Sy7BUd9gBpuqKiVciJUlao
 j.6re4zKOW8nNIn_zChvnpd7KdX0TP6FB7N71z.PreoWkvJC6nyYG6QsSLGBMfLXUU9w0.pdGAOW
 6qqhlWUHnSHrFfiNRgu5CMyG6swOjPYCvEvBh25FMNM6rPynxvQHEb6.326lIUdcvHwq3j_D7NHx
 I9NpN0_jveLyrfzzd3_tt2mRQM6koW1AV3tOnWcsulJd318Cr5LwA4LmybiV5nmfjm_6qsiNImsw
 AqysNvlZ6n9biFR7w5cXZU8B0f.8URGudOOds1eKQ5RnmPezc6S5fp_asNdIMCLfyylbVV._Hw59
 b9bRpmn_rqXCCfmcc8UtORZJiPC9i6tCGSnimB.BskkNW1J15qLjB5Sf.yamK8RIhcdF.tbOQ3nw
 h.s8D1LRUZWKrR.abIXK1PWth7X4SvjJVauClEk7ASeJWxhsmxbomlhY5vdTnM2augWVNPHn4bhM
 JlN0bvBo1GVNWpyLox6QZktfInbKoaBfrftnm2XvvicTSqI6VCM5owkyUlXfumqQ8mevYE_vIihT
 etRaQ79syjDqGJUpYjJbG6zwQ.VryJ3LFCxyJ4t2_yoaxtn6RG9Uptu.qLxHHZXNauFWzT1Ke7pj
 81knNaK3gwZwqRUMbTjr_K6vUQC.Qzi8_hCIRW2KDs1tao_uHpPpncUPBNgXCrRxTVdq6SwmYQ1R
 HZzmc7l2aVzgNuBLX6Pnrnv8FYlIdLVH5bG3vCZU6qhMi9r5dA5rg1kUQrt8RHpEqjWlqGSIgMre
 hC.L8Mgb3LpPXRo5BjlggXT6k.7wT_tUfr10hHDIzdRgmhcQdSmWmeSkMuSYeP6UVNXR0CYdj_se
 OnDaGbMkuLekYT2qDTGtmdU9o96E5dQDH26kB7x89WI9NqN0BVw4B9Yj2qljJvhGfkY.UR2GoFiw
 4RN5.sYChnrPozMzxPdVuwKl7Xi8XJJ5CJBAHOt89wDr2d5CtMJC._S2XlydEMty0zw91D9bMqYQ
 7sYz8aWg0S5iXQsNBdGogwSzs5Mz30C1cCF5eplGyniTrz3.GEIdMw55LHRmbzAZOH5hRDXd9tc1
 1oRVDIBJIVMPbBqJehwKY0L1q.ZpM5L0JusUDrIhQbdPzHqNHjos4xRC0h4A4hUldTGild9FMBIf
 sPSN7yHsG52J66YjnWhzahg.9bYLHTk_RSS4WFKpcp_sBo0P3jgmqEo1gNVACMXQ-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: f17715bb-19c0-4d76-a779-c6150ce28534
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 08:36:45 +0000
Received: by hermes--production-ne1-9495dc4d7-ksk6c (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 657af18a778aaf15ff4eb5122835a91d; 
 Wed, 07 May 2025 08:36:39 +0000 (UTC)
From: Jonathan Currier <dullfire@yahoo.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Mark Brown <broonie@kernel.org>, u-boot@lists.denx.de
Subject: [RFC PATCH v2 5/5] configs: imxrt1170-evk_defconfig: include FlexSPI
 driver and flash chip support
Date: Wed,  7 May 2025 03:36:24 -0500
Message-ID: <20250507083625.6195-6-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250507083625.6195-1-dullfire@yahoo.com>
References: <20250507083625.6195-1-dullfire@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 configs/imxrt1170-evk_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/configs/imxrt1170-evk_defconfig b/configs/imxrt1170-evk_defconfig
index 32107fa9d52..a57c35bf686 100644
--- a/configs/imxrt1170-evk_defconfig
+++ b/configs/imxrt1170-evk_defconfig
@@ -37,6 +37,8 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SPI=y
 # CONFIG_CMD_MII is not set
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
@@ -58,6 +60,15 @@ CONFIG_CLK_IMXRT1170=y
 CONFIG_MXC_GPIO=y
 # CONFIG_INPUT is not set
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_CFI_FLASH=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMXRT=y
@@ -65,6 +76,10 @@ CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_IMXRT_SDRAM=y
 CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SPI_DIRMAP=y
+CONFIG_NXP_FSPI=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_IMX_GPT_TIMER=y
-- 
2.45.3

