Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07579606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gWe9xTkZ;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=NT8Y28Vc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70B31608A4;
	Tue, 17 Nov 2026 09:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2yfX71hImsPB; Tue, 17 Nov 2026 09:19:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53419608AE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907196;
	b=sGZ3nKkwsrcQflUxfGevbtVsRLp/5HxU/Dy6B/DH/RLwwDThV0nrtu5bu0pGKqHKv6U4
	 SEk0t15Xt3NrL8dK2Wo6nj2KLfbqNF4P5gmV4C4LPeQPwLijXn2xecdLRJ3rb++20uxrz
	 bLowyJAfBWNU5L81BMpV44Ve7RqXX29GeWnlKYMKcR4sJ+jla7Var9sCOQwyri4M4ESxs
	 Z9rqp/dlP9XGSyv0h/EFvl6uJu0hB5p+haLR/xbx57d2VwSImlXoGQx3UO1xkEeD78sq5
	 dTvkc4p93s1heC9/3MnuT3wzOS+sJl0WnqHIedFxE39sHQemacIxUtKTWL+y23NEksw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JUrFyXgV5zNv6RTzN1iLGYELyrK3vk4qt0xMNJgqjrY=;
	b=n4HERU4nRHgCz8kNLL1zWPFwT9XteOWjo/46J/t3n/MQZJ/7jC2kpbdA8ENop3F0GOFL
	 q1S7/eP0DlN1hSmLZXxu6I/XLUZ0VBV0mrwMt7moN6KvQWXCACyqH8AnhqMwwKdidJiyE
	 DaNCIk2dHMHfRQuAJqRdomC2GbcfgF2lYdsxVa+3hZShh8vvAt1fTL1P1GDzDNExSlpib
	 FpMkTrZkodAn3B46V2f4ZNno9yDm7YkBHN499CZKJaiJdEm+P0u8NfEu+HuzP1n7oyJIH
	 zAbSOqunFIm5Z9D2sVcEH2KXG+sJRnxp0aO/CpUuu2BvCP2bipCYEx31pdSIYEoTD+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907196;
	bh=JUrFyXgV5zNv6RTzN1iLGYELyrK3vk4qt0xMNJgqjrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gWe9xTkZmNvmcbKoTZRP/rT6TquuFH+e33ao+81YjMQIjc5a7fGdAANZkEzZoI94f
	 TxKMgzYIKWMinjouzd9Q39ijnp/8SWD7jcdBXaKseEgs+qx2QlQNu8aG7cC02rrOm+
	 qnF03HpnE3cZOdeGCRcIqtBh6UUx6q6D9uWmOBueMCFLt0XEldojWT71TzzSSe2igP
	 7oWLEWOwXGdOCg/XOozLJw1N+4hULzky7sdMHAIEaqu7TPsYMjkeVuHfYrdC6M7p5P
	 kS8QoopwKX0epDuhR5PzbDRWQXM3oEJmWSx9vkqgQpQiCAzsZFp42cRYNQJvw8FzNO
	 S8MvUHOrjfvKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53419608AE;
	Tue, 17 Nov 2026 09:19:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 015ED13C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7524404C1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-kcpf15NTaF for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F2AB40433
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.125.25.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.10;
 helo=smtp-190a.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=NT8Y28Vc
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [185.125.25.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F2AB40433
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:45 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1q3C3dzwT;
 Tue, 17 Nov 2026 10:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907182;
 bh=JUrFyXgV5zNv6RTzN1iLGYELyrK3vk4qt0xMNJgqjrY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NT8Y28VcMGSqdjBCyI8EIHTey3BNb2Ur242zrh3ZmGkhE/r/FHTtUeIEsEDAeZuJ9
 wmf1bq7YQhkOwPJVwvS2w0cquQHHLiu2iqssaVutErySeQ5fy1k7vJwHfBsh0LAI9p
 /Sclf6P5wMSAsEI8Zad9X9Qa1MHZptu+b6IpphyKlaMIfiV3dtPJAmO+3f38aYDa9l
 xMY6ZMHXhbLr8AdnlbJNYxMlEan/kRWpGv9/rzB3xFo5xTtS0ORJjt6GiPO/TdiaFM
 aDbAfDHG11WcC7Oh3VnQ0QHXyGrBtGJeG7C/q33DFLq8qHPDboi+0rcptTBS9jQbQ7
 kgPGfAxxKOwPw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1n5rgKzj1w; Tue, 17 Nov 2026 10:19:41 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:10 +0100
Subject: [PATCH next 08/10] doc: rockchip: use sphinx admonition instead of
 subsection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-8-2cc0910f9455@cherry.de>
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

Make notes an admonition instead of a subsection so it is easier to read
and pops to the eye.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/rockchip/rockchip.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 72a316e58dad..41c8defd6888 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -328,13 +328,13 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
-Notes
-^^^^^
+.. note::
+        On RK3036, the SDMMC and the debug uart share the same iomux, so if
+        a SD card is the boot medium, the debug uart must be disabled.
 
-* rk3036: SDMMC and the debug uart share the same iomux, so if
-  a SD card is the boot medium, the debug uart must be disabled.
-* rk3066: eMMC and NAND share the same iomux, so if in MaskROM mode
-  and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
+.. note::
+        On RK3066, eMMC and NAND share the same iomux, so if in MaskROM mode
+        and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
 
 BootROM
 -------

-- 
2.56.1

