Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18248C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 14:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531C68753F;
	Mon, 27 Nov 2023 15:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lznSdKGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B426F87530; Mon, 27 Nov 2023 15:05:51 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA27875A1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54a945861c6so5935439a12.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701093949; x=1701698749; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdSh9Wye6IQdDu6lmxyJbrkMd16UXAqXNuVuhSgLM3I=;
 b=lznSdKGmQLrStx7COFXs0lwcgXZeIv7MITYtm7ed+rjyP8MJvXjGEAt1OhpSOJN/ab
 RcrvdnSoGw1lR9KsbyBYGZZr01kOE9NT7+jI7iAuaqc14dcI0rMk0xlddLvFQaBysIs1
 F3RfSYnQtCemL12T/QxA1OvoIqKSiCOK8P9xAWMRoyr8lsZilOs31VNl4GZTdsEfUS0g
 oBJch2epxePT7KSSSzhMC9WFKbYL0DaNem/ivfx5WCfRpUuXB5b/PGwZhc/xtUBm9nus
 01qMzio3sH4pfvFNW0b7RwF/sdeEQd78wve75JtaWCNZoby5ga3rohasE+GfIA7D+AaY
 2P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701093949; x=1701698749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JdSh9Wye6IQdDu6lmxyJbrkMd16UXAqXNuVuhSgLM3I=;
 b=mcxB3V6kMxNVBHwIiALGUAGcg0YdsX5dPOKMhhLHVh3Yvi1ROw4JQ3w9WrrlVvdf/M
 XTjJCmZ1/TiDHe6eDXBcZzJdegIdfiPRzh5O/jB7OqZ+fjQAmD+DEXy3Q65x6zE/9t5o
 meVN2+kEXV2g8QcPmLwkomBl75KdSoS21+wZ//unMcTy5Ix7jTvg2diOBpvPN4dN02yn
 g1rTLcj8kZVxzeeo9H7Rz9oYC0Em4WuvpUp6VoVbJCByQot32vIUonkkQ6LUkLoehrJT
 yAoHMsCAn+2SMU7/pB/caaxLs3+712swV1Aeq3ESMBd7huivV0UQxsj0bw+hpe16nhsD
 s3mA==
X-Gm-Message-State: AOJu0Yxc6uX/Nuvc4BAMtYjN8Vi6bIJLW2b1SOfIbji/XqANnFDgPETs
 m5wtjIRmmD6MoARx4HXLUlnqsUPWfgNvxtdWJjU=
X-Google-Smtp-Source: AGHT+IGmu8/kG6Vv+2vuTvgGKvYmKkJrcqvjE23ZUygTmisqdW8HGOs3QSV5Ok8Y7tCV9h38xM2s7dAnQ4WEphuR3ZY=
X-Received: by 2002:a05:6402:b91:b0:54a:ff96:2cba with SMTP id
 cf17-20020a0564020b9100b0054aff962cbamr7295254edb.33.1701093948829; Mon, 27
 Nov 2023 06:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20231117154757.777827-1-trini@konsulko.com>
 <20231125223809.GW2513409@bill-the-cat>
 <PAXPR10MB50858692C89D451A7A18F7E4D2BDA@PAXPR10MB5085.EURPRD10.PROD.OUTLOOK.COM>
 <CAEGM6axzOkySNu7uSmsWthiTQhTb_vMOY_Mjj_iFKKgg_Y=Vqg@mail.gmail.com>
In-Reply-To: <CAEGM6axzOkySNu7uSmsWthiTQhTb_vMOY_Mjj_iFKKgg_Y=Vqg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 27 Nov 2023 14:05:35 +0000
Message-ID: <CALeDE9NO4UB2fBwAK+dD2J3_nN=+rSeKuitD7dMOcrt3J1U+cA@mail.gmail.com>
Subject: Re: [PATCH] boards: Disable NET on platforms without NETDEVICES
To: Tom Rini <trini@konsulko.com>
Cc: "Winker Matthias (HC-CW/ENG-PJM)" <Matthias.Winker@de.bosch.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Philip Oberfichtner <pro@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>
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

On Mon, Nov 27, 2023 at 1:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Nov 27, 2023 at 5:45=E2=80=AFAM Winker Matthias (HC-CW/ENG-PJM)
> <Matthias.Winker@de.bosch.com> wrote:
> >
> > Hello Tom,
> >
> > Just to be sure. In the past we had NET enabled such that the fused MAC=
 is taken over, although we don=E2=80=99t use NET CMD.
> > With your changes, does I.mx6 evaluate the MAC fuses and forward it to =
Linux?
> >
> > Our board: Bosch ACC.
>
> I honestly don't know as I don't see how it's doing that today in
> current master (which does not have this change) so you might
> need to start by confirming behavior in the current tree and working
> from there, thanks.

It's usually reading from eFUSES and populates details via DT using
alias bits, whether or not that uses/depends on code in net I'm not
sure.
