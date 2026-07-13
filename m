Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60D1C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD5D84C19;
	Mon, 13 Jul 2026 17:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HfTBMeIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8F284C4B; Mon, 13 Jul 2026 17:57:02 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444E184BE8
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so25041165e9.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783958219; x=1784563019; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7Z3UnZrVDqXSsVjrhLAPeEFqWMzKxp2TtHDH0MNwaXE=;
 b=HfTBMeIkD16eyix1qVLpPFmhb2xMaSxg+fs8L1jdrGdQ39iXm04jx1kDNXVl1aKiLe
 qqv2CkyugOCnrHRt985OF31+ZJ+k+ILxmuO6BgBwf0YFoajJdYAsHdTXCGHs9tjRPs1m
 EI+Yd3rVBDVVNKM/QEpHhIwckiHrU3lmdeGGKmCLc2sIU3eqjl9c6Gff6RX2xk4gdJ+j
 a1fWMgqiRP1k5Jtj3IxkXJy2eI/B2DxqZPr+ifGGVqx8LX2JvOOU/ZiGsWarvA02+PQ5
 TjmM1q3UX8uKWbWDelgrHmEnXqwSMefT4FcITl8EaHw8Py8n3kEqoPEFI6Ds1ITacfT1
 m2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958219; x=1784563019;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7Z3UnZrVDqXSsVjrhLAPeEFqWMzKxp2TtHDH0MNwaXE=;
 b=MB2xU9LoVb7inaWxiY+F7afDRH1MveqZtxkgYeJruo8HVZrhhBQHNIMp9wdpuybydS
 C6gYHp5zwhWajYIt51YrNa83o39LnpXJbK6RbGXRPzEaqf7YTqZQhX2t2UGujHCFTcWh
 o2V3ulkPP2CX5QwzoS3DbjgUW3464unSSZJwL72MyLqhD02TKzrrnybkmDDsesvjJhPF
 1aVSm5rnFhhO0f83/qc/6rkaKBRox+mOJINpqx/0nmCwAwL2gIGgQx9FxTsG8D3QEec+
 QSzUDrRE15JvCzcYZICyoH4IDvZQ7z/Drth/fWmzATe33UfWG2J30yhYEs/F4zcYbqM3
 YuNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHxRSsD7bAICa08O5PHkFOvNTb7gtJKRsCH1sdCmDBAOGA9EnfEHQk6h83LhoYDvthfBWwNqM=@lists.denx.de
X-Gm-Message-State: AOJu0YzsVpQIFMbh6ivNTaKglB2EsYIgpWwA5K8TZcOuj54m1IfObUb3
 M2DbEMBB4y+AJQpZfi16mJQZKe6Sf8Sk7VtrJmsosAyiU2usHvuhCYLDt1jjGQLSlw8=
X-Gm-Gg: AfdE7cnZJCjGddAnYLm6Z8v+ysTYkwGcf9f3MrlvI0s/LazewwAc5pEI8DIoFe6asD1
 bUeAZWZH+uKm0BLtT5wqw2a3CkL9LGXlw8Yrn3ZiGjn/FU6R+GrGerU9E5GlpMgtaRSfja4JvaE
 rdwmxJfV/WwBzYIbfDD7SP2sBIDA8F7dDkBGIWZN3yY66x4qblvRFWue+Tl6gFvQTJzWDMdgTkR
 zSmNmgvOLjtxFMuHF8QfBUUCkAVsFvH831hOeyHHJF8K8j/2gH8ijc5Bz7q6uuMOFleyc23umMW
 Ps6Sl7hzbLvJiyxotESYcUgwBtJIZ2onY5k77gIQlPO4UwmYbKzKSHSt1tgJ3hWPnhFuw9EXuY2
 NDuuTabcmOq/iAIUHXFlBJ44kCKwfbV2NkhJyxUe7NjQAE4C5jppxvdAOiRuCjbUDgNA0TTGKYJ
 P9sMWkbEbPX2/q85EiIQCIsaFsEek18U6AYA==
X-Received: by 2002:a05:600c:1394:b0:493:bb45:d54d with SMTP id
 5b1f17b1804b1-493f883c8f2mr94639175e9.37.1783958218503; 
 Mon, 13 Jul 2026 08:56:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm352946f8f.8.2026.07.13.08.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:56:58 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC v3 0/3] Prepare migration to the new mailing-list
 domain
