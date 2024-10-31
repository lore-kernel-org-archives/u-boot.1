Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4626DE68960
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 09:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9820C89241;
	Thu, 31 Oct 2024 10:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rk0bOQkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5BD891E2; Thu, 31 Oct 2024 10:15:41 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBCC989241
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53a0c160b94so725681e87.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730366138; x=1730970938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xCZnS4V6uNX47ckEmjyp0Gj9GyTNhhM+2i46PhXaVrw=;
 b=Rk0bOQkdItmdxDRnUvwmYuaVHRAFL28Oi0SKTCquwq3JXYVC0ytk3bcXIKCw62xPSB
 SIYxGA1H5eyxVdV1wJF5ezynpmKJs5Jw9kp1pGURkmvQ6VL3yPXNXiSex7o3NT79T+et
 YEmiDRBUB25siexwIxYLM6cb3FFZ2Vcfk/oJYLmZPsIbn5FrPa0DjJNIh20MC/+9uEkR
 Mq6bxtmGQjAWnJcKZbhGGlIUVEzrXSiCgGKoj1c0IAaurPGwjfNuX+5s2kyW1g6+WIR8
 olFWDmNVaz5caM2kkUsbZ7YeE2r7OKu4QuXG20464ee7wgRyJTycurGx4MFJnXfq5U/G
 eUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730366138; x=1730970938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xCZnS4V6uNX47ckEmjyp0Gj9GyTNhhM+2i46PhXaVrw=;
 b=G/8887PK7fUtjL/R67XBm2g5kjdTIOqvpdbioo+V7EHFAevTQevWyJwf0yYEyhH2cy
 ITr6R3ld2hVwzZvxabd1d3L6lxcv9UrUpD56a/euI6ezm2wpWFWj9M0FnMSIJw59AG6Y
 iRFr42c5TAfOd0yMEdajPe9Ke/8cu4uLPKsb56XYMXFhgakTHS51z5m8KoC135yt9luG
 TUi3LLJ5SrBQXDGFr3dxA+/rqLxQ2NlsD9LbC3ErZdEgn3oH96EOwLSdnCHblT+RTTjR
 154CHzc81EWoiHiIQUXkfZZ4ByHKmyWUUE0wbabLWeL+9MQLhMq8t2/0ypMIokRimZkE
 09Eg==
X-Gm-Message-State: AOJu0YwYlq8ivshI0lgjERws9CJg4JArxatIvaInXTkjVQPSwC2cJYBr
 3ahEyRF7B1KZCppD1mGq8qGno1OfJsvsPnoC9HWeop4qxkwV/0iLMf/4Fd0wlYo=
X-Google-Smtp-Source: AGHT+IEk3OGeTABOxAGhhIY1jy/Rk3OsNpoCbFD4yjd84wV4JlsYhWBKhzIsQJ/tlEUNbXeDckiARQ==
X-Received: by 2002:a05:6512:3094:b0:52e:98f6:c21f with SMTP id
 2adb3069b0e04-53b348ceb28mr9488997e87.16.1730366138151; 
 Thu, 31 Oct 2024 02:15:38 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:2f09:ca73:75d0:e7d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7a9esm1520809f8f.21.2024.10.31.02.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 02:15:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@linaro.org>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, csokas.bence@prolan.hu,
 Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] lib: rsa: Set conventional salt length RSA-PSS parameter
Date: Thu, 31 Oct 2024 10:15:31 +0100
Message-Id: <20241031091531.761977-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
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

RFC 3447 says that Typical salt length are either 0 or the length
of the output of the digest algorithm, RFC 4055 also recommends
hash value length as the salt length. Moreover, By convention,
most of the signing infrastructures/libraries use the length of
the digest algorithm (such as google cloud kms:
                      https://cloud.google.com/kms/docs/algorithms).

If the salt-length parameter is not set, openssl default to the
maximum allowed value, which is a openssl 'specificity', so this
works well for local signing, but restricts compatibility with
other engines (e.g pkcs11/libkmsp11):

```
returning 0x71 from C_SignInit due to status INVALID_ARGUMENT:
    at rsassa_pss.cc:53: expected salt length for key XX is 32,
    but 478 was supplied in the parameters
Could not obtain signature: error:41000070:PKCS#11 module::Mechanism invalid
```

To improve compatibility, we set the default RSA-PSS salt-length
value to the conventional one. A further improvement could consist
in making it configurable as signature FIT node attribute.

rfc3447: https://datatracker.ietf.org/doc/html/rfc3447
rfc4055: https://datatracker.ietf.org/doc/html/rfc4055

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 lib/rsa/rsa-sign.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 2304030e32..fa9e143b4c 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -428,6 +428,15 @@ static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 			ret = rsa_err("Signer padding setup failed");
 			goto err_sign;
 		}
+
+		/* Per RFC 3447 (and convention) the Typical salt length is the
+		 * length of the output of the digest algorithm.
+		 */
+		if (EVP_PKEY_CTX_set_rsa_pss_saltlen(ckey,
+						     checksum_algo->checksum_len) <= 0) {
+			ret = rsa_err("Signer salt length setup failed");
+			goto err_sign;
+		}
 	}
 
 	for (i = 0; i < region_count; i++) {
-- 
2.34.1

