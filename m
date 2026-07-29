Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E851C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39133407CB;
	Wed, 29 Jul 2026 21:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uXbb6UgV8R9D; Wed, 29 Jul 2026 21:52:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD906407F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361942;
	bh=bP/mZhZRX726JsHEnsnXMVrBqvA8fbTzyFncaK1sWWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sPscJtnH9Jd3yndf0iFcD/Q2qf1zj1QjNDtbv1gMHr+FrSDDYnQs0RIwuP2yaokwa
	 dSLegPKRIY5fFJtsqnN3QVkVEaGm4AY0r8mH8VMEE0APVseJGdPIOVn9y2GEOsLkkJ
	 8qGVeSzjDpEB2tpM1UEJi7PPk8DOQrzEe8xk/cWZVd+xAkEbrSzqauhbgZ1TEWZhKy
	 C7nj2Ghj16XA8dCHHVYwqUjJsMTmnEeXeyg47z0alGDOdQd6dI3upYG+Ig3/T0mRWM
	 Z6RvL7aZCTisTt9YYgNdCfp0jpGFioAesMveihxFDQCb2x32ld+0p5qsK40gWYGTgj
	 69xYaJyofAG5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD906407F8;
	Wed, 29 Jul 2026 21:52:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A48628E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C13D405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSbKl5I14J1k for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 18:25:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 535D54040B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 535D54040B
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 535D54040B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:37 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c12614b81c9so232550666b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785349535; x=1785954335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bP/mZhZRX726JsHEnsnXMVrBqvA8fbTzyFncaK1sWWU=;
 b=dTyWJemP5fKjmWcuQyty3Udl6fgbzkfDg7FigxtSPykb6UHejmEKM5i/lTSI2Z5JPg
 FOX+qI0hi2Xk502WuzB2CEK91+pz4F1/5AEruj+DW8eWR8GoS7u/PVmWDvzvf3YNMzcl
 ADAG7Mg5m1NY3t048l+ATdZEsNm1Vf8/fDhM+1IO0xj8SyXd+dwnVutvL/XGct1lRQap
 B16jnDBL4vfaDSkXNPzxFEVxInFBSpGeAgU85Qq6fztJmEZkP0VAbrLo18+5eRzNxLcM
 M+IXHDuq93z+ZbyxfUBjqvD7yhefRUJLjcLWADrcim3WtuAtpuRtXNJCXj5CGYfsHLFO
 wWNA==
X-Gm-Message-State: AOJu0YxRJ3cy1HVCoiHERFrtbL3TSgXLwEHgzJPaj/b3XjzxottCV6y6
 rGhqOEffk1gh+7J7ZYLQ7XU47CDgBgqXPaT/A8qjLWprB7rSFHB9R6saFaYdj3Ttc5w=
X-Gm-Gg: AR+sD12AyvdhuSB276MIaL9CiBFtUzRECZ0ntiGgmb46PkKKqUupVbJRWIGSxLh7Ccs
 vky2daGcJ2/2Vo4eFVwskjoxks3yKvH6l73Izc039eEoqwhCJ4oK8kK5qTCxP4RQ9uWe/RUzwe7
 jcztl9Mu6+eGIGjLsBmqEwNAKV6jgCbVMBOGw6ckhEhuS//6vny//fnkxDiNxdCj1sCqvRRwD6I
 AZuIBd9Rq+UjLjLDCJanTIVWUqvDZAycumJYCYTdDKFjDj+VTLdsviseQ7Hr0zScPdlmrcaM/Vj
 dQQqUBGeFMHUIn7GkwZ3xalM0d88E+Gi/KIeh07eTlwJoFho8qi7GfaK+xL1uU9hisuf0MDptcr
 TChX4bPmyzwV3ZHa30zzpPPhtrp8TIopKgaQSa0Xl1V2u4HT6u5XuYt0nGSykLczyFY7IxJgz5U
 nHUTbkbZRbQBLtfqo+LpBDENVzMJy1rbSX+VOiIzEZjWl2QGjUDYSCFf2m26LTntDVoUhzIPsTI
 cqbz0WRGiuWkoZF3DSnMqXrJH2BjfElwloBTj9E1EbSp0Pi/m1Nfw==
