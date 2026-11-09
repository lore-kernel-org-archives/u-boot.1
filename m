Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A0606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DBemYZG9;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lT3Ewo/k
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89ACD4057E;
	Mon,  9 Nov 2026 13:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id br0dXpCCy4Tb; Mon,  9 Nov 2026 13:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22549406CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794230406;
	b=e7+KXkpBTsqo0mHhU7tqYk7pIeBTch2IQvUHgxwTwRufhClkArlp3hYjwLvt66oWMaEU
	 31RZw0NKBuHts5QCijmGaUtmgGV0pAN0hZzCjm+dkcF/AY5yfKseRWYr4oAdlR8UIAiIY
	 5NPIfTIDx600pH+T6xlW2co/oo8Lmbe0JLPPrbZ4/hvaRo2enUBfFlcCQ2u0yfifDpyFZ
	 ZtOJPocDlKYa+ZUHRPYblyjVmGCRy+qOlwo/q87e0LS80ESbi3HLWDxhcu4qM1oHG83qx
	 XasM7b7a9csVzc7mS+qth0qI401CAHzQp0fKEMPz1G1+ZhxKUBpsROSeMXq0gspLJKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:
	 X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AyLTL0tE/fJTsU+hs9QxY7MRgTaZ3nNnerjIYqa4ZBs=;
	b=PhP8b0F4Bc44M0a7r5MIBl8WB1ylxjfJG0V5JKiz9RrjRnujWCo3QuMMiWmOdjTp3AvA
	 7+v8B3EBA7VoAfY3B/G+DwdM/XzjSKQe1szb4zBjVGq3vKjxB17jqqZRBfobL6oJavvJ3
	 xSgtnaWbyMTDc0bwldNl1iJWSaofF6Ufsxf8VjL9ivT5YpSrljMnFz/tsvoyoDugp4EqX
	 1ustQikaPnmKLpL5WQgAV9MohFZriYbTQ0mMKLQl/vm+5vFCAKxMdkoEF/0oUNj16HKHY
	 ZSCdnc+Fh11nS57Q7JZQDjrePB4VFgvWiHzBBTrN46M+FEvXS5aZLgbT4wj01m9c/BA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794230406;
	bh=AyLTL0tE/fJTsU+hs9QxY7MRgTaZ3nNnerjIYqa4ZBs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DBemYZG9sDmnK+oaRmKrSut9kc6+X+hiSl/EH4lASmqjA8iURKmCLZ+ImaqW9e4p0
	 ZJzlLyjJiOgRbj3g0m9FNSjwxiJGf1/IY0QumWRuYNP4u12UXJO19orKxyQWfc5bQt
	 GMpDf5tq2ElajVGXoBnlIv0hSzeLx0hOo/sgX+hs7Yrow+V/gTIX2WAQb0dTQuKRXN
	 0nG0PqGGi70fLmsH59Zg8QAqxacTMpGyVfbW22nXpRswB4AXOeoq2o/MNe6LR87+/4
	 io+SP3YWe1tk1dS8bZAjQAc7BJ2igQdzAbLWZzQzAiowQi8ZsJcrW/95Gn7+I+MKmx
	 l3Wk43CkEm5WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22549406CE;
	Mon,  9 Nov 2026 13:20:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5FEE361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95B0D60703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:20:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7UaV9nSreW83 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 13:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BADA66061B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lT3Ewo/k
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BADA66061B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 13:20:02 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jNVkk60CBzKnS1;
 Mon, 09 Nov 2026 14:19:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794230398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AyLTL0tE/fJTsU+hs9QxY7MRgTaZ3nNnerjIYqa4ZBs=;
 b=lT3Ewo/khJA9zcsJMCJjPNXbDQvz4+FB1ud3VreR3n5qsVvGqzFb2YBTOw3uSItJ0JFIZY
 +QfC7bfyG6KeAlT4eRIt5KmfopjdcGazLi/ROzLJb+AlKBZaM1jj73UP9nJ/ok5ZqmurAc
 pgPa4RayH6P+9XTz4O0/C36q8t2vslBBD2WoJjk1DdzURf9LkQJC7yIPUcwPAi9C5op8f6
 Xid5620+b87SRQDSO4nBoMtaLlFzINZiqFoxbPaLRIn1x8UWEzVDilwB9hUykC4CT34Osl
 SVwVUTX74uSFNz/SwBEZrLwbuE0+RKEetlDXfBqb101V/MCyWAnbBinnB65hJA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-marvell/main
Date: Mon,  9 Nov 2026 14:19:11 +0100
Message-ID: <20261109131958.2033778-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 97cd8a531701c246973
X-MBO-RS-META: eyxmp55io3fhrcyzitt8myf11tg68p1y
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

please pull the following marvell changes for the main branch:

- arm: mvebu: helios4: derive MAC address from SPI NOR unique ID (Igor)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell/-/pipelines/1929

Thanks,
Stefan

The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba243:

  Merge tag 'u-boot-imx-main-20261107' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx (2026-11-07 12:04:01 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git tags/u-boot-marvell-20261109

for you to fetch changes up to 2ca3c698fcedfa0e56064a7430c36bc145a470b7:

  arm: mvebu: helios4: derive MAC address from SPI NOR unique ID (2026-11-09 08:49:22 +0100)

----------------------------------------------------------------
u-boot-marvell changes 2026-11-09

----------------------------------------------------------------
Igor Velkov (1):
      arm: mvebu: helios4: derive MAC address from SPI NOR unique ID

 board/kobol/helios4/helios4.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 configs/helios4_defconfig     |  3 +++
 2 files changed, 61 insertions(+)
