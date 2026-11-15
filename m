Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9457606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TZuuTBKr;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kdAl0UgJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FBD840612;
	Sun, 15 Nov 2026 20:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coqiD_VGhNcV; Sun, 15 Nov 2026 20:05:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D62E2405EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794773137;
	b=kUauNnOfd/Cdzo+PyJP/RBA97HaBfXTXJ9xEglI9IWZyzhuAzXqbtXHDNQQbP/32P1S6
	 /RqAEonU5rCXUBplwEM4nSrxBpBGKlMXySwmmC0/P9i4KaEEfra3Ix9lYl47ISOuhDKOl
	 mZ9zyKmJAddUZS8lURiVx5elo8sh7OSU5RUqfDErWg9zK+FdwIcifsAtnWBHQw8FtehFm
	 tL2T9OkGPB0fLd0UYtvbbGAxNFQn4hsOmbDjZm+or8GsUR3cNYchcvFMa0gFD0C/ZqxXw
	 xWA0y0sua9NLEzQvtmMhlaj5nl1FcuqOC4nmv1r2hdG8URUsxRyDZwInBW7GHHsJG+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794773137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FXX0JMfMtj4o5nKZOYgj4PiraLpic7p/EFaUn3eQCm4=;
	b=lMZjFh99AzCcsg7aMn2VY2z9qZsQFBVpMrrAumXqi3fYHW21lHP2G8A0gNARqfKVIEa5
	 miCdjgTgJO6pftl8bPO0x+PMxKQxrNPYYLxfCHw4iAq3FqoB52VTUJKSVz4vpSW+8qXY5
	 Ryw5t32lv94vJLQ5QlgBTPydwZC3f2u/Qh1V19yJEmN9+bsjftoJ00WkGK6r3rI6Pwa8T
	 qNehLRWijpYkR2zrmoD16Xc4REo/6RsPn42V4g+ZE4islnw7gdc/hZuuYRaw7H4eV8w14
	 3ADk/szKZRH64v2Jw7atfEDzwrDB58ftDhEPS4jfGgXm4Ewqk8CvdavOVYRjfcQQBUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794773137;
	bh=FXX0JMfMtj4o5nKZOYgj4PiraLpic7p/EFaUn3eQCm4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TZuuTBKrsIQ5yi71mHIf+TjRhSqnRtuNWKvIOLGiZ26nA7kKIRBtL20s8eBlsiYkY
	 EWHWwSX4uUTkF2LTQW+GBofjV9L4zlIFuHnTbraOZY5MFr4HQJRt4WfiRdRG+oxhNC
	 ilIUFIE10qVdgAh9hregGcMhw21c485R5ERorR/GkhYBaefNGZIFdH76vEhF1js2s3
	 BjH/KAt616E9O1c4m1xAbM2lqCoU6VHJVzX6MO7ZA4Ba1JZPEX9ogatZmlqMofLHqt
	 1HWlRlBvxyNg+Kpbmb4WG9gj+sZ16CpIOKT1AlunUkMRnZnvQdc62rfJM4xlaKfsOp
	 aNPnrl7sxnvVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D62E2405EF;
	Sun, 15 Nov 2026 20:05:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F4EBD7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 260D960612
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzD-Tk_Ju2uY for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 20:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F9B060607
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kdAl0UgJ
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F9B060607
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1794773134;
 bh=FXX0JMfMtj4o5nKZOYgj4PiraLpic7p/EFaUn3eQCm4=;
 b=kdAl0UgJ6iomWu6LGDCzx+ykdoY6YAGBKfSu6LdVBL9G3wV7UzSXNXBG0Y22wXNSHICc4g5ST
 gitzT48uD8KIMiFGC1CFox8byIDx1ryaDN4czQkdSObF7167vCm7g14K+CgptZ8NFI14jkfW+0z
 KeC37gfWbaNrHtMOYp5XCiyu8XbGlBttWWeSFe6qauOOiomHXPDts4z/BPySAN/Mz8pnzC1TprY
 m/WGBFu+pYzFK5Jdn7Ccob8Emu6sI5E6ToptEKbdpAo4gKZtZuZBjDnEnDRN8sJgz87Tdi1Xvwp
 sZrWJB5YT/3knsPiJqDN1CLygw2RKEIRsY2lNccFWpyw==
X-Forward-Email-ID: 6afa108b9dad7a125a77fa27
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] clk: rockchip: rk3576: Use correct mask for UART1 parent clock
Date: Sun, 15 Nov 2026 20:05:26 +0000
Message-ID: <20261115200526.120871-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the parent clock selection mask instead of the shift value when
reading the parent clock selection to correctly report SCLK_UART1 rate.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3576.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index a7e0febfdae8..117bef2eba1e 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -1807,7 +1807,7 @@ static ulong rk3576_uart_get_rate(struct rk3576_clk_priv *priv, ulong clk_id)
 		return -ENOENT;
 	}
 	if (clk_id == SCLK_UART1) {
-		src = (con & CLK_UART1_SRC_SEL_SHIFT) >> CLK_UART1_SRC_SEL_SHIFT;
+		src = (con & CLK_UART1_SRC_SEL_MASK) >> CLK_UART1_SRC_SEL_SHIFT;
 		div = (con & CLK_UART1_SRC_DIV_MASK) >> CLK_UART1_SRC_DIV_SHIFT;
 	} else {
 		src = (con & CLK_UART_SEL_MASK) >> CLK_UART_SEL_SHIFT;
-- 
2.56.1

