Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6665ACD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85C7803C6;
	Tue, 12 May 2026 11:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="oxZbizjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50038341A; Tue, 12 May 2026 11:49:48 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6CB380398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bcff2d08ca8so285146066b.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 02:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778579386; cv=none;
 d=google.com; s=arc-20240605;
 b=RSJWc6LxYvt07mpXxeiBVvHfja7tpOYCJesAt7zzKbKTBVeuDxiUKaYRkfbmG/2Olw
 tUsR82pk3GkGCho/AiWyUOIvJQOiLlsDZcbDUzQ9T8Gwq7z4J2SA0kmNkZvbwht8xAxl
 TsRlgM5/Br4EH3XPQ45v6GkXgTONyRVj3rLt/Qnu2fZKZounEyjzQfVt/btVRIihp13U
 qeCPSrZpkbSN9EgbFDs/deymX4ff1cVJI2eNau83MXYGffi+r0QbB8JTqB49qJYHJkop
 R/zvm/wwgICh/SVVYVh5JW5Ka7xCXokEWKoc6r4x4ulYirJOtxdjzZ7XPL3DjsuTaInY
 1eAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jAEp1A7B4ZA1FuqU4ED9oT//sdj1t64yqiXHhWw0Gr8=;
 fh=y9gDFogSGC1ykGIW49UG3E+efE2t38tpFCVAb91tqyU=;
 b=GVTSSAfy96TcpEnpK22WG07iWz0o1m0SJxWNs0oeQt3JnwSKJcyRBqIntQ9Rmm6uN2
 tG09n4BZSq+CnZECjPpvy3xwBdIhcOMzRsaXZ7E8xjN1fghnvb/SDhk/TKWx73zFQu2N
 bC2VoFWw78ALmWOG4MolR4Z+KjSn7vvR+M5iqpLYLH86BE94WxmXUW0UbWQLZtODYqm4
 YFSuQ+kkOR5Ub9Q76nF6oR0pNCW0vCihVXffKAUp5G34zsvyHahnWOxtR27kfKj3wGab
 NDH1tVxT0OP/Cx3KAbqumNnPFu2MoiCe12eZeD/CnUHU8x6sxTi4FECL/Xt4ltss7f/8
 9SkA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778579386; x=1779184186; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAEp1A7B4ZA1FuqU4ED9oT//sdj1t64yqiXHhWw0Gr8=;
 b=oxZbizjDselQApbIkcoKcoTSenpQFZe8u3FHrddCsjq0Tn4a9zzB5cY2NkYmtD1wGk
 anIgU/aWkoyjlN8DGdHBYhlMAQMbhTcTXwK3rhFms/fTisXqDEe+e1HPhXB2TgLIeBqv
 fuL19x3P4LL30EvbYktmmDjOci3hokr6a8KzEJtavj/elTX+zmg5jN/iADN8RqWj/km3
 ky5j6B42bB18p+/5jwtVaah1NSpRAuNxKgJtKP1QgKBKAFuULL9rJ9F+tShrdFzMUaE0
 OqV+N78sXhQcq9+IgjYtMk+Zbs0d2tnz5CV51lZ1/4NmqMgSbmK45f7vyD/fFaznMYCM
 tEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778579386; x=1779184186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jAEp1A7B4ZA1FuqU4ED9oT//sdj1t64yqiXHhWw0Gr8=;
 b=VbF+m9Xp80qbnV2lg1rEgY3d5nth+clS6xFvkFrlHGEDfC2VjIAqaBM3/JO4LjZKOd
 +FUgIX8j+QiJcdC3WFlArYfIqcc1F8UH5DeULmAmbrtXv4jw+YBsIX2JsZTQl4zfJ+px
 bMapS86Nh8XDP7SOXd9qWdTmJ/jgdaLPpYDK1vKDwBJnAKJILApQYxEWuwAwrSmcnkFf
 YgYP0IH+CLSj0XYnzdJu2ZeYYZjS2IydFHTo7vDv8mBy1iMXq19z0KwP0lwKiTwc9nvb
 Yy53pZivdNw+Y0jINdeBzltBGn+7lyU85zkxjhN9SoEjAIcZ8agb0mxAWeN1dv7aLZxB
 9jSQ==
