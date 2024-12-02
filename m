Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F014D78321
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE24E893E7;
	Mon,  2 Dec 2024 14:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="NYXpuVhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6474A8927E; Mon,  2 Dec 2024 14:46:10 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D968917F
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id D80A010000D;
 Mon,  2 Dec 2024 16:46:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D80A010000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733147163;
 bh=mqB6Dg09F1JSaozJAOqL/x7HwOWYlaOOfzMxSfQe/3w=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=NYXpuVhcYPWFAxBCzxn6jEHDnqg32uu4YAgHPaREAv7KqhcSZ2qznKmt4AW/TGtTM
 /D8Vb77QhDyila0lOLAopNwjoU2QQhigWkoEQlBZfxx+BH+dLQZupmr3uTFDN2zq+k
 EGawbfSpul1Ll6SbzIJBgXw0XdkEd29fl5Wr8tAy37k9hXvyEIxKTFi+wYd03wDCMA
 Go6rwBP7H1mxDpJA834YYZmoL5kydJO+YN6yoGXnT+ME5suWixWsXyeesnUFmF6OlH
 joO2p0m/fEfHO2+2xZoerSS8ERE2zndllp0THn7aJ/JOmzO+GizULEbrHiHThN1c2t
 3UZqVjDdG5j5A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  2 Dec 2024 16:46:03 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Mon, 2 Dec 2024 16:45:26 +0300
Subject: [PATCH 5/5] sandbox: set retval early in board_fdt_blob_setup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241202-sandbox_repair_of_embed-v1-5-05aff4b0ccf7@salutedevices.com>
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Raymond Mao <raymond.mao@linaro.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>, "Francis
 Laniel" <francis.laniel@amarulasolutions.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
 <u-boot@lists.denx.de>, Evgeny Bachinin <EABachinin@salutedevices.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.132.49]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189547 [Dec 02 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/02 11:33:00 #26927957
X-KSMG-AntiVirus-Status: Clean, skipped
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

Bug:
nobody sets 'ret' to non-error value inside board_fdt_blob_setup()
in case, when gd->fdt_blob has been initialized before calling the
board_fdt_blob_setup() (say, due to CONFIG_OF_EMBED=y)

Reproduced with CONFIG_OF_EMBED=y && BLOBLIST=n.
  ```
    $ ./u-boot
    initcall: 0000000000078e05 (relocated to 000061138d2c7e05)
    initcall: 0000000000117b12 (relocated to 000061138d366b12)
      fdtdec_setup():
            gd->fdt_blob = dtb_dt_embedded()
      fdtdec_setup():
            gd->fdt_blob = board_fdt_blob_setup(&ret);

        board_fdt_blob_setup():380 ret:-2 gd->fdt_blob:0x61138d4db310
                if (gd->fdt_blob)
                        return (void *)gd->fdt_blob;

    initcall failed at call 0000000000117b12 (err=-2: No such file \
       or directory)
    ### ERROR ### Please RESET the board ###
  ```

Patch moves code, zeroizing the 'ret', before checking the fdt_blob.

Fixes: d8289e7dfe5 ("sandbox: fdt: Avoid overwriting an existing fdt")
Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 arch/sandbox/cpu/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index d1c4dcf0764fb37ec99585a3db16fa34c3a54dac..7e93377e87e75b0fb92a8cf139b4a731a88a6a7b 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -377,10 +377,10 @@ void *board_fdt_blob_setup(int *ret)
 	int err;
 	int fd;
 
+	*ret = 0;
 	if (gd->fdt_blob)
 		return (void *)gd->fdt_blob;
 	blob = map_sysmem(CONFIG_SYS_FDT_LOAD_ADDR, 0);
-	*ret = 0;
 	if (!state->fdt_fname) {
 		err = setup_auto_tree(blob);
 		if (!err)

-- 
2.34.1

