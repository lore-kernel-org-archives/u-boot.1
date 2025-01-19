Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5177FC02183
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 14:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A5080141;
	Sun, 19 Jan 2025 15:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="NfThF3Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0380B80141; Sun, 19 Jan 2025 14:24:17 +0100 (CET)
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch
 [79.135.106.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665A480017
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 14:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pZ010001011111@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1737293054; x=1737552254;
 bh=nqz7ySv0akO8N+yz8SqQy3I1epAVmDIzkH1diETtGF4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=NfThF3ZwJfe7NXCOLXjvXNyPO6j1poM2EJtTClrm6FcOFltTX3Pm2Ard8r1DGirhs
 F+pbYwfR1khZpkeiIz5/HXAAtQr7Ddwv65huw47F0MetnhV0Qx/BtDeAdQxmbYw3g7
 IVM/MZ64K80/ECUE98rREzcRLlmRSzQrOCa5ii89YISTQj8mzPtX6oEFP7FGE0TpFP
 VhohSoHW3VPw7cWlOjkLAgVwaM1qhOKr9bfSumYu9b0XPZ8D9RewtrE7/4ANGCLWQc
 +tZkd+HfeuUu3DbpOp0VQhvN+3/AWR7j8zeADWZdmtHvs7LvaGuiLGM7dxNTpidiQQ
 67zjhMh102vXw==
Date: Sun, 19 Jan 2025 13:24:06 +0000
To: danct12@riseup.net
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: agust@denx.de, dsimic@manjaro.org, frattaroli.nicolas@gmail.com,
 jonas@kwiboo.se, kever.yang@rock-chips.com, megi@xff.cz,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de, Piotr Zalewski <pZ010001011111@proton.me>
Subject: [PATCH 10/10] configs: pinetab2-rk3566: Enable video and USB keyboard
Message-ID: <20250119132308.453789-2-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: eef65ddf7279060e10ef2a131e23c65b3ad27cb9
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

We found with Dragan Simic that in order for usb keyboard to work after=20
boot-up without the need to set stdin manually to the value serial,usbkbd
SYS_CONSOLE_ENV_OVERWRITE option must be set to N.

Otherwise everything works. Tested on PineTab2.

Regards, Piotr Zalewski

Tested-by: Piotr Zalewski <pZ010001011111@proton.me>

