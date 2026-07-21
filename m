Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B2C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E9F980CCD;
	Tue, 21 Jul 2026 15:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShDnV-yAeEya; Tue, 21 Jul 2026 15:32:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69B3080D36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784647963;
	bh=dnz42tK7WH4EO2IaJRsx0pqe46gbjvOwKNFbVo5K+zY=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nmuORsVVAWD3xPQpJEfLULC/+ZWWUvgCoBuNYInVcQ/Mur6KaBVjQPmi1ZMqT12Oz
	 bqhieB2Bj0jOvqFZUbCN7BK/SA68fgRPJKg9HEVjN9DgzImwzHkylBm5X9j09U7Het
	 5XVQbLVNeziTC6rpxaXrw8ACnWNMhfsJc07tBq9hRHBz2zPyfXdxN7OLAsKfMFv/qu
	 KtS1ollhBDcupbmEGrZEd1I4oWVc13ZGNv9P4TWy9Vi/tiYMO9VQFc/+B0sFjtG+LV
	 NJHs1naRtQOkoUaehPVXQO3xfgWXpU4XmNJM0ZC/FMiZLi3ecNX+db9tk146Jq6MDw
	 OB9jK/iD6fqFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69B3080D36;
	Tue, 21 Jul 2026 15:32:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A9B0A313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89CD260843
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QjwgFewd7WlP for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:32:40 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5B7916062C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B7916062C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B7916062C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:32:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0176846A4; Tue, 21 Jul 2026 17:32:38 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 819E8803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 17:32:36 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69e2266b07fso9450959a12.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784647956; cv=none;
 d=google.com; s=arc-20260327;
 b=rlo3078vi9lNT/hCyl/goFzVqFM7G/gE93kqFUYTtkEAEqB4igkDrE9OdHvXlgWBRT
 KsKlAWgN+Npdt43DQBO7Ao3/fcj/srikE96aOWyOPT3YmpL7eJl7cxp4DEwyQQqk7XPp
 XcGgwj2kfAZxQBeh0vlR+CGSCVyE7iFh4WayYzWjWjGA9ks/9qyn1BVlvfFuhSUxwv32
 xBoKzMdIuxr8qDtqnuvFw3voNUzLxP/HF+4NealGmQsLOOgln1F1iaaqkffaPMx2KZX4
 Zrtxu+xaKqS6WfK46cunXCf0PbPLkDJFZLprLL43yDhhBtX6XV/a0XF+jKmP3Ic+/GDk
 Kq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dnz42tK7WH4EO2IaJRsx0pqe46gbjvOwKNFbVo5K+zY=;
 fh=KKqG79PHnrSYl5nHTWBC74wbbL97VYb/Q8O5t+e6clk=;
 b=gcFuoVJ2HZoTbSUfMf/sR4XxLo87jCgrUKrWsN24RuaaRfk48cXsWtPIXs2avgsemF
 xYFc4OebyvFrDjMglW8wdFxpfIusScnKiQJMr1i4ZV73WtOS59OEo3XGT/E9dROffX2f
 PB+BXafAYrpqldY9BVCD8OzCLBEsqWHjf7JP8r0ZEFV3pxy6c7CesPHNXMe51wDjVXqD
 6Mgp7hNFu+Ej9NjgFKLbWjlV4dNDGMqO3Fk8lLtln2/sNN5eevzgz54KisWECPsoVomf
 fwojC8XGICW3qDLhGgWhGigpfqAlkHR0KR2c+b3pheBUZrtHHxS3mH8P2YnSgO1+1bb4
 jaxw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647956; x=1785252756;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dnz42tK7WH4EO2IaJRsx0pqe46gbjvOwKNFbVo5K+zY=;
 b=IvsYMLnVgfHupU2U1ky2BnnfVnEZsW7GSy80pI/n9O7fuHhpEyKYc0wIMBPXoC7/CD
 2T33p6aPwkIGIrlUPsioZEg3vYIXjn5kIEdIJ8viGdmDW2VSpemtHFmRz/k3ccustzVb
 lNEbB7fmmUc6WFty/e2wPl5aJyaWPfqymd4oRk47i2Ne4nSi+ICHzcTeVi0AAkyv93Ev
 XSgRnYgawKwtoeSywNjhVXpEKPBlWEiY30R/PV3N507loFndvqJc6dUKD98LQf39sw/Q
 5dD5iWtLnSJGDSGOHxbrVASXHL1ySzejZt8BlMZvUfZL5KAc+lOMQQNK3acYzPiav0HP
 aIhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVmdrMRLLMtJlnuMOgEoyd6RJsLgGtG0iI6RiDTHpsH0S/B6kKggKuRW6FvnCbXlkk+7F5i8A=@lists.denx.de
