Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1114EC9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 13:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0BF3407FA;
	Sun, 27 Sep 2026 13:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RKV_9S7mNbWC; Sun, 27 Sep 2026 13:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EB28A407E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790515036;
	b=Kbwe926upxXJv+vI+3AepqbsdwSv1IFWXRRlYrAPeeta4jY8FFyayanaj92MXuoHiqIf
	 jcSRj1VdHhAuclsyv8KR+PtZGBbBp2VRj4YkXpX1ycqSCpsgfQwgV5c+bjAYQQgfXPyf6
	 Iw9wRRTmvEqaWwUn4SuOy5QAiLX9lc4MNHOVkK/SwXQiwtEpeOba6JVK3mDLzXxJWQmzI
	 OPC7Q+m8MSXM43CZy39YzqM7aT9tgpJ4FWh7VmIQzEyJjhLA0PHausnMmT06bDHl91ttl
	 ycZ9umBCmo5Zd/yiD6PwnOIBgXB16FNBkMNnAdjlTY/q7O7LoBakIcOPLvohbBiZjQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790515036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GdaoKbRrkSo5XLmz5HmYqpeHTvHrCHE8YWTjsUnK90Q=;
	b=LOuGp2w5p6/kFOLqZFeVDBzbME8tkYrvzBj9A/ZDz60GWqbzvxRTYzSBZXK1FX6acejQ
	 1wExs+dTE9ViULUG/LD5SFKiJoVMDFmfxqtScPoVPCrLSM3MMULIH9y9Cp4n+5DWnYk9i
	 zb7kbbFQieS04OJam9hhs6n4PTLqNnTzZOWWzqfpqhWkHnHjgJJRGHZW5UzMemc4ArvWd
	 kR/zOrGcb514SPd4VKGOmNhgm7BbOw0l4Ip2x1tzPdsWdM0wxmw48cvNb52tfDg8ycJ4U
	 swUclT62WjACy34K4M2aBI7kxDmCPdOaZZsUp22UEyMbrhp8dcDTdugwtn6FBaUl+zg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=c4Ubo8wb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790515036;
	bh=GdaoKbRrkSo5XLmz5HmYqpeHTvHrCHE8YWTjsUnK90Q=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GcNWRFWucCfmT61hMzVqX/82ikfLX5pDOkFgJnu1l4A9vS18Iudh10liMj4lV89j7
	 DEXQR4eA/G6c1/xPEQQElfJFaFfhqvba0MS3DEv5qxjr7MVl74+ppi/XrHCGVCQ0GZ
	 XoZfKn+uR4nyvxKz4PVPoz1wcbH/3EY0dyQ/LQb+HDL7uEXmKzo/5m85QD7S3VXvP7
	 1WzdGA2Uq4RJD5jHootYk6uuAyukeYI+Tey7xCVzTPWS8YOhQnVxZQCHenKN2kHTiA
	 fWPcNwNKhy9kOzExEFyoTTjJ9quQER8nbFi8XFFa5tPCtzaKKQGa1+tQnJP2x5VEsm
	 SFBdvpY2yA5xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB28A407E7;
	Sun, 27 Sep 2026 13:17:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CFFD3D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E76440855
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 620RpwALydKi for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8DCF340851
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790511018;
 b=M1dFsMOmBj9XprvioZfi+UG1cvUvjPH8Pupg+KhtTguUggrzszLpqbB88Zs68hmXXPdr
 WM7HK+9oAAm3i10wRe75EO4OptIFYKyihlbkJVTZiwEfxqQC1qyMpah12aTgABqKgsEmB
 o/bWy0t8ybAcYl7wTKPcrPD++kbkf6425UVRBRRzqPXRRGGLN5iaZNA1uBOuWxe4b/C6T
 sA9HYE+EeJbFswTJA8GzUuvHUaknkV/v+xaqfbb50XTdeMulgAXp054BkT+CP75/hp2Pa
 Ps+xLdxCoR8ERaWeXOpROc6KvnmAoPcXc813jqctFE2crrU/itn+1bKvkMK6axsayFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790511018;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=GdaoKbRrkSo5XLmz5HmYqpeHTvHrCHE8YWTjsUnK90Q=;
 b=P3GQcYYgbWdB5Z+C5jb2wOxZUfEad7cqiTRxMxQJTTClfgsAsRpp9oGQ1L6gWZyymb/T
 7/m90hNIB2q9B8brGu27Xm2YJNckNZ39NBH9zzsmfY7sAlp1mDCT+X4pdPcMqYlfiVoWa
 +kkZpfUcfqh8E8sCimt30dBEbdubWocFxcwegLLb2cJp0b5aYQGqgRV9xJg67xH1j/CWM
 MDmBpzaG+6ttLxtZmPnOBXZjKUJlfKoKNUtdp5X/Cdb0Xd/m8zCLLIZkAiBBEtHgeoFj2
 UWRJPkLr3vQ31ZuxQByrVFOZbfi7cmJyV65j8i4zGhPHmm0gsinDNTA6KRaY0b5LMMw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=c4Ubo8wb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=c4Ubo8wb
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DCF340851
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790510959; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=af+md5bT2iPbQtbMR9Apf744M47w1aORmz/+/n35Y8RWVq5ri/lh2f79X5QzN50ZUkuewBdeDc31/f+zApHpAnS89vbHYAKW4VYHO1HkVxCgBg06IEryqggaNC+/DZ1mkLgBwIdXreMjWBiSrrVE1Fq15N7fXGw9+Yl1TOzBu4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790510959;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GdaoKbRrkSo5XLmz5HmYqpeHTvHrCHE8YWTjsUnK90Q=; 
 b=SljAWg/R/6+rthGjxZpZTTL/WCxEghgGEMaDEy+Q6yNUBG8OnzsLcwVDZ0HQZZUJFsuoFSlUSRw5BSYpwTrDHGZ67FNVk+X9J00pvYbxqMgWMMbSiJDtM3Ex4rrkoCk0A82qkty3oEhdvjCcrr3lzQ/cltNWKd0NV+YNIFYM7TQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790510959; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=GdaoKbRrkSo5XLmz5HmYqpeHTvHrCHE8YWTjsUnK90Q=;
 b=c4Ubo8wbldAkM+FCrmReji66Dxq+cKiqHmQiFlV0KXU+WANcjhhNqWC9I/jh/2E2
 sdQ20c6CiB29yFCqjv+xhPK+AJn06xtoeqK8CHgEOhcra6NwjNvr+zY7XX0dIwLS9EG
 IxbHtE5sSWd5VpWvmTBhv5bHFFpQaj4kUDrBOIlQ=
