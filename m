Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD0FC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E95584AC8;
	Tue,  7 Jul 2026 18:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="XsWRVkND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A9284A3E; Tue,  7 Jul 2026 18:09:48 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA1A849F6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQL3BtCz19nh;
 Tue,  7 Jul 2026 18:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440586;
 bh=JjX61VuGI44+0I1j25HwBhGMe5qsMjIrUadI04Ak0+4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XsWRVkNDYeh6OMb2VdrqZmdK8wbiLAz51F0evaARmN3KYLL5FehcY/bOB4EONXW10
 rUqMQzNVqCM5cU+wu97ekHdBKawkoRMpnu9IhsVctH8yHAjLFH+Mi8r/pps5y/XnIc
 AwYOo53ionwXO8HCOLbclVrIJ7sjY5hM/w5hWQkJtJFnTNSCI+PhkyhbdLo93F39Jr
 KMt49X8do/MOBdMBX4ocn5bu5F6Gx0UdFQz+ntNFLjc5/r2zGpiD8ZULZP4eW90NSs
 ruaSPePiQCYbDnSxPxZMxyEVhpnYDyjj9TyD4zWu93+s9ySTB7WN8yv5vV6Lo853td
 eXEF3VpNkkxtQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQK3VMnzXhg; Tue,  7 Jul 2026 18:09:45 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:20 +0200
Subject: [PATCH 06/12] MAINTAINERS: add N: rk8 regex to ARM ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-6-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
In-Reply-To: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
To: u-boot@lists.denx.de
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <u-boot@0leil.net>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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

Rockchip also manufactures PMICs and regulators typically under the
RK8xx naming scheme (e.g. RK806, RK808, RK860, etc.) so let's match
files with rk8 in their path.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 393c8abde10c..97d5e8feb51b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -580,6 +580,8 @@ N:	px30
 N:	px5
 # RK3xxx SoC family
 N:	rk3
+# RK8xx PMIC/regulator family
+N:	rk8
 N:	rockchip
 F:	arch/arm/dts/rv11*
 F:	board/radxa/

-- 
2.55.0

