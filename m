Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77350606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JU5lUr4u;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KmwLrHX0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42A2A60866;
	Tue, 17 Nov 2026 12:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vF-Nq8xNRKI8; Tue, 17 Nov 2026 12:27:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 311D66085B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794918446;
	b=CrXKGaND+ldStUkow/X9xUWJR/xkFpkk87/fSXrXb1ibahXgXsvTEDZsfboaMSkijZaJ
	 Q6caVDr6sy1/IVC6QrRAaTdQ+251cn+ep7U4C2cQeXmOnOFoXZ/l1k+YfDvtyCqDwT5RG
	 4V/PZRwJNdS9usyrTjy2XzMcfJ/jjSG3crsvPyEdI5eBpYcten50tG5+Q2yLhiaWpe2ZM
	 TML/7D3oLAtjUx4QbvlmdH+rdku//34Sby5I9iokZAO3N+P2/qkF2nR2K9DrRfk6yrmCE
	 dxFswlw4x3V8nLvxbbOejFdxiq51STk0LorHx3CSe0Wf3NggfO4/8+S6goBPId26oHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794918446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mIB6D+zWCSJ2NYtxVEzvwpiwm0FpR5YDhARSJhRfyAA=;
	b=pXdiIU8A0zdxh+D9IfyekvFchQMgqrjI9HWz7qICxOvlPZKaLak7arIvBdezGVihbNe4
	 WY6+svhxwkfFN7QDsAV8JYs1NMf8E56P0nDlYSvbn9BxoUeRxBSU4Ve/5obT5ROQITDxs
	 1Rs8MRbC2wWP20cBELjCZCrFv0yIfvLw8FjED1JRZydyCPW1QUO4iBgwKcPZ6+U8rK3km
	 FHzN79P3LjwtlFVbVg0Yhyqg2Up34Iqm/kvJFercSAOxWoj9Z99m+1uv3VsbixcEY3sfF
	 7+8JMc32oXr93BwMD+PhMaHXMSV0GltdUZ+3EKq5jENb7TvNmhvyg5HxWKFBxarC3TA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794918446;
	bh=mIB6D+zWCSJ2NYtxVEzvwpiwm0FpR5YDhARSJhRfyAA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JU5lUr4uU7yalNbYqI2QuKQ7wxMltWAT+ctxYygWJaaB/MqyLWWpzaWdrJ6o6AUIl
	 AeEJAsMSQpAzjElLksakg12W0W4QZhWdev9P0j67VM5hkkCJhhN5vqAGDzkgD7160z
	 RmFpb4PGztQXdqOEvj/h4h9IXr98vilL1j5zMe7n4y+5z9GysFdCYjodo98IMZRYOk
	 CLhZ4l2XLJAS/mdGG6aL/3bojDMOT2bueGP80iUN7iYmgSy0dr6L/C0qPRHwtMvY9u
	 rzCIxehD3PF+tn877IjnIUdwkIKlMlFLXNFNnSJ+cOfMXdg8mj3i1hgtG7ScfOOS0F
	 gC5yvfEVNrvkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311D66085B;
	Tue, 17 Nov 2026 12:27:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CDB4105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A3CC40308
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_aupyv4Ktf1 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 12:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 04AE04008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=KmwLrHX0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04AE04008B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:27:23 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so2280520f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 04:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794918442; x=1795523242;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mIB6D+zWCSJ2NYtxVEzvwpiwm0FpR5YDhARSJhRfyAA=;
 b=KmwLrHX0h6XkcNJbLrmeRVLD9PU2P1Lw1Z5VmkjLELUxqgrzBN8n/mxFsNk4x45bPH
 VBY7eRr/sGwYpJyEJ3acQZE+oQnmFCsMHCDvFBTDlbFSgCOKFHCYA9Bri1D9DU+haH4o
 AvV3eREalHqiBcvIfXiKPSXItvT4rLSHZkrcEk5qI9rHTq5fUJpZfpjdEnjEOasU3qYY
 8Xf2oXbh8iq0zgWoU9dUCjYsrlf48J2spTYnX9knyib9/sDIG30mXJn6FV+dywNIBta1
 osTVu2Ty0qrtztBHXyM32zIQ/6GzgLSAH1LAIMbIEKG3C8djm/FLVR2Q7NMcruv/+RJq
 BNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794918442; x=1795523242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mIB6D+zWCSJ2NYtxVEzvwpiwm0FpR5YDhARSJhRfyAA=;
 b=zffrg9F7Ql36DsksyzeEMyc6RHjzJf44MlZFuFYIBdhjXiNNzlZyyqCRsfNGyDSPl3
 HTRhAU/VyoHEDvjtQ+aPcLw0m8fYTKNGYSGFxUJ/CYFqvt6euLZDb4ZkXzK/ADe0y1Gw
 ktGJeP+yvhW1V4CsdlpExMWrhzf95mxMf6OQKsLjAcQ5buy8DSmjJ2Fb/Bs/pvRMZXjU
 Qc+Gv7mTRyn8hROasSU5oMGTRkNF0qt5jqdWGgF/52NFjSzz9CP9+eMnKMgQ5/t2JOLp
 8L/Cg5nlBEM9fqfgz4McBGAYoAwdV1ij/WbgJ/c/IlbuPpOAYXlqdL2vV59U/4PW8qi+
 vJkg==
