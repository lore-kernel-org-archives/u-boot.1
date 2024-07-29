Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8ABC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 21:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D003B887DB;
	Mon, 29 Jul 2024 23:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dRc94MiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351C188276; Mon, 29 Jul 2024 23:12:53 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AB788815
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 23:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52f008b40d7so697777e87.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722287570; x=1722892370; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8vEsXcEF2UdkkDCYKdxO1PypxpU6t3KqsjUcAOAhmE=;
 b=dRc94MiFjU+PcHuirdkAoXlZJ3v1eI4MYOLCz13BPOkQWjFxrKHg02knJRa/t3pZRL
 shJYNxxdppK5vPaps6Hz/Ywk7qU3FV8pcL9iqhV5g440XDkKh3hLhQ9YqrTiO6M23xtv
 qMCa7MROxZ5Px8ot791QGXqhZo8wsZb/uYW8KoIRKJqYfmz/7BaiGyS4zd0j14+k4gI6
 wuQY4j6/tnYHU1kFEEPUftyuEzjlEuOOC69hw7VEHqFB8yB2f/9nBr8kcBfybeFizITM
 BKBi1iGZ3KtCj2fMvRLeeKNH043DwrqsjLAInM6DFMT2aqLVFHSv+ryZ27TAcXKgzeCh
 PgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722287570; x=1722892370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8vEsXcEF2UdkkDCYKdxO1PypxpU6t3KqsjUcAOAhmE=;
 b=O1i2Yav1pYUscLPdEUqYzYHiJIJRAmfKeBBMOG4QjNepx+6FjmL9y9ufv5jukB+7U5
 qUi0vTZohkNQJVB6YdtiY4uCNl0JdjC2M1D5TVhUsozoUVElrVp1o4PI5PYfLG5C60xV
 cHxYrVta62Mfcs2pc0NGAIe+IXTdLjg23dfyUfFoDSy96x4vLrpogKbL6nyDdO8/s1tu
 Yol8JC8SzSLObXcZvPTFAPMTzRuLxPJ/qa2N+kEizX+p5WtpyYyqqejOGixZlLrsPYiY
 mX47wpGqYMJJrjTNBmRtjG1R4ojmmIG3HouWL/P1wiGtdW2F28aAXUWGc86Z3Yi3iX69
 U0Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWafJFZ05evexBH6/WZOBneaGlIxeqzVQOa+SSbvGB5R97CIkhYvBBRRmRWQquCEYYd/6jUdvE=@lists.denx.de
X-Gm-Message-State: AOJu0YwKLjqDwRV3pEkzkMrKGXh3N2guTmbUdVawkRmMBiKlhmAmky0K
 h2o/NAKe9htmeS4cVcab+L6fvTg5AZ8SVhsbJKBMBc7Zp3asf7MBVLJ0URSpxQC+uWSVQ5AFc9L
 9qzfUOc/Mjye3G+pbonwObrEj9m8=
X-Google-Smtp-Source: AGHT+IE5NGueracfSk4U94fKGpCW8Bp7iIpiMefNPY88VqBoSd8TA6SvSUy6VjD2CCDN62qTZD7YvxftnUfXqg88ZtU=
X-Received: by 2002:a05:6512:b92:b0:52f:287:a083 with SMTP id
 2adb3069b0e04-52fd522a800mr5576075e87.0.1722287570029; Mon, 29 Jul 2024
 14:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
 <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
 <CAOMZO5C+b0-9FSdugkeje70RozqnedPNQoHfPPcuvwuJ8MfRvw@mail.gmail.com>
 <DB9PR04MB9236C42A2E595ED1D10B575A84B72@DB9PR04MB9236.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9236C42A2E595ED1D10B575A84B72@DB9PR04MB9236.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Jul 2024 18:12:37 -0300
Message-ID: <CAOMZO5AYyjLh_HE-wGori3GCuj83MdJ92B34L9EdwwBRDNFyRQ@mail.gmail.com>
Subject: Re: [PATCHv2] clk: imx8m: register ARM A53 core clock
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Cc: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>, 
 "seanga2@gmail.com" <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>
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

On Mon, Jul 29, 2024 at 12:15=E2=80=AFAM Z.Q. Hou <zhiqiang.hou@nxp.com> wr=
ote:

> It's needed by the cmd/cpu.c to print the CPU frequency. will add in next=
 version. Thanks!

Please make this patch part of the cmd/cpu.c series and explain the
rationale in the commit log.

Thanks
