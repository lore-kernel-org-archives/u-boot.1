Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22073606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qEmCUxXo;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=DDAVIrpp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0064C4061B;
	Sun,  1 Nov 2026 14:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5JHBi--gcNh; Sun,  1 Nov 2026 14:52:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1593F40620
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793544742;
	b=lfCLRUxi6madPhpJtTiR1CoHoewN2eh4Poq0OYLdk+T7VTvPE0xxjEySaaG4tNnjtZpk
	 MsaU/Znl4EALc+5Bc/IOt7JlJgmy4gqQpCDYcQLQMtvVy9tDZihYWF87gASdrMQq+b+hb
	 j+OhKdyALAGumYvrg7ihQ/aPh9MoUwbCqOAyVG+FOP81+/YGhJ12V5ToCU8WVDyyYdaMz
	 aF3aR7pYlZS1LvnWMZpA4F8hWiq2uC6Vk0516XMqzle4XROKUP/LUjsv5ANiTIoFTsESC
	 NKUddbVQN2N5ex59gHtKtsBhddrFl5dbQgwkohXaeHVo03wFMvL2JmGd5Jx0hrCkyIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793544742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gpiJ84R9o5qCYPswdCR8BRuL1bRmhFYvvVgezCTE01c=;
	b=ajVgQXfjaCEGoAjH/0ZaVPgPwkcqE/FAL/f16fRO13Yq8ACaLidoUSknZiuq6e6lOVJF
	 TgnkMQLB46v9U9Eho+x8t0Z16nF5ZBF7iOhe0tLDX0xUbUEer620cvnJ3N42PBP/YiJIp
	 nyuewAaoMCDb0gf9xD/T3N/5t/asqUUtoJXGCFY0oRoNxQ15Xrf9eUIyHPIE0l7jw9vo+
	 XNiSxACzzkhybc79Rpydw1wvckRW25a2cUXonyhcbpvIh3oo4A/7wnBBqDeN3p4obV7IR
	 XN4lYv2bXh2KtzWvLKfS9gthcXM4niuVZqDJcsvr9f2K2QcZmTGFKrhTliz8cVEFuPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=DDAVIrpp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793544742;
	bh=gpiJ84R9o5qCYPswdCR8BRuL1bRmhFYvvVgezCTE01c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qEmCUxXoeyqiZgEc6lfruOhM7d9DqW23P56J7cuWPdt0aXgGHmlp8QJH8fTRsXvaN
	 F+0yAalzK3HNE69THCJDN1ZPaDIithaSv2Xs75mkguQYc6tr6l+y8vwp5rpm4NM8hb
	 LGjCIZ8miZQb2CC/3RyyttG1juB2lES+g+KLsQBGRC07aY5UiGz6J9941YCR72cV6p
	 eH/3hfLfOYZeY7rC4UntKXplPAybdjqr66cETLYjKGSfpmkgAUV8Z3Z6jpLcFySZMP
	 1lzbQYUnrES+aJRHNxMuw0ltXmqOlEvUrql2JESdktbK0hTVsjmsnPkrR3Rx86TxHk
	 l1TEjd2Yy66GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1593F40620;
	Sun,  1 Nov 2026 14:52:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4915D380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A7B940620
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6J2v9-1JiVI8 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 14:52:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B11D4061B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793544740;
 b=fnCVKGAWUshKJKduJ2hF5gocUcpc1CFHUp05gazlAqXXkTuSRYXLH6HxC4wXak0l4QMw
 V0SkY2ADzSBvab0cJtE2MA8eFa4ZRAoVGR8KRhOT+MspL7zJ/msI1rYHH/c1ysbllagg1
 jcHHLrlYTa0Kn0gvMhcom4sLi4622tVnREsRqeFKmvWZubo65TLo6MpVZ9I5iJU49xRhC
 kDlkrwQK0FH+zvlAUiOyiyYprk331rS7uoNpLmyviu+Crv+mT/PvkzPaO1fKtaVQJXrqy
 V5t1E9fwtV8y2D64juZvV3EHub5KwdCuqqpUZECiK8O85HSdzF53qf9uL5dVfoU1Qzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793544740;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=gpiJ84R9o5qCYPswdCR8BRuL1bRmhFYvvVgezCTE01c=;
 b=ZL2e1FF75KTIQAh/uLarARem5h3BSlPEGtRL5VfkM3xl7bH+jZrQiVYi1AWQDdvAxBUq
 HfeWqb1vcry6Vmd0qqmulFLZjVU+NN9glDkqhtjGQa5kj4Tkmzj0x781YuML+xgNZCisN
 0+9M8IkiJka0gbkzJksge+SgAH6qKVqg/SnvgU8M46/gOjsn70cGAbuKE+sAwUNy7gvmC
 cVkDyoHPMrmvKz6xqDHS6CjBLCJzEtWkeIYeIf+ZgDG65FN83vnSPrhokvmex9fBSDjhZ
 nNuC7p4oXa0HSYOY9FVNWCXn6f2Gq/BojShoc8O96DahDlKdzF7UmuczMbGOW2Frl7g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=DDAVIrpp; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=DDAVIrpp
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B11D4061B
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8506CB0054C;
 Sun,  1 Nov 2026 15:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793544738;
 bh=Sa3/APNDYYwXAByNPdKC/R4yDhkJ8aRg/ANWGsYU+kA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DDAVIrppG8rIqiS+wmOKpTxj7VkHwLQhiFBfDCprA2qVpFpRegZmxR8s2DbHB3Ibk
 PBclrq3zrZWAHasjNix04hcW7J836Nzgq0CxBdtMRj009BKp+BQzdfI9JlxRVhagT4
 ynU3ru/HAI9LUMQbEdzxlNQm1NxOVY+YZMdzRszh4Mix8I7JJKagnDkL5BOR4Uc51d
 SQvPTZAYD7uksIaMGHkMjfSVdSNvmqS0NrXwR7LVvWgrVqyyNACiPH7YIlnIL8jBf1
 PyfWmf9l4sdKQjppUUb5cZ6MZC2QjlZZOBCCP/1wz4Pc1zfiQyqDoXzR1Yl3hgC1z1
 AesyaDdxcpzkw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 3/3] board: nbxv3: serses 1 lane settings
