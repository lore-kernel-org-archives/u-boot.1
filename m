Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A98C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC33383FFC;
	Fri, 11 Apr 2025 14:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RxZ9wwhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573C984005; Fri, 11 Apr 2025 14:48:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941EC83FF0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so19745815e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375679; x=1744980479; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5VjAeINkyUoI8mMB8Rlc0rmVL7A0HFm/7qiHBgQUubg=;
 b=RxZ9wwhuN0vgQymM5ZBaheGMuyxmEt5DQDk2TtXFP9I/vKax998r7ZgzVteK5TqBmv
 IW5mE6sYQM5xmejBij15JcS97s6oEChp/znX7Y+oDIjSRGDgXBVnX4IzgirUTIgp02Kz
 RfKJBNSDComNfdq+dene15tK2g2i3lRTeedT13kFwwsjv0YAj8epFyTzl+PYYDLMwNsl
 RUqy+sd6GjUzShy61jFopuLBVKO0+/9l+vmWw9gRW16eREUgz9Lt+WUbXeDm1HRMJPVU
 5eZOkqj5MSS/jqH8LHRqFvhdYJocx24WOAYsEQg3Nh05FmKGggbI+4eA8iSXWdHyLCm6
 IXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375679; x=1744980479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VjAeINkyUoI8mMB8Rlc0rmVL7A0HFm/7qiHBgQUubg=;
 b=xK22r3X8uBbwotpjWqgzRgHo/HG0+OQQ2EHgb5RTFSy3RnTN+2DHyn1AiuilX0P8wW
 /vkg3ZG/C/7bAlTJOSAPCe6oydbpl1sY7AGppfz/aFNhGItlfgY7wgYT8ELegBbRmcAg
 cpEFWqgL0DFJK2gkQVOKuKmggdo1AePMfh2HZ6GhKPruhYSpvYbNeOV7fZdtuFS1nM1z
 bLdZFMOU7pRRDdRZECDGw0n1Jc0BeHjHh180tVNhS2PpFLWWK6T1SZeBXt0Da+6MWwDY
 5tmQvEzvQD6d3/T6HmPjTA2/rtMkHIkFyX2ml0uGaEQ9/Z/LARCWJLthOuqZ1dWUL+l9
 s3Ww==
X-Gm-Message-State: AOJu0Yx3/FRO34s+vLJ0+5AB9TlmWrqEW9JSIG2ZrPAh67Vny3G0G8Id
 6Cji+WnIHeWqDEiEci76ngixyYYb7qPOHJniuOL7E8szmYpNZNrVQ/UPcfg6Dkc=
X-Gm-Gg: ASbGncvU9NxL3vRQaen/sQf1Xbvgk70ZHIjFtMhu+4x/X+vxeP7sgZJQ9mKCxtCv6QG
 f/j2ZbsotP4nYt5bI7uCdEw1UT6fwF8mNGc7o2JtJhz1lFGQdk9IQpP345QYPpLKe3CAtErEsvK
 nFEimrYt80NwsP0J0+kdnmJmEcbKO+L3//ZpK0RZBOozKHtHx3WPpFvFELqXfN2ICwGdd0mXNyk
 yxXR3HmDRZCEKJ7tRyRQs3gJdJ5I2qypouL/In8cSMtgWSfFt+aXdztlAD5M/LoFTRyQPa0SKI0
 a0VyI4KHlO9E/lkZBPS+4EMf5QsArOIaR/QtFYsfY9j4ltWyNzzifOnDpIqxxxZX6sll0tzXZVr
 Izt1w5XDC6kZhhSYJilTfbEB0j0qR
X-Google-Smtp-Source: AGHT+IGHVgecXd2RMAQe0RUlCEY/FgH6ammwZESy1rJ4OTMiNsqS9Vw3sdYo7YScn0/32BtZG7WSVQ==
X-Received: by 2002:a05:600c:8709:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-43f3a925e0amr25853195e9.4.1744375679036; 
 Fri, 11 Apr 2025 05:47:59 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:43 +0200
