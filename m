Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4420EE78D74
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 09:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB4483BC9;
	Mon,  9 Feb 2026 10:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bTFJl442";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31E983BFE; Mon,  9 Feb 2026 10:25:33 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E072E8397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 10:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so3269392f8f.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770629129; x=1771233929;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=keqHSqTwJU+QeSHiI4z2N9XEKDM3WAxNy3h2XVSs68A=;
 b=bTFJl442h/OJ0jYgKCVQ6tZjPvBFjWEhyL4ExRXndZNQ/peqLcygxeJX8GAi7X0j1q
 gx5O2frNDV9/6/xWhb34zaZgTn0WEsilk1POA4rjjKIgOLQkYPWnpzRhxSo+FSWJQElJ
 4qJ47p7UCYzcm+rrxOVFcvJoy6ljvllS889aKfZ7SrHvtq40tsrNqO9fSv+fBiyqNoqK
 jA4QzxUVgNqyYTMHlkBoHptgw2oWMTVrFg7oPrLoItTbOqa2lteSrg107XfJNx2to2+9
 jWgQ5CNg0qy8+4I0LfC13B2/dEu4d9WfOFEqaJrwTwj2fbNHyVljg4Y2ptYJIP9yO7T0
 zNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770629129; x=1771233929;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keqHSqTwJU+QeSHiI4z2N9XEKDM3WAxNy3h2XVSs68A=;
 b=uzueZSkEOKxFQqf+s9oeVHQam8Jphd/IKioTLHac+iO7TPYiOvKW2E22nBUZvWad+A
 07q+rB7aBr4iQPm/JcBtgtaoJgGiKy8UvayczI7nbmXzmrmpcKKDuSoMw+9FCXSjkSOm
 Fu08YBVu7sa5uDfe9WfUp3wmaVjFz0op5X0VlOpo15YfEg7i2G9usQi41iy3iDkk2amN
 oTLrpC01qKQRliwUj7t5wGSkGbmN7UW0QMHaw7lvC6fc24R432LqIK23sFwmyAQAnkWG
 m2HXyj8gQOlvpU/cJgDSzCW8W76l1rv6DAdMcAo2iKUpXO0Z+o3aHe7PUw4f/2uG0cVp
 u+Yg==
X-Gm-Message-State: AOJu0YzMcxQLEF1I12wUHNuoNQoFFjQIewtjMV+UT6kvu7JMnati8/ju
 ZC85KR2eB299cZeR1hAKJHCtkoyB26OTx2J/1JN9sa+tDwDHW2BecBaKA54RnsN5j90=
X-Gm-Gg: AZuq6aJHlbH+xb0WnFt2K3wMeCIyv4Krl0UjKaYnjLdZxvY7qXQxhDJb3FvwBVpfcVe
 P2Osqs2BlWMiSabEDrpM9Mc7pv+OSP7ZmQPHNSJ4zKJh9ppX1Ipp845rsW9Y9mCGSmuRJEYctUI
 MBwu/iDZ0Fpm1JXEAE6cyzT/kTUaWwKqLI1vug40TZyIqW93hsLAwnDUQFBhcBX9qPvKXaan63m
 udxd95l8iUcTdhf2wTYqnCM6hmXuLPiU6EV47ILaZrtfjsZMEJY0zRrSWR5XrYO0SEZp7lkSSzN
 OCFOvE0Ot2DaCoDbQwYcxL0UNUTYmOubL2oV5kwRpOVp7KQDaH93OVwyEpgOoMtg0lVpuiF7Vem
 cJnLc7ZERC6PrZnwWVbYkAncKXRZjlq1a2w3biJqMPx38lCFAUw5VTIA0YULRdkoowtqbNOMkjK
 CFdl+ap4rQ
X-Received: by 2002:a05:6000:26c9:b0:436:1a23:3949 with SMTP id
 ffacd0b85a97d-4362904660amr14778520f8f.10.1770629129210; 
 Mon, 09 Feb 2026 01:25:29 -0800 (PST)
Received: from localhost ([2001:4090:a244:8139:5278:cf5a:3494:5e80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436309ed238sm23311408f8f.19.2026.02.09.01.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 01:25:28 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v6 0/2] dm: core: Support same compatible in host/gadget
 musb drivers
Date: Mon, 09 Feb 2026 10:24:36 +0100
Message-Id: <20260209-topic-musb-probing-v2026-01-v6-0-efce26b4917a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANSniWkC/33OzYrDIBDA8VcpntdlRo0fPe17lD2o0VbYxmC6o
 aXk3dcUCmEJHv8z8Jt5kimUFCZyPDxJCXOaUh5qyI8D8Rc7nANNfW3CgHWIrKO3PCZPr7+To2P
 JLg1nOtelpIAUueAxRo1KOlKFsYSY7i/99F37kqZbLo/XsRnX6duVTXdGCrS6vfZCK+Tw5ezjJ
 7kSPn2+kpWe2ZuTgKDbHKscs0J5GSAobnc4vuFQtDleueCc7o0BZ/q4w4kNx1SbEytnOQMMEDW
 YHa7bcBzaXFc5NJ1j3Csj9P/vlmX5A2I0mBcFAgAA
X-Change-ID: 20251125-topic-musb-probing-v2026-01-1343fff8176b
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149; i=msp@baylibre.com;
 h=from:subject:message-id; bh=EtO0ZTX1T+LsJQy/arjb+EukjVxaX708NOzaXm8EMpo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszO5d/P3FdM/znFglvzagzrQbv27K2RQiYb+BWiVFf5v
 g9hcjncUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABO5lsfIcN6G+b69rF+Ft/Ls
 az2aEswTZ8n9KE3RuXT09AaeOwcq4hgZLjr+qT/WyMu+zfZq1s7OW3901X1nljyv8/jz4INJ2Hs
 HJgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Hi,

the core part was already merged. These are the remaining two patches
for musb that change the address parsing and another patch to add
compatibles for ti,musb-am33xx and bind functions that check the
dr_mode.

I kept the subject for the series so the progress of the remaining two
patches can better be tracked.

Best
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v6:
- Use the same struct udevice_id for both host and peripheral drivers
- Link to v5: https://lore.kernel.org/r/20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com

Changes in v5:
- Dropped applied patches
- Converted fdtdec_lookup_phandle to ofnode_get_by_phandle as suggested
  by Marek
- Link to v4: https://lore.kernel.org/r/20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com

Changes in v4:
- Remove log message changes and push into separate patch as suggested
  by Mattijs
- Fix commit message as pointed out by Mattijs
- Link to v3: https://lore.kernel.org/r/20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com

Changes in v3:
- Add short paragraph about performance implications to the commit
  message
- Add a new line in the test
- Link to v2: https://lore.kernel.org/r/20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com

Changes in v2:
- Added a few patches to remove nearly unused variables
- Changed the inner loop in lists_bind_fdt to support set drv and not
  set entry->of_match.
- Cleanup the loop a bit more
- Link to v1: https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (2):
      usb: musb-new: Relative ctrl_mod address parsing
      usb: musb-new: Add compatibles for ti,musb-am33xx

 drivers/usb/musb-new/ti-musb.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)
---
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b

Best regards,
-- 
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

