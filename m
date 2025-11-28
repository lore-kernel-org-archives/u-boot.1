Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7D6D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B5DC844E4;
	Fri, 28 Nov 2025 12:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DOeS9eQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFCF844DE; Fri, 28 Nov 2025 12:00:36 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E582844F0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5969c5af23bso1831612e87.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764327628; x=1764932428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upoGjKsSMORbMutd/MYt644j4Md8WPW4E9WmzSOx8dg=;
 b=DOeS9eQbmLo+xTevLEciZ2LNO2DXrk9Tw4VuMBZHtgMtOy61f79s5y0AEnJ73ydWGM
 BMMjDhU8uVYH0BS3NVQKLQjC+J+0D3f29z1lMdeQOmYn30cmm01No3Kn2BkmTQvh1EFX
 ZbG8vChTVD1lJ2d2VBxI7olPJGAW7rjLQ4i1PtfOZStMT/pRwXFbH6wF/wV/FN5dx80r
 w66TaKXmgxkrgnMOoFfAbr0jVdyifd4g4E3Rf46kbaWr3W8he5srd12rUav35E+IXjr0
 P5AOuaZajOwAvjHzb41GxBIwdRwx9uA9RN1EWLpQ02oEd9PfKTbwnpOIOV2EZHU7pWQD
 PdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764327628; x=1764932428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=upoGjKsSMORbMutd/MYt644j4Md8WPW4E9WmzSOx8dg=;
 b=gVQsmoL85j9s2EP3TyQEANmyfRV4sLedC0/uY/nMhtMwrnKe9hPCyUJa0dTxmcC9OY
 joke1gdhIHPHEAjgai1XVvkUtYPufLM5XaZTTjFpi+JcKzjMcPr/KxgdEVLGPg6afrOM
 z/3jAAy6X/M5k5cSWijDjirzILP05rvToMZ4WZTgqXI6DvWVxqtDHoq3tEaJJ1n3veRw
 CPPnNK6nK5MVj0M/Od9hZGW3keNUSyzm1jwiFJItfT7EmPRjcW953I5eOf8V9/I6ds8W
 ChiIuiFU40jDz97V3sW8LNNgaXG2bSUXuQiromRnC0O5NpcoIGrpVShSFXiAz8XEBnkY
 3Ptg==
X-Gm-Message-State: AOJu0YzGzcD2vEDAL/PFFggPqK9ltd3Di4F1NwaxX3GN5JJja1U/2rti
 RJB5hMrRPq4pN9A+IEGbb0JRD869KZr5E0S+ZZX9R1p/GNSV/sYOrRUh6fsR2Ea6YlD5uBgtRm+
 71aGXtXF1SAhitvMaO6/W2GHZ07P1RFk=
X-Gm-Gg: ASbGncsWqp/hlmfloM921JC1RcQQEpc0ERn5zZ5xX6KxfBNzg+4chFw4SkaI+uc3VCv
 zTVwFJh6R/nz+8MTOytzrJ0ZI/DT2JFJe/EIiET9LbwrEttHugB4YVkUF8KjR2cWEl/O5u13+SB
 C9HZ5K75onRREnNh8pigvt6Q5DnfGwKaVg/eTwKt6951XZIc45Imvt+9Rbx45aSdGOQOdSWNzjw
 GvnVECMFeaj6QtQftLLdAuJI49LNf34QHTDbgJoVEpJYKhy1qRSt+Xbu56Q27v+KMKGvU98L8kk
 SHJJZvit8Q9N2aLfG/UTKmgP0g==
X-Google-Smtp-Source: AGHT+IHNkJtv7PUrzzDnSHtRa9RQqLPda+moiZPSvLuQvx3rVHW2naj46ZZLDyifwX7I+Ov2lDlT2+ytHkRcMpGuxAc=
X-Received: by 2002:a05:6512:4005:b0:595:7f2e:de0b with SMTP id
 2adb3069b0e04-596a3eab6e0mr8767951e87.12.1764327627760; Fri, 28 Nov 2025
 03:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20251113082145.898431-1-alice.guo@oss.nxp.com>
 <DU0PR04MB96367EBECA5951D3B9B7925BE2DCA@DU0PR04MB9636.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB96367EBECA5951D3B9B7925BE2DCA@DU0PR04MB9636.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Nov 2025 08:00:16 -0300
X-Gm-Features: AWmQ_bkcPHdobwqb1a5GPNu8L13txNWlZyuZjakpm6WMAWpF_Po5bX62XTzwdSg
Message-ID: <CAOMZO5BH+=tDCCE4sJtHwQyyu5_+tOJTQi+=+o1A1QT7ML3pkw@mail.gmail.com>
Subject: Re: [PATCH v1] imx95_evk: Initialize the ELE RNG context
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, 
 "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
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

Hi Alice,

On Fri, Nov 28, 2025 at 6:08=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:

> Gentle ping: Any comments on this patch?

It looks good to me.

I plan to queue it for u-boot-imx/next soon.
