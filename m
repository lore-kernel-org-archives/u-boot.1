Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F952EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF89864C4;
	Wed, 23 Aug 2023 10:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gqPfMTFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11258864C3; Wed, 23 Aug 2023 10:38:29 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41E6864C5
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1c5451a1fbaso3368831fac.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692779905; x=1693384705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fbj4+CS5XP8HOjTXq8r3mUS/RTh5dScSFj8QgpwkN/w=;
 b=gqPfMTFco638iBXXK/Ng7PizzZLQxW3d93m5eSYA5I6iM5+TWfMpcHK26e+HkmSR0c
 nfv1r5Y27oEkuZ4+W/5iYgDpol3A0zqbl9tK8ALOOC9AGm9On9EN2TBmkZPx93yL7fYI
 P7EQUjhmIY5ZdXARMoAvB7Uu820XGES8UQ6Sfo6MKk2s4/7gVGqToHZ78KMGZwb64Px0
 wFcbGD0YewbOCGUOfKCxPbAEg5aett0xz2a7hjC+VNfSD88vx7psuMeHl852/BmuXeUa
 OrFOapsfgCl9hdf/oCxawzK0KVTOSYUt17rnqT1FvZzi+QqeKRGMy4TYL0zBJQiOohYY
 zDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779905; x=1693384705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fbj4+CS5XP8HOjTXq8r3mUS/RTh5dScSFj8QgpwkN/w=;
 b=WnLLeST9vMBh69eB/1rQ/3yjdAWNMJpePWguzjNnhdad0286TZgK/ZIk/e42mf7p3A
 C8m8zSwBjXVfrkIAOP4idU5wtWiQ66P99vOakSSoU+U9AgbS1FNUfCplP46Wli8Lqgaf
 WCXYYBu0CFWekRNK+QsSqYqFUbIdpV9ayl6AmPPHxakWSdbgf/vWRfaEq54qAHBR9Frx
 9qZi1cQlX+oYoGBAWvg9KJrxKuNmgwW6QtrsHDtZu9LGHnbNuVlKsF8ttXSUX7L9Ki8Q
 y6bZPzbNYGQ9PRbvGUoWQZYDBmtnjQZmaMAg4REXBfrIW8wUhw6lwgJB6OWftOnRIBIC
 nVJw==
X-Gm-Message-State: AOJu0YzMaFRtSU+v3WeoBhuljMC7VGKjQ8Na+03QHlSi6Dd4M4PuBX/o
 9AmpOOos049bGan+d4BP5l6z/GOX/B/mdR0vRqg=
X-Google-Smtp-Source: AGHT+IHbm5Jowoa0BTAHdzIr8kCoV1Axk23GibDCZx0h9qaoYpSDnhypm7FnLZY/2SrPhpNZaNyPRw==
X-Received: by 2002:a05:6870:d0c6:b0:1bf:8c9a:9a2f with SMTP id
 k6-20020a056870d0c600b001bf8c9a9a2fmr13723410oaa.25.1692779905318; 
 Wed, 23 Aug 2023 01:38:25 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 25-20020a17090a1a1900b00268b439a0cbsm9918394pjk.23.2023.08.23.01.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:38:24 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 1/2] cmd: efidebug: add uri device path
Date: Wed, 23 Aug 2023 17:37:19 +0900
Message-Id: <20230823083721.1318097-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
References: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
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

This adds the URI device path option for 'boot add' subcommand.
User can add the URI load option for downloading ISO image file
or EFI application through network(e.g. HTTP).

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 cmd/efidebug.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 0be3af3e76..62f867df2a 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -829,6 +829,44 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 			argc -= 1;
 			argv += 1;
 			break;
+		case 'u':
+		{
+			char *pos;
+			int uridp_len;
+			struct efi_device_path_uri *uridp;
+
+			if (argc <  3 || lo.label) {
+				r = CMD_RET_USAGE;
+				goto out;
+			}
+			id = (int)hextoul(argv[1], &endp);
+			if (*endp != '\0' || id > 0xffff)
+				return CMD_RET_USAGE;
+
+			efi_create_indexed_name(var_name16, sizeof(var_name16),
+						"Boot", id);
+
+			label = efi_convert_string(argv[2]);
+			if (!label)
+				return CMD_RET_FAILURE;
+			lo.label = label;
+
+			uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
+			fp_free = efi_alloc(uridp_len + sizeof(END));
+			uridp = (struct efi_device_path_uri *)fp_free;
+			uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+			uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+			uridp->dp.length = uridp_len;
+			strcpy(uridp->uri, argv[3]);
+			pos = (char *)uridp + uridp_len;
+			memcpy(pos, &END, sizeof(END));
+			fp_size += uridp_len + sizeof(END);
+			file_path = (struct efi_device_path *)uridp;
+			argc -= 3;
+			argv += 3;
+			break;
+		}
+
 		default:
 			r = CMD_RET_USAGE;
 			goto out;
@@ -1492,6 +1530,7 @@ static char efidebug_help_text[] =
 	"  -b|-B <bootid> <label> <interface> <devnum>[:<part>] <file path>\n"
 	"  -i|-I <interface> <devnum>[:<part>] <initrd file path>\n"
 	"  (-b, -i for short form device path)\n"
+	"  -u <bootid> <label> <uri>\n"
 	"  -s '<optional data>'\n"
 	"efidebug boot rm <bootid#1> [<bootid#2> [<bootid#3> [...]]]\n"
 	"  - delete UEFI BootXXXX variables\n"
-- 
2.34.1

