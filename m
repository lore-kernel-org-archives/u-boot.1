Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC8AC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF01940B60;
	Fri, 24 Jul 2026 14:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwYU1nLrAee8; Fri, 24 Jul 2026 14:02:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6BBE40B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901741;
	bh=ynjfPNHtOPWGNzjzhDzttz1tpz+ujngomvZVrZr+i8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NExk2r15aLRVlSOgMhTakw+QLLy8Dkoc27BT0eYmsHxw4jlhL1/miDs2IoOohraCN
	 HlrpAC/yHOhOBqSWW7YpBO/vf9FMWBXbMKH7w1gf7Pof0Cf+ZnjArUbSmh2lsRcxAg
	 2mZY9FN1xXFdSOnccTvoYc/lY7xV5eskRg3dL3z6VKZEbAKGdI2kRm6H4fK5Vy/05L
	 YoKz1BokYVKRBqg49gso89R2qnF+9WeZzMIr1nmNEd1KgaF7fOV9+tp/0fGZLG5ocJ
	 TGrazGhVDyLJ8j26n0tKsFX+Ujz/E0JcJjspx72pqjPkzxmi8WYa1ccuMRurSu+0xR
	 3PeC6z+eX8+1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6BBE40B48;
	Fri, 24 Jul 2026 14:02:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF4A1DB4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1A4960B17
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mahvk3nwlj1v for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:34:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 765B260B07
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 765B260B07
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 765B260B07
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:28 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c160420289bso39388666b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889266; x=1785494066;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ynjfPNHtOPWGNzjzhDzttz1tpz+ujngomvZVrZr+i8Q=;
 b=EHqOr1rLoXRSIuFEyUQnef8my2H41x0SkJj0LG/ohdlcVvKwC4C8Ki+ijp6ZFdETZE
 KrfNyS9kQy1u4n04D7wCRP9wqpN5/uib+xyRSPlxwy3adI6vVCGG/FhrXOyc79OLBcrx
 R/zO7Ysdwg2ge6Vv7xbNLztCQDVNOmvVhh5hXmRoQ1QBje5+wIetmGHnvx4k0PHVGTwK
 SOvox0v/hHEhC9qu+dtL4DiYpiHcJtMh+Ce7ndZc6BzWVANTXCUkmpno2uYK4IMjPm24
 mPpvRXH49uqhVB/ShPUdNZxjAsjynwR6cD9Jz4nlF6l3nLoBLrbAXm6Of5FUiJsiPET+
 yBZw==
X-Gm-Message-State: AOJu0YwPWqo6LDGrWl94hwf1SkIX60rbrdfRQH2cswZwwxf+RC8vhLPk
 HXZnZSSJzxmjqMmrpC2IJ82VgADMLNn3eQrNkDoHR8h34mlimPo4/3/R/bvYvq/dqolv+WwJFee
 7S6CK9dI=
X-Gm-Gg: AR+sD12mUAKbQTqEuHbU4Yhe2R6pU/aeppOIxZWfyUMsd2KV23sOIsnBOVecmMKItbX
 D2XGiLNlFgFNJrfdAwuCwnus4KWSnYm84WgYN/eTntG4u8LwKSZZ8cvXbWTPHcM6ijf/KmsYIXH
 EPieNZqf4tacPSpbA+XDVPfdz0wOE8EoU4aCy5kdFpASHmVWlkX+ThLRG12CZKpircXf8HyJkx0
 tRoigECYPHWqSD+YJZEfcrJ6uhC3D/qcFoVsxCwjyP3AluAH7sgO4Pg/rdmK5vjUEZqIQ2kZoB7
 N++Bkh5OwPe7A31wj95X2HBF8gyMyyKWuvDP6CItxvequoG9xW4Maupggm48PCTbVsrJK1Mzmr/
 1EH9vWS+VO2RhCRWQpUHf7rirv2R54/5hxj+5lzOuOoz9Yad/NFwcnr3/DLGUsX5nGj4ieUY/vS
 3V8g4K84xEQyqDT741MV/dlqJQOluwBd7Z0MKWJm4efWj2gX3ZmEWM+qSOg5NhrpfPRVM=
