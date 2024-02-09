Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9B5C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 14:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BFAE87E6B;
	Fri,  9 Feb 2024 15:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ramg5NJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079F487E73; Fri,  9 Feb 2024 15:28:22 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B3087CC1
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 15:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e054897a34so58133b3a.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707488898; x=1708093698; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynhkX5Ok2BkqtvidSFAaDlKUTOGHVMQWfLfA9cmi9SY=;
 b=Ramg5NJRnMqTbHuJUK9aEzAA97JgGVq4c23kdUePa4OhVhl/d5GDhaRk05m55Ocu96
 xRW6TrpeVFPoArmDE0JfIHNGeVJ/KTWXX/dfBY7hufJ8gWBcv6QuVIBBQDPLH+UkO4jA
 TE7AaD571rrLaAhPtE7hwKzcEXemrFIutEyIBXkmMMFc9IxiUVsEsryXBLheuir2RCv4
 DJR8IVXB/Gq/G5Zen4YtMKBXavV9PoeToAmIk9nBu4cnziuUM99DiJ/JhYIM7U0dg/qt
 Wi60GpxutyP5yT6agyomLpgOdAFwnZc7WM9GbbaETQevScqihs+WgVr9tXDr3hzzknH2
 BBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707488898; x=1708093698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynhkX5Ok2BkqtvidSFAaDlKUTOGHVMQWfLfA9cmi9SY=;
 b=AyuPee1B85nZTgKdGvDEZ0eeUeawO2WxCjhNaMEQED8SSwwG3+yxsaa/Hef/Q58ARp
 veZQZYdmr3NRg+rKrMya4fDTNDv/jyoQj/oGMqik/4ot7kvDiRXKteqLUnrdEHGdZ5Oo
 9OuRAvtMn/WpkFXkqYRVVL2ZAv+d524xYnRp6inR2qHsa1M57Gmm22Mpm01hfR4cZwVK
 s0lZ578WB2ppDUGVWLea0egSNjEYwnVTGmi97RBZVf6MKFtZi9lPBBsn2zLhO2LvDWHP
 WbtV9fzzLmd+b3ppbYfBY5tj+tPCbrONGFRRR3ktMms1Q947gZLwDSsE1WC7cqY5342v
 XZOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpfiyYJn2BjE9Fitugd8S4lEbZvnlJJEpIS/4d5yrEUC2XASQrfy6PX26PoFkHJvYAShFBZJMDWE3ZQ8m6zWlVPXMwcQ==
X-Gm-Message-State: AOJu0YxA9EwdDKVRKRhKuAPbkrDfhSzbsIgBOKoYumUBTcUjRV9BH0Hi
 xLTG/ZDuE7oAPtwe+TH7QHqgwmq9gz7ojCDi66se5cSto8ubIAUYfniGWANZIWxD3V8LKzVh1aO
 Sm/1uLBcwtH+Tjwz0yNGL4FbLBNo=
X-Google-Smtp-Source: AGHT+IGU1qBM9TeJbQ0ciVNZ0VjKAX6BjTeyjtNrmFodH9zHdoqndkOsQvT41pjQxRMZjx01eszXXg2Sbt1JePQ086s=
X-Received: by 2002:a05:6a20:728d:b0:19e:83c1:1a79 with SMTP id
 o13-20020a056a20728d00b0019e83c11a79mr1934790pzk.4.1707488898148; Fri, 09 Feb
 2024 06:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20240208094518.391-1-othacehe@gnu.org>
 <CAOMZO5DhQqjsAy4eoZqKdaTT96EWfRa+Vra3gvRCwXP+6fXt0w@mail.gmail.com>
 <87le7uyset.fsf@gnu.org>
 <CAOMZO5CmE40nKAnhdnMxHxwQy8bJ=Fvd42VPUDb7cpVYVQneAg@mail.gmail.com>
 <875xyxzpe0.fsf@gnu.org>
In-Reply-To: <875xyxzpe0.fsf@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 Feb 2024 11:28:05 -0300
Message-ID: <CAOMZO5Ah5cDSJKjAyEcW2mjw0Ux_NZ4ttdi3=Rqhfhe=Z67OEg@mail.gmail.com>
Subject: Re: [PATCH 0/2] imx93_var_som: Enable AHAB support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Fri, Feb 9, 2024 at 11:25=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:

> Once the board is closed you can only boot from signed images. If the
> signed image is not working (hanging during relocation for instance),
> then you can always boot from a new one. All the interfaces: SD-card,
> UART, USB are still usable.
>
> I have tried many u-boot versions on my closed board until I had
> something working. So, no you do not end-up with a brick unless you
> cannot sign your image properly anymore.

Thanks for the clarification. I will apply your v2 soon.
