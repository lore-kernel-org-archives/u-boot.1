Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B07C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4B8880AC;
	Wed, 27 Mar 2024 12:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="d1un8ZAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB6488060; Wed, 27 Mar 2024 09:11:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE2E88054
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wefu@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711527062;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azw58eifUJbBoDQlTvja8OPfs7NMSPXvH32hMV7Ltro=;
 b=d1un8ZAamZhGyP1XQSXU/LP5TfcaquOtKBHJ1E0za9YZirYmI1UYE/iKfxFdDcQ+9c9by8
 3wc62uXnktxha82Yuh/pxrB2XVylxWquW923S6YTcbSReKyN8GFlGb/TwxBf+N3mRDn+Cn
 0N14zPhaAiOoHYeX/ob4BtXl6Q2u2sY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-f_AR6T8LNx2oBWkX1BpfpA-1; Wed, 27 Mar 2024 04:11:00 -0400
X-MC-Unique: f_AR6T8LNx2oBWkX1BpfpA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1e09fba31afso26422415ad.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 01:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711527059; x=1712131859;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=azw58eifUJbBoDQlTvja8OPfs7NMSPXvH32hMV7Ltro=;
 b=eak5mRAlzjjurSh8fggYD4P54deDdnm19sOzd0qG3v/EFJC5giq4GEs58koMKBKAnC
 ECISoiCmA5xq2IA3rcW6uoF4nyKal5ox0AvzwIpERBkbK49H6m4Yssaao8YuKdYeYtey
 s7zojE7xycNeZM8CMUDLIuz9f5zl4ci1Ep+nrc7lxj6vl3mB9JM3+TDP7+T1cAYmMVID
 z/PKsJ1TZcZ19FweldMGUG+hlr3oVLmfQRDAhKNnvElgQO/191lMXoP0g6FGKGvIEVkz
 QmcKFGCF81ecEPXtaNxJrE2ZHsinW0uC3WkjQksnI5zeHsji3fdWCOYCgnPvVjjrCYfk
 vfOQ==
X-Gm-Message-State: AOJu0YwQGr66RxleIcDS0vxVOFYXvXygDMk21GLKORlHxLYyQ9zOX2mR
 iNddNdUyZS9BGyBR98AcraLCivRYC5vatATlCN9RSwHZ1MjuzzONuS182gdl/+/8EJK3Q5O++Nr
 0n5L8ItvcRMyRBB0kQBio/wH6Z+zpDyAZ073XuCcNIUWZFko8ftCWQiAC3dvXDtS3tZ+wr+yUn2
 n0+f/dY1KCqItDFIwa2ldFjNgmSbPXQDUpZN0=
X-Received: by 2002:a17:902:db08:b0:1e0:cd01:9fd with SMTP id
 m8-20020a170902db0800b001e0cd0109fdmr552737plx.26.1711527058936; 
 Wed, 27 Mar 2024 01:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1Gw/Z+X4IH14MvkH8VcAeFIPL0mMeiwuyDGDi8Pg5o4UmCkIXTPivRYOLjHS/oVX0tgEDTA==
X-Received: by 2002:a17:902:db08:b0:1e0:cd01:9fd with SMTP id
 m8-20020a170902db0800b001e0cd0109fdmr552699plx.26.1711527058494; 
 Wed, 27 Mar 2024 01:10:58 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm8293709plc.104.2024.03.27.01.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 01:10:58 -0700 (PDT)
From: wefu@redhat.com
To: u-boot@lists.denx.de, bmeng@tinylab.org, rick@andestech.com,
 trini@konsulko.com, wefu@redhat.com, dlan@gentoo.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, ypron.glpk@gmx.de,
 michal.simek@amd.com, randolph@andestech.com, seashell11234455@gmail.com,
 peterlin@andestech.com, samuel@sholland.org, wiagn233@outlook.com,
 jonas@kwiboo.se, seanga2@gmail.com, baruch@tkos.co.il,
 kever.yang@rock-chips.com, sjg@chromium.org, gilbsgilbert@gmail.com,
 ycliang@andestech.com
Cc: tekkamanninja@gmail.com,
	tekkamanninja@163.com
Subject: [PATCH 2/6] riscv/dts: add gmac node for th1520.
Date: Wed, 27 Mar 2024 16:07:23 +0800
Message-ID: <20240327080817.44501-3-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327080817.44501-1-wefu@redhat.com>
References: <20240327080817.44501-1-wefu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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
Reply-To: wefu@redhat.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Wei Fu <wefu@redhat.com>

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-authored-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/dts/th1520.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index f7bfa42243..d68c446a6b 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -128,6 +128,13 @@
 		#clock-cells = <0>;
 	};
 
+	dummy_apb: apb-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <62500000>;
+		clock-output-names = "dummy_apb";
+		#clock-cells = <0>;
+	};
+
 	uart_sclk: uart-sclk-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "uart_sclk";
@@ -163,6 +170,32 @@
 					      <&cpu3_intc 3>, <&cpu3_intc 7>;
 		};
 
+		gmac0: ethernet@ffe7070000 {
+			compatible = "snps,dwmac";
+			reg = <0xff 0xe7070000 0x0 0x2000>;
+			clocks = <&dummy_apb>;
+			clock-names = "stmmaceth";
+			snps,pbl = <32>;
+			snps,fixed-burst;
+
+			phy-mode = "rgmii-id";
+			phy-handle = <&phy_88E1111_a>;
+			status = "disabled";
+			mdio0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+
+				phy_88E1111_a: ethernet-phy@1 {
+					reg = <0x1>;
+				};
+
+				phy_88E1111_b: ethernet-phy@2 {
+					reg = <0x2>;
+				};
+			};
+		};
+
 		uart0: serial@ffe7014000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7014000 0x0 0x100>;
-- 
2.44.0

