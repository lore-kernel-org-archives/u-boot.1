Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B78C369C9
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 00:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A14B831C3;
	Sat, 19 Apr 2025 02:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="FCPAEo0q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CDB800B3; Fri, 18 Apr 2025 23:04:43 +0200 (CEST)
Received: from sonic315-14.consmr.mail.bf2.yahoo.com
 (sonic315-14.consmr.mail.bf2.yahoo.com [74.6.134.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910BB829F9
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 23:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010280; bh=u6ueqGNA0ShymbhpoFqIU+HtjrjTmRCZ+FebsSluGaQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=FCPAEo0q0INLQdeVeED2ocJ7WKpsFQy9u2+R0MDyRZLTW4QyJykle44vzFr1K82/J7bspsQYQqf/3PaMcfGRyGhcbzFIR2cx5eLPO8OK/rm9FIIVrDdMiuUXa5NALkitppaeHCMhyo8wAjXCBpQarltF36HvIdsNLDQIEuz8YL+2MrmUIeg982OFe0BcejWJrGiKQfZU6bA5BHFdphd5Zlg2+cS2KfEYYWlxTEMYPl2wphay8vz8fsYNkBwbxp0w4DNs5uw5n9CXHs5QpO81AoefYmovTugmdTDiLlbOSumiFNzhzmTrXh7BFuub97UDngxhsgHd/tV989BaCU7kjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010280; bh=DIfbrGYA4pvylQFGhpRXJtYV6d+LZk+3mBJqchD3riy=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=HMYyRNTy0iX2zVpsHMrGmIzy4HBilAB7Zz6UY3ZZ2RSeW9jWosWj39fBE3bQQFraZQIHHIFXqjSECMmeN5eUqa4kU1w4arZty9zErwugnU8Rs31Kn9m7w0BAHAD4lX4Qe/DZQKfsz//ipvSSwjE9RW5uUJmIN+bhaVcWm0xzQmdAlp4TSM914NzZAL5wJXMvSHHYe/w9KOfBb6QNhnqT3ZXDcF8PFpjIq2WBsy80Oy1XAeI423Bz71D+pSXprBWIKcMycV8N/rD2u5Vm+aYs+ITP56nsV/ASrQ8zClW42F2rlHrLlSYcO0klyRooLYG9kG1mPS2zR/FPQKQZa0Jvpg==
X-YMail-OSG: eNFX.ZkVM1n3CtqNBDKG2keQWgVJSBz2johnuM5RlKd5pMYhqHA9mZphe8pKB0o
 oZs.tnOx6rvjaS406GEtFU5of0xYBxoDcXXD9WsgYddFzSPrUh674mS1NSnv.85ycY5GifiqDwJ4
 Rx5EGHz53R13b5kcYmShvdtsZJ6IdTxsAB.2FNr3KZHQ9MbNUnwclUTDMnKicdTtnuKcN07TVuaC
 sBEQ1FoUBVhS3rywDI5_qeopdfeTs.jCp1RkH1ztndHxnWwaPaLXb2QvUygj1cIBTyh15LtP21Sz
 W15.9iu2L_zp4gUUI0iwaQ7.LBoTimzH2461G88Gfj8r4kN9Mkc9qn2Z_tgzg7p9.yeZ6IUQS1vE
 Ajq1_ndeaYvdKXK01hSc9kT8KPIiBqQ3T3N8C84vGtjRZCFeNAWBnisdsxnSp7wl4.f1xyXWFScH
 BWaD1aLnwsxlLO0stGuKVSq5sO0ku4IkCnGQqUtIwTRc_mKMkCmMiHfsVMlxAICyjngTdKytC_Ql
 _AECmIj0_MCoT89FqNIuxWee.9CA9hfB6A1HoQYK1efuFVT084eORNSw0x6iFyNm2jY8hSdN_HIs
 VZRm_yfwExLmu1LSzIRS2j5Ndxzap4Z4e4u040lG69Cf1RypAPs2mrG1Xh_6AwmjmDlg15HVQkJU
 zu10bn.xrd9zSl3NIs2dvhOdV9pehHVgJ4JFBKIVYdRnrVrrDIWYOnbDOcNO4gH78K2xpr4.SpFL
 WF9oKNZUo9vSHtAxuMWwjBtBnq27TGHDt3q2dNadPgoEE3oXROWyJ8c0eyKdF60uXXw8lRs5qgb6
 YgTJZaiPrhPivVXR5qbsYoTeFLW.3NVRHkBInQU9SaLfm6RnJlwJ8YzDeBEacXH5f0XEscsLDp7F
 BSoTgyY0CKdubwmF4VU6.B4RjYg.WHwYZzlQRruikRIFj_SB0r5nP7NIW_KsrEM7iGdRFp3icJH5
 O9_TybfRDTnSD00yZlqnDR1ZIUFpdb9bnmMb24ntVYQeo_a1B0YvjGlOrcG_vLQMf3GLzq3mXAqt
 OJOVgVOTyj7QQvNiLrK8kCwBAHkAHeER3MNEM82UH5IdimDoEDPtRD_3ZJP5C_6ak.6mHZuNf.Qz
 qmktgwpblLkFd.b6HEAx_31760PDAEEtQxvD_EXR8LlV_FqW.1H6bRHXhVAx0r3jIZ4sr9_y9tBc
 UJBvsBk5bvt.1MnA8qgT3OUFwsActXRuhTgw18DaQVwIt2t1MQMHCbmal5l3wlyeg8Sk9LZiMyax
 GoLe4N8kvnalGkuCsYSzWIHqgX5ym6PTUncszpdjG9ecQ5DsJjVDbSsEHIVWgErAEZSPCDaTW_Ux
 WdzdHHRf52ZdKzdWRw77eRp99.0ivQI32NMCsGT9Ph2GMDs85lFhs5Iz2c.iqrT920IjKHjnlEjH
 .V46ayWsPWW5vTcEbysihaj506gkui5IcjoAYdzZROvIzE3k75tjVdfonvOlqyqYwtp8eBImcahF
 LbVjuJDbuVxdKOVw0htqgCko73GeecOpNcz5DBSm._NBbBLx_zcqdhxZKf7qN4avYyVaNM098Pie
 qt9s2cRZRqOpbkfJFC3zs_akg6BoTAF6MlLWmvnlqxaGBlk.xBMCeGLlJOfdJZ1Q7MIplks2G1hn
 5ny3G_1Xj_qxmjIEsnyks2bZJUJ7GtL8x5MzZQDxICknQppY1KAsh8x9U.Yqdg_Vsc75aKY_s5Ab
 GcGDcucrwq7JEinkEfP0u6TE3WoeDKPG8JyRuQxzA102rax0Z7rJwhYR3UntISXBakeS_0.Y0W1a
 pzsY6zEC7BhTcNVfLrD.zr1YsyaKKUKLmXo2btUVsxv65jk3EyCHD3yusueL2tJfwSXrsvGWfxez
 5ySxZe69sAPwETLtkCM0Wd9_PybnHS9QGG2sSFkwoBoPl4wsYrY3oKE28G4umiElqkrRFsLPY6iE
 gEtpPoKmmRJRDq2S7mIJ0NYXx4hxl_nrpHoXdhpdDb0jf7B7c3yVrAPTepX9Az6D3fsB53Fh7jEa
 jwv8BTdKmkYnHrkv_7lXRQKxI02Am5hhOQu1vgLFiENc3NyYzO9SHe2ZeN8W.Eklf6sti6YiYQ2D
 2lCYO2D3icfh3g32rLdinEVsyA3KVw07zH4jGV4vMOaypOLm4Pa71MyabYFsrQhoBpwgTKGyznjB
 xTUdzIWZZAEfvRF0VWGj38fXhrXdSrwjlwqtUWXCtVeJOC4SiNfFK_6yeCsKTRozo8vp4ucap8dW
 1yH54eAi.tkJ4AZm66Gr2jsVE4.sZEFY1PcIvI3k8h_6FJMiR8nO5iqfl78Ht1G0OBu4-
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 31bee1c4-6b40-48b0-bff8-e5b6e42867f2
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 18 Apr 2025 21:04:40 +0000
Received: by hermes--production-ne1-9495dc4d7-c2sv8 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID bd8f1d653e88fdd2e6d51e91c88cae19; 
 Fri, 18 Apr 2025 21:04:39 +0000 (UTC)
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
Subject: [RFC PATCH 3/3] spi: fspi: dev_dbg() call assumes fdt_addr_t always a
 long long
Date: Fri, 18 Apr 2025 16:04:30 -0500
Message-ID: <20250418210430.27458-4-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250418210430.27458-1-dullfire@yahoo.com>
References: <20250418210430.27458-1-dullfire@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

