Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0D1FCC05D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 19:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5416783F2D;
	Fri,  6 Mar 2026 20:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m5092s+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D3E83F8A; Fri,  6 Mar 2026 20:05:59 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF48D83F00
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 20:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so61833565e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772823957; x=1773428757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BZj/AVe2gzMuCV2Pp8MKVic9ReXVH7/+mfvstqkS7Us=;
 b=m5092s+C8JgCpdVZUDbMI/nzSbEIC72Bkcz+mNArUDiJSGroPucQSOLV4vkyKohk7/
 Obh7WAyKelcMYGyaTr9+w3PF2ZkT7TjIBM3FHbuZcOkxNsaMadWaZkJPlx8IIhAsssZu
 d0iNRhwE8s2+rX4PfnzOPN4Gho5sN+ERLkTJBa54uWOxRVnuTHu8ngS0lSzG3GulAhE5
 Qje4WDT+k4vJT7ehzkge5NnnGzVJLXA2I7RDAO0G7WGVqwphImWWAS4TsomKhNWLD/z/
 Sut23HqMDwQX/WC07QL7/oDRssbLZ8lw0lpxjrzzHSBFNwAwKC39l3LFJjy5RPxOHOjh
 E7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823957; x=1773428757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZj/AVe2gzMuCV2Pp8MKVic9ReXVH7/+mfvstqkS7Us=;
 b=XPQJam9oxEuSy4SxTqBDTgwlqkDzmmdmd+gGx0vYZrrH25YBPY/HDbN/dh6+edtcJs
 pS8kj749hY20NMYM7mfTRvxVNHP76lWwE6NyTXjXQ0lqDY26UV3t9gvcDFokz3bfB+8v
 V5MQAJ6DdvF9rslMJhDNpB13TUM7n+Dp8te9Hzm9OoVS5m5V36XxYgs8QJRa3QMeGH3d
 Bnb983enNlWz/LPw22aXQtBVNyPct/zaRlwqUX63sx/VHyqvTW7FarQO9WhBn5yX/9jn
 xRrABUCQlBcV9Oo+0sY5xYTgXW+v3jeuhKnbc934DTBqoE3bcoycLPjpbCFZ6wPSD/j5
 4NHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDVdWsnsGTBbSeRrOjmWijoys0QVL0M9QC9Nl85hHg5Sk0Byum3OKLOXDPHZ8bXwUm7wJt5uU=@lists.denx.de
X-Gm-Message-State: AOJu0YwQiAs2KKCC2FAWxrUULRgHy/eE9rJs0AjVgmMj8DemEyUZkCnd
 tmg2MRLdV+DHeQrL81xpoYcabtrL5GkgWKGvDj92Wkej+wiF6TQsZHAi
X-Gm-Gg: ATEYQzwm9p3JhJO0VYi6J/SCj5VWwTPk9L/p4pxgTQlnjDoiyyHgby19zEZIMX4BSbV
 kd1iH0s2ZGG7enKbLtditRu3TS7HhZy07X7WglRhrNOAe8rIgEvOuQL8WcS8wK732NAvNJs5CAa
 l57aEvAAj6MyrDqnGpHqg+AETUDnAVpVy7D8mYyt55aSnAlwhXx7QQ3H7uajNEcaGkp2Yb1b0Ca
 Uy93XUuWc2HdQnSHFAAICoQ24Dy7T8gMbjEFHuhPQ1xxtX6LalvaqI7NL7wFEzONLi7Ja0cm3xz
 Mrzs9Te0KBCF3u3JdbCIDVcGeJhPk3oNeGkMk2iyuVWFDSfj12Tt9D2FnViOLWJ7C+xOpPRI7uD
 4R+sspkyVdo/14/zcARA3HS0xWsWQizAOihGfjkFBDb6wAqhwUkNGT6FW882fqfDspcZsT72xnT
 pkP0/HYiEtrVpwYagBwF3nTrY6BQzros488SgmSJY8jq5IH1No5oCNjKY=
X-Received: by 2002:a05:600c:1e86:b0:483:5310:dc67 with SMTP id
 5b1f17b1804b1-4852695b81cmr51543425e9.20.1772823957007; 
 Fri, 06 Mar 2026 11:05:57 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm6701065f8f.32.2026.03.06.11.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:05:56 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/5] misc: fs_loader: reorg and split to FS and FW loader +
 FIP loader
Date: Fri,  6 Mar 2026 20:05:34 +0100
Message-ID: <20260306190542.22920-1-ansuelsmth@gmail.com>
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

Changes v2:
- Better handle header include to fix compilation error
  on some devices
- Fix typo for for ubifs fix commit

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
 include/fw_loader.h                      |  43 ++
 10 files changed, 982 insertions(+), 171 deletions(-)
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 rename drivers/misc/{ => fw_loader}/fs_loader.c (62%)
 create mode 100644 drivers/misc/fw_loader/fw_loader.c
 create mode 100644 drivers/misc/fw_loader/internal.h

-- 
2.51.0

