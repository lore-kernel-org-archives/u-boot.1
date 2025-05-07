Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B3AC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 13:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20ED681F32;
	Wed,  7 May 2025 15:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KUbu1agp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6E9C8004F; Wed,  7 May 2025 15:01:33 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 827C58212F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 15:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so1186212966b.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746622891; x=1747227691; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiNXlxur2Dh7oN7P4Es0NHzTBV+X3Ml6Cdu3bCSQCe8=;
 b=KUbu1agprcOb6Q0f5VqLBOgPl9FhZDXVOvY8TLnptrd0ziFIYLHaQccuz9rSvAnDGL
 M2aS5Ftwf2zU7krieA3/UjWcLaLTPTaZaeNap4ku96msGdxQNG4mhkn5XNATo7BnZ77m
 F6F+0Q+wItsDuImmYHBEfOIHVwtA+pxaJ3bj4kzvzEX8FqqDcGh0EQ91ktHLMYaz5PYl
 zO6dEBF7PfuvZ2npL1jt2Lv73SFRBfTjOv1f54wl0QzQj/wSmsuM8qxRnRRnRCP3AG3X
 29Yw3NIa+tlMGmeEUOAeX09jrHkSFrymjsHoAjWmvOcRe9pYjak4TecaK11eBno4peFv
 Dd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746622891; x=1747227691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yiNXlxur2Dh7oN7P4Es0NHzTBV+X3Ml6Cdu3bCSQCe8=;
 b=FaOKENvcxcD5g0SxB5dzt1zq+J6LlYCghr9utyPZ9wPWoikXq74VzmPq3ugqxBsOAK
 BXzO8JZkY5loY0IlqZ6mi2MWYwQhsBfD4oVhFBeKfLDWrfmpqhI97p/nwy3vu/I3zClf
 W1poyThh3L9bQgP6UzFZCAcvCxB1jtYuPsyrqhYS/G3XaJ2ViMN/MukYw5a6fQljXT+N
 E0hbeZg0cXzSU4HLDyL2KM5/NhIc4RpM8azVf8DDT286SBGCjAg3T3WqnvjJbtHO8Ls6
 T1G0uAaU9kl/zLem/bWb0OpPCYgz8UK2NRiqtZAm90fN1d48ZgfgpQdnqGgNgxBTrU67
 SStQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUswBGwsJnNtCEN+qfv0mB0HZs8RNOi1kz22Xyar5kEzNEIfpPoKe3+VRNajm3Ohhk/K59KFZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YxpnBAjfviETrA0t4dtet9qFf57hk2S5rfzhom+SC8/TrWZD2Hx
 YaEi9kjGB+4wYi4olTJF6whpDXxPocpHbwlcMNTicJ42YGnvb0YvoS4kf56KXqQtYcHJkP8AhgZ
 aFcB0GAYoP2OsMy79xN3EgeoUZtLsn1Yy
X-Gm-Gg: ASbGncu390KMPtVYSlCPH9DDJceX3TWWKbcHF373wshhOOd/A4v9YQrBv7nxYKgUYSD
 oKuN6xEauvgnp3sPadtwTCZxTIbGBW7U5O29Nhs+2Ok2XLtZPvPYNRI35i9LA3AEDI/FYs6jLKq
 3AohUUss0WXDZ3Cim7RuPr
X-Google-Smtp-Source: AGHT+IG02Z02N2xSddTvR9GvEJOIffjEx/5l5nVWEcqi4ELPqR9OiqScJnw1rud2NTaLP6BPWACNY23H103jmS9hmi4=
X-Received: by 2002:a17:907:2cc6:b0:ace:3ede:9d16 with SMTP id
 a640c23a62f3a-ad1e8b9587bmr328847266b.9.1746622890329; Wed, 07 May 2025
 06:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
 <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
In-Reply-To: <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 7 May 2025 18:31:12 +0530
X-Gm-Features: ATxdqUE0l5vsyzNKgL8uwyW-d7Ikg0-6lIS_zZgvV9ODcVZjJW6RmPTXmkIZfpU
Message-ID: <CANAwSgRMGOxrjuottn+rhU1Z3901LOgX=ktrMh7-HOJZhGaTmg@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: u-boot-amlogic@groups.io, neil.armstrong@linaro.org
Cc: Wayne Schroeder <raz@chewies.net>, u-boot@lists.denx.de, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
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

Hi Wayne,

On Wed, 7 May 2025 at 17:31, Neil Armstrong via groups.io
<neil.armstrong=3Dlinaro.org@groups.io> wrote:
>
> On 05/05/2025 15:12, Wayne Schroeder wrote:
> > If I add the usb reset command, it works reliably at reboot, but it
> > does not work on a fresh power-up with that change.
>
> OK this means there's a dangling resource, Does USB always work within
> U-Boot or it breaks U-Boot and Linux in those cases ?
>
> >
> >
> > On Mon, May 5, 2025 at 2:07=E2=80=AFAM <neil.armstrong@linaro.org> wrot=
e:
> >
> >> I think it's a very long term issue, USB lacks a proper reset at probe=
 on
> >> warm reset, does USB still work from U-Boot after the reboot ?
> >>
>
I wanted to enable CONFIG_USB_ONBOARD_HUB on Odroid platform on u-boot
I think this should help USB hub reset, I'll check this and let you know.

Thanks
-Anand

>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2670): https://groups.io/g/u-boot-amlogic/message/267=
0
> Mute This Topic: https://groups.io/mt/112625435/6056667
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [linux.amoon@gmail.=
com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
