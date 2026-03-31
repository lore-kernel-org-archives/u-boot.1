Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F24FF60DC
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 07:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D94183F5B;
	Tue, 31 Mar 2026 09:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WczoaSbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F11983DBF; Tue, 31 Mar 2026 09:53:51 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A7F83DBF
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486b96760easo58705635e9.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 00:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774943628; x=1775548428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PK6UpEMYRMPah6QsShwtT1bqZlzcg4BhvALhxxr1fnQ=;
 b=WczoaSbBCHDBOxZ7EswJWYjBEkpotAv9K3Vfwa5WUXiY+cA2WXjcHaHpI7RY5HXcyv
 +RjQ42xAHct2IRclCIDynnoj6JV5wChVjkrFIDBRvAof0mWabWLjTraDsBDbTmfEAYO8
 k1anjHW4knjFZXmidNzdIWSiz4yeP1RgajAJcKWYRXHFWtIFbbcoe4E1wTUyJjKdb4NQ
 fvq662ysXp3QCB+hn/bZv4KApAWHLNej98+I/xglBbSKD6aBxxIeWQ0miZzwYoXf9Nmb
 /h3uK7IO9h3AyKdgBWJJ379TCsnXh4EUP2gs8DijLRjlCNsFDyadwHSNmB8EHRg0MA7M
 heNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774943628; x=1775548428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PK6UpEMYRMPah6QsShwtT1bqZlzcg4BhvALhxxr1fnQ=;
 b=rW6tfvgoTIUbMn3LADuWuiyAHX2C5JVAG+HIeUtuJnmTidNnbDcOc7juRyM7DJt0zg
 w+qsmNU5VLwxnWkJOi3Xr2wqeWKb29UFVV2a1Eqnc40ZG5Hm9jJ1CE8BS0DQVo2M39O7
 N99ekb+2e/Wf/peayY6QRsh9uQaYrBQEkD+RsPC0tzlNXl7EsdehisHny6gwVyVTFE9p
 4dtCqIhmnaaSOgu0iwHYyQoRxfttH6oXTMxBnqyeWbHadQqNqZBz72fTwuu+Jm7+q6Br
 y84tdmWIGCDFEhPxXpufe0//dn1YHx9P0BIvJugQKRrBFmbCGuVYMyOKaUqfGJy9mt80
 SzEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2IpHGR5cMeZllwBkFm787Fdcmgfc4jjvH+0G5OIucdwj+weSZ5N8KDj6igp7FP4qT6iRxWxE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh1iYb0xfs2HTY9VMMmowoN+MCfNvntBuJZouKkuPahI7dQ+sM
 t7mgObX0c54SGoQPpN4q695FODlvHbVv5bY9gj7+EswIwd9C+P5ExcIP
X-Gm-Gg: ATEYQzyJS7oKXG0MTBue+Sv8v/6XcTV0yqJKl+K5+x3Nx2zDwduRa5aXr1Z3R5T+WEF
 2jSUSKAjqqzyJnBM4Qxm7ZbdxfWJpTus0K6fZGubgxbVsLvHEnt+UKLErllQUjzWcouAdiSNvD+
 nX1bCvUOWEbT6jMNT8yC2oyoag4Jqw+cI7A5CQAIrENcDjPlwB15byvNgeND50568CUdRo9C3kQ
 DLDGiqef9phwukoj5SptdYKBIHhyUKK6iJ5Rd6TC7iWAdqM1QBzRi+KtMKxfbdFKe2yC5E01z4d
 dx+0qb+znJAxvaxwQggBHKt87d58BkprgK6J5Zu6I7uUlhPg30+BU+9OgDtOQFqA569pF/FMHn1
 oWz+MhWblHRsKPPXmSRcGFOn531C7qhm5YLh3UWbdiZ3/LcO948I6vDihehWdw8NOtWLfHaduoP
 BaoDG4jhyUrwulDBPDQ2gTI2+W73o+18S49php8X9WquHDbKeVymo3koU=
X-Received: by 2002:a05:600c:a292:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-4873d34639fmr65849285e9.6.1774943628065; 
 Tue, 31 Mar 2026 00:53:48 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4887c561750sm23889915e9.2.2026.03.31.00.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 00:53:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 0/5] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Tue, 31 Mar 2026 09:53:19 +0200
Message-ID: <20260331075338.2391-1-ansuelsmth@gmail.com>
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

Changes v4:
- Rebase on top of next
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
 drivers/misc/{ => fw_loader}/fs_loader.c | 185 +++-----
 drivers/misc/fw_loader/fw_loader.c       | 207 ++++++++
 drivers/misc/fw_loader/internal.h        |  64 +++
 include/dm/uclass-id.h                   |   3 +-
 include/fs_loader.h                      |  47 +-
 include/fw_loader.h                      |  43 ++
 10 files changed, 974 insertions(+), 174 deletions(-)
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 rename drivers/misc/{ => fw_loader}/fs_loader.c (60%)
 create mode 100644 drivers/misc/fw_loader/fw_loader.c
 create mode 100644 drivers/misc/fw_loader/internal.h

-- 
2.53.0