X-Gm-Message-State: AOJu0YzKe7XX30JwiDlC3ibW7maAuhLliJRFiozTkhrRdtLNGPKfaE32
 w4Kt2tBCqW2cuiJfGo1fE/rmH1OoSpT1MgfJAdUHiZ3xifDzyGLKHXfX7NAYN+4AwpBb31Gu0KB
 KnrO8QfKY/ik7s9fJ8ZBbD/YKWtHbKiND3oy39f8RUA==
X-Gm-Gg: AR+sD10nXbHntuoqAua21jZOE4VMacN6d9vdgKwvlwEV9mSHGJ4XJ2WvFfY+gd7CZEE
 Rwn4fp34bgwJdvo8Sy7moHJSd6uXTkI5805EnWpnzhbZ269k4P+k8+7sIZFJQMDEYt8n7doAnJG
 RBkOt1DAnvIPQ7yiRUUeWsfoYsSStOehDMSRDUInZffqftxLpsxS34NPJH748N9oQufPZE5/UQU
 HiWY2+f/mSt6id2THfTw4tkpFrUzoz1QC9mu0Y/iq/zNmt/2pbdvS55o+D3mAUS5DoTRSmqm24/
 U8xKQf0iOPwSxB8Lvg==
X-Received: by 2002:a17:906:fd82:b0:c15:f4bb:e663 with SMTP id
 a640c23a62f3a-c16b469ac2cmr838828066b.10.1784647955764; Tue, 21 Jul 2026
 08:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
 <13650571778172129@c82c52a0-4efd-47b9-b2a9-5a9057476b1d>
 <CAKTNdwG-Keu5Gf9EA5TUw7mG-KGBLumOco54Gm=iRM2Oif-F7w@mail.gmail.com>
 <1e9104cd-2ccf-473d-a510-b1188aca5617@cherry.de>
 <fd7c7076-568c-4186-b37b-0b3783f5de5c@cherry.de>
In-Reply-To: <fd7c7076-568c-4186-b37b-0b3783f5de5c@cherry.de>
Date: Tue, 21 Jul 2026 19:32:24 +0400
X-Gm-Features: AUfX_mwqoj9V8XXGlfvQoyKwLdh4tQ7upAAa0GDIpx1qA4pRTDDZEuM6HQ9304k
Message-ID: <CAKTNdwGJCHHzXqztAiVnCpHno3Ta9=O4+tgG2zUcLqtct=KCdQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anton Burticica <mouse@ya.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784647956; x=1785252756; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dnz42tK7WH4EO2IaJRsx0pqe46gbjvOwKNFbVo5K+zY=;
 b=yRUnHrZQhfe/zmHz3hfV66ViW/HkGHlqv9tyqRkFXgISUYe2j+AxWVFZ8LQNFRtMGa
 1i7cEmy4e+fH06odlmTAEhQMBAXg7HXxpNZx81mNP6qpqcLy0/lo1L3jnLRwrapMCwsN
 sWqVse6f/M8JQwfSaqLBsopJWEknuTPdquNrTTtw2WaaxX/FtgXSMMuLPoGmunHsEyI5
 aglT5L+iqWd/96TqefMZCV9yjQ8t69mhJK4DVo/o6dkR/l41NWKJFndSCS6Rc+m5byOX
 fYTxJWH+kbqPuDL9M1v0qIoPkVxVCRkir2KZ/zBi+8OG9JGyX3Ou0mcZz8xRuZh9OxJf
 6DPw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=yRUnHrZQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="yRUnHrZQ"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Alexey Charkov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Alexey Charkov <alchark@flipper.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Tue, Jul 21, 2026 at 7:23=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 5/8/26 4:59 PM, Quentin Schulz wrote:
