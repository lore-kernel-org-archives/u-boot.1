Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5AEFED9E4
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9761884390;
	Tue, 17 Mar 2026 16:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bitYLs/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B218438A; Tue, 17 Mar 2026 16:36:34 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4535D8432F
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so6400955e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773761792; x=1774366592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=y9bLCuJnWtDCmjtYoWS2DObxr2CiRVD+wjEzwiGFJkU=;
 b=bitYLs/1swpKVk9v5uq1ud0FYd/fwbZGYI1n7QbOI4xMZQ/I+6IamEQTTAcV5Sqcv1
 AsMWeNHY7NoCMyWx2Y5nbuwD4BbaTRu11xxo+FmZZkky8T7/09xZbLPQnlHBB+Z2zO8b
 iLqFpPnWbEE1dk8QE6kkflILxyuHxgqy+vB5lvUuUz6pja5ufpXlcz7LLCcozNpEu+TO
 xIsZZ6jAb0oDNAvNNrw2j20VGEtthzmDAxNrAxnkY+C2/YHMZfskG0rkt5oF7MqOGBS2
 kFcfVnfbPwEsIpNcACwath4WexkQD5b9jBxHSMZVWxbwLAhJVtDPaod/XfPW13fM7qsH
 B8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773761792; x=1774366592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9bLCuJnWtDCmjtYoWS2DObxr2CiRVD+wjEzwiGFJkU=;
 b=eP/jVeWiShPrjj/0nDVC19WDFBnXS6rA2ZH/KidaldUYUMo58H9gdxRnfv6yRgCbJS
 CHituXkgF77ct0aStpa8d0ISAjBm0y6f/u7fV11FQ0mTH0Nkabx21NSdDCvWVwDPgMhN
 HfbqNii7egSJW530TXal1D6Rlgx6P1VjmqkgV5V6le6bE+z/GUlJIbHYVfxOzc3M0AFZ
 sS5xUZZyBi5j3c4gNo+NLJQUrTQg2RQCGHfYGWydXB0KRbGppJaGM26/Yr5lxJhydTFr
 YGo/DnC/tQwa8l/KnjdFZZIxrC4Gh+qMOQMqMnMEmMTaekd+LXWFOeccB505kX86R3wh
 YAaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNkh1IdLIXZBc+ej/xCPiFI/aUBK8+tYJE7gZCd/ZD7zf6bH7n1hAVaXsrjANlpU89K023lxw=@lists.denx.de
X-Gm-Message-State: AOJu0YwVL8WjeXNa3IRCFjTTA6yZrUEtQZYUYa2BcwFXfY9ApzyE1kiv
 fhD7qrn88aWVsKcHRnUg2ebhjYLnaoTJYTV/55Pcvn7UwRrPZXZ/1FMj
X-Gm-Gg: ATEYQzyfEmMN0tAOnYqjYkx880ux/gyeYm6KOjuFVYN28UrfEqODa3NN7os7QytjDAL
 ovBuHWlUOjfjdxaouJp4ury44N4SK/b+9X6E3q52pnqT+GLZ1BGJmsiK2RSW5fLokrDeEyAMgz0
 XmxLqKR+ms5AGpzfjIwv4rvBzHcRKQyFKOWZgbsXMFLgXGHmh1ceWxsw9TpH9OphsgWtSInQIHX
 4X8ixSva2OVg6YKsFD7ZGT2UipE4K7fZJAUh3HGyjte88JEYa78x7p9SxMVZyYiBsrjYe1kKwTu
 Je2q8zuLdQh62ta/HjBabFkfhuuguqj2LOzurRwVnKHlDwDA/+5Jr9h9T9vXFdukI9DAW4zrrJA
 wIQKRjCiai6tBhjm4SvsuVPddwsHZbt5dpxN2S4PonSQ/BASD7jgbA9skVP1aYXQTxH6lr4KCzA
 D56vZQr1cLitK3jx9CXgEGHdmUq4kswTg7YPDI1IfCYero97QZtJHrjF8=
X-Received: by 2002:a05:600c:354b:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-485567071a0mr283132605e9.24.1773761791290; 
 Tue, 17 Mar 2026 08:36:31 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48556414295sm200870485e9.3.2026.03.17.08.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:36:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 0/5] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Tue, 17 Mar 2026 16:36:04 +0100
Message-ID: <20260317153614.18409-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes v3:
- Add review tag where possible
- Check blk_dread ret
- Generalize mount_ubifs with generic_fw_loader_ubi_select
- Fix some typo
- Drop useless ubifs umount (nothing is mounted in FIP)
Changes v2:
- Better handle header include to fix compilation error
  on some devices
- Fix typo for ubifs fix commit

Christian Marangi (5):
  misc: fs_loader: fix ubifs not unmounted on dev_get_priv error
  misc: fs_loader: reorganize and split to FS and FW loader
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fw_loader: introduce FIP loader driver
  misc: fw_loader: implement request_firmware_size() OP

 drivers/misc/Kconfig                     |  16 +
 drivers/misc/Makefile                    |   2 +-
 drivers/misc/fw_loader/Makefile          |   5 +
 drivers/misc/fw_loader/fip_loader.c      | 576 +++++++++++++++++++++++
 drivers/misc/{ => fw_loader}/fs_loader.c | 187 +++-----
 drivers/misc/fw_loader/fw_loader.c       | 207 ++++++++
 drivers/misc/fw_loader/internal.h        |  64 +++
 include/dm/uclass-id.h                   |   3 +-
 include/fs_loader.h                      |  47 +-
 include/fw_loader.h                      |  43 ++
 10 files changed, 975 insertions(+), 175 deletions(-)
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 rename drivers/misc/{ => fw_loader}/fs_loader.c (60%)
 create mode 100644 drivers/misc/fw_loader/fw_loader.c
 create mode 100644 drivers/misc/fw_loader/internal.h

-- 
2.53.0

