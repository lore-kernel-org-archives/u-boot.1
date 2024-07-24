Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E0C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 01:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138DB885B9;
	Wed, 24 Jul 2024 03:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOTxKxrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B2C8811C; Wed, 24 Jul 2024 03:38:51 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B4A8872F
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52efd91dd28so658194e87.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 18:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721785121; x=1722389921; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crSu8K5kK+vWb2fDsZRQMK7He7Tr794SgMgIw0xiqfc=;
 b=YOTxKxrf//u0T5d5qgu6SAqwzE0JvfrO8D8z0Vt0ZobV7aTd/3nrCHUWr4+Np2ztLo
 eWuYxqpC/68jUecLO2ux0s5ssCxcYIJ9M9pfuimMD39d6K9QGnV3byOFBVy5+Zdxi/nZ
 v43fbHGPt/bDVqcE/Baqd3hP/C1QwA0N2cQwn1aEIDIeFyze3v+tUivnBZAa65kr+4TS
 3GGB6V/Sn2aJzi3xfM5n/jROelvP2Yh1dnff/I0y5MZ3H9vYAHXEmXYjo769VTsrfGwp
 NFyGW/cKgvcVMVflGwf2VlEEx0EP0KyLKOChXyFn5GONN/7YyqG0SPr3IGd+hX383lbT
 4m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721785121; x=1722389921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crSu8K5kK+vWb2fDsZRQMK7He7Tr794SgMgIw0xiqfc=;
 b=SSwfWXQNtpjrphED6kWK0PIbxRsAN+WaGyV9rNZDlImmboDtuz0hHCHe3UuRIM+5uE
 iSvEHKDNzWq7BnoH97cWNezfaT1KlBU0m5PpgmT+J5ZjaAWrPbDOWIR7cmMIE/LSZzsb
 JpbxPmMpmaGihP0xpNENWSby4auhWn0TY3bCOwqI+l9fxPX+1ZE1Ixtt+yIUE0fvumE0
 mbU7hwdhtgxAbQI3VtEa9eHiOg7PFqNntdpn/sck7V7qPzH7y2k+JOS0SY02PDTuToZu
 dVQoDVTcgm4qTQirhjILZu5CnlahF9yBNY98fyGZ/e0M//09KogRAjw5uZJddRCj6Q5s
 FXcw==
X-Gm-Message-State: AOJu0YzefZs0lkGgCfwpjn0VWwmeZ6NgsX4D7hqdB59LB5/EPAT+EACN
 J8YL6ksoy90ekWU7vxMzUTvhwftaYCg1iptSV/V7f6YG/JcZdeT87t1n8pvBmyDL/rcEieQ5Lcj
 EKPUhtv4rNUVNOh24yRWvDRFdkUzGBJ+H
X-Google-Smtp-Source: AGHT+IHlLoS2jKAEerWUssRoTGWwWjE0N6gN1s3A5xC1HWetFn6DHyUfvTCQf1j0Gso1IOV9YaBa26w1iPqg0xsewOs=
X-Received: by 2002:a2e:22c1:0:b0:2ef:24a9:6aa4 with SMTP id
 38308e7fff4ca-2ef24a96b7bmr36410221fa.0.1721785120775; Tue, 23 Jul 2024
 18:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240723150400.16650-1-Zhiqiang.Hou@nxp.com>
 <20240723150400.16650-4-Zhiqiang.Hou@nxp.com>
 <CAOMZO5BUguY8vbw9gUux=jfZ312q5pAr3FA0YKq_wAQiCvfEfw@mail.gmail.com>
 <DB9PR04MB9236608870B7A84AAB4E486084AA2@DB9PR04MB9236.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9236608870B7A84AAB4E486084AA2@DB9PR04MB9236.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 23 Jul 2024 22:38:29 -0300
Message-ID: <CAOMZO5CNfAQzqaVPy0WDiNZ2VLzQiAKUd-d+Jii8ZrewUyiA_A@mail.gmail.com>
Subject: Re: [PATCHv1 3/5] cmd: cpu: add release subcommand
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, "sjg@chromium.org" <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Zhiqiang,

On Tue, Jul 23, 2024 at 10:02=E2=80=AFPM Z.Q. Hou <zhiqiang.hou@nxp.com> wr=
ote:

> The i.MX8M Plus name isn't added to the imx8_cpu.c, will add the i.MX8M s=
eries names.

Ok, thanks. Please also fix the CPU frequency.
