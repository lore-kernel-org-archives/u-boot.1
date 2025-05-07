Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98728C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E580482102;
	Wed,  7 May 2025 10:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="svud/+ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0019E8210D; Wed,  7 May 2025 10:36:33 +0200 (CEST)
Received: from sonic309-20.consmr.mail.ne1.yahoo.com
 (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5987820EB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746606990; bh=Zdn1mX4OEjOo16xuX4rB4A/nio6xz0Ooy7yUje55eb8=;
 h=From:To:Subject:Date:References:From:Subject:Reply-To;
 b=svud/+rariZaTKNGTlS75HD3+gURUZtrDFsPgJ54txawilAVcITAqLiDpRFx6ldH5sBkY9ZRpJyMNKM/shgid+aNc4vjmiPQGTaAEcuGMofvEeTqQDicem23Rrd5AHLupJGN6HbDXjXh6EnkNoYyPaYTfOYFjG4vhZAAe+vNMJG8WJE8aSGbVSADc2m7CVTZee0nhhknBn4sFGZP3FvvaO2OGaowPI8HzkHe2AK6VBRU7ONUxotM/uOMDDOCe6q+V6JVagRXQ+/20CttiO+RcREVSuH/nOObRti5xE8q5ti8WizW5xo/YtRvbQp6l5VhQN2QcBgd1FQ/PVLeW54wQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746606990; bh=2+gZ+2UXGdmMx+xKtIxryuCBuDLDkSl6/a0oCqobIwZ=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=H0Jw0IjV7X4BSCMpyNEOMNA/t6mEz3Led2pnVMYxQY6VBeF45B9NDpB5Q/NFU6UFBeaKIXgtpDeLSH6sIXpvtdzHvqcYGAVrvmK8N00v7ZKD3RCDDU4S4xqHi5XYrcnlXw967bIBCZWOTNsnPXR4aljzMhNKOIGEPdFJ3+M4OltYxvFAN3ndwNX8TGaXTpR1KHfUTZVSm7+i+E6kMIeQXj592zps3qfuGYeFcdoQkO7PHl3ulRFjxbppoPo0Ndm4h4+LzLngZJdUyxVhGU6R3vAImyQ9oTqjtu6mz/WgSBLDHkkwUI2RHPuDRRCcUcDAfJnT+lq62ENuefYOlYNAWQ==
X-YMail-OSG: UhW8.3QVM1kvrkYaNkuiCs6BhSev_OryAa5mQu4whWpLwCgo8HmtXEx06_b_f3F
 HHAskCvhnCLFEpTZlC9JeHEVhoGHKNLLVCvIMemXoeAI.oOGmqHD8539VdNfZxylEi.mHimdSj8b
 vEbpOffDf1n3PkmZfJUv4n8uoDfaCDCaeHDtx2c8awARD5l_ththZL2Gf5mJa003JaSPErd0XKA3
 OYFftiQEbponL3p1OBxUqTYcoVIiw5ksbJ87QDS6c6Lc3L7sfnlOwoVrs6X9U4u3vbB8ypPfdq85
 IFvqvxRAAAvYSnrqyhgsEy4qzF0hvzLWruLVgDnquJ0wpzR39X7zBzI.udW.x6b7bxOM6Oa8nhiQ
 2KEawF3b06RvnAJJcy7MjP4hPc2Lyrr2DkkH6HGhHGlxvdzdIvSZxO1__NSZ8wS4oFIYxoJSPVYT
 FvyktRmzEhm9yX65sZ40_uc.PSFx07NrxE.fuT7HRmlncSsykawg8q1XUZ1ulfldZL6Y8VhQeaOv
 g4Nt9Lt6ogJJLqqPaUBcJAjnO2Ku4zvwbi6G2dogg1t.Xx.YhqEgIx8oZaqI04QVNh3OjEHrxLr5
 UH1JKMbiw3Zrj.AoR76WvSy6OROW2wEUXHSRv2TfB8oAx1Luaxq1Iz9vxHoeWeJmyBosaf4THt_2
 l2q_zSNzKruJ.nlL9JgC3oLP277zXNpn71rJesWpIPxEIiK2unfDkGnOu1PjXNKqlf6R2iDPAWn3
 uyWpeSaAi9u04IgBRLhYseXvmkCz0vrRc3JGICj66rSrNzTVsiTukDX81tngqD9lKE3.FD6uBtx8
 QWSMidgw7NgniGpjMxW2Q2cqDpyu9C_46lbfSZzZT8VINTRXgqRq2LqU2FoYQEyVgu.ntMDKmeRI
 A52bXKd2aMJPRHR_2v2oASLnXZEdUw3lnnstxWHi468ytxlZ5SrmiqcB4rNk4VaBs2hHheC9t5nu
 jY7_YZt2sXjxRCpEYGRn8mJn.XRuKYbn8H7bznTJhlg_Z3ugu_O79SFoulH3I5h3CoueO_koEkJC
 _9xfZaZaRrrNXLb4v9pO1SFNoDd1I5KRKjaCWVdVLE30gpTUCX5_D1E4vPOfdFy1z0AK9Xe70asF
 QROobu_YO_nd5N99S_U1chzd_XLO_s6K7cefLNzcuSCgGVnOBA_25xOtXF2J9GvDncD0zYE3lTOg
 PI8yEn9zOVd0UL16aTcVzJ.XwCey8mYslDUkR2IHEQdYu53tsoqQWodqDphEaj2bIFF1sIoUoc7Y
 LELmiQ9Col1XMDRdfumP1buVEwGlXb3gFWy82D4Oti9eYacKzdFwalRrNLW7BoyJnNBBJhgu_9GO
 WefHXFxLJ5Vv_21gXhPOfhmOBoMlWbRgtbvJ76pINfO5SvbzO1WaqOE5STfMkNbutta2p6D1WuDR
 EtolEnORTU_z4HPjPZXez7zWmUtqO5eQzLizbpagD5xLgfsTMdErYKMv34nEvdm8A4UVyrez5aZN
 qbTQOfqFImxEl6dJoAeOLgarlHgLKEGYJ5Q3pRuyD5C_dSnvTtLTDEvniD2WTtUfsiCB5QRC2Ovo
 TnX9wMrzSsMaT9FSO_QISQLcxglB4bb3FbbOCB6sG1Y79.uCVYpqMCMUVh65w5xO66eK.m6qJb0h
 iGozYzyvSdQjZZued6ax_gOzhkuEt0jh1eAaq8GkPyGjgnwS0xRtrrrx.6dFbzSLMdqoVxQiGOg3
 w9H.T_b_cXTfNm7.nMMxIJI_HtTecNByW0NSOFzs4ZmjJ1qaCxBlfX5cpn4W90lpaT50BImEP8nQ
 nrxDZe_Rlv_vF0wG5YBeWShkhLo.t3Yb_vNJKuLcTaZwL5.mjzy3Tn3eCEa.7p1s57PHQIahLzyv
 CPu5G6AXw2hRG9et62mJuHrbeKF8Zc5147v9Uv_ae57MsheR03gf6nr1eEhur6C5dke8v.cq8pP3
 jGH265oN12suf9rhobeM_ejeFgqrlM9uzlRarxizh3P6_g9vls65OQrrIpPX9leXa8IygtfVRwvL
 Km2DQh2894Mg0HH8aq81x4DiZM3aOj.JsOay37Xka1ib48j4cMQJVJSbNoffLkq5Jpa08rLGxOJl
 RsZPA1g.SxK5.6fMc71sKaw4yToX_Bz44vF9rF5UwTN.eZR4lUi8rnza9zOpihlN02CY4ldBVrF6
 nxJMct8lHVCehP12wqonUy3pGTi2Inb3hvwXyddJFd0AMqcRjb0zv_kh.nepkQNCQFmyfWdHdzum
 5zK5F12jB4NDTbQWAQ9rcNVQXwXjJk5.JRCPhbkh3PND.hZpMYEvX
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 4400d674-35de-4f1a-8698-ef7f72e1db30
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 08:36:30 +0000
Received: by hermes--production-ne1-9495dc4d7-c2sv8 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID fa7744874fa6f02606686856459b1003; 
 Wed, 07 May 2025 08:36:26 +0000 (UTC)
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
Subject: [RFC PATCH v2 0/5] Add FlexSPI support for i.MX RT1170
Date: Wed,  7 May 2025 03:36:19 -0500
Message-ID: <20250507083625.6195-1-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250507083625.6195-1-dullfire.ref@yahoo.com>
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

The nxp_fspi driver is missing some per-device quirks that are needed
for imxrt1170 support.

Fortunately, linux (where the driver originated) has since added support
for these qirks.

This series cherry-picks the linux commit, then adds the imxrt1170
usage of the quirks.

I believe Jesse Taube is also working on this problem for the
i.mxrt1050, however the patches I saw were quite a bit different, thus
this RFC.


Changes in v2:
- Rebased to latest master
- Seperated devicetree and binds to their own patch
- Included imxrt1170-evk_defconfig changes missing in v1

Jonathan Currier (5):
  spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
  spi: fspi: Add imxrt1170 device data
  ARM: dts: imx: Add flexspi (fspi) to imxrt1170 and it's evk.
  spi: fspi: dev_dbg() call assumes fdt_addr_t always a long long
  configs: imxrt1170-evk_defconfig: include FlexSPI driver and flash
    chip support

 arch/arm/dts/imxrt1170-evk.dts              | 28 +++++++++++
 arch/arm/dts/imxrt1170.dtsi                 | 13 +++++
 configs/imxrt1170-evk_defconfig             | 15 ++++++
 drivers/clk/imx/clk-imxrt1170.c             |  9 ++++
 drivers/spi/nxp_fspi.c                      | 55 +++++++++++++--------
 include/dt-bindings/clock/imxrt1170-clock.h |  4 +-
 6 files changed, 103 insertions(+), 21 deletions(-)

-- 
2.45.3

