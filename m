Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20362C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FD987961;
	Thu,  4 Jan 2024 13:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i2rfiWdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2AA87966; Thu,  4 Jan 2024 13:28:40 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FEE3876B2
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cc7d2c1ff0so5222321fa.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704371318; x=1704976118; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/U4gVFOQ2IifrGzPn7/n0N7s8JOQEVeXSojBR9V3HV0=;
 b=i2rfiWdzcx2izMz88KNzHQud1lJvRfT7ekk7yktm2SQzPNDnyd4VB8bQ1FIW8Ko6XD
 sUe8NXJrrCFkZYhQsxgd+4UY8bd2FHWvB6tQrd42LT4k3CFNx2RyqLak2seNFs62yGsD
 l2rv8ii6yxwc1Onzhil9vky+jM2MhZYCcy1hJ+b+E5awM2e/k6XFEIOTtCxD754Ksl2l
 lgdq4awQNV5W6vtBhCsfeLz+oXKAO0qrWIYKiVKkx+1MVWi7STKlhoPe/vZxOVq7QXi5
 IfCsTHmKFGxjTpqTiU4vT4ERc34xRNoKy6iF2r+uQUbMU/zREYPHAvJf5cLbxsXZc1Lr
 Zk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704371318; x=1704976118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/U4gVFOQ2IifrGzPn7/n0N7s8JOQEVeXSojBR9V3HV0=;
 b=hHFbC8TTcVSVoqNXtYHjWkp7e9ujpnXmI2P69h6wkinNBDAoeY8+Dq3I8q5yhj3kx9
 FGpddersnC7YwoVktI2yx62Iw8skynmY1eRBMA+oUUR8dKZt4v2G7XyxJk5xq8GoQc8J
 ylGLdi6SqB96OJwh6OriVZ/dIDxUJIwC9+nasbITCg34Xzbppc72suwaumuYMzcNCKE/
 XnWuTqelaU+cqhZeBjyCj1Z7KdIre3UDkA90K7ZdSdoW9Qo9kQN/SQFCiqV/PE2KKm8K
 iqVAeK2y3QICbrNsitISp+mHOM5a6vsXarPbSsqA+b2oZyafs98sZiAL3mf8P4a/ddo6
 ikhg==
X-Gm-Message-State: AOJu0YyB0A2AxRH4L1eakWqEmrwp+wUJcFKWlMsgf1tvMVRtb0g3HVnS
 vwGUoCqheWbYS6NALIdAzxhfsUptNMtal3lWAWo=
X-Google-Smtp-Source: AGHT+IHW77Zp1gvURyFMg8C2wu4DLnxMQZ7zM5Zs2leWRF06tWtAvEzH1BV4QVSXRhqV+aaTF6oMNvcwxIoG0uJVBnQ=
X-Received: by 2002:a05:6512:239c:b0:50e:7c08:1a55 with SMTP id
 c28-20020a056512239c00b0050e7c081a55mr485481lfv.18.1704371317151; Thu, 04 Jan
 2024 04:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
 <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
 <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
 <7bb9480d-ccd1-4717-8083-b007efd7567e@amd.com>
In-Reply-To: <7bb9480d-ccd1-4717-8083-b007efd7567e@amd.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 4 Jan 2024 20:28:25 +0800
Message-ID: <CAHk0HovT5XbejLHaTdpOTkR=dXhK=Q-GAO+=sXgdvfE4fyTuag@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Michal Simek <michal.simek@amd.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
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

On Thu, Jan 4, 2024 at 8:21=E2=80=AFPM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 1/4/24 13:15, Weizhao Ouyang wrote:
> > On Thu, Jan 4, 2024 at 8:00=E2=80=AFPM Michal Simek <michal.simek@amd.c=
om> wrote:
> >>
> >>
> >>
> >> On 1/4/24 12:46, Weizhao Ouyang wrote:
> >>> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> >>> crashes.
> >>>
> >>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> >>> ---
> >>>    cmd/sf.c | 5 +++--
> >>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/cmd/sf.c b/cmd/sf.c
> >>> index 730996c02b..e3866899f6 100644
> >>> --- a/cmd/sf.c
> >>> +++ b/cmd/sf.c
> >>> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *con=
st argv[])
> >>>        }
> >>>        flash =3D NULL;
> >>>        if (use_dt) {
> >>> -             spi_flash_probe_bus_cs(bus, cs, &new);
> >>> -             flash =3D dev_get_uclass_priv(new);
> >>> +             ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> >>
> >> if (ret)
> >>          return ret;
> >>
> >> don't you want to rather propagate that error?
> >>
> >
> > Well, since the spi_flash is empty, the following code will
> > print the error message and return.
>
> And you return 0 which means everything is fine. But is everything fine i=
n this
> case? Or do you want to see the error?
>
> This is command it means you can simply use && and if previous command su=
cceed
> you can call something else.
>

Hi Michal,

Please check the code that follows this commit snippet:

if (!flash) {
    printf("Failed to initialize SPI flash at %u:%u (error %d)\n",
        bus, cs, ret);
    return 1;
}

it will print the error and return 1 as the return value.

BR,
Weizhao
