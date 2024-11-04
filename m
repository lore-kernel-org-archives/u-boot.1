Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB9DD1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 18:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D9EE88D29;
	Mon,  4 Nov 2024 19:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730743331;
	bh=OGbP9sQEcU/T0fqKImAGDHPuDQSKc2rCdK6xc2qT0s0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FHtjgveNky8TKoC+RENdAwE/Xt9Va+41bY0+R9FdAKhJdymucXYvBOj3vhFYfYv8y
	 ztTn4yt5j6EC3ov2MotSZfdKEYcwCDQ62Mbf0r8UjxMkUeaIU2oUjuLZFmupoZ+EIM
	 THyakk13fLF71semkUrC6QdjU8TE7hPaMRjI0ShdrOd6rbx1Yz8hxlqb5z0LeltJ+/
	 aUZW8SW4UONCZbaEYwaGA629xOObv81hb4PDwoaAQ/v9MTKKlZ5ljwvJCjaBbD6hqb
	 /DpsiMAWVs4HK3cFPy1M5EJZwMIeIxMUP1MupTcNjvJwML/rE27zGGsQw3gNQkdT0b
	 0YYYRf92toPiQ==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DBF9188DA3;
 Mon,  4 Nov 2024 19:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730743329;
 bh=OGbP9sQEcU/T0fqKImAGDHPuDQSKc2rCdK6xc2qT0s0=;
 h=From:To:Cc:Subject:Date:From;
 b=tA04hlAx8jPUc6qlOTSBAqZs2vXQevN1/JkKHnzWAXi4km8ErvgaNmsFV0fMdg7hx
 m7Rsb4k/uKN73U2Jr0Uj7gFvWGuYyYEqZtqYb+dlMNgSb3pPwQeQteUkSWaxVGRl16
 111CMm+QF1vs+qJ90eYibMGTWoUbSvU1d8O+jS86ofl0EVxB42FdnTORf7uPUYABvB
 kqZHVl33qHxdy092cFM3JoWC77iqVOM5fo4MUPe3QxFh+gJAqBwde7D9qqcL8FsYj4
 SXqgO71Ft9Oq5WZvrJnSGuydkCBjx29TI7darDq4Q8VKl2ZvYZcUmmUl7jcr64OtzB
 ErQjcpTmqp2Fg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Gary Bisson <bisson.gary@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] tools: imx8image: add possibility to skip dcd
Date: Mon,  4 Nov 2024 19:02:03 +0100
Message-Id: <20241104180203.110395-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
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

Currently U-Boot always adds DCD Image to boot container.
On imx8qxp SoC it is possible to init RAM from within SCFW,
and adding a DCD image type to the boot container in this case
breaks booting (No debug output anymore from SCFW! Nor any
output from SPL), so we need to configure a dcd skip somehow.

This patch adds a new imx8image_cmd entry CMD_DCD_SKIP and a
new entry in imximage.cfg "DCD_SKIP". If set to "true"
no DCD image type will be added to the container.

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---
Superseds patch:
https://patchwork.ozlabs.org/project/uboot/patch/20241009123937.124691-1-hs@denx.de/

azure build is fine:
https://dev.azure.com/hs0298/hs/_build/results?buildId=129&view=results

Changes in v2:
- removed the RFC tag
  added Reviewed-by: Peng Fan <peng.fan@nxp.com>
  rebased patch on mainline commit
  6ebfafe8c53 ("Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh")

 include/imx8image.h | 1 +
 tools/imx8image.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 85fb642ae39..6b95e93fb50 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -146,6 +146,7 @@ struct image_array {
 enum imx8image_cmd {
 	CMD_INVALID,
 	CMD_BOOT_FROM,
+	CMD_DCD_SKIP,
 	CMD_FUSE_VERSION,
 	CMD_SW_VERSION,
 	CMD_MSG_BLOCK,
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 5eb4b9612c8..96ece28bd6c 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -14,6 +14,7 @@ static soc_type_t soc;
 static int container = -1;
 static int32_t core_type = CFG_CORE_INVALID;
 static bool emmc_fastboot;
+static bool dcd_skip;
 static image_t param_stack[IMG_STACK_SIZE];
 static uint8_t fuse_version;
 static uint16_t sw_version;
@@ -41,6 +42,7 @@ static int imx8image_check_image_types(uint8_t type)
 
 static table_entry_t imx8image_cmds[] = {
 	{CMD_BOOT_FROM,         "BOOT_FROM",            "boot command",	      },
+	{CMD_DCD_SKIP,          "DCD_SKIP",             "skip DCD init",      },
 	{CMD_FUSE_VERSION,      "FUSE_VERSION",         "fuse version",	      },
 	{CMD_SW_VERSION,        "SW_VERSION",           "sw version",	      },
 	{CMD_MSG_BLOCK,         "MSG_BLOCK",            "msg block",	      },
@@ -88,6 +90,9 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 		if (!strncmp("emmc_fastboot", token, 13))
 			emmc_fastboot = true;
 		break;
+	case CMD_DCD_SKIP:
+		if (!strncmp("true", token, 4))
+			dcd_skip = true;
 	case CMD_FUSE_VERSION:
 		fuse_version = (uint8_t)(strtoll(token, NULL, 0) & 0xFF);
 		break;
@@ -1024,7 +1029,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, false, fuse_version, sw_version, outfd);
+			img_sp, dcd_skip, fuse_version, sw_version, outfd);
 
 	return 0;
 }
-- 
2.20.1

