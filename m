Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6030FC624D1
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 06:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE6583D8A;
	Sun, 22 Feb 2026 07:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1wd/QKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386CF80FA1; Sun, 22 Feb 2026 02:34:21 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B880F80077
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 02:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-354a2a7d90fso1815336a91.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:34:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771724057; cv=none;
 d=google.com; s=arc-20240605;
 b=buxAvhvTdrkhetT3L6CMjftnL7Ql5NIXpPRLvEx5PPhVNqo8Afa5De3YBXaZO32CM/
 N/n70HOxfCSGpvB5jRvX9h5i0iDXbZS4Uz3hXUihWytLVRrlAa1P8GnJUOaPOlLAYSRB
 fv7wYKsdwCTLKGMG6aBVxifhcuzVs/HalAR/Jxumy6EMlg5WpXVCEudk0TGY0VrBEpzb
 1jGz5oyPHnf9TZ/zKpbr9ZiquHHJ4tirZo6HxOQq4x4YO9dyJj7hz3v80pPiHtO0I5nv
 08Y2T7fyLYYSFOwrKLZ2ntCbGkzQv5htuoe6t/sCByjm+Wup0MvwXDMHyLpLi/HuNHww
 /kDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5C+tNKK2OLn/ov+1ES1KcFF5XXqAXKUqPHr2SKq6LD4=;
 fh=T6dmxYCFd32P7JKVdQ0BLWF4QJJBskQX7IJzn/TxD58=;
 b=IKa+6glyMQqhKH5kiKfjeRHiU5OKo+aVYVtSUGNEWvdW6XjP6wu984UYg+eEg+Ed7X
 d/aFBFgodIhTYFg5pEp8VvF1p4hZhAvGWPdRHTD5eTxn5Xy6Jw+XtCLMWBTS4LDBRi7O
 iiJ7ixV6q3pUNGBEhFopF++U07AvMbPDzlLoyM8JJvJmQXltzf5Q6EfVrHegDU8u/z59
 F0G1RjVR/PuY8PdEGzWDjsFQOQDZdQC1aUAjGKksI92HZ0D4F4TLAFq91/2zDk3C0G5L
 rxiG67Ic3mMWJ4N+XH7blW0FstTF9SyPCqX4yqAe1w2RMR3wYrYJZ5QhQpsgsybiB0d7
 5WrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771724057; x=1772328857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5C+tNKK2OLn/ov+1ES1KcFF5XXqAXKUqPHr2SKq6LD4=;
 b=V1wd/QKgMLoQnBUVce4qG6cdHsCA22BLbJf+Ji7Rb5KSBb1uWA0Tivj77RgOUUX3lr
 9X9BVz6DlgWdu4HvRN7xDfY85HXeze36D8upouTeXCHaENAn9b79CuHOaK7mqo5fXjYv
 YFoERxm1b0v5g5uIMwlJyWI6y0Yzwp2keYAf3br/bydjU3MFXLajLX62AY5l6QjnGa0F
 mh+fbA7yJhN5hK9jYFzMoGY5J069lgQcE6IqqeowW3X6hCuEalpyxzGhE825MDEYTty8
 7UiOk1WlnzNG6UZtKwfXiSwLoCctYFdZz1lz7wxaLWOzqS7o+731QUNB6IWVptO4PnRL
 84Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771724057; x=1772328857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5C+tNKK2OLn/ov+1ES1KcFF5XXqAXKUqPHr2SKq6LD4=;
 b=XPVAPYmwIDbqDBRV2R0yfRjhTeBuTRbS7QCuvcVtRUytW4MDt6HIVKfe+ziaGyejyV
 nGfVEsZZwYWqNuvsSYS969p4YejKlMZ31t+nqSOX1mJqoBqfMNmt/raavabDhFr66c7I
 e3l1x3Mo0u6fdtylbdD6WM+JRtEG47UwjGmtVUsNOH39ezZy0b73USUVcZq7gdeCyZpp
 TYguVElnJy04tD9QSNlZLbCRzQ3NsDwdH2TRsFEqrGNntlcL80ME0aXheW9CKoExsUsG
 SEXJDDraOP9HYsQ5tMxcrHLFCONEe8Lp90at7qRv1pUS/Umu4pI4cvuVRGc1H5YPq4BD
 OyfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGVJoXNFXA4N6L1RKrAYnCI933fLAmZNBE4EulgL8gD9afMpfjuNznJpNilaGnhrHVw0UfSYo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8/hPphZdY0tDvb/LmBMdV4xn96xxzZ9KX1lCO1c4Elqd+pgpC
 ZkzmxwLrlYnr2AjysUd+gAGxaEfQZjOmszLM2QwZPgRBsQTA7v1zPwayol4qwxqxT3tpn5CJ04j
 G9TU2VvILO3xa6KQ7sNWcsFdCxXrL1yg=
X-Gm-Gg: AZuq6aIn+RrNJWqhX9zPZZxLgIo3s95tq/LXjhTaQVklC9yKCeElzhkWR/jJuUycQr3
 +f8NpHRBtj2EP5RBl+TgoLKI2vAH7PHDxVfTw4cEM9UgQNucsDeEPSsOhyt8ja0hAjvlhNRGdLY
 hsHtdCwHKx2QBy5Y9/q1BMTCSyRq+fv9S8qPeBZ+QYDrN6fPLf1MY1cfwr/yOGGFyKO+vOLq3gv
 WdzVRYzQiZD74BYjh0kUlt12ERWFM+dg4qsDG2YXlvwWlHQk+PdOxZibsZNs9k4UTqWUag+yaS1
 mJDvo/w=
X-Received: by 2002:a17:90b:390f:b0:354:a284:3ff9 with SMTP id
 98e67ed59e1d1-358ae8cfd90mr3417450a91.26.1771724057121; Sat, 21 Feb 2026
 17:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-8-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-8-2103d0222a0b@nxp.com>
From: David Zang <davidzangcs@gmail.com>
Date: Sat, 21 Feb 2026 19:34:06 -0600
X-Gm-Features: AaiRm52WqxBUqQAC6HLj4GBtnUNKSiuP_6TTUjt4-bxt-SJVBS3KZ4E6lmFp64c
Message-ID: <CACwB3C9X13jVzsKviFgg2d7yFTdf0oGALvRvp7+uZSHfD0AFhg@mail.gmail.com>
Subject: Re: [PATCH v1 08/12] arm: imx9: Add i.MX952 SoC support
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Adam Ford <aford173@gmail.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
X-Mailman-Approved-At: Sun, 22 Feb 2026 07:59:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, Feb 5, 2026 at 9:16=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:

> From: Alice Guo <alice.guo@nxp.com>
>
> Add basic SoC support for i.MX952:
> - Add CONFIG_IMX952 Kconfig option
> - Include i.MX952 clock and power headers
> - Set CPU speed grade to 1.7GHz for i.MX952
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/mach-imx/imx9/Kconfig       |  9 +++++++++
>  arch/arm/mach-imx/imx9/scmi/common.h | 10 ++++++++++
>  arch/arm/mach-imx/imx9/scmi/soc.c    |  2 ++
>  3 files changed, 21 insertions(+)
>
>
Reviewed-by: David Zang <davidzangcs@gmail.com>
David