Received: by smtp.zohomail.com with SMTPS id 1790510954168277.24088105515807; 
 Sun, 27 Sep 2026 05:09:14 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: [PATCH v5 00/10] riscv: sophgo: Use upstream devicetrees for
 CV18xx boards
Date: Sun, 27 Sep 2026 20:08:55 +0800
Message-Id: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PTW7DIBAF4KtYrEMFAzZ2Vr1HlQWGcU0bhwhsl
 B/57sWuqlZWU3X5pJnvzdxJxOAwkn1xJwGTi86fcih3BTG9Pr0idTZnAgwqphjQwR3fE7WTp9M
 5jgH1QO0YaVtKjVbyzlSc5OVzwM5dVvjl8Jnj1L6hGRdtmehdHH24rs2JL3NfJdWjksQpo7Vln
 FlrtTL6+eZ7P2h3fDJ+IEtPgh8SqIcSZAk6bJUWYJqttCv+J5Rc1lUrS9kY9cst4vuW+o+vRJY
 arkynmAYhttI8zx8yu5ijpwEAAA==
X-Change-ID: 20260702-milkv-duo-upstream-dts-b54aed41fc61
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227a8aa528d6d849227cee7514d0000fa9fee2894eea7b1c3374990936dd5138d8ff8516b2027e0c9:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:17:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Milk-V Duo, Milk-V Duo 256M, and LicheeRV Nano currently use local
devicetrees under arch/riscv/dts. Equivalent descriptions are available
upstream, but Milk-V Duo 256M support has not yet reached U-Boot's
dts/upstream tree.

