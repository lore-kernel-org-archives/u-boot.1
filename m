Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0101606ABA6
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O0u8Vt9Q;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=jo+rVVNB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC72781137;
	Mon,  2 Nov 2026 16:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IQKgCjqQTKua; Mon,  2 Nov 2026 16:21:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FB238117B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636470;
	b=ev0zWgCIvZ6nFIIOVAi/f9K7RozQXx9V1vU6FWFkLHkIAOGKMTkCci+xZuaRuFu2tvb/
	 3WTi9FvxEN4PNzAP379zxd5iYQWs56cBEs/KPwnex1oiAjyRQL+NHuQ5lwLzepvRV/Vup
	 jTfyjpHbcXfgfcRJmzLxBYWWndK3DyqY3PG0R3bZuxHmFERXlTaNRnRia2I8rLSxka1RX
	 jme1aQqhxf5mnOsMHG92XlAOaCBO3PziCVYmqqhNUUTt1uY+FPMRzJr7XWTX3lJZW5qbB
	 7g6toAHF855A+F+ycUisKFDmETPjQFT1ocVLp+PRUCaUvcl3XLkPLHBSHxOYIQWA7fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3eEmlsjqJC9EMKNW4hUmlWv6dvi2JQaKcwqBS9fBjqc=;
	b=kzMCEUuw7QSnx+3bzmc9PZweyRI7H1tZJSVsYazsXpY4qbqv7XjCmReoAzCJBafTjXed
	 R38X6F/07CtnJXCIYhgsh+lImVPyyXhH9osC3OLzQCd4JGHme7mjir36sOGdfWPmdrKZg
	 jOQnXUYBHic0hO8lowpBrLDebzK3VYcaDaFhZ+Q7bhIJrZRHSEoPZI8OLyGycIDMW7CPI
	 I6HEeN5u1902QQ1oucyXosN4b1933uG53UDeutx11ltDIBGMcJWuQ9Pgzu7WgOHwEL+pT
	 K0nDZQjzp/Yc4J5rrY2L3nnhlgI6bAhC11eotcCcHY6uLLgcXtmfRqERCJGG/15pIHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636470;
	bh=3eEmlsjqJC9EMKNW4hUmlWv6dvi2JQaKcwqBS9fBjqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O0u8Vt9QxbhY1rRxCS8q+MKMmvlaqmf0D5fCoZAJeHuYIvrXv2bwTwuTaSBs2bXyB
	 eVYZwKQzE8cnC030aF/LmNdWvSjBIKI5xiqldtm/jCkPgLITCKESL+S4DRD+YxtarR
	 gjqfNekF94V05HVHHE6lO86WtLCyxcsSbyYZVUsXZp44tgxQtJBN/D4ehWskSJ5NjS
	 NG+3PEixRBJfidePsvyNKYbrbSVPP1qOMNkvfUDuQDIKF59Bwk8T15AybXn/rtEssa
	 lVl/Lwgk4GMIruUh43SJl+x0QrBCGSmFg28DU8Gc3SZkwlAfdAKWiQ87vNHF7N/jnJ
	 0ycCvbYfcTb6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FB238117B;
	Mon,  2 Nov 2026 16:21:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 88AAE2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E9A46060D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b_PkhhLnKfvd for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 536FF607EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636454;
 b=hvpAgFD5wfCDtwwmU142xf7Lt/ns1LS1ZW/h7uDRxtQg6XYydar0QIYsLBYq1S3lKwK0
 6Ad7EolJwRZ/iIV24Saz2jfXLGuYPGXp95TrbOg4LRsrwhTv0/ZqQt1+4uxm+r9HIuR8s
 6XHa0lDH572wcYfZdxRxgcEuetkwQjXVDlf6p0t85Lu4biBhGHsYtEesOue/YxOOgayJP
 PIR9jJWzDzxPoWDEPhH1+qMcybMfdJmMTZCqleuwvnOfuCfqqksuGb14wH0d7v2FZthDa
 SZJCMIVvmO0M3rb4ZPYF93bsqlR9skJ95nsWjfeIBn7NUZRdvp9/rn8cZcsj3yX6bJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636454;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=3eEmlsjqJC9EMKNW4hUmlWv6dvi2JQaKcwqBS9fBjqc=;
 b=kOm129TGnrMVGxm7gaW84VuTrVvcL1cG0vDy+dbQyPNslIx7wn75QiytgqinPsUrwBqC
 vWJtZGYEsfwZNr6Y1c2zUwwS1cMZXN2SF14Wov9kqbO5s5Rm3Ff6rXT9k51K+agGL/fkP
 085Qvpp85JpMTct/wGSIEZRnQ9gic5ou+9TR2OqAWqF+p2iDYZpQyhvKIntm+3dccmVru
 ytJVVZ+fyd1D1kJiAt2wWlRKV/774VRMQb6qC1HRueRHNTmR563D/n9CjlzI5IbZQDtxf
 7cPiEznp8Hj/VH/uX6ypFZOXDOa9k9BzGo/M2msuSEgsKmN1A+UYgjFSvhq2XzgXgPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=jo+rVVNB; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=jo+rVVNB
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 536FF607EC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eEmlsjqJC9EMKNW4hUmlWv6dvi2JQaKcwqBS9fBjqc=;
 b=jo+rVVNBfLmH87L/PqOvSJo0MCC31PU471oaoftR8DU+/lRtCVbbixSaPeVMhgr8+A1Dcz
 o+Y8lbNokWzqUORbWXAFnqnm5e05MqNL6KbR7Si0T61LKoWekFV/MWBKLNrNU2sMEGgmwk
 c2JAJLXm7J1S4axSFkkca329TjnDoCuVFqQ6r9ETXPUq/aHs2lRIKi0us5SmPP0/26uqmx
 W2Kq/syoCbxDm4fi/0b30ADvOoE7uQgaERGCvN/nWLC+Sa2+yGRuTGnB5OXxA1+RMytEI6
 HH0dVu7yjyLexl4AjOaZ+rXDP75yElJwanJBHItv9OemAQZLw+6q/xVeRPHaKA==
