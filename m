Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CA2C982DB
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E74883942;
	Fri, 16 Jan 2026 18:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sj2IXrGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10213838BB; Fri, 16 Jan 2026 18:09:59 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01BF08389A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b870cbd1e52so329430566b.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768583396; x=1769188196; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xdjMtA2dfai1uG5ulxPEWTmPB65dRusFujUmCzj5J/o=;
 b=Sj2IXrGwg0U1sMGvv65S0zqp57DGXiWP37KuKtDZAqvUSQ+b9cm+lzKde/Gk4aDXWP
 sN8JretuFuGDsrPi1vohhj9A0lYCkJSmX5W6mkMnCS2O7aypvd6AKQnBv5zHAmc5QUkg
 yqtk2x2rhWB3Nbk9y4Vu/cAE1O73bKZltdPKHoW80l0+yMSogrt6JhueR9mz4dK+ZgPZ
 1uq1NbV20N7D1e0u1Xzf+pzBMqoc1qq1a0ULwKw1/YDgPu6lzHPrwgfqLb9byq8Aqk1I
 +dqV2+CgO9hHVIceZyLfV6dLFdYDBk7ix3lxRXTBby30w9hMHnXF0xY1lk1UUSM6CnJg
 gNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768583396; x=1769188196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xdjMtA2dfai1uG5ulxPEWTmPB65dRusFujUmCzj5J/o=;
 b=GznjaH8X5+aOmq7BU7jl+Lnw/5b5ZbW6kVspvG3M4k5hEKTFfoAMp2s1ZBzxsXuRxy
 daDEPNAAiI49MfTKqGYYd+0C4wGez8tzYJ6WLExsLIWg3/IikDH8s3oF6p6789GiHJhs
 7ko6OeQEJsDShtW9zHHuYpOoRbOD7PqeKoeLaStdEH7uXc4BOeAJWSvGEhMc9eX+KPBu
 m56k2dD0lQb71PxyOrItQVDMSdUvIQFzRDNm99DLuPBLgTvynpYlbx7KpClQ3BP1jSM1
 k/EOv0aSw9mINwtNFCQyEJ2ZECGMNZ3ktArve0HEuOQmh8T37Jx+mlmCwS+Z+cFVlUdx
 E5IA==
X-Gm-Message-State: AOJu0Yx8SfpeTEYBX7lXRwaTdFdVO5Jpn0SKcEauIYkRIyiqQIHZAZ6e
 Uc6zi7wtqRpL1+HnbpNrCT4BmNkRfmu+3UdOcSYWZHnUeGBEHi66nsJD+ChI0w0WjpU=
X-Gm-Gg: AY/fxX4c2TyPQIBpKqqFHaGTJUfR6Q/um/LMG5JT2/7HTXwrNFZt0dh7XtOp5kESFpO
 WzYLvfGgAJ8mejz//3VqlhimhP1aXdSBVm2awczw1sVin30DD8UMieHkzbaA5rAwBmkmkFSRMh+
 lFZW/52E47GTbcDVTXTYfeTzQ3OpHfb4DwvsLbQmgaHmB3QjVxdV6EUJ/nSkdRgE1QFo0HyvdSV
 HaX2dsTT+PQzTUBQZdnahc1xponh3nb6HxXJUtC7NHpOcYTv05zICNDMdR0ntMKPD57RnmJWVoD
 4kBTKwTQF3Zd9W4cRVzNk81RjqzGF3AfcEc/5vYk/ONVBTSfvOpyfxiIdTy9pE2+thSNQ60PX3N
 WKti7F2BYyM0PJjZKrtXH+ch09m4CiOGGyI8Bxa9Bv9BbmcdwnqDVj9RiGGUTBU2yH6fNszG10s
 PnqMouotP27Ce/H3KHqwU7GIyMpLChCeIZSAO2JmwDymjVLvCQO8lbXQ==
X-Received: by 2002:a17:907:9454:b0:b73:8b79:a31a with SMTP id
 a640c23a62f3a-b8792ddad96mr333557766b.16.1768583396441; 
 Fri, 16 Jan 2026 09:09:56 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795c38208sm294912666b.71.2026.01.16.09.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:09:55 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 16 Jan 2026 18:09:45 +0100
Subject: [PATCH v2 2/2] usb: dwc3-generic: respect role-switch-default-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-casey-usb-role-switch-v2-2-83a1a6501a11@linaro.org>
References: <20260116-casey-usb-role-switch-v2-0-83a1a6501a11@linaro.org>
In-Reply-To: <20260116-casey-usb-role-switch-v2-0-83a1a6501a11@linaro.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Yz5df7TViWZc7RO65bz6fgWIBuZpfnls60bdMn9Gq1Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsysgge7DV5+6ruq9jq7OzjwRNT/ZLYVl9i/mM5RefJer
 t3/e4xGRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjITWeGf5al6i90bpw2tGdg
 mHSpqfjD8lVJMxgufH1x/HLEKRaugqUM/6xmZJz+/fWcwuqvCpMXnT/5M91e+GH25X2VPV9u7GJ
 Z6RUIAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Respect the default mode configured in DT if it is set and dr_mode is
OTG. This allows the board to prefer host mode even on a DRD capable
controller.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 22b9ef0b24e3..8893a33b9f6a 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -533,8 +533,13 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 	dr_mode = usb_get_dr_mode(dev_ofnode(parent));
 	if (!dr_mode)
 		dr_mode = usb_get_dr_mode(node);
 
+	/* check default role for DRD controllers */
+	if ((dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_UNKNOWN) &&
+	    ofnode_read_bool(node, "usb-role-switch"))
+		dr_mode = usb_get_role_switch_default_mode(node);
+
 	/* usb mode must fallback to peripheral if not known */
 	if (dr_mode == USB_DR_MODE_UNKNOWN)
 		dr_mode = USB_DR_MODE_OTG;
 

-- 
2.51.0

