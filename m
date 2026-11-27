Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD5606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DFkM3JNy;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=sesOtPpR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 729A960D76;
	Fri, 27 Nov 2026 16:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nWeL5hcyWOIw; Fri, 27 Nov 2026 16:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C10460D5F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796008;
	b=fY2+aIVs7GpTrEYwLg1+7lAHtnmV5lDdpNH5kUZHRiXzbOVB60S8lI5zrXQhaV5ezIrY
	 OC1CNH9ExJUrJEDVTLmd991iOYKD1vwE9PWRunwTaDsN186CFhERfJ4VBw0QiGe20m5uC
	 tblfypweEuw2/ukgPiMBT/LgbC7dMxLaRJhoR2c7FPHFY6JEhwUa61bYOBB9Mx0YlQqRv
	 ZtzipaqnlA8J38eI+eCKts+yfRG746BeqkE6KicclJHGLA91ZFxYREfLWiqSC3e0FkqJl
	 fORvYt8ksmRalFMj0yQKZ8RnRVm4INe+6YrfaV/OX90D2L/btvgBDjGKDwpbi9z7VlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796008;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MAFMffgsQ4utdi8FgcrJ8v4tL1GYtSwwwApgAeJm+M0=;
	b=iJwSOQVewxRn77psn+peDFkzscasXP6f9Mp5xb4ETRo5L9xuhZ4EGx8JGUJVb2HBHezo
	 ohjnHDu0hpt1XcHwmBDEsqsOAKVv7/qCq5oyRkwwS02BkU/j1h4vwCGyQnomtkuySGKDM
	 cadKfNgLQSVNkhLgyBw8oLWH2RD7Aqa2PXTX1OU+3YSmotssQNy39jTBqr1cYPibGnARI
	 3FxdYi0Jo3CJtnliK1L99cLllm4fWmlYnWLZPDeVV+SAF5f1fAeL2Ykt5ffYHxNLXQ0mG
	 hivWRTKXgfwFhCDz+qC0ZevLfG2JA/XYUxM0q813eg/jaDw7XSOpk0q2iETagHHXvUw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=jaeyeong.cc;
	dkim=pass header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=sesOtPpR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796008;
	bh=MAFMffgsQ4utdi8FgcrJ8v4tL1GYtSwwwApgAeJm+M0=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFkM3JNyl+2Du+na/hLNr1Tsot/9irq0xjytl6FxyGdE/UOcF28lON9UWqY6Q6q6T
	 OTPkMbjpyuEdtZ5bA/hywZ11/zbtjdXxge/gak7JbD3ZRI62xPgEHhXpx7aAA8KA8S
	 K2jLHd/5dD7pU6QwrctnCMF1AlZAEHEwLedvN3xOvWNoAOc/2OjcMr5UZLb86Ge+Nw
	 dMDEz22U3O9IG9Da7kYnmDFDv4TwsBXCiz9myhfAc+03GFWh1m+rcy8S5I5wkyTOHW
	 xSXGH1e9EKybhIY6j6WjSAjBNH6/TTN+k4pmv6c5sc+KftrKHYZrii83+Bq2vIUoBK
	 ERFA8dQyPm4JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C10460D5F;
	Fri, 27 Nov 2026 16:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F681373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00DAF608B5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:08:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnVM-zrnKaCj for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 15:08:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AEEF607B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=lee@jaeyeong.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=jaeyeong.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256
 header.s=protonmail2 header.b=sesOtPpR
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AEEF607B0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
 s=protonmail2; t=1795792106; x=1796051306;
 bh=MAFMffgsQ4utdi8FgcrJ8v4tL1GYtSwwwApgAeJm+M0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=sesOtPpRnRV1OwkVeibKudy7gbNk/mfZSOLo+kmqPhjj+zNffF6gF2Ou0vzKpHs7k
 tP81hGTlydE16jzUmFM2h+4d+MYsTV2P6nmRfZDE/REwrQeAJQ9STBLdDD58BQDRhh
 lHE4PsE28Gm1W9+5EBVrUSTCsqPcuKct+tj8bihnhJo/14296sCjBhBXgpc2QdhECM
 FMHnbCkdY0o6AbJ5j6D9rsVYSX64B6SMOtp7rvuntr/Oo4YKKuSAsiJSjUcmnVeEny
 lGL2i6JRYspsxpTzr2UQ7VJs4mXS1jZtfBwgB0SS//F/IVH8KBIOMYUi52JK6v9OL2
 OekrL5hBjC48w==
Date: Fri, 27 Nov 2026 15:08:23 +0000
To: Sughosh Ganu <sughosh.ganu@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fwu: v2: reject undersized metadata
Message-ID: <179579209485.3201180.14759543002169998771.u-boot@jaeyeong.cc>
In-Reply-To: <179068612070.290852.2536897028462322324@proton.me>
References: <179068612070.290852.2536897028462322324@proton.me>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 16d68941545171fb8ded0b7960bc36396d295f9d
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Nov 2026 16:13:27 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The v2 metadata_size field controls the allocation and read size for the
metadata copies. Later code accesses the firmware-store descriptor and
copies the complete configured image-entry array without first checking
that the declared size contains those objects.

Reject a mandatory header whose metadata_size is smaller than the
top-level header plus the configured firmware-store descriptor. Perform
the check before allocating or reading the complete copies so a short,
CRC-valid metadata object cannot cause out-of-bounds accesses.

Link: https://lore.kernel.org/u-boot/179068612070.290852.253689702846232232=
4@proton.me/
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 lib/fwu_updates/fwu_v2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
index f48b6d1264b..93e57dcdff3 100644
--- a/lib/fwu_updates/fwu_v2.c
+++ b/lib/fwu_updates/fwu_v2.c
@@ -104,6 +104,7 @@ static int fwu_bank_state_update(enum fwu_bank_states s=
tate, uint32_t bank)
 static bool fwu_get_mdata_mandatory(uint part)
 {
 =09int ret =3D 0;
+=09size_t min_mdata_size;
 =09struct udevice *fwu_dev =3D fwu_get_dev();
=20
 =09memset(&g_mdata, 0, sizeof(struct fwu_mdata));
@@ -127,6 +128,14 @@ static bool fwu_get_mdata_mandatory(uint part)
 =09=09return false;
 =09}
=20
+=09min_mdata_size =3D sizeof(struct fwu_mdata) +
+=09=09=09 sizeof(struct fwu_fw_store_desc);
+=09if (g_mdata.metadata_size < min_mdata_size) {
+=09=09log_err("FWU metadata size %u in partition %u is smaller than the mi=
nimum %zu\n",
+=09=09=09g_mdata.metadata_size, part, min_mdata_size);
+=09=09return false;
+=09}
+
 =09return true;
 }
=20
--=20
2.43.0


