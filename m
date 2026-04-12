Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C8AE93800
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC7383B99;
	Sun, 12 Apr 2026 22:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f/1lkjf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2F283B99; Sun, 12 Apr 2026 21:08:30 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3C08352B
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 21:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d7650202fso335862f8f.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776020907; x=1776625707; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=glS/nvvZhUb41hVZDQcgKJHELerAAQ/NlE60k41Bzdw=;
 b=f/1lkjf4osKmGKcjcCLFYd1l7CFqFbDeVuLWLRNFt4xR3OSCmoNGrb1bXB8loX+VJx
 oql1gF0i7M52KXfialaHhE0/Apy17AbWfqj8E9r/Hw1d+DncBO7VIJ/3OM1wrCopqh+q
 tzP6+QbieFOp/3viybem/k38L0EuH5d1RB5fYPX/J2kGj85PtzodHRinYs9AlRwImB17
 PgXNAJGOuP0vYyysd98PvOQ83jtrDwDb8fAyljo6jCKO3tqTYEcFUKh/5ldhYcK6NHuP
 ipWV/mD7J/P4OnKTxJrKdZDHaofMub0wm6TOvP9rdzS+Y/Ys1f2pZOFx+KQ9lJYPbbLq
 CMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776020907; x=1776625707;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glS/nvvZhUb41hVZDQcgKJHELerAAQ/NlE60k41Bzdw=;
 b=n98hkngpW+y6gcCc4lDGXLIx6i+ORKxMcl3QlDtBOB+sNSv0gKi8iMWMOE3pe7q1f1
 Su47xee1hnQ/obOgPHQV83keqUZGPjJpEZNMFC9ECAbSOmnJ7qI8usQS/KwSr5etGyiw
 PKcMUsGZaNGwK4oJd2pigPWkwSjxYM4zMEaAVtapW13mjv4O6tJOq0htCyAnoHUHb6oz
 o3c+hWIJgUUISvhOF1TQEldRunjOHDgR9YWfSyjOieh8SEViE9kMjZQ9Y41Q9ysi+pe8
 ZFsTKoptjx6ISjnmNfa1Stoh1bNkvYc7i8FyLZKeQ1Q2nucBN1ns8OxYacDcKS/Gcbcs
 tbMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97zqhbDpCGGnFbNXvuVhd7QI2Z7CiicSfOXdAA0GFndMtalgrAXMmmiOrsnmunezQg2AGkGfA=@lists.denx.de
X-Gm-Message-State: AOJu0YzGP3ruHWtfbd13MkuLb3MNGkpKQpqAqdWwKvl0XsB2cD4+4M3D
 ImS9zg58tob2QHWnpeTp6vnXMTQYFJzYrKrkjjKJvP9nKIPUi+6N8lz/
X-Gm-Gg: AeBDievEHo/ekhtgb4Fcjzd9VRuHcjOSbBwqWYX8pY6SC9dMETjDf7yWe6dRjXXtoFz
 ruXxG1JsNwKlvhC/D6YPcbBaDMEkuKAyqk3A0TmziXoOjRWFIbIOMBFrP2qxcXnQvEJYwL5zFIi
 igXhECSvLM8Y1vlfCaAcQZ1WIRSqro/y2I9Hr4Pc4Jv+7DUjUUZYng56CwjcjAe3H3NG62AMANP
 RmHQs7Nu589SynmSq0zzNayj3Cank60oT3oJ6yLaMEoN4dzWqWBWgMs6eAu7VzxWXGPUA6EtUKg
 RYXk9h54cfrwMpIsGbQkQyj1qrohnk34JvAJ3pMiposP6rZw5lUUd53HZxjwpq6+s7vs0P6G0RH
 WpviFK1c3cXzrcqor77Stcrg0ZGfxT4a7dMelwZKkdG6x5//UjgbO7hWllPZ/J6Vu84xGoCo4fH
 kzjxVwLuR+/U2xIgpnjvHnXjD+
X-Received: by 2002:a5d:5d12:0:b0:43d:613:33de with SMTP id
 ffacd0b85a97d-43d642a63d1mr15188854f8f.20.1776020907254; 
 Sun, 12 Apr 2026 12:08:27 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d73b44b3esm8487333f8f.13.2026.04.12.12.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 12:08:26 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 12 Apr 2026 21:07:58 +0200
