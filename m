Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2CCC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 14:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D288753C;
	Thu, 11 Jan 2024 15:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gBxjp7Y1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AE1877FD; Thu, 11 Jan 2024 15:39:42 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372638749F
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 15:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a28f66dc7ffso1165736366b.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983979; x=1705588779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wVMMSLbnmuEPTte6BBeZUkwUzzU7PQi11ajtPdJh2LE=;
 b=gBxjp7Y1QwWiB4nAWmc9ijtHpPwtBNvO467ikvPUuofQQVqWg5R75qeHhKcA136I4Y
 VL6zHaYUiatcyqHeAF20CyCdYYHT+Tn9r7TnDzmxU01JnJidKwsZj99cbMtZ7ve2Lk4g
 zuW/gAtiHo6eqZSB/t81ZK0gArfXqyJAunOz4t6+WJYk4QAPzvFT+nYCGL1qp+KKREtF
 U4YaqUxr1oB+QxJhxjV7dqUejRHjE+gqBYiQZmLy1iKJuP5TsCgBAVvyCt2MuSKb7Zws
 n5j3qPqEYrKf6+Dmdiv8QuXWZJ3v9u3JMx72kVKey/km8WmK3Gu1+6c033e0TM+19xtA
 ZDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983979; x=1705588779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wVMMSLbnmuEPTte6BBeZUkwUzzU7PQi11ajtPdJh2LE=;
 b=pjQjvoNsm/OHsnsVPk/xFjl1I4Ul53kGx7YY6kPANvPItSK80jRq8Idfm3a7tKZPHj
 zeMx147/nF2Nb+9OQGvhie/vi2im6b8xkjHJcfsIvFVDR9vV0O4CgmGPDv2YpGwtPQp6
 sNLyhVhocEHKAmRqb9lBpb9osLZ0IRJk9Rb3GjV+xPJI39yGCrZ5WWkmjQdsAHKth8nK
 pwClZ6U0DdhGdU12qlOWp0OF3M1Zy0IVxlNMff7allyfGCdftoLpORPrZU1POzS291eB
 QMaZdoe+7u7wL/8vpFgPvMR3kut987JbXGH5xKPaHuaXHEY3EoV5zMpSIoYN+zQ2ibjS
 K9Fg==
X-Gm-Message-State: AOJu0Ywn1fG14US80IthFtSb/4sePSVHLXoy4rSn5TrGky4zMXrScuf6
 /00s2rFBfWIZtexWxY89Df53vorMU7j9pRI/yUGRAUR/3OU=
X-Google-Smtp-Source: AGHT+IFXbwjf2sqqxzzKojsEZWZO5lbBDppD734ltATf9os1iKdVOcfuNDuEdTv5zgXrPirDhsWuug==
X-Received: by 2002:a17:906:1d6:b0:a2b:a4c1:52ef with SMTP id
 22-20020a17090601d600b00a2ba4c152efmr996056ejj.3.1704983979579; 
 Thu, 11 Jan 2024 06:39:39 -0800 (PST)
Received: from hades.. (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a1709066dd900b00a26af4d96c6sm655062ejt.4.2024.01.11.06.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:39:39 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 1/2] smbios: shorten sysinfo_str declarations and use
Date: Thu, 11 Jan 2024 16:39:35 +0200
Message-Id: <20240111143936.983448-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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

sysinfo_str is a bit too long and makes indentation weird. Shorten it
to si_str.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/smbios.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 41aa936c4c41..47db410a2141 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -48,20 +48,20 @@ DECLARE_GLOBAL_DATA_PTR;
 /**
  * struct map_sysinfo - Mapping of sysinfo strings to DT
  *
- * @sysinfo_str: sysinfo string
+ * @si_str: sysinfo string
  * @dt_str: DT string
  * @max: Max index of the tokenized string to pick. Counting starts from 0
  *
  */
 struct map_sysinfo {
-	const char *sysinfo_str;
+	const char *si_str;
 	const char *dt_str;
 	int max;
 };

 static const struct map_sysinfo sysinfo_to_dt[] = {
-	{ .sysinfo_str = "product", .dt_str = "model", 2 },
-	{ .sysinfo_str = "manufacturer", .dt_str = "compatible", 1 },
+	{ .si_str = "product", .dt_str = "model", 2 },
+	{ .si_str = "manufacturer", .dt_str = "compatible", 1 },
 };

 /**
@@ -108,12 +108,12 @@ struct smbios_write_method {
 	const char *subnode_name;
 };

-static const struct map_sysinfo *convert_sysinfo_to_dt(const char *sysinfo_str)
+static const struct map_sysinfo *convert_sysinfo_to_dt(const char *si)
 {
 	int i;

 	for (i = 0; i < ARRAY_SIZE(sysinfo_to_dt); i++) {
-		if (!strcmp(sysinfo_str, sysinfo_to_dt[i].sysinfo_str))
+		if (!strcmp(si, sysinfo_to_dt[i].si_str))
 			return &sysinfo_to_dt[i];
 	}

--
2.37.2

