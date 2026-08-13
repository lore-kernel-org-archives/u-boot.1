Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808F5C5DF67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 476C7409C7;
	Thu, 13 Aug 2026 16:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMGPmdLt2Q33; Thu, 13 Aug 2026 16:00:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B0AF409CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636850;
	bh=5wgJd0RxLceISux5LfQ5XvSn86llHFXPJP24OD1mDK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u1uaNgLcTYtX/5uy7/mXkhqYM4FFdvKhJmONgRQh10ncExhKvzY7gUqwtWbVjTU+7
	 zx78NqiGrmgUcd3X8cUXSkaiMnVogfcpYVxK7UNP8wlJMWYxChVrDewwfG7N6FI5Ok
	 ayun6pbEsarVajR8a0LfSFQgYCVV7y5iY4pK+1Y5ZqAUJP3xKEYT6RVW1i8yyEhxAj
	 eIqXqghSLEW4kXnm6A5KP1FmZ+apYIH8BPgg9gtfhw1r62qIv3aS23rz+VIPjTDK4k
	 IeC12nrAtC/CvooNATQH0DsRFvCmVOb1WztA4PfFtswiPC2C7mIdEqPWVR/uzlwDMX
	 vsxacaCxplZSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B0AF409CF;
	Thu, 13 Aug 2026 16:00:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C613A388
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACEC5812A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dl8zmcimjbih for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:58:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D715F812AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D715F812AA
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D715F812AA
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:54 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so17771566b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636733; x=1787241533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5wgJd0RxLceISux5LfQ5XvSn86llHFXPJP24OD1mDK4=;
 b=BcyFPVtys5MV15VTmtWA7DfCMg0G/uQAeqGppr5i98Zim/rnBKxGwlYcBGnia0L+0W
 XCHe2zgPaU9b6ijfF9K6xkiUvAKS8wDRFxfNHD0sx9+MOfAzH9QeE28MqItEwhv2aQ6T
 nW2sLEK4GjAKuSeMRMj1bXFj2E+BI8FrwyeH8YrqKxSU1DeLtqVzaPuBUYVWe6lsB1vx
 v6RmoMI64bfrfpgsyakH1V17eSd6lIMvJLqqg4km3+xqxinBMtJtKWC2YRFiHyklC0Sr
 SnAYNlJ5Ip/neRrqdcvnsNU/0LORwFNYLTGDDVgwyhMwJvNX9XaTvz2lB+zjndw2/EPp
 WUEQ==
X-Gm-Message-State: AOJu0YxYpKf+9zjyJtBFn6DhWGkm26PGIjqbFt6al82XXw+7HRrsWCZx
 nKV5PwoLt+wFbvR8Lwuo3pP8Pb0CXPXPo1wHz+VJc5TU0z4Lf0M6HUDLDjG8NItHAkQ=
X-Gm-Gg: AR+sD13xrlCvG/P3w4TLMLpvdUpW0a1nsHBaZIBGHml0u+0rTd7mqcPjEG2jY6ZAsRW
 L37/TGM8qJAu31GUEfOdWIOcmb0+xnG6UL4Yq4GAndomNi2heN74RKIx4LM5uNwMioqabdDVV/U
 F+lGknfoyMdujU/7KpJfBnLcU+FZR/sT4SyaqtSTOEBXExMhmopTyMLkI9umHZa6+H9bqCrqdES
 MfBae0/hN6rkQhc7KxMUi4xnVRAhq5ibUm6yn+SLZT7rhVgiR1GU5ezsyi2PXlU2UsahjmvAIez
 fjUOIeeZ6DNm8uIo0nzDgfUMi57ZlPSqLgbJeSS59e1mdTejKEsj+gWArXNz9ev6r5yvQkrsDSJ
 HVEsO8bdzHZUpXWDZKFmCz0biMtMdeUD+oMbKyfkwTRzcRPKpy7425fxWa1TC4Ro3c8/6DUY5oC
 jdpSC5yx+/eMsFgMfwSWbos8iG2MNO1gO53lkAVNVrIGNDnBaitvAD6M5LxqRiKXDxsOnIL8FA8
 7aOMqfnCMZEtTtIKOyvCt873HX5yn1tLLoTH5JiPo2xSjXppN+C