Subject: [PATCH] video: stm32: dsi: fix unchecked return values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-master-v1-1-d7a8e742233c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mj3dzE4pLUIl2LpFQzcwszs1QDSzMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AxtE3bmoAAAA=
X-Change-ID: 20260412-master-8be67866e096
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=rgallaispou@gmail.com; 
 h=from:subject:message-id;
 bh=ZF5uHX2CbcTIGuyN0meT8DGgNQWE0Wup3xaGR3i4Afo=; 
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBp2+2QjxH0I/73m2jMc0v/H7HU7GhMUPq4ZNSvn
 DnhIxOuSHKJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCadvtkAAKCRDnIYpo1BLC
 tdS8D/9RXbtiX7P1DpeUdA6rn2tUQ1y0k3vAnKB81jFp+qR9j+XeEEzbwNGm25+ptfrYC0GqqoZ
 Mw5kfasxUkSNAuxG/vbxPJruTygg4AhFh5cCAYGmN7RY7bhyJpa3BTihHS+2Z7ChadjrfAxNwe6
 GVU+jsCnxIGoZuxZIzQCx4/hUMPbHO0YCrQFEkOUL/IFVr6dAzzYN9KCbptYp6tpmRRK9xmE9Lm
 +VIZ9F+SxC2xsyMmfRKLbLUB9MtlPBfcJm6H4GRF/ojVfO+X2ePHWqTaUBLM8C8tA9cfg0pE8Xk
 ZtbxKPqmhvRUQBS0xL27xs9B5pOuBgDxH10mlTNgS9/DnqJ8py3g+dJspZ/U2sYz578R7cO/2EE
 gCIYUtUTYMgq5nDutZtt2Sqssl+CWdPjAq9yI4WHlPqo2lp1YPhCsrfNx6UpDVpGcHXdymgIIg0
 9PJrXTZOz11JJuSc0OlBoPWajSNJbqICAzTklqKSkWpjpFJzeocscp/9DFKLvXV+wnJ3lc74EZq
 8Reax+PVY21J1fdkZhYBhFuAI7cHezHWZzSllxlu5NwFi8yGzJ717Z8+vxuw8q86w24+9YE8Cbq
 f35onhMLmWtaScen9eKLc0CcTVusV5aswy3p9R3gfWvIRGbr8bIkka5NL7h2vObU76FJuLBkguH
 l98Xhepi5moNF+w==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5
X-Mailman-Approved-At: Sun, 12 Apr 2026 22:27:06 +0200
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

Fix the following errors yielded by Coverity Scan:

CID 644836:         Error handling issues  (CHECKED_RETURN)
Calling device_chld_unbind without checking return value (as is done elsewhere 6 out of 7 times)
CID 644834:         Error handling issues  (CHECKED_RETURN)
Calling device_chld_remove without checking return value (as is done elsewhere 4 out of 5 times).

Link: https://lore.kernel.org/r/20260309212331.GF1388590@bill-the-cat/
Fixes: a6d047c0a86b ("video: stm32: remove all child of DSI bridge when its probe failed")

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/video/stm32/stm32_dsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/stm32/stm32_dsi.c b/drivers/video/stm32/stm32_dsi.c
index 65a91f5cff7a..5c4d8d2aab51 100644
--- a/drivers/video/stm32/stm32_dsi.c
+++ b/drivers/video/stm32/stm32_dsi.c
@@ -493,8 +493,11 @@ static int stm32_dsi_probe(struct udevice *dev)
 	    priv->hw_version != HWVER_131) {
 		dev_err(dev, "DSI version 0x%x not supported\n", priv->hw_version);
 		dev_dbg(dev, "remove and unbind all DSI child\n");
-		device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
-		device_chld_unbind(dev, NULL);
+		ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
+		if (!ret)
+			ret = device_chld_unbind(dev, NULL);
+		if (ret)
+			dev_err(dev, "Unbinding from %s failed %d\n", dev->name, ret);
 		ret = -ENODEV;
 		goto err_clk;
 	}

---
base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
change-id: 20260412-master-8be67866e096

Best regards,
--  
Raphael Gallais-Pou <rgallaispou@gmail.com>

