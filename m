Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EB606A32C
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w4Rz96F8;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=fgLkfa4Y;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=T8icCWrK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85ECF605D2;
	Tue,  3 Nov 2026 14:28:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F-xy4xZwaqhJ; Tue,  3 Nov 2026 14:28:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 74AF96070E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716088;
	b=PzaLWZxMqV3li0conPVYb3CV6KEFOVzpAsmPbI9yPexLGldE65FzM2w7l5f03aWZTDQu
	 sM3znYRUpT8K8PkWdHYK4Uy7zVx1DiNga//EyySyKtN60cCoHCGPV/NmjsMHznZ/R77dr
	 M3PbKPeOBZy4aAcmC2S8a4cGkCaCQbVCrqs2sRjJv1YIANmag0JgCaWu5GD0DjeupFdVM
	 eI/R4zXyPns1X0e4BNJ93cZwtcYbAJkD10ZdB3TLEZ0zcgtyeM/Xobl3RDuluM7Hsp04C
	 AbA5IzPKiOvCswQOxJC/7nR6j8N8RlWDxe1yGJHfowHrLNXHmiGR/90zDBgjXXAQOVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z3xHCB/iO50rE44momVTGcaHLlF0brH+xjLeQCC1cbI=;
	b=WTdHsDKT3A2ZCJVhUSJzDzK6pR7cQo4YjouC3t9BJ45a4R1m8ssOboG0CDhmeR1NoqHK
	 A4ljw6p63goqY0l1qMC4J0dRqLAgHBZH8RqfjE2I2RublScNnilTHY7IlxtnPKV8sYUyC
	 yRiylpf6t+pXUbsEGBlEQmt0AgaqnZBZK+oM5bwPHVUiReLSIqdyl1L0PglRXqRG1vPUl
	 wSbxGFykhZ6/XoQc5qooOdJ92oLyqyxEHlJFVfHBpLhyW5sr3St5d125w5d4EFrhJhf4n
	 1EkoVkyQ6RRDFuWwEMKzJfFP7xoMChdK1KKidqmqW3w7F/Vs8F37UM6XT9MX0x6IIbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793716088;
	bh=z3xHCB/iO50rE44momVTGcaHLlF0brH+xjLeQCC1cbI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w4Rz96F8kPtIrejpm0tola3ENjpNKC+3euBcBIdIDIkDPQp19jTsiKqdcKGL8gMyC
	 6lo6CLBUlx4Td+chUP91v7+6+5UIT0fEiicvgYyl4k/MCQdpYsUFEKpD3mvdfjeDwd
	 OuyHQ4gygGibNbYy6/m0ZNGwP+A8/KRJ3OYyKOGWhvr7zjvZ8ep0W6d6HrtMuf1zZE
	 QyD6k0gk0OflknvImVwBiI2Ya8EsG2IsU9L+gVauqEpJtLw766W7wE1ZMk90ybGhAG
	 LVQyB7Rd4mLzimZ53ZutuVKyEnXWieSWQMSbkMbOzkdqIe7cJVjAgUGnHb3YAYo7gC
	 DRpJuBn1BbaTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74AF96070E;
	Tue,  3 Nov 2026 14:28:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 646B8A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5514E406CB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 64QbxsWkxLDA for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB7F7406F6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716086;
 b=rTTkfE9XaBmGIKrTF30oaliFvQYb0sMVJy3zXQLh2jbCMbjS0/9WuV5pJgUEk7hck131
 /B7hTs3DZoCxAssh1gLEpCKT9SYG2AFZjZSdRmcsdqnPDlgrtQ0Pwo4DMJd9aex+3mMWf
 KtIrPJgOICfrzAN0vvBxBxVwKsJxXvjEDQiU8+smil0fAmi3LxPcQmsJyPcc8mK9AV/DR
 PAXZeXjxb6BpsfIZ2nghVGJ7iMAcgDjisG9HiQB6U3PmAmWKv9HJ5Uj8/vIGLdc5M6+SK
 eI1fJ+T8WxveWSYcN9tBWNedDCwuat9FRNyOzYosn6hwcMbl447spm4n1m8mOnCrvrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716086;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=z3xHCB/iO50rE44momVTGcaHLlF0brH+xjLeQCC1cbI=;
 b=XuLBFA+Lo+D/YbQIMdJ+9SGk7mco9/JUhSY4OmDaIjtKtGScvxe4IJEJtTiirwv3aTzl
 WnnfWAS2V+QUX/RUOxKeFsaYsIGyP08UA19/Mzk+qhf+Tb7ZoNiHARe10IlnabPhqsn0M
 C4Ybo8eJZq8JbAOYRnotdvF0d6anN64OyC8ZiNaE4nQXdCgGyYKa7lN0/2WHBkVj6zOWc
 LyiSvihdwU600UMu/kkvR89RKN5iKmxGJpFUcnkDdu/Mx5F85sJLTb2DCvoOQNVLJLaIa
 A3R7WDQw8NcD2HgXxFZZKIYrpJDYjJ+qaP/NsH487pO8HC6Lh6WWaGV3An06qfMAohQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=fgLkfa4Y; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=T8icCWrK; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=fgLkfa4Y; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=T8icCWrK
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB7F7406F6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793716071; bh=z3xHCB/iO50rE44momVTGca
 HLlF0brH+xjLeQCC1cbI=; b=fgLkfa4YKHIugKH3MNeJi6PKN247HAsFYDabTpYs+oPx4JFulZ
 Dg3Cl8zVUl02Z17Wi1hrDBL5TGkS0PhFONufBEB7NCMfFcc1JpZFaZFVRRBfcdaNP2JwzHmHuVX
 xQsH8ZKxOLKjVaTdOSGaG9Numkg/DuOqoBve2M+QY6WJSXqcZjA8e4M6LaZ/gURaHWTNxa+QJIV
 8xcQWDrZjY7Cmmyfzjlpet48F0c0VPMPk+emIUvWf7C+RkXo8SQot7bFfOBUtnFLaQK6wnOBBJx
 a1bo0U8eQNKVhjRevXAr4qPO1svndR5P6ctgzm9RnFE+KeNQWGN08DvbiCUZVvTkQlQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793716071; bh=z3xHCB/iO50rE44momVTGca
 HLlF0brH+xjLeQCC1cbI=; b=T8icCWrKMipoGT6R0dd0LWKvNan4ns3Bd1q3NeWaxkhqsz82Xy
 bLybeW+UHlct5i9c8tbHlbUhgJ8aL7tAdMBw==;
