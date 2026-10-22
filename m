Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6919606A322
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e1hiRc+7;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CsFkJ/jR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F21640879;
	Thu, 22 Oct 2026 16:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9KrEBppgY4P; Thu, 22 Oct 2026 16:20:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 727B240801
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686038;
	b=IRmhhr3zP1HvwozK3PEDXu4n9aF9bJtfDqy134OE6CwpfU/m2CmHPcThWHJEto2r0qca
	 +Ca+P5BYs5y1QVg69rLSfYaBJbkeotOOGIrS+MbgofdppLyrLDhp00selk4ObSQXqS4oi
	 9gPLy9MDoTucj/9Of6hs5AHudDXEirjynli6j/HUfkqAIbpluYpgvvlSDLQSCVeKvChFF
	 n2sTJJ8gYKWsnVMu9QY2I7k51K62gyFPtklOmmC9FHWc01SnZxIvy1ZqQ/BrHQ3/ZJ0Fv
	 XGEvcpbLnduQH2J5R+K07Qeq95tWU4ByMFo0N1A9K4qNo8IQL1CZjyrWPk5HPi2uPRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
	b=iNzMphdRi/dx0nstQzPVharPHR+xkc8joAXnxu0cShC2hT/l9I1dD3OVIOB+TIB6n1Xr
	 Lp8gPWe8tyIdZgNCYcy1RyPdXUoKkTq5MIJ+h3eULkuoHjYR4mync13yzdhEJpfgdMR2N
	 AZFqxrBVgArmpk/VGqszNljxCsBYZSYppBa3ZvuT++AVf1VruUKCjuHksjjkzGRD7FDFx
	 /LVSzoSpZu9YuZ+W2MaLrEteoi82Tm0LPFJWbeEm3aRqiqEItE5SB5YhWrdpC3PRdATLg
	 9BjbXlqDn3Q2FXMr7O/pHLEpko6gHEYAtipGGNhk7OWxC5gTjGGPi/Jn2q7Jku3173Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686038;
	bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1hiRc+7kxMDo0r8RUPsjbsps7dW8DV5HE7NlOHqQto7iFgFweOqK9O9yU6a/cjdp
	 OvD/aVerw8wkTQ/i2/T/DcadWjdFCNpsTTjy6nIuVvge3/OshYzap+YZoYUf/QZjzc
	 iRFIz1qmKfcO0hZnRPNtEqA1iqLYBadgCtpJFOJUl86M8HlXzEPyi4QnxLacJIwsOo
	 pq9OlZisKY4PTFK6Jn3Kvqn+XCfVP9BLoGpCXXLPsaYy6WBQv/CLEok472ZTwGAaNP
	 s1CVy/5f9XdZYos3IRwHq9pIaQ5Yi9AuASoMNfEH9+3vbkWxtSQ3NFR+3a4epRUin7
	 XNEsaMX8ybKeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 727B240801;
	Thu, 22 Oct 2026 16:20:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EF7B3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70F2C8117B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BVEkN-gtFWo for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4143781174
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792686032;
 b=o0V+my+CR0kjhzbYmHvt/MWxN4rDFv2VTNcp+Of2luY42B/4CB60tVjLWXf9c6qAK7N7
 sgzbR1CYOaFH9cHmzhofNHeajLWrdrvx23mW1LopE+GIseTMynm6+pP4+ZZKK1qxMh9a2
 WLFhpKwbGIRt8bXCgzdP2VFYWKCWrp0iI4nGJIY8cxg03NxgzbpBDH+n75HHsLliIJ8zU
 mrYWhdpEvP3R9GkOgGYcmYNvhCf+ytXxXeA325u+rp3fTntPE0/jsSyQxYNXvOTqkktR+
 YtgBtBgR6Apmp73ZjTIWELGXF+5NlRnsoHBteOXUSSlq60X+MeSoiHwUFcJen+aLCkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792686032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
 b=TUK60uIySe1HvyzUefXRnsJy/HJTw0uJofa4s4rQzC346kBaABpOcw7crtUqYaO+YvHW
 Gt2Nrpuo/5UkJWELClwcwyvoqLEXLl7yRn5+K7nsLg+4Jk9yvkXs2BUo4z5RIl5r7rs6y
 hM85amgoZWSE1nlg2gpmarzQJF7TV2ABvD9ixPYT1Z2iVoQbYNcoeTj6Z3hjfCNtWK5c7
 8qISk11NMOPVP2/JxZwbrxCacFpCoAh2ZDjVmALBXuqxx8OxEzix0/vW145sQHhDokN23
 3hi+ja+f42nmbgDH6TPle/1b+AM3Z8BHLpiB2FChb2UJz3A6+eiP/GsVQ7iZzg4L2GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="CsFkJ/jR"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CsFkJ/jR
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4143781174
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:31 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso7151855e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792686030; x=1793290830;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
 b=CsFkJ/jR29e9i38racBenDz+40kfF4vBqPaMfn2u6k0qAHt5XguOXXmouOj4MvqDlS
 FBs+kbL0Mf823XTdJFwnGKP23YJkWkrywjXfyltzqbv9pP5SQU2fsy/ay2bZvVBGHgRD
 tqcZorTwPH3xQUSgusGizTm0pjVKHLAffByBkqj3SbRgAdZtL76RUQNSjoXRl5ubtm3Q
 VRFNomRgBpBS6w2NXbIGxEdlZvZ9RaosWX+d9LkrIvSHvAIbs3IFCqgnDoopHQ5Vb+ym
 kOwXMier3mu5tAOk7GmpbakL8q3XPvdmrLp0smVXIdzyKbdoOXdzM6EXLv8qCw5A8T89
 sC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686030; x=1793290830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
 b=zrR1CbCMCqdE0M7cpeDidQvBcDCMV9e6ihfoQM/wRl+g3vKfEdMc2BGt03rqpCNPhW
 Orf6DVvFURVECWfNz9ScBHzE08U9iJqhxZHK0sYwzzFFoYgapcNbVk3qwMP4vBUQz49c
 9WrhecchVxk1le/0B0wb4UdBrMnlIfR3r1g9XJWOIad/dkXifx0p5OFfppw8IRdOQNlG
 w9CBbSyf94lujARHcZQrb+jBa6wQiWq6w4Yk9JYBc1EAZz/Mi5uvI/4aSgpeZlyzqHSM
 XeQyRRaRRjoyhQMf2KU0xs4/t8x6M94X6u567LtoAfcsCSxR/QzPHcgqFghMI06cQwo/
 n1KQ==
