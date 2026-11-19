Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3E606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BNvpgzQS;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gCTTna8t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9ABC940E38;
	Thu, 19 Nov 2026 23:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pthdTycaIn_Z; Thu, 19 Nov 2026 23:33:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5E0840E2E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795131228;
	b=e4ZmT0xqCEyZRRy7QNeBpFq5c7bM0Gm65feoloBjCcU/1FZpXXpNz8RfCTaoLUGgXWRY
	 W2lS/G0JMBw9oh5IyWHCsuTMyA8ZA/MGv9O1f5uo0BX1sS/bTBCtAz79sdOySP7icvSM1
	 ILpglH81jIy0Pz/7BKpuhBBrM/ewoofoBPr0Rp62LXE9g9/WH4WZ/EaQpqa15hfFLLiaM
	 L+TnZ4DxkWXjpLZsTVBf498jF6IdSVB2g0362hb3sl3rxXVlqnZYRd1C+EBI245spLjSC
	 3bCpQwwvp/QecAqPZ1AmB0UMsP7O9XNaN7N4EpKuv9hj0Mmwqu+LVQs+Kux7Qg2Irpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795131228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=roKH5a5UyAKhSXHeYYa3AZLrIuwMDZP3YSqibdnHolI=;
	b=s7sWThLcg+v7KlR8WslV7eILIAinTv5EVckPuaqH4kbtQVK9O4psO1d9A3Al9EJlNvyG
	 z/9GJ3gre6NeMfrB2vWfqttUduF8pdrlS/Ovf0jbu8GL78sEFXV592sKmVOv/HyT8arJC
	 be5fef030myAeCKIizSI9Aom9UjCokvKX3aUg98b5bfy3/S38SuCOPBx3I2lv8j7MDh3P
	 DzMs3Y6zomN031TMWH4SOKZ07sz7R62di4ZEL3bVGn9Oj6olhgkul2ohzH4CSyf6K0g2n
	 ocqZlG9aIzmBAK/2uKQYaftn8TaBXiHVLLQXKlmrtj1GYhw/UDFoGe69FyNV4ipQ2Vg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795131227;
	bh=roKH5a5UyAKhSXHeYYa3AZLrIuwMDZP3YSqibdnHolI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BNvpgzQSWyKXaOOKrM2b77N/OX8OdHzjgV9+ximIUAdsQXRYs/WXWeGfNgRO4bYGA
	 GEL7a/pJ+MNE4PO0rR43H8hJQa35OOj+D3OqEZTMLFfRXhbf5eruHW8CuV7IjeMJFq
	 cXWbna2pOql3TV7MFp7DOx1YIDCy/jalqAoU5S7BobH+CyY0u9MeLKssUNEPCDlEa6
	 gv+3dy44bjYu7zJOBdcY0hIDfPiDcFFBFKxmlflT64CTZxs/csBpZAmbUC4XXO9aSU
	 r2TSxQ5ma3QEpA2ixLJ6wB18miJZQZiq6t8BOlW9Ck3g1X9zIvyhnkQtMqs/lE0rrp
	 jEM2abA6Gmf5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5E0840E2E;
	Thu, 19 Nov 2026 23:33:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F01A79D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80A3560E44
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fd2b9wVk-665 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 23:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8DFF60D98
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gCTTna8t
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8DFF60D98
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:39 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-86103aaac12so909976a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795131218; x=1795736018;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=roKH5a5UyAKhSXHeYYa3AZLrIuwMDZP3YSqibdnHolI=;
 b=gCTTna8tVNKY8mhq0ZmG9v6YeuUkxB98ahnLVgViESEMnDIh5uE85pvfs6tjCi6N5K
 Vp3Qnkjsa8twOsvy7ZMQgc5htkW1LTnn1R8buxD+hmaaLU8iADlDoaVoMlZucQmixi80
 m7vD68RkJl4Tn11WpK2sgOdTCXhPifsN9CxZ4UR6vur5KueQxmSgBVDvQB0SOliFGnTW
 9/5BgdHUfMoJV25ZM5/VKo0x7qG0POxmrZJgGNVfj/U0mmuN/e9UrUQwqYI41muC7RRo
 8ABoBptAauU4YugeOiuyf7uMbiAe824uNvFbmH5nHzGPzWKlDsvj9+ZBPetprMnwp0QJ
 xVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131218; x=1795736018;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=roKH5a5UyAKhSXHeYYa3AZLrIuwMDZP3YSqibdnHolI=;
 b=QZTL1wzoXD49TuhroeF3XczsdfEg91Si7jCgxPf7xReCSTpIsWVBR+ra9N8YZg6tjJ
 ySpOCzbHwMCdqjZfIOJ263OdC+c8VbDdu53uAPSL3V4ee6V8czEiCBPgKNx6ypXi2jaF
 37d/jf04U090vv2Ee+jA00DcnaIrPfl/gcKd1A86g8Em17wjbwpOeVykXZEj/ZYe6vn2
 R/6U+b/m98DIEGq122PhQ9pGjX2yglJ6QADxZYqgWMvVaJrFrI4b3NxmwWsIK8vHL3im
 KmimlwxG6lMo7scEaDo8D4pH/jmRC2r84C57AO+1OB+90n/1L9lHjuFC8My3ICkqKY5y
 solg==