X-Received: by 2002:a17:906:99cb:b0:c15:f6b6:18f4 with SMTP id
 a640c23a62f3a-c1f71dc3eedmr412664266b.24.1785349535254; 
 Wed, 29 Jul 2026 11:25:35 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0047bee160d2cc76b5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:47be:e160:d2cc:76b5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83f4dd91sm145977866b.39.2026.07.29.11.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:25:34 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 29 Jul 2026 20:25:22 +0200
Subject: [PATCH v4 1/2] tpm: bounds-check the device-reported response length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-tpm-trunc-resp-v4-1-5dd1a634ea4d@byteray.co.uk>
References: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
In-Reply-To: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785349535; x=1785954335;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bP/mZhZRX726JsHEnsnXMVrBqvA8fbTzyFncaK1sWWU=;
 b=zTfsj/r9NevFZlTDYmRaotf+GDglNzCXdle0P6MIQu/i1pLfJEpR03lWWZYN/gzSCe
 y2R5I6wj9NUfh41jUBH5Jq7fzyonylngXVdaCiCDm2RvU3VhBq299UHMS/0YwGD6t4IC
 TYI74kxM0OnvPeR+eqWS8vnInsidc7D1E8du6QBlxM2mpmwqXxiUGpBNmhvrNoEMU8Rs
 msJXlH1pzMBp8QcgrCIpwddjspsU1fK/9d3Dnct9x9HjQQqw/bQ5lmb5OpTHl6vWHyRA
 x/e6ZB5eVQ8PoDVfyvNsj8n2T9oKS9W+Y50s3RWC1K5juBsL0kiQIwis6V6qokh5YTUv
 WhSQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=zTfsj/r9
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The length of a TPM reply is set by the device: tpm_sendrecv_command()
stores the number of bytes received, caps it only at the command buffer
size, and reports success whenever the reply's return code is 0. Callers
then use that length unchecked. The clearest damage is in the parsers that
compute response_length - <header> and index the result (the TPM1 OIAP
helpers and tpm2_get_capability): a reply shorter than the header
underflows the subtraction into a huge memcpy.

Rather than guard each caller, check the length once at the choke point.
tpm_sendrecv_command() gains a min_response_len argument and rejects a
reply shorter than the caller says it needs, before the caller parses it;
every command that reads a response now declares its minimum.

tpm2_get_capability() additionally copies response_len - 15 bytes into the
caller's buffer, but was never told how big that buffer is, so a reply
longer than it overruns it. Give the function a buf_size argument and
reject a reply that would not fit, so the copy is bounded for every
capability rather than for the properties query alone.

A TPM sits on a discrete SPI/I2C/LPC bus that is physically accessible, so
a reply this malformed is reachable by a bus interposer or a faulty part;
on the TPM2 path this parsing runs during measured boot.

