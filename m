Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0B3C54E49
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 22:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C290487DAD;
	Sun, 25 Feb 2024 23:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jHHDz3M8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2337087DAD; Sun, 25 Feb 2024 23:10:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A68C87DCD
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 23:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=31c0=KD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708899032;
 bh=uLUCnDRCF1oKgkt+IQkIs+YMRYojfElM7R4xzAe+Suk=;
 b=jHHDz3M8xYWeKc1SZp3KRvycf/ZB2dSQfU3RqwaB/ykOQUA4T5MSn48JY18ZJlW9w3htWCklg
 Bti8Hv3ikqIqR5K3rtJ3wxPkZj7RJlYQbYTecZC0Vj6iuHelrKYEF0kz1SjRUh3TyQarpqI9fR3
 b1BM5Iv/y5ud/1w3lziNwoeJQGTXoaW0KRZlFta7l0+SJw14QUxG8T717lZ+fNmtOOcQ3dbX/DG
 7ChwYZBdU0+Bdgcecx3fBh2zY1yj3sZnjKDBckip5Ro3UqSyRbZtj7Se6WMhv/kleP9TxSsWAsp
 YkB1xo8d0knLNVXHGNbC7wXEjIXPQGh+AX2ob06ozwbA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] phy: rockchip-inno-usb2: Write to correct GRF
Date: Sun, 25 Feb 2024 22:10:18 +0000
Message-ID: <20240225221024.1974853-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dbbad646c899733a83b3d0
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

This series fixes an issue where the rockchip-inno-usb2 driver is
writing to wrong GRF reg for RK3328, RK356x and RK3588.

The driver is currently always using the common GRF, something that is
only correct for RK3399. Remaining SoCs have USB2PHY regs in a different
or dedicated usb2phy GRF.

First patch changes to use regmap functions and gets the regmap for
correct GRF, from rockchip,usbgrf phandle or parent device.

Second patch reduces to only configure utmi_suspend_n and utmi_sel bits,
similar to how is done for RK3399.

USB have continued to work in device and host mode on all supported SoCs
with this series applied.

Jonas Karlman (2):
  phy: rockchip-inno-usb2: Write to correct GRF
  phy: rockchip-inno-usb2: Limit changes made to regs

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 158 ++++--------------
 1 file changed, 36 insertions(+), 122 deletions(-)

-- 
2.43.0

