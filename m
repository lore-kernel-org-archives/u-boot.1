Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D5CC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA5F82977;
	Fri,  9 May 2025 09:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AueDH5Oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB87182935; Fri,  9 May 2025 09:03:52 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8409482905
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30a8c9906e5so2316309a91.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774229; x=1747379029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEokt0TRyCHVnQ7y9GjVFIukHf6MhdOKWOz0q4o1/Zw=;
 b=AueDH5OjyWh8d4Jr/6cgGla/MZb5N8U9jnOaoZObJ/bHOEZPerWB4PzeIiX/qlS2Dr
 b1VbWviWRS5UJ9v3fQW/C0gHyAHcqYP2jFyU6XUhVP3DE4tt+169Y03omvZOvCQEhHkC
 SdZX6DRbYRd0ZOypkP3B9VCASZGJIMYp8WVa3ht3jSNrWBDu3sxCm/HhhhXh+mZMm5fb
 T2DnyEPLAzq7GNr0nPYt46Kge/gyJl+h5hsgzUiqvA+6MNQ0E+fKbe8aoCe59VqygoAQ
 h4i2T9GEQz/1pYv8j91mj4aHnoinIfcpsIv5aTAlXoUM1H5Ti9cSTz4H8Dro1SdwYjvV
 eToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774229; x=1747379029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEokt0TRyCHVnQ7y9GjVFIukHf6MhdOKWOz0q4o1/Zw=;
 b=OL2VvZzAsowDmSs9JpaPfI//9SOZ2kat80AAvIL+ZQIaHYsnhHHSEAgyP6lfxrybsl
 nIi+arimBReR81vgHKIN1pFoqp2BeDf+XZtKxIh1lu8wuvfcYDRTmUTv5dptLR8b78/y
 cBXClvVkpGESK6shO1beUchawyDBjKupkLTD8FJmhNgu7qZ0HZgLkRfrjK28BMfcIMtc
 n6/unE1OFef7q98o6d4No+XFTlRwwRsH7r3EbUcItNRQNvQY6l/33ObA8iJ97Gy6i/Ds
 +xGpqA830ZMV6f9ULKS22e7IE+XG5MKVuBX/wTC3p6emZNc6RpJDxgR8tArTbjZijKDf
 8slQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGaH/xK7od+/k35n8SFke0sR26+myTnDHWUcf2BZOS/Tu0xIlqC+HwvIvt0hX6yBBrDjuPh0Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywlb5TdMA7tnozmHdubxeDWvde913ndEgnpl1BKGMDE5Af7TVt9
 LeMzkwI6Tq5GxAzkS+q0TXuneBKqB7J5/MBwvijPeto0A7f03WsC
X-Gm-Gg: ASbGnct4mXY9nl4i0i44sVF5od+dJu+TmiP3xTww5YpYefCSK6+DfmenfzjrIeVUdQu
 aIecJo8Jk/egiphW4DzZfO7ocVMNFrkYFahZ6mhAcVu5Rahv6xO1khf3AK+/JUwE3ePD+edJjZM
 rZLUsWR91SWbgUiOR0Lc+1kHJJVRn6Tn/FbjSikPfbcUFK9NUVZ9y874U+USYVNtibEJ4b7FQAl
 1o+7NSawZK/jY0z/u5ivIVxexMwcKkjvmdn+BWRuIuxGQQIHDGbZx2WGKaCgU87saDpAw+zILfV
 Nn0jbjWiQHMO0KmqdYnyEtaIotlHw/EFgMA0qiPbhoWPVDZN+TSLeFB8/dZFMKI=
X-Google-Smtp-Source: AGHT+IGtDIGa7erq+FCqWgARoRXzzpiRJ71/MVkLrZ4GkA7Tx4KoT1AgXL9RIQBXqQjNq64CFcNFFw==
X-Received: by 2002:a17:90b:41:b0:309:cf0b:cb37 with SMTP id
 98e67ed59e1d1-30c3cafd29amr4129796a91.7.1746774228990; 
 Fri, 09 May 2025 00:03:48 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:03:48 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.denx.de (open list), u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 4/7] configs: odorid-n2: Enable Oboard HUB driver
Date: Fri,  9 May 2025 12:32:09 +0530
Message-ID: <20250509070258.5077-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
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

Enable the onboard USB HUB driver to power the
USB_HUB_GL853G-OHG on the Odroid N2 and Odroid N2-pluss.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/odroid-n2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index a8cbaee3c96..1bf687c1e6d 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -64,6 +64,7 @@ CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
 CONFIG_USB_DWC3_MESON_G12A=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
 CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-- 
2.49.0

