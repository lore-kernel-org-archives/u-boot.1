Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306EDC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9435877E2;
	Tue, 12 Dec 2023 17:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hbxb+fHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E0687812; Tue, 12 Dec 2023 17:11:41 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0A8877E2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ce4fe4ed18so547701b3a.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397496; x=1703002296; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7l5lyrf/YTGfI0PKesUnVU33U0TtMheKGv0LsfJCD4=;
 b=hbxb+fHNpCvYZGTvvBRPf42WPsdXBtuqLcRtjeZE33BBJXbEFmB5MzDyYrejbT+oj/
 5qybmtVHK0ucyrUidWwTUefymZIk6qRSEiG/gPlQmXYEyIkM34u/VcbuU6efhdprGCZF
 Phn+61vumGw+IINicvvdqjshcqFPAG3XzBJsuJghFGmcj6VZOV3577Lhy6OZwy8Mbc/h
 XPgharz7ar0q0UfOvBGVE2vrswYKjC51DFbvg/Fg9beMhfe5YrpoZzSwRfZVlFGrcy4I
 izxkDV7rHUo8NVtNkkxFfYRDajnagkAGqkUjlJLl+c43+Z2nFgxJiOQzRVPzFyCpSvTF
 p6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397496; x=1703002296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7l5lyrf/YTGfI0PKesUnVU33U0TtMheKGv0LsfJCD4=;
 b=oVcztJavNYXlQBAXZ9SInj5igq2EjnR+lljtwiF/ccNDR9ddT/DLc7NfVNF+H8hFX5
 Qc0CgsvRjXAIHoSC1FGg/585LNThB3BZheQaHC4gamI252RWtyXWDYqwMs10oaw0S2zX
 0fdX56iNaur2BvPJId6cZ3nVzDqKMMFLj8c9dxPGxrYrbNN02omCjeUdSNTh6gdEFiOM
 tQn4EQJaNC5Kvk5DYGEHUNptZT5od6mUFda6JO88EFFoQDlK8fSA560j4Lc1cypdWF51
 QQPNCSTqNJOy1Ty5WzyoGh27SX7GjcEyr9E78LbQeY31ibykVohDT5gl8WeMkvvnM0ad
 S/lw==
X-Gm-Message-State: AOJu0Yy9upgu28pdGbfgj4LL+wl/oPjZj8PL/RRWKoyNGbmiyx7D7GIr
 jOF6JnfvPrDm00eC3PjFncMEXg3ooxdwyk1J+VI=
X-Google-Smtp-Source: AGHT+IFAc2aRFW3DRzEVTa7ldxYLEQl0b43Ba1j52lgtihFVaV1IWbh+vGgfPhvQpIVMqPRu+7V+iBIbWSfRn0qqJng=
X-Received: by 2002:a05:6a00:2401:b0:6ce:4f4c:d475 with SMTP id
 z1-20020a056a00240100b006ce4f4cd475mr13762332pfh.3.1702397496581; Tue, 12 Dec
 2023 08:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20231018183306.2168046-1-tharvey@gateworks.com>
In-Reply-To: <20231018183306.2168046-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:11:23 -0300
Message-ID: <CAOMZO5BBKjutT+SQSfMdidPX_iBEtZ97msL8aFwEeRLNt7miZA@mail.gmail.com>
Subject: Re: [PATCH] board: gateworks: venice: add fixup for GW73xx-F+
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Wed, Oct 18, 2023 at 3:33=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> GW73xx-F board revision switched back to the original PCIe switch due to
> part availability.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
