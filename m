Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FCAE95A63
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 13:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3783F86406;
	Sat,  7 Oct 2023 15:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RKoaIrvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A07386D14; Sat,  7 Oct 2023 15:01:13 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7744F86406
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 15:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57bf04841ccso634004eaf.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696683668; x=1697288468; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dawRT+1GURQVaaVywIlOo/7pSdbnNkec1q9O62PJ/w=;
 b=RKoaIrvNDS+wRw5Ebx+6UutPhwybcWUn6vXLPGD9kGc9qUn/kwVOoCE3RWdUILpEJb
 WPJkL1pDgHvYu5yC3tS+cMowvDsSzUnU0khHH1rr9ISvq0PgQXA949E5EWznPrcEVVHM
 L8le+Ai3paL8y4skozDHIbu4sxBCeqheMNoUCbvj59/cDtm5aGFmBcNPLfQkkeD1O/7c
 PIanG5GChjDMgycJGfPJu1qLZIW4UHFis8xUIFaDEw1lfjgMr2dBMmWg3S/5WLvuBn0T
 54FSgYuIm0Vnx1dvOVA90JYRzTXAlOVh2FVtnqLyrjNH5kRXgUbSrIyWhSC2+9U3Fo+q
 y7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696683668; x=1697288468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dawRT+1GURQVaaVywIlOo/7pSdbnNkec1q9O62PJ/w=;
 b=QR3ltcE+jzI4ksLzrLEOstQTXwpaZWai2MdT7wSeYioulZaCCxskSpkoagttBK1pfa
 NueOFdQHgTPneTRo/EYyFEI6nXXYlfhV3p3pdalc8HF1ZjcST39mW6cvp5uONtlvcPX/
 OB58M/zx/Vm14/AmnJ/0vwnLDiIIj8eZF+ZQdKrLI0lK8s8YxlyRTSEIj3NdiPtCgtEy
 l2oJEVdowk4M6zNoqOzrUC25+CkHaRqsqXop+0Dt3fCMLx7DZbUYdScmoHmnS483vcpe
 HRpKXeczM8jAOXJHwL3r6BNx8CqePD8lbPchWed47starN22avnuV9W5D33W5cgkaV+L
 MHLw==
X-Gm-Message-State: AOJu0Yy8iToY3298ERMhBIgrLlkV/ApInI66ChDe9pwQ2jMyw6R6YBh7
 iCZ+a07Cjzn7SP6U1YFyDzWvatacyQZqNiVbdigW+lYxtF4=
X-Google-Smtp-Source: AGHT+IENFtkpZW078hP92MX5A2ineRsl7QdD0hfJvl9CQqFraQeh0ECt5SKpBFKL8UsdEqIiGBXb11/A3b+zdarY3g4=
X-Received: by 2002:a05:6358:cc28:b0:143:92d5:1fdb with SMTP id
 gx40-20020a056358cc2800b0014392d51fdbmr9956500rwb.0.1696683667866; Sat, 07
 Oct 2023 06:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230817085711.45339-1-t.remmet@phytec.de>
 <20230817085711.45339-2-t.remmet@phytec.de>
 <c3ae2eca245851ac7f7395edd19f91af7eab4dfd.camel@phytec.de>
In-Reply-To: <c3ae2eca245851ac7f7395edd19f91af7eab4dfd.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 10:00:55 -0300
Message-ID: <CAOMZO5A21pni4m7BibF79nnGyuV_YthjsKoMWdjeZpJZ7EuyhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] board: phytec: Add common PHYTEC SoM detection
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>,
 Teresa Remmet <T.Remmet@phytec.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Daniel Schultz <D.Schultz@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>
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

On Mon, Aug 28, 2023 at 9:32=E2=80=AFAM Yannic Moog <Y.Moog@phytec.de> wrot=
e:
>
> On Thu, 2023-08-17 at 10:57 +0200, Teresa Remmet wrote:
> > Recent shipped PHYTEC SoMs come with an i2c  EEPROM containing
> > information about the hardware such as board revision and variant.
> > This can be used for RAM detection and loading device tree overlays
> > during kernel start.
> >
> > Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
>
> Reviewed-by: Yannic Moog <y.moog@phytec.de>
> Tested-by: Yannic Moog <y.moog@phytec.de>

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
