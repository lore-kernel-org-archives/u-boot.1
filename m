Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A269C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 00:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBBD87206;
	Thu, 16 Nov 2023 01:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="I3WalHMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1222E8729D; Thu, 16 Nov 2023 01:54:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C048787278
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 01:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700096074; x=1700700874; i=xypron.glpk@gmx.de;
 bh=Fmq1N3aKOSQ2wyfekk2ZTViNeL5Abn+wm0bCpZJvYMU=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=I3WalHMqeczSR0lJeX6ndwNzlDaD1c4Cr2M1TpgTnOobb4/zmSQX7x3+PF/mxD1F
 /tEvKGq97xPzrs1H+WRHYqPLxDZ+mpqsX5oPkbfqwxFS03IaWIpcU9sga0tNjJroP
 1MSRFX4bCY6lPXNB6T9YPK17iydHEx99oBX/OvxXroraeuwchJc2MoGZFNxf3yyzV
 BSpisVzDwxJwBG8XfJ25XEyazRM4Qg1qv3qBa2PQ2mFokWSHPSNbBgG/y2STwY42f
 1FSAV+/ZiN/IiPkNE5YTBBUCiHYHIjau75kvImm8A0hx+RUBRJbZv083KbPQShQ0e
 F+P1/Sz5WZlY6hM9qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wKq-1r4WZy1loy-003K8u; Thu, 16
 Nov 2023 01:54:34 +0100
Message-ID: <8b4de31e-4f4e-4e21-ab33-2ca64b745b54@gmx.de>
Date: Thu, 16 Nov 2023 01:54:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Bug in distro_efi_boot()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kXUK9NcZgTbJtoXO/JNOhssGTFVZxsfeKqmBc2Yuo7RFrDfAXxK
 CIPcP0lhgNfJxI8ge5rwbpRHP3TkD0XkPTTs2EequAjzzL1ZSFuI45MDO6Z08WwrrrcWV/l
 2oMLLUlSVYgeqc2tqF2kw1tnHVtrBUumin+DG3DpmgV1DoyJZ5t76ZDNJ7g1V5wkH+WF37z
 onljHYXr0TmzafwvoHFSg==
UI-OutboundReport: notjunk:1;M01:P0:m04FDUTIL3Q=;UF8q1GJsV3H5BwGIO6x2CrMRh54
 bWo/L+zfPoSbMQQIwa8YDnSrKWkzsEA30SFBGfxS6bn/OVS/wQW/luXQ2lk/0+3EA4f7Mb8yK
 zkGkPPARQvq+2g0J/sYC5C5dJ8rcGFju0wLM/PPjgqMokEUWyw1nWQWTsGTns/OGuR/veoIoY
 JQML6P9VemjUcPf/Gj/Opp7i8n5BosF3G+K06zrqg23bpS/P1sg2PnD3kwtzBTZT+8MXgOKdv
 ogBR1gfF7arNDsvMKSe5+RV4WrM0ihjEXS5vwMCgmAOVBdLcaDoom+H63FZjsfv/IY5XwKbeJ
 1S2MXMXxrD4bVfdEpTU+aD3n1mXcByYSnAMu2nKeO//Xsc0+XZ9K5Dg3ExVqmLxrPxJYwdJl3
 b2TnAlrrQm7/lqwatSYwJU+pMT8RKfajawBzX0PSvBVuypIhwHJBYd9R9+wSzLmvfZ7zXumJf
 jO8ougQ4I+rdN6OJjQoDyHgCZMikzymcCcZtO3hEI//DxIjfLi/HWN9AKfB3e1tSSEnkoyhLA
 5O46yRpzsq9L9JZ8/KepiBhAySlrp5NXwi1icMB3mmtf7U0VTyca1sQULLrr4ZEjlTEMUX4pd
 88aFWw0B+FIlpGh5P70U8fpn8UnK4Qjxc7gBFuJYUlIEekG4eg+jn8TJr/UAXN3cki9XIc+i6
 S8IIt/iJh+L5nwcvbGSrb+Q2SztjwN8PAOTL1lCUlG+3SCHxjmWbp2iP36uigkg2WUlfKury5
 kqsCd8gYoX7n4uFDz7OdQxpHXZyNYRMormj4dgBIvTkSybqKRXUyf3GYZsl9DwBA/RSn2B3+j
 WvqojF/upeOPviXw7fxElpZyeBjg5zmndcTjdjNYRZA1F02206khswU1QkHYqNBG4U1lvmgF1
 /wYDUn6DGKyZaGC/H/jpvklZSbt2GfyLX4RK/R1wRI0HN62oBi19MoK4cCauydtlh1moW1P/c
 0jF1RQ==
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

Hello Simon,

In function distro_efi_boot() the bootefi command is called. The second
argument should only be passed if a device-tree has actually been
loaded. But this is not what the code does:

For network boot methods the value of $fdt_addr_r is passed as second
parameter though possibly no file has been loaded there. We should not
pass a second parameter to bootefi in this case if no device-tree was
loaded. The bootefi command will fall back to the U-Boot device-tree in
this case.

For other boot methods gd->fdt_blob is passed as second parameter. We
should not pass a second parameter in this case either.

Best regards

Heinrich
