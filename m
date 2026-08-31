Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7188FC61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 08:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15EE1605F9;
	Mon, 31 Aug 2026 08:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zJkr8CTvxTx6; Mon, 31 Aug 2026 08:58:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788166695;
	bh=zTPmUM5Rr9URkDsRN1arhbnwLoDamqrYXD09FWXJZxk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o3fmcTpKU/9g5xdKX9m6bTNlmSzJsFb39rzeGleGm1Hm8WFaqmPopbByGsTmzEuQR
	 tqAKttI1VGP+ph5FpPtCf8ryto41+ptGMkePWVtKmcrDIyc3OVttBZardUIud+OpPB
	 HMQjD/tiH6lQ20bLS/ldcPqa1GYsQ3yJqmgu5zjWWGqGnAX+F5PvdQgbuNVgx2MRP2
	 ZaKxQDLoBCf/PffiE1aOGvzv2zgJuSJVr2M1txN8ivgpWCJaz6973rZ40poDJpt4/P
	 lSaQ40uBxqir4DiTdIsKiXBJRxg3z0JvhQP+ykQgm+SHjCA71KR5zuqtxwFv1DseEK
	 G7pqzcLrNEXzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6419B605D2;
	Mon, 31 Aug 2026 08:58:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0357823E
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD96C400B1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bNlZ7tpW-wXe for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 08:58:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=qB5kyls9
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 085444008C
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
 bh=zTPmUM5Rr9URkDsRN1arhbnwLoDamqrYXD09FWXJZxk=; b=qB5kyls9eydJB3y4U3jm4SBs0J
 6HO9WKrKqg4IdDmvDBK0oXDSZ6/w7CEZx5CqMUO6Ry6Ap3xAcGHPPiQ1aMdrF6Z5j8nvA1vKOtSVA
 gDwhO5Ivm8lUdkA+seKiGOU1rk3BIg7IShzsObmTisAnmVVVeZnG5ypJQF3CSHWlMGpAlMzZUG6Sd
 BfYafqAPyYNj7IVeb4qDinDY22GQHNvGf7KUsaUfCoJY8Ho3LetXP3SN0skm1YgibTP3Qk8Wgm0kN
 TpTvfELV3VBSAcOHdabXVyPqhaUarAjMPATjzKY8VQFWHWjtCCTV3AoeMqxGGISW3uo3/m09L2pyj
 K+bxHRDA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqD-000898-1C; Mon, 31 Aug 2026 10:58:09 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1x0xqC-000PRR-2d; Mon, 31 Aug 2026 10:58:08 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 0/3] Remove patches no longer needed with dts 7.2
Date: Mon, 31 Aug 2026 10:58:05 +0200
Message-Id: <20260831-revert_bootph-v1-0-f7ce897ded63@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1ClWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2NDXaCi1KKS+KT8/JKCDN3kVMsko2RzY1ODJDMloJ6CotS0zAqwedG
 xtbUAgZED8l8AAAA=
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28109/Mon Aug 31 08:24:07 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

With the integration of the 7.2 device trees, the boot phase properties
are part of the upstream device trees. The U-Boot patches for this are
therefore no longer required.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
Max Merchel (3):
      Revert "ARM: dts: tqma6: add boot phase properties"
      Revert "ARM: dts: tqma6ul: add boot phase properties"
      Revert "arch: arm: dts: tqma7x: add boot phase properties"

 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi              | 32 -------------------
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi             | 36 ----------------------
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi            |  4 ---
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi            |  8 -----
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi     | 32 -------------------
 arch/arm/dts/imx6ul-tqma6ul1-mba6ulx-u-boot.dtsi   |  2 --
 arch/arm/dts/imx6ul-tqma6ul2-mba6ulx-u-boot.dtsi   |  2 --
 arch/arm/dts/imx6ul-tqma6ul2l-mba6ulx-u-boot.dtsi  |  2 --
 arch/arm/dts/imx6ull-tqma6ull2-mba6ulx-u-boot.dtsi |  2 --
 .../arm/dts/imx6ull-tqma6ull2l-mba6ulx-u-boot.dtsi |  2 --
 arch/arm/dts/imx7s-mba7-u-boot.dtsi                | 21 -------------
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi               | 24 ---------------
 arch/arm/dts/mba6ulx-u-boot.dtsi                   | 26 ----------------
 13 files changed, 193 deletions(-)
---
base-commit: 856a00aeb61c1d4e7825257e54219599f8e34a6c
change-id: 20260831-revert_bootph-ce9b2c7350b6

Best regards,
-- 
Max Merchel <Max.Merchel@ew.tq-group.com>

