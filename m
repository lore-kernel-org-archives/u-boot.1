Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41D6CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 11:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE4A838C7;
	Fri,  5 Sep 2025 13:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="OhH/Xkok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A762838D2; Fri,  5 Sep 2025 13:25:12 +0200 (CEST)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07D2838C5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 13:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail3; t=1757071508; x=1757330708;
 bh=xDNxSpYVWdPsamlJe15+/6uLFHBY7QH/ppgM+hqu/+U=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=OhH/XkokfWor//+1/e2zmqsf6tJCqPYoUlPPZxc497vlOJk1hhy4pkuVTZdALTBea
 G4HJ4VxcMj9gmPionGXNY19P9xIqKg2+qNZDIE3tQ1+9wGnYjjNMbfc/Ouy3eN8+kS
 zT4by9pZNy8k2u6/dyDZN0hmOOI1+AYhrz9YxCDNSpqgrHEOA+kQY6a629lPlX9Wq+
 tV/YehVTEWfhBrzUbKYeuVe2RRYB4VwozJ1MdH0Hc7Rofq2F1s9DDsr6Wu3BF4uhDy
 lU6TKTjDdKz7ztD4iyJNZFM/xLoucGfsNqgVS90zth/uggqc13Ys0S3h48kPXaCoM8
 caXK11Kc1KXNw==
Date: Fri, 05 Sep 2025 11:25:03 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: [PATCH 0/1] Add compatible for ADP5587
Message-ID: <20250905112509.2443775-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 7a8a2a929d70657d6d2f7bd176b1bcc9ac288bb5
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

Rev E of the ADI EV-SC598-SOM[1] replaced a GPIO expander with the ADP5587.
This patch is necessary for the mainlining effort to support ADI ADSP-SC5xx
based boards.[2] Since it is generic we're submitting this separately, also=
 to
reduce the size of the series.

Note that this compatible string is already in the Linux bindings.[3]

[1]: https://www.analog.com/en/resources/evaluation-hardware-and-software/e=
valuation-boards-kits/ev-sc598-som.html
[2]: https://github.com/analogdevicesinc/u-boot/pull/10
[3]: https://elixir.bootlin.com/linux/v6.17-rc4/source/Documentation/device=
tree/bindings/input/adi,adp5588.yaml#L23

Philip Molloy (1):
  gpio: adp5588: Add ADP5587 as compatible

 drivers/gpio/adp5588_gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--=20
2.50.1