> > Hi Alexey,
> >
> > On 5/8/26 10:21 AM, Alexey Charkov wrote:
> >> On Thu, May 7, 2026 at 8:48=E2=80=AFPM Anton Burticica <mouse@ya.ru> w=
rote:
> >>>
> >>> The original idea was to _not_ disable USB3 OTG port when booted from
> >>> USB:
> >>>
> >>> https://eur02.safelinks.protection.outlook.com/?
> >>> url=3Dhttps%3A%2F%2Fgithub.com%2Fflipperdevices%2Fu-
> >>> boot%2Fpull%2F20%2Fchanges&data=3D05%7C02%7Cquentin.schulz%40cherry.d=
e%7C2646189b068342c152fe08dead126988%7C5e0e1b5221b54e7b83bb514ec460677e%7C0=
%7C0%7C639138491747796890%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsI=
lYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%=
7C%7C&sdata=3DxX4POW%2Be7JMSMo1g2aYdZekD5qwLAuXTtSyRuD6QVlY%3D&reserved=3D0
> >>
> >> Hi Anton, thanks for the context!
> >>
> >> It seems, however, that the minimal change out of your original pull
> >> request which fixes the observed initialization issue is just the
> >> assertion of the reset line. The rest may be helpful but is apparently
> >> not directly relevant to what I'm trying to fix here - thus the
> >> significantly trimmed down patch body compared to your original
> >> version (one change at a time).
> >>
> >>> There is a possibility that with already running analogue blocks,
> >>> disabling the port will leave the controller in some weird state and
> >>> it's not possible to fully reset it via exposed reset lanes without
> >>> full SoC reset.
> >>
> >> Could be. However, having a different initial hardware state by the
> >> time the driver loads, depending on the original bootsource, sounds
> >> like future pain.
> >>
> >> The Linux driver(s) also seem to be able to properly reinitialize the
> >> relevant hardware blocks regardless of where the boot ROM and U-boot
> >> left them, so I don't think we are dealing with a case of
> >> "unrecoverable weird state requiring full SoC reset". We just need to
> >> figure out what we are missing here, out of the substantial difference
> >> between the two codebases.
> >>
> >
> > There's an attempt at synchronizing the codebase with Linux v6.16-rc7,
> > see https://eur02.safelinks.protection.outlook.com/?
> > url=3Dhttps%3A%2F%2Flore.kernel.org%2Fu-boot%2F20260507092843.358908-1-
> > jens.wiklander%40linaro.org%2F&data=3D05%7C02%7Cquentin.schulz%40cherry=
.de%7C2646189b068342c152fe08dead126988%7C5e0e1b5221b54e7b83bb514ec460677e%7=
C0%7C0%7C639138491747835058%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWU=
sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7=
C%7C%7C&sdata=3DbrdZsVC2x7KFqDMx5h476YybGJP0hEVubzQIixpSPjY%3D&reserved=3D0=
. Maybe this is something you could give a try and see if it makes things b=
ehave any different?
> >
>
> Just to let you know I have marked this as "Changes requested" in
> patchwork. Please send a v2 once the DWC syncing has happened if the
> issue still happens (and maybe help with the effort if you can in some
> ways). I'll not monitor this patch here anymore.

This patch becomes unnecessary if/when the DWC sync lands (confirmed
on my RK3576 setup). I tested an early version of that and provided my
Tested-by along with a link back to this issue, but Marek was
skeptical about attaching the T-b to individual commits (given that
they can't be tested individually by construction) so those were
dropped in later iterations :)

Even if the DWC sync doesn't end up being applied, the better fix
(which I'm currently carrying in my local tree) is changing the
ordering of reset vs. phy probe in the DWC init function, rather than
a platform-specific change like this one.

Best regards,
Alexey
