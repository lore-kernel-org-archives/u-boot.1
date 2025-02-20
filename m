Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96275C021AA
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 02:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D0B80A46;
	Thu, 20 Feb 2025 03:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WRtYluQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8897880C98; Thu, 20 Feb 2025 03:19:18 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 831A3801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 03:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30795988ebeso3936401fa.3
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 18:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740017956; x=1740622756; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SQzT/KUfEz8PbfZ02fTOsBUGCKNdCXGRR20Gs6cr14=;
 b=WRtYluQkJrwu3aE+C29ybbBcuc9CWf5VbyF7dCYujfW2CBehZpdutLDfMOmyPysWqO
 SzFDPmXBvVBS1BZHFRNQ1qtg8z1q3N5Ani0gd5tj7kXvTw00lkZoXJ2qRXTwG/rwHi6F
 3QL+e7osjza4K36qtDn9bNbIGaXvR2lCDTSbA1N686iC9eTA/KP33Z/DtqoeirTyVLbz
 n/rlIFLRv88aO2NulYAS5JvJ/IiUE2w7qCaXKcfO/pMIVPvneQ3BBNmxL1ZPSdK384lW
 neM+du3rvothcXn1piCTmCp55PddfUK7Em7byOoCKVwVSkAXeu71veOYEpVaXBtiHoyN
 1evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740017956; x=1740622756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SQzT/KUfEz8PbfZ02fTOsBUGCKNdCXGRR20Gs6cr14=;
 b=rpWfIcHqJnStdBaQCikLozhuzBZ290va/2IumXqM1ZWjA/sPX4Slo0WmEpvE2gfeky
 lAa6mFvt0FVRjukzlyzrQlLDC/0Qc1DBidWps1BDmlJ/DZ5lrYYO37PzbfMG409N9T15
 wh/Ofb41p3PwLYISh7sUArKGj4dvGLakrOpx5QuST8jZJGUdpwfJ6VJ9R1fgk4hHayUb
 9l4wemNvhVMIDwVJAcAt34bZHbggs7pZrmu5EbusvBZpekFuf+LGeWS+vocBLlnhjMeD
 PZ0utiuFx6LosTXcFg9/fd09Zp4ZF5JEHiFupJsdi1e6aT5xv/TKSteI/Xrt0R6tqPlp
 160g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVGS8rp2n2rbp8/oYpHyMVVlrSS7aqfBqmWiY+ZVwPUTQXbnWWcmR+x4QseyHMyh8D2Z4VFRk=@lists.denx.de
X-Gm-Message-State: AOJu0YxLTmrtrIo5MpApi7w2PoDLuKn9zBs37uIE35q4Avxcn+Az8lu1
 swMt1EgXeHoLZdU+nzhlyyfET0xRSE3bTJzRv1Lyi1N/82pBjVYf2ZAaCegPFkwJPL8ENY5Ux9G
 +d6UAWJGkz3PHcZdKUavoNVsmnZw=
X-Gm-Gg: ASbGncv4c+HGCMdeccaYwAZbr3zt8+L6Ae3yJqx3iDdMj8ATPJdVLKID+PaGl8xj4Vq
 J63crujH01neGMeqCI0fWH98jeNJ4pJ6QSsSnCELILg2ovQ2qrx6YVsYNOQp8GgY7VNtJ9/XEQc
 77wVcjOHOZ2BlPEuSS/+vXxrsim2BY
X-Google-Smtp-Source: AGHT+IHrs2GprERHw1mH4obl2C0IIWkt9Lz/LF++Hs/k2uPPS9+TZ+m7DqPWAeWGI06SkEStKs5xNTOhPxO8+zU81GY=
X-Received: by 2002:a05:6512:4005:b0:545:1240:24f5 with SMTP id
 2adb3069b0e04-5452fe56d68mr7385258e87.28.1740017955607; Wed, 19 Feb 2025
 18:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20250213162123.69159-1-ludwig.nussel@siemens.com>
 <CAOMZO5As9nU4Bf1Ba_pUqgv2EdUd7niMte1bua9MBhk2zVr=Dw@mail.gmail.com>
 <PAXPR04MB8459BB961D40CC57FFBCA82288C42@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459BB961D40CC57FFBCA82288C42@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Feb 2025 23:19:04 -0300
X-Gm-Features: AWEUYZlhtw-IaLccQ2tjLenSte4GIhng6YWGVNxsguE2LBesHcsJks2-CywqKxY
Message-ID: <CAOMZO5A9Yu910Z_SYP=p7Zt+ymM4pBD2H4VhLhZEp-qHrGHL7w@mail.gmail.com>
Subject: Re: [PATCH] imx: fix imx8mm_evk config
To: Peng Fan <peng.fan@nxp.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Peng,

On Wed, Feb 19, 2025 at 10:52=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> Not test all the targets, 93 and 8mp were tested.
>
> Stupid issues, copy paste from one board to the other, but forgot me
> update the name. shame on me.
>
> Sorry for this.
>
> Would you expect a v2 from Ludwig or need me to address those in
> a separate patch?

Please address those issues in a separate patch, test it, and add a
Reported-by tag from Ludwig.

Thanks
