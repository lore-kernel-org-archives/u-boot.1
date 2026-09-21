Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DCEC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 15:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C10A740A49;
	Mon, 21 Sep 2026 15:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SeQV3OebgDnL; Mon, 21 Sep 2026 15:11:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0AD5F40723
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790003467;
	b=Aqrb4n+lN3bJmvrMQlk7ogNSC51/n3LxZtEpWCe65lYbF3jI02qjnPB8pLQTFkvspWJR
	 CFWB4xR1olhzzj7uf2c8tV4HdppkOYd2eM/t1Huzl+jeS7JDi6FlnNqEKtmNtqwyBYGzZ
	 V1OeV2w0M1dQ+YfizoDRWu/BFLtjPbNcZZ9Rf9qzynfk/V/czXHVIIP+w5eLE32o83K/F
	 Ep7HDt/Fmu3Ne0OJ7jRLDj+QzgiF9M+1+lvZIuJvduD8kCpRVvEab3uKuE9pxIB5KwOlZ
	 F6B8qxoj3PCkL0kb3jZ9EDtKtO1BNWVQwbrD2fmUZwfmDKFvMIMTYw9Vml8yUQ9nxyQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790003467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6dUCksfe35U2AM8kOrwiaY5uc1/51X6bL0JK+OitqVQ=;
	b=dFmI8bwRbB8PU4gsyyDmfxYmneUuJMBiOnGki4bsnLlmOY1fyx/H3KRpdqVkeVMhk4XR
	 i+H6etp3C+FT2u6JNNyqcr4icYA7652hhn3Qw9aRPtBqKC4XMTZAM+LAtNjXJdzsW3cx0
	 xaw0VX4mjZ/x+FhYH69rLo/YMj7TOGTXYjF3GbnwS9WFS1F3E94Et5HMzD3Kg6wWK/k7X
	 5hsm0VtUyKQck3WHi9C4+ux5kjQEuf2qlDEbMK4sTRgnByWkcIFi6VmvpgoRckPvjK550
	 hdn5DWCkO9rilE0MTNL98V4FHAqV/TckAivA8/m3NCCUcNsb17qaCcRma6jD1JSxL0g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790003467;
	bh=6dUCksfe35U2AM8kOrwiaY5uc1/51X6bL0JK+OitqVQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PNGkMjd3xwEpicYyGFpyufnSlthElFY7W8nTEMl5wXEPM29QcrA4zW+D1xcxE7A7J
	 AC9H36h1TFQYbdSPRi/ovXGJPbU7bPgE2K7dZPwQxHgj/PwjO62/jtJCqzqZP43xll
	 V9AxZ4kHaMHmKm1UQAxgYGonnUTOldI1YMPtdzwmKacYtvBwCQ5zYAIFy8iTtw8LjD
	 HWUJ5GM28OEDIPszXvot+abo4qMvnCvs9Anf/Z7+qS8CC8WhQVOTldQ1OyAFUgh2bA
	 FzZkOtIMyK6cDpUM9HFRl9BDx2YuFC9UoPlmdhPGofAfTIxZYw5HuEVI/ggw/rZyAa
	 qnjmf3Mz+LYqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AD5F40723;
	Mon, 21 Sep 2026 15:11:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F9D02EB
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CC606066C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id va3JPmprdmpk for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:11:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E7AF86064C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790003464;
 b=Ul+wRVn1H7YYhXapvlAvGt3ZE7jcyNQ+H8Z/d64qfuu2ItOuhv+MfLbfDkVtCPiUNJW8
 P90YwDG4cJipiinigVrUN1ayco9jXlgMLgCZt/7UbbnG7DLu5bJ5BDvSAytukMDuABnn7
 ZxHK4unuhAzz4Sc6NMKmzQFB1Ljgba1VXpJS1zIJZhfKFjLfSbQmioq7XS/td4s4hTxNU
 JLtQL+1iYv/TUBL44ZeqNKVmE3ea9rRwE2Hsoeitk6mjym8U26z34dSB805vu2/a8HXxM
 nSoe5/OPl+qPxVuXbelTkcQjs+gQx8WmeAS0oMeckYlEAMWOm6RAwY2Y/D+TebHjJZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790003464;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-ZohoMailClient;
 bh=6dUCksfe35U2AM8kOrwiaY5uc1/51X6bL0JK+OitqVQ=;
 b=Coe+XzO+T+gUFDvwraEtM8SZUnLzkZhIQo6ptA8I/zM4NG9PhH3YsnA+jPvHcGPLQW+A
 +7Z+KOnm/RjvIIFfFhBoavQ8lHBZoU8rC2CMrFzmAZomnJX10DgXmkDTygLkxHZJBzu6s
 lNrpkdzIKljiD16sV/su//1WDU6KF8xqxk2ei+HOm8MFfz6ocya4eHJJiTBLE/zifX0g+
 Pq5AldfQZ+N/n8w2YfxwQz50cOrPwmMDk4MSjW74CWUK66Repi82H50pEAyLt3KDDg2tj
 1WKqFassYuOgsY5I8OiahSdg6/RuiNJVnHmfc7sZ0Qri6CXuQ7898D7nxjZ1NMQF2VQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=cbHi7OtD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=cbHi7OtD
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7AF86064C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790002512; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=StCHcE57Or1z638D1lkpKYxLc1iIjO9aGmncItBQu7WAFS765RXYcmngmnC8JXmZDewvFkZbyeFm11gsS46W+i9vmWOKXuvJMI8ONadlCXKww7JnBVCoYSoZhqaFbVuDQMC4rDHOn0t0fuu+P0/r0B5S3vzkfX9ChkHNdn4Fan8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790002512;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6dUCksfe35U2AM8kOrwiaY5uc1/51X6bL0JK+OitqVQ=; 
 b=E7Po0MvZihydJKyv7EdPZ6F2nsYY1NLAfEQfj6kBBs4tDyi0vjeafyB6PbFgEY3AnVKy2gI0e0KfyDCcCwUSG4x+fZVeBWMmUOfhU1dCitiAqWb2y3Fl9FbjU6Z/64dn+YP7E4g78tI8CxEEnM2C37wSuQGj5RyZ0Q4BW7sDlaI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790002512; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=6dUCksfe35U2AM8kOrwiaY5uc1/51X6bL0JK+OitqVQ=;
 b=cbHi7OtDDIzsrMGrbYUlk9o+JCdWXspLP5bNUscea24TD9AlU/K/PepnYFDP7os/
 9GNyR4Nv5mKbVJrUtEC0qkor6fHLsSx+F3nk8k6hL7ie+Y9QkhymtjbpVxEwJOIiq1c
 lrVLr9TKr/FvUEk2rh1IPyrMfrSbCYDP/+B6Yc5E=
