Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E20AC369AB
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 00:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA3F82B17;
	Sat, 19 Apr 2025 02:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="dgEFB/F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA358298E; Fri, 18 Apr 2025 23:04:36 +0200 (CEST)
Received: from sonic304-10.consmr.mail.bf2.yahoo.com
 (sonic304-10.consmr.mail.bf2.yahoo.com [74.6.128.33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8EE800B3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 23:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010272; bh=a6AbjGZUSZgTxlp7s3xWdg3YeR10W5P9pfENKAqs8CA=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=dgEFB/F3GrN8hUFpdAwLHaglRPBq+59ZbqXaSd22fzu5taHiabLCgXYeSMrHwa2h3hTURblrioK+aQTofgiVvqfgAQCNfTp9SroWB+KHcr1y17dXt7fKHQnEdJqKxoYDqgEtn8Z+AdXiHAqdYAH97su89HeiBluQFUTle/a0NhAWoAKWE28i21epiuMkZ6AdK44/l1hG5KCI9NYrZ/napFRTS8f4l04mxHhSdxFhfNVS1yS2bLkVu0N4XKxJ4Di7UfM1N34/X1DCNuPGYB1ii91wDRR0QSgnBTfPCEszhnDZGw7kETnBveQAtS3moassRSiuthpabkX9EM+7is1yDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010272; bh=9ENUPfOgA6Y9TH2CbzFR7zUyjIYcPh/FVDuDWtQ/EUZ=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=YkSyrsYkjvwQDCXciH03ndT3SLD6elPu07xU2FQ/+vyxax8LDlk7OaJQ2EleM4FGh01mD1XPLDMe0gWMWEASFxPjKIMnsMTNQxcf8ynKZ03UUjZpDwieeT+WPISA2Ly2kmUIuDZTpF2dDV9tnDR+AEVpYlcxYrw9Vz7Wh2vkBM4Wi0/6laFTheKd2ENImwlq1OpJIXwstyyrmUpqGa6jlc1+vBB9S2clkx0r3OaQdFoo5dCV3RgL+x5h6dj89bfWp4M5tGUe1dtywbrW+pDydR0Z8jpik/uSv/1uIIY+pTQvbTlffNyqGSa6ai5Vb2DnzJkthxkAPSpawp2zEF/hTA==
X-YMail-OSG: 0XlXXI0VM1k4HpCDJPgvACWCDMwmQRrbG408DlzW4KtOteH3fFIFOIRFm3VpQ3x
 AXhjcQGpTySlnRNr7Z_axHyhvKxfpfbzyyiJBwL_ZhZ6WcB999vwfig37Ke9B3sPJcEZ9TeFfkYs
 XNNOo2Ry6YcckQmCXf1mBygAlMFNP1R_IyosOxkFeXIbKSky.B0b4wWGUs1VjVl_iQYZnl4n5YKf
 F7Om0WVNJmTA6MK6_R1bzZ5a0EGIHnTnKhbS2wF_xBhdamvkgrHAatG.qzMBdWICSSZ2irsNSE6m
 pIJ5FjBNJr0RRLGPOLINutmpMprFd5OzFIoMs3BWrSST0iKl66kmRN1A_j5cBWHNnUQqqidz55Ap
 Jrg0Ug0b1VYWeVgGjkyehoknSUZgfdxskOkkZ4iwoRF1TaEEhMaS9p_18.LWkBCbUuK5z3Dd9sTA
 0Zc88d.H8D_qSD9NW3u7fWBScOsrA5x1SiQJnF7TKfKlXEpekcoIj8UKZUK9UwGPm1DHG2TkaA53
 WZC9emTotPbkZsGUfK_UZ3NY3CKj50P6fEuogEhWELPllRXODTNlIme.6o1vdFroNK2aL0t7vive
 Wk1wdSkRNI.tXA64Ti8C73hgYRxvXD_lSdABV3tywK9k22.goPGceIVfxFgefbzmw246FcQgxJJq
 0M3o5tle3nIcyKOTVEmGHS4wLnOu0DMwm0rBwG36n8gcnXYRvwHRsHph0LVEBt84VwbivEMMqqld
 .v6ZBvhvGVmFL.7M6zo3EHHjZf.KdKtMWgJhEOteybJIclaKAoYr0tfgxQxuz5Fg4a2XfO.e2uvG
 pe5MAygPbXC3iTSWRmQSg84BWK1E5K4vEGsd3JYCzrq9E0Kd8la0tws4nizZDv4ikissgMNK0ROM
 JkDNEp0g3RCjz3MjPTpJE7IoU8LGC.8XatKePopqJSmAP074OkIViStw25yBq2mc52z7BJYYI5_m
 k.nIvy_trOKSUzb0wNQA8TN1d1V_t8e26iSUNvCcutYlRGlVoAelrYz94mkuDa9_l2VBNwCNU4jj
 pDRIWAD5CGViqm8qtLFFIyCiDYEarcVtApF3_3znfHjVaP8Al0_I.CcT_8qRE_XafYxpHcxs3Kk2
 RyMX_sxM_.Domu7FapWwZEXyg7r2dfyZ5kF5r5T.mX96uLRwqQx8euZOO.fDLuXLwZNk4bFjOAa8
 rtZjI6958JK4FbQqNM9_.wukIFsjPOyMvw7ka5rqL2.SuSUDWuQ5.4c6NdRRtT2.10LnGcnZb3cX
 U4.aWFMlr8sr_i8f2Yne_K0jteKCoEw5AJ2Xpcc6efbvESAY6Du0gNtA3BHeSqBrlENZboX2coGo
 6K9FQdsToawXAu66w8HxvkyH.oMcZ9oZcMO8lsdxWwqK5mDNQoPxCXhEj2d78lTaxz4T9GwjIwcc
 5INHVHwG.E2j45gNumWbUklM4st.hpqfGHiU6bjIC4hKWsmdoYu4hUBKM2HJN.KVfXk9VVUvU5NX
 DeywUL0mXT8aYNDiBZs6ObF00Bey3xVzAj4uJ9GisI7JQ2QAQ9lPwq44FLNrGe6kMVRSiLyvXjXs
 Z9f1mqhzSigzXwCZ3Yy8ao5izbewG0T3j2UDq4gZOEd3ZDZVPrIC4GsSvq3ia5LAoTnvD3_.YGG9
 0kU1Y5wX.uxjLcNA_VNlaHv3ht2CHSxGxBn0nL.abpQ1looxtTrD2TosnozWVC4gfEjL_BpOXzxy
 ljPnpZ4CL6FatOUN_Y.aszn.PNU4b1jqEQpdS2IIUueSLgarVXQOGyc50SnJvxDjUyBzE3_g6DNL
 c.m5jOgngmDFqzWsvCmAoGVEdl7Z8yiLYUoW5cwa5n38Dr3x5Ha8kSFe7O8a18CUOOgJYdufAHd3
 SoD1f4Ly5mBzS9jnYeUlN6hAG.Zqj2KXrC7gqJQZfOlHR7i9xbDlo.z_SbKNPHf3YZztD9.l88sK
 el46HFQTt8svnHnjL5tpkWNKqB.KpQhZukBIQI9.iNA8ItWbivrMusg3_tZunrP9etR6UFOJJQHL
 c7_LcsstnbtGddLzBzRORm2Qhxy9FqCX7voeq4jZppi5sm3zUs.AvFXtIoW27e4CX__8rOeBsJPW
 D7C4EQgvFvEcd3CxJB2gXU1u15Ko4zGuY8DFu8WPm713gK47bLyK0EqxUzJvneRWc4qNVpy98low
 kNtORP10Yi1A2RMvB5jG1VsbmCJoz1ijaSUU.6CixYihv6kpc28Kgnukmr6o_dV7sEW21DTG81zP
 vFyfIGPn_NhBK7oeateO.9KRuiuf_gjey8Yq6M.n54fpqOkK8b7zLB_nAQ7I6aRY-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 16948162-6391-45d8-bdbc-41eccb6520ce
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 18 Apr 2025 21:04:32 +0000
Received: by hermes--production-ne1-9495dc4d7-k9rtt (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID f6a442520a88e20196b1f9f54b0e3c12; 
 Fri, 18 Apr 2025 21:04:31 +0000 (UTC)
From: Jonathan Currier <dullfire@yahoo.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Haibo Chen <haibo.chen@nxp.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: Jonathan Currier <dullfire@yahoo.com>
Subject: [RFC PATCH 0/3] Add FlexSPI support for i.MX RT1170
Date: Fri, 18 Apr 2025 16:04:27 -0500
Message-ID: <20250418210430.27458-1-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250418210430.27458-1-dullfire.ref@yahoo.com>
X-Mailman-Approved-At: Sat, 19 Apr 2025 02:13:29 +0200
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


Jonathan Currier (3):
  spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
  spi: fspi: Add imxrt1170 device data
  spi: fspi: dev_dbg() call assumes fdt_addr_t always a long long

 arch/arm/dts/imxrt1170-evk.dts              | 28 +++++++++++
 arch/arm/dts/imxrt1170.dtsi                 | 13 +++++
 drivers/clk/imx/clk-imxrt1170.c             |  9 ++++
 drivers/spi/nxp_fspi.c                      | 55 +++++++++++++--------
 include/dt-bindings/clock/imxrt1170-clock.h |  4 +-
 5 files changed, 88 insertions(+), 21 deletions(-)

-- 
2.45.3

