Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F6EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30BB87AE5;
	Thu, 28 Dec 2023 16:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="UeQ8cBdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE6287A71; Thu, 28 Dec 2023 16:39:42 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708EB87AB4
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id D15E010003D;
 Thu, 28 Dec 2023 18:39:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D15E010003D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1703777976;
 bh=oJJldLU3T1rNKBYdpc26Ro+WEbtlDNxRd2XsTh+M/QA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=UeQ8cBdQpkHRH9eL21NHr3QmfetJK1y8QPRBG+yaClGAnqVlyHybdth37AI0nSxJe
 7lU9CRrGZZXO76SrZAu48ITFF7JRHnj/pztna833Xd/rAjaZCdmRHsOgC6qgeXfdhM
 +VWjaX1Kawlr+7sPihfcqXGc4JkzJRA2cOQcRY4oh/YdTgKmfjBpGjwfFAET152fHn
 flXxVOgTvQG9tc+yb66rMYgbKR6QLHfx1WfRCaYQSV2ntYQcE1pZqt1Bjp+l+vswU6
 NmAd39odkNqskYN8pLH98awCf7ek12zgn4UHPIHilje1K+r1qOAQjydlv7RRbLJJYB
 StO7K5gVWuXTQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 28 Dec 2023 18:39:36 +0300 (MSK)
Received: from cab-wsm-0029881.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Dec 2023 18:39:36 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <michal.simek@amd.com>, <marex@denx.de>, <michael@walle.cc>,
 <stcarlso@linux.microsoft.com>, <tobias@waldekranz.com>,
 <seanedmond@microsoft.com>, <abdellatif.elkhlifi@arm.com>,
 <neil.armstrong@linaro.org>, <n-jain1@ti.com>, <xypron.glpk@gmx.de>,
 <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <frieder.schrempf@kontron.de>, <sjg@chromium.org>, <hs@denx.de>,
 <sean.anderson@seco.com>, <dimorinny@google.com>,
 <mkorpershoek@baylibre.com>, <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1 07/12] mtdparts: use negative error codes
