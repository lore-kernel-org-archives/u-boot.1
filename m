Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8369BC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4044D876F4;
	Wed, 31 Jan 2024 12:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QDukzsUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5EE8746C; Wed, 31 Jan 2024 12:12:51 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64B987C39
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 12:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-59a8ee08c23so253270eaf.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706699566; x=1707304366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kciYJNZYjKPX3+jaEJgC81JS0GkYBkCy5iTG5hyXqpA=;
 b=QDukzsUHLwwGm9xpbiASyzssk9u6yEPUglilD3pUM5TcbM+hT+384Jrr+6OTLJPyjw
 Q7quJKcNQRiQX282Uk5EFyzgtTZPemjjFPh8MCUVhPIpk52uYRxv1F1Ay+cjt8QYvRLy
 kee2lR7SI3m5EwRtcovZPrNDur2xskp/O+Dx4FclLiS93DbQc9nFlSw8pHMRu5g2LIk8
 5HOwhRuM0/Ucymev0jcgeGTTDsQ5C2FUiW6gZu8EHqgE2FMKZplHCjLRAYso4TGMAomc
 tWbHIfrZnniWYgH+hUEZQwfBxZKgd5xbfLjLjlDizrn19SjSGSZubr8yz8+5uUrXq22C
 R3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706699566; x=1707304366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kciYJNZYjKPX3+jaEJgC81JS0GkYBkCy5iTG5hyXqpA=;
 b=AmYV9DfJXWK5S/nyeCfJu7JUOu0eX2gT83GyIZtN98JbgBGaT4jqz8OMtQhX0kOxhJ
 42NY4lqLnjrbkS5EVWjJWfk7DFUsVNHoDb4TvjRcCcIcFaaJ9HkqcELrnWHVn+/MjKWQ
 bSx3/s0Atav8pwCbaAgl0crg4dTMG7GDRu01gzoMbeJBMCor2ceRm/onbpw5f3UaeyhQ
 iywEnMH6bIATqItSYj22o95KntncF+I7tUif6nPdwo6UOcVFGwr+nK2RAbCN0jEnhRKJ
 Ey9JRQYSdZ/G/5Suf7HXXNBfCit0vKQSkgOiokqzfSd7RxI5eWRDYV5FIbCVUXieAnn0
 BOzg==
X-Gm-Message-State: AOJu0YwS4gXnrDs14vftGuKs/VjtCt3kqHOKt/wrC/CN79OaWuDQcmB8
 4S156Bepi7bPr7vVbOZiDNnA9nKxBzeS8VioC7C8zKSFZYSO5tXz
X-Google-Smtp-Source: AGHT+IGPqfozzQkwGQhzCxIDCdS6pSGj3d9tzsgub5gssOy+JJn6UGG5pd0u8/rPgevUYE3ugJL6PA==
X-Received: by 2002:a05:6358:6a56:b0:176:cf6d:20a6 with SMTP id
 c22-20020a0563586a5600b00176cf6d20a6mr1049217rwh.19.1706699565272; 
 Wed, 31 Jan 2024 03:12:45 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUK7eC28Lg1R9eIIR7czTqikIIp6rlAsPH3hx1cB2a6Ti0xiD2HxWYtGFeMJii0SrolBgfdIYqQQHqe15CiAm3T66HC9i3hxUbqKLmg4gZUFbgk1CmCXZBkqzPWTQvGt0zObeCv8iNulYuEp9ehwgC6jbmHmTlyaJtKXmtnYi2gW6Vy8OYYG8Q1pFTeTVSZy1EDXzVivWEGyNXtBiLpgGH0Ud1MC1SQ2tcb8SMXH+G7cDtxMNqGa5eiLBkoLI5DXbc7Vi/k029RHa+83bbrJuEjTM3At7QDHGL5vgZi3qWQ68/LUUlAN7H2zJ4vXTiZmyaPzHc4Xmk5W+glCg==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a62f201000000b006ddc03c425bsm9535007pfh.180.2024.01.31.03.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 03:12:44 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/3] cmd: rng: Add rng list command
Date: Wed, 31 Jan 2024 11:12:17 +0000
Message-Id: <20240131111217.30124-4-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131111217.30124-1-o451686892@gmail.com>
References: <20240131111217.30124-1-o451686892@gmail.com>
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

The 'rng list' command probes all RNG devices and list those devices
that are successfully probed. Also update the help info.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
v2: update commit message and rng help info
---
 cmd/rng.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/cmd/rng.c b/cmd/rng.c
index 52f722c7af..b073a6c849 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -19,6 +19,22 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct udevice *dev;
 	int ret = CMD_RET_SUCCESS;
 
+	if (argc == 2 && !strcmp(argv[1], "list")) {
+		int idx = 0;
+
+		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
+			idx++;
+			printf("RNG #%d - %s\n", dev->seq_, dev->name);
+		}
+
+		if (!idx) {
+			log_err("No RNG device\n");
+			return CMD_RET_FAILURE;
+		}
+
+		return CMD_RET_SUCCESS;
+	}
+
 	switch (argc) {
 	case 1:
 		devnum = 0;
@@ -56,12 +72,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return ret;
 }
 
-U_BOOT_LONGHELP(rng,
-	"[dev [n]]\n"
-	"  - print n random bytes(max 64) read from dev\n");
-
 U_BOOT_CMD(
 	rng, 3, 0, do_rng,
 	"print bytes from the hardware random number generator",
-	rng_help_text
+	"list         - list all the probed rng devices\n"
+	"rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
 );
-- 
2.39.2

