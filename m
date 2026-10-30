Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF7606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hRYqvkme;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CJuSlm9G;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=S3il9i6s
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9675780F31;
	Fri, 30 Oct 2026 01:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AvqrOlBYBr2K; Fri, 30 Oct 2026 01:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D926880F39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793324970;
	b=cpQcNgxtSaKyXg8xGHCU2zt8/vx4wry94naig+d9FtWwmRPcyt2t3PRKa1NMHW0yy6mH
	 Le7tnQm/JlbQWX1HXfuUyEoYmSxJpiNpqq41J7qyknMX0pcuPMbELeRK+aIuq1sLGNes5
	 q7R1Tph0wEindsf3Y4snRaP9L8XT604xarDLTwtVmMbW/ebuYCx9oLjoZP7p9Zf0K2j3V
	 AYOyLQzksOK1Ev88DhHOov2n/0fJ8R9G/4anXHQW8LCFVI136gdC5EeewSZB6jB5Km4iJ
	 XljQR9LvgABOzb4kd5HlT/ohor9rpFdruyZnLu4VVGc2W7pMZpafGTwYKFxhQvlL/Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793324970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dXTZ+i8wXxbYy5zmLFmDNkjkOv3rgI03aGTM41zCf30=;
	b=Y5+UuEt/8xFofGFU9rb1lzIWxfhDdfxkcU/5YYtiauaqVDOG92rZ+1DBYC2X0cjqdfXh
	 nF4gebE9yttOqRn/LI+cDNTBOcvHRjPpZUO4I75YWAT8tL/1rQxDpGpU8IIJRvkWPbkJA
	 fkCuXkAu2PVkzR3Tx5cTKqr4WYOjg/joL1h8jorul6vNi+BiyWRFYVOtNOZr5i+ECw8+T
	 ywnmFfvHMz907dzwra7AtMGuLNTus7oVTsByfbIxRHBFzkXco6zaJYMDql5RLVmf2O4Zb
	 5Nu02Otqo38ehoh+r9Qs0lTK8EolvlXVbC9uNDLWvyADYCjTnOTSfgTSWvIMN+Nw47w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CJuSlm9G;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=S3il9i6s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793324970;
	bh=dXTZ+i8wXxbYy5zmLFmDNkjkOv3rgI03aGTM41zCf30=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hRYqvkmeE7rBfloh3WyooLdQTatPIJ/NapDq6Xgu499vah+4qNIJB6VrMLU5vuz/H
	 +GrwJGKQfbLrDiD4EeicT7JF04Qtj8oAkIXtPhyyIsd4M5zEI9LOH80Zgvs9dVYVMK
	 Y6jhp7qR46YA2jE2+mnStqE7pe7C0Mjxf4yrkJg1woM5wpTLo2dwe3h1FHmeNuMVdn
	 F60N4zccOGGsH+RQDC8NRTBGBdxJVG0U+W1DjIPQVssoLdwhbS0eV3rywOvh3y33yY
	 /QMaVJ1pqEFp1B0X0O1vMEhvb907P3ef9rqnskgTK1mMNceQWi+Kc1J4dNJtcjRt8J
	 eEq65NflUbKRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D926880F39;
	Fri, 30 Oct 2026 01:49:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 1DDDE712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 039C280F39
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id Hf__rvQ9Wrcg for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 01:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F12F280F31
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793324967;
 b=a2/ehH4lB2nxKAVUmPTSPtFY/X0YUY5twTaPeFe9bHdKB1865EEV3x4H+NYg1cKkiKt7
 dlVeNetJUBFWMW80j5PCbxVT5vVuCXXrvjOF6NzozSn/thN3SoL6KYaJ4P24aEjdFnfUl
 nM1ww1QSXBap4gQ4JQboFbuCVCFpiadL0v/IRGoVA+53gZ/7qQZAC8gwkw3WrzU4Vri/g
 mCovCKL1Ou4FLFJavz3IFTxfZk7XPLD4DWBWgosKYxEmovIgW+TcYzyg8rFKMzYZzMiIz
 GQHFJnR+jxEdK+Nf59fHl1jv5jRsICpwsa8LCxsfudGveDEOUufGZw04c6g2OtEED1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793324967;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=dXTZ+i8wXxbYy5zmLFmDNkjkOv3rgI03aGTM41zCf30=;
 b=bTb9qKA+vVrMsJVQchf+7LslMosQfnAQlh+qk0ld9fDRYACeWP097ZhC0fQlGxAbt/dS
 AzxAHJmcZtYMFMnZkfwmBAJIKho4OgkhPQQ/taKV0ManmwF8OaBPPY7KZ6pvVips2lKH+
 d6xq5GEnEWaZROLMssIIvt6JbT7a3Wy3/8vNvXJfal9es6aulzVW5nP3WRKwZRqWu564P
 gJIJ6BRNveC+xW4ltohxXO9XOGExs3Z5BTfqRYM3jz6CQbu4mfw10raFfIzdXeCwHj21B
 VpGr0dBtLnnQS7ti0Ng/wLcpNFfe7cEo2v15xgmvbA2+u7tgfpx/7v6TRyVdQCEXQnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=CJuSlm9G; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=S3il9i6s; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=CJuSlm9G; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=S3il9i6s
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id F12F280F31
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324963; bh=dXTZ+i8wXxbYy5zmLFmDNkj
 kOv3rgI03aGTM41zCf30=; b=CJuSlm9GJA+HTddVhxXdyO3PbI2qSldGjZJt35Tj1SanVZMYoG
 4QsdRfdtCRQ8YUnd7V2MuPulkUEZlVFYuy5CTlShFK/jrGLhX8fKWmiNlwgqiiWhH+Gzixj+I2k
 3Y1ALC6rwAt7K/l1gEg+zOvhJNUM+naVVRXwLy9XKPhtA8S967FXIMmakC/BhWVIKQ6c0ECY5xx
 06CsDVdkuf4NgW0k0nZm6Me99cSaYF5trIuFETSCCY3IFM/VrYmQTuZpxijWALJe8GejOcvL3Ur
 fhbLKmtMpAIWbRoa650fYSttiNJuFi+aus91JeYydsBGXbn6in8Fvv8urYltKodGaMw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793324963; bh=dXTZ+i8wXxbYy5zmLFmDNkj
 kOv3rgI03aGTM41zCf30=; b=S3il9i6sVnhtmGO9Aim02N5QnlGaBLwLf2QS2yEX+s/EGjp3Rb
 UisuhNBOU/KNrJkTCCHbq4Vklm0y8y4TQsCw==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	brads@mainlining.org