X-Gm-Message-State: AFq9FYLdzOKPWvG3YvtH/sfm4Eqt+b2pPilygFS61VFBPFL2Xp++R+pt
 Vr7Pu+zqHPaAZ0EmX2FXdK7y5cSHYii4vVejgCXotMU8lwpJ3JW81/ArWJccGqxzkkA=
X-Gm-Gg: AYBFou2doNpCpWGdcaDF2rZxxgSFghAchKjwzyJgZVO54pMYKXM3xCOw90vlF32bz6K
 ee69TTiDLvSYTf5oMTcBMw4KuPc9vMBPacWqd0Eqv3b/F7tmqJhuIkW/utWIGqC8Ypi2UlfhBTH
 4Xm7yzFP9SifUaEUPQ9E0Drqd0QS5TDhQVqq6r76mVj8JWFCv0eLDJ4f4A0lvzkySOZxeyqls89
 2EnC95Bu4KNLLwhsljNEEVQtCTayonY1ewB0J47HEha8OavN3wEnHRt3oqy+GKtvC06d7dEaoYX
 yk7cWwrFd+ZH5yniaI9TdWMm1qnyuFQngHTa0scYXfX106kYtxtylmHOUjtWUfyoshiADApAr1q
 DByh2Ju4ckttEvNKxXXNmlTCvx3GhHMtmHLsvBtHcmHhRZJ8GSfcnIp4U4G7sivAqxXmP4ZPsJl
 JM01hfmbF5NQKZXzfq/3zOyjCLVTFeCOg/1r3pmGk94kM4ehTbK7hNcEBfNYnvHq04nnZINNyns
 7I5AejKQyVDOlHHqcIZBJEiKLOFqNdmz9XitDmqwOtK2Ta95VIp/PVS2ZyYOD6swQsVSgF6w3am
 MeY3s3L7uGRSq+jfnf84jPiXibljbvsDpppsDLSuXb9zsujCgg==
X-Received: by 2002:a05:600c:524f:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4a210f9390emr902715e9.7.1792686029462; 
 Thu, 22 Oct 2026 09:20:29 -0700 (PDT)
