Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172D2D0C617
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3DD8857C;
	Fri, 25 Oct 2024 16:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="FuTzdV9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5559988FFD; Fri, 25 Oct 2024 16:22:11 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D9F887CF8
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e292926104bso2260658276.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1729866125; x=1730470925;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqKx3NDameOm/JMNMdfkqasz/NAeJC+7oIVPzinwfBk=;
 b=FuTzdV9Th3UJZCBlfzW2iQP16a1Lr1RPbEo/+z0ua/xQiODk9dl3WXZjzRUjFSgbK0
 hr1N+gxKNRaxf9JRy9WREed3WEoX580iNT/8zzW3+vq6Yoq3bZJm+/tRbG7xDILJjvr2
 n0cohJ/oUMfAmsVw/5t/NtHggrHRgYWOvkOniinvd87mUZTt6AecJygXROfgEq3gDNS/
 oLkZuyVU2qAv8eBz6q5cGiyhDHi/0PgUz+uXEpUhfBZFL8EY9aFgbcVDkUIwrob6uBXc
 KjwVxa/CXQtLOpOH64VPj29/QMQaWKQ9/b+w/zexOuSSM4i+7K4mxQ/1zgExInO+3nD4
 tTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729866125; x=1730470925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqKx3NDameOm/JMNMdfkqasz/NAeJC+7oIVPzinwfBk=;
 b=v7RRLQU39YIyASk378F4XBpVd01BK63aWCFcliygNTBGuMLvg3h2qdlO7JtS8U5Y1N
 PGMGYEq3r0jqKm84sj0hBHHH6EoMwY2Q/KybDoyc3jD6G2WE0X9q9iVfaZ5Og7VKtoHM
 PyIzuXLJLZBey6PC9hHh2NbYjLvLqAeYA+2/yn2WEMw2R0PeyNT2WWp0UPfCfbwKvSFi
 ZqHFk/lhcTe2+zawjCWK+StZTP2Ig/gyshD3Vt9q6PyLGf6NBBiYLmovfjRKTYi/nIUc
 NngRjrgYjEKd50i7Fwg4W6dg8eWuXWPINczDNB7h6RFkVJTuT6VaUV9Cedif4IogkDxk
 3S0w==
X-Gm-Message-State: AOJu0Yz8AF2XMcyytyvwEv4aOBdKaOTFiojEVoYOZzCxUWK5V/ttrHWM
 clx/vODzEmGr8PZjsrJxG6LAcKwFT8xN6OMnjde9TwGO0/+DY2Df/nvRJ8IRkEESmAO/F7Sl+JH
 hqPN4RH1wdN8W2cXh2muwWpInx4bs3yva4o86
X-Google-Smtp-Source: AGHT+IEK6ghRLaI0XnlvDHSBAhvxVVjD0wONlTr9U6Np5Vr1GrtHX01veGLvr7dV1hWc/VzyHMjF9KlCAWVNE0G3cgc=
X-Received: by 2002:a05:6902:2688:b0:e2e:3701:7824 with SMTP id
 3f1490d57ef6-e2f22f1c60bmr6332715276.2.1729866125379; Fri, 25 Oct 2024
 07:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241023085127.3450680-1-padmarao.begari@amd.com>
In-Reply-To: <20241023085127.3450680-1-padmarao.begari@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 25 Oct 2024 16:21:54 +0200
Message-ID: <CAHTX3dJr8+QxkWRFwGnf-OgO-jfjvsL=pbnEB=zT6q9HGC4AZA@mail.gmail.com>
Subject: Re: [PATCH] .mailmap: update e-mail address for Padmarao Begari
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de
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

st 23. 10. 2024 v 10:51 odes=C3=ADlatel Padmarao Begari
<padmarao.begari@amd.com> napsal:
>
> Update e-mail address.
>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 4d48349f0e..005e965b84 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -89,6 +89,7 @@ Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@=
baylibre.com>
>  Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
>  This contributor prefers not to receive mails <noreply@example.com> <pal=
i@kernel.org>
>  This contributor prefers not to receive mails <noreply@example.com> <pal=
i.rohar@gmail.com>
> +Padmarao Begari <padmarao.begari@amd.com> <padmarao.begari@microchip.com=
>
>  Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
>  Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com=
>
>  Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
> --
> 2.25.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