Fixes: 69cd8f0681f4 ("tpm: add TPM2_GetCapability command support")
Fixes: be6c1529c1ce ("tpm: add AUTH1 cmds for LoadKey2 and GetPubKey")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 cmd/tpm-v2.c              |  4 +++-
 include/tpm-v2.h          |  5 ++--
 lib/efi_loader/efi_tcg2.c |  9 ++++---
 lib/tpm-common.c          | 16 ++++++++++---
 lib/tpm-utils.h           |  8 ++++++-
 lib/tpm-v1.c              | 59 +++++++++++++++++++++++++++-------------------
 lib/tpm-v2.c              | 60 ++++++++++++++++++++++++++++-------------------
 lib/tpm_api.c             |  4 +++-
 8 files changed, 106 insertions(+), 59 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 847b2691581..5c591b30119 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -211,7 +211,9 @@ static int do_tpm_get_capability(struct cmd_tbl *cmdtp, int flag, int argc,
 	data = map_sysmem(simple_strtoul(argv[3], NULL, 0), 0);
 	count = simple_strtoul(argv[4], NULL, 0);
 
-	rc = tpm2_get_capability(dev, capability, property, data, count);
+	rc = tpm2_get_capability(dev, capability, property, data,
+				 sizeof(u32) + count * sizeof(struct tpms_tagged_property),
+				 count);
 	if (rc)
 		goto unmap_data;
 
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index a776d24d71f..4f5082f2234 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -550,12 +550,13 @@ u32 tpm2_pcr_read(struct udevice *dev, u32 idx, unsigned int idx_min_sz,
  * @capability	Partition of capabilities
  * @property	Further definition of capability, limited to be 4 bytes wide
  * @buf		Output buffer for capability information
- * @prop_count	Size of output buffer
+ * @buf_size	Size of @buf in bytes
+ * @prop_count	Number of properties to request
  *
  * Return: code of the operation
  */
 u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
-			void *buf, size_t prop_count);
+			void *buf, size_t buf_size, size_t prop_count);
 
 /**
  * tpm2_get_pcr_info() - get the supported, active PCRs and number of banks
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 5f9bbe97455..e15a2340e83 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -154,7 +154,8 @@ static int tpm2_get_max_command_size(struct udevice *dev, u16 *max_command_size)
 
 	memset(response, 0, sizeof(response));
 	ret = tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
-				  TPM2_PT_MAX_COMMAND_SIZE, response, 1);
+				  TPM2_PT_MAX_COMMAND_SIZE, response,
+				  sizeof(response), 1);
 	if (ret)
 		return -1;
 
@@ -180,7 +181,8 @@ static int tpm2_get_max_response_size(struct udevice *dev,
 
 	memset(response, 0, sizeof(response));
 	ret = tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
-				  TPM2_PT_MAX_RESPONSE_SIZE, response, 1);
+				  TPM2_PT_MAX_RESPONSE_SIZE, response,
+				  sizeof(response), 1);
 	if (ret)
 		return -1;
 
@@ -205,7 +207,8 @@ static int tpm2_get_manufacturer_id(struct udevice *dev, u32 *manufacturer_id)
 
 	memset(response, 0, sizeof(response));
 	ret = tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
-				  TPM2_PT_MANUFACTURER, response, 1);
+				  TPM2_PT_MANUFACTURER, response,
+				  sizeof(response), 1);
 	if (ret)
 		return -1;
 
diff --git a/lib/tpm-common.c b/lib/tpm-common.c
index b592c22bfc1..e4a620990fa 100644
--- a/lib/tpm-common.c
+++ b/lib/tpm-common.c
@@ -159,7 +159,8 @@ u32 tpm_return_code(const void *response)
 }
 
 u32 tpm_sendrecv_command(struct udevice *dev, const void *command,
-			 void *response, size_t *size_ptr)
+			 void *response, size_t *size_ptr,
+			 size_t min_response_len)
 {
 	int err, ret;
 	u8 response_buffer[COMMAND_BUFFER_SIZE];
@@ -190,11 +191,20 @@ u32 tpm_sendrecv_command(struct udevice *dev, const void *command,
 	if (err < 0)
 		return err;
 
+	ret = tpm_return_code(response);
+
+	/*
+	 * The response length is reported by the (untrusted) TPM. Reject a
+	 * successful reply too short to hold what the caller will parse, so it
+	 * cannot read past the end of a truncated response. A TPM error reply
+	 * is a bare header with no body; let its return code reach the caller.
+	 */
+	if (!ret && size_ptr && response_length < min_response_len)
+		return TPM_LIB_ERROR;
+
 	if (size_ptr)
 		*size_ptr = response_length;
 
-	ret = tpm_return_code(response);
-
 	log_debug("TPM response [ret:%d]: ", ret);
 	for (i = 0; i < response_length; i++)
 		log_debug("%02x ", ((u8 *)response)[i]);
diff --git a/lib/tpm-utils.h b/lib/tpm-utils.h
index a519e182353..fcff8b8beef 100644
--- a/lib/tpm-utils.h
+++ b/lib/tpm-utils.h
@@ -76,9 +76,15 @@ u32 tpm_return_code(const void *response);
  * @param size_ptr	output buffer size (input parameter) and TPM
  *			response length (output parameter); this parameter
  *			is a bidirectional
+ * @param min_response_len	minimum acceptable response length in bytes,
+ *			including the 10-byte header. When @size_ptr is not NULL
+ *			and the TPM returns fewer bytes, the command fails rather
+ *			than let the caller parse a truncated reply. Pass 0 when
+ *			the response body is not parsed.
  * Return: return code of the TPM response
  */
 u32 tpm_sendrecv_command(struct udevice *dev, const void *command,
-			 void *response, size_t *size_ptr);
+			 void *response, size_t *size_ptr,
+			 size_t min_response_len);
 
 #endif /* __TPM_UTILS_H */
diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
index a6727c575fd..a0ebe924311 100644
--- a/lib/tpm-v1.c
+++ b/lib/tpm-v1.c
@@ -44,7 +44,7 @@ u32 tpm1_startup(struct udevice *dev, enum tpm_startup_type mode)
 			     mode_offset, mode))
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, buf, NULL, NULL);
+	return tpm_sendrecv_command(dev, buf, NULL, NULL, 0);
 }
 
 u32 tpm1_resume(struct udevice *dev)
