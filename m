Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E93BCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D91B0608BF;
	Fri,  9 Oct 2026 16:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QnklNsz4Ibo4; Fri,  9 Oct 2026 16:32:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5233607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791563534;
	b=eJn/S76J+O1QqCJpT71+3O4UXHh2WL0Y0sMuUo/XoiYwFqnWN41TPJQ24B+jGTRcKjIb
	 2AMB+j89wd71+IaQDXeHgXgyxCdKm/d2ZmHojtz1Sg0gkZZBaV5W32J6ex089lkTMEvWV
	 Eb3QSqmnPxbwfTGnr2/dAJiOD/2uFrv/LjXDimtzbOz/8aDmNpwA+T9R+2aRz/s+KujOj
	 echRGLRR/n/0xY0eT4E0Jfff4XCmv4G+ve7w4dIJT9u8b7/HMf2RYsr51VPw2ExJECG2c
	 3lfBg7KO6QctOl8EUxBs+/2EKzjrag4mlZnVQUsWTo5S3imY0kRXmn2uwOq5G9FB82Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791563534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jPg2AhsUuXGeAL2wAk56bcng0ZFl4sCfdPT41d9ques=;
	b=Hu820p/CnWy/X+oUr1d1DoGJdlwwUwHGz+RonO+ly04NHvv52Lpp/Pqk2/+3SfUh+ua9
	 /oDmJdUOvubadL2Yu9xhMTWorzfV6kfc46Ht918NxZ/BYZtsrIfyguTxjd1pPF2QoltLi
	 KpYHBRU+Jr+AlYMgeKFmvS42TmsNYRH4iIYpgKbqhhKIFygcTTrcAS33iNzmSc8fI/DVr
	 /M8qNLfMVDq1wKQf3U2P5US4ifnUbPjsRNEMMKHuznc6wbkPFkPLjRa3QEAD1XFlzH7Tk
	 ZmQ4hKTxbMYkSM7vSQgF8Kcia5yaRuwyaSefwG/Sv+rjF0GL4ZgE2FWB+bq83kiMltQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791563534;
	bh=jPg2AhsUuXGeAL2wAk56bcng0ZFl4sCfdPT41d9ques=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S/N1vd8y6eCWc3d8XRrlO/q/AzDpbySTYb+tYFNMZ6UEuMgsQWQxb8NB/xAFa1Pno
	 a/j1MGchTPXiyzm6RVhSPT7ExJU4KMMaTi2Rnevuumqbs0w01KrGhBTu5d8XjGEsNL
	 vyI37Tk5NrIhIKhG0kt1nCIgw/ze4EFi/og52k1I1ZmUg10gD4vaT9OMzsyrTic64p
	 s6c4cggln+VBlnWNGa6D3iwTP55MM8zCL1/2B8fZQ9lW/Yeuiw05UDp7tGFPM+VB0v
	 qBkygZ9ulXba+Tvl/2bzCc4tj21rzgukPil9Y0Af7Qs2OcYf8K5NE8e0CiMvJmCB0R
	 A6GruJG+vGqjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5233607B2;
	Fri,  9 Oct 2026 16:32:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC539422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D8A540050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sznn0J18_TpQ for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:32:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DC726400FD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791563531;
 b=NQ+ulePkp4QqToUZH2bE2+9syriHqZhDdJJJZ8TpWErkxijkYmSp/SvZIBVdNKlozrdQ
 F+KZ15TEp6xBsK+6Au5UVz69hjNe2Af0Cf4Obx4E4l8NRgSbnNaIdSMCpBWhX9bmDfp6M
 cesEmp5DFRfoKiGmRWfNVA3jJ6ihW8wyku49tTYI/E264l+1M2O2S9ruP7Q8CVKH+mWE0
 yswA4CF+tmOJy5cZIV7SI1KkWof/esLf2mG/s1ABvq+KEKsZbsUC4KOZtcyYu4UDV3HXd
 2jjWFONzVvX3GfVR/qOpJ3nuOz2LQw9B2dRsvTBO/CCII8pVlP2hzLOAPRAtxcppNNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791563531;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=jPg2AhsUuXGeAL2wAk56bcng0ZFl4sCfdPT41d9ques=;
 b=dG+aJ8bXllsEhEZkLmBTYttlsrprx5hi/u0wZeYrln5ItnOy8tIa6UxK6uDVfXm0MCSv
 DTDvYW1nzQ059SId3NPeelkCLs+tBSzvFK+6kTc6IJoDYErfTX++Xwmk3RN1ChaOXTJO5
 tf3CPwiNAlPc9cNNIzRMIo5HV9t+BBvL19hEzVtP6KVpb72nG6qyibVsg/kXppHl/AMJ0
 vUdePDeriiujlOxBzZA0Jkfu6iQni6zS/akAAr4G4k8nlLCl3fbdDMR/lfLrOw+btytyK
 fWd9zOieSLLp7IKQI1cA+YuJEm3bEBteJ+WAcjlFrnEJbk6gNQ0dVfP8HR2QEfMCTtA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=pigmoral.tech;
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=kzTDvnFS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=kzTDvnFS
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC726400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791563494; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=blI/M9VYn3hwXWzrIgp47dy6DSjtajhbLZouj5evtVPxd3y9l3vdZMSolt9vAyc56fUS8ZKWFpubYPK8/GawVUpcPb20/EA7JICdEIUyaqy5b+np0fODPas7H94rHNPltVNlYLNMbs6cAfcHbMtYK2Dg8duZb/pwNDJXKri+0o8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791563494;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jPg2AhsUuXGeAL2wAk56bcng0ZFl4sCfdPT41d9ques=; 
 b=co2hkMGCSmAOk2TJ4f8h3y/OLiOJJIj0LcQOeTOksZ8f5LEDyX9itAMsslL+9youuahOAvHpGUAQ2i4YmHVrTheN5EheR/NGXWZATauUiYrqWMSf3OXZRIJxuyyYNUOyybYE4LPwb86YbXt+qupFPJgnHBK9b2hsWNciydQVtqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791563494; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=jPg2AhsUuXGeAL2wAk56bcng0ZFl4sCfdPT41d9ques=;
 b=kzTDvnFSGYbQZrcTksNugMK04rP69oIJ3GjGwMkMg4hwblpst9rz8qBgGL8Dm2Vn
 kwz7q+jj/xc7pqwUEuGYpLt58HrnWM6mld4SvDUio9bahi3zezh4fluOSCebacISxiM
 Dm1KldhCUoxg4/jpD4WhIBCajS/Ejb7/fEY6ur1c=
