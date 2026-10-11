Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528D3CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 00:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0564840811;
	Sun, 11 Oct 2026 00:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aUimwC7DJito; Sun, 11 Oct 2026 00:37:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 015D940835
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791679068;
	b=VVPuOV18Ae20zYUf/pOj3dL8hwY2TUaYdUjQahC4Fri7zJPElLFIIMXJsN1T/udE7Hz7
	 FFG8gEj7hc9uDz1dDwKlvOeujmlJ07c5kerj9GmtWW14BBYJyqgkTULPCqDUF1/1PEsDh
	 jPkaxwKiB1S95eiInaTy1Hsjjfy7dquM+r5xib0ZvCYTA14RaogC97ufQTbE7QmEsAhch
	 RXfzE5J4QlfbKvN8zlkdMd0XHs5pbzdiKpO2N3fOlRn6Sz0lEpR5E+YPAm066A5uPfPeX
	 BN9cJKwLNeQeoBipbgy6VvMG3M/IwTzhIVUni1Vpw99LU14h9QChctsxNMuZQ9tvlkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791679068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
	b=HLaHbSeR4kPDyGC3asgdWdOBXI8PEAH417bEeMCSTU7xf6NwyFSsQxmbVuiJUlaoDvNv
	 yLVkTKGkCrKGEowXYFYUTUyOxSF5eEf7/SiGX+MDPyMKETtFVlb41lYBiEBR2P1nFRbdZ
	 8DdO2bFMhBJd2wy7DnKixtj60EBjW0+9o6atscE8f2UCml+dkvb+SI4s6/1rpILiIhuxY
	 GmF4kqd6E/G0WmECSuxENmnjjvhtDK8GeG40pTwK3kkwRMsm+kwhQWYpvC08iwBC1pMIC
	 T/NMewOOkQhia7KJE/q+wZRIAxddUJLv/jddMLAQhVYcsVNqwXNsQ1hm5Lja86RjvTQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791679068;
	bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q0hJ9zUI8bOh+HkfJze3CNpS9wUSC4KyoHOnhf3WOwf7GR366T5grO/iV5mxgOEhO
	 Xj11y4pV2LeIINA0McXMaeKsy+127/Lw6mKOOhWj2aOF9FM4NWL+TI+Tyy5p7moLiB
	 UnmOiZ5B5wEW9xNM2tIknFXYr6W8CYUx8LSLEoIoOAqW2wmcOFX0mKebfATZyxDcfc
	 qiGlm+yAv6O71o8+mMR1zJPnDgo5IgAnUcnjXfMWT12GrdOzd5/H0KyUyfDizPz9y3
	 OlqzW3n8RGhzuOT/V/NtXu/ueYhQzW3QqOMVCrVjoMlphdAgrgolTU/gvVD3AXfQ1f
	 MCL7jQ3DhyhmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 015D940835;
	Sun, 11 Oct 2026 00:37:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF620105
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9519A60766
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1GUxBZ03qsX for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 00:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84E1E60618
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791679061;
 b=ooIhXLv9ixnwkHEIPaohNSvy1e6VnUVGmNkqgTVIV1E6GVRNK+3qm/HIZhEiU2ykbn6U
 mU7Pg4bZWuDqwmwko1+7I8y6cPdz74NfaLY/NftHwKsQWwfb0tsxpRc4pQaDOaLlmV8ST
 SJT+5c80U3rc8EAX+4KhKI+ZrMfvaHMzdvVsNr+lszIwMDoqHMieHgVeMFtdSmMk2qVLv
 khcbKRj3ZQgr6M78fnCeCDjANVswaIZ9wZ8PK8FQMmU73CFAwGMOcvfXBO033GcJ+A2m5
 ie50IEvuLbMCRq1ky4lA5NjDfq1EeqtYUx4cbZLPnO8Ugebn+ggRxs7s124RlHef7tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791679061;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
 b=ZcjAn6REtwezB/IAg+UkVJ5kP1GeEnd32Lflmb/R8Q6schLHhZKwlHz9ApfcWXwpQiJS
 VbC57nYo5PIi9jox2yQchKkeYAA43CqsH+5WYbADziesN5n4b+qeGflU/VO0HW3En89/S
 kwQtdD2WoIx+B8qda4Axko0RVcZ/1aP+HHmlF8DH4y46AxZ0SiSbDB1HxhG1ZqXwLx2vT
 XhjftSebogfArbZYvpqrIN12XiW9GtlVh0ZLJMzUlFS3HJ49lVB8tLNZkzTk5ulX+8Mzi
 i7XsD/vak6bZ/JSNb508eyoeyIz9/fVTleP8yhwC5F2GLdElpAffMlQH8nmTsDquqog==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TPMVE6Tz; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TPMVE6Tz
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84E1E60618
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 00:37:41 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-48ed188ee81so589027fac.1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679060; x=1792283860;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
 b=TPMVE6TzkiPzYY2Vjp63ZmVN1Bp9OB7NjXquyJSmbE8inkYCeSqdv6QdcUVK+UG92Z
 0s5IYMDiaBN2WQ6UpEPKPXfRZB0L4Wi/pBlPQhOtkLC8fYq1vIUez2iI4R28ZpBpEV8F
 aYiTBy3xrH4yxvndPf8bLOsomy/dE8oyGzStIAHbyAzBcB5QRBQvx9dnnIu3Oq+6IAIz
 VjGxpDkd9JPolwEX5g+2drW12mvAzgBteyp0s7m7PvkhuyuyAZ96N5vHp4wYINPOK8gY
 ZIDDOz/fihht65PGX1t74Ptn9uef2Tq+KoM/vuhg4X2n0i3m437pwyMzfu/PxTad5WMf
 PIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679060; x=1792283860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nb1ehsyn7NK3z7/aozvlZrRYC0d6q1coVbHhbGGDHqw=;
 b=2uz8U9uI+B4x5bQEtNC59fNgMzWISM8GaccfKdHvW4lBBbRuwmaerFaqX9d2dLMFGR
 g+Lq+VBkDuTNYqDxsROdaHflgezkWIuf5Kr73OZ7GouDH3/4Z/Mejc0ARH4alUXMqhbD
 sOdxrTTGQ6VMSWLEQ3P0Mfy8MvHK7J+SSmidsFbSZJxXcbuWYljuifcE0GyL8jGigqPM
 yOhgdt1wHp0MOryQNXU43UkO1ucSqPCU1dSDaDYQkaNY2BMm5znF8SuJFayTgeHuKKIJ
 n5hW1oO/cmUGuoxO7z/1HmTnTBrCmRkD7AW4D6j+4YpoUGl73G17UyxTYM+5XEzVt4SX
 jZaA==