@@ -57,7 +57,7 @@ u32 tpm1_self_test_full(struct udevice *dev)
 	const u8 command[10] = {
 		0x0, 0xc1, 0x0, 0x0, 0x0, 0xa, 0x0, 0x0, 0x0, 0x50,
 	};
-	return tpm_sendrecv_command(dev, command, NULL, NULL);
+	return tpm_sendrecv_command(dev, command, NULL, NULL, 0);
 }
 
 u32 tpm1_continue_self_test(struct udevice *dev)
@@ -65,7 +65,7 @@ u32 tpm1_continue_self_test(struct udevice *dev)
 	const u8 command[10] = {
 		0x0, 0xc1, 0x0, 0x0, 0x0, 0xa, 0x0, 0x0, 0x0, 0x53,
 	};
-	return tpm_sendrecv_command(dev, command, NULL, NULL);
+	return tpm_sendrecv_command(dev, command, NULL, NULL, 0);
 }
 
 u32 tpm1_auto_start(struct udevice *dev)
@@ -148,7 +148,7 @@ u32 tpm1_nv_define_space(struct udevice *dev, u32 index, u32 perm, u32 size)
 			     size_offset, size))
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, buf, NULL, NULL);
+	return tpm_sendrecv_command(dev, buf, NULL, NULL, 0);
 }
 
 u32 tpm1_nv_set_locked(struct udevice *dev)
@@ -175,7 +175,8 @@ u32 tpm1_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count)
 			     index_offset, index,
 			     length_offset, count))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + dataSize(4) = 14 */
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 14);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "d",
@@ -214,7 +215,7 @@ u32 tpm1_nv_write_value(struct udevice *dev, u32 index, const void *data,
 			     length_offset, length,
 			     data_offset, data, length))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 0);
 	if (err)
 		return err;
 
@@ -241,7 +242,8 @@ u32 tpm1_extend(struct udevice *dev, u32 index, const void *in_digest,
 			     in_digest_offset, in_digest,
 			     PCR_DIGEST_LENGTH))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + digest(20) = 30 */
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 30);
 	if (err)
 		return err;
 
@@ -271,7 +273,8 @@ u32 tpm1_pcr_read(struct udevice *dev, u32 index, void *data, size_t count)
 			     0, command, sizeof(command),
 			     index_offset, index))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + digest(20) = 30 */
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 30);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "s",
@@ -294,7 +297,7 @@ u32 tpm1_tsc_physical_presence(struct udevice *dev, u16 presence)
 			     presence_offset, presence))
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, buf, NULL, NULL);
+	return tpm_sendrecv_command(dev, buf, NULL, NULL, 0);
 }
 
 u32 tpm1_finalise_physical_presence(struct udevice *dev)
@@ -303,7 +306,7 @@ u32 tpm1_finalise_physical_presence(struct udevice *dev)
 		0x0, 0xc1, 0x0, 0x0, 0x0, 0xc, 0x40, 0x0, 0x0, 0xa, 0x2, 0xa0,
 	};
 
-	return tpm_sendrecv_command(dev, command, NULL, NULL);
+	return tpm_sendrecv_command(dev, command, NULL, NULL, 0);
 }
 
 u32 tpm1_read_pubek(struct udevice *dev, void *data, size_t count)
@@ -319,7 +322,8 @@ u32 tpm1_read_pubek(struct udevice *dev, void *data, size_t count)
 	u32 data_size;
 	u32 err;
 
-	err = tpm_sendrecv_command(dev, command, response, &response_length);
+	/* tag(2) + size(4) + rc(4) = 10 */
+	err = tpm_sendrecv_command(dev, command, response, &response_length, 10);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "d",
@@ -343,7 +347,7 @@ u32 tpm1_force_clear(struct udevice *dev)
 		0x0, 0xc1, 0x0, 0x0, 0x0, 0xa, 0x0, 0x0, 0x0, 0x5d,
 	};
 
-	return tpm_sendrecv_command(dev, command, NULL, NULL);
+	return tpm_sendrecv_command(dev, command, NULL, NULL, 0);
 }
 
 u32 tpm1_physical_enable(struct udevice *dev)
