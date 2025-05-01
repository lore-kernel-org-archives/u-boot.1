Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0CAC3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AAC18213D;
	Thu,  1 May 2025 15:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SYvuAqhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51878283E; Thu,  1 May 2025 15:38:04 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8E482724
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85b3f92c866so21694439f.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106678; x=1746711478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5imal6b+qIPnmMcm8Jm91SNSJ5P1sTBqaMahQuWwiQ=;
 b=SYvuAqhJrc0JImvbhIPXDsJzKdEylyKUpaopJct+p6bWXrstObCE/5CA522o1sk3WG
 usn7aNuzNPHT3p7gvuEqvUfygFNuW/QS2QdA+uLbUANosRTqXi6xknbcrXKXmSA1UO5Q
 Nh6+95jfTOpvJRPBDXIbg405NGJsheTv32Cpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106678; x=1746711478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5imal6b+qIPnmMcm8Jm91SNSJ5P1sTBqaMahQuWwiQ=;
 b=pZKoFhGf8hUf/ik9sPWLUEd4Yl9f93/QGjUkSa0QMgpQQYVGFydZEdnh9dneyqd9ja
 HejN9DH1V+D52PZuxp6XhtJpoRZ2mxKGESZiD8h+CPjTcVTEYdYp67AzXqfpgMK1rcxj
 O003ne3ivkzEFXZjRf0WddtO8jjeQiKBUn23zxMAtK8SrULu/yqim4a9wwCbWv8Ka/po
 6hUKO0KJL+D+9ZV+ULQYW9JIhI01Li3RVQ8kEYo8bbjp59JDcgw5pX0eoKQEwjgQP8gb
 N5GEy1qRSQXa7g6z4NjLdvDN14uMoigoMcPi9MwOueU8CbjbUwfTCzdx+BLH6Gn8lfiv
 ekCg==
X-Gm-Message-State: AOJu0YztvMr9sPHTno7UKUVRTkPxkeZO0wabCRF3ppkPzgIkpmlvPiS+
 uExu8Q/JpYHj9byIPmKtdgtmgX+QsnGAgVHFzZbhAHcRO5qD+4dYsrc5NszC7J0omzQPPPUTLKg
 =
X-Gm-Gg: ASbGncvkdLDm1V0gy56+bZqerktHyJaZNCqO+tJuw4smReDFmm7la0labXNIeIpu0g0
 6LZLmBEORhEDCzZml7coQHOVwGLoGM9tHA/6Fpgs/HWFIX+7Tusr0q+ikJwCiLGt7emA6UW9685
 cRgzZA58mwmhb3vxgPb+5zZn4avrC63t8D0c6Z+feVe+YtqfsGyZjj4gWeZx68FUTA/jdQrihLb
 rI3sWWULtBNjXfmPOMecOQryp1AoCugAoQbGi4Mx9WiE8X+z5GGefw5CWuB7Tng3SVjUlQ154EQ
 9MZ/E3Heq3PjPkq9zmir9u8OEy/q1uA8UU/6UJzIqeM2IuW6vsCBW/MxG5RPHDk08rB8lya2JLp
 aECp2CCk36E+r
X-Google-Smtp-Source: AGHT+IFpcONlTwQJigvrBl1bi4986URk0Hyn1/qTDLZg7t42c+aYol/iFvVtP+inomzvtsC7+iiKyA==
X-Received: by 2002:a05:6e02:188a:b0:3d8:975:b825 with SMTP id
 e9e14a558f8ab-3d967fa1b89mr71706585ab.5.1746106677875; 
 Thu, 01 May 2025 06:37:57 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/18] bootstd: Correct the comment for bootmeth_set_order()
Date: Thu,  1 May 2025 07:37:16 -0600
Message-ID: <20250501133726.2627373-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

The function is used to handle the boot_targets variable so must support
space-separated items. Update the comment to show this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/bootmeth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/bootmeth.h b/include/bootmeth.h
index c32bbbab7e9..8f4706c555c 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -301,8 +301,8 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global);
  *
  * This selects the ordering to use for bootmeths
  *
- * @order_str: String containing the ordering. This is a comma-separate list of
- * bootmeth-device names, e.g. "extlinux,efi". If empty then a default ordering
+ * @order_str: String containing the ordering. This is a space-separate list of
+ * bootmeth-device names, e.g. "extlinux efi". If empty then a default ordering
  * is used, based on the sequence number of devices (i.e. using aliases)
  * Return: 0 if OK, -ENODEV if an unknown bootmeth is mentioned, -ENOMEM if
  * out of memory, -ENOENT if there are no bootmeth devices
-- 
2.43.0