Date: Sun,  1 Nov 2026 15:51:18 +0100
Message-ID: <20261101145119.348038-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101145119.348038-1-vjardin@free.fr>
References: <20261101145119.348038-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Derive the mode from ${carrier}:

  nbv32              100g4x25g   1x 100GE + 4x 25G
  nbv32-40g          2x40g       2x 40GE
  nbv32-40g-4x10g    40g4x10g    1x 40GE + 4x 10G
  nbv32-100g-4x10g   100g4x10g   1x 100GE + 4x 10G

so that "setenv carrier <name>" alone selects the lanes and the data
path that describes them.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 board/nxp/lx2160a/nbxv3/carrier.c   | 97 +++++++++++++++++++++++++++++
 board/nxp/lx2160a/nbxv3/carrier.h   |  6 ++
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c |  4 +-
 doc/board/nxp/nbxv3.rst             | 22 +++++++
 4 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/board/nxp/lx2160a/nbxv3/carrier.c b/board/nxp/lx2160a/nbxv3/carrier.c
index 06a54bed0eb..26b079a1d3a 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.c
+++ b/board/nxp/lx2160a/nbxv3/carrier.c
@@ -23,16 +23,20 @@
  */
 
 #include <env.h>
+#include <hwconfig.h>
+#include <malloc.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <vsprintf.h>
 #include <asm/io.h>
 #include <asm/arch/immap_lsch3.h>
 #include <asm/arch/soc.h>
 
 #include "carrier.h"
+#include "../serdes_split.h"
 
 #ifndef NBXV3_CARRIER_DEFAULT
 #define NBXV3_CARRIER_DEFAULT "nbv30"
@@ -148,3 +152,96 @@ void nbxv3_carrier_env_init(void)
 	printf("Carrier:       %s (%s, not saved; setenv carrier <name> && saveenv to pin)\n",
 	       carrier, origin);
 }
