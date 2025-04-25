Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75607C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 02:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31688082A;
	Fri, 25 Apr 2025 04:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYl/lHFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3292E810EB; Fri, 25 Apr 2025 04:37:26 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F308059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b12b984e791so1534375a12.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745548642; x=1746153442; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsX/36X2+5pqUYiMythjZEqOjmPD8juTe+CHkYj4oa4=;
 b=DYl/lHFASgfXlqM0wzR63Js+pXLZ66v0sh8GkIPRW+lQspcyoUSSt/pMrLZqF+edQm
 uHG0IvX+JIwqXuP2MMB4fd86oXxTJpPV5syDc7/Z9OXQmZ90G8BG7JqGRXsB4qJgrnMm
 ATTDIqYpk831TXAGj0aeIuAGY58ukagnMjTFV2dCNfsXYKyaANyGQXvPT3JyP8+g7fiF
 AuIHIaOG33RAhHRwJZckyAr/1M1DPFewNJDprdwUDsnWWmr6/t/rfYMaCYVzjKnSBId6
 sq7lnet43lyFRRV80cKxt1U3TeWrv26w2NbIIng4FzJZQhhA7rdc/0vFI38gimqiBjvr
 SfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745548642; x=1746153442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsX/36X2+5pqUYiMythjZEqOjmPD8juTe+CHkYj4oa4=;
 b=oFnQ08Cy7mWUE+mND/7T024N5yJI5/Ir9FDNtfYFNMtlueZL0tC06H2/1VIxAd5GLh
 LGLf6M3yCWPqZj/HMwK0ie/gVEnc27RH9Y3ssWwqxO4UtIGSFZD+JufIKul+hZDhrLD0
 I3lA6vcQc+uvM+Y0H5yKmjRZ2boo+RRv3knt3iAY8eVIi60p54/Q/+rB8UudMaxXd7UV
 CqAjW2TVqq26SO72DmV6iK/ILIhNn0NGPhBZWfuwJofG+mWMS6TqClmozTw/A4J4rO0J
 Ur4HFDFpePNWGOIzhJHFrUwVy8EvHXuHFxA/lN8aO3gK3Mf+hnivfegnfcUh47CLoORM
 CdGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3H13fbfSZ/Vp+RQaVyIvP/1hJ9ZIupPjt2qZCN5fFC5Hle6yM6dxWpNzKTuF54UAuDK+vfE=@lists.denx.de
X-Gm-Message-State: AOJu0YzjHPa1FyQuGK7rF2EddRvNEcE0Y5cUYk91+0EV8DqsZp55T2Wf
 CUHZqd43RySqU3x2Bl3L90X+MM1q7j71kpfvVmjJtpihVsx5gV4YdpJE9DrhBNwg6PH8DUdKPKq
 xoIDlHcssYq1FWqF0J0MWCPplVL0=
X-Gm-Gg: ASbGncu6XzZwP0rSIxjq6aZdDG3LnPQjfP4hOUpPLa943mDa8cO/o1LFDs1bVy+T/Vt
 ekvV9PEJ6Y4LGkw0qrL/dxMFLGsGzY+pPeJ0VppR5zlQV2aYLRlEGDY/vqazwbsM1LXTRKaFYyg
 fISCnyJizc6KnKzM+VmrMOyQ==
X-Google-Smtp-Source: AGHT+IGjiYUMCI7omSnxU6i/RaA3SuASmV9SY1rUkGgHiRpiEnOD6HAZ9GywQ7bDl+0U8bR6cOSMbhKgbLkjUYOR98g=
X-Received: by 2002:a17:90b:586d:b0:2ff:62f3:5b31 with SMTP id
 98e67ed59e1d1-309f7ebf8c4mr1088937a91.29.1745548642405; Thu, 24 Apr 2025
 19:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
 <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
 <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
In-Reply-To: <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 24 Apr 2025 21:37:11 -0500
X-Gm-Features: ATxdqUF82WBUicfUvLA7iHclfTqIE6kiNx_AUk_svVUmbMkzVLzRiLC6csxpPs4
Message-ID: <CAHCN7xK_6QdG91dC_FnZbvnZTONYKKt2qSeLb4ruORw4epG+0A@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Apr 24, 2025 at 9:35=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Thu, Apr 24, 2025 at 11:20=E2=80=AFPM Marek Vasut <marex@denx.de> wrot=
e:
>
> > Probably some timeout in the esdhc driver, maybe some clock are not
> > enabled ? I don't see it on the MX8MP.
>
> Same here. I didn't see this error on an imx8mp-evk.

If memory serves, I thought SPL used the Boot ROM on Plus and Nano to
load U-Boot where the Mini has an older boot ROM and required more
driver initialization.

I could be wrong.  I'll try to test my Mini this weekend.

adam
>
> >
> > Did you already apply
> > Re: [PATCH] clk: imx: Finish converting clock-osc-24 back to osc_24
>
> Yes, I applied this one locally, but it didn't make a difference.
>
> I haven't had a chance to debug this issue yet.
