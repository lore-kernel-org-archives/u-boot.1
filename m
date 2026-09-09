Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC05EC79FBD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 15:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AD4380A5A;
	Wed,  9 Sep 2026 15:52:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-9EwAYpxgSr; Wed,  9 Sep 2026 15:52:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 17543806F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788969174;
	b=D0G5ITQS53tbopYGXWV3Odr3I83QYtwAamck7frt9aHBxnGCz5zkQlqBrr+XEliswaTS
	 odTicGCWV/MGejV3acDnBcG3mjO4AgUOL1r198kwbThMWpIp6VLps2aO8hFOycBcViCTv
	 iSx5sbkddCpf4WjImVzKJzZ7Tw/g1rRD+6cVo6+H46e1SaxOOac1mBDXJslv9wbDf0Q7O
	 J6PEsNHOuCWJc03mrjUh6IMcmlQhiKk64mzLvoFY2CEmWM2f6FyslFICUvQtcaYCfuMWk
	 tTPCA0gf2aQ7zvy535jaPZBWZ+JqeevSS+x9IpQA+b4tX3C0vv8QQ6flTigIc37gaqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788969174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JP+N5lCYfyP8jJB+cDu/whBsQIsnR9yEX6s5RN6AVDA=;
	b=D1XoONLGHgQWTJx1DmDEYzFvkicCPyFNJxI0kCaqyrlGq3kDiLFQzchqgjBCcaxDczXE
	 lrX/ln7vCLKORorAUv6aZ3MGmnYJDU4emOxPqkN9LIlbu41DLwRKuQc4OlUDGb/5e0WIR
	 xCpKE3MgWxBOP4p83o0okNkbFnRqrsnC8lCniAo7AgrvhdoM5Jr3z8yPlu9CEnZSt1uSB
	 Ys6hx6CwMsWApuJNX/zKgDasCxDqgcYGZFBRa31sqvpm2AlIpmJ8Zk9TfTK7qrW3eO4Ru
	 qs9r23oUpx074sf60K3tgzwdnbV34pKwr/A82BYCEi00lznNHen3ICEGDCN/pj4qebg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=none header.from=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=MdVwZdmj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788969174;
	bh=JP+N5lCYfyP8jJB+cDu/whBsQIsnR9yEX6s5RN6AVDA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=exT8aBRuIm8HOeLyNqhrzjXRo8lNpdi0ChiN5KFvSwdLrs9hBLS7r36YpOsPjNVxd
	 GEws97TBeB9Ada18XbQ7Xkrx1hTPJxxeqK4Qy71cuhTRHJ0fpNQ02mFWnMWG4rt9uV
	 u5+zG7T+o0qUv12ZTB8b96dLb3VRAUxXDMXvQ9JtmN48IP6QcVsOx+Tt7M1Fy1wQ0x
	 XS4SUbpRvW9VnQbP7js7IrvJr6t5Gti9c4JLL/wtqlHMYqjCOJ4lVaTEgJxq/GoAHp
	 M/rpTU0otAC+yU9iNdbPbkuRsoZNGf+6Q22nI4+0Ol/dteD8JLGEBGqbcFJd045rRm
	 sqewGnBKSslaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17543806F2;
	Wed,  9 Sep 2026 15:52:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA33A1331
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7896806F2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WqI6pF-xhqeY for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 15:52:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C992880DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788969168;
 b=pGxWveVBJUbNf8vKVff4fgzMRMzBqSh9b271aMSC0Pi76C16LJjyJ31AczW5fzLDzlBC
 DzHddMJSuJANmeJCJI0nwYp1cicabg8V0iAFkUYgXzMwUZ7qNEGld7PoIKMGsPMtVEyAR
 mzq5tAo0CtdWx0ZJLrkudHsZe1KiuZn0/rutOcDtEvzv05+0F7nzAOWGDmN3BEjS2tBZN
 0dvF+YVwtCxNUy1piB6KklZrwfuBWpa+hNc+ltHzIK+jYy0y+LI8u42GQED/Jy6/nnwqT
 WbgOpinfN3WQVI2Jk3FCmT2hqj7yl6JXVa5LHdU8DR4GDarTJRK1y1eQhbIO9d/hFVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788969168;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=JP+N5lCYfyP8jJB+cDu/whBsQIsnR9yEX6s5RN6AVDA=;
 b=mdxy2njvDFTjgSNEEyL3W0Bbl7qljDF0LL6YP1ZoWPd05Mu/1d+IZ/RFUOB7VCKHArCg
 deJv6sGZUybCwRTHS+2AnPCLyVIZIv2sLoZrsk/yY8nv4pQ/QptwH72et6vNF18i3/mq4
 xlq1FvB2GaP5j6BTf5nJg4mtvm437xD5IrD7Ql9r1Zzkp3yuaMpInrsqc5pD9gTZR/Y4U
 OtgY72I8FcBZx3m4B4jhanZDPAlArLbj6R+jbMMzIeqPzwDSn6fTajlcNhNA8+4D7G2jO
 FEJW4NkVPOXqTHf7EGyS3/nxAyepu46tD7asAu984Qsfr4Uqe4ft2IVZaVZwOP4G1Rw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=MdVwZdmj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=MdVwZdmj
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C992880DFA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 15:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788969126; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PqrMT/c3JbQQE0Omryw7vk4c1uHG4BMsb3vPexJndQdOaO3XF2JPkC6aNXMRyU9KXcxLjXLGVXwmdJbd/RGbEL8u3C0Ae4dU9Sy63MRZhPci8AQhiHHYKlMPE88gOb152y7QzqlVjDbgKSoS1G4Z3imNuJlQ7hDdswStOKiS/1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788969126;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JP+N5lCYfyP8jJB+cDu/whBsQIsnR9yEX6s5RN6AVDA=; 
 b=T1JDUoE1cAbI3+UNPUUZ3ZzY2RgVbF9eZW8r8Zw3KiprO+SxjBMoG5qSZ8tgRUn1akV7hxFf+WCXsFnPzMuE3LOsUK7F7i0Bx4U+pItHmp+EQDcRxf6fHInNn2ZzcVWayn2yzG7zkVYnfQhf4UWF6a0g3PLAeKGincD2J2OP3sM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788969126; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=JP+N5lCYfyP8jJB+cDu/whBsQIsnR9yEX6s5RN6AVDA=;
 b=MdVwZdmjB03UZM1Wo00qxlCFqdwdSMtrrKa7yfEiY+xPdyXauF+c6k0b4KJsRfvJ
 cD+kdX7uWUj8bh6AjyNAWtnuZquAkS0YTsmeOflIV1HCFiHap1kt/JuM1J4meqBE65/
 rRWMa6/jTdLRyaBN2YK0XeBV4btcxquTTvDw1kD0=
