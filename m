Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16548C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE9A9812BE;
	Tue, 28 Jul 2026 13:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1prGpfIedomP; Tue, 28 Jul 2026 13:00:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69D7B813E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243608;
	bh=3l+DRVxC1NY4cjTFEHkj161KJQV9lBcA8PzBp0YlzQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NuT1xd1G4XmQ93bSFG8xlvuWgLfgRB9Dvkcz42QIEd4NEt5A7x0ZimoQ2PxFL6oUv
	 BHZTeucoC3+j4ihNIKkELC2cKeowk0UdxMsbvW3HjJuFUol7jCL+jRdsingw0fPg1I
	 KJeWNWHVbVH4X1myBy8v+Dm0Wqe3Q9s8KPugF6aIcoId7Kk42phg/zaTIl3Rl7ZdlK
	 qW4MkjupKWLb4FzG185m1G5k98ynL1YDjVgtOdSep7jVrYMMsTf/4G47+Hj2j38+ng
	 KKy8GUAmAaNP2nvJmcUxdvBg/CdNSLzL02S2/2aWw2gkitmDWrOGxGgUAn5xZbmybS
	 aFxSaoZdeJajw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69D7B813E7;
	Tue, 28 Jul 2026 13:00:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55967A47
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 447438127A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0xAuTYJbTK0 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 07:38:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 86ECB81274
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86ECB81274
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86ECB81274
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:10 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so5882768a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 00:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224288; x=1785829088;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3l+DRVxC1NY4cjTFEHkj161KJQV9lBcA8PzBp0YlzQs=;
 b=f02nMuNEy1WckOEM6Q1MOY387E3hmW9F5U9O6YPlDPdwT6VmVAVEOylmHnu/qXrGlG
 9CFrLdEPkP6h5Xun2wqUSEwm15CgC4Wb87YmUEQnSXlDL6Jcnze3Kv3TOpSG47RJuoaJ
 O/qmLJaWH8Up+Bu0L8JHvxSaksBWN9PIMFXDXOcv9JtcX+qBbL44ZDqG5QQGZpWPt6ZC
 GrvqQ0cBIkO5AtJHSjzRrVaUX4iCMUGT3ppFDC9pcvwrLs16SMiqXFtG48GDr5pVwRv9
 E5VQVuAktY+008zdtU/g+xbCGZO4fX4GrnHBd8Gd9G6tV5/phiPZTxgXgXfVE5HWhKmh
 baiA==
X-Gm-Message-State: AOJu0YwEIxwL8aCNydFpuE8YoK59LVj6jFbjxtuYvxp7RkA5RgXesf55
 O/G8Gc/KIg6/WR1hn1YwxeqPy6RwKWSLiq9qmu7EPk9D6vodQj9REPh2ZF1PTMwobmc=
X-Gm-Gg: AR+sD137qC6mUbBMYlyO53EqlEZARmHKKuuP2IIQwnxBVv78gGbaC5J0Hyj5iKexyDM
 QGktgiMGr+0P5+X89grB9t6aJQsxU7oYDc2jU/MG5W8U0/DgOXo/3JC1w+A4Q3HMBQG4SAXihh4
 2J7zjgqIq2APGH5bL5hy8l0kztTTAfQkP6Y/CckI5wnPE5yjXe6Je7DvnbCYkpORbl5FNaGcFf8
 3xPxUILhpv0afE44NNqSiKmQZSDVw+Av+464pqHOctc02n9rPRf4DQBvMX7dU9ZnTpUXOQg+H2x
 N8Mrj14WUm1wd/mGpSQptj2yfkFa0EBxddpFw8EdkAaY7s91oJ4XmvJo6Tt/a3tZ9fTV5obWA7T
 YPKimAZAik0jjPdTQN1HlaR/gNwSnewROoRjATzJP8iO2TJRxFjvKkujIDAB3fm3Jn7x4l6C+HW
 dmzRp5gxQUgRdGg0IANhmhaHwNILu5ysvh2EOma8SDgUfjIP32oRAb9+sGJ3XulUOhDFLGQpLc5
 hRpxA==
X-Received: by 2002:a05:6402:40c5:b0:69f:c7ff:a755 with SMTP id
 4fb4d7f45d1cf-6a034a8ae9dmr566666a12.31.1785224288353; 
 Tue, 28 Jul 2026 00:38:08 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb50bcfdcsm3654045a12.3.2026.07.28.00.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:38:08 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 09:37:53 +0200