X-Forwarded-Encrypted: i=1;
 AL+hErHMjMXsADNB2cnookSVMkOifN0Cyt32sBfZ4wP7ObQgnjOVM04yrBbRAM5eoNNnX4rgQ7nWEPQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9czhJZaNF/4imB0w3YwGIA1YLueHzHoEbRoawY6dDPmCw6PhIt
 xn2rr0bhAKN37TWXkvzioP/zYxcE7HIWjWVrAsThZ4qVdJmWXbAcE4Y4
X-Gm-Gg: AZFdTZf9doZvONVcf+Df0IWA9nfnx3l8JSsey6roSu1NZwXhYJI99XyULrkYexSFc4E
 h+3gq/9jXZuv1FJa3Z4c4Eyea8T7DvqmSCBq/RTDGksxGtsKgvqnA6KrH7Jv9quhRiAdofNGGjg
 yHECSoXQvDd3D+X/gHjiKg0KClAK9xFJ+5gqTB5o02SR4YxVq1ePfoopAiAEXF/8UEpF0KFphUj
 QpeodKUjzuEMwwcJx3SwzZXEDwwywiwdMQ+GG0msu/Yah8+NaV87OnyXvM7kLSe8HXOmHQ5t/Wg
 vgs9ZaSYW7TSoq8YfCqVtwsCIPVfa04F6G5DfdedDVM4XcVZREhTetMSzJ3yeielxJ7Uz/HvjAa
 93JRolKDw8h7EOCLhBR1/s5U8q4nC3mVjYNaS2yW/vFT2TA+LDtcAee8hkqe2wYt1/d3Tih48VE
 xwM6JRDTiodFq1JjfYqMGZeOrq/S3zEfJH8A4TDLlDrPOXYcl5YXYBLNObVPrzzJeXXr+Zc4LRR
 OKv4JlPWj2dmw4tOYcP9YUaB93ZK2BUdMWGs5Ve4zTAay3a4nr/qa4ERapxatHcHgat7aJMVKG9
 YRhL/NF+vYWjwMChvif4+sgdada7aEHKBaU6EfHec0IRnnmSaUwHo/qIq40naOu9105qkZWduMT
 /5/qQojAmhLbv3UG0L7R1QUacn2eg5FoUFlsy0DhiyTqdwvZt3kwcKnk=
X-Received: by 2002:a05:6000:26c1:b0:498:bc2a:8f31 with SMTP id
 ffacd0b85a97d-49c73259d37mr36391745f8f.19.1794918441347; 
 Tue, 17 Nov 2026 04:27:21 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-92-103.ip49.fastwebnet.it.
 [93.34.92.103]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a33c344a58sm5243151f8f.34.2026.11.17.04.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:27:20 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>,
 Vincent Jardin <vjardin@free.fr>, Martin Schwan <m.schwan@phytec.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v12 0/9] misc: fs_loader: reorg and split to FS and FW loader
 + FIP loader
Date: Tue, 17 Nov 2026 13:27:05 +0100
Message-ID: <20261117122715.7983-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series mainly rework the FS loader to permit reading firmware from
container that are not exactly a readable filesystem.

Also splitting out the generic firmware loader infra from the
filesystem-specific code will make adding new loader types easier.

One scenario is when a firmware is shipped in a FIP container as
a generic blob with an UUID.

FIP are mostly used on ARM in the context of ATF.
In such context U-Boot is loaded as BL33 and the PHY firmware
can't be stored in the FIT image for the kernel as U-Boot should
not depend on the presence of the kernel to correctly enable PHY
for Ethernet port.

To handle such case the PHY firmware is stored in FIP with a
predictable UUID.

One example is with Airoha 8811H firmware where the FIP can
have a blob with UUID "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2".
(generated from command "uuidgen -n @dns --md5 --name en8811h.bin")

