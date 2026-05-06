Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC8CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A7C8499C;
	Wed,  6 May 2026 14:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mDlSYbwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B23E848CE; Wed,  6 May 2026 13:42:35 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9E38488B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 13:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoine.gouby@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso8092685e9.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778067753; x=1778672553; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=406cJPzKfc9o3e3oVxX/ucY83kiSfufshFfll6cQigQ=;
 b=mDlSYbwc5eNo01aOII2i1anxfluU0zM0cNDVQ8HgfVnnUw0e2IfNrpTMgtjuN74qXO
 ksHl402big/ajAQeznijUQsTzU3y1jIjtmVepcIM94esTFg3fLCocYdGHCuhnKxt9E0r
 Jh1fNwlns8ev6OQb+0TOzUWSHQa+mgDmFRiWBHLG0oGB8zQ0h/orZuW+i28FzTA9m1hn
 eHbjLDYwjKbW6lkak1+xf/k6LG92TqNy2nipxS7xHw3ztStBouINmy7lY5jBiTfdRYqM
 61Bl+Nz1Qu/Wd7I4dwqoz7OdRYhcjadYBDXKR+piG6rcUmAb3OknbU47PkidnP8NcMGm
 Deag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067753; x=1778672553;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=406cJPzKfc9o3e3oVxX/ucY83kiSfufshFfll6cQigQ=;
 b=Z/KAHQJEJW5UAdmva1jx85MSFBJVjCuhw4quZOlupsRx/sNdNL3lOh7MGdteLmYzMy
 R6cxBymqfwiWQdUM5QNwi66/iddAouy57DsXA1TgAswfcKQEnpjWqKxQL8jetObOPak9
 tg5pRB6L0IJ1xRpnotBmtSKALoB3ewadvcevf8G04aZ+ohI7gTMMtt4y2l2tgpS845nm
 YtcGeY742XY4ALhRyQhaurd/JC65CH/WkAxxeL+xeapC718BP4kPFGGVZJmKwg8ctTBY
 bsPDXzNfNR0wedwtQ5aITjHoHGHJek/GK0tY2KXDEycoeof0wO2B7+sOG0ZITMLBbQGm
 bleA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YLNiXK7KOJqy+HycrU1pstIivlApJ2eBYyf8Lmvu5keQzV+tFDt+jiRcqpmvBs9SawddRmqY=@lists.denx.de
X-Gm-Message-State: AOJu0YxuoiHjkENLWoFzDLtyrG8wDIJttE2RYU75v1RBjE2JJ4h/HXjK
 7mOGXlUEPnuH4nSHWXlQnGp894LZARl0tlUVn+7d8SPc+BpyGWSEyDUPXK++deSx
X-Gm-Gg: AeBDiesZb6V5j7/ayJEB/I/uVh2zdhsO/ElW4Npq7wl+fCDU6sDAdYPXyR/aiO5YhVL
 ADNEiNiz8fpgHqYLVEwiXvjt8n10jJLCClE0A/TudH2h+vQmCKdEcTMzcASrjdx87AZun4efoZU
 UTNYJwIkafpckJzfE9YPgoYh3bhsG4Q5gYwBfamgO5bYlzY1ZdNLXnJSsabs1HBgw1u2sRosDBd
 uaFKn0tQl/WI7QZo7oXRvZx1WXPlyHyd3fvu9uPdrYTBHupSXJHx+mrdZD7r7Osw7kgCea0Mgox
 09wur8UtkxNUrnbRQmG1IPcZSkpWeTTxz4L/Hct1edytE5Ow+CTeGSo3VzOkJdSATWoIwUPiKeX
 jkhWkMand+SE3wGKwZKCV7sWeUCSMMkGeRJzMqSl0zcuRAQDHhCYKlzUIPUmhiL3jzvZ/o9TxKo
 hz7ArewGaZoYfq98FPW1g6wmrbGR8JRheY7dHJ8qzvCqfycLpWq9p54Kv3dVWYCaxQlMo6OdoDS
 EOn55aHCB+A3OHWAjR8bKzFfGSd2yVUioftjoo5JrSV84Qmth6nyUiMQ66QNA==
X-Received: by 2002:a05:600c:3504:b0:488:aa33:dc8f with SMTP id
 5b1f17b1804b1-48e521f3938mr38954785e9.0.1778067752480; 
 Wed, 06 May 2026 04:42:32 -0700 (PDT)
Received: from [10.0.1.145]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53157734sm14458305e9.35.2026.05.06.04.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:42:32 -0700 (PDT)
From: Antoine Gouby <antoine.gouby@gmail.com>
Subject: [PATCH 0/2] board: toradex: imx95: remove gpio1 reg
Date: Wed, 06 May 2026 13:42:19 +0200
Message-Id: <20260506-v1-remove-gpio1-reg-v1-0-d5e09f936d90@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvQyim6SrSImmwWZShIIN49a
 /kW/ycI7IUDjFUCz1GCuKtA1xWsx3JZRtmKoVENKaMIo0bPp4uM9hb3wWJnmPq1HQYiA6W8Pe/
 y/NdpzvkF/k4so2UAAAA=
X-Change-ID: 20260506-v1-remove-gpio1-reg-45e67c388665
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Antoine Gouby <antoine.gouby@toradex.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021;
 i=antoine.gouby@toradex.com; h=from:subject:message-id;
 bh=UTLNNJpf1s1nuSPysOoxvE+JUOAtjxazoOGbLkvEpYo=;
 b=owGbwMvMwCWm0rPo7MxLN2YynlZLYsj8ramuPfGmp03+VU7H07Ey+xfYzWuN5umW/ix5ec82u
 46zRffXdJSyMIhxMciKKbJkPFEV5FMIkfXgaE6GmcPKBDKEgYtTACZyNoGR4dDFyKIHntIxpjHL
 1Cr5+W5lJy6t3dO9+9pP5m/mU7918zMyrO16fM3smPiE1rDETbnSGjWv/wZ0LWFtnvxI4uAReWE
 XfgA=
X-Developer-Key: i=antoine.gouby@toradex.com; a=openpgp;
 fpr=68E425110E20541D48088363248CA2CD99D2D899
X-Mailman-Approved-At: Wed, 06 May 2026 14:46:02 +0200
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

This series removes gpio1 reg from Toradex SMARC iMX95 and Verdin iMX95
device trees.

The RGPIO2P driver contains legacy handling for compatible combinations
that expose two reg ranges (dual base) for i.MX8ULP and i.MX93.

The i.MX95 GPIO controller exposes a single register range, so the 
dual-base handling is unnecessary.

On Verdin iMX95, the second address of the gpio1 reg node was incorrect.
When used, it needs to be offsetted by 0x40 to start at the Port Data
Output register.

Signed-off-by: Antoine Gouby <antoine.gouby@toradex.com>
---
Antoine Gouby (2):
      board: toradex: smarc-imx95: remove gpio1 reg
      board: toradex: verdin-imx95: remove gpio1 reg

 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi | 1 -
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi   | 1 -
 2 files changed, 2 deletions(-)
---
base-commit: ae8987f4e690f397f507c4b1efabd68b3ed08db6
change-id: 20260506-v1-remove-gpio1-reg-45e67c388665

Best regards,
-- 
Antoine Gouby <antoine.gouby@toradex.com>