Date: Mon, 13 Jul 2026 17:56:54 +0200
Message-Id: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMYKVWoC/4XNsQ7CIBQF0F9pmMW0FAh1MjHxA1yNA6WPFlOLg
 RY1Tf9dipODcbwv9507Iw/OgEe7bEYOgvHGDjGUmwypTg4tYNPEjEhOeM5Jia2frO/xrcf+YUb
 VYSGUZlQzEIKi+HZ3oM0zkWd0Oh7Q5XP0U30FNa7YWuuMH617peFQpPLvjVDgHPOmKiWrJdGs3
 vdmkM5urWuTH8g/gUSBCN1QDqICyr+EZVne9Kr4vwoBAAA=
X-Change-ID: 20260623-osuosl-ml-switch-88cf54f5e884
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=M1IgYxWZfaGPcnMzOtpZbC7och3sS2zZGE4wAIuXFaE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqVQrHOV9ahsNGbon0xqr0FHpQ7dmPSsNNtSN93sJL
 sDIqdQKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCalUKxwAKCRB33NvayMhJ0VU2D/
 47WOWQt/v19yyNr6tICbjFnQcn0VerdpkydD/nI881IC47UFp5Y2vngIF8bgwrSVlNFn+Zc1rhcnCa
 rNKuhnntLRE9D8YboHKlhhh/lZtYWJ3Rfgw+bQrXU33SVELQT/PUfCnaLfpBU/yI7TmW3BUbncZihW
 MuFl3fYtK/ts/nqVQHdIA3KC8s2XZOeqmpLUvviJaiMFZpkrHnKCf3yuzsvZs9pu/XbjTUlFKmKS4s
 Ti+vkwHJCB/6J8oRReA7H/dHCwehftUuL838GwZavyDH+6nY7KqUlprvxCzoOd1HzPLkt9TpSyBSIg
 7S79McfYUMD2GT//QieUekF/Tue0tM+gEBllu4LiMUT7XQ6xMNofIcm/TuAvFX87eMoJMCKOBNehWj
 SXNWZuK2RXNdmdC01F1dv1zabxYD/qe/ksDZlw74BKADgVy8AbUt6VfIYOThbAUfGzNimFCxOQTkSs
 fHftxGEVU0UBrOcGPDPmjtGTJnhDiqe/h1ilM1GUpe8NiPQ53jdBinFse6wVVOFwschCgsqTSNulxR
 hPl6Oyn0YfvpMurt4JZLVNofqIaYSN4fuGMI36lA5FMrj1T4q+Yy/8YNZCDHhVzWU7DGm1Y15TFGeW
 8wkM95AMOJtnoAKJOYGAuIICgvFfcQPUYpE1lnw8zAfxu0EXXdkdNqtf6SCA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

We are preparing the transition to the new U-Boot mailing-list
server hosted by OSU-OSL on the new lists.u-boot-project.org
domain.

This changes all references of lists.denx.de in code, comments,
documentation and MAINTAINERS/README files.

Please review closely to ensure the transition goes smoothly.

The exact transision plan will be announced when ready.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Rebased on master
- Dropped the already applied links change
- Link to v2: https://patch.msgid.link/20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org

Changes in v2:
- Also send to the lists.denx.de list... sorry for the noise
- Link to v1: https://patch.msgid.link/20260623-osuosl-ml-switch-v1-0-6d93a5ba2f5b@linaro.org

---
Neil Armstrong (3):
      tools/patman: Migrate mailing-list to lists.u-boot-project.org
      doc: Migrate mailing-list to lists.u-boot-project.org
      MAINTAINERS/README: Migrate mailing-list to lists.u-boot-project.org

 MAINTAINERS                     |  2 +-
 README                          |  4 ++--
 doc/CONTRIBUTE.rst              |  2 +-
 doc/develop/security.rst        |  2 +-
 doc/develop/sending_patches.rst | 12 ++++++------
 doc/git-mailrc                  |  2 +-
 doc/index.rst                   |  2 +-
 tools/patman/settings.py        |  2 +-
 tools/u_boot_pylib/gitutil.py   |  2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 02f8b8ab6d6095dccf867d899099322f7430d20d
change-id: 20260623-osuosl-ml-switch-88cf54f5e884

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

