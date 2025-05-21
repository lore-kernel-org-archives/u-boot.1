Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19ECC54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 21:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044A582E7D;
	Wed, 21 May 2025 23:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fsyt/hcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2020982E40; Wed, 21 May 2025 23:27:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF9D82E2D
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 23:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747862859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=urdL9iRxQ0QV7cGgq3NR4eZEyE2L11ipsE7cPhVibO0=;
 b=fsyt/hcg0f+1vljDnUzafiP/8q9+JVT6V2qglyQ1HkXfoCYUBgDIrRs1wyxFP+lPMSFQY3
 pP/b+sUUAC5SERHKbem7JZM5wWF+ZDgVNXY/MldhvunQOTZJtzMjv5tXUPhHL8QlqjLmu7
 msMH7GBsye8acatp4slK6WMNDsQcMW8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-ofXISB9sNOCfTeBoUvUBOA-1; Wed, 21 May 2025 17:27:38 -0400
X-MC-Unique: ofXISB9sNOCfTeBoUvUBOA-1
X-Mimecast-MFC-AGG-ID: ofXISB9sNOCfTeBoUvUBOA_1747862858
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7cabd21579eso1278265985a.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 14:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747862857; x=1748467657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=urdL9iRxQ0QV7cGgq3NR4eZEyE2L11ipsE7cPhVibO0=;
 b=eePLoTD0/9ube5JYfnpwwopvsrdDCoEDE4U4CKHKRu5hpwhBOwYn0qUVahVjR649n6
 8ohci8NcI5u+Oj1PANlKBD1T+wIQI3UdKzgXdi48q2qBDSClpVbegeIQ8ToEzFaderco
 myGaWOYUNk7tFamQ95rcN1L/MEDKFR1VvggzqJSWcUGT2OO4t6pD/2r/N36eccF2+oUG
 qdTCc0fnPfWMXMX/aHoWgmj0gN3LM7dmL75XEgMRDFxptxF1CR3GAlmmtd3Awu/44oHT
 7nY+jHRI3oD0b4tP7Oa7vShsHPk+QbuKiSA7cXF2UdBM+qUXutzLSnZ7OpSmoZkEnsYm
 sNrw==
X-Gm-Message-State: AOJu0Yw7PGl5GHg2OjyF14AFWxqfP0ixByTNBUN17Q4dXbYZJ+UCw+Ut
 lJmd+OoN8ZCukSVZtiDedOi/NiwVVF99fao2hualgHOljlP5mZ8fIjqj3U/hT/LKyllYbgCV/DN
 eQIG670ZKbwNe0JgJVPlI7+waqfCTEBENVJvauRxHCn/10bdtk4gjk4nUFYqD4lIe7DsLTBs9jR
 XzoN7lEJkbhB9bWnw7ROLZ/Ve+zh3AneCDGDi6iplY
X-Gm-Gg: ASbGncvB3iZHRkHe0zc/yPeU/suFinM8pC3f1dHUp5f6sWWw5gAg1IwGnt8G4qp3D4X
 eoO5G73t/ojUDvjqahefEeIYPI59W4kJVha/a5Q/7gj+anN9KVLumVP+RcZEcLKjy/cLAfS0Yj7
 zIGMvgViTGCQD+yC8pBsuDOvIQk/qxeAtKzqZlkI1BjTOEVCDf7JPqe+Ypn3Jb7zulbl6nMqRiz
 BaaAqaPxH0ZtxB/Tz3qDGg8yxFRWbuPo+YW55mTCeXkAhiH4HBbv/NquuVKXkZ1CymKVdo1hc1S
 AryNppA=
X-Received: by 2002:a05:620a:4441:b0:7c7:97ff:ca42 with SMTP id
 af79cd13be357-7cd46780414mr3155035785a.41.1747862857075; 
 Wed, 21 May 2025 14:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJAKOhHv/e5w0JQQQm3htRq3fbJLR12hzXR+xJvLK7tPnaGN2a2/ea9VXxULpzb3Ed1rwC+w==
X-Received: by 2002:a05:620a:4441:b0:7c7:97ff:ca42 with SMTP id
 af79cd13be357-7cd46780414mr3155031685a.41.1747862856610; 
 Wed, 21 May 2025 14:27:36 -0700 (PDT)
Received: from localhost ([38.147.236.174]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468cc89fsm928372385a.105.2025.05.21.14.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 14:27:36 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
To: u-boot@lists.denx.de
Cc: Enric Balletbo i Serra <eballetbo@redhat.com>,
 Aaron Kling <webgeek1234@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Belin <nbelin@baylibre.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] image: android: fix ramdisk default address
Date: Wed, 21 May 2025 15:26:59 -0600
Message-ID: <20250521212714.100357-1-ekovsky@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b4WWjZSxsfXd2ZveXhVyBYL9y2Dggv_o9ubOSylM20Y_1747862858
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 21 May 2025 23:46:08 +0200
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

Commit 21e7fa0e3ac5 ("image: android: handle ramdisk default address")
changed the default behavior for header versions less than or equal to 2.

The ramdisk address (img_data.ramdisk_ptr) is only assigned to *rd_data
if the physical load address (img_data.ramdisk_addr) is equal to 0 or
the Android default ramdisk address.

    /* Ramdisk can be used in-place, use current ptr */
    if (img_data.ramdisk_addr == 0 ||
            img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
        *rd_data = img_data.ramdisk_ptr;
    } else {
        ramdisk_ptr = img_data.ramdisk_addr;
        *rd_data = ramdisk_ptr;
        memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
                img_data.ramdisk_size);
    }

When the img_data.ramdisk_addr and the img_data.kernel_addr are the same
*rd_data needs to be assigned to the ramdisk address (ramdisk_ptr), not
the physical address (ramdisk_addr).

As a result of the current behavior, we can no longer boot a kernel on
the Renesas R-Car S4 board.

Add an additional check to the if clause so that the ramdisk address is
assigned when the kernel address and the ramdisk address are the same,
restoring the previous default behavior.

Fixes: 21e7fa0e3ac5 ("image: android: handle ramdisk default address")
Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---

 boot/image-android.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 1746b0189008..459cdb8456c4 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -488,7 +488,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 	} else {
 		/* Ramdisk can be used in-place, use current ptr */
 		if (img_data.ramdisk_addr == 0 ||
-		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
+		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
+		    img_data.ramdisk_addr == img_data.kernel_addr) {
 			*rd_data = img_data.ramdisk_ptr;
 		} else {
 			ramdisk_ptr = img_data.ramdisk_addr;
-- 
2.49.0

