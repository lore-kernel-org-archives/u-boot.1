Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A591606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o/8KKxaU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ybfo62rS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D9B180CEA;
	Mon, 26 Oct 2026 19:05:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SyE6pf9UbGRp; Mon, 26 Oct 2026 19:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 23C0180CA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793041501;
	b=bNYo0Q5HBcSl2LIGhADqtFRq38gfjsT4g50f7pKztFK0RA6okBO6ilIPVPLIcgBoYMCR
	 TnpjYC07AuFbfoi1PUae/P4bXxdGlBRWd0RYYWdaR1yIo7Rd59ZjBB/SfbQapmD94eShI
	 Psgle86Idy72R3BpAzkII0MmbBkmffbTM4ZNzOhI9vUnLauEL+VitJQXiPVLGqwv+H2Wi
	 I6Njn7XbWy3YBGenWMlpUAeYwNVpN7UaqFdneRZ7j+6N6PVEXwDr5SbBfNHQpJdpwrCqq
	 eOjt36VYJQGV9iVrlemFMR6h9R50ZNus0r1typJXg3L6om4qMfbnbiV8AbvVb5YjLGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793041501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=POVqIXgt2YiHtYT53576AgiH67Lw8cq4M9yXRfbKqr4=;
	b=sP2IBAbSFJZ2DRpOWkE7CVTELjXZn25tW7KAPAgWhW53fz6apkyPl6c1PuEf7SwwbnVR
	 D3FPdVhNaZV/7/M8hHp/rqEikKj9iUp6DmIftlCvFEThznUzczjk6Q+leeZ4AU2FW/xkR
	 yVwWggoIz6vUJqpHcgIfiOcFN4ZqnwvvnNcC35iFvSlHLxc5/TozJZ0WXLkXLt2Pyd0OK
	 yMtkBrVNdfOodrN8khVGdK7ur4ZVDAFP22WJb7cIHPtaSB6P6NHyAixOZBgLatW8uVONy
	 Vxy9kiTE9d+AV12IXn2kTlaZAIrLY6pY8cdL+T1L9yqVNMlgzAiZ2p72TynOrguTPrw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793041501;
	bh=POVqIXgt2YiHtYT53576AgiH67Lw8cq4M9yXRfbKqr4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o/8KKxaUJ9N3UX0WWR6G1yE27gj16XkXLu9YLCW17pYuqHYMYIKYhA9+J1d3nFi66
	 hCNw0VNZXdFCsrExQ+vJu39HMeBLO8nHKr9lXVTmeA9LzP1IvXAs1LTRizH/4wmvQ3
	 VoWkvhgbBcl4E5mc3P7Og3fcKAdRgGCHGs1cszo2NZJF5x+y/hggBRk0mkkzdRERDs
	 eELx2X2jjO94tB6/jWeA35nHPKRhdih22te7j1TpKLJ5gx+SU1SweZno7nDO+URK8R
	 JlkoAVWCgu2kLc07kdRHP9Q9WIdKLi/aZxVmKxyAIyTYmQDbMz1HQcRRSIDxFyJZLU
	 MxGgCpNC+3ydw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23C0180CA2;
	Mon, 26 Oct 2026 19:05:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DC0835F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F623605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpU_MS-IdMAV for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 19:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12939605E1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793041498;
 b=pmtEDio7OvczlffQrv99Gb8yl8Lo4/jmBkg+Q5GBIHwzgqfF0hpbdmdjOllrEq+Dune1
 zmoWtWhVEe4nknYe5UBXR7jjaNRNcY3bdf0fu2VzB1G5tCLUvmWHTQxy3nKPNLarNQmX1
 sC/U16u2Xco7i6N/a6PeBFGySGuBMeJcCtbPYSGcRy9LhdizR5nw9QzTko37JTKMLETU9
 sgcouhGnq3GQYGXHBfXAIQVa3BlhdRKT6yR2/G55/B4NmFnd/eFcju4uEaSNnc+F0APLV
 LhbEv3dGH+HhyH+Ki4GsaiV565VGeYRTVOAvLmn0flc1mwCnWmHgcz522OcWWeoM9wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793041498;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=POVqIXgt2YiHtYT53576AgiH67Lw8cq4M9yXRfbKqr4=;
 b=qxqCJgomfYazLeOKMGaRPbJS1eSueyz6kR1r+8X+cFUgimWtxP4rJCvLhLTYtNTNsTyG
 e2kpKhAqUIkeInZiaf1WrdGTR2lrk//jlbWopF4todQq7GuEVBEu5IBqv4nDIUUEQUsU7
 LKS8+7ynaLNwqaUOGLaovfGBtf3NJ7VsDCNwa+ue+mlkVT6jAaO0qeR7GwMANpkDh3SZA
 NDCakpo/rx7ZcEH+lfN+iLiVHEIxlm5lCfgWPyd65Q+AHQGiJJgvQkhRnDeLwSy/Z14rv
 OQHVMeKhiLBKFtQju8TMJN80X1zuaa7+ogiDiu0dHav3imVSUU/YHkmVxrWr7XgiepQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ybfo62rS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ybfo62rS
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12939605E1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:04:57 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5eac6c5f927so1357039e0c.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793041496; x=1793646296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=POVqIXgt2YiHtYT53576AgiH67Lw8cq4M9yXRfbKqr4=;
 b=Ybfo62rShomJc/KZVUJriNT5MoXgh1U2GFaFVHS5oQ54dY7SpCB67J1fC4v8WnMEJN
 C1oKqz50MKRSlj/k7hZSkTYgybFT+lITpoEp4gQo8SHs2Oicdnm5rKK48CtMEBy3Xdy8
 K2LM5VuXDqfk6RfHBr+qgpDe8cePTHtMauepgMYLKO4eKJbGxIKUoj2erG/Ui+Z80l9G
 OYoM7ioxJ0rk+afLWDDjb8NLw0YO5i97IkLFJ9pKsAMoz+adJK9DouVF2gBt4mIJDT/x
 LhfaDvtNHeev+qlA/u3/GvmgW4cZk+B5Alcu4451D+Mu3hSnj0iqQMsGC5pMkM94b6f8
 zTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041496; x=1793646296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=POVqIXgt2YiHtYT53576AgiH67Lw8cq4M9yXRfbKqr4=;
 b=vyEwEPvacPJp295RFvPj8PAHrDPz7Sto/u6i0ImGP1zD5yPmPkDVeJAfPdxwwEwHmp
 WxCtkkimucRGzpI+ZJbpoJS3+O/mdBrJNFKI94vI/tzaqjsKmpmcInvTI6f4wkkViLy7
 ZgwjT59QYeOt1q9FPisC2CYoh8EzBsZm619PYGPWfmVJtz1UBw7TrlQp/IK8H0b+N8/U
 xmZ6QckCSYngQnswlw9+Lv5RYfZrEwxRrtbu9/1v2f+bnZQqiyZ+f1xXngn1wd9m1ifV
 V4sMjyogHtd/lMAfMSD6TO48x6q9Fmh8KxVYf/5D7qurCzdxeqm/JzqrjLK01XbsXS8i
 kmlw==
