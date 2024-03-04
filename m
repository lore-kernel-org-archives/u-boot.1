Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D410C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200DE87947;
	Mon,  4 Mar 2024 18:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hP+H750I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F8A86F67; Mon,  4 Mar 2024 18:54:49 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21C686F6E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e5769aa0b3so1033113b3a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574886; x=1710179686; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TAkC7vJufdUZge3Kg+QARPS6kwGrnGHYjRY1cnviTk=;
 b=hP+H750I9A9GYkyZvXRPC8gbx4SGQ1uyuXGyC2F1TTcQfmecXbtcJ1wXKujRAh+bai
 NLFeuKrAl3Fc8lVU2PwjoNQBwXL1Sh3Paj1psQ1Lfz/ZtH93LxeIerHtg/pCnw+0LJbP
 WBPHbtEubM/wlekV6YfY0uJ8141a32KLELW5IpcHAHF9UiAadDV0+QwDWVnG5VKeNCWP
 RRvvDbPmSxCM3HjCpdAWFU7J4McW3/VU1qjozzYHyfAGOUtcyZkRe72Su2367cTOiDEr
 IBR/M+gdrWxjaqjljX/SvDfvqXhRRWn+gn6toFnaH7XM94OZ23e4wWgP/y/1pkUO1oeO
 dZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574886; x=1710179686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TAkC7vJufdUZge3Kg+QARPS6kwGrnGHYjRY1cnviTk=;
 b=SOMjS35xXHoVx/35cgcB1CJrpRZv4punARfLwc0hBupX9c76uUyK1Vo+VYDjmvissb
 AOZXM6HwkVgAv3+ZrPqyoPNJ5AWs31bNJBWZWZ5eqz1MqlWkYfjVgPM32KBSc/2/15rO
 hqVjv+yiW3kwzDspnOZHTqsRqGVynNsUkeEDrKHoZGLCZj/D6BQjct+Ta4cX9am2sGjn
 0UYJj4+qyS4uVDn5zNIvGU+hfk2CuS01wC1X1/RoMo9l1Kqr0rGKiGRX812aBxtp3ZhN
 Fha+olJtRWszMMsAT+55Sj9uVJcxKck4humU6ceGE+AFsvuxe1EenBRZ4wDK8cRfp4Q/
 ftbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzuo6OPnPtbCeYQHokUgHXXAfBDGmba41btGq4oFG/e20UQL/Dt8FuuPgjgAg1n5UouQhHVyWxWe6znB9LjaS6BwwKvQ==
X-Gm-Message-State: AOJu0Ywv1pNMuh+RXX2pjV+3tSIwERgyncPBsH6UJYDAbkufFNZA9T/+
 oPQLkTNrNllCUR0iJDo/VjM2C5rs4a0fQfw3aVIuSpX+QxbLZUid1ZU0SrbHfhy6b91xInImEEE
 QDlUIiZXLLE3/XqagwkXV+5vWDxQ=
X-Google-Smtp-Source: AGHT+IEJNgNjtUw06M8kMju5ESubz8UpIkbMiwBUE5EMA4CdZQ40W6XLgphsI6BC9TaLLatxUzYvF1GmtIbJXBoMYGM=
X-Received: by 2002:a05:6a20:1b30:b0:1a1:480e:7710 with SMTP id
 ch48-20020a056a201b3000b001a1480e7710mr5385615pzb.0.1709574886152; Mon, 04
 Mar 2024 09:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20240226174834.29661-1-othacehe@gnu.org>
In-Reply-To: <20240226174834.29661-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 14:54:34 -0300
Message-ID: <CAOMZO5AwThMsBi0UBHnjyRRznvXWs_LxSbCQReZJ7vHuRY0h9Q@mail.gmail.com>
Subject: Re: [PATCH] imx9: Update to mx93 A1 chip revision.
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

On Mon, Feb 26, 2024 at 2:48=E2=80=AFPM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> Use the latest, mx93a1-ahab-container.img that is compatible with the
> i.MX93 A1 revision.
>
> Using mx93a1-ahab-container.img on an A0 chip and conversely causes a boo=
t
> failure without any traces on the UART.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Applied, thanks.