Subject: [PATCH v3 1/2] tpm: bounds-check the device-reported response length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-tpm-trunc-resp-v3-1-8e20bcfb64c5@byteray.co.uk>
References: <20260728-tpm-trunc-resp-v3-0-8e20bcfb64c5@byteray.co.uk>
In-Reply-To: <20260728-tpm-trunc-resp-v3-0-8e20bcfb64c5@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785224288; x=1785829088;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3l+DRVxC1NY4cjTFEHkj161KJQV9lBcA8PzBp0YlzQs=;
 b=txABf5vn/RoEo3MzeQTW5+e5EKHOJ88CGAiXwm8IaK0BxS53+cZ2zmEgPpVo5dtTJd
 QwdjDgx5jwVnTq8A1qe6YvRCemqQuxkYt6evLIoJRCL65002XaepPBu5ST41+Q1BjrWt
 Fo6q5F7xYHOhQtw414rL2COgkM1OGmM0V0fs7kTeyzYpGWhYrW7tezkDMCTZh/az9QB6
 YpMIbH+iora6z8YukF3fL+/gCnjsnKbPPBQeed9kkBx043tad5Pc/86fl3Y4hc9Gq5fy
 a6zgBxYF5F2mHJQFkUvQxgiEvSGVdokxGihwkl30aIhhp900/+VIkHYNgOvz8Y3NObNT
 HIIQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=txABf5vn
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
caller's prop_count-sized buffer, so a reply longer than that buffer
overruns it. Keep a local upper-bound check there for the properties
query; other capabilities read variable-length data into a full-size
buffer, so only the lower bound applies to them.

A TPM sits on a discrete SPI/I2C/LPC bus that is physically accessible, so
a reply this malformed is reachable by a bus interposer or a faulty part;
on the TPM2 path this parsing runs during measured boot.

Fixes: 69cd8f0681f4 ("tpm: add TPM2_GetCapability command support")
Fixes: be6c1529c1ce ("tpm: add AUTH1 cmds for LoadKey2 and GetPubKey")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 lib/tpm-common.c | 16 ++++++++++++---
 lib/tpm-utils.h  |  8 +++++++-
 lib/tpm-v1.c     | 59 +++++++++++++++++++++++++++++++++-----------------------
 lib/tpm-v2.c     | 52 +++++++++++++++++++++++++++++--------------------
 4 files changed, 86 insertions(+), 49 deletions(-)

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
index a6727c575fd..d629ba40ff5 100644
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
+	/* tag(2) + size(4) + rc(4) + dataSize(4) */
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
+	/* tag(2) + size(4) + rc(4) + digest(20) */
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 30);
 	if (err)
 		return err;
 
@@ -271,7 +273,8 @@ u32 tpm1_pcr_read(struct udevice *dev, u32 index, void *data, size_t count)
 			     0, command, sizeof(command),
 			     index_offset, index))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + digest(20) */
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
+	/* tag(2) + size(4) + rc(4) */
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
+	/* tag(2) + size(4) + rc(4) + capSize(4) */
+	err = tpm_sendrecv_command(dev, buf, response, &response_length, 14);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "d",
@@ -438,7 +443,8 @@ u32 tpm1_get_permanent_flags(struct udevice *dev,
 	u32 err;
 	u32 data_size;
 
-	err = tpm_sendrecv_command(dev, command, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + dataSize(4) */
+	err = tpm_sendrecv_command(dev, command, response, &response_length, 14);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "d",
@@ -478,7 +484,8 @@ u32 tpm1_get_permissions(struct udevice *dev, u32 index, u32 *perm)
 			     0, command, sizeof(command),
 			     index_offset, index))
 		return TPM_LIB_ERROR;
