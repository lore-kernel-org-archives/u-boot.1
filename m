Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6F60B5068
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ob9xF/00;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=YA+2UMM7;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=0GjNMjdz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 956A260702;
	Mon, 19 Oct 2026 15:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJf61DyRDn3R; Mon, 19 Oct 2026 15:27:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B56BD60687
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423663;
	b=VCaAUMP02z7KuIaBWTezyLztDDAbc6m6XX/ZnjI2Yg0SqxkvRqmTZAMBHApWO0IjJ3YB
	 TF9mOyGBsPeWXJgancliB9snQu+BIZKU1ahqZxD173hkKoxerOVd99P2LXcWt9+D0lPjV
	 y7Ls7GLjKV7qTvyIAUNuljN6muTWnjc1bh6CKMbulcRZ1sTCl8PccAp+Wxz9TzRvwBhBJ
	 GGTvCqupVikM1mkgg8si20SZAc6u0G7Udd/ERkVW221YX8OZ+9Qc9RY91MRUMnhCHjmCt
	 8EGSGmZffHkXKOaxCyIc6A5O/VjVnJLKmeVKGGfU6uimHOxs8Zgeb2eSMOefLHYdz2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9zp1QODM2ZT/PrtbCTylW4ZdXUdMJkAtT/YoSPN27YY=;
	b=mYg9K2SAccMDYnsQBQRYx3ipIFiinra+gxFGjhr2DU72lVxDuRt4qL5XE99bKv+L5he9
	 /4gObQ7E5IFrhoXtcXZacEyznD34iJLYrFAgZ/FtSqWkmiEs34RWpxOfsfog2q/RSf4sa
	 YrRqX2QNaVTGAKiZAO4eck7XrrxMe6JFIaJhVkIDaG9BHiB1MRmL/Pu4NUcXG+jzhWZOE
	 WcqcxHpVKf0o8+yoMKNgX+SIncDYzpzTDNAUPUELJcHnk6LoaGgtg4GLe1QmGKa28teAf
	 smptjBRMox8OFVcAi6bxnnOpG6WomjlIdkNCMr8IRnaRJKsahWVEX7U0zqOXNn1uyJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=YA+2UMM7;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=0GjNMjdz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423663;
	bh=9zp1QODM2ZT/PrtbCTylW4ZdXUdMJkAtT/YoSPN27YY=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ob9xF/00zOpnTYPPD+bssDH3s5BkBy1ifT8jkB/VgUv3USPubRBzawzpgz/txa3uC
	 H8VPfcq8px3zzTbVGqx6QevBHTL+6CK2AlPTrbUOYgJBkl7lfRpOBxexcAIciGbIm9
	 lHNO4p/8OGP6ntpmiQvcOU7obo10ZQ8wrwAdOng3uz/y9O9XwkVn02r/S20E9eP3sj
	 OuUqdppdwKjwEMrf1BvySVSh2BfQGlpfV8eQ35fTZCuMQKBNk3Ikq+ofEoJQA1qE/H
	 d43sRZdRD4jFhAdm3j4yOAiTDBRLRI98xqloz54v9dPfTixp+GNlaN0JhQ/Ca8ysBo
	 qMD1NcukboXbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B56BD60687;
	Mon, 19 Oct 2026 15:27:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4BCF279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D63546063F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4eb-g0IHMh5o for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F93A605CB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423162;
 b=Tl4XDNgTHjcKUcNZu/oFBGaKZFO5jMUzlAsSya+tZjpCQRxo3VRnuz9NxnRUe2YpaU2B
 PdNtcrSP5NNnuLtckWgXxgPNg7P4X8TuZLSuptZHrD648G1tyYEoaO3/QuNW7DhDHDlBZ
 DtdDnWE6zeE0NLvLaLRmTk07g/PqiNz1iZygiL08Y2XeVej1jn+NAoauzvzW7NwuBNooc
 QbzHXCKY1fBj6wKV+hWcJPhbH4o7LMDio+0MdjtZu31L+f6wljaVuMCHX7Rfti+B+8xyw
 Z2+GKRbl/4ikNQDs6gK3OsOBoLdu7n1MEm4/5hMXC+yekaZgB9vronhhdJmLmutN4qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423162;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=9zp1QODM2ZT/PrtbCTylW4ZdXUdMJkAtT/YoSPN27YY=;
 b=Bvfw8ynPgLluumgKKCq1bzwQi1subSrtOG6/fHkTrKFIC6kUO8Fkw7MOtB6976ss95gq
 m4+3k+8nl0P+A8QFEMtlZ9vsSRQOOdQj6JvDrVNGnjjFPqnOO+oQc+XmBKIfQCFCZkLSs
 gsq5AauodwR1qXK3M3bTnwuEv7xvbdhwRfs+M/dcmldBSjlIOv5hcLTt2JPq2FNu1rPO8
 7vJwHRtBlJHyTjMvlHCKz5jvsKH3V1cnzlfMInsDuaPAv8d2Jh2RAQ/ndPV80JjKG1fca
 TlGUpLghEVKvm14aY5NZf/CdsfCb+57I9TCxqFg2LFL1n/7xkZoMrZ3AIM9ZOMN8ShA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=YA+2UMM7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=0GjNMjdz; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=YA+2UMM7; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=0GjNMjdz
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F93A605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423151; bh=9zp1QODM2ZT/PrtbCTylW4Z
 dXUdMJkAtT/YoSPN27YY=; b=YA+2UMM7HZy/T9Af9Yx/oFELmiKgeQ0q10FjMjXkqjvNFqwCI0
 oUyJjY3gndVHaud1YUOSHHvdbVBt8QrJnRO0s/tuar6Kzi6BjKohKTOi2VxX+BOknuKu0vl7Bvn
 HGpncsLoGpCFi+NKO5O2BFg84jXAzz7v7DXhcv4FUVS/KTX8gv1fHoofLhu4nqqxcIY+Xq4lkiG
 3pqs8mD/8n60yYZgkGEIUY9IZrJraK0/u5jvlXmpgon1qJY8gCiEzz7Bss7WQkoowTMvfrwbn9v
 24Rgh2ApM+dOoB4FSPhch5OzMCJ/7gW5BchxgDKUGkhbpSP9lL7f0HCGUuGfvhB+tWg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423151; bh=9zp1QODM2ZT/PrtbCTylW4Z
 dXUdMJkAtT/YoSPN27YY=; b=0GjNMjdzV7/8yy4KPdWBkp2c6wrPrTvF2d03yc4iidpOEYRPyx
 fKh+ckw/710bbVCivOrHn9wsVMuEGcHBWvCQ==;
