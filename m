Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE6EC3ABC5
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDC48288D;
	Wed,  7 May 2025 10:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="PBP2ZSWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F11820EB; Wed,  7 May 2025 10:36:45 +0200 (CEST)
Received: from sonic303-20.consmr.mail.ne1.yahoo.com
 (sonic303-20.consmr.mail.ne1.yahoo.com [66.163.188.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC84982163
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746607002; bh=u6ueqGNA0ShymbhpoFqIU+HtjrjTmRCZ+FebsSluGaQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=PBP2ZSWxTEQqjRLAWu9esTTkrZJFUiqi5TNxwivtmyAoVdNEoEOirA+HmPF08oSCCrmxErR4eID78uqzR2hVikOJRG7wbZUcDpvyJave72TZYuvkl+aYfiDc/MqYB1IAslqRufmU1TMmzdhTfQG/Avg7nl8OmtEhxMy2BTU0iJFMh4RbIP6tD9tKE1coess9OLKG9jQPBI1NsBBWtDzvqh/wf6AKl4aXChlbYGqJid5l97XC5+IROt1AqVgCfsuLSIK0ddIQ+xUzOlXDmYnWQvg9xXz4NzmxuM6DnlKsCa/t9NHHsMpop/3OLGtEXoG/AnMGp1tbNRZsVL1BnFxs5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746607002; bh=HtJ3idT4qbfkWqS0e98StU180b/AzICJ8M8iSUQW3dT=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=TwQ6Gy/+Nl1daYUB6WFpflTN9N4zTBP3iTKOij8RMEYTONmCDyGnGhormbFXn8DrgZoe6mFkP5znzEDnj6WI09+ZQF/sdFMqe3VhMWK6ZGNOyCYAdKp7vfKPlgGSYFMw5zqbGGr75ni7K4jUYihmiwcS9PwX1SpY8BR47hzESqJIxN6qUHGIHkxKnjrrsDTzYsQJwFL/RUp9nmdMjcDBj06RtvUtjZsmJiwuKpbCbKs6Kw4xS2mnbBdzxxo+59vtAzmme8tLhlRalw5Fa1JKMwyHNUxaJeuxmfgSF6MhjYDJQ3GFl6y6xlIaFGNBCxyxDVrd8ISIMo0/GmHMVee+AA==
X-YMail-OSG: 7KT7f0EVM1ndfAlsBybCRrzaYs84irbJr.2X6uvHuO0zjg6MwEH.8T20onCAOql
 c2MJ4FtJGQyt7pdcsOm0Y44vPviQwIeNyCPFyYCMEVcdakZBc8sPNw44V_DXoV60fosPj8aAlfmR
 juEncd9xGPAGnW1.S7B2SaxLApK2RIa.Vh9ECAKri6IzBGOKWsLDP6nSzE_KQ9aoM7n7PSGTCun2
 89oSSE3xo4oJfJe6a3BuFzDdfZsSJVg7i2cLuW4h0dUS9cTv7B0b9UZ88LFJ5rCUEJNAj3m57C0l
 ievSXk45dCklPhqAZVWq0hY3ywZbVx8IaCtIIiqAtB2cKbTgKs15kxqt5lILeyBb2Qu2n0XChz0N
 3HL9NNhg_AhK3nLF3QcEXtipemAqHNbIZOpI58HQXcIFtkeInaNyrRwl.jGAhjU6ChnqGftkyYKZ
 mcEmIdOqbkgJQxwtbOR82z8_X1spGfKW01JQ2yWND9jjKQgQSBMKC3Zg3RuBTP0l9pCeVua4zRvQ
 ayfYmnUSvI4zw2Bnpx1IiauK2Vta7DZ_A3A3BzZhSjcF86arCttmQfSyv7EUoA3FtoM29M0FrQnA
 cwBIPwrXRji8z0WplHwvT8HBvLcK.1oe0r0FaTnPxf7gBnjhXwRGNkkxt7s1bvfQ8v6f7lI2y11_
 ebmbnAuYBOp.4aiUQ_U97eCYCsGAahYDq_tz9RTUjJMhL9iZbJIProcnjdVDUikCMT34rXk7_jdj
 0VmAlkNpxwl1V1lvZFMiSYPY5cQHZekDqwSB8gLn9gME4uWLCu2qLlMyc6ADNM.JxBMaxKSWsmjH
 RIJYElKflpHOVaeOwDtk6SzbmhbR0idlz5kN3hE2drXaYhXx6qGhJXy7JLzLZpAL.Hwv8UD4h1CI
 WsS19filfcoengDpRvQ1iqsg4tzbFJBZk8iHr2OfQURhdnlDaTgHN0lW33JJrpRwHi0BjqNIk57F
 7weKGzKOP.y8ff5qjlw.WulRjQc7sMzFvh1HZte18BaXTlF9dJxkIkmGyNdR16bc9eYklEphvhOw
 QkXiQnpFctsf4dpqIGXJfEsRJjMoUcqKmK5ZIT1KfsTfFkYfx3f7eqiy3HjhylAP6S8TnfbKnGdY
 B1Dx_kW.HKi.1UwrcXt3mi1N1XYHaABiGk0jYDsqtEo1RReTYzatqMkBx7n4UlUOwE1A_YvxJPaG
 c_vrWpndvoKKsgOMEk9bu3tVKP77EF6uX_3xZVBSOvffiZyBDdz6gDfmN42obzy0Javr0SLnnv6k
 dAeUSk4eoDZSh2RYHWHneojdyhNgLCiT4qdaDgNIWioBoVsS0iBG.3BlyfchBJ1R88FUHdjXYbzq
 Uo6JhmvLfd9Bvl.stFJ3L.4TdZ0sqweMI_my9Lg00ovhIjlBjNq5tEgN81_xWJ.s0qFRy.5EpMJh
 BWus6.aVYvQiVplweja5NxZESNPizzx0nMl5gYxtdpArEdMk.c_F0UMElTsXtpIHQvlk3Gdn3rSp
 .ujW6DC1fDExYVaAnp5VCKjCm4bfoyq4J8IFeriFiwC6h6rCGf.R2GzPiu20FMgJMxM2GmbYh.tL
 .K.pQssXFxM6k1DQYFM0ix_8oX6t2NyIFlOQWkT94GG3YBXdy.xrWNC6YeEetOmbluMfvfWxkNWa
 u7CWLHMyQPG7h5iVdTKOfHBcPR3DO_09UV7_mG0nYPOH_MgzhQF2vEMn8uVYosukIu4iq_Flsiin
 PRd8hWWvqX_ueBP.vDtFl.APqZZytAaidczNVxjeLaZTSmSBY7lcxpZAI1MnEuR27XbIqcUNhICf
 DCLC7v3W0htB5QgE_ztissJ.8ky1PtXeYFmM27XjyXJ4wCOTm9wsxecU6EKwikqtIS2WlijCMaS3
 LdS5PjC9CldB2eDmf9JbMHvLgceLhkD7d2gKQGsedcEGDuDq9MrOevAw.xI0kdbMvEeVHQS269Lz
 1GgLCJBXM8p_ctGE9p0qVuBTuHiUGVHwM7jHbGU893md66I.jTxvCjFFVT2SqF4JHQz77fYJPE6Q
 Z6XZSWc5H_TmpTassfOc0pCwQNbZz3L5zIy5XxNRxz2UJuwTlRPmgq.7E0o5nBgqNFVNPa1d9f9.
 ut.16FL3L9POdXiqTH9DK5_cc3CoqM3qHsZ_NoKqlr7o_2QbLBGS6yAYpMvWJl29XTXZcHYymsdB
 pjCjeBWNmOCk2oggeDl4bU4H.gbxzx48CHETqR.gwBBcV0Q_MEJT_e53Bod0GAtsD_OtCKXnwBO_
 f8XzCJ9BsNNpxB.KQa8DEznlus2PSpTA5wGUSMhJr_h3x9QG0D.SBjMLkOYgjQF4-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 417dfd06-9062-4a83-83de-3f20935f0830
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 08:36:42 +0000
Received: by hermes--production-ne1-9495dc4d7-27szc (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 53889d222af5dc96bcf893d45fa94f3a; 
 Wed, 07 May 2025 08:36:37 +0000 (UTC)
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
Subject: [RFC PATCH v2 4/5] spi: fspi: dev_dbg() call assumes fdt_addr_t
 always a long long
Date: Wed,  7 May 2025 03:36:23 -0500
Message-ID: <20250507083625.6195-5-dullfire@yahoo.com>
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

On 32-bit systems, e.g. i.mxrt-1170 fdt_addr_t may only be 32-bit.
Cast to a "long long" for garbage avoidance.

Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/spi/nxp_fspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 95ad7fcff7f..6d97b8eefc9 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -1048,7 +1048,8 @@ static int nxp_fspi_of_to_plat(struct udevice *bus)
 	}
 #endif
 
-	dev_dbg(bus, "iobase=<0x%llx>, ahb_addr=<0x%llx>\n", iobase, ahb_addr);
+	dev_dbg(bus, "iobase=<0x%llx>, ahb_addr=<0x%llx>\n",
+			(long long)iobase, (long long)ahb_addr);
 
 	return 0;
 }
-- 
2.45.3

