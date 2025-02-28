Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96213C282CD
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 04:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE6F381115;
	Sat,  1 Mar 2025 05:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Gq9FCkuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCA4809A5; Fri, 28 Feb 2025 23:11:11 +0100 (CET)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532E5810EB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 23:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pZ010001011111@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1740780667; x=1741039867;
 bh=8mX3+X+Bizg1NYaefbIyrIL1SvjbcGsTwKse9D2aeLM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=Gq9FCkuZLnLTIdjdQHdchBk4r8zsk1MuvKEk5pNpjDyMlgQm7D5mlFzEuB00OerIR
 jfA+oPTgb9j8Aoy2DolXJQSJFqqpXtn/FBFJ+YLTHACSxRBTIuKN0Ueo/rlDv4MItl
 hP8TmTI6HqbPv0IQ/p9TA41KcevvxvOGw5hKNsh06i8eKX+vQ8MmVUgapCe04cTAER
 bfJJKNbvKXAZstLNNmPbfa5SlsR/CuVmpijbDj7x2DMhi+VaOWQwFBtKEn4sKLdBfd
 PGV82YTK9rpiglwLfH/WkRAeT/T7oDhq2+eRXVWkfyhS/o9WIzLvH1Oi0uhfuERDBO
 kKktij4TCZE0Q==
Date: Fri, 28 Feb 2025 22:11:01 +0000
To: Dang Huynh <danct12@riseup.net>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/11] Rockchip VOP2 support
Message-ID: <374acb53-2e36-4bc1-b414-fdeab5805283@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: ecf1627ef43bbe4e9d7baa1035f7e8b209e5fde5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Mar 2025 05:32:55 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Tested on pinetab2. With v2 usb start isn't called on boot because
USB_PREBOOT config was disabled so keyboard doesn't work until it is
manually typed through serial console. Also there is less console output
than in v1 because PRE_CONSOLE_BUFFER is disabled. Perhaps disabling those
2 was intentional but I haven't found an explanation in patch descriptions.
Otherwise everything ok.

Tested-by: Piotr Zalewski <pZ010001011111@proton.me>

