Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958B1C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2167387FA9;
	Mon,  4 Mar 2024 18:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QUrOr0ZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827C687F7F; Mon,  4 Mar 2024 18:54:18 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E1287FA9
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29a5ed64502so642245a91.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574855; x=1710179655; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SplwYPxa9f9Mnqhj6HBUwU1fcd1W9RGl4Fhnon6PdUM=;
 b=QUrOr0ZGbRKKR4y8bAdnT33EAzq4LGhJmoQKxxzGek3os7IUEXz63a88T2zPCll9/7
 6+xx9J/L8SrDUWiP/emcqX0ze89zVnqmf+h0RfWuKjCvQ5MEt/gsKriqOPI5BcdS4g2l
 pOhTYgi8srnK6YyDBBZVljUz7f2A0Lo9XuW5QrhVtnzXARMY+Xv3r4ePI+MowQ21N/40
 pWOl8EUd2wgsuaL7INk/kjYomg3D9iqkYbj6hgehYa93+zAjV38MQtlmXOD3xfrqvmPK
 qS6g+iItEPhSua3kb3ycVMlZ4Xugnv1hnX3J79d1cEcg6FbzRvF5/IS73k+oE99Hloya
 /Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574855; x=1710179655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SplwYPxa9f9Mnqhj6HBUwU1fcd1W9RGl4Fhnon6PdUM=;
 b=FFxl5dfQW7DNgxrqW54alfUrgrPJf/L/iQYtiBFxl/stm/Gk7DJDBlFsuxzcEjXHmF
 Ta9A4XbT6UfpHqpPflYb8hCxz03WSSFAulh7e3ntPeszeN/ym2FPAa+H2wYFhQTJA2st
 wFoluF151irxwNOiq501nppwmaRBuDKqPjwaSqpCYglgNN74Xs/0VAAmdbANtcxn36cv
 qihmWpJ19REdN0rYasu0L9No3UjPCc3FCSju/f6+Z8PTccGSEMJRDzPztRot7ZTe3xBj
 wLL7uwixR+/ZETcA1/28a0j4/BUiJUOgL6GtjQO1z8ZQBcASnyXBPFHMVOEKT0D7YwKj
 BPog==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+JRIEydv6yE97KA7O27vD6E57UEOteRZ7aKXACl+bXtoKRFb9ao15fuS0CdykXC0FzMKpa1VB9GWgCuhuE0cVayIjPA==
X-Gm-Message-State: AOJu0Yx9SbGl2eGAFMicm9UuF4lP/iS4SJyb2IbFSeoZdwVb9hHHfJT2
 cmIi+L0xcP7fJEUaRHyVaCxJ0aUwKwPCANQ7zY6KZff11LO/OmbzyqpGkbScVgPlVtTO2i919iP
 JSrVYM7pJ9cZAtuC1eh9qyIfnGLc=
X-Google-Smtp-Source: AGHT+IFdBIFS+wDj1Qlhbx1yIhI49pViBHdoVp6UHXB5rrmCuFxdfyKmdTrHMVQeOVkDoWftd5dQjuX12HhUXrDmyy8=
X-Received: by 2002:a17:90b:115:b0:298:cc02:4fd2 with SMTP id
 p21-20020a17090b011500b00298cc024fd2mr7966942pjz.2.1709574854819; Mon, 04 Mar
 2024 09:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20240226173719.25629-1-othacehe@gnu.org>
In-Reply-To: <20240226173719.25629-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 14:54:02 -0300
Message-ID: <CAOMZO5Ba7tqHfRCLv8Ao-s+3QvG6Q2qYy0Q41mEBjf6hGSBqTQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix OP-TEE support
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

On Mon, Feb 26, 2024 at 2:37=E2=80=AFPM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> Hello,
>
> This series fixes OP-TEE support on all imx9 boards by starting the ELE R=
NG
> and adding the optional tee.bin binary to the ATF container.
>
> Thanks,
>
> Mathieu
>
> Mathieu Othacehe (2):
>   imx9: Fix OP-TEE support
>   tools: imx9_image: Reword warning message.

Applied all, thanks.
