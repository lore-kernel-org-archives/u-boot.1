Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BDCC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 10:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9258E877CC;
	Mon, 22 Jan 2024 11:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="ZSm7/seP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA64B87823; Mon, 22 Jan 2024 11:30:49 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F04876FC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 11:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40eabd0414aso11930205e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1705919446; x=1706524246;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ojBft+o4NH3MnntnUZCiwboaWPCbg34oN22C6kwYmQ=;
 b=ZSm7/seP80pOlvCB80ucXnFp3kPiur2+J2LmpC1v2sUoRXjY/2nd+8CxmCIV4knfhH
 susvUSy9+l9seXejGHWUaOVnQ3FlCx2IeBP1N7wbHjR0T5dSu+5ieMauoW9bY3YtziWt
 K/7K1wELwYnQSAG+AHwh+1cUxhzpZtJPRWoJpcKTsY65wJJyxWHiXbPF2YYOgIW20ekT
 sqCexnv3fpfHS9xExACgxotgJPXJGvDTHN3sDFD04D4dt6FuLvZkde859ZRbUdzfRayo
 DEF5xf2rxJqFT1RZa04KFBJvxyt7Ss8CI/lD/MZJXY4kvL2/K5D8JVS0wpjCJDEoP3OX
 hpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705919446; x=1706524246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ojBft+o4NH3MnntnUZCiwboaWPCbg34oN22C6kwYmQ=;
 b=YZKbbTHNXbkfrp3IXz8mnIvLxqx7GlYGeA4eMuEyMTLLRCsaRQd9HlzE+t9imiQMNX
 nzQ0MjJjMyaVy+TWfoA1+Q7LSV0K2v2IsQF3n7QJhNT2ynq06ZciPNlJUZR8lsxo0lM1
 yDQkv2rt7CD/BhttVLat3u8EhdnO5wGEyE+6PQdqDNGtBHedyQJOkzXFNupuBQXovilJ
 UAJ0R5Bx+/rQ1ZbQEhPdej9By23vJPm5vBIuji+2ZaCKZf4IEiZ4QbSsW6bO40d4cW24
 wnWzwhgJlrke49gFeGalMi+bKY+x/oDl4U82zH8p3MomQJ+Xvst06h9PjAPhOup60/ym
 0mXg==
X-Gm-Message-State: AOJu0YzY6/Grh8EtA/L8RmeK5g+2kSt4WzW1KcWYFWm9/RYcsvVngrnv
 Rs4DGx5dmTCrH71hEsdIfOD0nbDhBDHv6aa5vagkn9dWA5O669ppsyz0N3e8w0KVTDXbaU+/tzV
 d
X-Google-Smtp-Source: AGHT+IEdv/YS8AIKSwFxE4ojnCAJ62wkvm9w9xLePEw8BcSpQb7B2EM1CyV7o4qjgDzErmzFn1wZZQ==
X-Received: by 2002:a7b:c38d:0:b0:40e:43d0:8a10 with SMTP id
 s13-20020a7bc38d000000b0040e43d08a10mr1191065wmj.129.1705919446577; 
 Mon, 22 Jan 2024 02:30:46 -0800 (PST)
Received: from P-NTS-Evian.home
 (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr.
 [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a0560001a4400b003392ba296b3sm5217646wry.56.2024.01.22.02.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 02:30:46 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: Romain Naour <romain.naour@skf.com>, Suman Anna <s-anna@ti.com>,
 Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arch/arm/mach-omap2/omap5/fdt.c: ft_fixup_clocks: use
 clock-output-names property as fallback (kernel 5.19+)
Date: Mon, 22 Jan 2024 11:30:44 +0100
Message-ID: <20240122103044.409748-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.43.0
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

From: Romain Naour <romain.naour@skf.com>

Clock names has been updated in kernel 5.19+ with the removal of
non-standard node names [1]. Due to this change, ft_opp_clock_fixups()
doesn't work anymore since ft_fixup_clocks() is looking to the clock
name and ft_opp_clock_fixups() error out with the following message:

  ft_fixup_clocks failed for DSP voltage domain: <valid offset/length>

We can't use the new clock name since several clock are using the same
generic name "clock". ft_opp_clock_fixups() is looking at the clocks
node in cm_core_aon@0:

/sys/firmware/devicetree/base/ocp/interconnect@4a000000/segment@0/target-module@5000/cm_core_aon@0/clocks
  ...
  clock@120
  clock@160
  clock@1a0
  clock@1e0
  clock@210
  clock@234
  clock@284
  clock@2a8
  clock@2d8

When fdt_subnode_offset() fail, we can look at clock-output-names
property as fallback since it contain the previous clock name.

libfdt doesn't provide any support to replace fdt_subnode_offset() by
a new function looking for clock-output-names property instead of the
node name. So we have to implement it in arch/arm/mach-omap2/omap5/fdt.c
for now.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e4920169e7a2a839836d3a0d8cda1bae8caa3056

Cc: Suman Anna <s-anna@ti.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Romain Naour <romain.naour@skf.com>
---
 arch/arm/mach-omap2/omap5/fdt.c | 37 +++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap5/fdt.c b/arch/arm/mach-omap2/omap5/fdt.c
index a8c301c6c28..0ca02e664c4 100644
--- a/arch/arm/mach-omap2/omap5/fdt.c
+++ b/arch/arm/mach-omap2/omap5/fdt.c
@@ -206,9 +206,28 @@ u32 dra7_opp_gpu_clk_rates[NUM_OPPS][OPP_GPU_CLK_NUM] = {
 	{1064000000, 532000000}, /* OPP_HIGH */
 };
 
+static int fdt_clock_output_name_eq_(const void *fdt, int offset,
+				     const char *s, int len)
+{
+	int olen;
+	const char *p = fdt_getprop(fdt, offset, "clock-output-names", &olen);
+
+	if (!p)
+		/* short match */
+		return 0;
+
+	if (memcmp(p, s, len) != 0)
+		return 0;
+
+	if (p[len] == '\0')
+		return 1;
+	else
+		return 0;
+}
+
 static int ft_fixup_clocks(void *fdt, const char **names, u32 *rates, int num)
 {
-	int offs, node_offs, ret, i;
+	int offs, node_offs, subnode, ret, i;
 	uint32_t phandle;
 
 	offs = fdt_path_offset(fdt, "/ocp/interconnect@4a000000/segment@0/target-module@5000/cm_core_aon@0/clocks");
@@ -223,9 +242,19 @@ static int ft_fixup_clocks(void *fdt, const char **names, u32 *rates, int num)
 	for (i = 0; i < num; i++) {
 		node_offs = fdt_subnode_offset(fdt, offs, names[i]);
 		if (node_offs < 0) {
-			debug("Could not find clock sub-node %s: %s\n",
-			      names[i], fdt_strerror(node_offs));
-			return offs;
+			for (subnode = fdt_first_subnode(fdt, offs);
+			     subnode >= 0;
+			     subnode = fdt_next_subnode(fdt, subnode)) {
+				ret = fdt_clock_output_name_eq_(fdt, subnode, names[i],
+								strlen(names[i]));
+				if (ret)
+					node_offs = subnode;
+			}
+			if (node_offs < 0) {
+				debug("Could not find clock sub-node %s: %s\n",
+				      names[i], fdt_strerror(node_offs));
+				return offs;
+			}
 		}
 
 		phandle = fdt_get_phandle(fdt, node_offs);
-- 
2.43.0

