Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7177C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9474287A00;
	Sat, 24 Feb 2024 23:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g0oeJVs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB8F87CFF; Sat, 24 Feb 2024 23:12:58 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC49C87A00
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dbd81000b6so6719575ad.0
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708812774; x=1709417574; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OY2UeFrbNixgH/9FNmuE2jyCA9+vl0LChGpSWEG4zp8=;
 b=g0oeJVs1/rOPpvjnk4vIWkx/Wvr1CLFBCdZkCXRP+TQaVi+IPA/1fkDf0RpUBgb9MS
 L4wqPLkrosmFKbojY1RVEx6UYuS0Mx4K76KvpHpqIrkdYFIufUAkxHRNW04dz2GAEKVd
 Hr6JqwMjdQJawn53winTaeZBGu733Tjo4LB21QYETjvcEIFDNcAP8I3ukKzZ65xyH9+6
 UWjVBGsOparg6h75LengEUjceJm2+pqTUYBSK6dZ6aR6UFXL1smP0O6lVzN+XFBJr8q8
 dCNSCkeNCzpgRyaIoyYVYiS1JQbY+ArNrGIzIkJYJkUCi1DtxqqaCU8iKJgW7gZfNCb5
 2dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708812774; x=1709417574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OY2UeFrbNixgH/9FNmuE2jyCA9+vl0LChGpSWEG4zp8=;
 b=rW9bE4ymA2udc3vXrpL+kpVX+ueMzVTLzixr+yt3XUh99GK/l+XFKmXPRakuW5hxxA
 uS9WdpSzkB6PEheLN7nnqDnvOxPgaZlGkCcaOI/Umrtph3nRM4zgOF989sxxYWhKNCZI
 Vm+cNEVmeq4W5XYukdHRF7VxYF6hGsmjeWe5Vx6H0tSEyW7Z5vj1Rp8ipC449stmUBqw
 r3/3cj3rfZjTxiBOWcttb8lDGdu4/yfyIlWxVWYEgm0maUFRMCwDEDDmcfzNZHzAhLIe
 ViF3zMhmnMhk5fsbpYiADWWorVgxRWeb2AFoJQIOOTRwAGx+cmerUegC5QD/lorjNu6z
 Zvow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5mXTGqMWZa2hwg0PEGVCJ75Az+61A2RoTx3Kp70+3kKu+EWa/59I43bdg0SoRXha6aBxL6v8orBM3nWRbxAx1//O2+g==
X-Gm-Message-State: AOJu0Ywou3m3XYwxYDREbYGWL6ARjFkgHKG+DvnYAlquBDBGvxPhKEpQ
 PC7VRyd77Z82YHDP8Uw+E8eyarfm5OrHITP1gyBYWnTZdXNO41zG5oP0evGO2sFG1UwilVS+sl0
 zttc3F1JwoSMy+MISkHZ2TD7Izoc=
X-Google-Smtp-Source: AGHT+IG39k7wrWfJ8A47E0gffzIucI+Re0ifMy+Xwt2PBFYgZS4k29JzI9JzrFImz2e29sE+Mmr7zr8ueAg3I7FnHJY=
X-Received: by 2002:a05:6a20:da89:b0:1a0:e659:4ca7 with SMTP id
 iy9-20020a056a20da8900b001a0e6594ca7mr4544155pzb.6.1708812774010; Sat, 24 Feb
 2024 14:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20240220103506.17218-1-othacehe@gnu.org>
In-Reply-To: <20240220103506.17218-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 19:12:42 -0300
Message-ID: <CAOMZO5CLDZbNm58nKBXoCaYUYLB8Q-1nvRU1T45gJM33M+q1oA@mail.gmail.com>
Subject: Re: [PATCH 0/5] imx93_var_som: Add USB support.
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, Feb 20, 2024 at 7:35=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> Hello,
>
> This series adds USB support for the imx93_var_som board.  It depends on:
> https://lists.denx.de/pipermail/u-boot/2024-February/546203.html
>
> It also adds support for fastboot and EFI partitions.
>
> Thanks,
>
> Mathieu
>
> Mathieu Othacehe (5):
>   arm: dts: imx93: Add USB support.
>   arm: dts: imx93-var-som-symphony: Add USB support.
>   configs: imx93_var_som: Add USB support.
>   configs: imx93_var_som: Add fastboot support.
>   configs: imx93_var_som: Add EFI support.

This last one did not apply against master.

I checked and the two options are already enabled, so I dropped the
patch 5/5 and applied the others, thanks.
