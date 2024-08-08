Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B44C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072B788BC9;
	Thu,  8 Aug 2024 18:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AwCfV5UX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7E288BB4; Thu,  8 Aug 2024 18:22:00 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD08688B9E
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5b7b6a30454so1471887a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134118; x=1723738918; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XceLW2XqiE7wRlBCScaaKGd8cI0ULr15gEOnMJ3F+Ro=;
 b=AwCfV5UX7APSIZI1Twd4r6V1JU1rr78DKGQW6dyJTNO3EOl5PWswWbAjN5jAkHxik3
 LMhXjQl0YtFHmnhPMU4Dwgi3kk4+hzN8yI5YDuRukjJvp6cT4t9o+NlF79vYf9Lezj0c
 x48zn8X8RhqqXXtLkYQH0zLsiRPrMrwzNy851nj2zYvFR+SDvUO5J4qNqUi36Y3YXyRc
 FbGVOW6eBBoni0notYXEmWle/OTv+F/D6/uero7N9P5W0u73Nf91nFuImXKuqA+z9phd
 FU/ttQflXOlAv8dGGA34O4CVwFP79Q/GxarNA9K2X2a1i584U0MNCHA8pgNrZRZzAI00
 09FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134118; x=1723738918;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XceLW2XqiE7wRlBCScaaKGd8cI0ULr15gEOnMJ3F+Ro=;
 b=juSGMOz7oVcqT27BNia0YwzZBzLjFU8EcnrgKOmfMEpuJToa/GgaMlDmzorcPBqhot
 HngDA/sP4e/9l6rxWE3Uqkde2mlB9k2XbTdmBKI2z3vTbLBV7fIKuWsnGfBi537XB8Mt
 E2FY+64rgrWOElL+1+pbVae32zjZ9whk4m2i3YKgAkC36D+b/nVNtsnfvkjdcyj39r4A
 Mja+J32ZRMiC0DUP12BKjV6hLqTjYquBT/khYHwNiR86F7PQYatp+iafyWDx5R6FuQIa
 7m2ttFIbKexFV0sk5p9Q5FPn6kNXHT6bR7oaw0o/tHfoO5iUGzaQRON3FScS7MoNfX5B
 e+/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH9QPGLZXcCw7ZVMhzY3jU/+lw8QdATextY3Nm3RVhHMaY48cIW7pdHmdlk6t+DYeP56jevq0zkgi4fuAMqMgm4RWRWA==
X-Gm-Message-State: AOJu0YyNWWdH/ZjeXlbKJUpGnlgBZ4RX4J7IOGDnic6ljr0Uz/wLmv0O
 QyWgu26NhT1og2jMrdEgtwHvxOIgYX3YUoTah5fmP69CoqwgqC/vEnOFHTaLONU=
X-Google-Smtp-Source: AGHT+IFYs6zGU3usoUaTIc+Z3r5tNeC9Wk64eIFQGXHXxOq6MSDnHpjzuo2w4ib+l5mifszQ+UA8hw==
X-Received: by 2002:a05:6402:1d55:b0:5bb:9ae0:4a41 with SMTP id
 4fb4d7f45d1cf-5bbb2338672mr1773155a12.28.1723134117989; 
 Thu, 08 Aug 2024 09:21:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:51 +0200
Subject: [PATCH v6 04/11] doc: uefi: document dynamic UUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-4-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=CnoU4+NAjPfmPO7lw0mrd3Kf+j79o89BEkFbYPucAaY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCfbmx8zS9BaKx23rvSDdv1h0IrgBiB1yHZv
 2LVq9vRRDCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwnwAKCRAFgzErGV9k
 trVCD/9Sp7c9r6ckFrsozmJavSoyIW5D0ZYMcSbn9MJC9gnll5QuTd0/vDj+pDBBrju1v4M0V28
 evJIvDwN/Erb1w8865v90EGrGKQXV+xphWaMrY3AaYtmfSyc53hZQgI9GS/shSTJh5iNXgqzxiz
 zC8agVYs5URKdS45IG8JyH00+hM6ExbCWjwjT8uflufVEIgULyekuoWKl0aD1SePkEynSPXQUUP
 tXeIBhwfHU2wCqAxp3rDug/Dei6EdVL780hoCivjKZpJASrnM3qlnmvVev8Q+Qpvc+ksSza7tZu
 O+bCShdnYT2dxzpMoLMsTych+40rpbc5DxA0CtXw4aYnDUkOPsHflFy1H0NHFOja47qAw1p3BYI
 XGdXjiDrVXjy0O5WjGcjhs9GXXL9uRwniNBRyrbZ/RQ4IL9gowDDSFjFYAtV7JZvxON4a2x559L
 q2bZRmN89bW0DmI/DOcq8vWarpBuPx6NUn7E660lDMCm+nSyDTksZ5Ffz+ZoPhA0X45vD0lBXnP
 Ovjaf+zt5++r7M8/OjXfDd7II8pLKLjuXEKA+2XE4Zh9Xy2bA7thucn69hw5wRi7Mv2ux564jMm
 AH9mvQNbCqbq9XaD8AZIrjVdqLW3PuOA9lTgrp4Ap0Bp1h7QWHlojKbrv0ZYgY8wTNq/MJfRh8A
 cqRaZG+A2unwAjQ==
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
index d450b12bf801..b64009cc2256 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -448,8 +448,35 @@ the location of the firmware updates is not a very secure
 practice. Getting this information from the firmware itself is more
 secure, assuming the firmware has been verified by a previous stage
 boot loader.
 
+Dynamic Firmware Update GUIDs
+*****************************
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
2.46.0

