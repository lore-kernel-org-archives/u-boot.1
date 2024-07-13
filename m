Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332D0C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 19:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB348855E;
	Sat, 13 Jul 2024 21:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720899268;
	bh=5/xVoTb7aXGA83NmGR7+pYVuMbt6Npx54W/W8CGSBRA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B8OGaqZnfmPtoqU2BoeWZnHe8JAlnemb2SQGUjq9Uy682/lZ8kLaeR79kSeveX0on
	 U3vPTolnIQvMAxmrzaODZzhvdRa03dQ7NkkgDCK/UA1+odd9c2SogwAco/nE1gCmka
	 3O9wCZdsgjODg0bBaCC4jC+sxnEFJwKHSHuoNw8qogdyIPT0bzXohImavdTxNrGNim
	 tEBS86jCEUw4vNltkstN0f5rqbRsuk6+F34hqx0t/Q84Cl04dP2E+Ctab5g2elL3FA
	 pm2e5GssKlyr/WTMHYsIS2D3YAGJY4K41k44B5rL2f4qlWAkXeDg2+Bw+cm0oiiV2v
	 Gys9MnXWGd6kw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E1E85884EA;
 Sat, 13 Jul 2024 21:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720899267;
 bh=5/xVoTb7aXGA83NmGR7+pYVuMbt6Npx54W/W8CGSBRA=;
 h=From:To:Cc:Subject:Date:From;
 b=mSOTwIsDScA142Iqj9VPNLnjpwyQoBinz71iQxdPkbIO95TrfaRjHLFkqKt/XFWdl
 I9qsq6Z9uEfxsjGL2cDgv4+mldNRMVR3WmmqrZu99AQoO/nBdLvbFYukZyQOjrpi+h
 IYc5NEjWvDvLuzGSNWxtjIr5vl7n6qpFI26mqB0KWLNPclpvDujZnfKkRgYrivGU5d
 E/Ey3HKGv24lGsxW+M5GgInrgEf/9k/mb8nyf/fXjhXhSMRpKuZaB9qWs1+rWQfb2d
 8w9TxrZeO4ol+VPX+GBu/XPLZQaUM5BedGZQ98A3wPgbP6o6rS3skRbk9Yj6lkeSNA
 1pyGtS4IGmvdg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] u-boot-usb/master
Date: Sat, 13 Jul 2024 21:33:49 +0200
Message-ID: <20240713193411.122539-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

The following changes since commit b182816c1fb436916661949213c543bf4d42250b:

  turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 1bd136715a4d3a8e44ccbe693e4c2a9010efb342:

  eth: asix88179: reset during probe (2024-07-13 19:51:16 +0200)

----------------------------------------------------------------
Caleb Connolly (1):
      eth: asix88179: reset during probe

 drivers/usb/eth/asix88179.c | 6 ++++++
 1 file changed, 6 insertions(+)