X-Received: by 2002:a17:907:3c8f:b0:c20:d4c2:f533 with SMTP id
 a640c23a62f3a-c2108fb351cmr337115166b.16.1786636732686; 
 Thu, 13 Aug 2026 08:58:52 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21233a12e6sm9087366b.12.2026.08.13.08.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:58:52 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 17:58:43 +0200
Subject: [PATCH v5 1/2] tpm: bounds-check the device-reported response length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-tpm-trunc-resp-v5-1-153b492a3256@byteray.co.uk>
References: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
In-Reply-To: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 16:00:48 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786636733; x=1787241533;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5wgJd0RxLceISux5LfQ5XvSn86llHFXPJP24OD1mDK4=;
 b=rrRq2I7xhZjyn8ZThY5lwG4r6LxWmdN8HZ/nz9yhKsEL8xtxgf8H9B81UH/Cgz+Rq9
 7XrGLLhOReomlODfdB8CP6jlnlWgFN8Z1kDBZlNotwljA8Ab+OMjV5KecY9uGCtRPZpq
 SSTS9EJokFbglM8xqd5niVjS8PSVRcjHt/4B2EfMZlv972Bb75Hm5JCEzMz3bcqQH2al
 etTrPhyUl4fvOm5UdG9A3aE3ZN+S/CRzbFeQAyEzfzZKgiwWiEI0WdrzPo66Lh5mKoh/
 Fp/1qUltTRCNEZBbJXarKXOZX3zzdXphBzybtWcywsLfs1lrzGjibrMHEZq4Iv//XhTf
 UdCw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=rrRq2I7x
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/tpm-v2.c              |  4 ++-
 include/tpm-v2.h          |  5 ++--
 lib/efi_loader/efi_tcg2.c |  9 ++++---
 lib/tpm-common.c          | 16 +++++++++---
 lib/tpm-utils.h           |  6 ++++-
 lib/tpm-v1.c              | 62 +++++++++++++++++++++++++++++------------------
 lib/tpm-v2.c              | 60 +++++++++++++++++++++++++++------------------
 lib/tpm_api.c             |  4 ++-
 8 files changed, 107 insertions(+), 59 deletions(-)

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
index a519e182353..066f7e6fb36 100644
--- a/lib/tpm-utils.h
+++ b/lib/tpm-utils.h
@@ -76,9 +76,13 @@ u32 tpm_return_code(const void *response);
  * @param size_ptr	output buffer size (input parameter) and TPM
  *			response length (output parameter); this parameter
  *			is a bidirectional
+ * @param min_response_len	minimum acceptable response length in bytes,
+ *			including the header. Pass 0 when
+ *			the response body is not parsed.
  * Return: return code of the TPM response
  */
 u32 tpm_sendrecv_command(struct udevice *dev, const void *command,
-			 void *response, size_t *size_ptr);
+			 void *response, size_t *size_ptr,
+			 size_t min_response_len);
 
 #endif /* __TPM_UTILS_H */
diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
index a6727c575fd..6dd4c6d9d1e 100644
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
@@ -750,7 +758,11 @@ u32 tpm1_load_key2_oiap(struct udevice *dev, u32 parent_handle, const void *key,
 				  parent_key_usage_auth);
 	if (err)
 		return err;
-	err = tpm_sendrecv_command(dev, request, response, &response_length);
+	/*
+	 * tag(2) + size(4) + rc(4) + keyHandle(4) + nonceEven(20) +
+	 * continueAuthSession(1) + resAuth(20) = 55
+	 */
+	err = tpm_sendrecv_command(dev, request, response, &response_length, 55);
 	if (err) {
 		if (err == TPM_AUTHFAIL)
 			oiap_session.valid = 0;
@@ -811,7 +823,8 @@ u32 tpm1_get_pub_key_oiap(struct udevice *dev, u32 key_handle,
 				  request + sizeof(command), usage_auth);
 	if (err)
 		return err;
-	err = tpm_sendrecv_command(dev, request, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + nonceEven(20) + continueAuthSession(1) + resAuth(20) = 51 */
+	err = tpm_sendrecv_command(dev, request, response, &response_length, 51);
 	if (err) {
 		if (err == TPM_AUTHFAIL)
 			oiap_session.valid = 0;
@@ -907,8 +920,9 @@ u32 tpm1_get_random(struct udevice *dev, void *data, u32 count)
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

