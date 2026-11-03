Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD6606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cnZ4uT6c;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXFr3fLw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3A394085C;
	Tue,  3 Nov 2026 13:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypL78eOxKCmx; Tue,  3 Nov 2026 13:05:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 086204085A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711150;
	b=rdHYv4w+1NBb6bZxr0zVgjEg9EX3LbwQpuZ3F/CP96Ifd6gZ32U2RV4zJBwa/I/meSJr
	 r+Xvo9Ehsf37YU7wMIQ9RmDvXwQs4K3wr8Fm5nptqPrj0azzSgafZ9u0aFFpD1Tce2TRc
	 54NPFoy5J6fAo6rU3TysnodVIZ36AWO/j1KYmy6inSX2wKHuI9vinLipyE7JE/06/d+sX
	 mrB8YSMTzl3xRsXOwkAViCKw3pt1TAd3m7jiLX8W4p6n2FhEZODzW3GP+dBjW62+at9RX
	 VjKcpFHwhT0nDC2QXcp4HYVY/KM0xJbtJA6fUy8NUe1B/zzfWCSQ1ZuAp0CVATvBHGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711150;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=O5pNdtvJNXiYl0g6B8ZENE7XgpYvx8yQvZHm9DH/8TM=;
	b=skshQ+Zn4xL/l1xfdSk4mdSiTa9Jawl2kNWUgvod3+4aMaBCjBCiYDLjfB0htYwl0wAr
	 bDnk0xct/WVc9SC5nxUERs1RBerZM8AgziHtb+BT/FYQW+yRLT1US9Pkhp2N480oJ+5nP
	 r3xtsrSOJo50esDKZWhEckAhebd7JGLph2rGXvKokMZgJ9OKjfIWnLwNwsl33haNRCXHz
	 TMIPoPkfaT1kblR7RdCwXTeTla/o68XfW0qRwVlb58kdmPb75GpeJoGs1ejuTveyVZ032
	 z4k1qf+UKn1hUZWTCI+KPKtXsUgvZnXYcBTJ2sBepU09pA66F4YWG1B/Xt3CvMLrD6g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711150;
	bh=O5pNdtvJNXiYl0g6B8ZENE7XgpYvx8yQvZHm9DH/8TM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=cnZ4uT6c0BeVpm3zhjkCDp9FCLiX9C5BcEAD6rVhLFzlRAoxle23+rzelGlJkLfRp
	 EMhow6lVbANXaD0pChqM09zUGYO/3rrKavwjtkk6pcZ2gZo0mV7v8IP8+KXUl+L5Nj
	 TGMYsMZuIZ/W6noebA51hSUpB4bPaWo9bzh0mp0lbwAqzGIHH23Db0bQ/OVetvHfdC
	 zKZ2OQhC9Ed18ImkRQRwAtGqKZPrPdmVvwUqKNDFfVr7ubIhlMbX/O+KaiYpCCkncj
	 KR4SkghV3nC391ftIkOl28DBOInPGRv8vHwV6XJH0/LozdeHbRHLUgFLtgoH98f9I/
	 P7CXO48x60+3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 086204085A;
	Tue,  3 Nov 2026 13:05:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37FDB356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E4B360611
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YRqwfYlK-IDJ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D8A260670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702234;
 b=Hs1PGeL9d7+cV+b8clcAM8wFvbBFuBUsSPE8B8bmwcj1gXN/bv5/R74sykFbyzOH70Tp
 PV/gknlAJosCnakle52Xr8drLJk8rSn9IIj+M5XvLNcfby8YwO/tfG6eWSsAn+DKBhW1O
 qozzmRq4CQWh5+MWbpJrCKJpJBKYl6EybIhcTaQsWKGGX5wcxM67lwyDv50ebtl+bDbzT
 dzIP2i2i5EV/S7gMSYqA1+QPEiG7lscp4b9+arXyfaJTsbq/x4XL2OeH09VYUEUGMKrNs
 jqt/ZubycqwoRpVmcK11F1J0QKY5XJdw8L/3aTvDBcXwOpkoaI2yWR2wfBL4Kh30TuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702234;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=O5pNdtvJNXiYl0g6B8ZENE7XgpYvx8yQvZHm9DH/8TM=;
 b=Ws6iz/UAEQPPC0zrfQLpzEf7rTDQmZKLhN0ZNBz7E+LZu8f/kDL0Cjcw3X5Xpj/6Y4AI
 Tz8ZajjvKMr5Ky6wxOCIM9rWF0rPbupZLkFfTPhTpM6cS1QeQ+P5ptWbYJu/5RQ7f24h6
 5v3vD3tJyMrGVrWO4uUsiS4LDn6Ms55HwcUODfrpf+ix9nhF/ykF+apsTBBg6Uc+V3z9n
 1W4y7cFIX4NV0OWUGL6RulyX3HwBBh2nTZSOSq4q2cU6yK1BEXE1/gYhsMmxFlqgVGFMS
 4F40Tv8UPnY1PB0KcoJMwDewdu9XOWcMVjyfEzJdcIK/ohYP76ff4qYm3rRO7rF+RBg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GXFr3fLw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=GXFr3fLw
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D8A260670
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8284060546;
 Tue,  3 Nov 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793702231;
 b=wm8d4/JWWa2rw6j38xuqFeZvK2WOjMlRVQZPCWCpmlS1gMg88EzElY1+GutsU7/MHPGs
 VVqgD32A2WHVHA+RkdIsF9tUXtj72gGfPFQjzcrW6Vns7R+axxZdsgSCg4HAdgis1TxtZ
 1vX+bu1PjretphONRw2gzBILmNKbSdaCmdvB+TI6Ikui56df8afN6GKQLNLvg1dz2lL8p
 XsNomCJx0wf+KRlsSpV3izlu/xqvsDgu6jyHGBImiTEkUoZO36zAH8MGfRbajt4GxAHHx
 vaq9ik8pnDPDzqZup3bQL9Lxtv03kKHmPjh//61XI37HuwNXCehujbDfyX1YSBemLVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702231;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=O5pNdtvJNXiYl0g6B8ZENE7XgpYvx8yQvZHm9DH/8TM=;
 b=CBN0mCQ1JsMI06EtaR3Vtr381f5sMq+UvY8kMI5fEzSCVlOnqLEcVtR3zZ1qZPs9FdZE
 Vp3ZacyBYG7Ci4SEl8ZhMJDwbbx4vPbYRW/n38zghOkmJZLOW/GHws2I8APBjJ+YutiCp
 GqZW6JCKJxvXgMlzgj/pIEp4e9K4/8zGSqtfoOX/Zfc890XwaIxNzTK40Ld3x+HpVM0kh
 8luo9hfHRQ1iidT5uvVnx1jbD50SbhNtZdNrDZq5PZp/qHfMqHp5/Q+loArc/g7VvbMAx
 w0aRZ6+wvy20I2+hStWjN1zRjxQwvFymtJmbwsQ150xfTj0i5crJ+7gTSPIUdSY4Z2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6D6CE1F00A1A;
 Tue,  3 Nov 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702231;
 bh=O5pNdtvJNXiYl0g6B8ZENE7XgpYvx8yQvZHm9DH/8TM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=GXFr3fLwGjzWLM/syglFwvjcSZsdzNdf5XY2oYN39xiROoZhrQnyTFda3LSO7LxSl
 7X4xSWb1TznBKum5XmDQSd38LWnXHH45tWjsS7MORQB8zCbk3JCZRqLIhPOWx7kK8K
 90zbRqRiozMaz+bJPlnZGZ6vu8AklAu1Yh35bKTrMnvS/5CtS7g2HtUJKoCKx2zJon
 W2COxfFY21uDQBby4bfjmyV9Sp/4nio6CRVmtG5+ThDuaD9we5qJIxtHfJhxAA2OrV
 m/p9q90gZGgIeam/sYYmmbyW2hOXtYBevFn4V9mR9XGkikc0/0ffzF+BH4KYc+l+yA
 x3khHDn/SA2zA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id ED7F1468D8;
 Tue,  3 Nov 2026 10:37:08 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Tue, 03 Nov 2026 18:37:09 +0800