X-Gm-Message-State: AFq9FYK8gc0c8c+glAz15yu52/jtgV6i3ikQD1x14NFF4tYHx7C3jZxt
 ciLDnsmpV2OCkGn/OhGGyP4Hsani0VzITCesvIXr1TfJRSV/2gsgmVp9svctHQ==
X-Gm-Gg: AYBFou0ItpPxpgskrWcsIGXfbSCX5kj0a4n8/QnlTMMmtFTqnQwzV6o8c36LpyF+owJ
 A7c18Wy8db6rJEuWsdDjE0N88aBby5TqmXpSPhBWaWPchbIzn4rdftLE2BYsc3+YxhG7U1x055W
 u3CdaLwh50qdkw9KeyjCUzSrwbXqSbkV9IuQmp7NaHz05P06zp81GJCVK0FsHf44Kx4115QVW+r
 okQp8ov9J//nv8HWZ4Oml905RTNNF0MYIBqqtTqfQXtZFAwriEXpneDlsWYMdOL3GgPaAd2i5HH
 KfiVmNES6YkOz/qOIK17WMz6qG1aXvYj4dW0NZW+u/1bRWcmMtNyFgAWmLxWVAkMmdnj4zgogv6
 hsdVQQF+YgwRgyr35+YzFsFesKJY+tXuv7hB16w+f7Nzi+eBwygm8AR/fIT7eBJB9AIKVU0vFkK
 IlKrw3PhNev7UAY4rslNojNY7j4PM3fYy4N2zfnFHh8FFtrOkpf/aLUXj7qSoTgNR20QV9sbB1k
 4VHEOucWjjQjHu0YzIdBmivvDJvV+cnU6WROvTFMJy4teiGOqvA8RC4mntamQrnwQW/+vISM94/
 SN97/9lVg7lSeTElDMKDn7Tg1nLEcHVOvNDzrHy1Gw5QuPlkKQ==
