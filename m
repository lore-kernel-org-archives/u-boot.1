Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CB2C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 483FA409FD;
	Tue, 28 Jul 2026 11:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y71plK7rSr26; Tue, 28 Jul 2026 11:37:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8A234099C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238643;
	bh=VQr84rw88LDo1uXwFWcNPpq/dmcAEyUDb9ENyLq6/sk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hDJOWmMW5aSiR7qWtvAThckEiaAV7ObuVLGRam/xjQCTfb5UmE+XIEbO0EnSL8EzC
	 H8x72XCRHxgyRKsiaBMAL2jCA3nB0tNLftatILccI1CROCKVAsV2Pp8yK2BKrjtsEO
	 Tr4jobTOpPQTBka1wAh6PZNFol4eZZ6Ybhv2JnbARRLUmED63pveEKp0PXR2E+H7yk
	 hg+oAfbgh99iqdKEnPCFVBui9NHyRKocTjeBXO11selDxKM4LFiIkGetCm9RsZxdSx
	 u7lD0jgBMeIynf4VSStPjHow6cP4QdtlGd+VSsFegc+ZnSEUwLKh/sK66pUouyp63p
	 hz28BatBAiHUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8A234099C;
	Tue, 28 Jul 2026 11:37:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F149F357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D750860858
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sD_l90KFdFB5 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:37:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0EAA66077A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EAA66077A
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EAA66077A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:37:21 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so6114986a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238640; cv=none;
 d=google.com; s=arc-20260327;
 b=FKjs4JcRQWtgrbGvWoimm64cmIbDag/bhvgx81ubPTCD46otqYlfl6jQj3L9egxlTc
 VFNhh0Qr8NgcoF0jguO6UsLvNv03pAPbj5IHCDRFWiMPfxHRI4cvGtnId3vAP2Cepvhi
 p6CsvfPhD7pig8QgbcJLDFjygRAtjg/xqHECxPUU2aDmVOjrZq78pDItC/tPF0/0jP8J
 SNbNuojuRGd3jwFiBPanqWmIBpYfzhbg83nuMxOImCOvEcpBwMG/eHXGfo0a7zrHq+Wh
 YgaWuPUpEabixBtfOBvbRRBn6pnLNI3Ye9dV/RJZ8TufK7dQjNA6RB66iNKUPgtJ8UsD
 I9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=VQr84rw88LDo1uXwFWcNPpq/dmcAEyUDb9ENyLq6/sk=;
 fh=OrCcvJMcvQ0gUV2oayJyA/RUltAZbYYKyAJKsjS8faM=;
 b=QGM5TKdaXa9UwVaBwKjmoJ8UpsVkQnvSqlaJam/dl5ElLy7/PuIZj4OfmQSwMWzsoe
 iSC+TwhyXeQ/3U7h0yZ6h4iuWd5/7ZIcfh9zh70Umr2WNP3ZxsRgFlXBrqJ1e7HN1Lbp
 pAcdeFaVeaEk+1vL/hZB5GwWBXRgvTWJrJhy8mcIuAgRRTFs72/umlqW/TGW2bzr7TfZ
 vfFWwNRITcRTu5TDGOgTdJgZEwI40cvoqzke7PmKL47471cKL4GZxFzrl4Uj15XwOb5L
 UEW1mfy+p0HPC4aSBAnTEBPbwIwStDolIXYt0LBIN/k83TlkhYUIrJ+0dHZp9zMgaKeO
 8B5A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238640; x=1785843440;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VQr84rw88LDo1uXwFWcNPpq/dmcAEyUDb9ENyLq6/sk=;
 b=r2FYlGSsm7JfX7qJoIlKc6XFRrU+c3Pd3P04I5p1MlDM3XTeFcjSNMy5nR+eCks9xq
 PHtpsPVR5XPRxNyuTUAVUNT9Bvjc3Bk4MlyP6oCjbKMqOVI58caMJEh3w6ZnGot2VYLb
 GJoNPchzlbQKcL02M4ltfpL9jfEYiLAfb4duVIUkGKA5e/m8Ph73E4fORevuGG9Vi6i4
 hR2KAmbpZZiT5GpeptqrGg4Tgl99vPYx91N4CUEduPdbbV9eqmnWKlysTSi2fERCcXZ5
 p1ReS8c3aJ6QtSrMi8pZfxFIgRu9cJmF2V1R33K4VxqY0EnMx/GnArLtxyDWe0YFVJgw
 qsyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqd5YhB+rm1djAqIdxJcJyibSC6oAyEUgj4EsVFHDBUklpP1Y1sYiJXzvl+9PSud75ujZh3JvM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxoTG+7BKtLBkFctR4YLjOhBny9PeW5ixn29ZtB6tQQCNRiZbEC
 sW8TNRBuEV9V/od0pASXmTsVZPOp2gnBwTvOcb5MU081mXFXV6MNQ10cOtaLVUa/59TR67z3cSF
 yAKFwuw086d8Nihx6+HOCWC30wgZvWzuQy21zeQttUPW+orcMWxS2gw==
