Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F387D1D492
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F338415D;
	Thu,  8 Jan 2026 21:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U9NpXdaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E428427F; Thu,  8 Jan 2026 19:06:22 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7488A84198
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-3ec47e4c20eso1997715fac.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767895579; x=1768500379;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v2KZlvu7SDM0puda+qwuFhCi2rTaX6/rkdSTR/IyPVk=;
 b=U9NpXdaXsFw8ntepKFmWfUdcermMylAlpv2G1QOmhaMK4BhdLNs31wgPOenZDdv9V4
 e7p3YYyENS47Rt8gnh82jH+AZRCf8ndoAEWBD4+Ynehzy+qwR6810MYeVB+w29EOZTIK
 Xp+U+ooOJDiH4WnoyK5d2vtPld5H4gKHF6fbp2Fg9QO06QTXuuEYgbR5LcZLVtPBmQpI
 LhyPmU9hnXviLiFTbMR2yg7P1eo3ODlcBmVphGs4ZsisZYeWWC3SiZknsNs6oFzoX3WZ
 hDzAV+zlFtsJMXiRSyOzLOBDdnYl1aabmYGO1yszWzC2Dh7Pj/8sC5ZXwxXoLHDwmA/4
 TRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767895579; x=1768500379;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2KZlvu7SDM0puda+qwuFhCi2rTaX6/rkdSTR/IyPVk=;
 b=rX3owCSDwgdmCC7jGIJWzCC20z0v5SOoLH2H2SIVABLC1W972eAFYlARwPhRVEgC5G
 bi/d3RQJQ1CwY0ct/17EYGItHheWNxK2Pv6Nn6lu5sPUGMHY+5Awkszn/fpHxKCDNDR4
 oohgg7eTWvbp/wzeE82NQOLECJiKe3WNoj3xcsjiGkr1yu+PskINZFgVJmYf8SEoCiwD
 zAsKRKXT0pWudfkpZGrAmiitaKRSVt9M0CYEcA2UPvGEJ30JssE5KmGw84B6Q+yL33A4
 9U2gkzbPwjoLXxh3XeZ7FM87felrvdU90+Qz41iUQ7Jjm1f77blsKWr5cIXEU5esKj2w
 tFVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRthh9QcCyII2BiYh2Hwar2j3JSSMf7SwfGcJFhdp1Q1OgVW7k9OzSfUIP5Bys2gesIhGKpjg=@lists.denx.de
X-Gm-Message-State: AOJu0YyFDi6AyzPVoYflit5uJziLGQhgIzsTkkdMR2GScQRgTpDRoilL
 WxIYILxcoNSXm1QKHk1OGH82dQ+44Yd6hlHE3UrRVSxvR9/IA1SUrassYGFv3ZcMLHw=
X-Gm-Gg: AY/fxX7+6hXmVsmrRiHQjqwMRMq09ASNeVWLc9lI0IeMxevrWZjwP2SW7h9pa4v7nSU
 x+rlzcvFZ2CJoqvHVUPIyqPeLNPwCoDfRW4krqKJ2gDbWWW4QplcFoWPb7yqqnhua5ofTxkBA7s
 PwQjuhg+ulNmZ/WP5Yvlmnso7rvyV0DiksGsJX3jaP/C23SUyVXsu78tmBDDl9+7eMVPoXu2dhr
 s1jnzZWX05ARe8PznLCeQuD9cFzHaipGWAMJol6iVPivwfv5qKUURILe+hsWJ497TsFH9VGGEf9
 uOKBwU68U2HOQY4LimL8lJcmyRmpXBqxj5P4NtaIteYUoO0JMAhI/sgX9DMk3XMkmMu3N2ntYlQ
 ZtLZYsjbTeB2ggap0vH5S+FkOp/KN48hf8qeLWU2hxyvY5m8JFC0vAXiruJ5hujrGg52Zc2SbIh
 xWX/z+UYgluAxbU8s=
X-Google-Smtp-Source: AGHT+IEgrw/sc8qEDmhkpz4wK6Rb1Cew1Pm51CYfTK5AKaEULcwzAro1JLdD5zKMlNu4gNAI29Rv/Q==
X-Received: by 2002:a05:6870:9341:b0:314:b6a6:689b with SMTP id
 586e51a60fabf-3ffc0b5c607mr2903509fac.47.1767895579021; 
 Thu, 08 Jan 2026 10:06:19 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c69c:7b5c:ce9b:24be])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4a9099csm5391100fac.0.2026.01.08.10.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 10:06:18 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] clk: clk-uclass: debug message improvements
Date: Thu, 08 Jan 2026 12:05:53 -0600
Message-Id: <20260108-clk-uclass-better-debug-v1-0-265900a42fe5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMBAF0atIr21IZJTBq4gLk/xoM6KSVhHEu
 09w+RZVNymSQKktbko4RWVdMmxZkJ+GZQRLyKbKVI2x5st+/vHh50GVHfYdiQPcMbJFhDPBx/o
 DyvWWEOV6z13/PH+C1/poaQAAAA==
X-Change-ID: 20260108-clk-uclass-better-debug-1efeb0dcf54e
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=r0qz1I//QVkfv7gl7asbbNcGEfgbGUU+woMzJdx0V7g=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpX/IFO2adA6X20R2xUokmAibLdCdIJgINPbodx
 CO14hsBD6+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV/yBRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ay7wH/jvuYDqq3FL5sY5n38Nuu9+KLjRSINpVdPxx8Ai
 RKSny8QH255khrCzcJXzHR4fz0IVIIBg/rP4O0t8mnouCfB74PXB6UX+7bOy6tEJPSKow2Djp0J
 rOyQV5LC+q9RyKqANYVQUclY+d4jV5Qi4wW5tUNHgrOEjWDoBX69DxnIFS+u+i3tqzNdTgAv5lK
 HgfChWxtnauoPAJnxeXNTRHnlObe1L0fBzPcYnf5gaLD2pSclu0ssxwOlRa6Ezv3w0pdrvsv5xg
 TBjrSnDN7sGUJFA8J69eb1qwjuNMliup1n4kuWgGSBQyQtFrqgkZ5slWRzd5K305cvP10bmjWuI
 OWo4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 08 Jan 2026 21:24:28 +0100
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

I needed to debug some clock issues and found some places where pointer
addresses were being printed when names were available. The addresses
are not very helpful, but the names are. So here a couple of patches to
improve that.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      clk: clk-uclass: fix format specifier for ofnode name
      clk: clk-uclass: used dev name in debug message

 drivers/clk/clk-uclass.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)
---
base-commit: 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6
change-id: 20260108-clk-uclass-better-debug-1efeb0dcf54e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