X-Received: by 2002:a17:907:9615:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c1c50b8a704mr280188566b.18.1784889266277; 
 Fri, 24 Jul 2026 03:34:26 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0011f41ca2fcfee2bf.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:11f4:1ca2:fcfe:e2bf])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f345b1decsm2957563a12.4.2026.07.24.03.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:34:26 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Fri, 24 Jul 2026 12:34:14 +0200
Subject: [PATCH v2 1/2] tpm: bounds-check the device-controlled response length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-tpm-trunc-resp-v2-1-381857e959f6@byteray.co.uk>
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
In-Reply-To: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Che-Liang Chiou <clchiou@chromium.org>, 
 Dirk Eibach <dirk.eibach@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784889266; x=1785494066;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ynjfPNHtOPWGNzjzhDzttz1tpz+ujngomvZVrZr+i8Q=;
 b=LGXJbTGIxj5wZRNxCIoiXGCGoSdUS1IeEMUV9MqwOGfz392H29f3tVUUSYWHoBpo6i
 8RNVWhzvw2xxq8HV8iGY3b5WzKH5fgBWgzBsZi+yge/osDMAWUtIT7mWou+f/mDxQ7AQ
 d6liiNCg0HOY6vvZwoevklplffW96eHo0uO3jEoZOB4GhPkaiDcKzZvEd1G9NeLIVy0A
 6zw9sSXbBakgqgnIQVCou7/3ON2Gyfj3ZkG6ky+1CXwreCbDb4Mr7/8dxRFBbNVbLVyE
 5YGDL6w0/1zriOFZEWW5uPZJtKoeqKtwfh2UbcPGXvtfj/Zq1Pea58Igr9Kzyh1Jdwu7
 NGJQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LGXJbTGI
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
then use that length without checking it:

tpm2_get_capability() copies response_len - 15 bytes into the caller's
buffer. A reply shorter than 15 bytes underflows the subtraction into a
huge memcpy; a reply longer than the buffer (sized for prop_count
properties) overruns it.

tpm1_load_key2_oiap() and tpm1_get_pub_key_oiap() pass response_length
- 41 to verify_response_auth(), which a reply shorter than 41 bytes
underflows.

A TPM sits on a discrete SPI/I2C/LPC bus that is physically accessible, so
a reply this malformed is reachable by a bus interposer or a faulty part;
on the TPM2 path this parsing runs during measured boot.

Check the reported length against the header before the subtraction, and
against the caller's buffer before the GetCapability copy.

Fixes: 69cd8f0681f4 ("tpm: add TPM2_GetCapability command support")
Fixes: be6c1529c1ce ("tpm: add AUTH1 cmds for LoadKey2 and GetPubKey")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 lib/tpm-v1.c | 6 ++++++
 lib/tpm-v2.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
index a6727c575fd..5fd22924b28 100644
--- a/lib/tpm-v1.c
+++ b/lib/tpm-v1.c
@@ -757,6 +757,9 @@ u32 tpm1_load_key2_oiap(struct udevice *dev, u32 parent_handle, const void *key,
 		return err;
 	}
 
+	if (response_length < TPM_RESPONSE_AUTH_LENGTH)
+		return TPM_LIB_ERROR;
+
 	err = verify_response_auth(0x00000041, response,
 				   response_length - TPM_RESPONSE_AUTH_LENGTH,
 				   4, &oiap_session,
@@ -817,6 +820,9 @@ u32 tpm1_get_pub_key_oiap(struct udevice *dev, u32 key_handle,
 			oiap_session.valid = 0;
 		return err;
 	}
+	if (response_length < TPM_RESPONSE_AUTH_LENGTH)
+		return TPM_LIB_ERROR;
+
 	err = verify_response_auth(0x00000021, response,
 				   response_length - TPM_RESPONSE_AUTH_LENGTH,
 				   0, &oiap_session,
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index f443b738f82..aa4d3866d7b 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -519,6 +519,14 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
 	 */
 	properties_off = sizeof(u16) + sizeof(u32) + sizeof(u32) +
 			 sizeof(u8) + sizeof(u32);
+	if (response_len < properties_off)
+		return TPM_LIB_ERROR;
+
+	if (capability == TPM2_CAP_TPM_PROPERTIES &&
+	    response_len - properties_off >
+	    sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property))
+		return TPM_LIB_ERROR;
+
 	memcpy(buf, &response[properties_off], response_len - properties_off);
 
 	return 0;

-- 
2.43.0

