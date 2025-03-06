Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B7DC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 13:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F743808A2;
	Thu,  6 Mar 2025 14:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m3x1ceMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF7C811C1; Thu,  6 Mar 2025 14:00:28 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF920805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 14:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5493b5bc6e8so693425e87.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741266024; x=1741870824; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heVKvz0wItxmYn8QyI5K85yxfjGwJkIROfm8CE804tc=;
 b=m3x1ceMwRyxjjAnJiuZNcHu95NiDNv1MgSVpQmQVlwYOdoA98wVijH6lXuw0EhvAbL
 nJ7wvMcCC6n3ly+1W9QCuO6Ldu3VdgTpjETgLM/RPZCbafifwQ4rYuDWz97vbpnQCdbU
 1l84f8I5ZZx1y8Cjuea+m3yuPNQHhFgTbWYXuqczNrsyCJ277TSawdGXAykDGcO1hRZC
 WxuMR3RUfaXAX0hAVfoLgtRRQcqcFV1AsX/hWKJvu0jeSzs8zmNCL/HlgFWDSr/Y44jL
 GwkPjSnirx2Gd5SDCki4KGNhUosn+tyEhPvHkQQAQFFlYoJjmCtVGklLrd7xW9ddHbdi
 +BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741266024; x=1741870824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heVKvz0wItxmYn8QyI5K85yxfjGwJkIROfm8CE804tc=;
 b=vk0++UKtRJMUOpdqs7hbCtSY/JKgpjjIkbRYS7NNkIg9sQttyWeKbWc1u44svSTIPt
 4q55UEc1y463jMyS63asKray3aALTrRMFqJextM7VK0vWb1UAB2MbeiBPE/+zgJNQZQ/
 b7078p7likgTwmxiL5SV1MJT6dxV7UhLhE7hRkc+wBGG/UATrLC9enPpSfU6/Xjwec2R
 DraPJ8X+/Dl9Iv5GrHYW6f33ByMls5r8FpBCP9aVy/3izdu+x4AMq5Z62OQfPDZrYFXZ
 R7d7+nEBePb/59XDV2thAtwvpuW/asJweHkcTotXotIS/UUeJhhxZEnW9Ihn8iP/bKUm
 nKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjKzSjMAL2aZTDwMxNIyqUtE+pqk7ZtU7B0xdEIFMtwkciv2U6yZjLOBZjg9uVCxgGHkmGEho=@lists.denx.de
X-Gm-Message-State: AOJu0YyTCee2+g9JXZUSDIxfN/rXAO1CR84OLc8vCyCVWYFiF1LyW5nx
 CpSxrD0OD7ny1nByzy3s08wtzisAnPOJjTqHzmgQ4oer1efePom2drn0zaYiojrCUb8KtZbUsJZ
 uXis2p4ScfT/asEKop+Zvf2a0hoY=
X-Gm-Gg: ASbGncttafKcOhX4sA24M8Ks/lYNkJNGqS7i5dAkPw/3FKGyjfLonr/W0RcrlWGT+v3
 11j/PgINa4zyOAn41yhpI4Igd55y3+ifEuz9eucadDBYAyReDFARVDr21Xah5x/jAriNZRMo9C8
 rYOON+oi8FxzF4ypXRs3Ct+jLmrl1tecC/JTV0EQV1MS3w+7WKheZGQxsu
X-Google-Smtp-Source: AGHT+IH1TO5DcJd9pGdRxytmrdBoWVmv4TPeAjvfDJeEjbhCUyS8GhBzV4Bl2TUubCMc2IxgS/pSh8iBRK4914Iikug=
X-Received: by 2002:a05:6512:220a:b0:545:5de:f46d with SMTP id
 2adb3069b0e04-5497d37b016mr2731802e87.39.1741266023944; Thu, 06 Mar 2025
 05:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAOMZO5BTCir859QDcR9XEDTnc4JnMHdCSLXTe94Z9z_FY5bwbg@mail.gmail.com>
 <20250305181703.GW2640854@bill-the-cat>
 <CAOMZO5D_WeB+iv3YzVeBbfL3o1Wr250aM3+phGe7i9Luus9uzQ@mail.gmail.com>
 <87pliutj96.fsf@bootlin.com>
In-Reply-To: <87pliutj96.fsf@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Mar 2025 10:00:11 -0300
X-Gm-Features: AQ5f1JomeSkv-pRCcqA6cKbVXFPlEyDe63nVJ69u24XqK3jgVQkecmZiW5x6eCA
Message-ID: <CAOMZO5CGm4zsdR26weQY9_8yztPvjvSdUs-MUPokbCgkYzDrHg@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Thu, Mar 6, 2025 at 9:51=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:

> Why not just waiting for someone to tackle this issue with the CI? The
> handoff test is failing, there is nothing that can go through any tree
> at the moment, no? It is not just blocking this series in particular, I
> guess?

Without your series, the sandbox_spl test.py passes:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1050165