X-Gm-Message-State: AFq9FYIGDnhLCj4NJAOWjYOGBbC2+bdC5SeStrLU0AgUZydbm44AVFpS
 lKyrfSAGeTJvbyM8OiuPrU+RXYdxZhp5O9YJSVCDVAvZksKdwRIjaJt2
X-Gm-Gg: AYBFou0c8hhWliaUlVqSfE3M+IvKKP3tk+FohOZeJHKuKrYdtF51m2Z1Qe0I1H5Sn4u
 zcvVbxLOEWHFYUP/lWvvP2aJZottvuOFNVFOOOdOtTpMUyPkyAIYyvO0cS4km11fNOLPCV83BMw
 3WKMojo65pbuD5LtTFDd4if7KWUy6eHgNICzx1BlSR4OFyvrhFG4S+rhHXeOgdUl4hrkWTWgK1w
 9LQ7Aq5CzteheCgmwzbUZ4d+n9Nhse5SLGKRx1c3wxD+3ywHh1pifoCj0Uq17e/8EntxsUpNxWC
 Ji9SjePaNANRWSsKiM08NblfVm41T9xJChGy+hKVE3XF2apsizX2PfDDRtNSuvkqPfyu8+rfWxi
 X3pLfCoWG8rutW4Yq8637dirbA/qS8p62yZwkN5Oo9JOL0Q/CC62EJrBgK7y+4/TvYy2Wrzirrz
 HyHKcAQbdtUZ7zn2HZNGcEHz9tOZha2db3e1+1awNTuHaS3Mx872ldVRSfrhrqRy6JZySjc3YEL
 4CVPxN4oSgH8kBd2QoKkYbcabEN7jyxGE0MS3Q+gXCVS+YVXwWtEmsRnReBsE8j489sK9z6bYcP
 KI5QKWD16gsovCISH+IqRWYskVAFAe8lwyS4jLq5VT3V+psgjjDLsVCux4CFqPrneBsQw19etcB
 LDTy2pmF4iKU307xIfgF5
X-Received: by 2002:a05:6871:ecaa:b0:492:1de3:785f with SMTP id
 586e51a60fabf-4a2a8a94760mr4392023fac.46.1791679060290; 
 Sat, 10 Oct 2026 17:37:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a84a1457sm5386985fac.4.2026.10.10.17.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:37:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 10 Oct 2026 18:37:06 -0600
