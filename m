Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8714C5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC32660669;
	Sun,  9 Aug 2026 01:31:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlx4we_oG-xd; Sun,  9 Aug 2026 01:31:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC7AF6060C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239105;
	bh=6W8Wp96/EloqHNAw3btj1R9/EsChwuMLBXNgvXhxAeg=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=du98MPEjCGS8MqsmXWtopHTfrvRqPa3V7E0pvn26Pt6SxuEZSox+x7cLkd5KvsEXB
	 LyDlNErOSF4M9jPMjSUTi2xYeeAzQ0bZqeRsb4J+7VIxiWEXPS7GUm8/evR+Md+Bzn
	 rtfnVpz+ro7VB218JnMynY6j5MbzW/LrdTxuxMfDKDzFVLenV1Hq5ZzHzZgT171vuZ
	 aYI16AGblKxIszD8OaP4+5KvYD8PnazHtcwzduN/bXMi7FlZVh+EdxUxb7gbVktnM3
	 MWnTlZvCZqUFCGwh6XInc+YlMQE71JgpZAgfNmzPB/+sjR94LmQ7UO/At4FzrWHaMM
	 Ed6Ff1azgNETg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC7AF6060C;
	Sun,  9 Aug 2026 01:31:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 666FB2F5
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E935400D3
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CTtknKdL3Vt0 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:31:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 125AB40068
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 125AB40068
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 125AB40068
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:39 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hHgMs4yqjzMlFf;
 Sun, 09 Aug 2026 03:31:37 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: dts: renesas: r8a779g3: Drop invert microSD
 voltage selector on Retronix R-Car V4H Sparrow Hawk EVTB1
Date: Sun,  9 Aug 2026 03:31:01 +0200
Message-ID: <20260809013130.444086-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809013130.444086-1-marek.vasut+renesas@mailbox.org>
References: <20260809013130.444086-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1bkg4griyd6wu9w8in8tzi59c8sk7pzm
X-MBO-RS-ID: 08ebb483ef27c21b512
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6W8Wp96/EloqHNAw3btj1R9/EsChwuMLBXNgvXhxAeg=;
 b=JtO6N3xOY+OzYZ5jzTpesQXWwVkmRnqWYalhaLdnmlz3R9lea8NJgYSOZMUaIzAXNH8BUq
 3tngbT92Q804if8P5ylPCauFlU8Ouut5h/4//iBZ4/SD3R7HUcil00pNOePjcUmW+Z83Zj
 rEX4EQaJvsxjF+blfCdmSALhi/CEbDIl8188MQVXNuzhJFB7tCoJhUFBJHJXPOzvP+fYZK
 gBajfAHZOa9ihoqj9Vr1I5XcZ2KkjNGhWNf2wUaC7UxDVpiuqwcpD8W1PPx2H5kHEvjctq
 vBZwkDSzfD6+V//JUFtyFrdHQbNtBH+WWBerHvtfjMMc508NWDgxkFtBksRZZA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6W8Wp96/EloqHNAw3btj1R9/EsChwuMLBXNgvXhxAeg=;
 b=fuVj2Qjc8CpuIM7S1JNtI39jXxYGuB6h/h8XJy+iSmi8dbyFHJitUQhuTPnPA/Hcmuc5wd
 /80zklV3Hri9QBTJj53Sw2y8EPEd/Bu1lpfncUbdDzK4MRyK4EOSUE8cC7+eT5rQNCKtFS
 Uyz8tI/uSuF7/g++YGuSQ7BnVxcjlI2bpAPkCakXjRzRrE8amKbl/ZtC9xYMbSRdcnoJG+
 yt6alcIZpn+xwK31oDzni5H1qbpEFXJRW/exeRn5s+jTdgMAUCOyeEq10jMGC1eGsg4C4z
 njqLIcnkJFiJ/5+9Vo2WrCdx8jDnytkr2tVXTBZjxOAAt4pU/J2Ze/IFzh9dIg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=JtO6N3xO; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=fuVj2Qjc
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This reverts commit 74bc80190c48dce43a59cbae1975ccf10f671bc2.

This change is part of Linux 6.18.y DTs as commit
ae95807b00e1 ("arm64: dts: renesas: sparrow-hawk: Invert microSD voltage selector on EVTB1")
Drop the duplicate change from U-Boot DT.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index cdf5c9cdd64..53c1be3fae4 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -55,7 +55,3 @@
 		spi-rx-bus-width = <1>;
 	};
 };
-
-&vcc_sdhi {
-	states = <1800000 0>, <3300000 1>;
-};
-- 
2.53.0