Import the upstream changes required for Milk-V Duo 256M and enable
CONFIG_OF_UPSTREAM for all three boards. Add the clock and SDHCI
compatible strings needed by the upstream devicetrees.

U-Boot-specific overrides retain Ethernet and SPI NOR support on Milk-V
Duo, and Ethernet support on Milk-V Duo 256M with its optional IO board.
Enable the MDIO mux support required by the Duo 256M Ethernet topology.

With all local users converted, remove the local CV18xx devicetrees and
the legacy "sophgo,cv1800-clk" clock compatible string.

Tested on Milk-V Duo, Milk-V Duo 256M, and LicheeRV Nano. Build-tested
for all three boards with the riscv64-linux-gnu cross compiler.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
Changes in v5:
- Move the RTC and system-reset changes to a separate series
- Enable the MDIO mux drivers required by the Milk-V Duo 256M upstream
  Ethernet description
- Link to v4: https://patch.msgid.link/20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com

Changes in v4:
- Import the upstream Milk-V Duo 256M devicetree changes
- Switch Milk-V Duo 256M to CONFIG_OF_UPSTREAM
- Add CV1800 RTC support and bind system reset through the RTC node
- Preserve Milk-V Duo 256M Ethernet support through a U-Boot override
- Link to v3: https://patch.msgid.link/20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com

Changes in v3:
- Restore the CV1800B SPIF node in the Milk-V Duo U-Boot override
- Link to v2: https://patch.msgid.link/20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com

Changes in v2:
- Expand the upstream devicetree conversion to LicheeRV Nano
- Add SG2002 clock and MMC compatible strings
- Enable hardware system reset on LicheeRV Nano
- Remove the legacy clock compatible string after converting all users
- Move the Milk-V Duo Ethernet description above the gmac0 node
- Link to v1: https://patch.msgid.link/20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com

---
Chen-Yu Yeh (3):
      dt-bindings: soc: sophgo: add Milk-V Duo 256M board
      riscv: dts: sophgo: cv180x: Add PWR_GPIO controller
      riscv: dts: sophgo: Add Milk-V Duo 256M board support

Zhuxu Ran (7):
      clk: sophgo: cv1800b: Add SoC-specific compatible strings
      mmc: cv1800b: Add SG2002 compatible string
      riscv: milkv_duo: Use upstream devicetree
      riscv: licheerv_nano: Use upstream devicetree
      riscv: milkv_duo_256m: Use upstream devicetree
      riscv: dts: sophgo: Drop local CV18xx devicetrees
      clk: sophgo: cv1800b: Drop legacy compatible string

 arch/riscv/dts/Makefile                            |   3 -
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi       |  35 ++++
 arch/riscv/dts/cv1800b-milkv-duo.dts               |  64 ------
 arch/riscv/dts/cv1800b.dtsi                        |  22 --
 arch/riscv/dts/cv18xx.dtsi                         | 232 ---------------------
 arch/riscv/dts/sg2002-licheerv-nano-b.dts          |  45 ----
 arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi    |  16 ++
 arch/riscv/dts/sg2002-milkv-duo256m.dts            |  46 ----
 arch/riscv/dts/sg2002.dtsi                         |  34 ---
 board/sophgo/milkv_duo/MAINTAINERS                 |   3 +-
 board/sophgo/milkv_duo_256m/MAINTAINERS            |   1 +
 configs/milkv_duo_256m_defconfig                   |   6 +-
 configs/milkv_duo_defconfig                        |   3 +-
 configs/sipeed_licheerv_nano_defconfig             |   3 +-
 doc/board/sophgo/milkv_duo_256m.rst                |   2 +-
 drivers/clk/sophgo/clk-cv1800b.c                   |   3 +-
 drivers/mmc/cv1800b_sdhci.c                        |   1 +
 dts/upstream/Bindings/soc/sophgo/sophgo.yaml       |   4 +
 dts/upstream/src/riscv/sophgo/cv180x.dtsi          |  18 ++
 .../src/riscv/sophgo/sg2002-milkv-duo256m.dts      | 121 +++++++++++
 20 files changed, 210 insertions(+), 452 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61

Best regards,
--  
Zhuxu Ran <zhuxu_ran@zohomail.com>

