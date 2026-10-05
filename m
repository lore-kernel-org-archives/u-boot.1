Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9856CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6165E6074C;
	Mon,  5 Oct 2026 17:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqEyicY0Bog2; Mon,  5 Oct 2026 17:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B2F6460730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791222810;
	b=r/mRkPkIjwR0J2BuEN+YzqF0O9CKtpmWem7r00V4dY6cxTfXnq29Z340ChCqYPAKylV2
	 n+u0N/vsMw1daWYpX9Q6deiur21y3HM83vonUknJo8bd8bf8bPEkADpafXZdLYVD1077H
	 5zdfr/KTrsiagFjjO5H0YCLk1+7Fmb5BaCYd+gnEPBl7xaNFf0CFC45GBEZJZ46nv7EYw
	 8KXdg7s1Zcr16VBLYQEr6419pbgRulTR3kCHrTI/2et2zmx0iwQPcl7zmDBM393pmZmhT
	 qapNvCV1fCU+U8q+ooQCxY0ZgngMzr9n4gKjiXHrYhfB/GuvQMxaFHffNaKEJEexQnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791222810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pKeG2LeokleRF34MB5wnIUJYn8rMO5xZGHZaW2tvpmk=;
	b=Nm4i6IDnSdvZdrCnE7TFt+FqmVAns6VDB4EUqtSRCeQhvMeH5dpU/l//mfT4z8ol1soA
	 t68wzT99/fbr/Ib+XAVotMoTJ4VkEDAKD96WK+Z52eC3A/xbirGwUny0RfceO3w7WlfDE
	 kaNjpt7/gTLVfnjy2PVp7wz6OqiMYzzqKaJB2MTrKzqgv9gj/Qx3m/gzV/zJpWgJ1qzJV
	 HL60PfPC2robxV1hbsn29ZHEm1C/zL8umN6XXkyILOz/Jrh9Tu983tLIvu6U3rgG6mXXy
	 QK+XmgiWrLdUp4N8xrGD7D816pDhysXaIaQrcHxqyEsvpJM2GGLx9Qi2ikHO3lYwTzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=VqkgDKby;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791222810;
	bh=pKeG2LeokleRF34MB5wnIUJYn8rMO5xZGHZaW2tvpmk=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AryiK6JpCJgxNf8yC6+VaEU8k6eNu+mMKxKm8OnGZMampLyJ0ntioWVZ2or3CRxvp
	 uXp4AaB/OXwA/BDrMqhqrFMv30wpVdFrP3ZPmgDFuDlZYpDxBMZuYGoY3kenfOTojV
	 9PZEUmFSmAz0Uwaq+Nvsxw0I6lEMcZPpkxRfvFZN0Z+GPmPOqx2Kf3vL4fM6GYq1S7
	 G/s1CplU62GrwcrvLVTzexY64vGFEP4CR2dY0KykiR6yvyqj+Lb4ffS1D1kCUmnrKI
	 HCGSx8az2L/e06Zn9fntJgfJOP6vBzxFdZmNkwsMXQUo0TUHZMo6z9OP39+pIjQ35M
	 ZLWuOSCTmqSAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2F6460730;
	Mon,  5 Oct 2026 17:53:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5373D338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 393626073C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:30:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gko6y-beY45 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5392260730
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791221416;
 b=AEGk09IFX1ky1xfLvCNFD1aKWkfSIPPDnrQxawXslOX98/EukKph4nyl7KDneFCJDSpx
 AHVFsh6pvrOOaS23WvxDQOazwz9giPwCdog8SGoxUWsrrOeHSodpJ4nWpkS+6nsGDoWsd
 9AitIp6DRhe6EzaOWUvgJo7Tj0EfK2izIl9QZRpWJ4TzLeV1+v2jx7yH5DmUlaiRKdKX1
 9PxjY6jx32XmGPMEHoinuN4+5w40h1WjWIoCCW8z+DFWWr8oTca+hwt0JT6OarFfO6qNI
 h9/k5A6vqX/ikDpaRCFwqqyGzNAxau7U9ObYsOgjhXkzXH5drKca6J1YckYaWswldIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791221416;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=pKeG2LeokleRF34MB5wnIUJYn8rMO5xZGHZaW2tvpmk=;
 b=qZxj1Hz4tCufROuiE+Jv30wTKuKZHnRDfo8C3J7TqYh/HipiRafO86yYSVaDg8CzYQt6
 vDYAuI9GhqL3zhkOnWxt9q/YETZ4+QIKWjRXZxdJsS09pPncwAs05fQ0rpzY9rLUkbC0B
 gQyyqQFYrY4pxKGKmhwo+9+gMshd9qkjJbxNtJNSgLIfi6Dx0BbKsJx8MqLN/M1B8Pf2N
 jf8DIE2s+nO5VCwNcu2Gtsugj3lWr9EVVoR9TuSv42dR03yTkSfCKb3z4gfsLAPjCBBLf
 gEKmPmxpr994C5N0mMXrXUMOtVPCB17qbsbzEDM6J3FyJNtVqW071BQX9GzJqpINtYw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=VqkgDKby; 
 arc=none smtp.remote-ip=109.224.244.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.18;
 helo=mail-24418.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=VqkgDKby
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5392260730
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791221413; x=1791480613;
 bh=pKeG2LeokleRF34MB5wnIUJYn8rMO5xZGHZaW2tvpmk=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=VqkgDKbyYknjcD/rAm7te2k15yWut01HrGPYXftKJGTmWlKCPLzIFkjsoIALr6ID0
 UaqpNS8Im0OV2vfVpkSfxGdjL0F/KyI/0YojCF9JUITXCayHeSGh+dZqlipLld6Ok4
 rm9+JE4myBsgVch5vAJkDIzZMlaLLn+VGWJ4cpSw92g7qvlsWQhOp2uHqtK/iHUEfR
 ziwc6MfDaHTbcF3mdAF5fip53R+2vJ/xBFVMFTS+0QhyQrZeN/2wBBn/wD0GPoemh7
 q8kJ9+6HU/Pjve+NmxCcnglUv0bEJU+uqYrBOVcWUMESS7A/DkmwdLkiOOCtnFSZLK
 thWwTxFuH3kuQ==
