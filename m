Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD86606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OR/a0b0r;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=W5sIW0YM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FA6060849;
	Tue, 17 Nov 2026 09:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1jFEpKcFF7C8; Tue, 17 Nov 2026 09:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6790E60873
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907193;
	b=Spo+Rw+rsOLApi249wK0byDZk+VMsc7hy/nCndRDFhdQwsGzZrimJLHAX9V0zojiPOYB
	 C0JOI2UJ/wl3ir49Y5kKO6iL5ADlto3oczEOojj6WxIkj54NcJy+mpQvzACqCwsCaO4M3
	 5qZFW7FxIJpAe6Gt7QfOR7YWozXgOHeLWoAAUb3IgFb/1g6FRPmNHf3hyLr/5Tv4wa3Im
	 cVk045ykAaGp0s9yCNauZibJ204T5MhR1ecGp6wT99xdFip87p75ZMHF1pNfU8o+bSNun
	 /WgYnSdBbY7Cs+Ep4PihucBBoBFmX6oFCd6+jThJ42YopCohrxj/xfW6IHwZbn+3ftA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HG6oijAqTP3HsJjlEJGxlB+rFE2p+4N4iKyd5yUHuY8=;
	b=FgOxfus/INUqeLr98mWKsYVdswxoeVid4Ty7j5dTIL165I5r4CR9c4j6dsV/pqMTTGnO
	 X6K5DczfBx1uQ6h7LE2F/hIRJdyf/G5Yn8eNjP+hiFIGcntQ+RdtfuUiaGahYA9A7t4AV
	 sf7xeZHx4M6YN3i1ll7fMK3MatEn07dH91i6zC6UPaXXN6bf4pYCSbHWyx0AL9u1e8hq+
	 FwiH0feMGF4cUL6Dd70soXgBzTdxfGalyD0KD7K2RoFNMZi/hrXQUD2+iR+8L9gihUl/m
	 8PH3miOZqYjojjh8h5dryGNw65bF9MM2cEM1seLjkdkvnTdyYQs6Dx6v3w/4JxsSreQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907193;
	bh=HG6oijAqTP3HsJjlEJGxlB+rFE2p+4N4iKyd5yUHuY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OR/a0b0rzGMNKT+o39Fs/GhvLlv1rKnFy1Ukv6L+h8Htynx/GrO4nDPFqWlKmi61z
	 MUU1hWe6E7uI+H++i7xjg7UNB6qHrv53BaROz4iJyprV+o5fhnx4yAT8H6uph/i0Za
	 geiznUOFO1fmUyHDIFRIOGpIrdrYuii5O5YbAGvOEQMJvXbJIV4nB00Gt5vPrIVHVe
	 Agli0IReYIuqsxMCpczn41Vmva5CdCJPmqs8pHzGlSJ3WYHNWXz5CBVV24bYGgFoyM
	 lia98QE9fhQIRSkLyerQ4m30hlAgFjUqM1enYC9Hmk/dHYSev6GiR8SGRKZPv+11Mn
	 eTtLhXE5WaPKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6790E60873;
	Tue, 17 Nov 2026 09:19:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C1E713C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E65CB80F70
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1v8_eOx6CgK for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C326080DFD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=W5sIW0YM
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C326080DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:44 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1p1jhqzr9;
 Tue, 17 Nov 2026 10:19:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907181;
 bh=HG6oijAqTP3HsJjlEJGxlB+rFE2p+4N4iKyd5yUHuY8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=W5sIW0YMAPOIMzKAtR5kvwMi8+I3DHnwqemDJYzzCvpED8DbaBipFnesTJqQLc2IT
 eAZkqG0GqR8ulW0KRZmUPf3w41hLMWqOF/QLqadCZJFEONW8YhMnHlQ4ZLnc1ifcMI
 lKGywx2tifwm6q4+eUxGB0BuF8AmutyPGB7kYbOToMlGDT3onzEuKOTFYtFFDJ7Kai
 qQzllRFYvCSL1sUtSwJLLae7sT+IAdwXUoN14+2bIq8Bq9SoF5c3o/67IA0NinNjEo
 lfJn+vW1AAyG1GeMQIghiag/ttVIE2GcyxJ/m3LSKWIl4o9aabooqV61uQQZPonTQj
 0UXWNX5Getw2w==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1m3lmXzbDC; Tue, 17 Nov 2026 10:19:40 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:09 +0100
Subject: [PATCH next 07/10] doc: rockchip: fix incorrect section header
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-7-2cc0910f9455@cherry.de>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

The correct term for Rockchip platforms for the code running from the
ROM is BootROM, so let's reword to match that.

Fixes: a70ce65eec42 ("rockchip: doc: add back to ROM section")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/rockchip/rockchip.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 086d3fb5d739..72a316e58dad 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -582,8 +582,8 @@ config-flash.ini:
 Boot flow
 ---------
 
-Back to ROM
-^^^^^^^^^^^
+Back to BootROM
+^^^^^^^^^^^^^^^
 
 Rockchip SoCs have the ability to load a second loader binary.
 If enabled, the TPL/SPL code will return to the BootROM, which will then

-- 
2.56.1

