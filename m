Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B42DCA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 07:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1E3867EA;
	Sat,  2 Sep 2023 09:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h1HMkwV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F0A86411; Sat,  2 Sep 2023 09:34:34 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B5286416
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 09:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B7C3642959; 
 Sat,  2 Sep 2023 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693640069;
 bh=deJA/Bi4SAgRvVpYyoXfLlUuvYo/09ggJHeKr+0+obw=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=h1HMkwV2yXPoUswLUEEGHTDDpRCJ/7o1MgN6PBVvUVg/L7QyquNfpOkERbNSfAfVK
 8RJfkxjtSIo4ut7oq9C8ZgQNii2qCGbODdAHw/hHRfcGeM5iplBUhxpNLsoPrWI8a1
 a8FV/ZD7pEYOSy1j+LN8564DqsWvL+z88WmVD9WGXxE2nFdj4nRQ49gGvEK3efGvhb
 55QZtrx9W3Wu3OKTiJygd97ujKT93v4/VozMxCOA+saCdNiK/WzSOx+U96HMSZBrio
 gQ3XG7EbRXKjm6ZpZejVOnvepNDlW62ZinMklbN02iOZRgiEtFYo8wnOGhGiV3ODRx
 NNt7DaYSADbQQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] cmd: gpt: fix calc_parts_list_len()
Date: Sat,  2 Sep 2023 09:35:23 +0200
Message-Id: <20230902073524.87451-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
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

* Avoid incrementing by moving comma into strlen("uuid_disk=,") and
  considering NUL byte.
* Appending a UUID only adds UUID_STR_LEN bytes.
  Don't count the terminating NUL.
* The length of the hexadecimal representation of lba_int is
  2 * sizeof(lba_int).
* We don't use a 'MiB' postfix but a '0x' prefix.
* The uuid field is only needed if configured.

Fixes: 2fcaa413b3f6 ("gpt: harden set_gpt_info() against non NULL-terminated strings")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 cmd/gpt.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 092f7defff..e7a53747fc 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -162,22 +162,29 @@ static bool found_key(const char *str, const char *key)
 	return result;
 }
 
+/**
+ * calc_parts_list_len() - get size of partition table description
+ *
+ * @numparts:	number of partitions
+ * Return:	string size including terminating NUL
+ */
 static int calc_parts_list_len(int numparts)
 {
-	int partlistlen = UUID_STR_LEN + 1 + strlen("uuid_disk=");
-	/* for the comma */
-	partlistlen++;
-
-	/* per-partition additions; numparts starts at 1, so this should be correct */
-	partlistlen += numparts * (strlen("name=,") + PART_NAME_LEN + 1);
+	/* number of hexadecimal digits of the lbaint_t representation */
+	const int lbaint_size = 2 * sizeof(lbaint_t);
+	int partlistlen;
+
+	/* media description including terminating NUL */
+	partlistlen = strlen("uuid_disk=;") + UUID_STR_LEN + 1;
+	/* per-partition descriptions; numparts */
+	partlistlen += numparts * (strlen("name=,") + PART_NAME_LEN);
 	/* see part.h for definition of struct disk_partition */
-	partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
-	partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
-	partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
-	/* for the terminating null */
-	partlistlen++;
-	debug("Length of partitions_list is %d for %d partitions\n", partlistlen,
-	      numparts);
+	partlistlen += numparts * (strlen("start=0x,") + lbaint_size);
+	partlistlen += numparts * (strlen("size=0x,") + lbaint_size);
+	if (IS_ENABLED(CONFIG_PARTITION_UUIDS))
+		partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN);
+	debug("Length of partitions_list is %d for %d partitions\n",
+	      partlistlen, numparts);
 	return partlistlen;
 }
 
-- 
2.40.1

