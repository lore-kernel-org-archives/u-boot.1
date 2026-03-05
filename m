Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B204F3D33E
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA51D83FA6;
	Thu,  5 Mar 2026 18:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kG1wHxus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1D783F7F; Thu,  5 Mar 2026 15:00:25 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF2A883E81
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-38a3772c3ecso4146391fa.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 06:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772719223; cv=none;
 d=google.com; s=arc-20240605;
 b=S/hFznOb/SZfV2J4QKxRKLU+jhE3UaJYlDmTA92Kq26k3YDz1h7iVCtGU4OYKQcoyc
 TVgCm3dVVxKc6O9wKIxQRha1lqMJCBIxz5wr35fde24YY6EY1M8oKe06oq1zCqg3yCPq
 R/CmIOtxik88dHojegI37kUNagFStVAsR103Vc6Op+HZrizcPV7VJbcct4SNMbPrECLz
 uOKCtctwlPS++Kp6jfBaJQ/bXFoS2qjyOClu/gJD+NDwiSOxo+Vpw37I8CdbmTqlCRaV
 RKsK8QlztM//cb2bpAH6HggrJKBJZEb4fkxe2h43eKlwCwgNDtFtKdC0uOZM7qIQvOOx
 GbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qn1+MXjUOCzlfKTTLAAya/A1TxWjfB9YmfSfE/i5syM=;
 fh=AFJ62T4qUYZQwE1dvosizxezHHwCKM7Y/tgCehUPoMI=;
 b=RiGWCea+SzaiUkvNY9/7ePGwESjX1EV/XyMoV986L7L0gpIhVhzTgspg8NrqCpjyMo
 UxHMHf8Wh3CLyONivnn/jLuhkmCcqv3dhhmWCEee/ePRiSv50SHCdVD53/KWoqfLgE0s
 PaClf8nnWpiK4QHiMpD5oqn0RHjzApaseWun6jaOkbhgH1AOrIN7lyiZNH9FOuZOzEQ9
 wbPibWIBJTYxcy1mCS9dlhlLP32O1D2AFnTM/v3YLUSbLGLLcut7nvrGGuU4xc8eZE3K
 51twpCNmb1YtX2GyHQbNgjMCrQiXR97E6A5ZEfFYe7j4KLQkxPoG565dtUTjoRZPBe9Q
 n4dg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772719223; x=1773324023; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qn1+MXjUOCzlfKTTLAAya/A1TxWjfB9YmfSfE/i5syM=;
 b=kG1wHxuswGZ/raVY3LccGIq6u2eXo/TbqT3oRF+SevdqexqFojmpHCYTPQNFMaAZ3E
 NsQeL5F+C8ihzSN65xilHDGlw4SvOZRT+TrEkhOtcUZ8Cwd3LS6xWzAeeD8W+Eroy773
 Fzf5abN3RGnA4HrJqBcjzh29KDp2CRqWQoBH1/nQZzNE6vconkWGBQcfWAkfNq4zkyX2
 9G/xnQnLyC+UdS3MbSimPZ1x+qlWbpAACpZX8l+rtYo1QjrXumaW4jAySPym5u2X4iYU
 3pJAlk0MfKtxGj2rsu/Yzxm9c+2vWSoohwq3N7dulANHUxQm9Ka9yQUU/G9qcW7F5YjR
 1sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772719223; x=1773324023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qn1+MXjUOCzlfKTTLAAya/A1TxWjfB9YmfSfE/i5syM=;
 b=RNzR9HfneHoT+dMYnTTduvyCbJPiawVLYB3dSl2rdJ+IUAT3gVNy1lucFP2ZfG6sMq
 wsun9lJFzwiPk8fANbx1DfRKz57jVoURqWv96i+Rsc2GI0dgUG1QhoN10NVOZygRaRlq
 J7taFO4G5i0VO/zqjgui4hf1kvjzuvVITYHJ3KUl11DP2x4Z/iuudfIbNWOs2zOpYgsF
 FF6f6unzzbQH5hKIXcqcZacbGm/TC/c3bYS5CY0JnC1++WGzpfUuzJrkuDUVTeR4zFzP
 RwEJjsikIXremQSS1Rxhif0uOsdrVzVSs7hx4fIM1BQ0NZSHKCGBEMYEvbgt2XgOw7lo
 /TSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9wKvQHfx/4bFLvdjt9dbdFsNDPtn6pJxn2DdMNjqa3OT+XZL4FofhmCFrEj9EDv0ZtCQqRmQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxwGXOaP+d6Eu2Sd+F6boinmQkTkDD04JROCCISJD1NcbS34vo+
 LB6cOkI/YWpVTuxYkaLAXVR786UzddBS4MI942ulsSlwLX0MPBAuE0B0rlv7YfOxsapsromR5op
 Jqr2Qeqdfa60cCOE0JHAUa917oFvDRpc=
X-Gm-Gg: ATEYQzx1xBZJpv95pnBkyrflR7v2wJvgeap6jkAvdV0/TpS4JmPng18lZZxTSuuTMfS
 ENKcnwUWUNQm+RagkmCSER8rCDwATTw/4IcLwoQVRfDutQ2it8cgjVeLwHBU7/lFtH7Ckh3GOKj
 AaeNdMd6xrCiHrOkZy2Ld0F4QMZGXAeI7hyh249UxbT7GbNG4Gs9yRJpysuQJyapGLPKRAdvqy2
 MCxmtqA4n5t0gI/ntdBU3kLd6FzgDncKptzVV9FgDiWZHTC4y3ftLX7J+wpo51/zOLC61KbEYyl
 pWWlg/nvfkb5sWZ6Sv4BpswzZF53TAC/UedWdr7yMnmEwO5y4qYgnkoYUPokFLavJxBtT9bJ
X-Received: by 2002:a2e:3210:0:b0:385:d6b2:f4cc with SMTP id
 38308e7fff4ca-38a2c7b197bmr25190051fa.19.1772719222768; Thu, 05 Mar 2026
 06:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
 <20260302-imx952-v1-11-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-11-069d6167c0cb@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Mar 2026 11:00:11 -0300
X-Gm-Features: AaiRm53T5giMWVX9SE396VjH62KfwebFZ--yLqS6udLaC8JOfcLZrVOtL0F7_lI
Message-ID: <CAOMZO5Dz9PNPWqqBOvwquvQYmh+Oy24KQ79d5qcxKn8EbyH1ew@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] arm64: dts: freescale: Add i.MX952 EVK basic
 device tree
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 05 Mar 2026 18:26:35 +0100
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

On Mon, Mar 2, 2026 at 3:41=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX952 EVK basic device tree, with UART1, SDHC[1,2] supported.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>
> [ upstream commit: a5aa8551d0046ec701e8962f83361165ccf640a4 ]
>
> (cherry picked from commit bf18a0f083bdf73f806a3afb9b606b2cb0fcafb3)
> ---
>  dts/upstream/src/arm64/freescale/imx952-evk.dts | 217 ++++++++++++++++++=
++++++
>  1 file changed, 217 insertions(+)

Shouldn't we add this temporarily to arch/arm/dts instead?

Then, when it reaches dts/upstream, we can move to OF_UPSTREAM.

Tom, what is your preference?
