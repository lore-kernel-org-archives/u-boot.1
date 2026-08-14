Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFB0C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 389B140C9C;
	Fri, 14 Aug 2026 18:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnbuFrTteKsy; Fri, 14 Aug 2026 18:27:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52D8340CD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732065;
	bh=/+u1+dfmXr9kvK5kLwz6zpWvYN6qCRja+KA6aPiI1rw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MG5TxROcr/jmISFp9ZugBnVTyqe7FYxcBHUa9/R63FPaH0hEfdTFx817Wss6Dj+4J
	 O/zminb1niX+EZ+OKCQIAZKkmRVMjEY+XbHahgPIMO4DE3mEog3B77kUU7xDUJ975J
	 6PHKYlAYyYsRS+FrZAO5i9Aef+A7NcaozLNdargc7/JBASNVPvw23SbhyQVeNlob8w
	 SIyNfOwFfJV6ZaMvbO7j1f4NUqNvjYqio+sAI/KYCuEzZ6HC/RcBR94IwZM4UIR4/t
	 VnzAf5nFIwrnBljpDftrxBGNjqGY0xZWpc1fO1i/h9jpY/7S2BCmWIG+GzpE5F5Oxi
	 BAEx1h4oy8q3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52D8340CD0;
	Fri, 14 Aug 2026 18:27:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58C8D2B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A97240CD0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqotMBz9T6On for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:27:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2D53A40C9C
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D53A40C9C
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=KsK8yUlv
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D53A40C9C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:27:42 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8f256eaedf8so11824186d6.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732062; x=1787336862;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/+u1+dfmXr9kvK5kLwz6zpWvYN6qCRja+KA6aPiI1rw=;
 b=KsK8yUlvNLo0xDrhE1S+VZ9hE1Y4r+mlU6XjWe1hnVZIdiexhgK0/gZc3QwWsECkSg
 O0ClNDnuf+SHAObVjgEGKU17vi8KcaOlheugVUpRy86gPVRyWddEV+JyFz5cFEKEeJxr
 ECVqCLxCjx5jXc+D7d/KywKq8sgnq+uox3s9c742H5nGa4wGH+8yZFSQ1JHKzGfR6/83
 7fRlCpk1JHqhQ91XJ0Sr46V1BgCFHCPKgesYx0QyU6NpHyu+9dv7J/lbBT+gIWwv6xG0
 8d9BD9kQf7qXfgShxP8rDFIqJgQU1VJkVZVqC7bGznNGqpUfi6nVcUR3gIqw//LBRXEo
 VAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732062; x=1787336862;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/+u1+dfmXr9kvK5kLwz6zpWvYN6qCRja+KA6aPiI1rw=;
 b=Y0c3HEcZWLPZ+96dEwWXsecmpQIn7DazVp9IbdKsUq6F4fUb26+Z5QN8QpB4/ydF97
 EK5hEdyQwEJH70unJ0r6x+SrcOq4CM2YsyOrXT83KuEc2pwtQoZOVHpZwqrpAyo5G+gU
 nBOZlD1YJ0boafNd0/VqJ5qXy0zyirtvUUBbxfvXcHAs3n3QQf9l6Wmev9PFBGEl7Bhi
 ytq6xlDjNGxbRn/idyk1ZwRK1pqZtAI6ioVmlvTXsgm8KBfSVnan5KsgiZkRyI+YorzC
 5TYJOfP+iArmXLqKIsjcyag8wqiVNTXja7/nYlqBeX9ga4z5nZ15rT0/zn3MWSpG+2vP
 v57g==
X-Forwarded-Encrypted: i=1;
 AHgh+RossPI6/wWqhT2FTztXcAuwP4UeyUDrEcqTw5MemA+HlTOeB/V/98BXHHzn7E8Hu9664lOrGLY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwmVWa3d3EnTfCChG7nk3L6OL99Jin6yMztPJ+RF/m192dj3ASm
 qWC45cu3ume1FPikCnkjBh6pwsOurqeuQ+bhyIn74vrpY8YEiqvSfjHwzsGxlK2hclM=
