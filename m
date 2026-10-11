Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5470BCA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2287C80BE9;
	Sun, 11 Oct 2026 22:32:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UT1Lc43dhQpE; Sun, 11 Oct 2026 22:32:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D0C480B7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757968;
	b=qjFUCcIlxn6+3nofnIRXIgl/9TEDXro5Qnn9TtVHQWmSfvOwR5k9qwMcXUT7SFhLCHsY
	 5sf2zMMxE6q85caMypfM0H0z2RZw4doRacBFuXnh3KkmKDnLtsJVbw0BCBz2T6uxQIDFa
	 x4j5S6UP/vRhveYRm5BhwTOM2n/APGx5KKQeJ1b3CqrhBK6Qr+fjcfAOnkqRQYuML4nJR
	 6HPkKNtBadsGcDWvCEFkb+FsFeeVwIQ2OakZtBXgNnzYnFwWzMdsqRGYf8iT93f0BGG+p
	 O+Y1KBHvejnyr+1WnCRjAyAk94C98Y58DU9yH6l9tIAvQwfnWJBYBRJ0dJks9uur93Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ar9aOjVbZvwz142Lk7KluVCqfcitxd/OlQf+iipXHPc=;
	b=ZGwV5CrhXoASITWYGxrG7i6s9BWl2dOX9KwwyorGRCswkkqc2L7XT3NZ7LcTnLbfIDZW
	 430X0fFtl1EYhRPdd1IJNmAtUftxwDvq14nI3mMsnlkD62y4NVlzVX+eVrGo96gH5aTpz
	 QzmXHghscknL3iuWNWzgQsEVx1x56mAH3qXO8Pfn1USPIjqhtTqjsdGBvHHS6oPm/wDRA
	 FMakflZC7AN3pjlBx23yLAJ/c+lbHWROFQiIpRYoXK/t6JOsLf50muUKPfdXNTAXFt0pE
	 rCLZNdqLu48E0V5ltkSE9Zepb0X7f9hNcNyaKT4WmLmpaIphtUkU1OFkJlb91ixOVyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=V213TPTj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757968;
	bh=ar9aOjVbZvwz142Lk7KluVCqfcitxd/OlQf+iipXHPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qInSWtxVywBTeTXZlzacZLysU4uzl8tgZkhIPE6Jch9OwULj5u4SmwtlTSJAjRa8T
	 vnOruA3TAhzRQbqw0xxhUq8seoQC83MldfF6XlFWj8XjfM+nL7mRtoqaEUF7ufiTSP
	 PjAnOMcaviycwLQF8SR7TQ4OtClQdSWjfsAq1YnWMnVsKKs5kY6xlAaTMmtoBXXZQh
	 XCM3fktAPLqi7L2yQA0UDSYxr9TLKygWo10UzGR3yTRRLJe5igJAYGM13wbQRu0oLS
	 GdSM5wSUMCRrLvnWWKnzwe7gPYeFelIt4lXvByz1icXA9mJqTefvbzSI7MTHwa1HtR
	 WFqq5GXUq0jXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D0C480B7D;
	Sun, 11 Oct 2026 22:32:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA594D5E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C09C880BE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqPCH8LoVqBj for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:32:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BA6580B88
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757967;
 b=d+HIk/m4BS96r0iN55Wl/GKvjpcXJFRrJwngt44hmUP/b1+rogEI5zfc/uRa3AleO63T
 IddKT0bP/UYYbFRhhuhGhn3iFSQ+djeu2SOUbjZ277L8+surQvK0MWMtAWsyx8xKrNlZn
 sT+uYx5ZsRIY4l3LPO9DyZeHcfaxyW7iU7p36WxOxa8hzDHKVIA9W0HLrdw+ZnozCSfgm
 Yseng6SQHEU2/rqUjoEuHiG7XkjsQ4SSdzzlcffevE+4Ktt4CfryOluSsoswtJ76fWnBE
 SkZKo7ahjD5vt9ki6fdyeGlbzkQhbic7B1ggl/x8+jyPVooSeazxQrqXrMvwe5U3u8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757967;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=ar9aOjVbZvwz142Lk7KluVCqfcitxd/OlQf+iipXHPc=;
 b=MG5quYtucJNqenOypk9kT22upA5quZHKpbb7wgWW/evX2vemH3mQcuk+NYw/pS6GeAMb
 6DRrCfUChcri1bpM6T36jbo6hszJTdEzQqyUSej9LZPdEyo6LGD9r9Tp/Qrn5yM51/fU6
 +ZE8LoBGvHebyNyxzgZWMYXXau/rx8fjzSr+/0bMJw761eg+sOt8+I+AkIb90nG17fkDK
 Wf3uKcBXyUGj9DcDXARCflDe7Jz3H+ad54MHBeMuC4fKl4Qews4wDnYNti46DUIw7+80O
 zIMQhfrA0zhu1x39KLjY68yekCLq/5n3gcXhBIGp80y3wS9K9+tEQD75yisMhIvG1CQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=V213TPTj; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=V213TPTj
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BA6580B88
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757966; bh=ar9aOjVbZvwz142Lk7KluVCqfcitxd/OlQf+iipXHPc=;
 b=V213TPTjPo8deDq0fYRlekGEEI8tj4M0mlEgGbCEcYwUzSJah0AxNEEat3ks5iveUEcEu18gt
 wYm4tAaHM/xLhn4Z5CNNEApYcBohyNFNtcqpWfYPr4UnR2jacp6/AKpu7KGKk9738c5Mok/UP/3
 9XR8XNK091PQr6dfJpS2ABUAQgAKK6k3yWlUflRbhRa1dDWrLOxijSc0eqgAuLYCLuQJCaaSUyj
 25nuQ7wNwsod1isnVsx/1VAqGBqrponPAXmyhIzOZdiOv/QcewkvpsXsIasmJ6pY1wXb30umjXq
 Ty5m/m3qi0GB77m5DGnHc8Hy4FjwRTkkMNk4VGzvyd+A==
X-Forward-Email-ID: 6acc0dfc4548822a24c173dc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@edgeble.ai>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 12/37] clk: rockchip: rk3588: Use correct PLL rate for
 SCLK_UARTx divider
Date: Sun, 11 Oct 2026 22:28:47 +0000
Message-ID: <20261011222930.1085075-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
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

Calculate the divider from the CPLL rate instead of the GPLL rate when
CPLL is selected as the SCLK_UARTx parent.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index a4fd3a57ad7f..dbb4cd57e250 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1343,7 +1343,7 @@ static ulong rk3588_uart_set_rate(struct rk3588_clk_priv *priv,
 	} else if (priv->cpll_hz % rate == 0) {
 		clk_src = CLK_UART_SRC_SEL_CPLL;
 		uart_src = CLK_UART_SEL_SRC;
-		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
 	} else if (rate == OSC_HZ) {
 		clk_src = CLK_UART_SRC_SEL_GPLL;
 		uart_src = CLK_UART_SEL_XIN24M;
-- 
2.55.0