X-Received: by 2002:a05:6122:1787:b0:5ea:de2e:545f with SMTP id
 71dfb90a1353d-5ec231ef129mr2791669e0c.8.1793041496261; 
 Mon, 26 Oct 2026 12:04:56 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a801:e068:1849:4759:7bb4:e279])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec234277b8sm9086328e0c.8.2026.10.26.12.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:04:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, bin.meng@processmission.com,
 francesco.dolcini@toradex.com, frieder.schrempf@kontron.de,
 qijian.guo@nxp.com, Markus.Niebel@ew.tq-group.com,
 mehmet.fide@screeningeagle.com, rnunez@baylibre.com,
 stefan.eichenberger@toradex.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-main-20261026
Date: Mon, 26 Oct 2026 16:04:49 -0300
Message-ID: <20261026190449.1771759-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit 8649a54d301a4d0ac526324c7a7ad2574939ff27:

  mtd: spinand: winbond: Clarify factory BBM offset in OOB layout (2026-10-24 08:24:15 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261026

for you to fetch changes up to 6887b66797ec825e69c1751bcb716fdfe39f3fd6:

  colibri_vf: separate the partition numbers in dfu_alt_info with a space (2026-10-26 10:51:28 -0300)

u-boot-imx-main-20261026
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/1731

- Only read SCU for i.MX6DL/i.MX6Q/i.MX6QP variant detection.
- Use the correct GPC registers for the i.MX8MP DDRMIX.
- Add FRDM-IMX95-PRO initial support.
- Implement memory translation table for i.MX6SX.
- Fall back to NOWHERE env location on imx9 SCMI.
- Support newer GPU0 bus node name for i.MX8.
----------------------------------------------------------------
Bin Meng (1):
      arm: imx6: Only read SCU for i.MX6DL/i.MX6Q/i.MX6QP variant detection

Francesco Dolcini (1):
      imx9: scmi: fix up thermal trip points from the temperature grade

Frieder Schrempf (3):
      ddr: imx: Use the correct GPC registers for the i.MX8MP DDRMIX
      ddr: imx: Recreate the power-on state before repeating ddr_init()
      imx: kontron-osm-s-mx8mp: Remove DDR reinit workaround

Joseph Guo (4):
      imx95_frdm: Enable remoteproc for i.MX95 FRDM
      imx95: Remove container.cfg and imximage.cfg
      imx95_frdm: Kconfig: rename board prompt to imx95_15x15_frdm
      imx: Add FRDM-IMX95-PRO initial support

Markus Niebel (1):
      imx9: clock: Add missing UART clocks

Mehmet Fide (1):
      colibri_vf: separate the partition numbers in dfu_alt_info with a space

Ronaldo Nunez (2):
      mx6: implement memory translation table
      imx: bootaux: clarify comment on firmware support

Stefan Eichenberger (2):
      imx: mach: imx8: fdt: return libfdt errors from helpers
      imx: mach: imx8: fdt: support newer GPU0 bus node name

Ye Li (2):
      imx9: scmi: fall back to NOWHERE env location
      imx9: scmi: Remove useless scmi protocol devices probe

 arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi |  65 +++++++++
 arch/arm/include/asm/arch-imx8m/imx-regs.h    |  10 ++
 arch/arm/mach-imx/imx8/fdt.c                  |  35 ++---
 arch/arm/mach-imx/imx9/Kconfig                |  10 +-
 arch/arm/mach-imx/imx9/clock.c                |  34 ++++-
 arch/arm/mach-imx/imx9/scmi/fdt.c             |  14 ++
 arch/arm/mach-imx/imx9/scmi/soc.c             |  15 +-
 arch/arm/mach-imx/imx_bootaux.c               |  17 ++-
 arch/arm/mach-imx/mx6/soc.c                   |  37 ++++-
 board/kontron/osm-s-mx8mp/spl.c               |  14 --
 board/nxp/imx95_frdm/Kconfig                  |   2 +-
 board/nxp/imx95_frdm/MAINTAINERS              |   1 +
 configs/imx95_15x15_evk_defconfig             |   2 -
 configs/imx95_15x15_frdm_defconfig            | 139 +-----------------
 configs/imx95_19x19_frdm_pro_defconfig        |  12 ++
 configs/imx95_frdm.config                     | 140 ++++++++++++++++++
 doc/board/nxp/imx95_frdm.rst                  |  29 +++-
 drivers/ddr/imx/imx8m/ddr_init.c              | 196 +++++++++++++++++++++++++-
 include/configs/colibri_vf.h                  |   2 +-
 include/configs/imx95_frdm.h                  |   4 +
 20 files changed, 573 insertions(+), 205 deletions(-)
 create mode 100644 arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi
 create mode 100644 configs/imx95_19x19_frdm_pro_defconfig
 create mode 100644 configs/imx95_frdm.config