+
+/*
+ * serdes 1 lane grouping of each carrier, as a hwconfig serdes1:<mode>
+ * of board/nxp/lx2160a/serdes_split.c. A carrier without an entry
+ * keeps what the RCW provides.
+ *
+ * nbv32-40g used to need an RCW at serdes 1 protocol 20. serdes1:2x40g
+ * builds the same grouping from the protocol 13 RCW, and it is void
+ * for a protocol 20 one.
+ */
+static const struct {
+	const char *carrier;
+	const char *mode;
+} nbxv3_serdes1_modes[] = {
+	{ .carrier = "nbv32",			.mode = "100g4x25g" },
+	{ .carrier = "nbv32-40g",		.mode = "2x40g" },
+	{ .carrier = "nbv32-40g-4x10g",		.mode = "40g4x10g" },
+	{ .carrier = "nbv32-100g-4x10g",	.mode = "100g4x10g" },
+};
+
+/* Is ${hwconfig} serdes1:@mode ? */
+static bool nbxv3_serdes1_is(const char *mode)
+{
+	const char *arg;
+	size_t len;
+
+	arg = hwconfig_arg("serdes1", &len);
+
+	return arg && len == strlen(mode) && !strncmp(arg, mode, len);
+}
+
+/* Does ${hwconfig} name a SerDes 1 mode ? */
+static bool nbxv3_serdes1_named(void)
+{
+	int i;
+
+	if (nbxv3_serdes1_is("2x100g"))
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(nbxv3_serdes1_modes); i++)
+		if (nbxv3_serdes1_is(nbxv3_serdes1_modes[i].mode))
+			return true;
+
+	return false;
+}
+
+void nbxv3_serdes1_apply(void)
+{
+	const char *carrier = env_get("carrier");
+	const char *mode = NULL;
+	const char *cur;
+	char *saved = NULL;
+	char *hw = NULL;
+	bool set = false;
+	int i;
+
+	for (i = 0; carrier && i < ARRAY_SIZE(nbxv3_serdes1_modes); i++)
+		if (!strcmp(carrier, nbxv3_serdes1_modes[i].carrier))
+			mode = nbxv3_serdes1_modes[i].mode;
+
+	/* Put serdes1:<mode> in front of ${hwconfig} */
+	if (mode && !nbxv3_serdes1_named()) {
+		if (hwconfig("serdes1"))
+			printf("Carrier:       ${hwconfig} serdes1 names no mode, serdes1:%s of %s used\n",
+			       mode, carrier);
+		cur = env_get("hwconfig");
+		if (cur && *cur)
+			saved = strdup(cur);
+		hw = malloc(sizeof("serdes1:") + strlen(mode) +
+			    (saved ? strlen(saved) + 1 : 0));
+		if (hw && (saved || !cur || !*cur)) {
+			sprintf(hw, "serdes1:%s%s%s", mode, saved ? ";" : "",
+				saved ? saved : "");
+			set = !env_set("hwconfig", hw);
+		}
+		if (!set)
+			printf("Carrier:       WARNING: cannot add serdes1:%s to ${hwconfig}\n",
+			       mode);
+	}
+
+	lx2160a_serdes_apply_hwconfig();
+
+	/* The DS250 retimers do not follow the SerDes on their own */
+	if (nbxv3_serdes1_is("100g4x10g"))
+		printf("Carrier:       serdes1:100g4x10g mixes 25.78125 and 10.3125 Gbd lanes, set each retimer CDR to the rate of its lane\n");
+
+	/* Put ${hwconfig} back; NULL deletes it again if it was not set */
+	if (set && env_set("hwconfig", saved))
+		printf("Carrier:       WARNING: cannot restore ${hwconfig}\n");
+
+	free(hw);
+	free(saved);
+}
diff --git a/board/nxp/lx2160a/nbxv3/carrier.h b/board/nxp/lx2160a/nbxv3/carrier.h
index 44b2ce1f047..063765821eb 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.h
+++ b/board/nxp/lx2160a/nbxv3/carrier.h
@@ -15,4 +15,10 @@
  */
 void nbxv3_carrier_env_init(void);
 
+/*
+ * Apply the serdes 1 lane of ${carrier}, unless ${hwconfig}
+ * names a serdes1:<mode>
+ */
+void nbxv3_serdes1_apply(void);
+
 #endif /* __NBXV3_CARRIER_H */
diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
index 69873909733..6dd05b5fe23 100644
--- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -15,7 +15,6 @@
 #include <fsl-mc/fsl_mc.h>
 
 #include "carrier.h"
-#include "../serdes_split.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -35,7 +34,8 @@ void reset_phy(void)
 	 */
 	nbxv3_carrier_env_init();
 
-	lx2160a_serdes_apply_hwconfig();
+	/* Then SerDes 1, from ${hwconfig} or else from ${carrier} */
+	nbxv3_serdes1_apply();
 
 	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
 		mc_env_boot();
diff --git a/doc/board/nxp/nbxv3.rst b/doc/board/nxp/nbxv3.rst
index 8259ca85095..0e3578b5742 100644
--- a/doc/board/nxp/nbxv3.rst
+++ b/doc/board/nxp/nbxv3.rst
@@ -121,6 +121,28 @@ no data path for the MC to manage and starting it hangs the boot.
 U-Boot clears ``mcinitcmd`` for that boot, whatever ``${carrier}`` is,
 and does not save it.
 
+SerDes 1 per carrier
+^^^^^^^^^^^^^^^^^^^^
+
+Before the MC starts, U-Boot should set the serdes 1 lane grouping
+that the MC's DPC and the DPL of ``${carrier}`` expect, using
+the ``serdes1`` hwconfig option. It can be used to
+override the RCW's protocol grouping for SerDes 1.
+
+==================== ================= ==============================
+``${carrier}``       serdes1 mode      SerDes 1
+==================== ================= ==============================
+nbv30                (none)            as built by the RCW
+nbv32                100g4x25g         1x 100GE + 4x 25G
+nbv32-40g            2x40g             2x 40GE
+nbv32-40g-4x10g      40g4x10g          1x 40GE + 4x 10G
+nbv32-100g-4x10g     100g4x10g         1x 100GE + 4x 10G
+==================== ================= ==============================
+
+Example to switch an NBV32 to 1x40GE + 4x10G::
+
+  => setenv carrier nbv32-40g-4x10g && saveenv && reset
+
 Boot flow
 ---------
 
-- 
2.43.0

