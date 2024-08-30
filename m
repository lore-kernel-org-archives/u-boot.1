Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6375ACA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334F488C05;
	Fri, 30 Aug 2024 14:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k3naNV7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0061688C20; Fri, 30 Aug 2024 14:34:41 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0729488BB8
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso15891715e9.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021279; x=1725626079; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/b/8MiOtStSdfdpiDFC77Y/HYjbiXPx78MBnwUYXDa8=;
 b=k3naNV7hZ+0iax+GuVqCFx1gxKxMCZInjrTrezvSxS8X3b4ieUcOFt3OwJq2sOoCZw
 ezJv6HZhWvnmS5gn7rRfF8efYmtXVBJTa76lmlDUSHvTrs0lW1iyc/XDeDN2xolfZevI
 js06BIj47knt4IQKMaK3xZYquZoZlwdHG7uTCDXNiHsZId5uUpbEx5Ld/kva58lQO3By
 pqJeE4KLSdyKJsYS3Vseft8IDxhEgS5ugCAxeZEWx1RSzuiql6hrLqmh6zzK7OqC9ZEb
 AR1cAmsLtQBBvD3SxZ2fJ2+nhTFDnAvIUkbiDAYW+seAOaNeVB9HTSVx2HKPcfm+igVl
 LWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021279; x=1725626079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/b/8MiOtStSdfdpiDFC77Y/HYjbiXPx78MBnwUYXDa8=;
 b=oNlFjPVo+T1S9nsOcsjVSJYE2xqpBV6EZM0MGtwvlkA1/s6GrhnZcSXtTIECCitHdP
 xkTvqD4dR0ntYKrcqO0IOfLo5Tojyg/Sy+lRzpwKwrTjbdcq6382kCW2qaBvXX3yMQNo
 a5CTPA3gbxHbDBM7W6NBwMeElvrn7O/KtIjrEObkOebHMqLc2aDBUwQ+KPUKr0IVxOqq
 +o3r/holaUDv3e9YXPxkw+2FIWDJYAb3Lfj8pI5n178xue7hfrfDVIqiYCfiMZLGFEAR
 2tILGV6pICMkgzo92MkCruHprAVdTq41zkt2Gi4z5kmtk2HmmhKhH995xijV+5bAaBgS
 or+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLCXbl0W9Wr67UrGPme/m4n3di3R+F0K1D5qOgSk8DJZQDIkviOjRVmMHOc13eNzT7RF+08uA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2EER09IeQw7prst9n3KPCECnmxut2q7vTLadSxi8EeYq2fOCP
 xW5B2G0t6yiVuyKUiiOkECZPEEABkCyTASDz07b8Yo0FzGRYyUDtO0KtkMOkTtA=
X-Google-Smtp-Source: AGHT+IFq6gHzSWvTD16xRTMCzPvdrwmMDMPpmPGxMrCXzgK4yJde4wnmpj7Xk+I9gumJBvwpMlvesA==
X-Received: by 2002:a05:6000:1545:b0:371:7c83:12e5 with SMTP id
 ffacd0b85a97d-3749b544876mr5587324f8f.19.1725021279348; 
 Fri, 30 Aug 2024 05:34:39 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:38 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:34 +0100
Subject: [PATCH v8 04/11] doc: uefi: document dynamic UUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-4-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=z+k7ehN+E2cuyiSmyz++J33laIvhLNnuuBKXIQoKanw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxZxlz0AgnBdY5bQR47aTgPBRhNkgg1LfFZq
 r0PWQVOLNmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WQAKCRAFgzErGV9k
 to9bD/9AUtLnQI/fPWD6dlCbJ3gL7rgMKkYc+tKqWE3KcKHsfBStWBbXr2SmK8detMiZ1HdE3XN
 lhukt1Ww4/3scXV4yT6uyYXRhIdjiBGV2lbYHnEsnE3/3KnURxMZykGdowhegGbajvCGTcGwTSF
 5LuZ3S4yN9E53mBcP+GE38ss1cGOUcEyHpVuvhpaTKrBjp+IvMTOIPq5TnA6lxOm2eH3bNcM86O
 EqrX8qVjD9O15ct8lC3H3mPMAPHt38REpDVmmD5Cpmm/FouGG1Ad9TS+8W1p7HX/1JWhDiFoDVr
 SehD1JFeEuBTIVcY3IYnt1ADUhugZrV5dEFOyZVBtGzIiZjetpMWfH8ONt2dsDS6fr8kmcMa7fV
 cAPGerMrBazcSbu3uLwIC7Ve3bebTJqOlINYa+oEwhfnjieqiswfvEqxtIIxc1ipe518lPrFjpM
 LIGIFYIZvm8b/Uro1ijq1EoRgV4XkKBv7fAR5kcbKduLly6uXsnp1IOjdbwfvMGnYn8thn6kcYq
 tVNvQMsj3x8Y1M1cHO/2Xa+CuTGieoZdrT+jFP/zf4Z7YTh5Zo7z13ScdeknWWtxB1Pkg8Cl0Zt
 mEMmoOkX87+AxyuP8THDxbkcaFS9CUXo1beRGunxlZQSo6CRMz3tIAqIcALmnv+MxZz5XtxLjXF
 o2U7PO6hhBY27Lw==
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
index d450b12bf801..944827585731 100644
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

