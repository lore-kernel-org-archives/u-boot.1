Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EB0C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF8C882BE;
	Tue, 18 Jun 2024 16:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YXiCfUXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA06A8832D; Tue, 18 Jun 2024 16:52:26 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB60880F5
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111aeso3564082a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718722344; x=1719327144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=APsfDYpjbL3QIFe/WQ7U3v0IMzPGES2v4YYzEUEhC6k=;
 b=YXiCfUXwMOmsV4FcD/MqBNweUHObIcYZxwUNRHpO006CiWMuraUk+xe2A+eWRNJKXv
 YS9Q2g72MQkOe6jZNr1B7G+DVTbRAS+HlU5e6MY/gMdhZZwBs31CHyUq3vc9vU+Ide2J
 pJXAY6nFTGK2Ssut1pCDRM2bLWt96ArAOwyUxxtRPAOrc2N1XHhvltaiTBr/DYzAMCwC
 MQ2c4DyFWt4bw/L1lSgQ/aslV8WAc/B2lfLO71Er4HjK3SxHTfzDxDR95uMljUV+qILx
 IywDhtSLyx0fTepmcSAHR8br724HeKW7lEyKuhO6bjJoVps6Oa20FlANjx9Y1yhDdqE5
 58PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722344; x=1719327144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APsfDYpjbL3QIFe/WQ7U3v0IMzPGES2v4YYzEUEhC6k=;
 b=qKaYg1wB9JboBOXBS3eUJHYPW03ucmlI/hsh5GrGbqH5dfVXG4a2FWvWeD+nPQoVgt
 C7e1TJYHvN9W+3eOsqG1iqmvw9WD2fgMZKlJovP5bz7fdAyXBjVbBwKT4q0PkqUu4a+2
 WNmWghtBomV/1MztXb/bliMErx2ckQWs6vauTTd7o7iXPPHsBJ7mwUR73RbeYLVhiVSU
 2GBt8LW7meuGH7ny4qYkYjAZtvyxhFZhOcADzNYkLQOqu3z4o8/PBhe7Emlw05sPAozM
 GTqkJeuqvXaBa17YJozytC2I0qfp89aiKxtyAGOcrjYtxxpUl60zaWaFNpMpyF1S4yRz
 DFYw==
X-Gm-Message-State: AOJu0YzQ77j+dI7TFGMmVgDqyZABocRHVqPHFB1Q8m6bfeLRECsdi4RD
 wc+AVBj4LE8N90PlkIuFxXexo4ce4WeWPcj+EGH8QtgJJPiZ8h3OQZTRQfbnS5Q=
X-Google-Smtp-Source: AGHT+IGv0SVNZvHbeglr//nxRfADeLQAPKiRZPwREWIvglAx8BNeMpyLrL1eyifZVLPulN2DFXN8Fw==
X-Received: by 2002:a17:906:2c0f:b0:a6f:4de8:f490 with SMTP id
 a640c23a62f3a-a6f60d27cb6mr911099066b.24.1718722344070; 
 Tue, 18 Jun 2024 07:52:24 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f5731cf4csm618900466b.188.2024.06.18.07.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:52:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] cmd: make 'booti -h' not crash the board
Date: Tue, 18 Jun 2024 16:51:56 +0200
Message-ID: <20240618145213.3284922-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Check the result of hextoul() when parsing the first argument to booti,
and add specific handling for "-h" to print usage rather than causing a
null pointer exception.

Fixes: 5db28905c952 ("cmd: Split 'bootz' and 'booti' out from 'bootm'")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 cmd/booti.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cmd/booti.c b/cmd/booti.c
index 62b19e834366..c4029a84e7a7 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -31,8 +31,9 @@ static int booti_start(struct bootm_info *bmi)
 	ulong dest_end;
 	unsigned long comp_len;
 	unsigned long decomp_len;
 	int ctype;
+	char *endp;
 
 	ret = bootm_run_states(bmi, BOOTM_STATE_START);
 
 	/* Setup Linux kernel Image entry point */
@@ -40,9 +41,14 @@ static int booti_start(struct bootm_info *bmi)
 		ld = image_load_addr;
 		debug("*  kernel: default image load address = 0x%08lx\n",
 				image_load_addr);
 	} else {
-		ld = hextoul(bmi->addr_img, NULL);
+		ld = hextoul(bmi->addr_img, &endp);
+		if (*endp != '\0') {
+			printf("## Invalid kernel image address: %s\n",
+			       bmi->addr_img);
+			return CMD_RET_USAGE;
+		}
 		debug("*  kernel: cmdline image address = 0x%08lx\n", ld);
 	}
 
 	temp = map_sysmem(ld, 0);
@@ -108,8 +114,11 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	/* Consume 'booti' */
 	argc--; argv++;
 
+	if (argc && strcmp(argv[0], "-h") == 0)
+		return CMD_RET_USAGE;
+
 	bootm_init(&bmi);
 	if (argc)
 		bmi.addr_img = argv[0];
 	if (argc > 1)
-- 
2.45.0

