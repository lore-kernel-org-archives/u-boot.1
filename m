Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40860C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 535DC886AA;
	Sat, 27 Jul 2024 09:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="T0IRnRm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 154D1884DB; Sat, 27 Jul 2024 09:20:18 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F350A886DF
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f01afa11cso2862271e87.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064815; x=1722669615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C5CgAdWE/bEiG2q3uNLNwlN8pAqu5qqODBp3+y0Ovo=;
 b=T0IRnRm1YKByq+QpfH3pNrp7+ZnG3nbfT7E2nsv4YngTXi6vlukURFkNXQscjT4WHI
 aMEig46ZCaupXBEvLZux1482CZg6OZe6ZTD6rskJbrdhZ8A2lhRqZ/0ME7gbZ0HmSy6M
 Xt7m1IMxq1kpPOUiucaLD1G+MmQ7IqsTSfn/XWW6Su+ZF92Zfn8zbyEw2+P5OPj4WFt9
 u5QwcSu7simJFhH7Xuhd0RND108BGsihBgaSZWYByhWh8xP8LHeTa34v4wGh0am98ujj
 GtCq2tWnEAsfsdF2uCggRfyiff4/jsb3A0KAdVGgRlPeC6C8+/+kXpFutwoLk46rl1Y0
 nShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064815; x=1722669615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5C5CgAdWE/bEiG2q3uNLNwlN8pAqu5qqODBp3+y0Ovo=;
 b=GGQcf/F0u3Gm79FBvtNSGT0lFBJxJg3se38qT9FNAaYh3RLsHjVWPmFrBocLTzUQCb
 dMPQtiEOXwOD47ByH2/4Rmj3kklrQvKzmgqK6b6laBeni4+IhUMjn//khVQdSjSkl/Lb
 DwlWbFfgP/EmVZ6moEs28rRo04zrapx/FJ5oqNFztsNH1QkcFY7/uTnSK+fPWXTaY+M5
 grtQ4vADR92izYFJcIfVz/Spjc8PtTX+fPdIN1k3qUvVuMsTPzgdSNOXHL4uhhjf1kF6
 Jm1QYL3PEiLr7bMwJKV/EozLMIHKNgaV40O8hXwXFSsY/vKlXKzJlpj98fjNUeQ7/l2K
 V2AA==
X-Gm-Message-State: AOJu0Yw4r3SbOdAGryyepoDHKmgrYytz50NhP0hM8dbzbMl2pt2BJGEl
 kiUMvCpLvJ7fFFPB4MjNaJg3J5fdBm1K1+DgWeFQiPPc7kCWmLl/1n6Wf9UyKKeNUfL6M1DxInJ
 ccJE=
X-Google-Smtp-Source: AGHT+IHQPr5S7ZstJou/cFWswTTJvWY4gSLcXwwOp0o1KQZuCvkLeDothm8N3/Bwr/NuR23tO+ONOg==
X-Received: by 2002:a05:6512:e99:b0:52d:6673:11da with SMTP id
 2adb3069b0e04-5309b2ce6c5mr1164608e87.57.1722064815110; 
 Sat, 27 Jul 2024 00:20:15 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:14 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 06/17] acpi: Add define for GTDT
Date: Sat, 27 Jul 2024 09:17:07 +0200
Message-ID: <20240727071742.1735703-7-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

Add the interrupt flag used in ACPI GTDT table as define.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
---
 include/acpi/acpi_table.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 0de3d3f439..19771c133a 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -707,6 +707,8 @@ struct acpi_gtdt {
 	u32 virt_el2_flags;
 } __packed;
 
+#define GTDT_FLAG_INT_ACTIVE_LOW	BIT(1)
+
 /**
  * struct acpi_bgrt -  Boot Graphics Resource Table (BGRT)
  *
-- 
2.45.2

