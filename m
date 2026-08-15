Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09579C5DF67
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B171F80EAA;
	Sat, 15 Aug 2026 22:48:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h8AhNNsJtDkv; Sat, 15 Aug 2026 22:48:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF82D80EA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834132;
	bh=q64i8bKr+zgjQdftWY1TCUBu9A3gRRHxMTOGyd98o34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ukA/CaqRvZx/2WF58cDSxp7r26ABYunSgGTttqD1lnlhIMOHBdLrjdG+KdzN/FFQA
	 7ZIlHuE1V5zywQ0tssY0EF4+Zl0AGspEuzW3XZOlKOp0r+3w1eTwK+6SsgPYJxpr6M
	 GgX83ENAJTK6cnxIHBcHPpunVG68HnmmcNpLQPlNsfFA3aonoBzUpVozI+UAMeGPhG
	 jNGCPC5aHwu7qjf1xfJ666tsDqCNMy8W9aB7xzth1IKyK/1DLwMDbBbwWao68A0832
	 Ayd1/rQeivdV9rU8ZWpJZYTk0yz0a1o9LUyH5eGMcqKXHbjvmXF2SH42DB9sVHlx34
	 Jm5BdSEMAcGAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF82D80EA5;
	Sat, 15 Aug 2026 22:48:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75AC8333
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6826B407C4
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUn4jhdMeuda for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:08:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8A723407C2
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A723407C2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=QVSki4Tb
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A723407C2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:08:07 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so16578985e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831685; x=1787436485;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q64i8bKr+zgjQdftWY1TCUBu9A3gRRHxMTOGyd98o34=;
 b=QVSki4Tb1+31sJiHsfp7XvgtrFcHYxNJiH5Xp0JFbkljI7PSDK4RMLgplQPeKBWNmZ
 MtKZckcg0eYm/Wiw5c9jbGfYnfYPGJUIjqjzXfjJFSPGiv/8Q4TBJKfqC5BOy8A+L5db
 XHqBJUzKddGadlrpOEjZ1Mg8M2PT3gBPRbhEDn04N3D72jZ8ZZbVnmEjVq+WMB10oAXR
 kV8nwImPsjh93W3C2cj3s6iXqCPOcxFJ6lg/nXtlajAXGeUDyM1fywnb7M+JOAGyMN1G
 WsdvwKxg6kui9a1VFDrO2Vp4Lfh/PU+fdnIRx2aAZT0Eqod6NMLFj36RiDCU6W1mRFvh
 g67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831685; x=1787436485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q64i8bKr+zgjQdftWY1TCUBu9A3gRRHxMTOGyd98o34=;
 b=ft2ejdiM7o+Fc5JplfO+r8bGy/7BQloLXeYBp86qpDC4nAb3WmJAZ1Famn7QYohLrO
 o9dPfCtckUMcb193fpGgLxDFBQwxG9mlAOgsBd4h+TkA/uvGeog3P58j0bPYtnqBuhwA
 Z0SndeGIyXrGTypIRoYB5c3/enR6Vq9QdIcUMVuOwjQedf+f1tA3C+Za0jG3R1xE9YGd
 cehZsyPE5JJhxd225ciGQl5v63bQ+MD268N7P4q4ZPUt7YM4BsX8ExuQWRs/yvjtznBg
 JMPCnHwWK11Q7pILU39QaOVAr0NXO1Hi7yqOiE07GpZwwr0J2lzAZkOtZcWQJLW0RJR0
 /8kg==
X-Gm-Message-State: AOJu0Yy4kU1vIUXltJpiwxuGmmDrCRZYbA2PPhx+vH2v012MxUMF/i2c
 uoMztU+bmOr7M1tkr73oO5n74n/KJN0OzIAqNei4tOsa0BbQ3rbA3vKyizCb1+RpBoc=
X-Gm-Gg: AR+sD11f6Xn4Ay1w5eTNw4lR+xDcvjEkto7FIjyE2TeY5Qai7Ww9KbEeP8jqAPZey7T
 qebSqjvw+iC8s9KNv3pvTir/DPXPhkbQ1o76ruX/Vf6gfcEA77KsmpmySHVUYTxmdSJ/2aGVbhX
 qol/JOOmLbEoUx3Lqem8UdMaNB31VjeTiTWgW/DDjoS7Yy6FOgPpvE8Zsyfb0jjLGXOn5p6gHqL
 slXMmH83XyTUl7ZsQOOiZ6peU/cF7tn2T2zQ8LAqnoQ9jM91Gezj2JYRL1CXGUh5uQlG6WcNS+v
 A2WHJyNaS/yXv+tAypTcujYN7w1GppHaVr0niQ0icw8LHfwHB4XJmTTYJQjT17m/XQ11/VcHDK/
 lDyWdnc4CcCOW1eUbGwnAv9xzIe15C9eBr8NZ9bPTPGEoXuSFjifGKpO+R+lRyli9IP+aIJlI6u
 nJ0tDcaHoZ3mwpmrfB72ct508FW4zGAz98vHt75yBZqIQrsY6RkhdoP5+sdib1WaAb2YsnVvLcb
 RL4jsH8cu9HrUnsi4wPflLyxedM7GmxZDcntfdeuc2wD+Z2qpniqfhjANRzuaExzsVHDbfJ+quY
 If6WAtjRrX+4RYJU6JEYS0Oz
X-Received: by 2002:a05:600c:3796:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-49987993e08mr193561925e9.17.1786831685218; 
 Sat, 15 Aug 2026 15:08:05 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm179598285e9.10.2026.08.15.15.08.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:08:04 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: philippe.reynes@softathome.com, trini@konsulko.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1 2/3] image-fit: check the length of the
 data-size-unciphered property
Date: Sat, 15 Aug 2026 23:07:53 +0100
Message-ID: <20260815220754.11724-3-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815220754.11724-1-pranavkasthuri@gmail.com>
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 15 Aug 2026 22:48:45 +0000
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

fit_image_get_data_size_unciphered() passes NULL as fdt_getprop()'s
length argument, so it accepts a 'data-size-unciphered' property of any
size and then dereferences the first four bytes of it. A property
shorter than that is read past its end, and the bytes that follow it in
the FIT are returned to the caller as the unciphered size.

Ask for the length and require it to be exactly one fdt32_t, as the
binding describes.

Fixes: 4df3578119b0 ("u-boot: fit: add support to decrypt fit with aes")
Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
 boot/image-fit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..0b98cc242e3 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1040,11 +1040,15 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, "data-size-unciphered", NULL);
+	val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_size = (size_t)fdt32_to_cpu(*val);
 
 	return 0;
-- 
2.50.1 (Apple Git-155)

