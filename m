Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B2FC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D6887854;
	Wed, 13 Dec 2023 17:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QtvCErlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E52A87854; Wed, 13 Dec 2023 17:32:20 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0569E8785D
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28ae1de660bso230372a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485136; x=1703089936; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXNN33dfwP+H1LAJBjDluPsIT9G/WF8CgOamzzlGClQ=;
 b=QtvCErlK+2jcbdY4ACGn7YSkPn+730aAqIfvkF3n7F7V+drm2UBVZexNbKQnMwxtmn
 0kEMRZFlcpzoDJdR8WYh9jf3yeqh9IXdGr9OLiqLZt82BztmIR6L1tt/RDvfov7Ye45k
 g2SreGjKoyAzZwsvmkWbG8GDg6OvCa7vdm0hXxWgdNHGRVKGwyqrdmTLASXpwJ4j5sPh
 uqCQjmBaqPKO+QywbzFqAarhaKK6dB66o1bf46Cs2MuSJpGRELqN8b9JDMtdeb1XJqHR
 6ZLxfWRJ03G4p2benOa52spdJM1vdGA0j9lHi97FnFRmz/f6jJXDeW8MNXRBezDI3Z10
 nZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485136; x=1703089936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXNN33dfwP+H1LAJBjDluPsIT9G/WF8CgOamzzlGClQ=;
 b=t1xo9tMu84IaHtqf5XK1gm1vQOUDnfc6UNOdjJu88aVtSoStTGZLwLQLkpwE+wnV8o
 UcuoMBnV6Vap2xbTzuQpK6nakVxU96sd1fcMpzrIzlHXgS/zwmC80xocRydImqivo9EK
 ydXQ9OpOL7cy5I2ohKMAFVJihlkQMp+P++49C2nYVnsZa35Mql4EamKwVr8rRPDuZtIl
 bUw0XPCvlyD6/eSt4VZ8mCnExAVqx8UmwxV0mGWMZPCNk7ysEqEMKGcYsOCptCtYk/QZ
 046U0MaHBh1VisHdUbd6LvkqIm+ugPGhXI17S4+R68yBEgW/u1n2fZMIEcBeZFHrYZQ7
 D9tA==
X-Gm-Message-State: AOJu0Yy+VEI/9nyoBqr9+CBCb1nJu1jvItd833JhZdCy/UYOBogeiPt2
 WkHibeV9EQ6tt9r67ycSnNmTav+LltmD+wWSARjSFxbB9uk=
X-Google-Smtp-Source: AGHT+IHzFLrnkgA8raJAvZHO9D1DLTIaSbOTFlcktlMxsLdqbBXxz340cRoZkRM6daRCo+x14J7zbTRUg+ZJScVzx5c=
X-Received: by 2002:a17:90a:6345:b0:286:4055:63e0 with SMTP id
 v5-20020a17090a634500b00286405563e0mr14265230pjs.0.1702485136421; Wed, 13 Dec
 2023 08:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20231025230456.7924-1-aford173@gmail.com>
In-Reply-To: <20231025230456.7924-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:32:03 -0300
Message-ID: <CAOMZO5DiFFXKw9UOzKay=tRnLcMD3pRuz9BmtBb_QQ0oMs3Rmg@mail.gmail.com>
Subject: Re: [PATCH 1/5] configs: imx8mp_beacon: Do not set
 SYS_CONSOLE_IS_IN_ENV
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com
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

On Wed, Oct 25, 2023 at 8:05=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The hardware only supports a specific console port, so  remove the
> option to change the console location in the environment.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied all to u-boot-imx next, thanks.