-	err = tpm_sendrecv_command(dev, buf, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + respSize(4) + nvPublic(60) + attributes(4) */
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
+	/* tag(2) + size(4) + rc(4) + authHandle(4) + nonceEven(20) */
+	err = tpm_sendrecv_command(dev, command, response, &response_length, 34);
 	if (err)
 		return err;
 	if (unpack_byte_string(response, response_length, "ds",
@@ -750,7 +758,8 @@ u32 tpm1_load_key2_oiap(struct udevice *dev, u32 parent_handle, const void *key,
 				  parent_key_usage_auth);
 	if (err)
 		return err;
-	err = tpm_sendrecv_command(dev, request, response, &response_length);
+	/* nonceEven(20) + continueAuthSession(1) + resAuth(20) */
+	err = tpm_sendrecv_command(dev, request, response, &response_length, 41);
 	if (err) {
 		if (err == TPM_AUTHFAIL)
 			oiap_session.valid = 0;
@@ -811,7 +820,8 @@ u32 tpm1_get_pub_key_oiap(struct udevice *dev, u32 key_handle,
 				  request + sizeof(command), usage_auth);
 	if (err)
 		return err;
-	err = tpm_sendrecv_command(dev, request, response, &response_length);
+	/* tag(2) + size(4) + rc(4) + nonceEven(20) + continueAuthSession(1) + resAuth(20) */
+	err = tpm_sendrecv_command(dev, request, response, &response_length, 51);
 	if (err) {
 		if (err == TPM_AUTHFAIL)
 			oiap_session.valid = 0;
@@ -907,8 +917,9 @@ u32 tpm1_get_random(struct udevice *dev, void *data, u32 count)
 				     0, command, sizeof(command),
 				     length_offset, this_bytes))
 			return TPM_LIB_ERROR;
+		/* tag(2) + size(4) + rc(4) + randomSize(4) */
 		err = tpm_sendrecv_command(dev, buf, response,
-					   &response_length);
+					   &response_length, 14);
 		if (err)
 			return err;
 		if (unpack_byte_string(response, response_length, "d",
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index f443b738f82..6aea58a9d8a 100644
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
+	/* tag(2) + size(4) + rc(4) + paramSize(4) + nvSize(2) */
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
+	/* tag(2) + size(4) + rc(4) + pcrUpdateCounter(4) */
+	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len, 14);
 	if (ret)
 		return ret;
 
@@ -508,7 +510,8 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 	unsigned int properties_off;
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len);
+	/* tag(2) + size(4) + rc(4) + moreData(1) + cap(4) */
+	ret = tpm_sendrecv_command(dev, command_v2, response, &response_len, 15);
 	if (ret)
 		return ret;
 
@@ -519,6 +522,11 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 	 */
 	properties_off = sizeof(u16) + sizeof(u32) + sizeof(u32) +
 			 sizeof(u8) + sizeof(u32);
+	if (capability == TPM2_CAP_TPM_PROPERTIES &&
+	    response_len - properties_off >
+	    sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property))
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
 
@@ -767,7 +775,7 @@ u32 tpm2_dam_reset(struct udevice *dev, const char *pw, const ssize_t pw_sz)
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_dam_parameters(struct udevice *dev, const char *pw,
@@ -816,7 +824,7 @@ u32 tpm2_dam_parameters(struct udevice *dev, const char *pw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 int tpm2_change_auth(struct udevice *dev, u32 handle, const char *newpw,
@@ -861,7 +869,7 @@ int tpm2_change_auth(struct udevice *dev, u32 handle, const char *newpw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_pcr_setauthpolicy(struct udevice *dev, const char *pw,
@@ -916,7 +924,7 @@ u32 tpm2_pcr_setauthpolicy(struct udevice *dev, const char *pw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_pcr_setauthvalue(struct udevice *dev, const char *pw,
@@ -962,7 +970,7 @@ u32 tpm2_pcr_setauthvalue(struct udevice *dev, const char *pw,
 	if (ret)
 		return TPM_LIB_ERROR;
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_get_random(struct udevice *dev, void *data, u32 count)
@@ -989,8 +997,9 @@ u32 tpm2_get_random(struct udevice *dev, void *data, u32 count)
 				     0, command_v2, sizeof(command_v2),
 				     sizeof(command_v2), this_bytes))
 			return TPM_LIB_ERROR;
+		/* tag(2) + size(4) + rc(4) + randomSize(2) */
 		err = tpm_sendrecv_command(dev, buf, response,
-					   &response_length);
+					   &response_length, 12);
 		if (err)
 			return err;
 		if (unpack_byte_string(response, response_length, "w",
@@ -1029,7 +1038,7 @@ u32 tpm2_write_lock(struct udevice *dev, u32 index)
 		tpm_u16(0),			/* auth_size */
 	};
 
-	return tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	return tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 }
 
 u32 tpm2_disable_platform_hierarchy(struct udevice *dev)
@@ -1057,7 +1066,7 @@ u32 tpm2_disable_platform_hierarchy(struct udevice *dev)
 	};
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 	log_info("ret=%s, %x\n", dev->name, ret);
 	if (ret)
 		return ret;
@@ -1070,7 +1079,7 @@ u32 tpm2_disable_platform_hierarchy(struct udevice *dev)
 u32 tpm2_submit_command(struct udevice *dev, const u8 *sendbuf,
 			u8 *recvbuf, size_t *recv_size)
 {
-	return tpm_sendrecv_command(dev, sendbuf, recvbuf, recv_size);
+	return tpm_sendrecv_command(dev, sendbuf, recvbuf, recv_size, 0);
 }
 
 u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
@@ -1086,7 +1095,8 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
 	};
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, recvbuf, recv_size);
+	/* tag(2) + size(4) + rc(4) + subCmd(2) */
+	ret = tpm_sendrecv_command(dev, command_v2, recvbuf, recv_size, 12);
 	log_debug("ret=%s, %x\n", dev->name, ret);
 	if (ret)
 		return ret;
@@ -1111,7 +1121,7 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
 	};
 	int ret;
 
-	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL);
+	ret = tpm_sendrecv_command(dev, command_v2, NULL, NULL, 0);
 	log_debug("ret=%s, %x\n", dev->name, ret);
 	if (ret)
 		return ret;

-- 
2.43.0

