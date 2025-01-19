Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410E6C02183
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 14:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89166806DE;
	Sun, 19 Jan 2025 15:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="KT9pnFgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEA3801F5; Sun, 19 Jan 2025 15:27:04 +0100 (CET)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F197480085
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 15:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pZ010001011111@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1737296820; x=1737556020;
 bh=msahF1Eklr2FWYk+hmdr/w1fb/5cR3pdhmx5D6M8xb4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=KT9pnFgd/lhtVounGTGF4JzcIoMgmM7nneprgsm5nDDgMK/Y5zp0IpsJXvO6hmtjR
 0kjneB4yuPNzBxMAnn1K4GkAKQTsW5QX/vTMlVF4lGFeTCMShjG3OEpw55qdynrG4G
 IN9/43+PKTJmyRUybADKkWCglSf89ST17Nx9Hx4Qiy76FdDk1xgkgbI+CJ1toRffPd
 nEhuexKDjeYUaHmJwv7WyKoSulznO2zECtyrvj3xVevrpj/bwQ6vdBOlmBFfeyceV1
 vmvmjkptIfvBmNCdiMpzQeb+8M4OOg4oc0Onn60Al0tdYITiRQhK/d2FejyYRnhEnS
 f3VuEcCbm+3rg==
Date: Sun, 19 Jan 2025 14:26:54 +0000
To: danct12@riseup.net
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: agust@denx.de, dsimic@manjaro.org, frattaroli.nicolas@gmail.com,
 jonas@kwiboo.se, kever.yang@rock-chips.com, megi@xff.cz,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de, Piotr Zalewski <pZ010001011111@proton.me>
Subject: [PATCH 00/10] Rockchip VOP2 support
Message-ID: <20250119142549.661296-2-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 81982eda99b5c6ea32e90f9528ae997c7a55c174
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 19 Jan 2025 15:46:36 +0100
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

Hi all,

Sending another reply to make it clear that tested by applies to the whole
series.

Regards, Piotr Zalewski

Tested-by: Piotr Zalewski <pZ010001011111@proton.me>