X-Forwarded-Encrypted: i=1;
 AL+hErHZGdUMy7yLSas0sZiBxRtXEe2QFZrUb/O8vYWStQugDqprdLl6Km5FW0VoJc0IwPQOgHqbnSc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+y8MGWxW7Tm+1BOVFN28MpP/DWNgSBPbIAMnT6lxtbb0zEIjDG
 IRZrr95zeRVj08EGWRuuWMHKHmpWW2kYfFpp7hlsmq+inQvVKsfbClM+W1Ogg0jk/Rs=
X-Gm-Gg: AYBFou0BMcJ5XM9/A9sZ1/u73Rg4PMEklk7TbeWtVI+SNmn/fC9x5FXREVN9b07Juai
 C+4MuG+lKR98bPWyitr9XiZlfR5icZhHA5qrB3VC3PRN3mGYtrva2a6VIUKJQ4Sypum1zMvfAEs
 xUDWL0I2j8YhpvP+p3q2Z9RgQg4JJEuVAtQKgcOQwTnHSHy1yX2jd18ZGCfQXNe7OBTWJJsHlZd
 hYI4uLGRYCikORKKWD23eitqfJkwVKYMou4GHaiBniSKZyKG7y06o64lwyOiqfrP+N4ENkSclqq
 eot+wWUwGTf84oSV0k8sEzHf+W5W1XbcmafS4DLv14H0YNlgDVoUBmbCbGwK+0VZ71ShDjBZqiD
 adlkVVgyfLgWH4Wc3Ocu0OE0N6fLYLaEYVBwdiQ1n36hGyQW8d7tYvluwaw0lHg3668P5K+z7io
 vuE9yFMKA7al911QOJ5MJ5kJWcjHA5PFrbPqoLelZIhBBCqqswOBDsLpz0Eoeo3jxMh+X8MYvEO
 Vt7mjrWcSHs9D3DbUULOGgip2pKMoIONUYkB7Uz2j43VpeyX8akJCax5ciDynPvavYrsVt6PrlS
 Xhwni3mxWIansxxUK2OSQtLsw2gHkyC0eF9kFYYGaRKHsPIr1OD6p5A=
X-Received: by 2002:a05:6808:16a4:b0:540:8ca:36e3 with SMTP id
 5614622812f47-5797c1b5467mr2268296b6e.19.1795131218122; 
 Thu, 19 Nov 2026 15:33:38 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm813561b6e.3.2026.11.19.15.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 15:33:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/4 RESEND] binman: Add functional test for pre-load
 HSM signing
From: David Lechner <dlechner@baylibre.com>
To: yan wang <yan.wang@softathome.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261117095322.16813-5-yan.wang@softathome.com>
References: <20261117095322.16813-1-yan.wang@softathome.com>
 <20261117095322.16813-5-yan.wang@softathome.com>