@@ -352,7 +356,7 @@ u32 tpm1_physical_enable(struct udevice *dev)
 		0x0, 0xc1, 0x0, 0x0, 0x0, 0xa, 0x0, 0x0, 0x0, 0x6f,
 	};
 
-	return tpm_sendrecv_command(dev, command, NULL, NULL);
+	return tpm_sendrecv_command(dev, command, NULL, NULL, 0);
 }
 
 u32 tpm1_physical_disable(struct udevice *dev)
@@ -361,7 +365,7 @@ u32 tpm1_physical_disable(struct udevice *dev)
 		0x0, 0xc1, 0x0, 0x0, 0x0, 0xa, 0x0, 0x0, 0x0, 0x70,
 	};
 
-	return tpm_sendrecv_command(dev, command, NULL, NULL);
+	return tpm_sendrecv_command(dev, command, NULL, NULL, 0);
 }
 
 u32 tpm1_physical_set_deactivated(struct udevice *dev, u8 state)
@@ -377,7 +381,7 @@ u32 tpm1_physical_set_deactivated(struct udevice *dev, u8 state)
 			     state_offset, state))
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, buf, NULL, NULL);
+	return tpm_sendrecv_command(dev, buf, NULL, NULL, 0);
 }
 
 u32 tpm1_get_capability(struct udevice *dev, u32 cap_area, u32 sub_cap,
@@ -405,7 +409,8 @@ u32 tpm1_get_capability(struct udevice *dev, u32 cap_area, u32 sub_cap,
 			     cap_area_offset, cap_area,
 			     sub_cap_offset, sub_cap))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + capSize(4) = 14 */
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 14);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "d",
@@ -438,7 +443,8 @@ u32 tpm1_get_permanent_flags(struct udevice *dev,
 	u32 err;
 	u32 data_size;
 
-	err = tpm_sendrecv_command(dev, command, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + dataSize(4) = 14 */
+	err = tpm_sendrecv_command(dev, command, response, &response_length, 14);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "d",
@@ -478,7 +484,8 @@ u32 tpm1_get_permissions(struct udevice *dev, u32 index, u32 *perm)
 			     0, command, sizeof(command),
 			     index_offset, index))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + respSize(4) + nvPublic(60) + attributes(4) = 78 */
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 78);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "d",
@@ -510,7 +517,7 @@ u32 tpm1_flush_specific(struct udevice *dev, u32 key_handle, u32 resource_type)
 			     resource_type_offset, resource_type))
 		return TPM_LIB_ERROR;
 
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 0);
 	if (err)
 		return err;
 	return 0;
@@ -667,7 +674,7 @@ u32 tpm1_terminate_auth_session(struct udevice *dev, u32 auth_handle)
 	if (oiap_session.valid && oiap_session.handle == auth_handle)
 		oiap_session.valid = 0;
 
-	return tpm_sendrecv_command(dev, request, NULL, NULL);
+	return tpm_sendrecv_command(dev, request, NULL, NULL, 0);
 }
 
 u32 tpm1_end_oiap(struct udevice *dev)
@@ -695,7 +702,8 @@ u32 tpm1_oiap(struct udevice *dev, u32 *auth_handle)
 	if (oiap_session.valid)
 		tpm1_terminate_auth_session(dev, oiap_session.handle);
 