X-Gm-Gg: AR+sD13q5CcnQUT87Pf6Q29vkZXKEni9UvmIaGjSaFSjhBZYnjg7S6OEgCi0JfXmgoT
 4ICoQahAwG/n9MwgFJQ6PWmrJVYzQotigxw2znRU37ubo9qpf/1r9jcE4erOZNdGsNN5gCPpvCf
 iH4M0YfcTx65Us2GzvnHIVvYhoH4vqhKHN41728uUs3IKk/56XlMcTFrFiAmdmKphhdrlmoMI1K
 +KmLS1u+dZI4h+9ot+sT4C0zAJ6rhUty4542JODWD4GyIkThC8xh67A+z2G
X-Received: by 2002:a05:6402:2684:b0:69f:e3cd:5ae0 with SMTP id
 4fb4d7f45d1cf-6a034a1c2e8mr1051856a12.18.1785238639974; Tue, 28 Jul 2026
 04:37:19 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:37:08 -0600
X-Gm-Features: AUfX_mw4V9eGG8WBtm_wcelZCG39xhocuML-IyqajdBpAkuTMpIt61LPbtkSg9g
Message-ID: <CAFLszTii3h==qj3Y-S3J_B_dfgeJ0=0c0b2fsr9h+pAKjLhLXA@mail.gmail.com>
Subject: Re: [PATCH v4] serial: coreboot: Accept DBG2 subtype 0x12
To: jayaramudu.desapogu@amd.com
Cc: sjg@chromium.com, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238640; x=1785843440;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VQr84rw88LDo1uXwFWcNPpq/dmcAEyUDb9ENyLq6/sk=;
 b=Smw6uzvXcFTZSAK0WbFgZnBAbPFclXk4Sm5Pz2fgcNz2cbiJJ3Ihs5La2Vbu9Lbla3
 I5xGBCfXuG8yRdKRL1mDftqPmer9iM1CmaI29lzbzkeO4UV5fX84MY2I9CHnBZ2IDiJw
 vc9aciubkgxtkVSVxt2VPERg55U+v0XLccYm0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Smw6uzvX
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jayaramudu,

(I see this in patchwork but not the mailing list, so am, trying to do
a manual reply)

On 2026-07-28T05:02:11, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com> wrote:
> serial: coreboot: Accept DBG2 subtype 0x12
>
> U-Boot running as a coreboot payload obtains serial console
> information either from the coreboot table or from the ACPI DBG2
> table.
>
> When serial console support is disabled in coreboot, the coreboot
> table does not contain serial information. In this case U-Boot falls
> back to parsing the DBG2 table.
>
> Some AMD platforms or any other platforms that uses memory-mapped I/O
> advertise the debug UART using DBG2 subtype 0x0012 ("16550-compatible
> with parameters defined in Generic Address Structure"). U-Boot
> currently accepts only subtype 0x0000, causing DBG2 UART detection to
> fail and leaving no console output.
>
> Accept subtype 0x0012 as well and keep the existing handling logic.
>
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
>
> drivers/serial/serial_coreboot.c | 3 ++-
>  include/acpi/acpi_table.h        | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Some nits / thoughts below:

> diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
> @@ -59,7 +59,8 @@ static int read_dbg2(struct ns16550_plat *plat)
> +     if (dbg->port_subtype != ACPI_DBG2_16550_COMPATIBLE &&
> +         dbg->port_subtype != ACPI_DBG2_16550_WITH_GAS) {

Please remove the trailing whitespace after the '{'

Also subtype 0x12 means the register parameters come from the Generic
Address Structure, but the code just below still hardcodes:

    plat->reg_width = 4; /* coreboot sets bit_width to 0 */

That comment only holds for the 0x0000 case. For a genuine 0x12 entry
the GAS bit_width is meaningful, so forcing 4 may give the wrong width
on platforms that advertise something else. Just to check - do your
AMD platforms populate bit_width in the GAS, and if so should
reg_width be derived from it, perhaps as a follow-up? What do you
think?

Regards,
Simon
