Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1E0C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C02E940A4E;
	Thu, 23 Jul 2026 15:14:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXk6Jz-elrzw; Thu, 23 Jul 2026 15:14:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBD4D40A1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819656;
	bh=RSNffKoPcOnEwkuwfNgJzBzWttN4BC+92EEYHVDtM8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LEUMwBFb9NNl9aRMAR6svPetndZlgo2UBK0VxAGAnN2CCFzKTTTRL0iwI0ualTenb
	 5iviGooypTf04K7Dv2JIXc0Dg2zcnA95Gx0E06rYIKWHGwq8/JORfz78uxmzhX+9zH
	 B/RI4wXgGU9jd9M+4i7WKt9nZ5yRpavaAas34ozcPQBChxz7heG8TNDH+0eRUMjev3
	 bdtPIwkoeunuWdklTk7U0j56hVqZF7nPYqrijc8q0A4qT+jUJ3m3aIL2xffSzJ61RR
	 r7/UOEqnQ+kVDIVQjTG+oCxNJg24BgxotWIpgoW2NpyK+cN03DBB5Ace6P67A4Z3sP
	 PT097HuMPT53Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBD4D40A1A;
	Thu, 23 Jul 2026 15:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2E7642A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9881B403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7j7q53h_oNzs for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:01:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 657F5403DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 657F5403DE
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 657F5403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:45 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69f7130b47dso1175516a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815303; x=1785420103;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RSNffKoPcOnEwkuwfNgJzBzWttN4BC+92EEYHVDtM8M=;
 b=fhDjH9+TiZEFsslzHSl06QsKVOUfuFV0bcf4KXrF4gpCvLPlBRlKdrJLfR83LH3NWs
 SeHGQYTWx47uVy7Ln7r5VaobjpRBc4Y48PEeEyGYEX4wgXthSxD+q58Hm33SaffWuR20
 b4WbgHkZVwcYnRg0j5ptSmRu/56DoSR1ahuGtDiT2nVIC0XugpqFvJbKW5ZYIlVBnldx
 x3vnbYys5vFx3fCuCszXdDIIbAuCStf4ZqZnUcRsittmnqFbEZ4oHkuSKbRHAPoXEycg
 n8QNRGC4mhi7TOJDl9dCEXMsUd42DYE4IQdD+o9rYwhcdsjDC6UuEdLSc77LBrwv4HCj
 6Wyw==
X-Gm-Message-State: AOJu0YwQXnjUuXH9YZT7sl3seBDThKa5hipEADtTzCgx/hWE6jXsmm/m
 wJyH7S6P8SB+Zzp6d1K9+rNHkCQKBwQ7fq/yZXm9iBzXRPw+UcxmNYbhpQ4Pvw6recHrW1HmcP5
 I9YY9d9Q=
X-Gm-Gg: AR+sD13wbCrukXlyAJ2bawCx1brTP42l6PHiyvrp2NaeFhDgPaC9PvwvMpDhfzjgN2z
 3XLDtM+6mGfbc/C7aG83tBYvvay1e38r7BBm4UNC3qn1X/VOWLO9pL+sdvUqobHM0YeQQnm8Vna
 0u9PFEEAuEq8Cr9mlg7+xg7F7DtS7ZL1X4ijRFmdnmruT5ZysxwI/ByNSi2haDQo16Ql0oAepfT
 qTvTHjDN3zkPl0pmZAwOOpspdK8VThjs4ErecRz+xYh5vZvMN9Av/WC3PgeGjXPX33vsOixHGYJ
 ppBWHTKGY3s/tg55GGcwh2miJoplOUkoR23F44Q8OC8gEVzN6z6flIgvyf1ry4L+nVD0stngkkI
 6R4/Z+dT+2NSGeBKI7sduH3W2yflasj9NfmPx90jAN0O/AEMwY/mLOKrHZ0CakWAId6AJn32aHo
 uograajlUF+3j6biPzMs15Knr2ydQ3Sy2ObapFTsG6LwXoi1a3GAXEPnd6A6twOOcofTfoFUU0o
 lx0HA==
X-Received: by 2002:a05:6402:4542:b0:695:822c:1083 with SMTP id
 4fb4d7f45d1cf-69f6c70e45cmr1140263a12.28.1784815302850; 
 Thu, 23 Jul 2026 07:01:42 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0099e3f3dc2d051096.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:99e3:f3dc:2d05:1096])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f345b1decsm2137178a12.4.2026.07.23.07.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:01:42 -0700 (PDT)
From: shj <shahriyar@byteray.co.uk>
Date: Thu, 23 Jul 2026 16:01:28 +0200
Subject: [PATCH 1/2] tpm: bounds-check the device-controlled response
 length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-tpm-trunc-resp-v1-1-72a54ac30f4f@byteray.co.uk>
References: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk>
In-Reply-To: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Andy Fleming <afleming@freescale.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Che-Liang Chiou <clchiou@chromium.org>, 
 Dirk Eibach <dirk.eibach@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784815303; x=1785420103;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RSNffKoPcOnEwkuwfNgJzBzWttN4BC+92EEYHVDtM8M=;
 b=cL9pJYfnzpB/4g18aRGN5St/f+hVo8ZS2M1USTi/C1b3C9oOUfNZ/X8JLRYAazKc5R
 480ojwoVntSP8qyXeboVHL6cw+MAm3Sgp3+++0GgahZ8VT7N0XygZZ+06tp1bf2rePrP
 YfLmOwANb19A7DGkSpyyr2Aq0KzYk7883lPdIORDBJx9qv+kW0JYU/2GmrowilhKLbsc
 UnIIOgVV3l1+oTul9kUgDXKvyBXP2no0i36PxynggxzXiIznlVZfNWUUeWlVI7fWQd9b
 weso3gmxyfcm8C91a8vxNnit4yOlgqnKPj839F0GASP5d5XnIWdRbVD5hLzEMPwyNnan
 +PzA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=cL9pJYfn
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
Signed-off-by: shj <shahriyar@byteray.co.uk>
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

