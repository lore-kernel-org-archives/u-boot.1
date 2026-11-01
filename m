Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB4606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eiVR2Vz5;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=We+E6ceN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FC8440533;
	Sun,  1 Nov 2026 21:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Nu8fAp87BMU; Sun,  1 Nov 2026 21:32:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76C504054B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568747;
	b=az5yJH+s+zI5X7KwNhcVEc7mNuMgcdLkuxfQbGmrVipsIAgUNrXp9PiDAkm28iwB5b+i
	 wHUBYolFAztlNcKh8QfbV/+9P0C6lEbRkWiZkJup2+2TvK5gY8OUXKtL47MYf6GJypAwU
	 6Gj9NyOvgAIpDY5KjEClNh899RPTsQPFNBdsrTNmHiRTocV5RdRLdhBPrgbU5gkm+7Mwz
	 0x4sjmogT8Vs5URbn/5rLjZ2rzkA0X7gXM/lCMEkgsnvasVxopmelJm+vP5JUwTVr3HsJ
	 53Z1WuhA9L5pIvS8sD7kD9K4wZrRFdfdmuXBkwzNny/LvjHQYu7pSvaIx0E/QlBbRmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ACa2o5a44V3JmvX1AUhBq63xxVb5nLFunepkQ3CIWKw=;
	b=YRCmjdaWP+IwSv4SuZsDG+fsC2wdAZtd9ED2U+bunhvWvvdCFlZbvka45ftEivyBCF06
	 RQcQxW3bWqxIRLKF1DuS9cozVzn4W5ZJrIHw+zA0hjfqCdptZtzaZwrj/8NuX4vGg3PWy
	 aYrZGrbkPjPYPbF3bTr83PJsL1dwiMqDUmGTYdNiF5phFsZV2R+LalITTaAU44IjCW0hW
	 ELT4KIraRTJe7T9wkFCGI0CKmhjM4LxHv0E1q38UnMSzqjLTRD0qheoxbY608wnlM8DEA
	 M3acTIEuecvXK3esVoa26GcCAIF5mTOv9ISCJKWl6k6GUXtPfl42UBffZt5iV9PR/mw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568747;
	bh=ACa2o5a44V3JmvX1AUhBq63xxVb5nLFunepkQ3CIWKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eiVR2Vz5WKfrXoAOiZjlIxVICycw0/vbybHLoba4Km0Wm/kZ5dLCOk51tsHzLwz8X
	 nQjty0hSn2PrVD1AlNvnM8ZOSdZsummV56AU9B9TGMyyJr/KdD3Mmb7azz3GEg/LI+
	 /HxPwKQFUh8PL0ad6IKZcNfRHYwngprP/HKePg/3b3S/F4fd4bT8n/NLG293HOuGkZ
	 vwsDfpyrwDd7DrvqA2YcZPL2GK1EWYQMEu4JxF4TMW1VplkL6O/xQ0B2mnmF6oUiGW
	 gL7i/w0K6B4wJ2OIfCAsX5KCzfTR8g4+69Jsq7eTbKPqtigLYHhBRkBjmGgUDUSps4
	 Dt9ndx690c/OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76C504054B;
	Sun,  1 Nov 2026 21:32:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D7F02AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EE1860612
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:32:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sv57LIRrkPgW for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:32:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C423B60606
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568745;
 b=ggBROZgxKzIfw4+JS3wvX0hqDvuXKlz08ym2TPJLKtQsz/7q+WIzXPyqc4w6b51lzJw6
 9esqyHIQBQEVnUUfnE/3Zg8fR7i5e2cB/0DMsD11RUBJePMB5hNWDvnpbG+imA26zQ9Nw
 mfuNkAISgWFkjib0Szh2XDcI6uR51PeCW0FCXe1SdSPUwMsEiGEy8Ooj31YqtG5jjjSjK
 hKBQQK6DrgK6oF9bjjGvAaH6hA/7qBFTFPdk+eRiOmGjmocadZwKcQjxgC/tGqb1D2uMq
 y8UeXaA4eEGvYnZzp1OZ8PMRfe3PuFT7VOlKujIQPe5TyzB7I8e7ntl9DeSKfimhGCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568745;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ACa2o5a44V3JmvX1AUhBq63xxVb5nLFunepkQ3CIWKw=;
 b=lcSjGqIc/Eyl4npacbB79KRHwzx6D809ZlZ1tqwXCkLc9eiPV/iI4951EL3LNQZMNh9d
 HRl1jGn83iXjYB38GGHN/YpGl/+oV2yq2b3uc+py4dXcDlDaXD6F8VGjR2lXJzjoNr9hp
 Ax7E9mUsHg6RxvgWac5VT1sYfSpJYQDUFK4TXjwhnJ6dl/N0SQLDmtYalSBLdizWk9l2k
 8oLYRpy7q/NRz+WAQt2nQnM86ReXTs3bRU8v1SgD0QWqKo+/wbB656qUvwPVnTO+YDB39
 34Y9n8Cvjlk4A+aL6MLBv29uXhU9zkq+S7ArotpKpJK9AQWFUdk3hje5MG99xpXKI/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=We+E6ceN; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=We+E6ceN
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C423B60606
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id EDA71B00539;
 Sun,  1 Nov 2026 22:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793568742;
 bh=XYZ09vk/8lwnYBA6vBHMih4fIKW8RR1ma7H6pgGp+b8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=We+E6ceNNXi1DJUIRJSAsAA7Oat0QRbmVNV6jS0QoyLD/orRXP+IbHvaEs11m2Li9
 Tl6hpb12wdd/FdRH9Eb+oAYAmBKeCwYw3siR/9xA2G9I9sXjMWxqtsEToDYxwqyhk1
 SO5NgJMiOZk97noU2X/CFsYa50TvzJgjTUZ9LGJGzh4GyhenGNZZZKprmkiP9gSP4L
 3A/M44R+5OjKhnfpTweaSV2fPNtURJT3qOU2sqpxyHQ+esNTkqna1F5G1RSu68ZyIe
 15p8ybJO/7/6qx2nOFpc1MvVw3rQRYTp4ysj1m/C23uQW5A3kSUZvHp13fSBNJAaQs
 H/pxTqAXL3eaQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 4/4] board: nbxv3: get carrier from the NOR overlay