Received: by smtp.zohomail.com with SMTPS id 1791563491939418.3864654210653;
 Fri, 9 Oct 2026 09:31:31 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v4 0/2] tools: mkimage: add SpacemiT K3 boot image support
Date: Sat, 10 Oct 2026 00:31:06 +0800
Message-Id: <20261010-spacemit-aihd-v4-0-e7152ae4d71a@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NwYrCMBDG8VeRnDeSTNuYePI9xEOcTuzI2pakF
 kX67qbKslI8/uGb3zxEosiUxHb1EJFGTty1OcqflcDGtyeSXOcWoMAoC0qm3iNdeJCem1qqCkv
 jPVlrSOSbPlLg28vbH96drscz4TAj86LhNHTx/no46nn3Z8PCHrVU8hhKLLVzhXV61/Pp0kX/u
 x4IGzH7I/wLTrmlAFnYWEXOYoBA+E0oPgTQS6HIQjBGBbRVDb5aCtM0PQECn9gXRAEAAA==
X-Change-ID: 20260820-spacemit-aihd-05c46aae886e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=Dc3kh8O3/9scyoefyDoS8KF70UKjjjEbXxGRkDUU99g=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJOil2UffecM+3Q8wWdu/o83EMV391au+6X1xm7O7KdS
 +w8JdKnd5SyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCRaUqMDJ8sAjjksyemGn/w
 9TseOceXRVe6wfD4pAwrgczw0B3yixkZlmxk67wSvKHTTi/m17vz8iFtO1UZZrUVVHDs0N02y2s
 7KwA=
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
Changes in v4:
- Revise the documentation wording and layout
- Collect tags
- Link to v3: https://patch.msgid.link/20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech

Changes in v3:
- Align the uimage_type table entry with surrounding columns
- Explicitly include the needed headers
- Drop SMT_PAYLOAD_ALIGN macro
- Simplify the NULL check in smtimage_get_variant()
- Fix the title underline length in smtimage.rst
- Link to v2: https://patch.msgid.link/20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech

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
 doc/board/spacemit/smtimage.rst | 144 ++++++++++++++++++++++++++++
 include/image.h                 |   1 +
 tools/Makefile                  |   1 +
 tools/smtimage.c                | 208 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 356 insertions(+), 1 deletion(-)
---
base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
change-id: 20260820-spacemit-aihd-05c46aae886e

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

