Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D331CCA470
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 04:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EDA834D4;
	Fri,  3 Oct 2025 06:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="E/LeFm5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16544835A2; Fri,  3 Oct 2025 06:20:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478808349B
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 06:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1759465200; x=1760070000; i=xypron.glpk@gmx.de;
 bh=AfsScuEqJKFCzdMil25sZBBRsWslUr2lvW4AlyNfH7k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=E/LeFm5J9tIio2BkUk9LemYhJ21quWmaHXco5JW9uDlgeCiGoL5cuTHterrOQaXZ
 xs4ynKv9YIdOfBxB4qEOebERru9smUjRYpJQLgMBHffMCJCPiK02MdGrGPmxJO57z
 v8p5mFEjVcSTtOryHVXc/ePwxBpOpcWB30dmEnRNwkGOip5M5V8uU/MF5gf/Sw9kp
 Aad1ofWL6K9BENUCYjsFmBu6cWHErWnARluNMOD4CFy8x8LIJj+s+IjV/1B3556mH
 fi/EfJw4vb7RPLIpZNfAmiMSgCsBumhYeo62eNLVJBhvGk1Xe9XM4JypdvAF31XJf
 KBpc/41eUrB8SmxQMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1uusL52yMl-00VAvI; Fri, 03
 Oct 2025 06:20:00 +0200
Message-ID: <b1655828-f404-46b1-8f33-85eb58ecd52a@gmx.de>
Date: Fri, 3 Oct 2025 06:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Martin Schwan <m.schwan@phytec.de>, Javier Tia <javier.tia@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull request doc-202510-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AkBfA7iibJU1YYVgY3TNZS/OZapyGGoFVZfyOxCeEXCl0BFtTtO
 CZZFwLy9VxV8iW9LDUDnKhtgrZaUuTXZKMbVwfTakacSOSOs7bz0Z7Qrp5a0G2PaHCRTu4C
 Sx3eRUmIsqN/llCXQMgnJqEvsOop0ri8CQaB6ibTgT444DcTic1/cegEU/8gLCOYgMWl8If
 oPAkiZjqPCnzkjyMt1azg==
UI-OutboundReport: notjunk:1;M01:P0:nAoV5oHmxrw=;+Bo2Cte8/e1r1qbFyjKxpHd/xNq
 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
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

Dear Tom,

The following documentation changes since commit=20
72f72fab00773f7ee89c9635e490908c0a058162:

   b4-config: Improve b4 config for correct operation (2025-10-02=20
11:30:15 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/doc-202510-rc6

for you to fetch changes up to a8d451aa14657bdfe8ad64c5f2883502a99ece8e:

   doc: pytest: Fix inline code and other formatting (2025-10-03=20
06:01:33 +0200)

Gitlab CI showed no issues building the documentation:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/27807

=2D---------------------------------------------------------------
Pull request doc-202510-rc6

* Update coding style to recommend b4 for patch submission
* pytest: Fix inline code and other formatting
* develop: fix grammar and syntax

=2D---------------------------------------------------------------
Javier Tia (1):
       doc: Update coding style to recommend b4 for patch submission

Martin Schwan (1):
       doc: pytest: Fix inline code and other formatting

Yegor Yefremov (1):
       doc: develop: fix grammar and syntax

  doc/develop/codingstyle.rst        |  54 ++++++++++--
  doc/develop/devicetree/control.rst |  14 +--
  doc/develop/pytest/usage.rst       | 173=20
+++++++++++++++++++------------------
  3 files changed, 142 insertions(+), 99 deletions(-)