X-Gm-Gg: AR+sD13EUxJKqBtsPdMeqLLoc/0WIh4UQ1n3RX+eesNS6bwCKGcAr8tDufLQ1DNhr/a
 bF+QU2R5leuUS/Cvidqd+Aisg7z3Kh7ul9KmPJFYq+GZgH1j+CSerAn2mtINOC2QHFdyOzq9Tp8
 Bn8Z5CW7t2gdR9IhVuSVm+U1smRdnW1ZsDrP2mvKmK/p3HYFx9OgcNHQKXmtRumFYlQSDPgijx8
 RBxqX89nhcvtgUdZh8oOmh1qPq3mSpis9CGzrytLaSqpvLW7b9RrA4qwTSmNlJZqNXfC67VrsQ9
 pFaUhUU9UWsIwHwVgWUaozfWJuV3EFxS9rjGBmXYExKgurXZ58Djmh/SY2xzUuM9pgiRPbJM5hJ
 Pe4kKtc38p0z1z7op9F2nGH6o0ekviIiC64VBGXMes8c4PxF6SzRbEb/vP/pJ/I/RaeKdEQJbyS
 OfDnVZBGYnLTKIjiKToh512oXIgniub9uWa3lkJz9CxTiI+cLGS+gkyZFJH2FOcfcRIxrOcZaMk
 RE5FygzSu/QL5veoTVeNFJF8VzxKsCNNRjhskxgAwDQ1i9YG4lwmv89
X-Received: by 2002:a05:6214:19ca:b0:908:9036:9288 with SMTP id
 6a1803df08f44-90a91cf1455mr85643586d6.5.1786732061669; 
 Fri, 14 Aug 2026 11:27:41 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a935a2bf4sm22157496d6.49.2026.08.14.11.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:27:41 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:26:51 -0400
Subject: [PATCH v2] pinctrl: renesas: r906g032: handle pin subgroups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-pinctrl-v2-1-95dec872b1ca@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOpdf2oC/yXMQQ7CIBBA0auQWTsJpUlRr2JctDDUMQaboTVGw
 t2FdvkW/2dIJEwJriqD0IcTv2OFOSlwjzHOhOyrwWgz6HOnUX6xwyasWDi6VV7owsX6fhpDry3
 UdBEK/N23t/vhtE1Pcmt7QSl/WK7RY3gAAAA=
X-Change-ID: 20260810-rzn1-2026-10-pinctrl-cf97d3baf307
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732060; l=2059;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=3MgsMoWl5XO9TTAKUGIpE9Gbhcm50w+qYjoUcH/flKw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCs+3Y3oiaxRtm3SWm+GBVz7Nci+mvgbuvD2wCO6566AegYoW0qMSVsv2/HesM6EW6RxboHiePs
 R9L40SN68XgU=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
possible to use subgroups in the device tree, which in turn allows
setting multiple pins with different bias/drive-strength properties.

Fixes: e4aea57fa773 ("pinctrl: renesas: add R906G032 driver")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- split out of the series "Renesas RZ/N1 additional drivers"
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-1-af2ce80db9d8@linaro.org/
- fix typos in commit message
- use device_foreach_child() to iterate child nodes
- move recursion to top of function, ahead of the early return in the
  case of no direct pinmux entries, instead of removing early return.
- dev_err() in case of failure during recursion
---
 drivers/pinctrl/renesas/pinctrl-rzn1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index fdc43c8e714..6c8d40e9639 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -298,11 +298,24 @@ static int rzn1_pinconf_set(struct rzn1_pinctrl_priv *priv, unsigned int pin,
 static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	struct rzn1_pinctrl_priv *priv = dev_get_priv(dev);
+	struct udevice *child;
 	int size;
 	int ret;
 	u32 val;
 	u32 bias;
 
+	/*
+	 * Handle subnodes recursively, so that pin groups work.
+	 * Note that properties are *NOT* inherited from parent.
+	 */
+	device_foreach_child(child, config) {
+		ret = rzn1_pinctrl_set_state(dev, child);
+		if (ret) {
+			dev_err(dev, "failed node '%s'\n", child->name);
+			return ret;
+		}
+	}
+
 	/* Pullup/down bias, common to all pins in group */
 	bias = PIN_CONFIG_BIAS_PULL_UP;
 	if (dev_read_bool(config, "bias-disable"))

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260810-rzn1-2026-10-pinctrl-cf97d3baf307

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

