Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19E9E71080
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 13:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCC888906;
	Sat,  7 Sep 2024 15:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Vna4nFQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7468D88D5B; Fri,  6 Sep 2024 23:25:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387F688D52
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 23:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725657913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WdnJNVqZrddMxmoBIBgxFSLdjzvvS/hEi+xtb8SllO0=;
 b=Vna4nFQSISa2mPQw02pGf+MGmkMDpGxQCNH1kvqiErx8rDBxJmsYFfNXtVjlNRsgxY2sND
 15d8e0ggf/WCA7nCKf/wo5Kitw8o18glH6/3PAMJCCf6B+hEG02UOyG+1u7HMU/vju9Omu
 mlWZCScvRGyjURiWlGuJpN1HcoHGvQM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-yXfbrayBNRGkIzs566Ih7A-1; Fri, 06 Sep 2024 17:25:10 -0400
X-MC-Unique: yXfbrayBNRGkIzs566Ih7A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c352e8352eso31478346d6.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 14:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725657910; x=1726262710;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdnJNVqZrddMxmoBIBgxFSLdjzvvS/hEi+xtb8SllO0=;
 b=fbNr2EyLaCnSyqcE2nfBuDHGc+CXb3whNYawyo2amCWwoMg/M1Xd3QlJPRRbNBtRCY
 dxAIWZLlmk5ViNVwAIhS0uwVbxCwXI+gVcvMR/+O0UPO0dP4P1oSrfkABgx9d6rcnksk
 GyF4q7+gv7AnPYuCt2+drk+2b8HDhyWZr7zHscOGLIzbY0+9l91gpYaNboLewC95+/zM
 tZqtQQjfNLN5DLAYm8Q1uB/epZGTPZsNRlxbnOpr4pvl8mIQWpEQCQznZfRtIk+OytAH
 LLiHUCE3p28CpUy3IYj05cT+E4oOd/4UYz5rrxD2bu8qFI+rq9E2Sbl9f3xYvmm52s+G
 PQqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm5zVkONGDG0JZFXhacZEBHS7KNJhOHQvFzRL+I3iRGU+6zjs5v5QsCIteRPOmiNM1DH6elgI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw/3nj16vmEPMT2sifrU+yoL6mLwwe5PEUj3Cmh+bdslFmNh93
 sPAeCykwHkG3G1/wAgb6E1hofDhAEm4VCoP7qwVb1GaIoWBQWgJOIcT0dRUzOAMTCBazZIoEhIR
 ekvzr/orYzOwj/mXLUyoD19g8YNnfw/MYcnjs1iKj4CcaPfGE5AM=
X-Received: by 2002:ad4:4816:0:b0:6c5:2fc7:a626 with SMTP id
 6a1803df08f44-6c52fc7bfb9mr24825056d6.34.1725657910259; 
 Fri, 06 Sep 2024 14:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMtFa/cyTwIG2bWmf6I4+9JwZbPu1+otUJ8rbEhj9k5idLjWiUYzKL2ITYgAbOHE6N+Me4AQ==
X-Received: by 2002:ad4:4816:0:b0:6c5:2fc7:a626 with SMTP id
 6a1803df08f44-6c52fc7bfb9mr24824886d6.34.1725657909874; 
 Fri, 06 Sep 2024 14:25:09 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5203148f8sm19967006d6.86.2024.09.06.14.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 14:25:09 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Fri, 06 Sep 2024 16:24:51 -0500
Subject: [PATCH RFC/RFT 1/3] arm: dts: k3-j784s4-r5-evm: Add the PMIC ESM node
MIME-Version: 1.0
Message-Id: <20240906-j784s4-esm-enable-v1-1-b83b17d5a744@redhat.com>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
In-Reply-To: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
To: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, j-humphreys@ti.com, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 07 Sep 2024 15:02:07 +0200
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

From: Neha Malcom Francis <n-francis@ti.com>

Add the PMIC ESM node which is responsible for triggering the PMIC
reset.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ea82cf77031e
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm/dts/k3-j784s4-r5-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
index bef4573d3d2..7714ef87388 100644
--- a/arch/arm/dts/k3-j784s4-r5-evm.dts
+++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
@@ -104,3 +104,10 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
+
+&tps659413 {
+	esm: esm {
+		compatible = "ti,tps659413-esm";
+		bootph-pre-ram;
+	};
+};

-- 
2.46.0