With these example DTS entry:

fw_loader0: fip-loader {
	bootph-all;
	compatible = "u-boot,fip-loader";
	phandlepart = <&mmc0 0>;
	partoffset = <0x100>;
};

mdio {
  en8811: ethernet-phy@f {
    reg = <0xf>;
    firmware-name = "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2";
    firmware-loader = <&fw_loader0>;
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

Changes v12:
- Rebase on top of next
- Improve log error for offset
- Add review-by tag from Simon
- Add additional documentation patch for develop
- Move DT patch after code change
Changes v11:
- Address request for test patch from v9
- Add additional test and comments
- Validate memory for FS test
- Fix defconfig order
Changes v10:
- Add review tag by Simon
- Use min_t for FIP driver
- Prevent double mount of ubi
Changes v9:
- Drop FIP blob in favor of dynamic generation
- Rename fs_loader to fw_loader
- Add additional patch for offset validation
- More use of lbaint_t
- Handle reading 0 for UBI
- Update MTD/UBI documentation and YAML conditions
- Make generic_fw_loader_get_phandle_desc handling explicit
Changes v8:
- Address all the comments from Simon
- Massively improve test coverage for both FS and FIP
- Enable mmc node when needed for the tests
- Change FIP implementation to follow FS one
  (read up to buf size or end of entry size)
  (complain when offset is bigger than size of entry)
- Update related documentation for fw loader
- Rebase on top of next
Changes v7:
- Add tests
- Rebase on top of next
- Fix compilation for vpl
Changes v6:
- Rework to generic FW loader UCLASS
- Account for firmware offset in FIP loader
- Add UBI example in documentation
- Improve variables order
Changes v5:
- Fix unment dependency for config flag
- Move request_firmware_size before FIP loader
- Add documentation patch
- Improve get_fw_loader_from_node() implementation
- use min() instead of custom MIN()
- Fix handling of some return value
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

Christian Marangi (9):
  misc: fs_loader: fix ubifs not unmounted on dev_get_priv error
  misc: fs_loader: reorganize and split to FS loader and FW UCLASS
  misc: fw_loader: implement generic get_fw_loader_from_node()
  misc: fs_loader: validate requested offset on reading file
  misc: fw_loader: implement request_firmware_size() OP
  misc: fw_loader: introduce FIP loader driver
  doc: dtbinding: Update documentation for Generic Firmware loader
  doc: develop/driver-model: firmware_loader: document new FS and FIP
    API
  test: dm: Add test for FW Loader feature

 arch/sandbox/dts/test.dts                     |  38 ++
 configs/sandbox64_defconfig                   |   2 +
 configs/sandbox_defconfig                     |   2 +
 configs/sandbox_flattree_defconfig            |   2 +
 configs/sandbox_noinst_defconfig              |   2 +
 configs/sandbox_spl_defconfig                 |   4 +
 configs/sandbox_vpl_defconfig                 |   4 +
 ...irmware_loader.rst => firmware_loader.rst} | 101 +++-
 doc/develop/driver-model/index.rst            |   2 +-
 doc/device-tree-bindings/misc/fs_loader.txt   |  48 --
 doc/device-tree-bindings/misc/fw_loader.yaml  | 112 ++++
 drivers/misc/Kconfig                          |  31 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fs_loader.c                      | 326 ----------
 drivers/misc/fw_loader/Makefile               |   5 +
 drivers/misc/fw_loader/fip_loader.c           | 559 ++++++++++++++++++
 drivers/misc/fw_loader/fs_loader.c            | 261 ++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 231 ++++++++
 drivers/misc/fw_loader/internal.h             | 100 ++++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +-
 include/fw_loader.h                           |  42 ++
 test/dm/Makefile                              |   1 +
 test/dm/fw_loader.c                           | 254 ++++++++
 test/py/tests/test_ut.py                      |  58 ++
 25 files changed, 1802 insertions(+), 434 deletions(-)
 rename doc/develop/driver-model/{fs_firmware_loader.rst => firmware_loader.rst} (60%)
 delete mode 100644 doc/device-tree-bindings/misc/fs_loader.txt
 create mode 100644 doc/device-tree-bindings/misc/fw_loader.yaml
 delete mode 100644 drivers/misc/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fip_loader.c
 create mode 100644 drivers/misc/fw_loader/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/fw_loader-uclass.c
 create mode 100644 drivers/misc/fw_loader/internal.h
 create mode 100644 test/dm/fw_loader.c

-- 
2.55.0

