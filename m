Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F18606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GZkfnMAn;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=IFu8R3df
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D788810B9;
	Thu, 29 Oct 2026 16:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CW30pw60DT80; Thu, 29 Oct 2026 16:23:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8A93810AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291028;
	b=sMY53c+nSKNWyrBqiho8sSaAXzoFw0ElD2Ia/izVN+Eom5pBsfdyjinMRCRwDT0Y5CKo
	 LMXPVQ3GhoG5P/UbkLr50p2HejXgq5Rkhxn3hm5vRwZszxu+jXfoXkAo4DeM3y+cnS9Q6
	 frmh8ubUHPRfvu4ejGiL2AA9b5qgzuwJ5Ob7ZSfi6W4C3mggddBmjISRmmuheCXLeWlND
	 CXdB7g+1uQTun5agi7/JKrK225+IeWxpiNCD1szKVhm6zUPI9ffNVVhSe9RJe1FqN4grv
	 WaCJ62eENz15OG9r+5ln66umUTODyiF/iVjkWdd1wD/QZhpvJbQSy3GacS9i/eK/UAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/v66sbp6mFSIZMdFZJ2jN9+TAMlictC/poiEsO2LEU8=;
	b=LPkQd+t6t7ByTov+KwQ5cOU4CAP0lKUmtWoKhmt2PR9v/qxtwvpqZ0L17epyfym6xovh
	 yW66jH5xCO/jfH9bDfvtNexjU/0N6BA/Z7L9PDfimNiLve9+cqE/N4rURxuPXXnBc1nUD
	 Ldae38TnVqxkFBaxdHQPnKV2fwsItotnyeqwVunHnbOp8xEkSjg1V8Z9J1YefNwlYLNM+
	 emwIkbRhoAGZ9nUYPlZGUB3oE21x1wADbULlCfiYM8zNiT+LGD3NNRqQjhIWYC7Atwri0
	 a6ArGYRC0j/l2f6Y4Zhu7LltEQA5aLBOLMTyoxNUfe/hfo5d4cC4zLoBBo28LcbGDHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291028;
	bh=/v66sbp6mFSIZMdFZJ2jN9+TAMlictC/poiEsO2LEU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GZkfnMAnpQxE+uB6erS1TEuDssHuMjoO3rWjM5Aq72p6iZnpaEsqzVcbay6N3siDl
	 O2jSa+pEKEl3fxonqZ/nDCrr5nqbmr4HuWPoyJAY9obMqBPJkWiNB8gb6vyEJLepvv
	 aDfjIoBOPQEeXZeDqj4n0rfGbIeTY0CkQUoBJ4PwfhQ9EhY/JvDDLMtZTFYKzBgHHA
	 ZDj4NsKc0eLm8qBjDcg8ccD2vbVITH5UCm93axpIQ3Z3gqXzdvip4n3JcyqAYGA8bq
	 xeLqVGUhFI44O6hEM/PP8Q6s+1n1LxlPO4mSQkejorCtfP3ACXIhJzP3tB38z4wK07
	 M9r/xQijwkHWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8A93810AC;
	Thu, 29 Oct 2026 16:23:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86424362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A93140012
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKdEKHhEN4F8 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6ADA44008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291011;
 b=CNSvqVUqwkIgj1WBpbjGoB9Vjook2C0kZ0E8c4c3vFnKaCz+hzmideKjcq0n6BdFCbVA
 aIq99wz+k7YYJnO0hnNFO50kT59lVlVkX/Jv1fOoKknZ3/DUNpccQURlChoFWoJ06kd/x
 UQU62SpJfiyLFDVDRqN+Bwd4SUeaWMrMeGUbeVPKKQ6CYunGNxUjSrnCwQoT3UbRXUSXF
 yWDRPkKF3LRb4pX8Qnu30XLxGQ01UudGW/NI57yVw7IlGlNU+9Upl2AHYUcgZ7/r+/8fH
 U3WPnL/xb/pu13AM3uOjN9XLLOfHowPfIzZc60Ss8S7myllt1Rn6gvPdiDpnlTAOACA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291011;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=/v66sbp6mFSIZMdFZJ2jN9+TAMlictC/poiEsO2LEU8=;
 b=BvDeNT1G5SI2FIBHov600dAXutiDwnPMU77SLVvsTWh9aRyZ9duQJaEx/wHYW8IhmuSv
 3b/LMUb3LPtfpAB9wl2/zYHP4ELGpgw4q5O/6L2XTrbsOY1E9eeTON/w/KEztsEcajWft
 nGE9R80WEy99t7oApSjyMU1h9OowMJvA7a96TGf+vi24rhYCHmhjJpk2tnJ9t5FavOGWV
 kIJ53PRF1RuTZZhSAByhrPLI8Cy+NXo6uAV1kEk9bp6srbaAIk4uI8pyAv9Epvb/KwhfZ
 YoJtNzm33O3T+qJ3w/pMuKDEoCKc1wm5AJ/OHwc+GARPy6xlAYtzUfbOgRrdJ8dxfjw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=IFu8R3df; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=IFu8R3df
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6ADA44008A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/v66sbp6mFSIZMdFZJ2jN9+TAMlictC/poiEsO2LEU8=;
 b=IFu8R3df8I4KQfbal9rpxxtPRv3/rKA6BWwIHUxVxbVWo6Y2ba9CArBI+2gMBpoy2L51cN
 0+2AJUlIxzdZYY9u0/xQBWtC5uDwfRwdiNpv/NRfbcEp7Q4G+G11XxZ7tc+0kMUdcAT0Il
 dNzERBftdGnzyNqWa9Tr+3IzSy6amIKTRMg4NzEKaABgAkCCuv+iyClPlYD/L+M4BKwHJL
 6C8FBAj6lONSGkyu8/6rJscEuMRdaa1fXTW/4cJBRXSxl3eQ+tXSUURYB3acJ6y6GmBQao
 J0Mb43N6VfFoNf31apTvlETeO9vrH8dqVkQI82yjaUmwNgnvekwO4UTZNd8dSQ==
