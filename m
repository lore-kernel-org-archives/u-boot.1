Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97494EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 22:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099B688CA3;
	Thu, 12 Sep 2024 00:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BN1CAmDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06373892E5; Wed, 11 Sep 2024 19:39:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A69AC880E6
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726076395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WdnJNVqZrddMxmoBIBgxFSLdjzvvS/hEi+xtb8SllO0=;
 b=BN1CAmDZcZHbNdWJpCq8Blj2Lc9YwqPi7rIvwd9cPyXPLPTvxhXO1lrzyeFo9B1MpaPqZd
 TV0cWQ5xKAGXGYdhIODR/Zr1LKHp+VOibaKwDXXpS4ltDJc2BCEKpxS/Zd3fllgD3nCsc0
 07RN4eLx4i9O6RXGeveE2HKTO/J045I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-CZojIdg8NMuTY_WDHqXYOw-1; Wed, 11 Sep 2024 13:39:54 -0400
X-MC-Unique: CZojIdg8NMuTY_WDHqXYOw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4584bf37e23so200271cf.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726076394; x=1726681194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WdnJNVqZrddMxmoBIBgxFSLdjzvvS/hEi+xtb8SllO0=;
 b=tOvbYPwjDsBDPh3AwY/vCIrK3LoqYitKtp1JiUK609FKdGC9BJgdO3Kil4XzTDSpgk
 aPWeyffpL3ob6FXQaIUBBDHEax+jUJjm46Y7/rz071YH/GIIhohNNZdq+r7HSdNAkhFh
 5+ThDdt2htMStGJEEBLgLS9p2PmsUt3bw2RmFpmWFwF/MNTfWo1wffXk5gJhZ7UjJ3TW
 nL38aXpOBpHvrPJa1dKhfjcqhfREBw/LlVCxGjx2wSUBMo2hdak3/NBiV4bfhmGrA8o7
 uitIei3OnUN6fFjh281XeUvwme85OtrtZykcv/P3Q078n4tfyd03C0cKkFJLehkTPjCd
 ZLCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCqTS5qvyWHmztbV3vSh8C8iz0ohYItrXpSIk9yfAS19xAEsfq3thbhSb/xPd/CQC9eDRg7jg=@lists.denx.de
X-Gm-Message-State: AOJu0YxT6gp9M9BU82cEYnG1REaNLkKFcY7mYNUMYUEwKj4WBgLTpLw/
 u6c6k/y+IG1H6vLknuiIrh6GXWKnmygatJ0379GLK5bqxbJkjG0eqVlk4Tkfx5pbBnQkKA2VTPV
 5sNP3xljOy4uCxg7pi2BhGT68fi0NuDvIUwr2H/r9KygtgzmiKI8=
X-Received: by 2002:a05:622a:28e:b0:458:3766:964c with SMTP id
 d75a77b69052e-4586032d392mr1783391cf.30.1726076393650; 
 Wed, 11 Sep 2024 10:39:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP9qR4C8vWou8iCClvo2PBVO+FAdvBh7si/4qfgvYHXl6kq5WnsGTAxjRLTYmdMbQ0rNRmug==
X-Received: by 2002:a05:622a:28e:b0:458:3766:964c with SMTP id
 d75a77b69052e-4586032d392mr1783031cf.30.1726076393249; 
 Wed, 11 Sep 2024 10:39:53 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::33])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822eb0027sm43663781cf.53.2024.09.11.10.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 10:39:52 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 11 Sep 2024 12:39:47 -0500
Subject: [PATCH RFC/RFT v2 1/4] arm: dts: k3-j784s4-r5-evm: Add the PMIC
 ESM node
MIME-Version: 1.0
Message-Id: <20240911-j784s4-esm-enable-v2-1-957f56b588d9@redhat.com>
References: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
In-Reply-To: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
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
X-Mailman-Approved-At: Thu, 12 Sep 2024 00:03:14 +0200
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

