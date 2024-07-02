Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20659C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C6788725;
	Tue,  2 Jul 2024 15:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zAt6faOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4948871B; Tue,  2 Jul 2024 15:30:51 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70673886FD
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d044aa5beso1911847a12.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927049; x=1720531849; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gN9DoT9GCRFkCrGOvTijcwQaySiqv9geeCMsx1qW1o8=;
 b=zAt6faOZJtkqr1x3jiwk2H5nBQ4voCVBq5wWjDGE6gpDg46vPPK245n9USdqOXPJQ4
 nqg1LBqoP8p45F5oJM+pBmrVHRmY6AwYdGw/j4YEjaP6nW8/YGZ3UOzRL9BdNSQHs55q
 mJBm0sFNnwDWtGFZ3fbYdEXmPUg7JJLXO0GEMdLnTaOxEDjsR68tU5X+wc4+HB1r1vyn
 7yju9fvUTngTr2eVsQv57usJBpyEyyqkEu6OqMNnnBz1nRcfihW8iaCyM/N9PSqan+/L
 hnnQj1JoGXxU6svgWcko5GRv/RQ+uwdqhgDLxMo6I0pNwVGYjwUEV6hsvaJTOrqUYOye
 9uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927049; x=1720531849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gN9DoT9GCRFkCrGOvTijcwQaySiqv9geeCMsx1qW1o8=;
 b=eV/qLDstqOz24wDQPLL/NWJ02dN9frRbe1SfVpuU9tIScWQdoF5wLtwbmUMFpKZyDM
 zs2alF06iIRYSf04wl25e1I/WKU82MmOWKs/TOHX+G+uTx3w2szaD4ujXc6GHjp5K/tO
 q10L+nj4mjplCCCqlcFlFq75dT1NG6YWTMrX09/HeHohlqAS2eS0U97kH8D+K/oc0iYx
 D7Xzi8WS2DV2FkXArEITSBNnsLTn4ZGIUwEQxp8kmV495DM4RcSVMSfhq3bmcLLIIG0j
 bdjUuD8gjXWgERzcQtl7u1cfTYpvTQ5xzY3fkIuFmJhVWdewVmce+z935ivKquK6uFA4
 EBxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl1yzTC2OG6kK0/t7wjcK2H3itMSrMLfGDu7EK53p5y/+fOX9jJR0HKbUWwY7P0YCSapsE75nPds+OEih60rleJ1Rsug==
X-Gm-Message-State: AOJu0Ywy+ioYDy8qNbitkbWJJUw8E6RV8SvJjM0rMftHjPpWqRKe63lH
 20G/4cNXCUhg6KuyoG3x29RCsLv0heQWntnXMCXhWd6LRbjOA0+/LH1b5PM1Wcw=
X-Google-Smtp-Source: AGHT+IHW0/SYzepDZ7m5RgkeCtkGB+6KqoJvZtL9Yh3grJm3yzhGKM5EHRrZ38KM0b8XlOpVuCPmeA==
X-Received: by 2002:a17:907:2cc2:b0:a72:6055:788d with SMTP id
 a640c23a62f3a-a7514452aefmr748210466b.42.1719927048934; 
 Tue, 02 Jul 2024 06:30:48 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:44 +0200
Subject: [PATCH v4 04/10] doc: uefi: document dynamic UUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-4-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=m34fpCQOsOSaLRHycWoKBc/ZZ93pL9gtpyIdV2TquYQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAECT1RAowug9C52VpkfQkHu1DFOR0rHrmw2u
 RraUGpc/dGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAgAKCRAFgzErGV9k
 th0cD/9xp++wB5kS9msm+4bo2cy5M/mR9G7EBnNxbhZ4QGBiZDnjtJna7w/t3rL1p0DkYT0ftHR
 gLkUUKsQcZ79oxkPicCxDLmAo+jaR3pmYp2Xkjq0rtW9MWkpWvnUViwJq4jKvCGsEnRdVmVwlqD
 3NKVsdgPXUgSvrsPvP5AgZfukfK0QkcXPRDmsIbaw6fp7+xmNFHN0ViRRdmFtvq2gqlbAWHhvXK
 VOPV25SJRUYgjWw1/Z4D2Sp5QC5YBUmCsJvLZzKx4H4MnRw1ZIC4XHHwMfkNL+sDVx6R5dSnwMf
 Tewgty59cDXY1U4lZ0U+DooSB1JUGszbJc52/OhsqLbBuOcRGOxJBQSVad5JyBywGIHkaD6F9cd
 Vi5lAVWvwrpm76cIvbKUYHh18vgwj+VI0V0NUmD1PHdPRX7BY1ifFlD+IDGLgly32S843Vr5Qs+
 t0qUOAw4qz+7IwVs128RObH3aaaT6cI8dRQYYZWfHvQat1a3Blw/zsNSWHwJ9BWJLUHO4dHUT8A
 0dC9GVcOjWB1Q71DPJSjaVXZSgqZoJ25BxNRXgDwaq8LwBKUdpET0tWDozFrrFZJEQlzaBEns8p
 Na2ztvbAMfzsYC0UDYa+j3k4uoKhsloK/Z/rH9bd4erZnyncaoiOTZrJUrzPD5o6IuNz+Va7Xut
 RfWML+Fn9kXBr7g==
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
 doc/develop/uefi/uefi.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0389b269c01b..19931af9ced7 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -448,8 +448,35 @@ the location of the firmware updates is not a very secure
 practice. Getting this information from the firmware itself is more
 secure, assuming the firmware has been verified by a previous stage
 boot loader.
 
+Dynamic FWU GUIDs
+*****************
+
+The image_type_id contains a GUID value which is specific to the image
+and board being updated, that is to say it should uniquely identify the
+board model (and revision if relevant) and image pair. Traditionally,
+these GUIDs are generated manually and hardcoded on a per-board basis,
+however this scheme makes it difficult to scale up to support many
+boards.
+
+To address this, v5 GUIDs can be used to generate board-specific GUIDs
+at runtime, based on the board's devicetree root compatible 
+(e.g. "qcom,qrb5165-rb5").
+
+These strings are combined with the fw_image name to generate GUIDs for
+each image. Support for dynamic UUIDs can be enabled by generating a new
+namespace UUID and setting EFI_CAPSULE_NAMESPACE_GUID to it. Dynamic GUID
+generation is only enabled if the image_type_id property is unset for your
+firmware images, this is to avoid breaking existing boards with hardcoded
+GUIDs.
+
+The mkeficapsule tool can be used to determine the GUIDs for a particular
+board and image. It can be found in the tools directory.
+
+Firmware update images
+**********************
+
 The firmware images structure defines the GUID values, image index
 values and the name of the images that are to be updated through
 the capsule update feature. These values are to be defined as part of
 an array. These GUID values would be used by the Firmware Management

-- 
2.45.2

