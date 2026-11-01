Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADF606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e4ZRyL7c;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=QmjAvrsD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E3646060C;
	Sun,  1 Nov 2026 15:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJ1WN6yIJJFD; Sun,  1 Nov 2026 15:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95F356061B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793547073;
	b=aaDcXip7Uo7giZfD/lDR0kEu7zVZzjZ2evJCtEXRZOFBQiVxgVQ+kWwVdOEjfG6NHU8+
	 B85jgfLbajrUM2dtCf3Aym6U9+CHq4ls/1ANHMd2KE3Aj0DyiNRijQ9l8ZtTfgMssrYRs
	 ax/RrF+Iu8y9cfvG0+KVv5p+vLyBvs1kL2wp6+QN0ywHo7Nd7HtkbES2ZYFRXJAzumhL+
	 CcQ71OE8cZENwlXaS8MKed6xXPF8m+BwZkIN6O/QiZVlPnKod+dd9+iy5s6M29vSole2F
	 4IwipU/+vl6JIijgmOQCpph8daV6rvhsC8M1v1Ncipy54on4j7Yc8pZrRL5CrGT9k8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793547073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8v9YIAjXPM9HgVQ73OWm2yZ3Xyn4AKKOtDt5GqXmn6E=;
	b=BB/YksrLhWqzHo4aQb7vbKJOw9kmbDg29ht3uwZJSKn2ARQ2r0FyLef/i8W0Qiel33A+
	 CWDXBRkx50jtXhoS1pQC5f72VuLeAsJQMYXmrTcg33vDZGitiXTd+CxQsVPHBJ6E7bxv6
	 CeqgtMXK+eDGaEtqJi1aldMPYMaeXgMPFQpFLQR9FVb6nCdWB+BwNQfzteOKqpZeMGGbG
	 WQY+eh0FGEHdVKGeMTnMHUZ90oXSG/14mmDnHvtgd1Dsl5T4GvcorpSTFN9s0fw6qW/DE
	 IM+jemDkyfwXpOLuXb9ALXVEXU22irLlAV7g6KKFL2AnDdbPGHGOL1TRSC5+ed3pyFw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793547073;
	bh=8v9YIAjXPM9HgVQ73OWm2yZ3Xyn4AKKOtDt5GqXmn6E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e4ZRyL7cs2Sm7iYohrU3PDwjNleyEbqGYYCFJ/WEvGuUnmUuoWT+yR9k0mELm0SIA
	 WODmRVXtX0U0/5NN8rTgG4ul0vq5J9G1NFTbHjDQ7Z0tjBJGcgXjKGtkPU+SU9Zmf6
	 p8xWyZvMC+XBT0UyjoCscmcMLwP2TpUA7Qmtq66p7MwJ2T87iZ/fykll/Fzis+MXP8
	 7xv+GPS33YpRvdjVC2sY9mK/jgdr1MY0L+MCR2CDN68LgNIClobreKMXaHopWSGtmD
	 ZiXDlqsw4JRywRBBjhM+O9Cv2H+TdV2UglHzaaa9vU0f1KYyImvnQjEJ6eGmN+GFEe
	 YY6MCsfCMmX4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95F356061B;
	Sun,  1 Nov 2026 15:31:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36C882AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CCA6405F0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OzZBkbBHaGCJ for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 15:31:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 737A24052E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793547071;
 b=AssXVZfn2OlhhpYT+B++zZSFn7enZfAU9Bmmrqrpc8Z3e92xEeX8mqVx4UkF7Ieacft/
 oD+geFjjnhzWsY7nEk8k91IckRHYuNxgUro+vvaC88hBZFl1A/ne6Jxe9+bW/q3BeY0HH
 G4CMDDMsXtmAqB0E+9FAuut8d6wvNb28PtWc4i1tQjVfelILnbMdB1ZEnB+Bv9qox6cjX
 9hI8YftHnBWFMHxAsSQF+J1W85EujGoHSPPmdEID0p8TcKQK9krttyat+m0ctrhcwo9lh
 lRZHpoqUXH+l6Sl/nRkjUvR2A86dc2gLKVsHQjVONkpczPXZRjBVwtmTChwk5hJqDQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793547071;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=8v9YIAjXPM9HgVQ73OWm2yZ3Xyn4AKKOtDt5GqXmn6E=;
 b=h03A8s4mRBqXj/qKRqcdbg+amzX240hoyUG4OBo4oFv9M2Q59h7Ug0r9PGJBzr1wG1np
 /uACad/2eG7JHyiru7sUjAPVg239FmjJtph+1aGeVcA27yoaxiFl46VvdX+Dx9rXsV4TX
 A6wJMXN1Fnb6DM47xH7ILJQ4RCl6bKPVre+varFsq2iKfo1QPAGqSuBPXvqzoOSg41GEy
 ePLpcvvLkwszUBlw5609TmtkL9g1l0gubEbp0He2Rmk3vTlB6WCYr8PwLikKeOVyDMTcz
 8XuRnH42qovSPS0EBVnJF5NXhSnByBoRrHPMEGnKvKE+xDnfDKePzUxuovG/kqzEWRg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=QmjAvrsD; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=QmjAvrsD
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 737A24052E
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4774AB0055A;
 Sun,  1 Nov 2026 16:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793547069;
 bh=ufHQWsM73pp3izUqTgvPde1HcGgA/YuXrzRmJ3BGIvw=;
 h=From:To:Cc:Subject:Date:From;
 b=QmjAvrsDxjL3jZhUz4xjMedpzlzJhY3d2oBWg7MrkWowoA/mwGDczXO1k8PLAjXGn
 xuvZd0eBoNBRpuSvHhr78mjlireAcLTp/X4JfF3QPKhJKZZ/Jy7AOJyHHJ4X2jbBEm
 hM3FZ8fx0NTCvV+nXDeYWX+89xQA21jmfJHKPBN4CVKRrI18sW8rZ51LzlbqVU3ow9
 gUIGU8wCu6UHDWSfOWvb0A9zi9jcRhEKKJU5RguFSx1lBfi5uwe8H66AVSpT4yUb6P
 Gp9m3a9jPytuTZH6qNUEEKNXxlinK9lSyR1Eb09PvbpINjAyussOV5EW77MvMxlPdG
 L+x55TXeLcM9g==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 0/2] configs: nbxv3: SFDP probe and faster kernel load
Date: Sun,  1 Nov 2026 16:30:57 +0100
Message-ID: <20261101153059.380205-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Few defconfig changes for the Nodebox v3 CPU Module.

Patch 1 use SPI NOR SFDP tables

Patch 2 builds lib/ with -O2 and the full zstd decoder


Vincent Jardin (2):
  configs: nbxv3: enable SPI_FLASH_SFDP_SUPPORT
  configs: nbxv3: build lib/ for speed and zstd unminified

 configs/nbxv3_tfa_defconfig | 3 +++
 1 file changed, 3 insertions(+)

---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
branch: for-upstream/nbxv3-defconfig-boot-speed-v1

-- 
2.43.0