X-Gm-Message-State: AOJu0Yy5xvPpRqPrdNkmmF6sLC/YaphYmFWiH4FDQPjuubQ0aAJ8CSpo
 gIqHQR2mlngKiEkFMP+vwbOaaOeO0P97h7pWFDpzbgaZst1fyyHAx/9ijNlKPN8aq3VmeenHJK6
 v9gGKZlKCJ7I4ZWAU+tw5xpXH08cLvF1Hi7qTre+3dFLLcld5J0qK9mVeeQ==
X-Gm-Gg: Acq92OG0zHAXKh3T9O5b770QN56h5JrPmGcKJNyGQ3UETxXsvMlMSVhOP6mUYVJaleq
 G8xeJUdJndqs1++92Ihv+fiGS+OLPDvbAF5whjJuWHpM7O6rRKQfGaG+Nj1CkEWKPChQq+AK4eM
 /WsXDqz+WnmTgc7dKwNjm5egTxWncdI52W31NQIfGXq5KGe7/7XMAPX8KAVI3A4FMqcDGUVSr7r
 JFbe503WnRbNy8VFBOiQ/HgJtlyqWTBwARAtaSUYkDGTCz/rZI7D3iAfEQQOFdwGR+vVY0cL8tm
 go69Cvju9V14BWEo5Wu4SA9GQggPRldQDm2bpi3W
X-Received: by 2002:a17:907:2d11:b0:bd2:649f:971 with SMTP id
 a640c23a62f3a-bd264af2c68mr170849066b.37.1778579386017; Tue, 12 May 2026
 02:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-sl6341-v1-1-2819ac19e050@flipper.net>
In-Reply-To: <20260512-sl6341-v1-1-2819ac19e050@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 12 May 2026 13:49:36 +0400
X-Gm-Features: AVHnY4KPEKrAbVLPdrDkljRgXP8CleM-wFy0fBrfGB5aczbnZKFZndagkG-uxhE
Message-ID: <CAKTNdwF087X=19_-kEwSzCz=OVmNC3s89UnYR7PFdMG-mWBwfQ@mail.gmail.com>
Subject: Re: [PATCH] usb: onboard-hub: Add support for CoreChips SL6341
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>
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

On Tue, May 12, 2026 at 1:41=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> CoreChips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
> requires external 1v1 power and can optionally use external 3v3 power
> (or alternatively it has a 5v->3v3 LDO built in to derive 3v3 power from
> VBUS). It also exposes a reset pin.
>
> Device tree bindings are queued up for upstream release with Linux 7.1
>
> Link: https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/usb/corechips%2Csl6341.yaml
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  common/usb_onboard_hub.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6fc34489a98f..d15d7bbff87d 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -262,6 +262,12 @@ static int usb_onboard_hub_remove(struct udevice *de=
v)
>         return ret;
>  }
>
> +static const struct onboard_hub_data corechips_sl6341_data =3D {
> +       .reset_us =3D 10000,
> +       .num_supplies =3D 2,
> +       .supply_names =3D { "vdd1v1-supply", "vdd3v3-supply" },
> +};
> +
>  static const struct onboard_hub_data usb2514_data =3D {
>         .power_on_delay_us =3D 500,
>         .reset_us =3D 1,
> @@ -299,6 +305,12 @@ static const struct udevice_id usb_onboard_hub_ids[]=
 =3D {
>         }, {
>                 .compatible =3D "usb4b4,6506",    /* Cypress HX3 USB 2.0 =
*/
>                 .data =3D (ulong)&usbhx3_data,
> +       }, {
> +               .compatible =3D "usb3431,6241",   /* Corechips SL6341 USB=
 2.0 */
> +               .data =3D (ulong)&corechips_sl6341_data,
> +       }, {
> +               .compatible =3D "usb3431,6341",   /* Corechips SL6341 USB=
 2.0 */

Oopsies, the latter one was meant to say "USB 3.0". Happy to amend and
send a v2 (will wait some time for feedback first).

Best regards,
Alexey
