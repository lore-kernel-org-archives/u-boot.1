Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C284CA5FEB
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 01:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CD980FA1;
	Sun, 18 Jan 2026 02:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PcQQBIka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8699182BF2; Sun, 18 Jan 2026 02:45:50 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C953B8003E
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 02:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64472121ad5so2262976d50.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:45:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768700746; cv=none;
 d=google.com; s=arc-20240605;
 b=RtPGBgm5jIxLa7AMa2VB3sf0ugZ5rAHPhNwnyy5swXwEPI3qi2sDamA21p1OLNUKJA
 iyeTMdWvYVdyYo9Ek7JB3lmo5qD3cSSwS/Mn+x/phjCeFM45JCSzBX1cPDPQtaUDkM11
 g24vs72XUG7gtxJEcMHDbo6/BJkPIOweiaGpt2Pz95HPjPhSyKbvfA6pzBUKbzQS3ZEe
 QGOXEzBjEDpRBsrjckgEk5mUNNggTOY2drLH3iaq+vbyJ+GrLLQ8J85grfBbPBtiVxHR
 aBHF+mrXCBNn5ndaUOXxOQMVFE4S1ECoUiveIrhZhwSsghUUsKC2N5sXmcd+jRibZHfj
 G/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c8N/aNm/bm1m0MuCkUzHM7+wfV3rhVMVIqNxf3dYtB0=;
 fh=sMASeYU4Ojfn2dD7TIhqd/PiS0OLIrMM+AeCM0f5QXU=;
 b=fhAW1Ny4WA8/iwgIWCTO2rXRnXDfuIDWIjgxqALOxx9/MlxWnwAX/QmdeNHint1Bb+
 YDLd2ujHLJS9DUFSLHSEQnzyxawrs+IOd6Gp5q6ogOL0a3giljBbA24BYlhzCXtVH7zr
 41kHdTZmC932Y7c2yUH7YiNX3GE7FlhFo8GFfkWftX6ZJVNOajn6Q2ucynoPy0RREbki
 Jn/EO55uA+l9bkhcQ8YixaB3Tgh+UOOC2XxZQlQBeNcATwVVUYCOFiQ73bpybRpcfJCr
 qmkFF81xdjdgktumuPekxeersOe9BsbjU+gXDIZ2HbcoWu5AdDrAQsPyq1ghJDnpKuDJ
 Rxow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768700746; x=1769305546; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8N/aNm/bm1m0MuCkUzHM7+wfV3rhVMVIqNxf3dYtB0=;
 b=PcQQBIkaBzS9sYBIk2my+nfhlKUEaIDBYOoTih3z9BsRWXAOhow9H0nzVuf2Uu9CS/
 zNRlbc7e8JGc0k+7WcHJ/6hvlOl2V62CROE/r9JUmaIae8m2HjJRKlJ5yeO8e/uCpbDw
 Jjr12jOvyaqHnbrD7fHGT6AJxcUE+pfEGpKbtpjioYLc+FjfrgLOmIkAQoAP/qcJ68JI
 HsvhH5nRR0Y2HF5u5m2TZNE37PsQrlR0Es1wuZvKgrZBw4M36nqGspqY2haCXr8h1R9v
 eCaeSfmh6mw+Me+WL87bjiVkTW6qVb6sW4uJzInSVblWL1Vq02LnWfKLRN9JWEtGyQZs
 V9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768700746; x=1769305546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c8N/aNm/bm1m0MuCkUzHM7+wfV3rhVMVIqNxf3dYtB0=;
 b=pimDPKdlJihvodpYUg5NTIMUFBZZgA95wgfzzAEcqmHaEHnf9osTtw6Dayhp37Tc9K
 hFSSrWH78wSzJjzKix4+tf4w7gw8cE7z/ZJibCsuaJJDl5Yhd/IFZJjbDf4qD2eaRoUw
 bxABrZRxjFPzW0iksC5y3b0lmYRjumhkDqKTd/W/H0mRMD0oP3vXb4LAxNMNIJQGRHvO
 sfSslQsAEWczyukeD6pwsqgz3DE8ah2yZ7pIxYOvtPdKnUb7NkaPEZkroNojq4p4HFlQ
 1ua5uKLsi4kpKZB/qYZEI07MVKkScCsW9bR2C6H91yOPYXCiGRZ9E9L04fOuI2YX23Rm
 8xxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpHzk72OGEk5nuyfj5BmFpfkdndq1DWOOm83q5N96nCGxl3p7UWS0eOc4P1mB3AqrfThhQr8M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj5TGj+fhY3zWC4/3VIr+frLyXLQYPIdQunrzrCqXAh9/CIaR5
 8coWRlpLVwVlB5m7nElpA4pfeM8z5om58RDfoAYITqqWylDjyC4GAJuFUYar9WTbLT82u5tU7A1
 BF0CTjxo/OagQJrTd6FmylGyn1mSFQms=
X-Gm-Gg: AY/fxX5J3+CJowHZKaZS0NYy2g8/m9SzcgnSPsaWaGpK1XB9tRF/2WoqI6E+FM0saHA
 hM8gV4JFI+qjcNuYKJZQAWjmOrsF7bPOJiLX8PPc8tM6TyxriWUpBTrZ7pL94lK4I7abg7oQslc
 sT1iEnJ2uLeAhOLk590gLvSBW/o3SycM3YCAW0j0cpcxcJMiZkcnSnwu2zrklf0gp/ZtCHotfBQ
 W1Msx5Kij2ubEimwqIDJwgxJroiJiYoGtHZAmACD9dBfyYhhZZB4+9VL598PGwKLcF74EF2Jytv
 X2cc9ZsgR9tdT4v6aco=
X-Received: by 2002:a53:bacf:0:b0:63f:bd67:7c4f with SMTP id
 956f58d0204a3-6491647e8cemr4757462d50.12.1768700746604; Sat, 17 Jan 2026
 17:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Jan 2026 22:45:33 -0300
X-Gm-Features: AZwV_QgMusYQjGjozotMonqoFviFz71etG0Nx1Scn_8wXPE7xV7AVh2mPluwzxY
Message-ID: <CAOMZO5B3V0oaw2NyPcMZrGPcNh-v-2PUrSq2sTep+56SZNZ8Xw@mail.gmail.com>
Subject: Re: [PATCH 00/13] imx9: board cleanup and include ELE voltage API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
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

On Thu, Jan 8, 2026 at 6:52=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> This patchset is mainly to cleanup i.MX93-EVK board code and
> sort the included header files for i.MX93/1/4/5-EVK.
>
> For patches to sort the header, I follow such rules to sort the header:
> *.h [generic header]
> asm/*.h
> asm/arch/*.h
> asm/mach-imx/*.h
>
> While at here, the last three patches are including ELE voltage API to av=
oid
> create dependency if post in a separate patchset.
>
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28959
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
