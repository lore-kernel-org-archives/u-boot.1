Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EE6CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D4CB407C1;
	Tue, 29 Sep 2026 19:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MwFhEC45vUP; Tue, 29 Sep 2026 19:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D2890407BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710579;
	b=GTA+eIuYQVZenWigLqrgybLK1jk+3BqJFZsXQI3AaDeyc+sCFnuBrVmDDBtvPzu7e911
	 VjaCisSRt6SRjreshrqK/XygTIs5+sg6O44cHRWQ4/BK3pnNL2v9UiZh2AgTrf6nwIeOZ
	 OIk3Ys2ZbgLNZvn3OT+NGZCR4yffCsB1Jnqj7TgsoXvPX6vvWTchNHgQbp//xbQrzJRIh
	 Mh4c9J1JLYL6T+bVRZ/HFJoqARzPf7/7Sqe69uHRuJ0jz2n1NnSrPaJsuTlG4i3nXC4IL
	 NPwPAsoPrGSgoM7OIJAUFIRrbAFjL5hyr1FromHIrPJnumIbfYLV/1q6vmcebE0UDMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mIX3RFpGomfdlOZbPYQxCXdy6XQ1v2DKQF8GRIUD2MI=;
	b=CvdPixpsA+svRAS+GcipNUzTVHJ5kAMtSwuBWuhMPpRuH0C6mf4m2z7iJszyKdYH1rVX
	 eKb8u1cnnTDdTBWT3R6FLCgv20Hz8NpT7AB+rxuqRnhxcbvBu31EWVqq5QIf2f0RjBzQG
	 tsG/UAH+VjCsjHAvIf+IyukdCZix6uIPABt6QclAlJz6ySizhzzkJlrsSgOxw6sMNdSEq
	 0CIwlzfJO/ztBCK//G0F5ZupiFRIKQCgXVV/u5VdF0KTTLHywGECHFH1zj64Lwt1mBwmM
	 ndzY5uPWzx+Jk8txIcS9bgWHJQEVhXuyi5KjWyH5RM3J8xrs0qg4rM7/P2S2oeheRXg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710578;
	bh=mIX3RFpGomfdlOZbPYQxCXdy6XQ1v2DKQF8GRIUD2MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gx2oJlYt3KTXsBo99woM3kWupIhcMzr553PqT1FLd31j/dnesxy8J3UFSbPKc6FbT
	 gw4M1Wyl9PsvOxrhzRSZk9nYsk3ldVK0e3KQ6W4R31o/7TW33En9nazFI4C1FSAIh/
	 JGWVKny4hlA0N2W8uQ7miksUdf3ohw/bGb1R10tKTuISVunJyJ9b23u6kJ/Cii9eXq
	 pDpjS4w13pKfzz3vvVQjNy7zXvHvpERDT+daKS0YQxpHuffBOZBJkZ392BKdliMuBB
	 jzIdtzS7WZV8VES712EC3kOe4V7O3mx8dOKe4skCU2mr7ee1d0qEZGwt88EDhzDpFj
	 Clts78ZoQSIyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2890407BC;
	Tue, 29 Sep 2026 19:36:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 736F6282
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63A2280F29
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJijW2b1mTNw for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 34D4F80EF5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710576;
 b=gbY7fsut194PbVVvrJ+YgHOFgprNjNAxEvCNQOrRJtgFi2av9qzOFUsZ8wOV3jAOynUk
 Y9d6Ies9g8+BjDz5HSmjj28wxzOZiP1uahnaZ7+csyixV1LftodeCVwqxCYQ79WhLpV85
 T6ftWsIMSD4fdpbIBugyEHjXX4kNnVofF8E7/vQtnms33dtZ1UPZPf8w0Fdijffip4aZm
 mWOMS8g7rphi9VMc/DDFAw01zVhLFtmj/hcOCT0sJuec7nRjgjDVe26d3gN0PiIUiS6Rj
 WcU5O4Ce29yzQZLRgc2PsejAhYgg0LLlaIG3NxWDXJKJui9tsCEGuNi35QnhTrpS0SA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710576;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mIX3RFpGomfdlOZbPYQxCXdy6XQ1v2DKQF8GRIUD2MI=;
 b=S29hBOyhQ7a/3VtvGbhNIb7j2x8QPr8njl0m8M2sDNnq0irPOGHfqBzIAxPEB8G29LLb
 ojiK0DN7Wrqn/SZBytYiT2/g0Qw2Ck3wvqN7v/4gJ3zq6QavWoMmBVrXSDiExx4nzBmvL
 xssuP2lZj7EyiWGuSKaAcK8n4Wl83ME5sjVt5PvH6NdPVKDLNBggPsXgWWIwH5j8l5dMC
 UhBsOiaBRXtVsAuh9tuvqd03IFS3RED5dcZedN20oTB1PTK0S8pCUYeK+vTFUxVYShdqn
 MUFxo92x3oOx50VWAgnKesZCkH7cs5ee6ruyarO5RSja89Vzs/3SlkXcVi2Ve2c7DuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=NQMcmQoQ; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=NQMcmQoQ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34D4F80EF5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 9A88FB00563;
 Tue, 29 Sep 2026 21:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710573;
 bh=oXagBOaFry/x09TQINjdzYRVHnBBdc24OLUBNBpgKQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NQMcmQoQEEAGM0e+fUXTIYNpHZ/e/AYHKQ40hx1rYdK0KyRkqF114J7k6unL6tmpz
 ZQC+OCLUYVjo+xY1tZFJ8oAav6VzQVr1UE26A9zKdZrZMOYmZHwV+aIMnwOBwHnl3c
 QDjJkjTGx2t9YtjEBXMVswGrqHNzswgSP5Oe4CjkMqoA+dTqdZINmo1bojbBta4Rna
 UiTQ0fZCC+DoSir+3VjhWYEu9gr/8HFGO24PPLeNnK6OKRmwul+qeVTl+l3FlicNdM
 uFY7PyCvcb3SW8M4tP/r0mSGcZwyOiGF7g00P/d3DvS17q7+vTxveAWYL/KqkgxCYD
 IEyjO8rv9Faug==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 06/13] board: lx2160a: serdes: report unknown SD1 cases
Date: Tue, 29 Sep 2026 19:59:38 +0200
Message-ID: <20260929175947.1379710-7-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929175947.1379710-1-vjardin@free.fr>
References: <20260929175947.1379710-1-vjardin@free.fr>
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

---

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