Date: Thu, 29 Oct 2026 17:23:13 +0100
Subject: [PATCH 07/10] bootstd: rauc: Optionally boot with a built-in command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-7-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5027;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=yx8ZnkwRko/6kU9DG/CIWnQFz+LhATRMAoH2awGkRU0=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a/9sw0jK9vSVRaueGigdfTgubI0N/YPO9WTJp16+
 9BnJ+vnjlIWBjEuBlkxRRYpfovXtmaxPvLHqqNg5rAygQxh4OIUgInouDD8d1p1Suhf0K46R1+r
 6fM/VOabPG3scXTdu9JsvcGkCZHiQYwMdy+6rdvzr3zn2usVN/OTnPZze176LjZz/oLPJ9Lzt31
 7yw4A
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
executes, and the code that loads the script is left out of the build.

The option is empty by default, which keeps loading the boot script.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 boot/Kconfig                 | 16 ++++++++++++++++
 boot/bootmeth_rauc.c         | 21 ++++++++++++++-------
 doc/develop/bootstd/rauc.rst |  8 ++++++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 5f89c9d86fa..b17f735937a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -981,6 +981,22 @@ config BOOTMETH_RAUC_PART_NAMES
 	  names. Partition names are only available on GPT, so this rejects
 	  MBR devices. Leave this empty to not check the names.
 
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
index ff2e2d48145..dca11500190 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -528,10 +528,12 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	if (ret)
 		return log_msg_ret("env", ret);
 
-	/* Load distro boot script */
-	ret = distro_rauc_load_boot_script(bflow, slot);
-	if (ret)
-		return log_msg_ret("load", ret);
+	/* Load distro boot script, unless a built-in command boots the slot */
+	if (!CONFIG_BOOTMETH_RAUC_BOOTCMD[0]) {
+		ret = distro_rauc_load_boot_script(bflow, slot);
+		if (ret)
+			return log_msg_ret("load", ret);
+	}
 
 	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
 		 slot->name, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
@@ -552,9 +554,14 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	}
 	str_free_list(boot_order_list);
 
-	/* Run distro boot script */
-	addr = map_to_sysmem(bflow->buf);
-	ret = cmd_source_script(addr, NULL, NULL);
+	if (CONFIG_BOOTMETH_RAUC_BOOTCMD[0]) {
+		/* Run built-in boot command */
+		ret = run_command(CONFIG_BOOTMETH_RAUC_BOOTCMD, 0);
+	} else {
+		/* Run distro boot script */
+		addr = map_to_sysmem(bflow->buf);
+		ret = cmd_source_script(addr, NULL, NULL);
+	}
 	if (ret)
 		return log_msg_ret("boot", ret);
 
diff --git a/doc/develop/bootstd/rauc.rst b/doc/develop/bootstd/rauc.rst
index dfbe010a60f..f4e7e02f37f 100644
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
 

-- 
2.56.0