Date: Thu, 28 Dec 2023 18:39:10 +0300
Message-ID: <20231228153922.84323-8-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231228153922.84323-1-avromanov@salutedevices.com>
References: <20231228153922.84323-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182415 [Dec 28 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/28 11:18:00 #22863388
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 28 Dec 2023 16:40:44 +0100
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

It is bad practice to use such error codes. Error codes
must be negative.

Also, fastboot code expects that if successful, mtdparts
functions will return a value greater than 0. You can see
fastboot_nand_get_part_info() functions calls inside
getvar_get_part_info().

And use 'return CMD_RET_FAILURE' define instead of 'return 1'.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 cmd/mtdparts.c | 154 ++++++++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index 0984158f41..08e5b794db 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -299,7 +299,7 @@ static void current_save(void)
  * @param type mtd type
  * @param num mtd number
  * @param mtd a pointer to an mtd_info instance (output)
- * Return: 0 if device is valid, 1 otherwise
+ * Return: 0 if device is valid, -errno otherwise
  */
 static int get_mtd_info(u8 type, u8 num, struct mtd_info **mtd)
 {
@@ -309,7 +309,7 @@ static int get_mtd_info(u8 type, u8 num, struct mtd_info **mtd)
 	*mtd = get_mtd_device_nm(mtd_dev);
 	if (IS_ERR(*mtd)) {
 		printf("Device %s not found!\n", mtd_dev);
-		return 1;
+		return -ENODEV;
 	}
 	put_mtd_device(*mtd);
 
@@ -323,7 +323,7 @@ static int get_mtd_info(u8 type, u8 num, struct mtd_info **mtd)
  *
  * @param id of the parent device
  * @param part partition to validate
- * Return: 0 if partition is valid, 1 otherwise
+ * Return: 0 if partition is valid, -errno otherwise
  */
 static int part_validate_eraseblock(struct mtdids *id, struct part_info *part)
 {
@@ -333,7 +333,7 @@ static int part_validate_eraseblock(struct mtdids *id, struct part_info *part)
 	u64 offset, size;
 
 	if (get_mtd_info(id->type, id->num, &mtd))
-		return 1;
+		return -EINVAL;
 
 	part->sector_size = mtd->erasesize;
 
@@ -347,14 +347,14 @@ static int part_validate_eraseblock(struct mtdids *id, struct part_info *part)
 			printf("%s%d: partition (%s) start offset"
 			       "alignment incorrect\n",
 			       MTD_DEV_TYPE(id->type), id->num, part->name);
-			return 1;
+			return -EINVAL;
 		}
 
 		size = part->size;
 		if (do_div(size, mtd->erasesize)) {
 			printf("%s%d: partition (%s) size alignment incorrect\n",
 			       MTD_DEV_TYPE(id->type), id->num, part->name);
-			return 1;
+			return -EINVAL;
 		}
 	} else {
 		/*
@@ -374,7 +374,7 @@ static int part_validate_eraseblock(struct mtdids *id, struct part_info *part)
 
 		printf("%s%d: partition (%s) start offset alignment incorrect\n",
 		       MTD_DEV_TYPE(id->type), id->num, part->name);
-		return 1;
+		return -EINVAL;
 
 	start_ok:
 
@@ -393,7 +393,7 @@ static int part_validate_eraseblock(struct mtdids *id, struct part_info *part)
 
 		printf("%s%d: partition (%s) size alignment incorrect\n",
 		       MTD_DEV_TYPE(id->type), id->num, part->name);
-		return 1;
+		return -EINVAL;
 
 	end_ok:
 		return 0;
@@ -410,7 +410,7 @@ static int part_validate_eraseblock(struct mtdids *id, struct part_info *part)
  *
  * @param id of the parent device
  * @param part partition to validate
- * Return: 0 if partition is valid, 1 otherwise
+ * Return: 0 if partition is valid, -errno otherwise
  */
 static int part_validate(struct mtdids *id, struct part_info *part)
 {
@@ -420,18 +420,18 @@ static int part_validate(struct mtdids *id, struct part_info *part)
 	if (part->offset > id->size) {
 		printf("%s: offset %08llx beyond flash size %08llx\n",
 				id->mtd_id, part->offset, id->size);
-		return 1;
+		return -EINVAL;
 	}
 
 	if ((part->offset + part->size) <= part->offset) {
 		printf("%s%d: partition (%s) size too big\n",
 				MTD_DEV_TYPE(id->type), id->num, part->name);
-		return 1;
+		return -EINVAL;
 	}
 
 	if (part->offset + part->size > id->size) {
 		printf("%s: partitioning exceeds flash size\n", id->mtd_id);
-		return 1;
+		return -EINVAL;
 	}
 
 	/*
@@ -446,7 +446,7 @@ static int part_validate(struct mtdids *id, struct part_info *part)
  *
  * @param dev device to delete partition from
  * @param part partition to delete
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -ernno otherwise
  */
 static int part_del(struct mtd_device *dev, struct part_info *part)
 {
@@ -544,7 +544,7 @@ static int part_sort_add(struct mtd_device *dev, struct part_info *part)
 		/* be compliant with kernel cmdline, allow only one partition at offset zero */
 		if ((new_pi->offset == pi->offset) && (pi->offset == 0)) {
 			printf("cannot add second partition at offset 0\n");
-			return 1;
+			return -EINVAL;
 		}
 
 		if (new_pi->offset <= pi->offset) {
@@ -574,17 +574,17 @@ static int part_sort_add(struct mtd_device *dev, struct part_info *part)
  *
  * @param dev device to which partition is added
  * @param part partition to be added
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int part_add(struct mtd_device *dev, struct part_info *part)
 {
 	/* verify alignment and size */
 	if (part_validate(dev->id, part) != 0)
-		return 1;
+		return -EINVAL;
 
 	/* partition is ok, add it to the list */
 	if (part_sort_add(dev, part) != 0)
-		return 1;
+		return -EINVAL;
 
 	return 0;
 }
@@ -596,7 +596,7 @@ static int part_add(struct mtd_device *dev, struct part_info *part)
  * @param partdef pointer to the partition definition string i.e. <part-def>
  * @param ret output pointer to next char after parse completes (output)
  * @param retpart pointer to the allocated partition (output)
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int part_parse(const char *const partdef, const char **ret, struct part_info **retpart)
 {
@@ -622,7 +622,7 @@ static int part_parse(const char *const partdef, const char **ret, struct part_i
 		size = memsize_parse(p, &p);
 		if (size < MIN_PART_SIZE) {
 			printf("partition size too small (%llx)\n", size);
-			return 1;
+			return -EINVAL;
 		}
 	}
 
@@ -638,12 +638,12 @@ static int part_parse(const char *const partdef, const char **ret, struct part_i
 		name = ++p;
 		if ((p = strchr(name, ')')) == NULL) {
 			printf("no closing ) found in partition name\n");
-			return 1;
+			return -EINVAL;
 		}
 		name_len = p - name + 1;
 		if ((name_len - 1) == 0) {
 			printf("empty partition name\n");
-			return 1;
+			return -EINVAL;
 		}
 		p++;
 	} else {
@@ -664,7 +664,7 @@ static int part_parse(const char *const partdef, const char **ret, struct part_i
 		if (size == SIZE_REMAINING) {
 			*ret = NULL;
 			printf("no partitions allowed after a fill-up partition\n");
-			return 1;
+			return -EINVAL;
 		}
 		*ret = ++p;
 	} else if ((*p == ';') || (*p == '\0')) {
@@ -672,14 +672,14 @@ static int part_parse(const char *const partdef, const char **ret, struct part_i
 	} else {
 		printf("unexpected character '%c' at the end of partition\n", *p);
 		*ret = NULL;
-		return 1;
+		return -EINVAL;
 	}
 
 	/*  allocate memory */
 	part = (struct part_info *)malloc(sizeof(struct part_info) + name_len);
 	if (!part) {
 		printf("out of memory\n");
-		return 1;
+		return -ENOMEM;
 	}
 	memset(part, 0, sizeof(struct part_info) + name_len);
 	part->size = size;
@@ -714,14 +714,14 @@ static int part_parse(const char *const partdef, const char **ret, struct part_i
  * @param type mtd type
  * @param num mtd number
  * @param size a pointer to the size of the mtd device (output)
- * Return: 0 if device is valid, 1 otherwise
+ * Return: 0 if device is valid, -errno otherwise
  */
 static int mtd_device_validate(u8 type, u8 num, u64 *size)
 {
 	struct mtd_info *mtd = NULL;
 
 	if (get_mtd_info(type, num, &mtd))
-		return 1;
+		return -EINVAL;
 
 	*size = mtd->size;
 
@@ -732,7 +732,7 @@ static int mtd_device_validate(u8 type, u8 num, u64 *size)
  * Delete all mtd devices from a supplied devices list, free memory allocated for
  * each device and delete all device partitions.
  *
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int device_delall(struct list_head *head)
 {
@@ -756,7 +756,7 @@ static int device_delall(struct list_head *head)
  * from device list and device memory is freed.
  *
  * @param dev device to be deleted
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int device_del(struct mtd_device *dev)
 {
@@ -835,7 +835,7 @@ static void device_add(struct mtd_device *dev)
  * @param mtd_dev pointer to the device definition string i.e. <mtd-dev>
  * @param ret output pointer to next char after parse completes (output)
  * @param retdev pointer to the allocated device (output)
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int device_parse(const char *const mtd_dev, const char **ret, struct mtd_device **retdev)
 {
@@ -864,7 +864,7 @@ static int device_parse(const char *const mtd_dev, const char **ret, struct mtd_
 	mtd_id = p = mtd_dev;
 	if (!(p = strchr(mtd_id, ':'))) {
 		printf("no <mtd-id> identifier\n");
-		return 1;
+		return -EINVAL;
 	}
 	mtd_id_len = p - mtd_id + 1;
 	p++;
@@ -872,7 +872,7 @@ static int device_parse(const char *const mtd_dev, const char **ret, struct mtd_
 	/* verify if we have a valid device specified */
 	if ((id = id_find_by_mtd_id(mtd_id, mtd_id_len - 1)) == NULL) {
 		printf("invalid mtd device '%.*s'\n", mtd_id_len - 1, mtd_id);
-		return 1;
+		return -ENODEV;
 	}
 
 	pend = strchr(p, ';');
@@ -915,7 +915,7 @@ static int device_parse(const char *const mtd_dev, const char **ret, struct mtd_
 	}
 	if (err == 1) {
 		part_delall(&tmp_list);
-		return 1;
+		return -EINVAL;
 	}
 
 	debug("\ntotal partitions: %d\n", num_parts);
@@ -932,14 +932,14 @@ static int device_parse(const char *const mtd_dev, const char **ret, struct mtd_
 			printf("unexpected character '%c' at the end of device\n", *p);
 			if (ret)
 				*ret = NULL;
-			return 1;
+			return -EINVAL;
 		}
 	}
 
 	/* allocate memory for mtd_device structure */
 	if ((dev = (struct mtd_device *)malloc(sizeof(struct mtd_device))) == NULL) {
 		printf("out of memory\n");
-		return 1;
+		return -ENOMEM;
 	}
 	memset(dev, 0, sizeof(struct mtd_device));
 	dev->id = id;
@@ -953,7 +953,7 @@ static int device_parse(const char *const mtd_dev, const char **ret, struct mtd_
 		list_del(entry);
 		if (part_sort_add(dev, part) != 0) {
 			device_del(dev);
-			return 1;
+			return -EINVAL;
 		}
 	}
 
@@ -966,7 +966,7 @@ static int device_parse(const char *const mtd_dev, const char **ret, struct mtd_
 /**
  * Initialize global device list.
  *
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int mtd_devices_init(void)
 {
@@ -1037,7 +1037,7 @@ static struct mtdids* id_find_by_mtd_id(const char *mtd_id, unsigned int mtd_id_
  * @param ret_id output pointer to next char after parse completes (output)
  * @param dev_type parsed device type (output)
  * @param dev_num parsed device number (output)
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 int mtd_id_parse(const char *id, const char **ret_id, u8 *dev_type,
 		 u8 *dev_num)
@@ -1059,12 +1059,12 @@ int mtd_id_parse(const char *id, const char **ret_id, u8 *dev_type,
 		p += 8;
 	} else {
 		printf("incorrect device type in %s\n", id);
-		return 1;
+		return -EINVAL;
 	}
 
 	if (!isdigit(*p)) {
 		printf("incorrect device number in %s\n", id);
-		return 1;
+		return -EINVAL;
 	}
 
 	*dev_num = simple_strtoul(p, (char **)&p, 0);
@@ -1079,7 +1079,7 @@ int mtd_id_parse(const char *id, const char **ret_id, u8 *dev_type,
  *
  * @param buf output buffer holding generated mtdparts string (output)
  * @param buflen buffer size
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int generate_mtdparts(char *buf, u32 buflen)
 {
@@ -1195,7 +1195,7 @@ static int generate_mtdparts(char *buf, u32 buflen)
 
 cleanup:
 	last_parts[0] = '\0';
-	return 1;
+	return -EINVAL;
 }
 
 /**
@@ -1204,7 +1204,7 @@ cleanup:
  *
  * @param buf output buffer holding generated mtdparts string (output)
  * @param buflen buffer size
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int generate_mtdparts_save(char *buf, u32 buflen)
 {
@@ -1342,7 +1342,7 @@ static void list_partitions(void)
  * @param dev pointer to the requested device (output)
  * @param part_num verified partition number (output)
  * @param part pointer to requested partition (output)
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 int find_dev_and_part(const char *id, struct mtd_device **dev,
 		u8 *part_num, struct part_info **part)
@@ -1370,27 +1370,27 @@ int find_dev_and_part(const char *id, struct mtd_device **dev,
 	*part_num = 0;
 
 	if (mtd_id_parse(p, &p, &type, &dnum) != 0)
-		return 1;
+		return -EINVAL;
 
 	if ((*p++ != ',') || (*p == '\0')) {
 		printf("no partition number specified\n");
-		return 1;
+		return -EINVAL;
 	}
 	pnum = simple_strtoul(p, (char **)&p, 0);
 	if (*p != '\0') {
 		printf("unexpected trailing character '%c'\n", *p);
-		return 1;
+		return -EINVAL;
 	}
 
 	if ((*dev = device_find(type, dnum)) == NULL) {
 		printf("no such device %s%d\n", MTD_DEV_TYPE(type), dnum);
-		return 1;
+		return -ENODEV;
 	}
 
 	if ((*part = mtd_part_info(*dev, pnum)) == NULL) {
 		printf("no such partition\n");
 		*dev = NULL;
-		return 1;
+		return -EINVAL;
 	}
 
 	*part_num = pnum;
@@ -1402,7 +1402,7 @@ int find_dev_and_part(const char *id, struct mtd_device **dev,
  * Find and delete partition. For partition id format see find_dev_and_part().
  *
  * @param id string describing device and partition
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int delete_partition(const char *id)
 {
@@ -1417,17 +1417,17 @@ static int delete_partition(const char *id)
 				part->name, part->size, part->offset);
 
 		if (part_del(dev, part) != 0)
-			return 1;
+			return -EINVAL;
 
 		if (generate_mtdparts_save(last_parts, MTDPARTS_MAXLEN) != 0) {
 			printf("generated mtdparts too long, resetting to null\n");
-			return 1;
+			return -EINVAL;
 		}
 		return 0;
 	}
 
 	printf("partition %s not found\n", id);
-	return 1;
+	return -ENOENT;
 }
 
 #if defined(CONFIG_CMD_MTDPARTS_SPREAD)
@@ -1478,7 +1478,7 @@ static void spread_partition(struct mtd_info *mtd, struct part_info *part,
  * as big as their mtdparts environment variable sizes and they each start
  * on a good block.
  *
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int spread_partitions(void)
 {
@@ -1493,7 +1493,7 @@ static int spread_partitions(void)
 		dev = list_entry(dentry, struct mtd_device, link);
 
 		if (get_mtd_info(dev->id->type, dev->id->num, &mtd))
-			return 1;
+			return -EINVAL;
 
 		part_num = 0;
 		cur_offs = 0;
@@ -1519,7 +1519,7 @@ static int spread_partitions(void)
 
 	if (generate_mtdparts_save(last_parts, MTDPARTS_MAXLEN) != 0) {
 		printf("generated mtdparts too long, resetting to null\n");
-		return 1;
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -1547,7 +1547,7 @@ static const char *env_get_mtdparts(char *buf)
  * for each entry. Add created devices to the global devices list.
  *
  * @param mtdparts string specifing mtd partitions
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int parse_mtdparts(const char *const mtdparts)
 {
@@ -1605,7 +1605,7 @@ static int parse_mtdparts(const char *const mtdparts)
  * to the global mtdids list.
  *
  * @param ids mapping string
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 static int parse_mtdids(const char *const ids)
 {
@@ -1646,7 +1646,7 @@ static int parse_mtdids(const char *const ids)
 
 		/* check if requested device exists */
 		if (mtd_device_validate(type, num, &size) != 0)
-			return 1;
+			return -EINVAL;
 
 		/* locate <mtd-id> */
 		mtd_id = p;
@@ -1704,7 +1704,7 @@ static int parse_mtdids(const char *const ids)
 			list_del(entry);
 			free(id_tmp);
 		}
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1715,7 +1715,7 @@ static int parse_mtdids(const char *const ids)
  * Parse and initialize global mtdids mapping and create global
  * device/partition list.
  *
- * Return: 0 on success, 1 otherwise
+ * Return: 0 on success, -errno otherwise
  */
 int mtdparts_init(void)
 {
@@ -1768,12 +1768,12 @@ int mtdparts_init(void)
 			env_set("mtdids", (char *)ids);
 		} else {
 			printf("mtdids not defined, no default present\n");
-			return 1;
+			return -ENXIO;
 		}
 	}
 	if (strlen(ids) > MTDIDS_MAXLEN - 1) {
 		printf("mtdids too long (> %d)\n", MTDIDS_MAXLEN);
-		return 1;
+		return -EINVAL;
 	}
 
 	/* use defaults when mtdparts variable is not defined
@@ -1789,7 +1789,7 @@ int mtdparts_init(void)
 
 	if (parts && (strlen(parts) > MTDPARTS_MAXLEN - 1)) {
 		printf("mtdparts too long (> %d)\n", MTDPARTS_MAXLEN);
-		return 1;
+		return -EINVAL;
 	}
 
 	/* check if we have already parsed those mtdids */
@@ -1800,7 +1800,7 @@ int mtdparts_init(void)
 
 		if (parse_mtdids(ids) != 0) {
 			mtd_devices_init();
-			return 1;
+			return -EINVAL;
 		}
 
 		/* ok it's good, save new ids */
@@ -1810,11 +1810,11 @@ int mtdparts_init(void)
 	/* parse partitions if either mtdparts or mtdids were updated */
 	if (parts && ((last_parts[0] == '\0') || ((strcmp(last_parts, parts) != 0)) || ids_changed)) {
 		if (parse_mtdparts(parts) != 0)
-			return 1;
+			return -EINVAL;
 
 		if (list_empty(&devices)) {
 			printf("mtdparts_init: no valid partitions\n");
-			return 1;
+			return -ENXIO;
 		}
 
 		/* ok it's good, save new parts */
@@ -1923,15 +1923,15 @@ static int do_chpart(struct cmd_tbl *cmdtp, int flag, int argc,
 	u8 pnum;
 
 	if (mtdparts_init() !=0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if (argc < 2) {
 		printf("no partition id specified\n");
-		return 1;
+		return CMD_RET_FAILURE;
 	}
 
 	if (find_dev_and_part(argv[1], &dev, &pnum, &part) != 0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	current_mtd_dev = dev;
 	current_mtd_partnum = pnum;
@@ -1978,7 +1978,7 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* make sure we are in sync with env variables */
 	if (mtdparts_init() != 0)
-		return 1;
+		return CMD_RET_FAILURE;
 
 	if (argc == 1) {
 		list_partitions();
@@ -2000,11 +2000,11 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 		struct part_info *p;
 
 		if (mtd_id_parse(argv[2], NULL, &type, &num) != 0)
-			return 1;
+			return CMD_RET_FAILURE;
 
 		if ((id = id_find(type, num)) == NULL) {
 			printf("no such device %s defined in mtdids variable\n", argv[2]);
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 
 		len = strlen(id->mtd_id) + 1;	/* 'mtd_id:' */
@@ -2015,14 +2015,14 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		if (len >= PART_ADD_DESC_MAXLEN) {
 			printf("too long partition description\n");
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 		sprintf(tmpbuf, "%s:%s(%s)%s",
 				id->mtd_id, argv[3], argv[4], argv[5] ? argv[5] : "");
 		debug("add tmpbuf: %s\n", tmpbuf);
 
 		if ((device_parse(tmpbuf, NULL, &dev) != 0) || (!dev))
-			return 1;
+			return -EINVAL;
 
 		debug("+ %s\t%d\t%s\n", MTD_DEV_TYPE(dev->id->type),
 				dev->id->num, dev->id->mtd_id);
@@ -2031,7 +2031,7 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 
 #if defined(CONFIG_CMD_MTDPARTS_SPREAD)
 		if (get_mtd_info(dev->id->type, dev->id->num, &mtd))
-			return 1;
+			return CMD_RET_FAILURE;
 
 		if (!strcmp(&argv[1][3], ".spread")) {
 			spread_partition(mtd, p, &next_offset);
@@ -2045,12 +2045,12 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int flag, int argc,
 		} else if (part_add(dev_tmp, p) != 0) {
 			/* merge new partition with existing ones*/
 			device_del(dev);
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 
 		if (generate_mtdparts_save(last_parts, MTDPARTS_MAXLEN) != 0) {
 			printf("generated mtdparts too long, resetting to null\n");
-			return 1;
+			return CMD_RET_FAILURE;
 		}
 
 		return 0;
-- 
2.30.1

