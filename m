Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACB9EC1444
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1851683E7F;
	Tue,  3 Mar 2026 14:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOADHU3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2946283F69; Tue,  3 Mar 2026 14:29:29 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6D8838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so34538535e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544566; x=1773149366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qCFKMSJuWADj5QwhvBmO6svAbWI2IN3E7fPhGH3Fp5o=;
 b=YOADHU3X8Vobv+z/0hJvL90AUyrCEF6mhlVrVlSsP0pjCVBiN+eXCNWrCAOb9tyz8O
 3TZAy/5pZcIRiMSiXppJl3GEzTmKeXDQxtrvwM5mbsLljxHJMco9HGh0Sx0GUex35wQu
 ofocRDZh2CJej02qK6CsKLDQs9BGaPPZS9IomXWdEj4xL76VXYDtf0fgKJPhCm99kB00
 jtSWjLJHrtG81jSe+HysPyQMB3wrPdYKMTwNUhfj1z6S1CWxIFVdSY5S8dWKGtNZMy+m
 suILaoOz5VbI8TZuDwrK8ra5rAWcJXZpxyI7JlICqiPCKKLUXEH+Gy4Yp8wA9eA/D2gz
 hpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544566; x=1773149366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qCFKMSJuWADj5QwhvBmO6svAbWI2IN3E7fPhGH3Fp5o=;
 b=sbOU8jr+aBG9xUOwnr0FqmzE6i8lyv6ZVePMk9/H/H5xfxBMMPWxm3xqdYhmuyg0ZE
 MRrVAzTgp3GadWWx9Ou7o62mCBs63Wmdcv9swUcLCVaxqEbWNmHJO8Pz/Ho1pjeVIKAz
 xPZI/rMqMMDgdCjnbjRdNWLwZlPJFDH0evJze9dOxvgZUUMQWpi8aqWohwuXs/Pw/tRL
 SuFQTCAoUQrh006FW6Duq4oNMCus5XrxT9TY5a4ctV97nHUFjHBPwULONG0rP5a81XDJ
 oLKzpIrTBO0bbgWzNaToDYvB0Q4mDVQWCxuN/sNYDf9/vqGalBkgZiPsoKSscRRsg3+g
 ODDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8aXkOPEQ7EX5T0ernSl0ocAsw0Y6+a8cR1Bd5u5zpX2ygctOcUu6o2GFgN/ixjY55pdAI5ks=@lists.denx.de
X-Gm-Message-State: AOJu0YxG3qrIc98QPUABnUanY/mGxfchMkyQgoqWAPuG8By6lQgdu2rG
 W2/z+13MGGE4DZhqspRTsAp1ht3RIoRFBewyM0pjUUhDHuebHGOjZWZ2
X-Gm-Gg: ATEYQzzeGQY+23aNoQXFDmGdiUI8HsBeSd4nluwKMbWGCOV3Mu4+DlR6tZ1MEeLozBc
 SUgYgFaaTykB9rbptVsgGjfhBgy1YJG8L3ycK9u6KdGvBmIKhC6dDaHtnSAUCzKX7jmgqC6Up90
 iPtJn8lVRM9y7uqXdhOPO0r141KD2/PrNtEuyAPc+ZFWjm9+jXRdG7pBlLpAHunWOtIVww0+sRS
 AjUKze4HK9lXfjTzM3vB0n8H6dR3NgofitZD22MnZcvbWj5k/Sncea44XaCcnsSfl6o/Rq60hZL
 DlT3incVOh4K2wqE6p3O8sZsX/Y3MROb9T2l19Vbw9wyu7Ku6OTY5CbD2DWZlwO9zcmGX5Vygag
 9MXFLkPHzHmAHZ0rE4Uli6Du5V7Z45ZKLXnZ8qTb9glTCu/PP6XxY3SR0GPh4FJobhZ/sDuNIAw
 CgpCZdy5aAo+f36G4gIhFG1W+d74BIqFzioFO8nPxsWxQhPk5Jper+foH5QD/3050+cQ==