Date: Mon, 05 Oct 2026 17:30:07 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH] riscv: spacemit: handle overlapping DDR firmware relocation
Message-ID: <20261005T132330-0400.ddr-overlap.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: af20e3c200554d1e24ce37447999ddee0733ca33
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

The binman-appended DDR firmware grows towards its fixed execution address
at 0xc082d000 as SPL gains code and device-tree data. On the current R2S
image the source starts at 0xc0825c80 and its 36248 bytes overlap the
execution region by 6680 bytes. The RV2 image overlaps by 7704 bytes.

memcpy() copies forwards on RISC-V and corrupts the end of the firmware
when the destination overlaps a later part of the source. Use memmove()
so both overlapping and disjoint image layouts preserve the firmware.
Keep the DDR configuration, execution address and instruction fence intact.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---

Validation: checkpatch has zero errors/warnings. The previous packaged
RISC-V copy instructions reproduce firmware corruption; the corrected
instructions pass five full-SRAM copy cases per board in each tested
build, including disjoint/overlap cases and unchanged bytes outside the
destination.

An integration containing this fix, the clock-mux rename and the MMC
corrections passed warm-boot tests on a 2 GiB OrangePi R2S and a 4 GiB
OrangePi RV2. Both reached DDR/SPL, FIT verification and automatic EFI
boot to their existing FreeBSD 16 installation, with the expected memory
and eight CPUs. These are combined integration results, not isolated
tests of this single patch. Cold boot of the corrected firmware has not
been tested.

 board/spacemit/k1/spl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 157e1bf5b442..4e9f66f60909 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -421,7 +421,8 @@
 =09src =3D (void __iomem *)pos;
 =09dst =3D (void __iomem *)(DDR_FIRMWARE_BASE);
 =09log_info("DDR firmware: [0x%lx]:0x%x, size:0x%lx\n", pos, readl(src), s=
ize);
-=09memcpy((u8 *)dst, (u8 *)src, size);
+=09/* The appended firmware may overlap its fixed execution address. */
+=09memmove((u8 *)dst, (u8 *)src, size);
 =09size =3D round_up(size, 64);
 =09/*
 =09 * Ensure the just-written DDR firmware bytes are observable in the
--=20
2.50.0