Date: Tue, 03 Nov 2026 14:27:50 +0000
From: Bradley Morgan <brads@mainlining.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
In-Reply-To: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
Message-ID: <AD60C4C9-70D5-4C31-B773-86FD9114C1A4@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3 November 2026 14:03:07 GMT, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> wrote:
>Some people have reported christophe.leroy@csgroup.eu being stale
>from time to time.
>
>Change to use my Linux Kernel address chleroy@kernel.org

Thanks a ton, I'll merge this in coming days to next.

>
>Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>---
> .mailmap               | 2 ++
> MAINTAINERS            | 2 +-
> board/cssi/MAINTAINERS | 2 +-
> doc/git-mailrc         | 3 ++-
> 4 files changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/.mailmap b/.mailmap
>index 76ba0a7fea3..6685205a232 100644
>--- a/.mailmap
>+++ b/.mailmap
>@@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
> Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
> Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
> Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
>+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@csgroup.eu>
>+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@c-s.fr>
> Christopher Obbard <christopher.obbard@linaro.org>
> <chris.obbard@collabora.com>
> Dirk Behme <dirk.behme@googlemail.com>
> Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 45e9076de67..f0a6de9409e 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1594,7 +1594,7 @@ S:	Orphan (Since 2022-10-21)
> F:	arch/powerpc/
> 
> POWERPC MPC8XX
>-M:	Christophe Leroy <christophe.leroy@csgroup.eu>
>+M:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> S:	Maintained
> T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc8xx.git
> F:	arch/powerpc/cpu/mpc8xx/
>diff --git a/board/cssi/MAINTAINERS b/board/cssi/MAINTAINERS
>index f82dd3b789b..8fbbb94b953 100644
>--- a/board/cssi/MAINTAINERS
>+++ b/board/cssi/MAINTAINERS
>@@ -1,5 +1,5 @@
> BOARDS from CS GROUP France
>-M:	Christophe Leroy <christophe.leroy@csgroup.eu>
>+M:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> S:	Maintained
> F:	board/cssi/
> F:	include/configs/mcr3000.h
>diff --git a/doc/git-mailrc b/doc/git-mailrc
>index 65626d89eac..eb676b3ed85 100644
>--- a/doc/git-mailrc
>+++ b/doc/git-mailrc
>@@ -20,6 +20,7 @@ alias alisonwang     Alison Wang <alison.wang@nxp.com>
> alias angelo_ts      Angelo Dureghello <angelo@sysam.it>
> alias apritzel       Andre Przywara <andre.przywara@arm.com>
> alias bmeng          Bin Meng <bmeng.cn@gmail.com>
>+alias chleroy        Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> alias danielschwierzeck Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> alias dinh           Dinh Nguyen <dinguyen@kernel.org>
> alias ehristev       Eugen Hristev <eugen.hristev@linaro.org>
>@@ -97,7 +98,7 @@ alias nios2          nios
> 
> alias powerpc        uboot, afleming, stroese, wd, priyankajain, mariosix
> alias ppc            powerpc
>-alias mpc8xx         uboot, wd, Christophe Leroy <christophe.leroy@csgroup.eu>
>+alias mpc8xx         uboot, wd, chleroy
> alias mpc83xx        uboot, mariosix
> alias mpc85xx        uboot, afleming, priyankajain
> 
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
