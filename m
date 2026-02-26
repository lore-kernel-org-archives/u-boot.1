Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2973BFC5930
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 11:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6685583AA9;
	Thu, 26 Feb 2026 12:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="y53sjs96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC0183E85; Thu, 26 Feb 2026 12:11:53 +0100 (CET)
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C9383642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 12:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772104310; x=1772363510;
 bh=al1p1BQVR27ZwtSeK6z7OwfwiRrq7t/lIVk7bNZpkhA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=y53sjs96vS/utCB5xkPYdCa37kxM/Kd0cmYXAIh5GMh5CHbIRuVezGQ9hUYXcxcjG
 QT+nPV+m7YZaaYw5gFLO3RSEKccmBWYoKYkXguK3IHjVh0qtzUls5UbZGLWi0Ab87W
 SLT8pBLe2hdsT1eQBjwbfa+xIycHbNw1xHBqQfLGoPzl6eT/DjD6ok9JZP9V93F4UP
 RzrlqkuYliQGWmmXDwgJ45uuh0hGXCyH2nnZ/0vlU6xbZDJ9SP3IFcVRGvoRt4r6cE
 6iOMYWs+7jlhZLuFeTkqhWIupv5FIGJP/BZ4GjxvJ0A/a9y6f59MRTLSvakB9qRoiY
 EIgP7S1KctuAQ==
Date: Thu, 26 Feb 2026 11:11:46 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 1/2] MAINTAINERS: Update ARM SC5xx
Message-ID: <20260226111136.354009-2-philip@philipmolloy.com>
In-Reply-To: <20260226111136.354009-1-philip@philipmolloy.com>
References: <20260226111136.354009-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 70c2e5c4dd46abb1a94f4016aa60cd86ec2933a9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

After years of developing the ADI ADSP platform, Timesys was purchased
by another company and is no longer contracted to maintain the platform.

Utsav is leaving ADI after contributing to ADSP SoCs for the last 3
years. He is a founding member of the in-house team supporting the
chips.

Linux support at ADI has been consolidated. Use the company-wide mailing
list and git repository.

Signed-off-by: Philip Molloy <philip.molloy@analog.com>

---

 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8d4f6ee8b2..920da147e6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -626,15 +626,12 @@ S:=09Supported
 F:=09arch/arm/dts/am335x-sancloud*
=20
 ARM SC5XX
-M:=09Nathan Barrett-Morrison <nathan.morrison@timesys.com>
 M:=09Greg Malysa <malysagreg@gmail.com>
-M:=09Ian Roberts <ian.roberts@timesys.com>
 M:=09Vasileios Bimpikas <vasileios.bimpikas@analog.com>
-M:=09Utsav Agarwal <utsav.agarwal@analog.com>
 M:=09Arturs Artamonovs <arturs.artamonovs@analog.com>
-L:=09adsp-linux@analog.com
+L:=09linux@analog.com
 S:=09Supported
-T:=09git https://github.com/analogdevicesinc/lnxdsp-u-boot
+T:=09git https://github.com/analogdevicesinc/u-boot
 F:=09arch/arm/dts/sc5*
 F:=09arch/arm/include/asm/arch-adi/
 F:=09arch/arm/mach-sc5xx/
--=20
2.52.0


