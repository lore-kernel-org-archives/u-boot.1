Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B369D13C2F
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 15:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C9B83B27;
	Mon, 26 Jan 2026 16:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="fM2httz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46DC83EC6; Mon, 26 Jan 2026 11:53:55 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB77E83E9F
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 11:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 5ACD727090;
 Mon, 26 Jan 2026 11:53:53 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMgANn8J15Ao; Mon, 26 Jan 2026 11:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1769424832; bh=GfCjIQshrXA1Wz8e02SHvH4A+n/nAM9hKVmCm516YIw=;
 h=From:Subject:Date:To:Cc;
 b=fM2httz4WsaprsGg0TSxkCy/8QVeWaKYsty2QGNHkoVxMkLNxsWhZCISSZ8+0RWnx
 CngJmIveUWC+nCSRGkTZpSJlQ0fKV8lrSxAU0iHZUloh5/8v694mGSXhoRbCGi5LuE
 /lW5xUueFcDhjFtVHTmUg2grmq2OZEtiDIU8dg7klWn8qDM/ZvQPBSysykgdHCFW79
 P3A68rcd5dJXy2MKZSxWb0cnDx1kzMUGVBHVVU6rZ3bXw/Q9yOwvo4Ti8bHzmlRglc
 J8SJqNDGhTdNgQJuhFrnFZCoz3hny8ZEXVqZuJ8vtG2e8/+FC8ZPDV03wR85qxr959
 Ypvy81BDgQquA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/3] Add simple-framebuffer support for supported Exynos
 7870 devices
Date: Mon, 26 Jan 2026 16:23:42 +0530
Message-Id: <20260126-dtsi-simplefb-v1-0-0f7b65968299@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZHd2kC/x3MQQqAIBBA0avErBNUSKqrRIvSsQbKxIkIxLsnL
 d/i/wyMiZBhbDIkfIjpChWqbcDuS9hQkKsGLbWRShvhbibBdMYD/SrsoLxUHWrsPdQmJvT0/r9
 pLuUDrwgVFF8AAAA=
X-Change-ID: 20260126-dtsi-simplefb-c91f015e2e8f
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 26 Jan 2026 16:11:52 +0100
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

Since Linux v6.19 (and subsequently its devicetree-rebasing repository),
simple-framebuffer as been removed from upstream device tree of
supported Exynos 7870 devices in favor of Samsung's DECON IP for
display. Since U-Boot lacks a driver, the display is non-functional.

Add framebuffer support in U-Boot's device tree, which is included in
upstream device tree during build.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (3):
      ARM: dts: add dtsi for exynos7870-a2corelte (Samsung Galaxy A2 Core)
      ARM: dts: add dtsi for exynos7870-j6lte (Samsung Galaxy J6)
      ARM: dts: add dtsi for exynos7870-on7xelte (Samsung Galaxy J7 Prime)

 arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi | 21 +++++++++++++++++++++
 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi     | 21 +++++++++++++++++++++
 arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi  | 21 +++++++++++++++++++++
 3 files changed, 63 insertions(+)
---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20260126-dtsi-simplefb-c91f015e2e8f

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

