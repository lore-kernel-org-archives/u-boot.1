Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC98CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5988760820;
	Tue, 29 Sep 2026 19:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mNyNEbSWtog5; Tue, 29 Sep 2026 19:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B2D6A607F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710727;
	b=nH7nfSQVGH1QRp6qlOtwDC7pEjJHs9nffjYrXKHtRGtCTdauUYwsGCzgG9Vfr8maYYEn
	 dF1xoneRrc+U3wImwINST+Rr4HRicp3WzK/9klBf3bsW0XXt8/kgkt/38wNfWQvsEGFa9
	 ov0wfcrwQwJQ3DrmvVvp2ToYNgeh4gWo0NKdNRrzpBOJoZ2qZ0uPtDkmx6+XsIJ0rvLpM
	 3EnubTDbtE9O85dm+aKHZC7b10JLiVM7R2JM+Hn8QhPqcw9vZSiBXzkm3zKbkkzgkw/yv
	 xahhw4SkTZwAXojVabgVny+E0tKZCsRuzm97zcY+esbmFa1IFCDkt6QefpHcURHFkyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710727;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V8Gt4ay03FXe1Y17Dr6llWpRni6WOBroF+hOjYHVfSE=;
	b=l7GOLfYtmgdoqAShI1gDEO0iUd5c0U3IdCDEV9ePjX44Yz+95giG0sL2GAD8IoKet86b
	 EAsveYyEslgRF0wWxtyHhxRH9mKUlP6SCQWVwd/To+lts+3ZjL18sJT6aSx9x3Uhp1a82
	 Go8TIe/wRFIyxsJfPeOZPKRHlNRRnfs4igty1c+IfqJ4TwIyHeQCgLNmYsFlF/dQ97wwb
	 Gi8epAZmeNIeA56m97LFKp/yF7hf5qCGgdcAUdvFXX8IZmiZpQJnRztHOMrWvJ3OGPZ+n
	 fAylCJayEsdjEI2UTxdf3qa0RcNhp0qhqjtImwDzF3owMfQzjnCOq0vl++THu1kM48Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710727;
	bh=V8Gt4ay03FXe1Y17Dr6llWpRni6WOBroF+hOjYHVfSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJ/3F1sjQE2tWWkL1yB2hLYih0jNULTfgYBRjvGSJKryrdrJuPFQ8Z6a90GJOM20R
	 VAy3vvQlD1pUHvGmRrKMNK+aILzA+s/yz32bcISXv4OOZ/m0TvCOx5QAmLKLeThNo3
	 LJpJ7UQwIB/ASpVCVIwyEexGNmo8xOaeLZI7qRv06noBDXv5OxJoP0Va5qwEJEKEp+
	 lKvDlCcpaCzQDKsnUyfeabX0JWsM4s9ToxWgZphQ8v83RMCCesQR6Kot/KOhq76jlX
	 Dq0Y0Y7R393KbPhTr6aw6+7cXWnvIfhYgW6qADaQsksAW0sjIcxN2Xtpo5j7GxKnap
	 OjrEJHzoCeUTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2D6A607F0;
	Tue, 29 Sep 2026 19:38:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B5BF24E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 417834032B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1YxoyCqvOhu for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:38:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9D4F4400D5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710725;
 b=bmXelhbjSuIszQ0WCfPrmYYIFxBjwvQuvGakNrSjFWFpLxQijSk98v95zo/rPDB2DvNJ
 TCOn0UITArckuxCugNj8VxZm8cQ1wQzVe/7NfU+6v9VbeuALAQpQFAp4iNk58ZLAkqE6+
 qr+3cYZpn/YOdPa0bBcT+4Sf3jKl3sAPYq0FzQEXa6QUoWPsDbBbRanXaov4aRSb663Ab
 CojSs+MAfJY/MhZCthgbTFXy4usNNnN5yVtEE8qEsHE6DBPa7x+oWXN82RFib5yBZnTIi
 1/dx1TecGx20jiI90Q0sgbYE/XIrf6M6UbkAiLuDohfKGK2ho03cnoLu/2ioJ2wSw3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710725;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=V8Gt4ay03FXe1Y17Dr6llWpRni6WOBroF+hOjYHVfSE=;
 b=rumFo1CoQTXl0nfmYCMfpxf2Y18GgC42jn9HrJDvQKDmN1RefHRQqR9rhFAhYq6sI5C+
 QQd4nIQZq4z+4YHRsU/vIR9Hhou4YxObXYNuryh/EMmAPH4TTwuAvmwfi/He2AdCPns6d
 i9s7zxDWftoU4BIDbL0L4blnLZh3IzbJFw7ENdMe6a7JlUuYAV6hdcX7WAh6zky0T+oq2
 rogugSz4+W34EOfmLrO7esh9o0/SMfiqkoWbnraplO/AoDoO/8yqLQpQuU8WBNUA54WyM
 w6ICQq3xdwglZtx9/YOuFlOPiCvtIojdZvh8vKbhcCHF8J5CI3dDcIY01fczKffSkfw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=knjxSSmZ; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=knjxSSmZ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D4F4400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id CD35AB00579;
 Tue, 29 Sep 2026 21:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710723;
 bh=GrDfhFZI0BFTrB+Jmoq1P2IDLqtmOOjRmFkNXdboe58=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=knjxSSmZrggA52H0ZaWqUrpboPQAy39USRH+OXGsWt7aQv4Flsd6LP+q+U3G73aUi
 e6xWa+TTSol+ZMnWJz3jrfGhYj4xDiPUx0AaRfj+V9Mulg9VZ40X6ZhxhNkfEAXMHo
 lwSzzKYpDHtRfZXVe8WvNwYDFIpf8IxeIKB6tss8RZ1pojquzSThD9CYZPkAnEzGUo
 xrtcpURSx4I9QGq8WTBFdmBMGJBr5QZEmVAR4HR3gNXSQIVh9HNTxcAomCyA1K5KXs
 Uo2kWUIOBZl8xySgI2bkQFnvpkOiAeaR0ZGAUtscfkr9N1E9w+rDm3+pohy+DIEggk
 eZLiXRJdRQ8hg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 13/13] board: nbxv3: apply sd1 hwconfig before MC starts
Date: Tue, 29 Sep 2026 19:59:45 +0200
Message-ID: <20260929175947.1379710-14-vjardin@free.fr>
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

Apply this feature to the nbxv3 board too.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

Changes in v5:
- No doc change: the doc no longer lists the boards

Changes in v4:
- New patch

 board/nxp/lx2160a/nbxv3/eth_nbxv3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
index a8d249c5cac..69873909733 100644
--- a/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
+++ b/board/nxp/lx2160a/nbxv3/eth_nbxv3.c
@@ -15,6 +15,7 @@
 #include <fsl-mc/fsl_mc.h>
 
 #include "carrier.h"
+#include "../serdes_split.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -34,6 +35,8 @@ void reset_phy(void)
 	 */
 	nbxv3_carrier_env_init();
 
+	lx2160a_serdes_apply_hwconfig();
+
 	if (IS_ENABLED(CONFIG_FSL_MC_ENET))
 		mc_env_boot();
 }
-- 
2.43.0