Date: Mon, 02 Nov 2026 17:20:26 +0100
Subject: [PATCH v2 09/12] bootstd: rauc: Optionally boot with a built-in
 command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-9-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6415;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=zQ4zUcaeAroh9nnrW01Gy9j722vjAvRm4GUryD0HOaE=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjrjZbCYhMvcDf59Prm9NmeI7o1eu7cVjCeED7M3zX
 KKXipl0lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATKRgFyPD/XVB1qcd65aKKSwN
 euDwWuXCw6zlSYvrtvB67ksX3lniychwZBpL6smt84t/WoWc3LNxzbUNJkqrtJZPn3ygq75ksvZ
 UVgA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RAUC bootmeth boots a slot by running boot.scr or boot.scr.uimg
from its boot partition. Nothing authenticates this partition, so with
verified boot, whoever can write it can run any U-Boot command, for
example booting an unsigned kernel or changing the kernel command line.
Signing the script does not close this reliably as source skips all
checks if the environment sets verify=no, which RAUC systems must keep
writable for BOOT_ORDER and BOOT_x_LEFT, and it accepts a FIT script
without configurations, whose signature is then only checked against
keys required for images, not configurations.

Add CONFIG_BOOTMETH_RAUC_BOOTCMD to set a command built into U-Boot
that boots the slot instead. It sees the same environment variables as
the boot script. The boot partition then contains nothing that U-Boot
executes.

The option is empty by default, which keeps loading the boot script.
As for the partitions, the bootmeth keeps the command in its platform
data, so that tests can set it at runtime.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Keep the command in the platform data of the bootmeth, so that tests
  can change it at runtime, and always build the boot script code
  (Simon)
---
 boot/Kconfig                 | 16 ++++++++++++++++
 boot/bootmeth_rauc.c         | 23 ++++++++++++++++-------
 doc/develop/bootstd/rauc.rst |  8 ++++++++
 include/bootmeth_rauc.h      |  3 +++
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 072108db64a..27640817068 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -976,6 +976,22 @@ config BOOTMETH_RAUC_PARTITIONS
 	  partition names, this also rejects MBR devices. A value consisting
 	  only of digits is always taken as an index.
 
+config BOOTMETH_RAUC_BOOTCMD
+	string "RAUC built-in boot command"
+	default ""
+	help
+	  Sets a command to boot the selected slot, for example
+	  "run distro_boot_rauc". It is run instead of loading a boot script
+	  from the slot's boot partition, and can use the same environment
+	  variables as the boot script, such as distro_bootpart and raucargs.
+
+	  As the command is built into U-Boot, the boot partition does not
+	  need to contain anything U-Boot executes, which helps with verified
+	  boot. If the command runs an environment variable, that variable must
+	  not be writable at runtime then, see ENV_WRITEABLE_LIST.
+
+	  Leave this empty to load the boot script.
+
 config BOOTMETH_RAUC_DEFAULT_TRIES
 	int "RAUC slot default tries"
 	default 3
diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index acf9413591b..4f4927d5cd1 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -527,6 +527,7 @@ static const struct distro_rauc_slot *find_active_slot(struct distro_rauc_priv *
 
 static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 {
+	const struct distro_rauc_plat *rplat = dev_get_plat(dev);
 	struct blk_desc *desc;
 	struct distro_rauc_priv *priv;
 	const struct distro_rauc_slot *slot;
@@ -575,10 +576,12 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	if (ret)
 		return log_msg_ret("env", ret);
 
-	/* Load distro boot script */
-	ret = distro_rauc_load_boot_script(bflow, slot);
-	if (ret)
-		return log_msg_ret("load", ret);
+	/* Load distro boot script, unless a built-in command boots the slot */
+	if (!*rplat->bootcmd) {
+		ret = distro_rauc_load_boot_script(bflow, slot);
+		if (ret)
+			return log_msg_ret("load", ret);
+	}
 
 	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
 		 slot->name, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
@@ -599,9 +602,14 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	}
 	str_free_list(boot_order_list);
 
-	/* Run distro boot script */
-	addr = map_to_sysmem(bflow->buf);
-	ret = cmd_source_script(addr, NULL, NULL);
+	if (*rplat->bootcmd) {
+		/* Run built-in boot command */
+		ret = run_command(rplat->bootcmd, 0);
+	} else {
+		/* Run distro boot script */
+		addr = map_to_sysmem(bflow->buf);
+		ret = cmd_source_script(addr, NULL, NULL);
+	}
 	if (ret)
 		return log_msg_ret("boot", ret);
 
@@ -619,6 +627,7 @@ static int distro_rauc_bootmeth_bind(struct udevice *dev)
 	plat->desc = "RAUC distro boot from MMC";
 	plat->flags = BOOTMETHF_ANY_PART;
 	rplat->partitions = CONFIG_BOOTMETH_RAUC_PARTITIONS;
+	rplat->bootcmd = CONFIG_BOOTMETH_RAUC_BOOTCMD;
 
 	return 0;
 }
diff --git a/doc/develop/bootstd/rauc.rst b/doc/develop/bootstd/rauc.rst
index eee8d103fb9..247ae474f0f 100644
--- a/doc/develop/bootstd/rauc.rst
+++ b/doc/develop/bootstd/rauc.rst
@@ -44,6 +44,13 @@ The boot script must be located in each boot partition. The bootmeth searches
 for ``boot.scr`` first, then ``boot.scr.uimg`` if not found. It will search in
 all directories of the bootstd list of prefixes (``"/", "/boot"`` by default).
 
+Alternatively, ``CONFIG_BOOTMETH_RAUC_BOOTCMD`` sets a command built into
+U-Boot, for example ``run distro_boot_rauc``, which boots the slot instead of a
+boot script. The boot partitions then need no boot script, and the bootmeth
+executes nothing from them. For verified boot, the command must load only
+signed images, and any environment variable it runs must not be writable at
+runtime (see ``CONFIG_ENV_WRITEABLE_LIST``).
+
 When the bootflow is booted, the bootmeth sets these environment variables:
 
 devtype
@@ -63,6 +70,7 @@ raucargs
     kernel command line arguments needed for RAUC to detect the currently booted
     slot
 
+The boot script or the boot command can use these variables to boot the slot.
 The script file must be a FIT or a legacy uImage. It is loaded into memory and
 executed.
 
diff --git a/include/bootmeth_rauc.h b/include/bootmeth_rauc.h
index 0faeab192d4..88b17f10235 100644
--- a/include/bootmeth_rauc.h
+++ b/include/bootmeth_rauc.h
@@ -14,9 +14,12 @@
  *
  * @partitions: Boot and root partitions of each slot, given by number or
  *	by name, see CONFIG_BOOTMETH_RAUC_PARTITIONS
+ * @bootcmd: Command to boot the selected slot, see
+ *	CONFIG_BOOTMETH_RAUC_BOOTCMD. Empty to run the boot script instead
  */
 struct distro_rauc_plat {
 	const char *partitions;
+	const char *bootcmd;
 };
 
 #endif

-- 
2.56.0

