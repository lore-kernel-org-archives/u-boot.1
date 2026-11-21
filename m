Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5D606A32C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tahk9WMo;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=oB+o4K2I
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B42A606AE;
	Sat, 21 Nov 2026 12:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s1aUjtc2mQsY; Sat, 21 Nov 2026 12:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A241A606C9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264551;
	b=a5B9kQ5DADeHXP9L87xiSscMu2x1Pi0FNh35ce/NYCu03RCRTr8K6/8O3wgeUTMlo134
	 pSNUB0qIVLfxtiSQUSRDQFEb1ZdJKRgICDeoVXLjhD1arWWPmiLuj1/SARrg1WzZcJ1aN
	 zfbAh35Y3ZWFTdcErb3YMRtEqWcwhp5vG4/aNAj5dUCrUQQI8RnN3s+jALT6nmEjJdRCN
	 x08V7tvXXgjuBoVfaZ5IuNo/I2e66G6VnpreKNYn46kR7SU3rRiYErckqtdLUzEi9KvsW
	 h4giJ0jdXO4HbivGxoRia2VZrzSY0JUa2FKun5ZgEuVUTrvdCaKFEvaY1fF0924LquQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B5s12GvHnng4EoM7IaU15QSwKG+sf5R9ky+tliDxOhY=;
	b=ddLhXiIL14e84IrW4AjmykiByoQKUU3aBVvBtEMIP6L32DE/63fWhCjFjATSooqgwUZI
	 S+6CT3+wg6X3g788BSe43oV1EMhLEl2lQHOX26YVWcAfS/SY6IfC5OssIGBTEBE0Mu5ZM
	 kZc+EqUK6mOeLKpNO6TjOVpM5mz9GlhRL3IqJ2wk36DiuU3OcE69k69E3tHPT98NDxmVs
	 ZjBspm7xmJDFVucc16GmrljApwcB93fXaDQCUPjwjnVrF98brTzk6IxahAzvdCIFYOhHn
	 GLHsmtuBynI/gVE2kefdRRwCf9gfSiWXHkemJvrMGGQFQR95dDbJez4Dzy8w8ekLz+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264551;
	bh=B5s12GvHnng4EoM7IaU15QSwKG+sf5R9ky+tliDxOhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tahk9WMoEmMeWyYmTlvjdkuRHu8jicRlPXCCMLvX3r/TBtXWG9Qz0sphSW3t78cX+
	 JK7U97GvqoNSCA3IK7r+Q9WAqME1Xx+ZOFPHxY/lMpjla10XRKbTQscmBM4yAdqtIP
	 Ohel/Xt53MGiatWUkgD7IScOZgWgdbiUTFh+2J4UWnIsM8DEzbJbDNdUFhgFpxdJ+6
	 8/JMSpnSpYgJ/5Bb/iA5mWd4JVLdAfLf7JO0D56e8fGZzwDPSYFIjsxvOnco3Z1L2m
	 2ImQ6qjEzIheiQ9/o/9QVpvCPS60jNp5SvfLSrMJ+bEOs9iqQNql95laSoM2FKyoCO
	 rTZYf95frnB2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A241A606C9;
	Sat, 21 Nov 2026 12:35:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 350AA9C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27093400F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7pYcIEHXhSAR for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1E94240012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=oB+o4K2I
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E94240012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:45 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso1224322f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264544; x=1795869344;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B5s12GvHnng4EoM7IaU15QSwKG+sf5R9ky+tliDxOhY=;
 b=oB+o4K2IWcvowoBYk0+rJp+0sOfYHmivdX6OeBLxCODF0Jeqr4t1P+V11o8/F2fPUm
 FGKlD8zt+ubF5Jk5MiSrVNzXstSnO49w7f/Y3NdJEVnz39BOCkpkBi9V4a64eAnszapN
 E8WZIsDvaLv+DEIVxuM+mpeKsXPpseJNWgdbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264544; x=1795869344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B5s12GvHnng4EoM7IaU15QSwKG+sf5R9ky+tliDxOhY=;
 b=OErPbdHZtNz/uIQlnY/vPo0YP4HZTBh5eArLvV1s7slfwE8iAKvBVbeUH1t9vWig5x
 rF7hrkrL8gRHYW8g40r6TNmdFoFgwiEZ/BhR6KjuFPQxtyljb9t5wdiOqyT2GXmYR7Sk
 wjqzvnAHrGJHtsbyNpFgKyUtQMP+fNnP2qGwPX+6fRnUB34jIzSrRQ5TbgknhzgIBcwk
 2ghXf6SDu4ugvg8i40MYe80nQNLaXT+kdrE7U36toxpPnTLnlb1jcGKUzQw19YPvXH9F
 J0shaMypTxAKifJW7RpcdrzIq8xpY4swhAqUjngkoVIKkHKhxujippKLdcnIvS4UAtvd
 UwuA==
X-Gm-Message-State: APuU4Z/luecLo/A5QKnUkoszGi+R/GBADghiuM7cLUdU/2U4eJkKRQv6
 OBkAJptsmAjLn6C/HcpPQDlni+nwlhFTjDxtAtQwt2xdmKs+YoHu8L8m5uPi80QaIOji6Eg41ga
 1tRFY
