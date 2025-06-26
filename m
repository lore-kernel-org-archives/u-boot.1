Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3C9C77B7F
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B3C82AA4;
	Thu, 26 Jun 2025 10:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=eub.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=eub.se header.i=@eub.se header.b="Kh57bOet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D25D82C4C; Thu, 26 Jun 2025 08:54:40 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A0C982D83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=eub.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=tobias@eub.se
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-553b165c80cso626823e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eub.se; s=google; t=1750920872; x=1751525672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/2MQ77rqG3Qc+XgYnWDWvcwbmKGWjxin5ftkw0W23Q=;
 b=Kh57bOetpkG/8cB4CwCq4rowMZHO/Nc7FLAOdEEN85OT5cvUvr5ojIXIRfZc3fqvDQ
 YaqtSfhHvjDh650zxB7W/5+MtYAILfanQY1epVMCbE++IY2wxtzpq4pS3UA7q5NBjDgA
 Y+UhNJTWxmlkTf56XpLfuLY4HVI8p5ehz7zbCwrJTJK5q3cf2QNPEytnLfJq3007xMDL
 NW+IOOoWN762dp5BPMTTmLq0swqKq3MvVJMOIINk345QfBz1qPZvjDZZkO8N5i1/cnVM
 d4P4sfbqzkF+jh3NqzhLSuddp0nFrFwE1cNH5pPUmRKWYUwfByoXnvhUYZyOmIlJSeob
 TSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750920872; x=1751525672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z/2MQ77rqG3Qc+XgYnWDWvcwbmKGWjxin5ftkw0W23Q=;
 b=iJP4NvTTgfBuXSiDb3JntKwDuki8wqf50HtzJYiqlm3LTfcaB0cbdJ53F3KTtgA+LD
 Co3I3DG0hJui9Wo3TBapA3LRRXzDZxk6Y6/ammKS2+ugKOocZQpT/bAdDIm1rF2df2oa
 n33uNapO9Y/jBf8uYaXgJtxrhDRVOXRIHouwhOeJeeWlsr0jbp6jNtbiGlwgQXgXqWq3
 qOcxzfKS1eNF807zRXnkDiOE2xX7ibbSsyn2U4cuLDaeesqCHlnV2bQhStld2G01aBdB
 JMPKU5KmOznzf67vj5nZnTIbnigLlByFzzcnebuo6wfDDQRTYkoqo2LUfpHF+aRHJUiU
 Hcag==
X-Gm-Message-State: AOJu0Yy2xM9nrwHeL0CTCwijn4Ph8l5Nu5LYn9Inb7dllsAiRcAgPlb0
 iPY5hI3snfxx5ifWeoseoF2Rbeq2EvuZhQVAlesCqBZb/hq7II1poLT0pqtLsxPb6mTHvrYJlTR
 BT0GI
X-Gm-Gg: ASbGncuZFm0qVTrjVeYMDgmgUb1ZTyNc/X6SFnrASvWMRc1TrbybDSR86I18xhGJBqH
 X+oZGtDGT+VQ0f1J7OvMlTw0uSN5O4DmGi/4TLBmRYXHs4lHCeb4oM4LMWETsrlc7NhQBior2Nh
 c5v1NDnwhJpa/QljG0f9EryO7OJ7xY5+JxO93qjTKyXWOvJpqNAqlEpFgcQiZFBwrpQc37mM88W
 9k9Lti/P5I5UV49RwDgD/MD0kjm9nPrDxYTRswcUaxE/N1M7SbdJj1uQV6acr7nj7aGgu8MGz5A
 +ceaLjV5zeJ1HR5kq2fCORKveS9R92fl2ZJZRevkLhkt/IrZ1kBeLtMspVLss5KGPlvfAC6MBos
 jRg05pPayaIR64Ji9vPUdJdpku8s=
X-Google-Smtp-Source: AGHT+IGE/HCqWeZzw2WoQiVtXk8VqImFaJfHa6tVsz+wfrGsoxdoY9lifg4SKMrUsAcUtXQpfyn2QA==
X-Received: by 2002:a05:6512:2c0d:b0:553:ccef:e2f4 with SMTP id
 2adb3069b0e04-555029e6c3amr954596e87.35.1750920871524; 
 Wed, 25 Jun 2025 23:54:31 -0700 (PDT)
Received: from eub76.brunnsliden (h-155-4-128-6.NA.cust.bahnhof.se.
 [155.4.128.6]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-553e41cc0f6sm2463777e87.220.2025.06.25.23.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 23:54:31 -0700 (PDT)
From: Tobias Olausson <tobias@eub.se>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tobias Olausson <tobias@eub.se>, Loic Poulain <loic.poulain@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] lib/rsa: allow matching pkcs11 path by object id
Date: Thu, 26 Jun 2025 08:54:20 +0200
Message-ID: <20250626065428.1471599-1-tobias@eub.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Jun 2025 10:41:15 +0200
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

The object= part matches against the label that the pkcs11 token uses
for that object, but in some cases, specifically with a Yubikey using
ykcs11, where the keys have been imported, the labels differ between the
private and public keys [1], making the object= matching useless. These
keys will have the same id however, so matching against that works for
both the private and public part.

[1]: https://github.com/Yubico/yubico-piv-tool/blob/master/doc/YKCS11/Functions_and_values.adoc#key-alias-per-slot-and-object-type

Signed-off-by: Tobias Olausson <tobias@eub.se>
---

 lib/rsa/rsa-sign.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index fa9e143b4ca..92b9d7876e5 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -122,7 +122,7 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 				fprintf(stderr, "WARNING: Legacy URI specified. Please add '%s'.\n", pkcs11_schema);
 			}
 
-			if (strstr(keydir, "object="))
+			if (strstr(keydir, "object=") || strstr(keydir, "id="))
 				snprintf(key_id, sizeof(key_id),
 					 "%s%s;type=public",
 					 pkcs11_uri_prepend, keydir);
@@ -253,7 +253,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 				fprintf(stderr, "WARNING: Legacy URI specified. Please add '%s'.\n", pkcs11_schema);
 			}
 
-			if (strstr(keydir, "object="))
+			if (strstr(keydir, "object=") || strstr(keydir, "id="))
 				snprintf(key_id, sizeof(key_id),
 					 "%s%s;type=private",
 					 pkcs11_uri_prepend, keydir);
-- 
2.43.0

base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
branch: rsa-pkcs11-id
