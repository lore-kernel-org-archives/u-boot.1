Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57DBC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 17:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAFD88813A;
	Tue,  2 Apr 2024 19:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjI8/iE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9204D88164; Tue,  2 Apr 2024 19:19:51 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5168813A
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 19:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a4e40fad4fdso434284766b.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712078389; x=1712683189; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9pDjuapCcs9z2VT3I+M3hPP86dLv3uInzJhcK4K8oM=;
 b=XjI8/iE6iCFSg5GylE1H3VSRw+0jcWfpXnBcGe0sOv5AQak1F5TMNnIg5Zs+WiiaQ2
 iekkKqo5vS2ixAVLo957f6vYJofp+Noj7H4WLvsy6/PmTfNZx3My8MVxUjgtoAl9A+Gt
 5DalJBx8lqqrXJ/x/jEPoFrIU9lSM5WxmrRvqIsfeQkPVK2jITiw12yM8ZMzVRVwubzE
 GmggjCODkTH7yMJRw2s+QSLAHHM2vmsST3aj/N5h27YWEeDTK//aUVnqlBpD7gTMWzRr
 Raa3BurNQd1LtSH6r7ZFZdK9JfXSRNlVX/+rbiEDdyUbq7xVqLY8UGy+qvgW16CpQ95w
 Dm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712078389; x=1712683189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S9pDjuapCcs9z2VT3I+M3hPP86dLv3uInzJhcK4K8oM=;
 b=RVJAkXkE8nnowVxuq3SYqKdNc6oIYc6nkTLzJAreEU476bx+lo5/tD5v1KdGB8lj7A
 GkZAA2bucOYxKojPwwyRQWPKgJVcDbgF+Q0BSjABCj4/qizUHqldrLVbS2foduOY+A11
 HP08/0HVpIg2ysxn8RdbCRE6YmAaGwlmLeeuNx9ErpspLOWqJgJYxL2e50NTV/non83B
 DGiyaySIbBDVPNzjBQvRGBheo81af/SqtVrfBjrBPpB+wvq5Gsq/t/lFvMXRcSJaFX8H
 zn2piWCOKdy3ulJbvAcz8Mg8AND9xiGAVdf9/hqpk6ZgoGrxgL0v5IGjGBL3juohIW2t
 xksA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5B99nxiNqm9FNTrMtEyTqb8i41YYBUyGrGP79jbxhuTXuNMtQaRgsJOMfLTp9axVPJ24IHppxYoobwwqv5LoV9/MWAg==
X-Gm-Message-State: AOJu0YxfHX08AJdWMzhSD4YGhkMwFXD6+nR39cXS31FXMm+HHkGfTNyT
 Bk0ZJYj8fbf4Vo0G1/WzIL9CsZSZf/nCqbbkjZQiGicuGYm91PUGucbqUHaK2Q7bUKojuqPE/cv
 ZrIWRolsV0mK3UoVtPRZxZUVSL2k=
X-Google-Smtp-Source: AGHT+IFlUaHp0FSnS1tHZhCf7qpUQREktPV9C51wqSI9SE1cBqsF1FPmdAdRd6aPZc7uaCaUID9jsli+ODKl/WMNtsI=
X-Received: by 2002:a17:907:1b21:b0:a4e:3715:7f4a with SMTP id
 mp33-20020a1709071b2100b00a4e37157f4amr10555079ejc.71.1712078388880; Tue, 02
 Apr 2024 10:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240330175948.80931-1-bigunclemax@gmail.com>
 <20240330175948.80931-2-bigunclemax@gmail.com>
 <4c80330c-e12a-4652-89c2-857d572d6a7b@canonical.com>
In-Reply-To: <4c80330c-e12a-4652-89c2-857d572d6a7b@canonical.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Tue, 2 Apr 2024 20:19:37 +0300
Message-ID: <CALHCpMgEr6kB+TcnqOAex=gpNqZex4sUyeEXjEVh2_0E4cdL5w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] mmc: snps_sdhci: Add sdhci driver support for
 TH1520 SoC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

i, Heinrich!

=D0=B2=D1=82, 2 =D0=B0=D0=BF=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 17:47, Hein=
rich Schuchardt
<heinrich.schuchardt@canonical.com>:
>
> On 30.03.24 18:59, Maksim Kiselev wrote:
> > Add support for DesignWare SDHCI host controller on Alibaba TH1520 SoC
> >
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
>
> Thank you for driving the TH1520 support forward.
>
> Locally I updated the Lichee Pi4A device-tree based on the Linux
> device-tree and built th1520_lpi4a_defconfig with
>
> CONFIG_CMD_MMC=3Dy
> CONFIG_MMC=3Dy
> CONFIG_MMC_SDHCI=3Dy
> CONFIG_MMC_SDHCI_SNPS=3Dy

You can also enable following options:
CONFIG_MMC_IO_VOLTAGE=3Dy
CONFIG_MMC_UHS_SUPPORT=3Dy
CONFIG_MMC_HS400_ES_SUPPORT=3Dy
CONFIG_MMC_HS400_SUPPORT=3Dy

For HS400_ES mode also needs to add `mmc-hs400-enhanced-strobe`
line to the emmc node in the Lichee's DT.

HS200/HS400/HS400_ES modes work fine with eMMC on my Lichee Pi4A board.
MicroSD works fine at UHS SDR104 too.

Bus Speed for both devices is 198MHz

> I tested reading from eMMC and SD-card as well as writing to SD-card and
> found no problems.
>
> Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks for testing!
