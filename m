Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D4606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L8Fh0feW;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Lu2DOz1o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59CEE6086B;
	Tue, 17 Nov 2026 09:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IFYn00jW18Xu; Tue, 17 Nov 2026 09:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6B4660877
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907190;
	b=kWmwuDKOZAO4pwuKLvqYSfREbnokMBoJRk56xe7NiZmLJbhL0nmJ5ZOd6eZIVckYtd3k
	 cpAoZ5o7IZX9y218915X9HFLXcW1LKwpyhyuyZGCNDW+EI05wgNgROCQ0j8RUgUw5ksRK
	 X8ALQEDrXKydnaQcMqim3N0+QUPPRtb9ovtselTE4D1olNhMMceHTHBu/1/x/uqAN8HTd
	 n1NGrn9HK1Z5ZplaQXnKxzDIYX4rKkidRIuHlwmuuM1IM8RdZ2Y6UnbyyTgM14Ccu32nv
	 3U93rMWSxxWlCS90Ogy1JIr3qRJ2uEYjUHmrll/9P6Keq5J4mkpaOgMGYc9SJvD+HgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=El0tpNnz2GngFVQwDmULnidC0yHEP1F2XUiOJ8DDLV4=;
	b=iFvd9MoyYB5j3Ae+u7kLUVgh47sK5O8Fbkl5yj4hsEFYCEItodwxdDrA6FAiLzrGdZuv
	 WFQ+zZkOX4rDKiD+5g816sEuExp6xYBBq0E1pbe3HhqyKHK6p5DPm1Fdi9sE1xl13BQll
	 FswLbwqORNguSZ0greiMZDd6Yqp2/0+dLgFjFg/V+mlN9uEo01dXSBtEkjkMzpIis6xBG
	 81KyqrCZ8Jtx0VBC0WzgjlIn1Gf1enzn0fF1To2WtpK8bxNshAeWY5wK3PIXVdldyrydK
	 vlV7zGYSqaeFNvDLf5HdjGFYhd8GlBhccsQt9x78Ylk6/yShZYC8evPXdZ4szVS+CRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907190;
	bh=El0tpNnz2GngFVQwDmULnidC0yHEP1F2XUiOJ8DDLV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8Fh0feWOZwUVyqzhcnFcDRMZNscduSeCPcKeMDEHkoqwL3DGSVOrrorl7oPAv7Ce
	 S9iOXKQcgSRyt4FzfIMqyi4etOMEJp5GCzfuaP2CUVwGsz5icegJvQohzSPS2udTs4
	 XAoeidJiIEIprrgBpQh5958KlYgZO6tQjlXw8rgieJTK2vcWpPPDDPF8WsGEurgL3Y
	 UUAuhLS7Yzpu8BxDObhdBe4nJiSnTJkTqZALAPIfZFs8oo2kRphA4ntdTZFPiSXmJB
	 Ykw4oD1vmHDlvs7THIvaBUpuX4WwldsvY+FLGqX2Oj4KmKAFa8CXx6UMdBbPcOgxNB
	 OD1h+b59hS8cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6B4660877;
	Tue, 17 Nov 2026 09:19:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05C71A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E00F3400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qbNVv7yDcQHH for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A60F7400BC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::bc0e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::bc0e; helo=smtp-bc0e.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=Lu2DOz1o
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::bc0e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A60F7400BC
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:43 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1m6Lm0zVG;
 Tue, 17 Nov 2026 10:19:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907180;
 bh=El0tpNnz2GngFVQwDmULnidC0yHEP1F2XUiOJ8DDLV4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Lu2DOz1oXgWBuXcmi+ha51WbPo89DvdzOgRQik4K1EdwV9Ae/PZrmV3ockFfo61kH
 Ygi/ubWBNmxPvRCW2Klday+gDK3ImJ8W5PJ3lppJlp0WLBPkJCoqdpiiPvMxUWYdVi
 Pg/R8qNQaKhgWnXXaty/tZJ9eCWYlayZwMtfQJ34FLgjxcT1ILtOonr4zlOlhltbJB
 nYCwgJ9Ue1ZfOvVd620RJpDVYzqp0rf4NUOmDcQWCFoYIwbc5jwHTxRVpBzr7Ot2A+
 lQoNq3KXLEpXMsS6B35FOt6bJjbGSPkRoQ9KrQbjqtS+0nUU5varVMdAdVZpmI5cCd
 QtdQr4n3ppOyw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1l0nMFzj6g; Tue, 17 Nov 2026 10:19:39 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:08 +0100
Subject: [PATCH next 06/10] doc: rockchip: expand on MaskROM mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-6-2cc0910f9455@cherry.de>
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Give a bit more information on MaskROM mode and when it is entered.

Based on wording from Jonas[1].

[1] https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/rockchip/rockchip.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index d9029715da5b..086d3fb5d739 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -346,8 +346,9 @@ not modifiable by the user.
 MaskROM mode
 -------------
 
-MaskROM mode is the fallback mode of the BootROM,
-in which it listens for USB commands 0x471/0x472.
+MaskROM mode is the fallback mode of the BootROM, when it hasn't found any
+bootable code in any of the supported storage media. In this mode, the BootROM
+listens for USB control commands 0x471/0x472.
 
 Options to get your board into MaskROM mode:
 

-- 
2.56.1

