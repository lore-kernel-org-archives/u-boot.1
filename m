Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5CDCA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE29A81198;
	Thu,  1 Oct 2026 20:50:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEXEjpBAj_pE; Thu,  1 Oct 2026 20:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A2DB811CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887804;
	b=JXHh1UmJvOz+Sp2JP0NV+pb5vL6YQsPf/jFGu+JWk/Z5QD81U3qAOC85kI652MyYxRUL
	 fKoazSYowKPMoQkaSvY9kIBiDedBhQ2tFbdOVTQlB1AnkLAlaqA/96g8XCZgOYeNMbRgv
	 e9RNb3MrMT3sSZW6CiUmok+Q0acypftuDcJBi/SmMOvXu56v6BtjsmbmfQkaxpIUo/qvn
	 lNcTPwmK9X9DAAzuCF6vRQmaesx8Rw0aX8+8EyCUCnz4c7fj+0xM92e8NWG3hEWCwcWSI
	 bO1vsSguUj7Yfops05oPh6yXH9vuRfplO45ZpwlhAvuHh13sxp57UG3kTs1NhM/8/1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d8k1TB9uMknTEie1YiahfD+PelilXMerw8yFSFc2U0Q=;
	b=JC3MPbw+uq5q/Cl9Hk8WYEuX6AgZgeM5+ZJDvyKlIPh6rO1zxq3GhVG/XnpoF2X3t2ya
	 Bp9P0qAp0iWTYk/jfIg+jweoL1T/JZwambJVLQ29xoOV3i1DE3A6oDlGxAFa1nn+riNai
	 HoVQskcV/8Wwp6sNOVkH2NhPQvcjjwyWOftVhIqohkDtrynCiyiMkwN/jRSGvHRs2NvPT
	 gilVhJRRpEYbjzS3QusPGMtAlQ2N5LIAG2Ewyw0ZadObrITsUb837LleTaOGtvhYbXV+r
	 3mYTmjDYRwuQr+GJYc8eOpLx2PL933XwHTET4/n95zLi3t9/On8F/0znNLCRNOwKojQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=k9tMO6VT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887804;
	bh=d8k1TB9uMknTEie1YiahfD+PelilXMerw8yFSFc2U0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M4f5sTLcmQSfP6RGfTosHZGmemkt1TNvn8UT/O7G1tc6K6b3nTNRwfzwPtjdXTdp8
	 D+7yd7kv/1/bhfBKjiNJf3tScLZLHKxNUeL8OIMmEJ+7HOSd1EZwrMeNfAEkkw1tzr
	 2r3uv2g4YRoun6R/c96mbrYK48DfAEgMeMGhadGpaTb0B1EScmuG1i86OLsOEAovra
	 h9SdMnZOMK9SuV6K7p3ssR4m4tMgLmGnaYjVwXcd7XCr1j/eigp3yGgBGWjMVyYhAO
	 D0u9rnStmwDubMGgyCwIOvnpFkaXjJu3DbNpMkQmR/hZFevuR4Bw56CWUaPJT8ENjW
	 Km9Dx7EEEvIkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A2DB811CE;
	Thu,  1 Oct 2026 20:50:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4038B22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32B10811F7
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMCQSivOGbg8 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8164381198
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887801;
 b=Vt7HpSAR5c+AeL3wcQQk9NWx1S9F8G+nzlZxPtlTwgJ5i1X34+aPbTaicqNtECfTLjEt
 5kJv1lVAwR8dnnspqBtMBGEJ1dl5mHBp9MSM7YrXD22+72OeNHuj0tlBmbALUsLu9+axY
 igYGX7xNSdYTdSuNEP8NaqP4Br8BOdNT465Qi8aQ8YiGImdjOAVdv5sAd3D50dWi/JfbB
 TGxY4ZgxKtOCV4rQNyL3CyDzwjdEaJnYmX0qFfY12TwaK0hq+jLZ4DnUE55SXsnGJNW4w
 zj6us7+g4gRRfq/NILrfINvUkiFkOlLhuCn/ID+rOfB/UXC9F/rXN2Rjgunv/EeF9RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887801;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=d8k1TB9uMknTEie1YiahfD+PelilXMerw8yFSFc2U0Q=;
 b=Tyb4cNeKKJIWJTs0iuUYko79Q74pmpdLGQWSKoEAjudZKlcziUpajdSSd6qBM/m23Py0
 EAHrETvOKDlNOSNlVwPzkrHlLhtht4s948eQW+Gf9MpovkLx8erPEYmhAO+Nx9B80t4is
 c9qDEbiVsdeSf3N9IIA1i8zIWZHbEaxWUgdBiyyx4VsbKnqXV9mQ2dPP77FAG+Tj+vFhe
 Tmm+Yia7N3EcNlbvtYO9kXvBBHsnBBrEGS/6JtXyNNYzAdc/tofu0coorhlZJk9AcFH85
 LSM157Y3inDz2+US6W8ZI+0KsO2+jAOvLBsVe9q/GwBHtuEc0HXPsRHtYVO/LhWAt6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=k9tMO6VT; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=k9tMO6VT
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8164381198
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8B587B00563;
 Thu,  1 Oct 2026 22:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887799;
 bh=fiUOkfBXKgzGOa5H/A1ukrUhbBDxDRnQyQkI4samp3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k9tMO6VT05lmO6GhVwlK7FZQxkc0C9BTFfBGTYMecPlcosvjYuYg2A785zlEE2Zvh
 586UIkmTD2Ytx+OW+IJXHntJIBtcOW+SANi//q3PN69KfF367RHgo29e1WZzdbsCzN
 A7omCSqljpTwd4dno3WWC0TH1YVDffZ8h3P1PMk+j0TwLKkifqCJgcCdbsMF93f05O
 JgDFM/ADsswiwLgo2jhWOglKLQz4fCpwM2Dwzgkm7ye4P9M5y3E+tY4t/TBcemOWIu
 uoTgamcG/wXNBDn4poYoxgesaQ6gu/Y83zSs7FArkMjmHttpeZSFuYEZ0T/dHSLSg/
 0AFUtH7Q7O9CA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 06/13] board: lx2160a: serdes: report unknown SD1 cases
Date: Thu,  1 Oct 2026 22:47:23 +0200
Message-ID: <20261001204731.1774613-7-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Check and if unknown display:
  lx2160a serdes: unknown hwconfig serdes1:split, ignored

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v5)

Changes in v5:
- Print the serdes1 value as hwconfig_arg() returns it, no sub-option

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 1cc9c7e5509..57504a2327c 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -515,7 +515,13 @@ void lx2160a_serdes_apply_hwconfig(void)
 		return;
 
 	mode = sd1_mode_find(arg, len);
-	if (!mode || mode->is_active(srds_base(FSL_SRDS_1)))
+	if (!mode) {
+		printf("lx2160a serdes: unknown hwconfig serdes1:%.*s, ignored\n",
+		       (int)len, arg);
+		return;
+	}
+
+	if (mode->is_active(srds_base(FSL_SRDS_1)))
 		return;
 
 	sd1_enter(mode);
-- 
2.43.0

