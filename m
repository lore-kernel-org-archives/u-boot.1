Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F25BC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF9886A26;
	Thu, 24 Aug 2023 21:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QWzYNk5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDA486940; Thu, 24 Aug 2023 21:56:17 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD09869BB
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79231457b7fso7293739f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906970; x=1693511770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dBYZlZyXAADlKaNsQiy+m8oTAtAPfjfAPNtLlYiLGg=;
 b=QWzYNk5f2nnLHJr9A6Yu/tmpUHG3ypQ9MqkXQRqfXGtFxPC/gwvl+atYKMvXacEmUM
 gS1eL2qjWzDgB+YR5w3j8T7RuKB8RjFrWJUjh3wqaSrs1FwNvNkhKKeZ9jFlAhTmVpmh
 ujAP2mdGAK6YBrHpWNShsA2MWZ1reUzNUo1A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906970; x=1693511770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dBYZlZyXAADlKaNsQiy+m8oTAtAPfjfAPNtLlYiLGg=;
 b=gpY2Sc6jk8lx9WvQdB5v7wbr79JsjBri3BwwkfGds7SKBeRPqYtSuhnDBxpGlxHQo2
 pdY1VmR8A6FBEvMwmuEPKSWoYXvZu9I6JDaW13tlv8snOZLf0wO+EldweEj/zebs4Yyf
 /pM3m2QNUvop6WMffWIllFrFPcif5Sch5Jh0zH630slF8A2JpAfbexyPx2TtlmabikF5
 pybEImny2cx2i3t3IGfHZQINSGJv3B4PseZ7H4yDhIoBrcwSEy+cK8fygzcfsd0qEbxB
 TBQQPsvMoTinL3xpVeHWnSdpOReLXmS+goHA3ADe9OSPxf60BfZ/KNVznXjsAn3cybmG
 BlWg==
X-Gm-Message-State: AOJu0Yza5pOzUWD6iHF07Zj5/prjuZ6oKdz5f7+j8k3DiAVNBwyz4InA
 /WIDyiY3+XQQtNLIi8GfxiBopI5EmKdMNTn0lXU=
X-Google-Smtp-Source: AGHT+IE+3WyJaKb/ZdjrN08Z5Kbq22ySu2ckRmISGhly4wuVcYNvACHCSf/1VPk8QVTKj1QoopS3Kg==
X-Received: by 2002:a6b:620d:0:b0:790:9728:4014 with SMTP id
 f13-20020a6b620d000000b0079097284014mr6954862iog.11.1692906970105; 
 Thu, 24 Aug 2023 12:56:10 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/23] uuid: Move function comments to header file
Date: Thu, 24 Aug 2023 13:55:36 -0600
Message-ID: <20230824195553.1685996-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

These should be in the header file for easy browsing, not in the source
code. Move them and add a missing Return on one of the functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rebase to -next

 include/uuid.h | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
 lib/uuid.c     | 103 -------------------------------------------------
 2 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/include/uuid.h b/include/uuid.h
index 89b93e642b73..f5a941250f48 100644
--- a/include/uuid.h
+++ b/include/uuid.h
@@ -12,6 +12,51 @@
 
 #include <linux/bitops.h>
 