Subject: [PATCH 0/3] doc: arch/powerpc: add architecture documentation
Date: Fri, 30 Oct 2026 01:49:22 +0000
Message-ID: <20261030014925.32610-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is no proper PowerPC page under doc/arch, everything is in the
README files scattered around the boards. Add an overview, the mpc85xx
boot image layouts and a PBL guide, with the PBL one covering the
practical bits like building, flashing and not bricking the board.

Bradley Morgan (3):
  doc: arch/powerpc: add an overview
  doc: arch/powerpc: document the mpc85xx boot images
  doc: arch/powerpc: add a PBL guide

 doc/arch/index.rst           |   1 +
 doc/arch/powerpc/boot.rst    |  59 ++++++++++++
 doc/arch/powerpc/index.rst   |  12 +++
 doc/arch/powerpc/pbl.rst     | 144 +++++++++++++++++++++++++++++
 doc/arch/powerpc/powerpc.rst | 169 +++++++++++++++++++++++++++++++++++
 5 files changed, 385 insertions(+)
 create mode 100644 doc/arch/powerpc/boot.rst
 create mode 100644 doc/arch/powerpc/index.rst
 create mode 100644 doc/arch/powerpc/pbl.rst
 create mode 100644 doc/arch/powerpc/powerpc.rst

-- 
2.47.3

