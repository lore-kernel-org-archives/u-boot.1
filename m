Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A954BC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 12:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF9587669;
	Sat, 16 Dec 2023 13:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PvX1z+wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBDF6876AB; Sat, 16 Dec 2023 13:33:10 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52A387620
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 13:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c67fdbe7d4so391394a12.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702729987; x=1703334787; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dykua6EDH4ylIqzSyv2Ad0oV27T/NIRx4uUV6Vn5TkQ=;
 b=PvX1z+wkVD+hLa6wa5Y0oPhiNTQGKvT67H+UNhfhSEUHkf9LOlMPq0BuQC6B7gsXCS
 rb2XFsz0cKXyftg1YX75Fw49y3LEqB8KXbG283/iBsebgIyCVK5YDAFvU14XlBPyafjr
 jHg+WhzPaZA1ufD3rtsi4EH2Dwa77WAuqHiRnPaP7sQtM9OFUuuupi6Hx1vIj5R7s9bZ
 ClaiX11JVX3bwGrSE/SjenUZ5uLAx6/++RPMRfe2Y3sqKO10QkuZjMW+Z1e6Rz7cxc9R
 bJzB+soOYwMsqD4c33irY8Qga38Wlnfq1B9+jtjvxcjGCwxZ0vHRtAm0gCRyVoeOAEZD
 rEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702729987; x=1703334787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dykua6EDH4ylIqzSyv2Ad0oV27T/NIRx4uUV6Vn5TkQ=;
 b=WFeCTvU8sgDa1E7wasamwRXH1ZXfZi/+KX6TrLginImVovTzSHJ2+2ksqKipuNZRwJ
 sn6HNLTs7kjoH5Y5AEV2B+3uG+rg+oqFer88yODCZwmCSI5nvV/Xw2doE5Nb/l/4i/1J
 tCfGWYjshe4sY1N5n8w/W0yRw4XfmkTDXElJDkcGsImwf7oL1YLvY/FhAkY9lk7bLcUG
 6lsJ1q5PlhYY81NXRadklOuabvvsUms9Umnlh2mS5e4/wTsWo2sISSJLEW+b3t7LL24Q
 AX8qlMACPeBJQ5MDHVKK1r/h5GBugiZwPC5zuKs/W5M4/OS+1FMNsyPQ7MFuPmlNumEP
 vi6Q==
X-Gm-Message-State: AOJu0YxTA8H8q7xRNh1CeYsP7IJjB4jhnuqVqx0xdKvoIiXXnj8Ul6xb
 MR0KhFY7hoIdCQaad5zzud5SnVQ5hMhIOaMG/Ks=
X-Google-Smtp-Source: AGHT+IFhx3OofzKBf8/Yv86idb+Et9BQiV9iIo81x28rRjqJE1LQUT0WUFK1m9YZww0w97xTdF8q4e9tq91+i+p53y8=
X-Received: by 2002:a17:90a:9905:b0:286:7cc2:4c15 with SMTP id
 b5-20020a17090a990500b002867cc24c15mr22359360pjp.0.1702729987000; Sat, 16 Dec
 2023 04:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20231216054243.327104-1-marex@denx.de>
In-Reply-To: <20231216054243.327104-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Dec 2023 09:32:54 -0300
Message-ID: <CAOMZO5DRFMtp6Tj3_kWLKoLf1ek12vieje_sFQMtgQZzuLQ_Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: Force DRAM regulators into FPWM mode on DH
 i.MX8MP DHCOM SoM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Sat, Dec 16, 2023 at 2:43=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> In case the Buck5 and Buck6 regulators which supply DRAM Vdd1 and Vdd2/Vd=
dq
> respectively operate in automatic PWM/PFM mode, the DRAM EDAC detects mor=
e
> correctable errors than if the regulators operate in forced PWM only mode=
.
> Force DRAM regulators to forced PWM mode only to stop tempting the DRAM.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied both to u-boot-imx master, thanks.
