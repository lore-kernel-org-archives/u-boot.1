Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E469E8784C
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 18:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA98483C39;
	Tue,  3 Feb 2026 19:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="hAi61Ffu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8634683C4B; Tue,  3 Feb 2026 19:35:34 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096DC83C29
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 19:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6495d592b58so5593555d50.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 10:35:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770143731; cv=none;
 d=google.com; s=arc-20240605;
 b=eX3C2cEBi8x2tLSU6JoGngaywCbMF60DGoK62tSUcRKecHGyrvHLN/7ak5OszQpbHD
 upP4Y8nne04pIeJiDcDZ4ncjE8aDnFsqr4JykKIeE07b1EOGFbW7ypRP54Efax9BMuu3
 1zFFpeAThO35aQjX/SjILC9PnfySWgXNP1o/XjFmu6pwTT7dUkdJI3Nb3ljLOpx6QuTl
 esQHsxzm/2AiGMUYim3ugb9ra7offTE6UCXy3OEISpemilMFf6nBQBCjtP7nCpxLyjpV
 Ik3RwSlIRd5ECjihxAKhND3WfRlNOrNyqal78AoI0DT8ravhfso6vbvAf/n6A6izmVSl
 qbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HaKuRXskk8V+3hA1dqfLEABDQBQF+C+uHzH2rDStwvY=;
 fh=ulYpyrL7VsLd7n/N8xGGPiyXyVPg6DKYzXyM8wl9IYk=;
 b=arJYT4ED9hSeGbysugE3RkTZrBkeguC2nEh+W9vW+wRkxEui07eYUe8idcp9f2Ol2Z
 rGYBXq1atSwZKd7KFsLoDVlytQg/FIEY4y0w24E49h1fWBSH2VpsAlhgk2bBtDqbn1hN
 PoiIAzMslxc57LO9YKd6sb8mcZCwsbbM3aCFjtPZfmZJail4VWRxvMwXNCBWKY1LgFwJ
 w9pTXbKfg400qG2Vqs8vExSDlRxn3Sq2h40+vmBfn+j265qFe6OtNh0piEtrOe7PaoAu
 QskneSO3/Wq1bJcpbTFoCixDpbiJI9l4cx9r5qLZs/muvwMMtXVh7PIL5V//Y00l6ZJU
 5g7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1770143731; x=1770748531;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaKuRXskk8V+3hA1dqfLEABDQBQF+C+uHzH2rDStwvY=;
 b=hAi61FfuhDM6vFoiPn1SB2DB9mChpcJoQhxXMuwvo4E/QXMxIvMeZl69l6Xfcgw51i
 AxhlbRA9ymYQyZCnAg57Ik8pEY13biq4vYSFsS5gxUWR2GokVAFSbngwmMlhrlsGQ7b2
 vEPOobXO5BDP8ZgGaIA+oleOdDd3dnT83prFfjQ8xlH21tVTJJ/8edgX/1Gb/cZg5kqe
 nMZVgd/Nmh+qZxBWFga7ZvJvwEJ3Q3iNHnfTFhvlIbi8CFQDjTaIqMlWhHh7emUmJq24
 gwq9ZDrelkQijJNlx3dsPlprMx/ZYDkuoP3+dSA8wBa/9fs7xBmt9OVHcQR7y+zYhQfh
 xrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770143731; x=1770748531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HaKuRXskk8V+3hA1dqfLEABDQBQF+C+uHzH2rDStwvY=;
 b=s2lZdB2hK4Kxg51WxaZpXDQ4VhkFxgNCxw92yXwCZjNm4XSo/yFcq4y89+ZAocLdef
 VVUPX0Gl181EGdq8VNBOFXNazdtsF26xUWTi5hm1qpduTP5kMr7QaL8qLEVlhuEhVtm8
 LabCS3NluX09pkoobmk98aKAdRS6ww9wIU8xDOC3Q34+GgWtQ6ZMjotAHSrku+rbNu7H
 LQ5UbbiaBOhue+/RuOx5ktq4dVWAtpgvZDPxeDySNTaFQhbPZbGi83h9LQO0qxnSen1u
 M0h13yrELFUs/2+kbA08IXZmOSUIdJF0DFVkpouKon5UWcvgNq4/5fUHTS1KrfuYXhKV
 yfoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWwdvyz2MWuwar6J6rujsb1OLnvNR3iSyH4BTwVSocXI5km5Q8Jg+cs5hgesifq7rQyp5bJ8c=@lists.denx.de
X-Gm-Message-State: AOJu0YyhllfQG9GU3HzfggL81w8QoCK/8+2RhhNuImVQalLfpWXDNTu4
 oaW2I8Q5n2p54yCcjUDfh33Dt2tV03cHIYzC9ohYva8sRMB5dDBtQ6G6t+2Ac+FbZwNpfOVD7le
 6MuH7Nu7PsXZAyFv2AvTnrnDo0n5eOHSKSt94/N36
X-Gm-Gg: AZuq6aI3jb0a6oI7p9/cBvsTO26iT8nHX7VBk/YoZczm508FQYtzsnfEItPb5nfrxRU
 gJxjnszU5qao9rYOyqh6xvcKuERsx82lTWhQNw5wPDZUcMbYdvgGGetxXQdg4yhwcwb7n1zJGu5
 J/SO3eqj/rBvGtS7tTlNBG7jaHEMFgG+MxoneJQ15R+qbA9Hu068HXAY28pjAueFo1JVJABxT+e
 O10xXTsgf6cvzo+yOIzCgaKzuJ03XIi20P1aMD1oiGY1X8Knvr5z0LvWSlLcI+eituKW1NZ
X-Received: by 2002:a05:690e:eda:b0:649:5ed9:fb73 with SMTP id
 956f58d0204a3-649db4901damr328520d50.50.1770143730699; Tue, 03 Feb 2026
 10:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
In-Reply-To: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 3 Feb 2026 19:35:19 +0100
X-Gm-Features: AZwV_Qjdas4-5NFEN4cYQ-zlVKx_Bb1TtddS_oGpQA954tPEPVtf5_11Fa9d9F4
Message-ID: <CAHTX3dK6eybwR+FBcqS=qgFOpX2BVsg3gDQs=mTbshDMDS-imA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] net: lwip: Do not write past end of buffer
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>
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

Hi Jerome,

st 14. 1. 2026 v 16:12 odes=C3=ADlatel Andrew Goodbody
<andrew.goodbody@linaro.org> napsal:
>
> Fix some cases where the trailing \0 written by sprintf is not allowed
> for in the target buffer resulting in writing past the end of the
> buffer.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v2:
> - Address review comments from Michal Simek
> - Add a second patch to address some more instances of sprintf writing
>   past the end of the target buffer found by code inspection while
>   looking for an issue.
> - Link to v1: https://lore.kernel.org/r/20260109-tftp_fix-v1-1-64bd50abc7=
2b@linaro.org
>
> ---
> Andrew Goodbody (2):
>       net: lwip: tftp: Do not write past buffer end
>       net: lwip: dhcp: Do not write past end of buffer
>
>  lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
>  net/lwip/dhcp.c                    | 6 +++---
>  net/lwip/net-lwip.c                | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> ---
> base-commit: c05dba22f1f2b0b2655ee3971644acf1936cd07a
> change-id: 20260109-tftp_fix-3ab9bd66a6ad
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>

Are you going to apply it? I would be good to get it in.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