-	err = tpm_sendrecv_command(dev, command, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + authHandle(4) + nonceEven(20) = 34 */
+	err = tpm_sendrecv_command(dev, command, response, &response_length, 34);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "ds",
@@ -750,7 +758,8 @@ u32 tpm1_load_key2_oiap(struct udevice *dev, u32 parent_handle, const void *key,
 				  parent_key_usage_auth);
 	if (err)
 		return err;
-	err = tpm_sendrecv_command(dev, request, response, &response_length);
+	/* nonceEven(20) + continueAuthSession(1) + resAuth(20) = 41 */
+	err = tpm_sendrecv_command(dev, request, response, &response_length, 41);
 	if (err) {
 		if (err == TPM_AUTHFAIL)
 			oiap_session.valid = 0;
@@ -811,7 +820,8 @@ u32 tpm1_get_pub_key_oiap(struct udevice *dev, u32 key_handle,
 				  request + sizeof(command), usage_auth);
 	if (err)
 		return err;
-	err = tpm_sendrecv_command(dev, request, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + nonceEven(20) + continueAuthSession(1) + resAuth(20) = 51 */
+	err = tpm_sendrecv_command(dev, request, response, &response_length, 51);
 	if (err) {
 		if (err == TPM_AUTHFAIL)
 			oiap_session.valid = 0;
@@ -907,8 +917,9 @@ u32 tpm1_get_random(struct udevice *dev, void *data, u32 count)
 				     0, command, sizeof(command),
 				     length_offset, this_bytes))
 			return TPM_LIB_ERROR;
+		/* tag(2) + size(4) + rc(4) + randomSize(4) = 14 */
 		err = tpm_sendrecv_command(dev, buf, response,
-					   &response_length);
+					   &response_length, 14);
 		if (err)
 			return err;
 		if (unpack_byte_string(response, response_length, "d",
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index f443b738f82..9a567b29293 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -180,7 +180,7 @@ u32 tpm2_startup(struct udevice *dev, bool bon, enum tpm2_startup_types mode)
 	 * Note TPM2_Startup command will return RC_SUCCESS the first time,
 	 * but will return RC_INITIALIZE otherwise.
 	 */
-	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 	if ((ret && ret != TPM2_RC_INITIALIZE) || !bon)
 		return ret;
 
@@ -196,7 +196,7 @@ u32 tpm2_self_test(struct udevice *dev, enum tpm2_yes_no full_test)
 		full_test,
 	};
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_auto_start(struct udevice *dev)
@@ -252,7 +252,7 @@ u32 tpm2_clear(struct udevice *dev, u32 handle, const char *pw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
@@ -307,7 +307,7 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space_index,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
@@ -358,7 +358,7 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count)
@@ -391,7 +391,8 @@ u32 tpm2_nv_read_value(struct udevice *dev, u32 index, void *data, u32 count)
 	u16 tag;
 	u32 size, code;
 
-	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
+	/* tag(2) + size(4) + rc(4) + paramSize(4) + nvSize(2) = 16 */
+	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len, 16);
 	if (ret)
 		return log_msg_ret("read", ret);
 	if (unpack_byte_string(response, response_len, "wdds",
@@ -442,7 +443,7 @@ u32 tpm2_nv_write_value(struct udevice *dev, u32 index, const void *data,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, response, &response_len);
+	return tpm_sendrecv_command(dev, command_v2, response, &response_len, 0);
 }
 
 u32 tpm2_pcr_read(struct udevice *dev, u32 idx, unsigned int idx_min_sz,
@@ -472,7 +473,8 @@ u32 tpm2_pcr_read(struct udevice *dev, u32 idx, unsigned int idx_min_sz,
 			     17 + pcr_sel_idx, pcr_sel_bit))
 		return TPM_LIB_ERROR;
 
-	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
+	/* tag(2) + size(4) + rc(4) + pcrUpdateCounter(4) = 14 */
+	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len, 14);
 	if (ret)
 		return ret;
 
@@ -492,7 +494,7 @@ u32 tpm2_pcr_read(struct udevice *dev, u32 idx, unsigned int idx_min_sz,
 }
 
 u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
-			void *buf, size_t prop_count)
+			void *buf, size_t buf_size, size_t prop_count)
 {
 	u8 command_v2[COMMAND_BUFFER_SIZE] = {
 		tpm_u16(TPM2_ST_NO_SESSIONS),		/* TAG */
@@ -508,7 +510,8 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 	unsigned int properties_off;
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
+	/* tag(2) + size(4) + rc(4) + moreData(1) + cap(4) = 15 */
+	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len, 15);
 	if (ret)
 		return ret;
 
@@ -519,6 +522,11 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 	 */
 	properties_off = sizeof(u16) + sizeof(u32) + sizeof(u32) +
 			 sizeof(u8) + sizeof(u32);
+
+	/* the reply length is set by the TPM; do not overrun the caller's buf */
+	if (response_len - properties_off > buf_size)
+		return TPM_LIB_ERROR;
+
 	memcpy(buf, &response[properties_off], response_len - properties_off);
 
 	return 0;
@@ -641,7 +649,7 @@ u32 tpm2_send_pcr_allocate(struct udevice *dev, const char *pw,
 		offset += sel->size_of_select;
 	}
 
-	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
+	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len, 0);
 	if (!ret)
 		tpm_init(dev);
 
@@ -659,7 +667,8 @@ static int tpm2_get_num_pcr(struct udevice *dev, u32 *num_pcr)
 
 	memset(response, 0, sizeof(response));
 	ret = tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
