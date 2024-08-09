Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2077FC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805F388BD4;
	Fri,  9 Aug 2024 02:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x/iO0nDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A5E88BEA; Fri,  9 Aug 2024 02:56:37 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB36C88B99
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a15692b6f6so1728879a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164995; x=1723769795; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XceLW2XqiE7wRlBCScaaKGd8cI0ULr15gEOnMJ3F+Ro=;
 b=x/iO0nDfJ1lFnUUNB7CGZ8+0ffWubeJijPifvtlGDHRkUqqSkwK2ZRynCR/c7Bw36x
 GfnU73xQbuc8Gw+Tyyuy7188xGUZd+B3D4pCeXXiJaNg3b6BlEpYY/gTdZPKpk1zeQxf
 kXW2+vrZwkKv1bJAxU2FXVTdIOlMXLn2lBaHJ4wsq6wj4Kwzdl2d0vEgql3G99B6Kzr0
 /JLgnwImOf8XTOwKOVPko5uqXO6vA66qxb70+MrTuiHAqY/R7QOa2wLopSnj6SiqFAdV
 hsrCp9HPI0DH1Lt33E7CYd5oYKQXYSxHoB6wQ5Dv32+mw3IRfBJi8VlLTlM8LQl8wapO
 ozhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164995; x=1723769795;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XceLW2XqiE7wRlBCScaaKGd8cI0ULr15gEOnMJ3F+Ro=;
 b=Jde/+cHz/nqIOYOuZtGo9eJocW4IgJsNoEqA3lef3HkcdGEUrn+5nSW3ogthCVc3jU
 Bwd4TGzKYwByvAFCzLeycdxRAccmwnyDP9B8K4V8rdWU4PloeeuHGkPru1o5AlnE1h7x
 85NtXr3OwF1ngP025giEiusOQYeokN0AypbzJQqIum7HxxSkxd32ppeTN3Gmi9mmRtWk
 ZBmjRG/4aVPPt3JciTGn7rT7PRTy1kB7wa5ReWl6yiAVQpWudYV0UuHVpUGee75G45L5
 TMXlYMd0j4l9tjduJl/FwfRrvAiH/f8JvU849imm9eSdZv4wU67jQmDTVVc7EqH0Y+pO
 Q4gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyQD85y3GYvqWtmqi74vVP3+dnL0l4aoCIr+eYiHigv+OBDtYzpskHPRPmIwqM+ZdggHQfNPjan5+1GSDIayvB56aDuA==
X-Gm-Message-State: AOJu0YztZwdL0zohLftOi0h2JuxYQ24agI8h62ZV0gHpacC/2ocuXlNZ
 4js0k6ByE2ssPf/PyvWHZU6+KuS5CxYRACA64JbJgmCUHYUM3Vd2OUj/zlwl6Vo=
X-Google-Smtp-Source: AGHT+IHivcmEQF2Gy4IRiJsFfETa/gYYMCOMqhpRq2ME4DL07aXyPYExq/e6JRGgQU597QqyiEhfqA==
X-Received: by 2002:a17:907:f1cb:b0:a7d:e41e:6bbf with SMTP id
 a640c23a62f3a-a80aa65eed5mr369566b.50.1723164995007; 
 Thu, 08 Aug 2024 17:56:35 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:23 +0200
Subject: [PATCH v7 04/11] doc: uefi: document dynamic UUID generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-4-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk8k48ESrmehsCSJB29SdV+aDDseXVIkgoSR
 JP1X/1lUjuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPAAKCRAFgzErGV9k
 tqK7D/sE+kP3HFtW7I8QudEVkVnyyL6gg2SpfUSjcYaWvHtGkF5v7Tf4fxSze1fBqc2mkyLn7Gh
 hq1LSOvVsEqRtGqhGpk3Lek2Ma42LDydklZ/YY4PJMGLhQ79bOD8+3IuCokPI/cPAjBOWRtPFNe
 NVZyWmyCdVmkmUvgzFoyd2NVhPjJfUulEw2A29OPI4sKX62Sqstaeb1OStk8sHqJS5KkCUqrF/q
 NL4hQGO4UAIa0bgMFkRj4ydO6C13JhyQVlRqDZeR2NpA1iMo5x+PN/aCiO40EZiaQZc+VVPEmig
 fDHuyZ8w1JDQEhw1kdtp4LttvNssm5UsW0kbu7T4PtzRZpot/Hiw17Vm0nJsggVvi+4X4lacL8w
 webPa0PTWq45Sro+pV/zaYxQqIj44K8wyp8o22YGuJdGDKbtx9fbYg7+M3novXxncmPXaXeFEMq
 8uC0wBqftBkY6jXFWS8cyqRtfVjgIIHJ2xX5VIa4Qd2KHlX8F0H/LfZZRq+3CH8Iu3uSpoBYYGd
 yLQgx1ZNYmArsOGqwEuONY/eajRSe1TNhjbPxjeFPZUZ6hCVqB3kp6gCZUi86rwKy125OmYQHaJ
 JcqaZa9GzAGhtfb4/Xv+HrgYPRGdw7/bY4vNJhP3sA+wU8cUloAxB+ByudKUnJktEJtGGeSB30g
 OTerNybSWhnX4tg==
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