+/*
+ * UUID - Universally Unique IDentifier - 128 bits unique number.
+ *        There are 5 versions and one variant of UUID defined by RFC4122
+ *        specification. A UUID contains a set of fields. The set varies
+ *        depending on the version of the UUID, as shown below:
+ *        - time, MAC address(v1),
+ *        - user ID(v2),
+ *        - MD5 of name or URL(v3),
+ *        - random data(v4),
+ *        - SHA-1 of name or URL(v5),
+ *
+ * Layout of UUID:
+ * timestamp - 60-bit: time_low, time_mid, time_hi_and_version
+ * version   - 4 bit (bit 4 through 7 of the time_hi_and_version)
+ * clock seq - 14 bit: clock_seq_hi_and_reserved, clock_seq_low
+ * variant:  - bit 6 and 7 of clock_seq_hi_and_reserved
+ * node      - 48 bit
+ *
+ * source: https://www.ietf.org/rfc/rfc4122.txt
+ *
+ * UUID binary format (16 bytes):
+ *
+ * 4B-2B-2B-2B-6B (big endian - network byte order)
+ *
+ * UUID string is 36 length of characters (36 bytes):
+ *
+ * 0        9    14   19   24
+ * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
+ *    be     be   be   be       be
+ *
+ * where x is a hexadecimal character. Fields are separated by '-'s.
+ * When converting to a binary UUID, le means the field should be converted
+ * to little endian and be means it should be converted to big endian.
+ *
+ * UUID is also used as GUID (Globally Unique Identifier) with the same binary
+ * format but it differs in string format like below.
+ *
+ * GUID:
+ * 0        9    14   19   24
+ * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
+ *    le     le   le   be       be
+ *
+ * GUID is used e.g. in GPT (GUID Partition Table) as a partiions unique id.
+ */
+
 /* This is structure is in big-endian */
 struct uuid {
 	unsigned int time_low;
@@ -40,20 +85,78 @@ struct uuid {
 #define UUID_VARIANT		0x1
 
 int uuid_str_valid(const char *uuid);
+
+/*
+ * uuid_str_to_bin() - convert string UUID or GUID to big endian binary data.
+ *
+ * @param uuid_str - pointer to UUID or GUID string [37B] or GUID shorcut
+ * @param uuid_bin - pointer to allocated array for big endian output [16B]
+ * @str_format     - UUID string format: 0 - UUID; 1 - GUID
+ * Return: 0 if OK, -EINVAL if the string is not a valid UUID
+ */
 int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 		    int str_format);
+
+/*
+ * uuid_bin_to_str() - convert big endian binary data to string UUID or GUID.
+ *
+ * @param uuid_bin:	pointer to binary data of UUID (big endian) [16B]
+ * @param uuid_str:	pointer to allocated array for output string [37B]
+ * @str_format:		bit 0: 0 - UUID; 1 - GUID
+ *			bit 1: 0 - lower case; 2 - upper case
+ */
 void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
 		     int str_format);
+
+/*
+ * uuid_guid_get_bin() - this function get GUID bin for string
+ *
+ * @param guid_str - pointer to partition type string
+ * @param guid_bin - pointer to allocated array for big endian output [16B]
+ */
 int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin);
+
+/*
+ * uuid_guid_get_str() - this function get string for GUID.
+ *
+ * @param guid_bin - pointer to string with partition type guid [16B]
+ *
+ * Returns NULL if the type GUID is not known.
+ */
 const char *uuid_guid_get_str(const unsigned char *guid_bin);
+
+/*
+ * gen_rand_uuid() - this function generates a random binary UUID version 4.
+ *                   In this version all fields beside 4 bits of version and
+ *                   2 bits of variant are randomly generated.
+ *
+ * @param uuid_bin - pointer to allocated array [16B]. Output is in big endian.
+ */
 void gen_rand_uuid(unsigned char *uuid_bin);
+
+/*
+ * gen_rand_uuid_str() - this function generates UUID v4 (random) in two string
+ *                       formats UUID or GUID.
+ *
+ * @param uuid_str - pointer to allocated array [37B].
+ * @param          - uuid output type: UUID - 0, GUID - 1
+ */
 void gen_rand_uuid_str(char *uuid_str, int str_format);
 
 /**
  * uuid_str_to_le_bin() - Convert string UUID to little endian binary data.
  * @uuid_str:	pointer to UUID string
  * @uuid_bin:	pointer to allocated array for little endian output [16B]
+ *
+ * UUID string is 36 characters (36 bytes):
+ *
+ * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
+ *
+ * where x is a hexadecimal character. Fields are separated by '-'s.
+ * When converting to a little endian binary UUID, the string fields are reversed.
+ *
  * Return:
+ *
  *    uuid_bin filled with little endian UUID data
  *    On success 0 is returned. Otherwise, failure code.
  */
diff --git a/lib/uuid.c b/lib/uuid.c
index d0187007d0e8..3bdb20b0e5b6 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -23,50 +23,6 @@
 #include <dm/uclass.h>
 #include <rng.h>
 