X-Gm-Gg: AZFdTZcyjHb/J2sj40j0MnDXwBfZ63TFPISvpyBoH/s8+F9/aFEda1jguLmukTUAAno
 OX9ouH0e/jryhBJG11l+dsmSTWgnFrFIoe16UbeWT16UTsXMMt3K5HpIFh3UolQIqR3ItKd9gpT
 xuzLc6cdxfRgtm1YRQdPpLmntcVo48cvSoeimoJE9gcSQYyx1GkK4Jg0LeL6+WUXfHDsl7QjBIK
 NH011ud7Jtwm8PlPfsVYceoiZOpqkbB6JWmfwq4KKA2JhSD0DIsf+SoGmNr++RhR+TBblWFmGO1
 c+itNnzQsv3h11sYtewkyiz+lydC/KVbPoB/nIqL0Qwh4MLBNuZQhRS2BXi+eoA9IsI6vwbnzpX
 7VqltdPiChlppNoFSLDlla2qHhxpZ49Xgm5nDU8UzEKgwagoD7b49F82SUt0L1JSW6USFL7EWXp
 kpLs69W/yc5mZ2XpcDARBSIqlIDn84cSvK/g4CaSQq4SA+nXWyLZdFjbzmbvnse/S3XCTirTwk+
 f1DUJ1alpqFBIO6gZ3SWolbhXl1q/jU4n92GvIKX2+yHmHxBV1alWAPMw3nVPKlFk7Ee0lQeH5+
 7hNEjYqO3ZDRvU/uD25CAIEY30Z6vxMnJ7eP4sdc5L+HU17qa8DPAUy+nTsHs5Et9XVHF0Q2kp0
 K0eJASdbBPfzmJUR1NqXyMVOE0IKAbi4U1o3nMxZsxZLEu9w4RzYuhCsmbIvCORI2Mv1/FT1oDf
 eqesQhrZfRitjrzk0pKSWgs2r3ND7aL0t5pU6arHTCj1VPDu09
X-Received: by 2002:a05:6000:3113:b0:499:527f:ce55 with SMTP id
 ffacd0b85a97d-4aa5ab78750mr19878688f8f.27.1795264544062; 
 Sat, 21 Nov 2026 04:35:44 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:43 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/25] imx8mn_bsh_smm_s2/pro: support simple frame-buffer
Date: Sat, 21 Nov 2026 13:34:13 +0100
Message-ID: <20261121123451.2471185-24-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If you want to pass the frame-buffer to the kernel, the video output is
initialized by U-Boot, and kept by the kernel. The commit modifies the
device tree to be passed to the kernel just before launching it, to
prevent the kernel from reinitializing hardware that has already been
configured by the bootloader.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Drop the custom boot-on properties added to the Linux device tree
- Drop the #if guard around smm_s2_setup_simplefb()
- Fix the style of a comment

 board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c b/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
index c4a85c4aa440..902d5304249a 100644
--- a/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
+++ b/board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c
@@ -5,6 +5,8 @@
 
 #include <asm/arch/sys_proto.h>
 #include <env.h>
+#include <fdt_simplefb.h>
+#include <fdt_support.h>
 
 int board_late_init(void)
 {
@@ -15,3 +17,73 @@ int board_late_init(void)
 
 	return 0;
 }
+
+static void smm_s2_setup_simplefb(void *blob)
+{
+#define DT_BLK_CTRL_NODE_PATH "/soc@0/bus@32c00000/blk-ctrl@32e28000"
+#define DT_GPC_NODE_PATH "/soc@0/bus@30000000/gpc@303a0000"
+#define DT_LCDIF_NODE_PATH "/soc@0/bus@32c00000/lcdif@32e00000"
+
+	struct dt_addprop {
+		const char *node;
+		const char *prop;
+		const u32 *val;
+		int len;
+	} dt_addprops[] = {
+		{"/regulator-3v3-O2", "regulator-boot-on", NULL, 0},
+		{"/regulator-3v3-O3", "regulator-boot-on", NULL, 0},
+	};
+	const char *dt_delprops[][2] = {
+		{DT_BLK_CTRL_NODE_PATH, "assigned-clock-rates"},
+		/* pgc_dispmix */
+		{DT_GPC_NODE_PATH "/pgc/power-domain@3", "assigned-clock-rates"},
+		{DT_LCDIF_NODE_PATH, "assigned-clock-rates"},
+	};
+	int i, ret, offset;
+
+	ret = fdt_simplefb_enable_and_mem_rsv(blob);
+	if (ret) {
+		printf("Failed to enable framebuffer DTS node\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dt_addprops); i++) {
+		const char *node = dt_addprops[i].node;
+		const char *prop = dt_addprops[i].prop;
+		const void *val = dt_addprops[i].val;
+		const int len = dt_addprops[i].len;
+
+		ret = fdt_find_and_setprop(blob, node, prop, val, len, 1);
+		if (ret < 0)
+			printf("Failed to add property %s:%s, err=%s\n", node, prop,
+			       fdt_strerror(ret));
+		else
+			debug("Add property %s:%s\n", node, prop);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dt_delprops); i++) {
+		const char *node = dt_delprops[i][0];
+		const char *prop = dt_delprops[i][1];
+
+		offset = fdt_path_offset(blob, node);
+		if (offset < 0) {
+			printf("Missing node %s\n", node);
+			continue;
+		}
+
+		ret = fdt_delprop(blob, offset, prop);
+		if (ret < 0)
+			printf("Failed to delete property %s:%s\n", node, prop);
+		else
+			debug("Delete property %s:%s\n", node, prop);
+	}
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	if (IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_FDT_SIMPLEFB) &&
+	    IS_ENABLED(CONFIG_VIDEO))
+		smm_s2_setup_simplefb(blob);
+
+	return 0;
+}
-- 
2.43.0

