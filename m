Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D536E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECB468033E;
	Thu, 19 Dec 2024 22:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="K8SsRXUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA2980312; Thu, 19 Dec 2024 22:42:16 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E1E80291
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C275A10000C;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C275A10000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734644529;
 bh=A30LdPzevITfy6CDIU99lazXkItHflkSePfLWk/55BA=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=K8SsRXUknW1ZwgUM9AwSNUcb7pUBWWp2aAgo+BvPLeg7rGFeRJ3TQ20ZETTMBy3FZ
 uYKS0NPgiSriy8rV1EG4DOpghLpFw9PvMkQ1fuHRqIbIIK17w2jokou7vhq5kEfZGP
 l/PHNbg64uewbg87ZaVvCTsGbL4EWE7rU3Wi3y0yRFfdN5O+mAWMLvOTLbbeVS0ybB
 L5e8l+rnllDWaCRmlKLf/sAFblUy89i37nFZw4isfJlK1CmvJXynCkpxOcPgO+QEhQ
 WUXPkAVe11ERqhdDQooKX0KfkMcvARFHTsorJRdnrgtQP9GxWYNcAAx1IQWbJAsfkd
 qM3Uw2+bNCrwA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Fri, 20 Dec 2024 00:42:10 +0300
Subject: [PATCH 3/3] common: fdt: hand over original fdt bootargs into
 board chosen handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-board_fdt_chosen_bootargs_improvements-v1-3-f6a7181787c5@salutedevices.com>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Tim Harvey
 <tharvey@gateworks.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Sam Protsenko
 <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734644528; l=3662;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=nsyoWU8o4mhhIbCCXTgM3ocFRUZtGFdj/zEgzgPYJus=;
 b=WyxNweZ/pLwhFJRpqiLjT5EHvoFrkZk4ZwPxc4GFsUp1gKX7a0pVjPEB8HgrsV8Ea6WQuifZO
 GA1ensULrGgBDiG+c4r4NwRSlJ+MnAdKSXjSCuFmgX/7YClR/Mdrd7O
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.162.51]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189961 [Dec 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/19 19:16:00 #26891781
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

Sometimes, it is necessary to provide an additional bootargs string to
the kernel command line.

We have a real scenario where one U-Boot blob needs to boot several
kernel images: the vendor-patched kernel image and the latest upstream
kernel image. The Amlogic (Meson architecture) tty driver has different
tty suffixes in these kernels: the vendor uses 'ttySx', while the
upstream implementation uses 'ttyAMLx'. The initial console setup is
provided to the kernel using the kernel command line (bootargs). For the
vendor kernel, we should use 'console=ttyS0,115200', while for the
upstream kernel, it must be 'console=ttyAML0,115200'. This means we have
to use different command line strings depending on the kernel version.

To resolve this issue, we cannot use the CMDLINE_EXTEND kernel
configuration because it is considered legacy and is not supported for
the arm64 architecture. CMDLINE_EXTEND is outdated primarily because we
can provide additional command line strings through the
'chosen/bootargs' FDT node. However, U-Boot uses this node to inject the
U-Boot bootargs environment variable content, which results in U-Boot
silently overriding all data in the 'chosen/bootargs' node. While we do
have the board_fdt_chosen_bootargs() board hook to address such issues,
this function lacks any FDT context, such as the original value of the
'chosen/bootargs' node.

This patch introduces a read-only (RO) fdt_property argument to
board_fdt_chosen_bootargs() to share the original 'chosen/bootargs' data
with the board code. Consequently, the board developer can decide how to
handle this information for their board setup: whether to drop it or
merge it with the bootargs environment.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 boot/fdt_support.c    | 5 +++--
 include/fdt_support.h | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 2c39b2dd14b7c447bc4c7c8fad64e22cb00e88e0..49efeec3681f7c97341ccdce596bcaa4e1f037eb 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -321,7 +321,7 @@ int fdt_kaslrseed(void *fdt, bool overwrite)
  * board_fdt_chosen_bootargs - boards may override this function to use
  *                             alternative kernel command line arguments
  */
-__weak const char *board_fdt_chosen_bootargs(void)
+__weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
 {
 	return env_get("bootargs");
 }
@@ -364,7 +364,8 @@ int fdt_chosen(void *fdt)
 		}
 	}
 
-	str = board_fdt_chosen_bootargs();
+	str = board_fdt_chosen_bootargs(fdt_get_property(fdt, nodeoffset,
+							 "bootargs", NULL));
 
 	if (str) {
 		err = fdt_setprop(fdt, nodeoffset, "bootargs", str,
diff --git a/include/fdt_support.h b/include/fdt_support.h
index f481881ce640797e0f6204d599f008d0e5dc2bf7..7731feba5f068f82c8ee25f18a9f0e57729e2bd8 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -231,12 +231,14 @@ int board_rng_seed(struct abuf *buf);
 /**
  * board_fdt_chosen_bootargs() - arbitrarily amend fdt kernel command line
  *
+ * @fdt_ba: FDT chosen/bootargs from the kernel image if available
+ *
  * This is used for late modification of kernel command line arguments just
  * before they are added into the /chosen node in flat device tree.
  *
  * Return: pointer to kernel command line arguments in memory
  */
-const char *board_fdt_chosen_bootargs(void);
+const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba);
 
 /*
  * The keystone2 SOC requires all 32 bit aliased addresses to be converted

-- 
2.43.0