Subject: [PATCH 11/16] cmd: bootvx: use stack-independent TFTP downloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-submit-lwip-tftp-combined-v1-v1-11-cf8002c6f401@gmail.com>
References: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
In-Reply-To: <20261010-submit-lwip-tftp-combined-v1-v1-0-cf8002c6f401@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The TFTP path is compiled out with lwIP even though a common
download-only helper is now available. It also parses the word tftp as
a hexadecimal address, leaving the local boot address at zero after
the transfer.

Use tftpb_run() with loadaddr and keep automatic boot disabled during
the download. Reject failed and empty transfers, then use the actual
image load address for the VxWorks handoff. Reject tftp explicitly when
the download command is not configured.

Exercise successful, failed and empty downloads in sandbox, stopping
before the architecture-specific handoff by leaving bootaddr unset.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/elf.c      | 29 +++++++++++++++--------------
 test/dm/tftp.c | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index 53ec193aaa6..a3cc051991b 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -130,23 +130,23 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	 * Check the loadaddr variable.
 	 * If we don't know where the image is then we're done.
 	 */
-	if (argc < 2)
-		addr = image_load_addr;
-	else
-		addr = hextoul(argv[1], NULL);
-
-#if defined(CONFIG_CMD_NET) && !defined(CONFIG_NET_LWIP)
-	/*
-	 * Check to see if we need to tftp the image ourselves
-	 * before starting
-	 */
+	addr = image_load_addr;
 	if ((argc == 2) && (strcmp(argv[1], "tftp") == 0)) {
-		if (net_loop(TFTPGET) <= 0)
+#if defined(CONFIG_CMD_TFTPBOOT)
+		/* VxWorks, not bootm(), owns the downloaded image. */
+		addr = env_get_hex("loadaddr", image_load_addr);
+		if (tftpb_run(addr, NULL) || !net_boot_file_size)
 			return 1;
+		addr = image_load_addr;
 		printf("Automatic boot of VxWorks image at address 0x%08lx ...\n",
-			addr);
-	}
+				addr);
+#else
+		puts("TFTP support is disabled\n");
+		return CMD_RET_FAILURE;
 #endif
+	} else if (argc == 2) {
+		addr = hextoul(argv[1], NULL);
+	}
 
 	/*
 	 * This should equate to
@@ -333,6 +333,7 @@ U_BOOT_CMD(
 U_BOOT_CMD(
 	bootvx, 2, 0, do_bootvx,
 	"Boot vxWorks from an ELF image",
-	" [address] - load address of vxWorks ELF image."
+	" [address] - load address of vxWorks ELF image.\n"
+	"bootvx tftp - download the image using TFTP before booting"
 );
 #endif
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
index b70aa6f4722..45612e066e5 100644
--- a/test/dm/tftp.c
+++ b/test/dm/tftp.c
@@ -503,6 +503,31 @@ static int tftp_test_download(struct unit_test_state *uts,
 	ut_assertok(env_set("tftptimeout", NULL));
 #endif
 
+#if IS_ENABLED(CONFIG_CMD_ELF_BOOTVX)
+	/* Stop before the VxWorks handoff by deliberately omitting bootaddr. */
+	ut_assertok(env_set("bootaddr", NULL));
+	ut_assertok(env_set("loadaddr", "2000000"));
+	ut_assertok(env_set("bootfile", "update.bin"));
+	*net_boot_file_name = '\0';
+	ut_assertok(env_set("autostart", "yes"));
+	for (i = 0; i < 3; i++) {
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->fail = i == 1;
+		ctx->empty = i == 2;
+		image_load_addr = TFTP_TEST_ADDR + 4096;
+		net_boot_file_size = 1234;
+		ut_asserteq(CMD_RET_FAILURE, run_command("bootvx tftp", 0));
+		ut_asserteq(1, ctx->requests);
+		ut_assert(!ctx->autostart);
+		ut_asserteq_str("yes", env_get("autostart"));
+		ut_asserteq(i ? 0 : sizeof(tftp_test_data), net_boot_file_size);
+		if (!i) {
+			ut_asserteq(TFTP_TEST_ADDR, image_load_addr);
+			ut_asserteq_mem(tftp_test_data, buffer, sizeof(tftp_test_data));
+		}
+	}
+#endif
+
 	for (i = 0; i < ARRAY_SIZE(autostart); i++) {
 		timeout = i & 1 ? NULL : "7000";
 		retries = i & 1 ? NULL : "09";

-- 
2.53.0