Received: by smtp.zohomail.com with SMTPS id 1790002511667864.0374775995165;
 Mon, 21 Sep 2026 07:55:11 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v3 0/2] tools: mkimage: add SpacemiT K3 boot image support
Date: Mon, 21 Sep 2026 22:54:37 +0800
Message-Id: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13N0Q6CIBTG8VdxXEcDNIOueo/WBeJRTit1QKzmf
 PfA1tq8/G/f+Z2ZeHAInpyKmTiI6HEcUpS7ghirhx4otqmJYKJmUjDqJ23ggYFqtC1lB1PVWoO
 UNZB0Mzno8LV6l+u3/bO5gQkZyQuLPozuvT6MPO9+ttjYkVNGm64yFVeqlIqfJ+wfo9P3fQBjS
 faj+AuKqa0gknCUDJQ0nejAbIVlWT4544EBAgEAAA==
X-Change-ID: 20260820-spacemit-aihd-05c46aae886e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>, Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3053;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=5srazcCwskpX5gAdXOFQHyj95JcNVsf++4+t7CBF8dE=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2utpFiiavYq+cxFV6QeCmj6fO0XrvWEUu70Wa55XrM
 j9u2lnYUcrCIMbFICumyMLlL/7PWofn2xGB1vswc1iZQIYwcHEKwES2tzAynJ0/5cmH/O/Oj9aK
 bg25XeHeY/XeI/3Xg/r9lbqbYxn+OjIy/KwwPSq8/4BSyYt5C+X6t344aO31tkznxOkXrzb+Nax
 7xgcA
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
 doc/board/spacemit/smtimage.rst | 143 +++++++++++++++++++++++++++
 include/image.h                 |   1 +
 tools/Makefile                  |   1 +
 tools/smtimage.c                | 208 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 355 insertions(+), 1 deletion(-)
---
base-commit: 211de43d0f954a00a490220c1aac9db298287c40
change-id: 20260820-spacemit-aihd-05c46aae886e

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