-				  TPM2_PT_PCR_COUNT, response, 1);
+				  TPM2_PT_PCR_COUNT, response,
+				  sizeof(response), 1);
 	if (ret)
 		return ret;
 
@@ -680,7 +689,8 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
 	size_t i;
 	u32 ret;
 
-	ret = tpm2_get_capability(dev, TPM2_CAP_PCRS, 0, response, 1);
+	ret = tpm2_get_capability(dev, TPM2_CAP_PCRS, 0, response,
+				  sizeof(response), 1);
 	if (ret)
 		return ret;
 
@@ -767,7 +777,7 @@ u32 tpm2_dam_reset(struct udevice *dev, const char *pw, const ssize_t pw_sz)
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_dam_parameters(struct udevice *dev, const char *pw,
@@ -816,7 +826,7 @@ u32 tpm2_dam_parameters(struct udevice *dev, const char *pw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 int tpm2_change_auth(struct udevice *dev, u32 handle, const char *newpw,
@@ -861,7 +871,7 @@ int tpm2_change_auth(struct udevice *dev, u32 handle, const char *newpw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_pcr_setauthpolicy(struct udevice *dev, const char *pw,
@@ -916,7 +926,7 @@ u32 tpm2_pcr_setauthpolicy(struct udevice *dev, const char *pw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_pcr_setauthvalue(struct udevice *dev, const char *pw,
@@ -962,7 +972,7 @@ u32 tpm2_pcr_setauthvalue(struct udevice *dev, const char *pw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_get_random(struct udevice *dev, void *data, u32 count)
@@ -989,8 +999,9 @@ u32 tpm2_get_random(struct udevice *dev, void *data, u32 count)
 				     0, command_v2, sizeof(command_v2),
 				     sizeof(command_v2), this_bytes))
 			return TPM_LIB_ERROR;
+		/* tag(2) + size(4) + rc(4) + randomSize(2) = 12 */
 		err = tpm_sendrecv_command(dev, buf, response,
-					   &response_length);
+					   &response_length, 12);
 		if (err)
 			return err;
 		if (unpack_byte_string(response, response_length, "w",
@@ -1029,7 +1040,7 @@ u32 tpm2_write_lock(struct udevice *dev, u32 index)
 		tpm_u16(0),			/* auth_size */
 	};
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_disable_platform_hierarchy(struct udevice *dev)
@@ -1057,7 +1068,7 @@ u32 tpm2_disable_platform_hierarchy(struct udevice *dev)
 	};
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 	log_info("ret=%s, %x\n", dev->name, ret);
 	if (ret)
 		return ret;
@@ -1070,7 +1081,7 @@ u32 tpm2_disable_platform_hierarchy(struct udevice *dev)
 u32 tpm2_submit_command(struct udevice *dev, const u8 *sendbuf,
 			u8 *recvbuf, size_t *recv_size)
 {
-	return tpm_sendrecv_command(dev, sendbuf, recvbuf, recv_size);
+	return tpm_sendrecv_command(dev, sendbuf, recvbuf, recv_size, 0);
 }
 
 u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
@@ -1086,7 +1097,8 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
 	};
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, recvbuf, recv_size);
+	/* tag(2) + size(4) + rc(4) + subCmd(2) = 12 */
+	ret = tpm_sendrecv_command(dev, command_v2, recvbuf, recv_size, 12);
 	log_debug("ret=%s, %x\n", dev->name, ret);
 	if (ret)
 		return ret;
@@ -1111,7 +1123,7 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 	};
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 	log_debug("ret=%s, %x\n", dev->name, ret);
 	if (ret)
 		return ret;
diff --git a/lib/tpm_api.c b/lib/tpm_api.c
index 576d601e5ff..a26b8c7671c 100644
--- a/lib/tpm_api.c
+++ b/lib/tpm_api.c
@@ -271,7 +271,9 @@ u32 tpm_get_capability(struct udevice *dev, u32 cap_area, u32 sub_cap,
 	if (tpm_is_v1(dev))
 		return tpm1_get_capability(dev, cap_area, sub_cap, cap, count);
 	else if (tpm_is_v2(dev))
-		return tpm2_get_capability(dev, cap_area, sub_cap, cap, count);
+		/* @count is the buffer size in bytes, as tpm1 expects */
+		return tpm2_get_capability(dev, cap_area, sub_cap, cap, count,
+					   count);
 	else
 		return -ENOSYS;
 }

-- 
2.43.0