Date: Sun,  1 Nov 2026 22:31:10 +0100
Message-ID: <20261101213111.483600-5-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101213111.483600-1-vjardin@free.fr>
References: <20261101213111.483600-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For boards without GPIO neither EEPROM identification, ${carrier} can come
from a NOR segment, an overlay, imported by ${cfg_import}.

The selection priority list becomes:
  1. the saved environment (saveenv)
  2. the NOR overlay, imported by ${cfg_import} when the environment
     defines it, for boards without GPIO or EEPROM identification
  3. the RCW build stamp
  4. NBXV3_CARRIER_DEFAULT, the build's default (fallback).

The NOR overlay is an environment image of ${cfg_nor_size} bytes
(CRC32 + data, as made by "mkenvimage -s 0x1000") that sets
carrier=<name>.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v2:
- new patch

 board/nxp/lx2160a/nbxv3/carrier.c | 24 ++++++++++++++++++++++--
 doc/board/nxp/nbxv3.rst           | 28 ++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/board/nxp/lx2160a/nbxv3/carrier.c b/board/nxp/lx2160a/nbxv3/carrier.c
index 26b079a1d3a..daa6fce639d 100644
--- a/board/nxp/lx2160a/nbxv3/carrier.c
+++ b/board/nxp/lx2160a/nbxv3/carrier.c
@@ -18,10 +18,12 @@
  * ${carrier} comes, first match wins, from:
  *   1. the environment, e.g. a saved one:
  *        setenv carrier nbv32 && saveenv && reset
- *   2. the RCW build stamp in DCFG SCRATCHRW13, see below
- *   3. NBXV3_CARRIER_DEFAULT
+ *   2. the NOR overlay, imported by ${cfg_import}
+ *   3. the RCW build stamp in DCFG SCRATCHRW13, see below
+ *   4. NBXV3_CARRIER_DEFAULT
  */
 
+#include <command.h>
 #include <env.h>
 #include <hwconfig.h>
 #include <malloc.h>
@@ -114,6 +116,15 @@ static void nbxv3_carrier_disable_mc(void)
 	printf("Carrier:       bring-up RCW (no SerDes IO), MC not started\n");
 }
 
+static void nbxv3_carrier_import_overlay(void)
+{
+	if (!env_get("cfg_import"))
+		return;
+
+	if (run_command("run cfg_import", 0))
+		debug("Carrier:       no usable overlay at ${cfg_nor_offset}\n");
+}
+
 void nbxv3_carrier_env_init(void)
 {
 	const char *carrier = env_get("carrier");
@@ -130,6 +141,15 @@ void nbxv3_carrier_env_init(void)
 		return;
 	}
 
+	nbxv3_carrier_import_overlay();
+
+	carrier = env_get("carrier");
+	if (carrier && *carrier) {
+		printf("Carrier:       %s (from the NOR overlay at %s)\n",
+		       carrier, env_get("cfg_nor_offset"));
+		return;
+	}
+
 	carrier = nbxv3_carrier_detect(digit);
 	if (carrier) {
 		origin = "RCW build stamp";
diff --git a/doc/board/nxp/nbxv3.rst b/doc/board/nxp/nbxv3.rst
index 0e3578b5742..4806f9eada1 100644
--- a/doc/board/nxp/nbxv3.rst
+++ b/doc/board/nxp/nbxv3.rst
@@ -86,9 +86,33 @@ FIT image at NOR offset 0x1000000::
 
      => setenv carrier nbv32 && saveenv && reset
 
-2. the RCW build stamp, see below,
+2. the NOR overlay, imported by ``${cfg_import}`` when the environment
+   defines it, for boards without GPIO or EEPROM identification,
 
-3. ``nbv30``, the built-in default.
+3. the RCW build stamp, see below,
+
+4. ``nbv30``, the built-in default.
+
+NOR overlay
+^^^^^^^^^^^
+
+The NOR overlay is an environment image of ``${cfg_nor_size}`` bytes
+with ``carrier=<name>``.
+It is outside the environment slot, so wiping the
+saved environment keeps the board identity.
+
+``${cfg_import}``, ``${cfg_nor_offset}`` and ``${cfg_nor_size}`` are
+defined by the board's default environment
+(CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE + CONFIG_ENV_DEFAULT_ENV_TEXT_FILE),
+or by a saved one.
+
+::
+
+  cfg_nor_offset=0x520000
+  cfg_nor_size=0x1000
+  cfg_import=sf probe 3:0 && \
+    sf read ${loadaddr} ${cfg_nor_offset} ${cfg_nor_size} && \
+    env import -c ${loadaddr} ${cfg_nor_size}
 
 RCW build stamp
 ^^^^^^^^^^^^^^^
-- 
2.43.0