X-Received: by 2002:a05:600c:4f0e:b0:483:702f:4641 with SMTP id
 5b1f17b1804b1-483c9b94367mr269793475e9.3.1772544565318; 
 Tue, 03 Mar 2026 05:29:25 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm772625095e9.0.2026.03.03.05.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:29:24 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsha Vardhan V M <h-vm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Subject: [PATCH 0/5] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Tue,  3 Mar 2026 14:29:07 +0100
Message-ID: <20260303132916.5502-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series mainly rework the FS loader to permit reading firmware from
container that are not exactly a readable filesystem.

One scenario is when a firmware is shipped in a FIP container as
a generic blob with an UUID.

FIP are mostly used on ARM in the context of ATF.
In such context U-Boot is loaded as BL31 and the PHY firmware
can't be stored in the FIT image for the kernel as U-Boot should
not depend on the presence of the kernel to correctly enable PHY
for Ethernet port.

To handle such case the PHY firmware is stored in FIP with a
predictable UUID.

One example is with Airoha 8811H firmware where the FIP can
have a blob with UUID "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2".
(generated from command "uuidgen -n @dns --md5 --name en8811h.bin")

With these example DTS entry:

fs_loader0: fip-loader {
	bootph-all;
	compatible = "u-boot,fip-loader";
	phandlepart = <&mmc0 0>;
	partoffset = <0x100>;
};

mdio {
  en8811: ethernet-phy@f {
    reg = <0xf>;
    firmware-name = "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2";
    firmware-loader = <&fs_loader0>;
  };
};

And PHY driver using the get_fw_loader_from_node() and the
common request_firmware_into_buf() it's possible to
load the PHY firmware transparently by just declaring
the required entry in the DTS.

get_fw_loader_from_node() is implemented to actual get the
loader from DT. This was something that was already in mind
from when the FS loader was implemented but then it was
never implemented in favor of a single loader per device.

The first patch is a minor fixup for something that probably
won't ever happen.

The second one is a good reworking of the FS and FW loader
moving the internal struct to a dedicated header. (this is
really to enforce what drivers should use and what
driver should not mess with)

Then there is the request_firmware_size() new OP to get only
the size of the firmware. Useful for case where the firmware
size is not always the same and change across different version.
(the patter might be get size -> alloc buffer -> get firmware).

Then the FIP loader as a basic parser of FIP. This only
read the FIP header, loop all the entry and search for a
matching UUID. If nothing is found then no firmware blob.
Very simple implementation.

This is being CI tested on [0]

[0] https://github.com/u-boot/u-boot/pull/884

Christian Marangi (5):
  misc: fs_loader: fix ubifs not unmounted on dev_get_priv error
  misc: fs_loader: reorganize and split to FS and FW loader
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fw_loader: introduce FIP loader driver
  misc: fw_loader: implement request_firmware_size() OP

 drivers/misc/Kconfig                     |  16 +
 drivers/misc/Makefile                    |   2 +-
 drivers/misc/fw_loader/Makefile          |   5 +
 drivers/misc/fw_loader/fip_loader.c      | 610 +++++++++++++++++++++++
 drivers/misc/{ => fw_loader}/fs_loader.c | 180 +++----
 drivers/misc/fw_loader/fw_loader.c       | 184 +++++++
 drivers/misc/fw_loader/internal.h        |  63 +++
 include/dm/uclass-id.h                   |   3 +-
 include/fs_loader.h                      |  47 +-
 include/fw_loader.h                      |  41 ++
 10 files changed, 980 insertions(+), 171 deletions(-)
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 rename drivers/misc/{ => fw_loader}/fs_loader.c (62%)
 create mode 100644 drivers/misc/fw_loader/fw_loader.c
 create mode 100644 drivers/misc/fw_loader/internal.h

-- 
2.51.0

