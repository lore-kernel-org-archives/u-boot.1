Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4F7C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F378580E66;
	Fri, 31 Jul 2026 16:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OT46vQf8vSIf; Fri, 31 Jul 2026 16:35:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CC8580E62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515747;
	bh=DXcnbiolijZ45LBVCRN5xTlz95IIDPca0cujNZ30nnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sd7sz7qMb8jdrV9RTLt+gbGyHXnXImxV5vgy2hYdGFSwb3XOReR5p31GA01PhtnkN
	 /eTAz77q8Lu+KQ7GpzKnqybPTTEvWmj+bdIUjfSVJbgh1TnPrN75Zjds60MLIhmtgu
	 PGa5gEdM90pdKgjc4o6lOEbQtXwc5xNwdx+4QDswkcc92EDl9BXUvbM682iq3BGWw+
	 TJMSS2pfdQFVHkN5mSPg1UtzBxpIRrtkORHt6h/+ExFzH1AxSwbA14w+nlgAIOm3gX
	 BDDsKlDXaLi8D4Ys97gM3AV3LEq2vDAxxteWXajdEzZkQeTuJXFURzTkxcNqYO+aXv
	 PT3w0Ml5AkWcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CC8580E62;
	Fri, 31 Jul 2026 16:35:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5213069
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 500F84008F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ipqs-4oKDXR for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:33:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7318C40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7318C40025
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7318C40025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:52 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-738cdd667ceso293615137.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515631; x=1786120431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DXcnbiolijZ45LBVCRN5xTlz95IIDPca0cujNZ30nnI=;
 b=dWAGceXCZdoiYWC6ZPrgbOtoGnF38OXepMbP975Z+/sHt5TfiMdYDEquTwcBjdizKs
 H89mdhQ4Fk58fSjOKv+txo9i0wX0wfeplQF9i3q+S57QsYPUDnyLxx4mJDNhbLFmhjgC
 qJUmZjIf/vnpS6yHdCFWgGreiAxEfsmTj7YH8JSQucc4u5gXpD9JzNVvQBVt2skiPNRx
 JS6K/Pl9iR1o30pozaSEG7u4xQ2SdUuyvPyVAWuE4IZpd1LHNCSDMIZJeNJkJxwX6VpB
 cS0WsOaCbpicA2lejCqu4hXOdVYVwuBo0URhqKO1uYcCQOBjY4vKyVa66fU0nqbWSs1W
 ODTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNtsDhhIecBxyRVPupxcP1SdRgBPgr5q6mKempd9yhemik6FdkZiGmAbBL3Ft+S6pQiA51lmc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxixbsHaJymlWzAoC1PTApm/SBFnswR03We9bqNuu1enNRZTDme
 ZmifZL895hBRsct0udSOci/J+IqGjChWlBav0aSi06I6pgvZsxT6Z11l/wCQbt4Ws9Y=
X-Gm-Gg: AR+sD10Ef4ag1FY5sDjBnVHZ4M601tsJuCYpKMAsdWhrq8vHJfZrkLCZRNVUk8iZzyN
 ElBPa8Bx8VrdgOj46SYyuHFUTu9pUMFwM6fNf5scwTb8XmAq5ByiQHlVKawmZDGR97GBlQ5vq2H
 HBo+DEkDSH9b1YaqJfH4ltYnwo1mluJOZCZfKmMtC0vJWhH39QLu1H4SLQVoiQl1Gzmeb6cH0C6
 5MDd4Pj3I7mg//iUjLb0bsO3e4UZdWguAJxHJihuf71vAIxFB6aMl6R8zlB1emJmNw6lME0ZCq3
 bUjLPOepGNGZKP7pMWhKEyR64wxsL3CZZ5V/xjZ99kM6mwJG5sDNL/cmNm8zfEyl5oSXvH3nJou
 +s6f+5TGnDWSAXo/CgfGNxFyTLNgnIpkqUn18V5GpO3wkYxoY13yd4v/jNnMI3K8gZJ0N9kIyH7
 dPXEurKWh2d+tj+v+DQNSDsVVeuFG3oF9vO8oocO1JGTecgK4AtK4VFQ7Z1qz6pUR9fzSTR9jFB
 JtWZemYB6eSfXyGT7CPFizUQ1rPNvioioqXW+CRsDfqGNb0kNSLSkaxvsPJ
X-Received: by 2002:a05:6102:15a3:b0:738:be73:55e0 with SMTP id
 ada2fe7eead31-75b237677ffmr703783137.12.1785515631056; 
 Fri, 31 Jul 2026 09:33:51 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:33:50 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:30 -0400
Subject: [PATCH 01/17] pinctrl: renesas: r906g032: handle pin subgroups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-1-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=1720;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=zV+4C5G4X6AMh2BUvV3rAxoAcQGnNf37bzLtBsHMyfY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFx0lcacIlZuRIfh7RZQDXZbTsH9rw57QZl0szYZvawFn1W1N3RRGkh9d8lJ9A06tWkBGAXmspG
 CwSWQhgHpSQ4=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515631; x=1786120431;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DXcnbiolijZ45LBVCRN5xTlz95IIDPca0cujNZ30nnI=;
 b=D29yVYhQWwdFITeA24yLXbtl++B2yiPxbv0UZAjtqsLkD9vqbTjuhjNyj6vU85ETc2
 hbmGep/343KxQCrdOwJ8eTfga5IxpD7oJgn31OK9if09AX95N3OJUCIxI2xB4tFKlZ3X
 TQb9HviR5MRQxT2gz5CWmmtevsMoAVzmmRrp5dN9zt/5LYiBwUBszqGzFd19D8el5WxJ
 mYOb5tB2Ik6oS4ZNQTsY277jAap1yKr+fx6T9/tU2V/Wky6UPP7YIoWHoOdNRjc6qMdW
 gZvbcqyvYArxwbuhSdWxUxujnYLzswuxRkVAL6ozagdmwpZtvMRRxxK8iwetOpyUIdjz
 iMgA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=D29yVYhQ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add simple recursion support to the .set_state method. This makes it
possible to use subbroups in the device tree, which in turn allows
setting multiple pins with different bias/drive-strength properies.

Fixes: e4aea57fa773 ("pinctrl: renesas: add R906G032 driver")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/pinctrl/renesas/pinctrl-rzn1.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index fdc43c8e714..8b13a2cea75 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -298,6 +298,7 @@ static int rzn1_pinconf_set(struct rzn1_pinctrl_priv *priv, unsigned int pin,
 static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	struct rzn1_pinctrl_priv *priv = dev_get_priv(dev);
+	struct udevice *child;
 	int size;
 	int ret;
 	u32 val;
@@ -317,8 +318,6 @@ static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 
 	/* Number of pins */
 	ret = dev_read_size(config, "pinmux");
-	if (ret < 0)
-		return ret;
 
 	size = ret / sizeof(val);
 
@@ -338,6 +337,18 @@ static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		rzn1_hw_set_lock(priv, LOCK_ALL, 0);
 	}
 
+	/*
+	 * Handle subnodes recursively, so that pin groups work.
+	 * Note that properties are *NOT* inherited from parent.
+	 */
+	for (device_find_first_child(config, &child);
+	     child;
+	     device_find_next_child(&child)) {
+		ret = rzn1_pinctrl_set_state(dev, child);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 

-- 
2.55.0

