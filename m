Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB6606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cfq5To65;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=W3qfKLxQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95546405F6;
	Sun,  1 Nov 2026 14:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50yGtQ5-gyEz; Sun,  1 Nov 2026 14:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C56F5405E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793544696;
	b=D6KBJtzFiQ4UtqZsNYhKvGBVRRqPTwuxC+87Ed6r014YJqJseacQujtB6hXvwXSuPQf1
	 ahdhrnWzIaZ+oVg0WFLMpxLiaUv2AvldUT49feumyCyRL90YegVrlkXVqPjqjAgr6BBFo
	 lBg7UlynR6OPxyCYcqVhksW1pqfINut5ac6sYsp92lzX4wAnh5trwCDwJtT/si3nucUCl
	 TW7He8t5Jbdf7YW7Y8mxxyEavuVYa+XigwqeHwjpbbeqqsRoFXoFd1Lj61r77aXp4hOFo
	 LTCt5FTTGeQRN9/NxVYkUYU7VxjeNfVmfjCEd6gCGCjRdn1fYZPgzMZYSEW+m4bVUPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793544696;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j6w+O3ovkugxRPvcGPLDd+cXtTUM9xc/Q2TcPjO9ifU=;
	b=RTq5GYChZGgewprAHPeo7wTi0bKizSDJ0g1sE87ymuA8QGCArBFxRwJI6APqhMTCUG3Q
	 KSw6nXjbjqy2uB79OFBZo7eWsoWMCOPhGBNWla4REOwcCcKiZ+n5q6OAzqzeXusC7CqeY
	 XUZdtLnoV7GgLWLuXs26dnR8V5zPLLyGDRQTA/v/EXkOrUsy6/CRtdRBUo/zJxVtWasmM
	 TRd2bnDBDdiUOi+VtRtxy+0HmD9vFt0ryVDYS3A7Jr7+Gkrm+sb+Ws0+OsFRl8C9vL/5w
	 j5s31ErnYtEc+NKeq4A7Lzt7IZmn6PoOiH7kVuj0FOqJ50ASKv1wYLgZQ3cirfKX+zA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=W3qfKLxQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793544695;
	bh=j6w+O3ovkugxRPvcGPLDd+cXtTUM9xc/Q2TcPjO9ifU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cfq5To65tLJfJWHZBkMUpfXc5c2dYKcyOTAlbuGwOJxmf5rm9A+U9Ovfi8tB4AZTi
	 2nGqji2kkgmoqRTOFmJXPtyvuhGJCVNdWbOFf1v1dt1ea6+bjezhwoDXbgXvZryttM
	 0FARDjV/NbeO7N2w++a1R8Kuz03yuNrYotBDhQRK4V11YT+ZqC0P/0uw0INTQJ0kYe
	 WL5AxDh4ZEsCqu6XFKlD66UQqlzGO97qnBX5R059dWz4xE7mXNR5i1qXhX61spJ9sD
	 CgOR+zFM/RizGi7+zfHB9It8OfTBh6RCe99f+e4QJvchNoSfJxNQ8apgtZ6Ku0pPc3
	 Rj87UOSH5AXtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C56F5405E3;
	Sun,  1 Nov 2026 14:51:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F36194B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9179405E3
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFDXTZKm1dsO for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 14:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2EED540518
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793544694;
 b=LOEQRHDZeoc6pR7AzjmlRrG3x4Qop6ThWcnKAd+XRDReVMxo2ZT6caYOB52VV8hfUvRK
 HjiUOLhJZm48Yl/iPgCGQ1qvmrCNFB4yd2W1oxbB9syuq7uDFICeP1ljAEWoh58vVB4Xe
 iT+7VIMMhTpMPYh/w1WnKj98W1PTxkecvL52tsw81ZOHB3Y7EWxlJcsGuJwM0n+hUOlBi
 HdaJnq5eOBD1Y3gFYU968ctWXEqRmGcpzlwzgCpOFkAJ2cSzcEYQ2hOxayo2tFR5951nq
 2bLI7zYJundwyBn+VwFLhYrfYqjub2S6mhL2tIrv2zD8ulCf1ANehCG4FbzUldeGeYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793544694;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=j6w+O3ovkugxRPvcGPLDd+cXtTUM9xc/Q2TcPjO9ifU=;
 b=g5s9D+LlYUx3LlxfpcBuU6h5bVUAjZpXJDTz6loQDvSoiKshjbDIAia+swFxfQlSew9P
 OrTM9DVGeuRwoiMjqAc8SmDt3/40WoqBffT83IuEnDNdqbzJZh/GQFZ1Gsxe2ePTSVY6F
 6ycr7+DbuDEIGQV+AU4f/uOWe2K8CPoLSvq6XQBrkprXiHaulp5eO8c8DYaCsizeHKY2P
 fzlTWgbTltoqy6nF8U8ydDcsTkTLvFqoaz9I4KlG/m32xiOddNPFnKdw6syBiWvmEG1gO
 X+UvKupbLi6Z/e4X5kxw53y4I1WUPz2pLR6aPHRoSBSLgpA/WRJojoCG8+4eWlh/mSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=W3qfKLxQ; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=W3qfKLxQ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EED540518
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4A059B0053E;
 Sun,  1 Nov 2026 15:51:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793544692;
 bh=THLX/7/Z6OMwTR3y5yBcbsVokfDyeD/NgqdKoVuP2Cs=;
 h=From:To:Cc:Subject:Date:From;
 b=W3qfKLxQo+rNE1cN6U6Fu0jsin5BgOp7Ps57mOkblkp70wpTUaafrfk2ZmX9DP8O7
 xobgXWWsjkBRr1qzXKgLSsSvn/Y5TgxPthJN+X+K2t2kpMV54fHtnXo3cooRcJ+R29
 FPIi53LTAsKXqZyCLLeVH/+DiOwMaohCWudsW99elQB3+j9aXf85rlSSbJ5y6zBkuU
 O6VD8t+YTyTKUWEvFp4EUlvf8TJ3Vf688Odiva0LP3LLx4K7GO3nUyRXvY+K76IUq6
 AvNGPuWh5WaWtikvpV4UEoVwkiY7HI3ET4Li9p9nSViUz+zdBATWmjODz87lbGCmMN
 Uc9pdSl2fNdtA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 0/3] board: nbxv3: carrier from the RCW build stamp
Date: Sun,  1 Nov 2026 15:51:15 +0100
Message-ID: <20261101145119.348038-1-vjardin@free.fr>
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

The Nodebox v3 CPU Module plugs onto several carriers. ${carrier}
selects the kernel DTB, the MC DPC and the DPL loaded from the FIT.

Patch 1 reads the carrier from a stamp that the PBI of the RCW writes
into DCFG SCRATCHRW13, before falling back to the default.

Patch 2 does not start the MC for the bring-up RCW

Patch 3 grant each carrier its serdes 1 lane using serdes1 hwconfig



Vincent Jardin (3):
  board: nbxv3: get carrier from the RCW build stamp
  board: nbxv3: do not start the MC for bring-up RCW
  board: nbxv3: serses 1 lane settings

 board/nxp/lx2160a/nbxv3/carrier.c   | 211 ++++++++++++++++++++++++++--
 board/nxp/lx2160a/nbxv3/carrier.h   |   7 +
 board/nxp/lx2160a/nbxv3/eth_nbxv3.c |   4 +-
 doc/board/nxp/nbxv3.rst             |  63 ++++++++-
 4 files changed, 267 insertions(+), 18 deletions(-)

---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
branch: for-upstream/nbxv3-carrier-rcw-stamp-v1

-- 
2.43.0