Subject: [PATCH v2 6/8] mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-6-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=uEd2ub++HG9dCbEmtDV+nXaF06/lbpP1gSd8mpDqjSU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q906inti+h5F8lw8SclZj+7uir16M/NGGwGd
 e6h02abeHmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPdAAKCRAFgzErGV9k
 thepD/48ffM7q7KvKuoQlQJJdjcmFrcA2hDFrkQv3XQN5epxfHxAzcShLm9t8W9swauImJs/gQ9
 vraU/qGDBGDin3Ta7W4Be7xT0d70LuQDF0gqCdavwp9CKx2PQe6vN4+ZWLrrGthY5+4YXkTu4DA
 I6qTlisIEZaNBt6+y8Q1qGz4cZKrafT0jUeLvRNR38BYU/zcdJIl2hifANwWuuZST867LUKZNDm
 yy15LhZUZsYO/SgMBSUU2qNUVT+s2kjrgO5M+a0mMIdcbYJy8bc3klmf1B+KTnLu2cJHuF3pHeN
 rn330wwhL2wvV3Lz7Fa3qhxKWv2IAO2a6U7MMhq3jreeG4bCuWTAEF0qh4ia3zSeS6n0x+7PC5f
 5KSv35krOo2dVSXFR5MeGa6ZvDDHyvplJRjJli601/BrYVtvjkri+uwhZoqArpX7P3A3ri/spDU
 I9OWX8jlyjXNCHyPDx0ozQxlDpjGlHIJOQSYV0nPRpwV1sLvk4E4Vl02KjuFpMsoj0ViuE/6DOe
 51JvvcZYBACMhs3c5D8qX16f/aFCtBzSH96lqun6E9p7tMQTZX5D64n6+aF+H9MECifzSabYICk
 nuD0grT84SNJRQvfK4XEHETT8IO9MfE2Mj/GtgnWsFby5ZKoaAACYn/Z1wq/lDq+9DuYJAK7VQ1
 /72TJSfG2sYwcWQ==
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

The RB1 and RB2 have a single USB controller which is manually muxed
between a type-c port and an internal USB hub via a DIP switch. OTG is
supported in Linux, but the DWC3 driver in U-Boot can only handle a
single mode, and defaults to peripheral mode.

We did hack around this on the RB2, but the RB1 got left out.

Now that we can fix up the live tree before devices are bound, drop the
DTS hacks and do the fixup at runtime instead.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qrb4210-rb2-u-boot.dtsi |  6 ------
 arch/arm/mach-snapdragon/of_fixup.c  | 28 ++++++++++++++--------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi b/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
deleted file mode 100644
index 7d1375f38c44d7bd54c022fa3d390f666a35d6ee..0000000000000000000000000000000000000000
--- a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/* This is usually OTG but U-Boot doesn't support that properly */
-&usb_dwc3 {
-	dr_mode = "host";
-};
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 10053e48d88017d2179c96f2f3724c4d5dc4f3e2..b398c6b7b9fdaddc03324921e6b955919f9c7675 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -98,8 +98,21 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
 		return ret;
 	}
 
+	/*
+	 * The RB1/2 boards only have a single USB controller and it's muxed between the type-C port
+	 * and a USB hub. Since we can't do OTG in U-Boot properly we prefer to put it into host mode.
+	 */
+	if (of_device_is_compatible(root, "qcom,qrb4210-rb2", NULL, NULL) ||
+	    of_device_is_compatible(root, "qcom,qrb2210-rb1", NULL, NULL)) {
+		ret = of_write_prop(dwc3, "dr_mode", sizeof("host"), "host");
+		if (ret) {
+			log_err("Failed to set 'dr_mode' property: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static void fixup_usb_nodes(struct device_node *root)
@@ -164,21 +177,8 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 }
 
 EVENT_SPY_FULL(EVT_OF_LIVE_BUILT, qcom_of_fixup_nodes);
 
-int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
+int ft_board_setup(void __maybe_unused *blob, struct bd_info __maybe_unused *bd)
 {
-	struct fdt_header *fdt = blob;
-	int node;
-
-	/* On RB1/2 we need to fix-up the dr_mode */
-	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2") ||
-	    !fdt_node_check_compatible(fdt, 0, "qcom,qrb2210-rb1")) {
-		fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
-			log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
-			fdt_setprop_string(fdt, node, "dr_mode", "otg");
-			break;
-		}
-	}
-
 	return 0;
 }

-- 
2.49.0