Subject: [PATCH v3 4/6] rockchip: rk3528: Split out common NanoPi u-boot.dtsi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nanopi-r28s-v3-4-ae8664fd168f@proton.me>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
In-Reply-To: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208;
 i=HystericalDragons@proton.me; s=20261103; h=from:subject:message-id;
 bh=TIxtOopOrGmSkxCMfGEz85CWNxKpg64WHl+I8dZuAlU=;
 b=owGbwMvMwCU8Ldb53x4TtgLG02pJDFkvdwZ/PRjYkN6VyHC1u37he8F++yj2q7v+tbxgmfOG8
 yajq6NVxw4WBmEuBlkxRZZO6c8Tvzy+MP3rzUlZMHNYmUCGMHBxCsBE2CcxcTLK+afUVl47va/l
 bej6S+sXuGTJZFTXCp2cdSCu8YTgivzOWv6HbscvNS659oh9W9Jap8Llaqs2y12W+XTtG7d1jZL
 XuwYmjks16VNvf7jCEbs0fe/nsysdVyllF16WsYnVNuBoOzjleZmanAf7Zbe9Xrr/rv2atk7RMd
 P5yM3zyoblT3Xvpn7LK3ktCAA=
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=5A3AC293DCEEAA41A8A3266A910205A0AEB09D84
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/20261103
 with auth_id=1393
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: HystericalDragons@proton.me
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: 安容 <HystericalDragons@proton.me>

The Linux devicetree of the NanoPi Zero2 has been split into a common
rk3528-nanopi.dtsi, which the NanoPi R28S builds on. Both boards use
the same PWM regulators for vdd_arm and vdd_logic.

Move the U-Boot specific parts of the NanoPi Zero2 into a common
rk3528-nanopi-u-boot.dtsi in the same way, so that the NanoPi R28S can
include it instead of duplicating it. No functional change.

Signed-off-by: 安容 <HystericalDragons@proton.me>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi       | 11 +++++++++++
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 10 +---------
 arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/rk3528-nanopi-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
new file mode 100644
index 00000000000..3e2fbd81da1
--- /dev/null
+++ b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&vdd_arm {
+	regulator-init-microvolt = <953000>;
+};
+
+&vdd_logic {
+	regulator-init-microvolt = <900000>;
+};
diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
index 3e2fbd81da1..151f1872fed 100644
--- a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
@@ -1,11 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
-#include "rk3528-u-boot.dtsi"
-
-&vdd_arm {
-	regulator-init-microvolt = <953000>;
-};
-
-&vdd_logic {
-	regulator-init-microvolt = <900000>;
-};
+#include "rk3528-nanopi-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index 95543b40dd3..d1810fb0528 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -13,6 +13,7 @@ F:	configs/hinlink-h28k-rk3528_defconfig
 NANOPI-ZERO2-RK3528
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
+F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
 F:	arch/arm/dts/rk3528-nanopi-zero2*
 F:	configs/nanopi-zero2-rk3528_defconfig
 

-- 
2.56.0


