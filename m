Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5AFCD6E64
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 13:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE4886D9D;
	Wed, 11 Oct 2023 15:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA12986DD8; Wed, 11 Oct 2023 15:06:37 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22A786D01
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 15:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp78t1697029546t8m0lh20
Received: from ubuntu.. ( [111.196.129.4]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 21:05:45 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: 8DxqQiJJYvJeWaA+VTplLtOaZ6P5jJlRDFlmMJ+WhGsSiQGwc8tw2Rlk0QRYj
 pMpMwNouZ8g1bn4TeoqHWl4UgNsmwvcN7jNNNzJ1E+zb5FaM3IUaDSrPae2wP4ETaINe+UB
 YgLIt1ThIXglpH/zVeVduX0i39KhXvNX44NVrIUIvkkFrID6UwnchySMdaPREslGaYPWPZo
 kUxdW6kLHfcNATfg5VQKDS6/8qqp0bvDqRNge7YAYnf0EuqAkq/WB4nAMO4YGAKVL8BfJDl
 kz1uNgv0FMp3ly8sm5bM+1ruTA7PkdL9yrlRkociAw3lF/bCbF6Y8JvjrPbfkv2eq8QZtWq
 Ho7ICnZTSO5cYDnY1NOBuIi7EkDlu+3dpwyrFui
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16302493678616131305
From: Bin Meng <bmeng@tinylab.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Subject: [PATCH 3/9] cmd: kconfig: Make ufs prompt look similar to other
 commands
Date: Wed, 11 Oct 2023 21:05:29 +0800
Message-Id: <20231011130535.3964-4-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011130535.3964-1-bmeng@tinylab.org>
References: <20231011130535.3964-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

At present the 'ufs' command prompt does not look similar like other
commands. Update it.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a59c67e333..0b4e76c262 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1536,7 +1536,7 @@ config CMD_TSI148
 	  Turndra tsi148 device. See the command help for full details.
 
 config CMD_UFS
-	bool "Enable UFS - Universal Flash Storage commands"
+	bool "ufs - Universal Flash Storage commands"
 	depends on UFS
 	help
 	  "This provides commands to initialise and configure universal flash
-- 
2.34.1

