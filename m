Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5865FE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FFA89405;
	Sat,  7 Dec 2024 18:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V07nc/dP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E21891C3; Sat,  7 Dec 2024 18:26:06 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9E88939B
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so115100839f.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592362; x=1734197162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyZuMFoqZLhbMZy8ftr92p+WXS8xDpo1+GTJBnHgM8k=;
 b=V07nc/dP8VJI2nokwP4F8hrziqdNGl5VRxL9g4LdJjL9OoD6guivwTC0LQalp6vhAz
 sS1gNEdkcWZQ6ccMvRWpLxjvdmLmmHi0VaiybZt0TkKeKdfsVDqMvbuoPDqNGjh9qP/e
 wYaJd3URTUfR52/WGMS75LaabdJfH776OYw6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592362; x=1734197162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IyZuMFoqZLhbMZy8ftr92p+WXS8xDpo1+GTJBnHgM8k=;
 b=lGgf7yRGmE1AEXJ5BONqeSNXdZtFZ2rkTv9IUjec9nrwvq03/cmdHzqzuf7vPp61aS
 BLqVS6h8WSQMMUwXlOH4MeVKy1YGan2HVOKzzOaf9Ai3oK+izeZbNeb3MLCttAj1ysho
 GR8ia3Yx+GD3doQr81Vfc76nRBzWHjE7JJ6gcf90+7cAeNzDa5nTzHc//FfW4vIGfV4e
 +CH324FRO+GfMsoVlzSJJJGYoOCRJflh0TpMlAC0oar2BpZiKp6DkxEumfKJPHq5azDs
 okOIu60W383ScguU8Kb9iGPevtvfgOJ0RVr0FdQVycLMAA+iW50nXIbEURLAQ6JKZjtV
 qwJA==
X-Gm-Message-State: AOJu0Yww2vyzdeVEnR1/8uxCicno+uWMYrIrrPLM9DxEWH+lr3L/Dix8
 XYN1sOl4CLIFdmcSLaApoVxjoDqLSuKtA4zJxym/gv/Co7o8bfX+nvvbMO45UM0e5E7f38PViFU
 =
X-Gm-Gg: ASbGnctweJqRBjZDfXW25lEz0JYp5EaWWad/eGkX1UMglt1gaFlBPon9Juauvf2M4Dq
 6G+LvqmqZCbrXha5Hs5wMQ3ToCTauc7Xnb6qgC0a+rrJ5aBnJDg0CGpDBFNFSu7k+GuZflcvK4K
 jOscaFCn1IRh07lDo3HWIoSvvC9Xsqr2b+csxENo0laJwaoD3BQLM8HOYHdTMUZZCw5vIWc+4WS
 Hx9Qd6S22u7BpsVZ4RPyJOwAFKNBsBluFOYANh8+gJUQMqqnSoc8PsPMJ4vGYdA325kjh0i+JEW
 o81ZaTX/qtc=
X-Google-Smtp-Source: AGHT+IGP5UIFUJXsnnLqO6cC9dJCIAHLAWYKwBB5FYvivmNGX3/w949lpOxGtryGVrGSbuqfvn8swQ==
X-Received: by 2002:a05:6602:148e:b0:7f6:8489:2679 with SMTP id
 ca18e2360f4ac-8447e06d784mr744092539f.8.1733592362468; 
 Sat, 07 Dec 2024 09:26:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/19] image: Add a prototype for fit_image_get_phase()
Date: Sat,  7 Dec 2024 10:23:55 -0700
Message-Id: <20241207172412.1124558-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

This function exists but is not exported. Add a prototype so it can be
used elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/image.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/image.h b/include/image.h
index 9be5acd8158..bb15ef69871 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1171,6 +1171,18 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 int fit_image_get_data_and_size(const void *fit, int noffset,
 				const void **data, size_t *size);
 
+/**
+ * fit_image_get_phase() - Get the phase from a FIT image
+ *
+ * @fit: FIT to read from
+ * @offset: offset node to read
+ * @phasep: Returns phase, if any
+ * Return: 0 if read OK and *phasep is value, -ENOENT if there was no phase
+ * property in the node, other -ve value on other error
+ */
+int fit_image_get_phase(const void *fit, int offset,
+			enum image_phase_t *phasep);
+
 /**
  * fit_get_data_node() - Get verified image data for an image
  * @fit: Pointer to the FIT format image header
-- 
2.34.1

