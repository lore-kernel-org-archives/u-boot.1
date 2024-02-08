Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C69C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE47687E4B;
	Thu,  8 Feb 2024 15:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cOwt6quQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691A487E61; Thu,  8 Feb 2024 15:31:37 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D9C87E45
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-295f9e5f8a4so385276a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707402693; x=1708007493; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r45vX9IYDgLDvxc6S4suhDXe6ek+IvSlIEVlfUz6Tng=;
 b=cOwt6quQxSHqo9fiMPqEAnhrjDftNzXWOvjV/p2th2z81HzxI/fVFyhvKzun7DpIvm
 iFvqkAzojS3bxN2BTZfch/d37VgMUYUr6S7jbA8kRB/2pY3k13A7m3I1LsehVrWLap2R
 GlJZXwnO0GNrHVbGlVEeJ/drvVDg8WzBs3B9JXANF6XxE2+6U0bSh3obRXbuUUI3m5bc
 y1KkBlYtM3hhGHfAXlx5rPT/2kZVXdboHFAMTITLbdwU7hMw/5VOwwFHNQ61Niebmd4b
 23fo/RhgFDZ5AkMUEB9SqwhzkPpU7DFyAf4sw8eorN4uBJLD4hqOzncGQOzU41hUw5Wp
 K+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707402693; x=1708007493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r45vX9IYDgLDvxc6S4suhDXe6ek+IvSlIEVlfUz6Tng=;
 b=VavfpQFdYs4fEpnkAm29NPtTbKWDvrIwTKfJHSWC9PVemH3yWhq/n4B17WCPz1Ah28
 h2OB4alRXl7H4I3guiUjWRhiyvdxvINJQlb+0xg5S6y2xTqltq2jsTelECqAgcDUr0Sj
 TiVeuyd1ZqCT0+/MSovszQB6Jovc8DnbWK4VXkY7X9HfyN+jHRt8V/oclxWE3lb9wDQ/
 1B+evixJq/KAPwjuArmPmenqlyultmGkX+4vWVV2uiPHdvFVDYNJuVZmvaQ9zG0B/0iS
 dz3ZfuXALSrq7jGx8WwPgsFJbCe3ayl6YT4+Nek2lVYId6GfsHE95GEHXanNh//deIzG
 fttQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn+/4+KCbtBtnbddb8kiRJaZjh18hFNXkrzO+x76ppBPrzgdeoPZtueQNKRXV1f+fnOzOnQeB/d6wGchk/5Bs2tAyUVQ==
X-Gm-Message-State: AOJu0Yz/S4sb2t6u7+1npfGQeKN28/IBvsNOAhaL6b4ILDxRUA13c6Bv
 Hw3aJmhhBDUN9fmfFYqVTRt30LpppOSO0cHU8+S1xKSnXIMY8+GLiMXKHA9X12Cf64TtV93D0KE
 DoonUIPtwbvQqZs4Nmnonq5+4ecIQdSOa
X-Google-Smtp-Source: AGHT+IHFUFCLckb2mtdtXwcM1vV0U13pY+3MStjmDgw8MM3AtbslCoKTKzUPDEW05DbJ1YdjbmSC+ZaEGYyND5Bg+1E=
X-Received: by 2002:a17:90b:38cb:b0:290:f5f7:caff with SMTP id
 nn11-20020a17090b38cb00b00290f5f7caffmr9297456pjb.3.1707402693663; Thu, 08
 Feb 2024 06:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20240130124337.497748-1-primoz.fiser@norik.com>
In-Reply-To: <20240130124337.497748-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 11:31:21 -0300
Message-ID: <CAOMZO5CJvaNCr6BzeUgGh=6qKbR-6AL6S6OKHZGWEYs_xZVhTw@mail.gmail.com>
Subject: Re: [PATCH] imx9: clock: Fix board_interface_eth_init for FEC
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Tue, Jan 30, 2024 at 9:43=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Commit d5eae216d833 ("net: dwc_eth_qos: Add board_interface_eth_init()
> for i.MX93") implemented board_interface_eth_init for i.MX9 platforms.
> However it only accounted for the EQOS interface while any board using
> FEC as primary Ethernet interface was left out as return value -EINVAL
> is always returned from the function in such case.
>
> Fix this by returning 0 (success) when FEC interface is primarily used
> instead of EQOS interface on i.MX93.
>
> Fixes: d5eae216d833 ("net: dwc_eth_qos: Add board_interface_eth_init() fo=
r i.MX93")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks.
