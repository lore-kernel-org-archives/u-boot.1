Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D89EE57D7
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 22:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DD388CBF;
	Thu, 12 Sep 2024 00:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QfwPSA2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED047892E5; Wed, 11 Sep 2024 19:39:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34816892EF
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 19:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahalaney@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726076396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKj4gj+mLm48VzuVcbI5qB3vxWmF9mZi85v6Xz4Awtg=;
 b=QfwPSA2hVmFGl+8NPHy5fVHhnm9S6BgaF0NI7uklv8BRClC1s2/FfO+1bx7MmQWQ802tio
 7fvpUVbZiYlrMZBRv6Rk5+tFvzFJacEJiRnjPZedAKZJa/pSDO1AUueX1n3OL3VfmcLV8G
 ulrgnIC9nx+odAl2xNQe6ypjRZyi5fQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-RPmGz9YGP5qUeeRS6uwEqw-1; Wed, 11 Sep 2024 13:39:55 -0400
X-MC-Unique: RPmGz9YGP5qUeeRS6uwEqw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4581d371964so159071cf.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 10:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726076394; x=1726681194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKj4gj+mLm48VzuVcbI5qB3vxWmF9mZi85v6Xz4Awtg=;
 b=M3HCgOYTV+Fw/D6KV4ENTSispUm22P/Kdp56r1TlIQENaxW/xBLn5g5qsxxTm18zXo
 EoiiZDhhXm8bgXlfBphS2fXPQdvIfkmn2L0aszptxfiYNz/QxyW1P/tJqONj7nJDA8L2
 /9nII8nP9B68cR4YF+QkcvCH3YHE7RmRn/oH2VFxFGeKfWGzMY8qJpDdJWC/xCq9LqJr
 wPmJU7GM3Iu9FnC2KXOqDSDe/r3NzRLEOp3QK28F6kGs04+eFrr6rR2rQvNWj+OQ/+XV
 bwf3RqIpnX8dI1osjKJwa/zpJoZfE50niJuoYW7mk9AUCp1McY1lez31t39GeAB+EbTC
 6Z2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjgcZaAIPpJzDcZhpyL3C7PF1a5Gw4zK9i5VqnkiXU2roKFai1h35NlEWRVWDfWIPYbXgFHSk=@lists.denx.de
X-Gm-Message-State: AOJu0YzJHV+Eo37KMNOkNGqSDuLmSflqzKur2HxnrFntOE+s1dUqo8Bp
 MDvlTvX3Pie2mhow36696VdGXpaUTdVJyM0e/bwnazwgtSGFahh5Eue3XZ0c1eP8C9OmxgrXe35
 2bhbsHKcNB2frdViWBT88v2+n7h5kAAGRQY1cdwwgZhaUylkQY1w=
X-Received: by 2002:ac8:5fc2:0:b0:456:802c:a67f with SMTP id
 d75a77b69052e-458602a9264mr1567071cf.3.1726076394575; 
 Wed, 11 Sep 2024 10:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwjWXrOJ/WcZBme6ny4qrY413Tu+epPO5nvXMC3/cuaR50UVkOpKYb6mqOqt+kifM2Mxqx3w==
X-Received: by 2002:ac8:5fc2:0:b0:456:802c:a67f with SMTP id
 d75a77b69052e-458602a9264mr1566891cf.3.1726076394249; 
 Wed, 11 Sep 2024 10:39:54 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::33])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822eb0027sm43663781cf.53.2024.09.11.10.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 10:39:53 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 11 Sep 2024 12:39:48 -0500
Subject: [PATCH RFC/RFT v2 2/4] arm: dts: k3-am69-r5-evm: Add the PMIC ESM node
MIME-Version: 1.0
Message-Id: <20240911-j784s4-esm-enable-v2-2-957f56b588d9@redhat.com>
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

Add the PMIC ESM node which is responsible for triggering the PMIC
reset.

Suggested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm/dts/k3-am69-r5-sk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
index f177f563527..a7738c0f948 100644
--- a/arch/arm/dts/k3-am69-r5-sk.dts
+++ b/arch/arm/dts/k3-am69-r5-sk.dts
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