Received: from [127.0.0.1] (mob-83-225-32-96.net.vodafone.it. [83.225.32.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21029928fsm6905905e9.3.2026.10.22.09.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:20:29 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 18:20:14 +0200
Subject: [PATCH v2 4/5] cmd: fdt: add 'fdt fit' to prepare a devicetree for
 other boot commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-fdt-fit-v2-4-4140e0c4d5a9@baylibre.com>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

A board may keep its devicetree and overlays in a FIT while booting
a kernel or EFI application from elsewhere. Boot scripts need a way
to verify and assemble that devicetree without asking bootm to boot
the FIT.

Add fdt fit to prepare the devicetree described by one FIT
configuration and copy it to an address chosen by the script. The
result can then be passed to bootefi, booti or another boot command.

Always check image hashes and enforce any required configuration
signatures, even when verify=no. Reject chained configurations:
signing each configuration separately does not authenticate the
combination.

Only copy the completed result after verification, overlay
application and destination checks succeed. The script remains
responsible for loading the FIT and stopping the boot on failure.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/Kconfig           |  9 ++++++
 cmd/fdt.c             | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/fdt.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7124b961dc2..c81534810c5 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -577,6 +577,15 @@ config CMD_FDT
 	help
 	  Do FDT related setup before booting into the Operating System.
 
+config CMD_FDT_FIT
+	bool "fdt fit - load the devicetree of a FIT configuration"
+	depends on CMD_FDT && FIT
+	imply OF_LIBFDT_OVERLAY
+	help
+	  Add the 'fdt fit' subcommand, which loads the devicetree of a FIT
+	  configuration, applies the overlays the configuration lists and
+	  copies the result to a given address.
+
 config CMD_EXTENSION
 	bool "Extension board management command"
 	select CMD_FDT
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 7e2abf96103..94b2376d072 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -11,6 +11,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <image.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
@@ -145,6 +146,79 @@ static int fdt_get_header_value(int argc, char *const argv[])
 	return CMD_RET_FAILURE;
 }
 
+/*
+ * fdt fit <addr>[#<conf>] <dest> [<length>]
+ *
+ * Load the devicetree of a FIT configuration, with its overlays applied, and
+ * copy it to <dest>. Images are always verified, so the configuration must
+ * also satisfy any required signature in the control devicetree. Unlike bootm,
+ * image load addresses are ignored and configurations cannot be chained.
+ */
+static int fdt_fit(int argc, char *const argv[])
+{
+	struct bootm_headers images = { .verify = 1 };
+	const char *conf = NULL;
+	ulong addr, dest, data, len;
+	bool owned;
+	void *fdt;
+	int ret;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	if (!fit_parse_conf(argv[0], image_load_addr, &addr, &conf))
+		addr = hextoul(argv[0], NULL);
+	dest = hextoul(argv[1], NULL);
+
+	/* Only a single configuration authenticates the whole combination */
+	if (conf && strchr(conf, '#')) {
+		puts("Chained configurations are not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (boot_get_fdt_fit(&images, addr, NULL, &conf, IH_ARCH_DEFAULT,
+			     FIT_LOAD_PREPARE, &data, &len, &owned) < 0)
+		return CMD_RET_FAILURE;
+
+	fdt = map_sysmem(data, len);
+	ret = CMD_RET_FAILURE;
+	if (fdt_check_full(fdt, len)) {
+		puts("Invalid FDT in FIT\n");
+		goto out;
+	}
+
+	len = fdt_totalsize(fdt);
+	if (argc > 2) {
+		ulong newlen = hextoul(argv[2], NULL);
+
+		if (newlen < len) {
+			printf("New length 0x%lX < existing length 0x%lX, aborting.\n",
+			       newlen, len);
+			goto out;
+		}
+		len = newlen;
+	}
+
+	if (CONFIG_IS_ENABLED(LMB) && lmb_read_check(dest, len)) {
+		puts("ERROR: trying to overwrite reserved memory...\n");
+		goto out;
+	}
+
+	ret = fdt_open_into(fdt, map_sysmem(dest, len), len);
+	if (ret) {
+		printf("libfdt fdt_open_into(): %s\n", fdt_strerror(ret));
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+	ret = CMD_RET_SUCCESS;
+
+out:
+	if (owned)
+		free(fdt);
+
+	return ret;
+}
+
 /*
  * Flattened Device Tree command, see the help for parameter definitions.
  */
@@ -281,6 +355,10 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_SUCCESS;
 	}
 
+	/* Load the devicetree of a FIT configuration */
+	if (IS_ENABLED(CONFIG_CMD_FDT_FIT) && strncmp(argv[1], "fi", 2) == 0)
+		return fdt_fit(argc - 2, argv + 2);
+
 	if (!working_fdt) {
 		puts("No FDT memory address configured. Please configure\n"
 		     "the FDT address via \"fdt addr <address>\" command.\n"
@@ -1124,6 +1202,11 @@ U_BOOT_LONGHELP(fdt,
 #endif
 #ifdef CONFIG_OF_SYSTEM_SETUP
 	"fdt systemsetup                     - Do system-specific set up\n"
+#endif
+#ifdef CONFIG_CMD_FDT_FIT
+	"fdt fit    <addr>[#<conf>] <dest> [<length>] - Load the fdt of a FIT\n"
+	"                                      configuration, apply its overlays and\n"
+	"                                      copy it to <dest>\n"
 #endif
 	"fdt move   <fdt> <newaddr> <length> - Copy the fdt to <addr> and make it active\n"
 	"fdt resize [<extrasize>]            - Resize fdt to size + padding to 4k addr + some optional <extrasize> if needed\n"
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 493ed895bc7..88222a9939d 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     fdt addr [-cq] [addr [len]]
+    fdt fit <addr>[#<conf>] <dest> [<len>]
 
 Description
 -----------
@@ -48,6 +49,46 @@ If the `len` argument is provided, then the device tree is expanded to that
 size. This can be used to make space for more nodes and properties. It is
 assumed that there is enough space in memory for this expansion.
 
+fdt fit
+~~~~~~~
+
+This loads the device tree of a FIT configuration and copies it to `dest`. The
+FIT must already be in memory at `addr`.
+
+The configuration `conf` is selected as for the bootm command. If it is
+omitted, the configuration matching the control FDT is used when
+CONFIG_FIT_BEST_MATCH is enabled, otherwise the default configuration of the
+FIT. The `fdt` property of the configuration lists a base device tree followed
+by any overlays: the base device tree is loaded and the overlays are applied to
+it in order.
+
+Each image is checked against its hashes, whatever the value of the `verify`
+environment variable. With CONFIG_FIT_SIGNATURE, the configuration must also
+satisfy the signature policy of the control FDT, so an unsigned configuration
+is rejected when a key has `required = "conf"`. A configuration signature
+covers the hashes of all the images listed by the configuration, so it
+authenticates the base device tree, the overlays and their order as one unit.
+
+Unlike bootm, the command does not accept further configurations appended to
+`conf` with `#`. Each of them would be verified on its own, so a chain could
+combine device trees in a way which no configuration lists and nobody signed.
+List each valid combination of a base device tree and overlays in its own
+configuration instead.
+
+The command fails if any image cannot be loaded, verified or applied, and
+nothing is written to `dest` in that case. Unlike bootm, the command ignores
+FIT image `load` addresses: only the completed device tree is copied to
+`dest`, after checking that the destination does not overlap reserved memory
+when CONFIG_LMB is enabled. Alignment and decompression of the base device
+tree are still handled as needed.
+
+If the `len` argument is provided, then the device tree is expanded to that
+size, leaving space for later changes. The command fails if `len` is smaller
+than the device tree. Without `len`, the device tree is copied at its own size.
+The working FDT is not changed; use `fdt addr` to select the result.
+
+This subcommand requires CONFIG_CMD_FDT_FIT.
+
 Example
 -------
 
@@ -66,3 +107,37 @@ address and expand it to 0xf000 in size::
     Working FDT set to 10000
     => md 10000 4
     00010000: edfe0dd0 00f00000 78000000 7c270000  ...........x..'|
+
+Load a FIT holding a device tree and its overlays, then copy the device tree of
+the `conf-a` configuration, a base device tree with one overlay, to 2000000 and
+inspect it::
+
+    => load mmc 0#firmware 1000000 fdt.itb
+    1771 bytes read in 1 ms (1.7 MiB/s)
+    => fdt fit 1000000#conf-a 2000000
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Using 'conf-a' configuration
+       Verifying Hash Integrity ... OK
+       Trying 'base' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Trying 'ov-a' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    => fdt addr 2000000
+    Working FDT set to 2000000
+    => fdt print /test-node
+    test-node {
+            ov-a-prop = "ov-a-value";
+            base-prop = "base-value";
+            order = "ov-a";
+    };
+
+A boot script can prepare a device tree kept with the firmware in this way and
+pass it to the boot command, stopping if any step fails::
+
+    if load mmc 0#firmware ${loadaddr} fdt.itb &&
+       fdt fit ${loadaddr}#conf-a ${fdt_addr_r}; then
+            bootefi bootmgr ${fdt_addr_r}
+    fi

-- 
2.56.0

