Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4ABCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1CA8004F;
	Tue,  4 Nov 2025 19:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RxcJmsG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C993E836D1; Tue,  4 Nov 2025 19:04:48 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D168003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59052926cf9so6442258e87.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279486; x=1762884286; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMJEtfc57FW9PJTxe1NGbkNoSz2miW/03GeGXAN6Zkg=;
 b=RxcJmsG4Vor6BYXjw1kvchr2VFowum3ysKEyswXkakqDbArS0MbQ+tQeL5Hs7FOd4I
 mA/zx6uQH0WoYrTmTAqAaQbV96Xac5X6Vz9+6Kgi+YjQaw+vjzzPUM7F1yNDStFh6I10
 lvo7pWE+OfRgYLxWbBkW885dCp8TNzIhfSwMH45jqzO3F0NCMZLoqsO7Py/po7wQsj5t
 WUhPBYQUv8INFObJbmU+TgkUJ5Eh8jhpH+a/bbffesbd+fk4DmYlVDeceiubALRRWeS+
 6W/jdV44LZzWg0YofauzEdJ7bRBM6W1xmLkh3M8J+Ggxb90EBlCtK0/xyrrRiNIEC7H3
 7wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279486; x=1762884286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMJEtfc57FW9PJTxe1NGbkNoSz2miW/03GeGXAN6Zkg=;
 b=GQk9gFTvxarZK7k7i75Ne8XkBiG3v50knEAWJCO5PuSl9i2kW+73CZCUP4W3SrRex5
 RLmMxEiHmur8OgiyChrlMZ1wT49pAeF0BkTh3xBPZB0V8ZsOxhi9ShGSLF3zuttQrrui
 EauIDQztAvKfYw3C04eo4WcmxBSFfZMc+yO5qS7Dw9JgQOAQq1r5nDzbN7pDQd9dhV8X
 ozpsytYVx2R8iG1h36VnDVgieomv/SK/5xeiBq6Wh90OC/RA3Z7srsab6AKChZIVzsBq
 znE8cLGjUO5akRBf4seHtgdGYqNZXMq/l9MkiYegHQ44UVea1gtmwY9++PdkiQOMMQfL
 +aaQ==
X-Gm-Message-State: AOJu0YyH5V5+01MeQpvBHEKg+IP1tcjkqBifRvPgMJUtA6xWB0HJRvgU
 6c7jszTZ65x5DDqgBNEzlVEO3I1pzjTO1ZW1ORxviYujpuhQr3rXklFcRnalc4qyZhl8L/skd57
 pKzUrUC8wa1uFOHQl3VfyEFcFR42mC9o=
X-Gm-Gg: ASbGnct/Cn39+KBnEtvMB9hNgnW7wkL/SatQuCYG54TqsA/I2BlONQuxAy/t3i7+HTi
 T/vB1fcHKcYRJlzrS/puZPayV6tXKIYnD5CN5uKTs386ElxYV7FxjbJMw+dHHo0P5SxIVwawOKj
 0Onl3sKlVXHOpi/HaZ/KuektmOZTO+XHWFtG3oYuQ2En7N1oRfE1VvwoyRb5CWjuGrrtOPC5hUk
 wuO/rbFmGfNmLrCSpn9yUzvZopI9bgrG5HCBIVBpBgSLzxJfpsj1qAcvG5+ysErcT8mY+VvtBqv
 7PnpMRgQKu+wwsOt
X-Google-Smtp-Source: AGHT+IE+qRN2+6smStA4C3bFS57N1UptIzpZHEUA47EGFXLubj9yVjtEvcG7QxlSKSd1QFKUM0yaUDKv3kWqbnuKvM0=
X-Received: by 2002:a05:6512:2351:b0:591:eb01:8eeb with SMTP id
 2adb3069b0e04-5943d7d956amr6082e87.46.1762279486037; Tue, 04 Nov 2025
 10:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20251102173459.80904-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251102173459.80904-1-marek.vasut+renesas@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:04:33 -0300
X-Gm-Features: AWmQ_blv8cckQrwkeG-hU_XeYOdX9IetbQW7qYmTqne_9UQS3IOwBOSE3_6TAgU
Message-ID: <CAOMZO5DMkJvR9_K9bLWwWW52u=_FneKqEcvZSiieDiwtGkhDRw@mail.gmail.com>
Subject: Re: [PATCH] imx9: scmi: Drop parenthesis around enable
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Ye Li <ye.li@nxp.com>
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

On Sun, Nov 2, 2025 at 2:35=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The 'enable' is a single variable, there is no need to have
> parenthesis around it, drop them and change the implementation
> to simple !!enable.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied, thanks.