Date: Mon, 19 Oct 2026 16:19:11 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 09/14] xpl: Pass the make jobserver to the xPL link
In-Reply-To: <20261018083516.49229-10-pepe.schlehofer@gmail.com>
Message-ID: <641559F2-68AC-48BB-A184-037F2E9885DD@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 15:27:37 +0000
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:11 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>With LTO, SPL, TPL and VPL are linked through the compiler driver, and
>GCC's lto-wrapper runs code generation through make. The link recipe
>is not marked recursive, so make does not pass its jobserver to that
>command.
>
>With Debian's GCC 12.2 and make 4.3, the SPL link of turris_1x_sdcard,
>which the next patch switches to LTO, therefore fails at -j8:
>
>  make[3]: *** write jobserver: Bad file descriptor.  Stop.
>  lto-wrapper: fatal error: make returned 2 exit status
>
>Prefix the recipe with '+', as the top-level U-Boot link rule does.
>
>Tested with Debian's GCC 12.2, where the link now succeeds, and GCC
>14.2, where '+' does not change the images of three mpc85xx LTO
>builds.

I guess

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>Cc: Tom Rini <trini@konsulko.com>
>Cc: Simon Glass <sjg@chromium.org>
>Cc: Marek Behún <kabel@kernel.org>
>---
>Changes in v2:
>- shorter commit message
>
>With Debian's GCC 14.2.0-19, the link also succeeds without '+' at
>-j8. The LTO images of turris_1x_sdcard, P2020RDB-PC_NAND and
>T2080RDB_NAND are identical with and without it.
>---
> scripts/Makefile.xpl | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
>index dfd76b51a61..926d762108f 100644
>--- a/scripts/Makefile.xpl
>+++ b/scripts/Makefile.xpl
>@@ -544,7 +544,7 @@ endif
> $(obj)/$(SPL_BIN): $(u-boot-spl-platdata) $(u-boot-spl-init) \
> 		$(u-boot-spl-main) $(u-boot-spl-keep-syms-lto) \
> 		$(obj)/u-boot-spl.lds FORCE
>-	$(call if_changed,u-boot-spl)
>+	+$(call if_changed,u-boot-spl)
> 
> $(sort $(u-boot-spl-init) $(u-boot-spl-main)): $(u-boot-spl-dirs) ;
> 
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
