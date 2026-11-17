Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D7606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eXk4ZDr4;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=dJ4i4C7d
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7CAA6087A;
	Tue, 17 Nov 2026 09:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id foLgNM1px2Bq; Tue, 17 Nov 2026 09:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82D0060877
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907188;
	b=kH7ImQQkhs3wevmsZj67it8E1+gnze0j8zFoVM0qB+a006UdLiJyRs3UbkRc4/mY7hBw
	 bi0KLGEh+Kz+ey7qD5jdBo3F0Y7e0CvwK0Pptm4hhR6LhwHw0fHdM67JmLoeflFBHjPgr
	 E0zwM2U9FEuaDW5I8us49ZN/09rRSUiOIMdMyyNPIeWch8GMLkziARsq0RbP5qNb8kZGs
	 TAq1VdHV9hcK3fIL892a6sYLVbfBwRs9LetrL5V79deW683jh4sbwMaA2VcTfjb7IBUUm
	 q5Vn7srSdRvpyQb8ysu7obwdsUiNwLKEOgd6sNpBrA/7EUk2KMNaMnkjYIlEDer8q1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sVtAONlA4WCoIVgwdmbvRIEPdnuUHmdcbTo58x+vxA0=;
	b=MU26aTaB8pIr9WxJCoDtNqYYnstR66P87mjA9tMElBfgKr0MEKjEh+B5byhp1hdBSwtN
	 ZDCtKeLXxHCBwiiflND7K8pLutaRuU38VJlmof1p/KAeNz0BEYta25ptg2K09q7uXxaXq
	 nJw2hDsrsKPKs+Yl33goKzWRq1ms5XJxnQDovtsFLXBtaGDKgy7wq8yUVmTGUQzxjgE/U
	 mUvmwDN6rs4foN9ijg4iRUVjzmYKi3Qkf4Ax9UAhev5Sl5HI3RZS0OeAntULiXUZPddR5
	 SMY0+i6F4wq6GjH9SZKs13tpovOVRhUSt8BFTgewrrdmwN66t956aP98i92slXsJ5SQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=dJ4i4C7d;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907188;
	bh=sVtAONlA4WCoIVgwdmbvRIEPdnuUHmdcbTo58x+vxA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eXk4ZDr4qx6bsmFcc9y9xL0LMjKt6BULqLHjk4RQ+TykjuyOf7eEzEyKpdPNYmQ5g
	 BcdfutOkfbKG9knlG0JoVQbTsutnl2NX7SzW1RkuZT92PFyvAlz3PzImMWigkGlDSp
	 SQ6hwlBKqmJiO1X9MKZU7IeYSeUmxKLdRWw4sUMSsNPCISWkfd6341kuUk+H4oQxkS
	 LSp7McJ2vsL1zvham+3/9s/z4bmwVAMN/bypLMs2zUrfCcAfEP40DWnZLJc5T8J4FN
	 W+3OLlaqjDTWKxL5+n5+iyo3qgjNg4KsLJh6mcyfXvDY0eQC0ovMQAURTSRyat/+Ju
	 iOS3Vo2aNUfuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82D0060877;
	Tue, 17 Nov 2026 09:19:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A9040A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A48EB605EA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CW9F7WQCjU9W for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A071B60859
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=dJ4i4C7d
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A071B60859
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:41 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1h6XT3zt7b;
 Tue, 17 Nov 2026 10:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907176;
 bh=sVtAONlA4WCoIVgwdmbvRIEPdnuUHmdcbTo58x+vxA0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dJ4i4C7d9fikEPniIbZfNX6Et4JPijsmd8aPJbYGq9HdJW3F+iYU4caagvT0NKNLc
 Ti9tVHttn848FLhBLg6Ol34A3ok0M7vcyFBqS0CTbZJpYIZKxF8LEVFNioju224S5V
 ZLEHqawoFLyWbirT4y9pvUbZrRtLs9GluKTF9RPjeYKsITU4rubh0gbgp4F3H5ffR9
 +DLZpBUAhVhs0sbxxZlKiW4MuoLPXCRYgkvJlmqiaPVuCQenT4RauHhcHEBovgdsKo
 eo8ke6nUc+yK/K63oRc+o/y7ltMq1mOw77AYkmRudzf/7xlC+NU6l5WwRfq8x5Y4AL
 nKi/LAd88H2Ig==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1g3CGfzkGl; Tue, 17 Nov 2026 10:19:35 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:05 +0100
Subject: [PATCH next 03/10] rockchip: px30/3036: fix incorrect comment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-3-2cc0910f9455@cherry.de>
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

We return to BootROM, not MaskROM. The latter is the mode in which the
SoC is when the BootROM finds no compatible bootloader on any storage
medium and allows to upload binaries over USB.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/px30-board-tpl.c   | 2 +-
 arch/arm/mach-rockchip/rk3036-board-spl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
index 2a3dcdac845d..1d27719a633e 100644
--- a/arch/arm/mach-rockchip/px30-board-tpl.c
+++ b/arch/arm/mach-rockchip/px30-board-tpl.c
@@ -33,6 +33,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		printascii("sdram_init failed\n");
 
-	/* return to maskrom */
+	/* return to BootROM */
 	back_to_bootrom(BROM_BOOT_NEXTSTAGE);
 }
diff --git a/arch/arm/mach-rockchip/rk3036-board-spl.c b/arch/arm/mach-rockchip/rk3036-board-spl.c
index d69139278a8a..06818b698d8f 100644
--- a/arch/arm/mach-rockchip/rk3036-board-spl.c
+++ b/arch/arm/mach-rockchip/rk3036-board-spl.c
@@ -22,7 +22,7 @@ void board_init_f(ulong dummy)
 
 	sdram_init();
 
-	/* return to maskrom */
+	/* return to BootROM */
 	back_to_bootrom(BROM_BOOT_NEXTSTAGE);
 }
 

-- 
2.56.1