Received: by mx.zohomail.com with SMTPS id 1788969124329972.2090186596714;
 Wed, 9 Sep 2026 08:52:04 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v2 0/2] tools: mkimage: add SpacemiT K3 boot image support
Date: Wed, 09 Sep 2026 23:51:07 +0800
Message-Id: <20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBAFf4Xs2Zq2VlI8+R+GQykLXSOUtLXRE
 P5dwHjxOMm8eTNEDIQRLsUMATNF8uMK8lCAdWbskVG7MkguS64lZ3EyFgdKzJBrGT9bVRqDWpc
 I62YK2NFr793qL8dnc0ebtshmOIrJh/d+mMXm/dryr50F46zplFWiqk66EteJ+sEH8zgmtA7qZ
 Vk+Jq+9FsAAAAA=
X-Change-ID: 20260820-spacemit-aihd-05c46aae886e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2703;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=yPBLvKfNkdscClw6kvY4qBBn2L3O/X+7KkIqhI0Y5Nc=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLIWNkwJOPj5qafKdpcw+RXmqe2H4ziXRUxgvdz+fU58e
 ZnV+vOnO0pZGMS4GGTFFFm4/MX/WevwfDsi0HofZg4rE8gQBi5OAZiI+lNGhif2Hz54Hpn0uzvC
 6Pjm3cov2stOz5jTLFjAtchm9qK6vxoM/2s+Xu7S3nEueN0jv40L6jjWeaTvuiqwRtHZW39RzW+
 li8wA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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

The SpacemiT BootROM loads a first-stage bootloader from storage or over
USB in MaskROM mode. Vendor firmware packages this bootloader as FSBL.bin.

This series documents the SpacemiT boot image format and adds the
"smtimage" mkimage type for the CRC32-protected K3 variant used in
non-secure boot mode. It provides the FSBL packaging needed for future
K3 SPL support. Select K3 with "-n k3" when creating an image.

K1 and K3 secure boot use RSA authentication and are not supported yet.

How to test
-----------

Rebuild mkimage, wrap a small UART test payload, and load it through K3
MaskROM fastboot. The payload is linked at 0xc0801000 because the BootROM
places the complete image at 0xc0800000 and enters the payload after the
4 KiB prefix. UART0 should print "Hello SpacemiT K3!" and then loop
indefinitely.

  $ make tools-only_defconfig
  $ make tools-only

  $ cat > k3-uart.S << 'EOF'
  	.equ	UART0_THR, 0xd4017000
	.equ	UART0_LSR, 0xd4017014

	.section	.text
	.global	_start
_start:
	la	s0, str
1:
	lbu	a0, (s0)
	beqz	a0, exit
	call	uart_send
	addi	s0, s0, 1
	j	1b

exit:
	j	exit

uart_send:
	li	t0, UART0_LSR
	lw	t1, (t0)
	andi	t1, t1, 0x20
	beqz	t1, uart_send
	li	t0, UART0_THR
	sw	a0, (t0)
	ret

	.section	.rodata
str:
	.asciz	"Hello SpacemiT K3!\n"
EOF

  $ riscv64-linux-gnu-gcc -nostdlib -fno-builtin -fno-pie -no-pie -static \
    -march=rv64gc -mabi=lp64 -g -Wall -Wl,--build-id=none \
    -Ttext=0xc0801000 -o k3-uart.elf k3-uart.S
  $ riscv64-linux-gnu-objcopy -O binary k3-uart.elf k3-uart.bin
  $ ./tools/mkimage -T smtimage -n k3 -d k3-uart.bin k3-uart-smt.bin

Hold the FDL button, power on the board to enter MaskROM, then run
fastboot on host:

  $ fastboot stage k3-uart-smt.bin
  $ fastboot continue

---
Changes in v2:
- Use "smtimage" for the image type
- Update the documentation and command examples to match
- Link to v1: https://patch.msgid.link/20260822-spacemit-aihd-v1-0-bf4c41993891@pigmoral.tech

---
Junhui Liu (2):
      tools: mkimage: add SpacemiT K3 boot image support
      doc: board: spacemit: document the SpacemiT boot image format

 boot/image.c                    |   1 +
 doc/board/spacemit/index.rst    |   2 +-
 doc/board/spacemit/smtimage.rst | 143 ++++++++++++++++++++++++++++
 include/image.h                 |   1 +
 tools/Makefile                  |   1 +
 tools/smtimage.c                | 202 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 349 insertions(+), 1 deletion(-)
---
base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
change-id: 20260820-spacemit-aihd-05c46aae886e

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