Date: Thu, 19 Nov 2026 17:32:57 -0600
Message-Id: <179513117714.2216103.5003226155603382774.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pWsNUrYnMMW1rQ3Oxj+/UNMDC7WglqoshdzlsxjxHCw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/4dBjHVd7YQsTNG0O2KYr+5cFzvjJX8zE7jhY
 OFFlXe7MLSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav+HQRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AlKUH/Rb7WRQ3M4d7VMcrDfMEb2QZBHqq1LvKVLVB6P4
 SEIB9/NCQDkgTXa8wJ1obj4oBa8JKgdz+871U+c3H86FLP+ng4Iwix+AFXdy9PeI8ky/GSVVZCZ
 xaNF2z3H4FGSEndIKJ+Hx2M6edwQYZo8xOUh73PsE0mIWvn1IKK/lxVbJjDgTaZRdAnsg6LLIVS
 +vlUj0VhXwe5RqJecYCAYvb3kA0OgFP7m6CzxtT3+w3HMilu91yUfmCqULmfhYdlAe9tMJ9obHJ
 0FnyB2j2gpUCaqlAIYPb2ATeX5BMGeJVZJmje6HR40yen2FgHHchf8WHV3/YRzOWmqASOWIcEFi
 x5ac=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add end-to-end functional test for HSM-based signing of pre-load
> headers. The test verifies that binman can use PKCS#11 libraries
> to sign data via hardware security modules and can generate pre-load
> headers with HSM signatures.

I see mocks in some of the tests, so that tells me we might not actually be
doing full end-to-end testing in all cases. Is it possible to write the tests
without the mocks?

And I think we might need to add opensc to the CI Docker image so that the
tests actually run on CI.

> 
> The tests create a SoftHSM v2 token, generate RSA and ECDSA key pairs
> on it with pkcs11-tool, and verify the resulting pre-load header
> signatures. RSA signatures are checked with preload_check_sign; ECDSA
> signatures are checked with Cryptodome because preload_check_sign needs
> the private key.
> 
> - Add _MakePreLoadHsmToken() to set up the SoftHSM configuration from
>   fit/softhsm2.conf, locate the library through p11-kit, initialise the
>   token, generate a key pair and export the public key in DER format.
> - Add testPreLoadHsmSign, which generates an RSA-2048 key pair and checks
>   the header, for both pkcs-1.5 and PSS padding, with preload_check_sign
>   using the public key exported from the token
> - Add testPreLoadHsmEcdsaSign, which generates an ECDSA key pair and
>   verifies the signatures with Cryptodome, since preload_check_sign needs
>   the private key for ECDSA, which an HSM never exposes
> - Add testPreLoadHsmModulePath to check that module-path= in the URI sets
>   the library.
> - Add _GetPreLoadHsmPins() to collect the PIN passed to each sign() call.
> - Add PIN tests that check the PIN source order: the pin entry arg, the
>   environment variable, the entry arg taking precedence over the
>   environment variable, no PIN at all, and a PIN in the device tree
>   being ignored.
> - Add testPreLoadHsmBadSignatureLength to check that a signature of the
>   wrong length is rejected.
> 
> Error-path tests, which do not need SoftHSM, cover an invalid padding
> scheme, an unsupported hash, an unsupported signature algorithm, an
> invalid PKCS#11 URI, a missing pkcs11-tool and a signing failure
> reported by pkcs11-tool.

Please add SoftHSM cases for serial=, slot-id= and id=. They would have
caught the two URI mapping bugs in patch 2.


> diff --git a/tools/binman/test/security/pre_load_hsm.dts b/tools/binman/test/security/pre_load_hsm.dts
> new file mode 100644
> index 00000000000..5671559c838
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_hsm.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+

nit: GPL-2.0+ form is deprecated use GPL-2.0-or-later instead.

-- 
David Lechner <dlechner@baylibre.com>
