Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C3606A326
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o7dW6LGD;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Lrkd4tWN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1B7E40554;
	Sun,  1 Nov 2026 21:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBadz-WrDFgy; Sun,  1 Nov 2026 21:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 22F9A40533
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793568688;
	b=LNt2eOlT8qwvmPiz1WZkzJbD0GLkWkXveXXRtWgyXRECroYsqSRbSFNoI40cb1dWN7fn
	 51OVhb/iQuiAlYsHlMJkYtGLFlv4ASkmjFbs1fEbGohcIGStJT07j1mfn6esWFG7lNlr6
	 oP8Osbmw7mjDtRrI1L9EHu1jGKVA9bjkElNyZ+L+LWdE3MuEYyTRi7knGO0hgLUTR8al3
	 LkIpFB48Ff+OHJkNJ1W2uwsw5yASFWrmpHBrSckh8JO3Rgv47QqbLFImADiLJptDZSkDN
	 mkWYETYWbZh1nzKem+iJreU0/FkgGzlZtaW3+el7uHE+7aFZFkkgAkFIhJp4tVk0Oug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793568688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZfiHqKBOhqGuYe/x6uGuAozNI+DNAzFH0t/irkhkxOo=;
	b=Qh3Au3pwsOh5P6eFoEzw28asVxhsxlUjdFOzq4KOX1/w/AXCipu4IAnb1cFTcuv5Jd/W
	 i3WT5Ga9cl3l1ju3aemErEa55OyTcoJeKr39i0zXXaF/oFLc1qy2Y64llO/NwTMiT0wy6
	 rqgATiSJ8me1lfw0aLMXatwVcduTj+e1UjZbdae84+XrfGW9DZTB3/tMJcf0filCgQmDG
	 ZDF1zTunLFsOlSnuFlGDXl2narsANB0hiC3/csfrh17H7IDeDM0/g0reRONOgC9gPUolT
	 ReydnV/vik8vLju4kluEVd92aDoUnwlK9ufu9/2j9D4NwE1ASfZKxlKQSkh2pCpFtLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793568688;
	bh=ZfiHqKBOhqGuYe/x6uGuAozNI+DNAzFH0t/irkhkxOo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o7dW6LGDSSALcgI5Yo68MspM+q6166JtqUxehOFYFj8l0tKU+UEhGPmM+/oFrZjgU
	 bSYyxPMq64KMHABw3Hje0Y8etHajRcMKENBBkJ/NZ626rPYOl1h3aod8n6Pol2BXDS
	 vRSnnIfxQF5vWR39Kw6bEUdJVZUgCzaBN/nVBE1ZzUvbffjEF1ntJrGgi0Lfvi6h9h
	 8a0wFERqvH8y/v3yJyt2oj+CtSfYLQKM8kvF+gRE/cp6V3qRK7A4rsSL/8lytcNl3x
	 VG/DQIR8wfiHDoNJUe9O3uh8Pj9BWy43ufAPmtXkfUs+WqytZTtXSG0BWT2R3VX3wM
	 raVhAcUsDhB+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22F9A40533;
	Sun,  1 Nov 2026 21:31:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F35452AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8CB380D98
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYzKP2vuen0p for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 734F880D97
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793568686;
 b=RVYCoSmqkIT73I2WVVq2WIg6A7zq+XQFWif+jfErJt05G08M7TrE/3UMpV0mn2JYiCo9
 UW3SsQs30yjHfPfdWYMEOuWAbyDXJQn4v0he8GBrrLHpfhFoelkxwGmh5N/++IaAX0mTe
 1fx846ybciyBGo9gKOhIMlznZtXDb6rGRqlZFR8eWdh4xO5Eobei353aZkXD/czFJQdWR
 ovro8ftdoW0vIjOUgt6+346nmZX6VMa0bZJ20IbLGdd6/bDdFepQCaPFnA5yUrcE9fDRo
 ZMDV0x11mUc6NBwC+d/wVRSDNUNObnQXu+GUy2dLYebWGqMhj4rPc7HSuD4UK3unIMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793568686;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ZfiHqKBOhqGuYe/x6uGuAozNI+DNAzFH0t/irkhkxOo=;
 b=LPwhDuq1ophQ4oyISniCcUCwhPaImZqe8lXRY0lslWCb1hNgpnIf1TD4LbmTCvaOYVPm
 Ou+4QZsH6IK7apCz2fM1nSbXoG498h4eTD43GNpGWvqHszgAOwtSlRi3SECrXgab+oR9I
 wnszoBSgHX2ioxtV9G5qQxQHLzvYJ3QgQkV52cAK+gnpYua6QBiCyP937Bwm3Tsd/ykAK
 NdioPDJBg2hu8sOBJNW096tjh3hCFj35sCTRcAvZT6dxlgqdwK3a4R5QSvOvzSDM5UW/F
 VifNUpKXCWqnMJ814KnkOYOyoZMj+qd4GxWRNIhKu6TXqxRd6YeFqRIZIHBNIgDkDtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Lrkd4tWN; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Lrkd4tWN
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 734F880D97
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 87F2AB00539;
 Sun,  1 Nov 2026 22:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793568681;
 bh=XTJO/MMlCrBtM64AGiQkCMvFHk0T9NG1a5m83BMLJMM=;
 h=From:To:Cc:Subject:Date:From;
 b=Lrkd4tWNiKdVwK9biyHwad7Z/kJllsU54wl4SjT9rurjxIikI2KmTtZSgWmQ0gSKs
 R96i9G2GqASgZcZWpoU/jrjWheTxmWibuFGHnL182I0psB56dJOVczVVhnrIC1sy4C
 rVPFR97ZS36asCYPKrJSt/ZCrUJm6tAHD84K2pkFwmGPuWtfIESAzdhGaJ0QAn3sGV
 MOR2AJi2YpXddNF4bRXysvkrxLg6OTy9DakCTyx9KLH37b9yrtgrAicCn5Tgw5ZHiQ
 R6gePk20F1jt0VoJERt6sr28CqcdvOOc9h0oEv8WIyFBDIvPfhu50YfFKa0260WAFz
 z1eoYxBA/Eq/w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 0/4] board: nbxv3: carrier from the RCW build stamp
Date: Sun,  1 Nov 2026 22:31:06 +0100
Message-ID: <20261101213111.483600-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Nodebox v3 CPU Module plugs onto several carriers. ${carrier}
selects the kernel DTB, the MC DPC and the DPL loaded from the FIT.

Patch 1 reads the carrier from a stamp that the PBI of the RCW writes
into DCFG SCRATCHRW13, before falling back to the default.

Patch 2 does not start the MC for the bring-up RCW

Patch 3 grant each carrier its serdes 1 lane using serdes1 hwconfig

Patch 4 gets carrier from the NOR


Changes in v2:
- new patch

Vincent Jardin (4):
  board: nbxv3: get carrier from the RCW build stamp
  board: nbxv3: do not start the MC for bring-up RCW
  board: nbxv3: serses 1 lane settings
  board: nbxv3: get carrier from the NOR overlay

 board/nxp/lx2160a/nbxv3/carrier.c   | 231 ++++++++++++++++++++++++++--
 board/nxp/lx2160a/nbxv3/carrier.h   |   7 +
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c |   4 +-
 doc/board/nxp/nbxv3.rst             |  87 ++++++++++-
 4 files changed, 311 insertions(+), 18 deletions(-)

---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
branch: for-upstream/nbxv3-carrier-rcw-stamp-v2

-- 
2.43.0