-/*
- * UUID - Universally Unique IDentifier - 128 bits unique number.
- *        There are 5 versions and one variant of UUID defined by RFC4122
- *        specification. A UUID contains a set of fields. The set varies
- *        depending on the version of the UUID, as shown below:
- *        - time, MAC address(v1),
- *        - user ID(v2),
- *        - MD5 of name or URL(v3),
- *        - random data(v4),
- *        - SHA-1 of name or URL(v5),
- *
- * Layout of UUID:
- * timestamp - 60-bit: time_low, time_mid, time_hi_and_version
- * version   - 4 bit (bit 4 through 7 of the time_hi_and_version)
- * clock seq - 14 bit: clock_seq_hi_and_reserved, clock_seq_low
- * variant:  - bit 6 and 7 of clock_seq_hi_and_reserved
- * node      - 48 bit
- *
- * source: https://www.ietf.org/rfc/rfc4122.txt
- *
- * UUID binary format (16 bytes):
- *
- * 4B-2B-2B-2B-6B (big endian - network byte order)
- *
- * UUID string is 36 length of characters (36 bytes):
- *
- * 0        9    14   19   24
- * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
- *    be     be   be   be       be
- *
- * where x is a hexadecimal character. Fields are separated by '-'s.
- * When converting to a binary UUID, le means the field should be converted
- * to little endian and be means it should be converted to big endian.
- *
- * UUID is also used as GUID (Globally Unique Identifier) with the same binary
- * format but it differs in string format like below.
- *
- * GUID:
- * 0        9    14   19   24
- * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
- *    le     le   le   be       be
- *
- * GUID is used e.g. in GPT (GUID Partition Table) as a partiions unique id.
- */
 int uuid_str_valid(const char *uuid)
 {
 	int i, valid;
@@ -269,12 +225,6 @@ static const struct {
 #endif
 };
 
-/*
- * uuid_guid_get_bin() - this function get GUID bin for string
- *
- * @param guid_str - pointer to partition type string
- * @param guid_bin - pointer to allocated array for big endian output [16B]
- */
 int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
 {
 	int i;
@@ -288,13 +238,6 @@ int uuid_guid_get_bin(const char *guid_str, unsigned char *guid_bin)
 	return -ENODEV;
 }
 
-/*
- * uuid_guid_get_str() - this function get string for GUID.
- *
- * @param guid_bin - pointer to string with partition type guid [16B]
- *
- * Returns NULL if the type GUID is not known.
- */
 const char *uuid_guid_get_str(const unsigned char *guid_bin)
 {
 	int i;
@@ -307,13 +250,6 @@ const char *uuid_guid_get_str(const unsigned char *guid_bin)
 	return NULL;
 }
 
-/*
- * uuid_str_to_bin() - convert string UUID or GUID to big endian binary data.
- *
- * @param uuid_str - pointer to UUID or GUID string [37B] or GUID shorcut
- * @param uuid_bin - pointer to allocated array for big endian output [16B]
- * @str_format     - UUID string format: 0 - UUID; 1 - GUID
- */
 int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 		    int str_format)
 {
@@ -358,23 +294,6 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 	return 0;
 }
 
-/**
- * uuid_str_to_le_bin() - Convert string UUID to little endian binary data.
- * @uuid_str:	pointer to UUID string
- * @uuid_bin:	pointer to allocated array for little endian output [16B]
- *
- * UUID string is 36 characters (36 bytes):
- *
- * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
- *
- * where x is a hexadecimal character. Fields are separated by '-'s.
- * When converting to a little endian binary UUID, the string fields are reversed.
- *
- * Return:
- *
- *    uuid_bin filled with little endian UUID data
- *    On success 0 is returned. Otherwise, failure code.
- */
 int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
 {
 	u16 tmp16;
@@ -402,14 +321,6 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
 	return 0;
 }
 
-/*
- * uuid_bin_to_str() - convert big endian binary data to string UUID or GUID.
- *
- * @param uuid_bin:	pointer to binary data of UUID (big endian) [16B]
- * @param uuid_str:	pointer to allocated array for output string [37B]
- * @str_format:		bit 0: 0 - UUID; 1 - GUID
- *			bit 1: 0 - lower case; 2 - upper case
- */
 void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
 		     int str_format)
 {
@@ -449,13 +360,6 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
 	}
 }
 
-/*
- * gen_rand_uuid() - this function generates a random binary UUID version 4.
- *                   In this version all fields beside 4 bits of version and
- *                   2 bits of variant are randomly generated.
- *
- * @param uuid_bin - pointer to allocated array [16B]. Output is in big endian.
-*/
 #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
 void gen_rand_uuid(unsigned char *uuid_bin)
 {
@@ -493,13 +397,6 @@ void gen_rand_uuid(unsigned char *uuid_bin)
 	memcpy(uuid_bin, uuid, 16);
 }
 
-/*
- * gen_rand_uuid_str() - this function generates UUID v4 (random) in two string
- *                       formats UUID or GUID.
- *
- * @param uuid_str - pointer to allocated array [37B].
- * @param          - uuid output type: UUID - 0, GUID - 1
- */
 void gen_rand_uuid_str(char *uuid_str, int str_format)
 {
 	unsigned char uuid_bin[UUID_BIN_LEN];
-- 
2.42.0.rc1.204.g551eb34607-goog

