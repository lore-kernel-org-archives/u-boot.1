Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980D8C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF22A887C2;
	Fri, 31 May 2024 15:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w0lWhrby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272BC8878B; Fri, 31 May 2024 15:50:52 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297FB882B8
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e95a1d5ee2so37445331fa.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163449; x=1717768249; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mTiLq4D9w02Ubiegl8WaAhqf5gqlLgN++TAyAUTr66s=;
 b=w0lWhrbyKJgNG51zMZWfVmqIJ3QEMn5F5srVbQenNYTpvAmrROPDV79XcYFnPgrx3i
 Vi1pjorkL+4UScNrat4BwV56YHZ13ycEUlSjXonm+JEYhwwPHANlZAaKrgmpDk3OOim0
 RQxEh8mdNFLTxU4fyvYo8gWVjQHXW3x/uyjqqnZoqLWzfhbbIWDieRIf1qkJZhM2F0vi
 mEUfkag965J7B+qOs28ie26HiY9YUKXgrHtX2XL4/X/Wz+zVarl+Kp3GBPGyPZry9tl+
 NlyOlPt+k3I3ZwRopN7Ozu5t+WCkP/zElccqLx4mskWTj9ExW0yr/LKjnATmAsK5ekYm
 F5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163449; x=1717768249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTiLq4D9w02Ubiegl8WaAhqf5gqlLgN++TAyAUTr66s=;
 b=U2IjKnjsYgXXh6Cn0fgJwwyoor3bGkcY75KsoIFfgGjgInQvj6Llq4CM0JAoMNr0eO
 agA7rx7xvthXlijP9hcB/SJw6efI/Z5PrObBH2xEt/d/hNHofR8E1JB2pdRD5fMtUSxg
 sTWcR58biI7Zlw4X4vi9jT9y7Nq9Md1MfeNF2TNbiIOaMa0ASfyp43bflXYZAqqOyxxk
 QV0bHXDzCMX+v+WZH6LtozhNvI4FLERAKeqcNtO43BSd7Dk5n0Zs+k+DPPU+J3rIcqTM
 ycI4pQn5kfUCSQzcqbt8i2NM1wiHXxBx3sqHPGJdfY1JU0fb5Q8VTHL5oajmIA7FwwfF
 aKBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVojPhQ5+yzfgslaNcZprim90uA0XiTephztDyJbN1/6aFgaUGErP/o10bXmoNJlvO+i16VRAJ2zxBA3ENipcgZaWFJ/w==
X-Gm-Message-State: AOJu0YwulwNVc+EKeci3OYPGsOjmvAeK7X5N2OKlXCJQRtgbPQGHThOv
 TAPXIwC1n/qrFF1yqmp/+JDr+noqYtGu+uQjqnjc64yPwrGClzPVurVkwBAg1DY=
X-Google-Smtp-Source: AGHT+IEpRlcNfHndN6vRRgg/A7pgNFo97uy61wdvZMg8C7jocAOz9GZhbwAkqAlzWhEPT//uhTiBqQ==
X-Received: by 2002:a05:651c:2112:b0:2ea:7dc3:bdc with SMTP id
 38308e7fff4ca-2ea951ddecfmr21055771fa.40.1717163449422; 
 Fri, 31 May 2024 06:50:49 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab84a99sm89442866b.143.2024.05.31.06.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:50:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 31 May 2024 15:50:37 +0200
Subject: [PATCH v3 3/7] doc: uefi: document dynamic UUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-b4-dynamic-uuid-v3-3-ca4a4865db00@linaro.org>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2358;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=aM8qt0vJ1DRPyAhuqT6v0n4vqhUxMhwVttmyUp/d080=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmWdWzWd+yeJEcysyW0xUyGdDwZpXjrHXayC/MH
 tEOzjvGkOaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlnVswAKCRAFgzErGV9k
 tskhEACKevaI0X1GAwIrrkbxJMIlgT2B0UIdP6Ns27yPATNnJmmi79SNZOXjPFJLp3Rla0ZyYvK
 RvoM22UHLsS+Vomp72sYapg8tKa1gPlbRuFmz6HxN9581Zw4KRJmKAoi2GDIkHRmiOuzH7LZoUj
 ZMkX01r5K4rTzHUwBauB5XYqNnXcxFGh1PEgD+d4j3t5IrNlchx9UkOQLv7ybhow+U9g72glVqJ
 YjBeh3VQ62Nc0Q55NVEcO/3CoMEHCZcnKWhBSSfDA2Fbp7rvmyKsVU3Xf9UzLsMUF/WLB8EZI7E
 eJes58dDrusU/ENvcQzYHzFmsZ8ystYa8cN0EP5wtVz2UjGoIqz2mcH3Ag+NAijfBYhv//gRapU
 0YzidWVmGcumBQ6SOicBRKmngvZ/NZ84XOZWb11azJ36NtgHBRf0eh4QhfxbELHAs4M5fyVKUv6
 n4HyItaVPXbPTbiyTC+Z0l4qAxqXRouuqSbj/vpKh84hRqIbsbn6oYSM+4v/0DuVyMtZBM3RM48
 sx5T2fISxF9X/cnOy8Uj7pSjo8IaebjmUjDsySPAZcHhGdfZfneO50mppz0iPJLci3VvNxLTtbg
 Rkh5UPoZiV6025+6p3rZSqEso/HpA76pn1oqX10V5iJIvEbFVIhmpPV+oAg1XZwQIcdIEN/zgCn
 euhuR3YHVWrwvag==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Document how platforms can generate GUIDs at runtime rather than
maintaining a list of UUIDs per-board.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/develop/uefi/uefi.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0389b269c01b..0b60702c052a 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -448,8 +448,39 @@ the location of the firmware updates is not a very secure
 practice. Getting this information from the firmware itself is more
 secure, assuming the firmware has been verified by a previous stage
 boot loader.
 
+The image_type_id contains a GUID value which is specific to the image
+and board being updated, that is to say it should uniquely identify the
+board model (and revision if relevant) and image pair. Traditionally,
+these GUIDs are generated manually and hardcoded on a per-board basis,
+however this scheme makes it difficult to scale up to support many
+boards.
+
+To address this, v5 GUIDs can be used to generate board-specific GUIDs
+at runtime, based on a set of persistent identifiable information:
+
+.. code-block:: c
+
+	/**
+	* efi_capsule_update_info_gen_ids - generate GUIDs for the images
+	*
+	* Generate the image_type_id for each image in the update_info.images array
+	* using the model and compatible strings from the device tree and a salt
+	* UUID defined at build time.
+	*
+	* Returns:		status code
+	*/
+	static efi_status_t efi_capsule_update_info_gen_ids(void);
+
+These strings are combined with the fw_image name to generate GUIDs for
+each image. Support for dynamic UUIDs can be enabled by turning on
+CONFIG_EFI_CAPSULE_DYNAMIC_UUIDS, generating a new namespace UUID and
+setting CONFIG_EFI_CAPSULE_NAMESPACE_UUID to it.
+
+The genguid tool can be used to determine the GUIDs for a particular board
+and image. It can be found in the tools directory.
+
 The firmware images structure defines the GUID values, image index
 values and the name of the images that are to be updated through
 the capsule update feature. These values are to be defined as part of
 an array. These GUID values would be used by the Firmware Management

-- 
2.45.0

