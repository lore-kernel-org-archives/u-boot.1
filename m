Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE5EC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 227D460A9D;
	Fri,  7 Aug 2026 14:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJouR89UYRSL; Fri,  7 Aug 2026 14:18:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B81260A7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112292;
	bh=ou2z+aTJstDjXpoQHm42LR2QaDK9YPuYwKi9UPLdAQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3OX8rLN/Esc8kq9EB6lT7agSJQSfO5qstOU/Uxi1OJxJATviQ+1mxZw2OcyT162/
	 iiw+B/FwKDPmrhX0iruNHVMsx9capAPBAdMTdYczU46XlV+Xhr505irMgA34BSn+Xl
	 ZAmHlie1LSgHVxT3PY6/30ixD0htl+/jnscm2F+WWSExsC8h6DSy7SZgKvtDekrkYM
	 O+58c23NSB57It3KL2AuiswFL+BbxpPp67B+MtPbtWpPHIvyqfFBnfSRs8L7FWa26T
	 R2OlU7DH7U8dVJELhe06QWsfc+dD23qaAZg2XYbNPJ3f6gFdAKd9QkHs2hp3TFI7mO
	 BgoMLwESb27lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B81260A7B;
	Fri,  7 Aug 2026 14:18:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 71090270
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 07:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62E6B608B4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 07:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R6cnAq1aekwy for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 07:38:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3EC89608B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EC89608B1
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EC89608B1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 07:38:07 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c160420289bso431681266b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 00:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786088285; cv=none;
 d=google.com; s=arc-20260327;
 b=XpzdcbTd1o62YF7FjqW1VYYB/hVKbk/sevfV17ZsU4lOUWdbQM26hTTStYSP5y8t9A
 +m5dFAb6/3HHuxI8UEqHgCeMPpkLmMTOWV7A4uMDa2eLV5Rhu9QwmclewnfaU5Uqajbl
 k3uDGRcifmjO2atNqQV6sg6zoGh+BY5BB5p24jGOr/Qq2y7o7pC0pk+a6EhEnTgdoLW0
 6PJZwZweUzYsvNsXqPnCH3YnI+lK+sURLfm7J38VqatKcRD48C6r/Qad6o3h2cqtgJeS
 jBenJJ4yd6J0FHhPwj3pMC9UiO7ntBhg3fqAt6PYrfpQU4jgBwNViBCGNJ5rbW0dqH0X
 Dc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ou2z+aTJstDjXpoQHm42LR2QaDK9YPuYwKi9UPLdAQ8=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=itLAZ4fG1zpGtbNWkJoaQWqBLi+FkRDDachoXez4HpqX7Y2hUAB11PISjKTu/bbOr2
 fbgPg60KlLxPtUa25a3nwm7fb+uOKSYFgB8igBIps5PQwm8jaPbbDKnCoGL7N4qJpUOR
 0XFbUyDN3j/F1xvG2OkQjEtX+v+Kp7+4v+8EBQb2yj8H52Lk8hR6LdzDc5glXLfi4Je8
 zqkZZG3VE0yIyJ5QU49IdzO0P6VOQyzzxKeZmd1tcrOD/9TX4bKcOVU3B3iIeNfE9Fo/
 FEmT4uAIL14dMwKp6favT2gMLh2doqHGPjeTpAM6LCD1VcsrsiKV6vlqxsqjwhSkVvty
 NL0A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786088285; x=1786693085;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ou2z+aTJstDjXpoQHm42LR2QaDK9YPuYwKi9UPLdAQ8=;
 b=YYib9djo677Snf8ePYTZ0w3JwLIAc6OnF/XB3B8nUqromNbVhNOEC7OZ+etdF1hKUX
 6zg9TAXKhrztQzKiatORuhQ79EY+2FhC4Wb2dlB5EmhgEhuPYiwhWQT1+U0+1zcgpEzR
 DC7G8X7w9ykczIiNtSiJyBKt96DJdZsinp1tA7WPUY2CA/qZ2om+NleEwsSBX2wRKgQN
 PUgKi4aFE/mmlQ0k3fnPpsf5eXbU8auj268JkdS3pu32pKvb/zNOy1d4eST+pDh57JxF
 /P+tFW8uT2e9OtB1gyVVgJ3triv9SoIzJ4oG3opP0IfyL9BIsZMVkLi29kHjOHAbSeOt
 Sv1Q==
X-Gm-Message-State: AOJu0YyLOX0uxjsMZoDnzy5mG0U3eTkzbwG0T3MjWnlyZPCcgDz/0pQF
 Nn+ouVlty1ppzKUaL8CAoZe+g1jLA4Rv9DjCLgoDqj9Y1MQNMubtq6yVD2sLUaukj4adShZp234
 kwpZ+laCD4rl7Hx9c7YWcJUgsMTnmtSkwxwo5NtRsmQ==
X-Gm-Gg: AR+sD12Sm4f8Hvd9gC7VzVRni0sCQcSw6i+A22yhRcPFLOZE5OwUGC/efbC5Hc2y7cp
 Tax5RlRlr3Oaj5Sep/yxoBs7wAUX/QwRnTN530VuJ6ky5XBFVo+jO9+6391bw93E0ZzNKSMxqTI
 NEpyF+lY22fMfzUhysDivSfkArMpIoCh6ge0QbCBuJ+xRkT1N6XueUYYMcE1qYoLfi+HAX5YMx6
 9Js5gn9ypTWaF5bboaxU2biei9hYixj5WiN89jmpkJQjML0x4Q8zR2eeLnxdFHmg5lL1inUqz+s
 9cpBblR1mv44rdCK/gE/z08pA94aLLJhCKfh2dT5s7htAPzfzsXuF4WEt098t2uf7i7jdYUnpEM
 =
X-Received: by 2002:a17:907:9344:b0:c16:5ae4:77a3 with SMTP id
 a640c23a62f3a-c2039d1cadbmr989523266b.25.1786088285011; Fri, 07 Aug 2026
 00:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
 <CAFLszTiAP1Bib=Xpg-OK=x=pJCuG=N8f_bnxE7dv=YdM4x2ZOQ@mail.gmail.com>
 <CAKTNdwHaxhnCy22VPMNnGo9Z=p3DF6zmQ8ixR-EsOpb9crO=Dw@mail.gmail.com>
In-Reply-To: <CAKTNdwHaxhnCy22VPMNnGo9Z=p3DF6zmQ8ixR-EsOpb9crO=Dw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 7 Aug 2026 11:37:56 +0400
X-Gm-Features: AUfX_mxiVpcSXmyH7jlaprZgL2QSiCN9stcJUh_wcJHtgGLIz5X2sj57putraQ4
Message-ID: <CAKTNdwE1xG8d_x3KH6v5bQfWB_QQ1b6sHWxagz1JZ2GDyVOtgQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] spl: Decide about Falcon mode boot only once
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Aug 2026 14:18:09 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1786088285; x=1786693085;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ou2z+aTJstDjXpoQHm42LR2QaDK9YPuYwKi9UPLdAQ8=;
 b=nMp6Pyjeu9WUVZQaCwF3x7fhPGDBq3GanO248DtGJX6tN4qZ0E8UNEp9Y92WLW0QQz
 uVn1GZdmDLhuMtVRJ4Z434whPUcUUvBxG57Ia4neygfk0WR1MWrFy3eU/B8ER5jihiuH
 LBu7ktEeWaX/scLqnXO9NzOhDfhnsTcZDMUDqIkRn6pmnBR0suS106DiPjzuEGoj3/uv
 A/sF9buUuE7B+BRqwDlcKb1rIz8gImPtI6hrybb3N2vcm6wHsZ7HgEdKhXRee6qgbXB2
 /xGpnymijTnNe5XZ2y5WCByuZGEar4uqEi/2F/XqNHT1wHPOisFmLNlsnmLFOC9cJyWQ
 BGfA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=nMp6Pyje
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On Tue, Aug 4, 2026 at 5:29=E2=80=AFPM Alexey Charkov <alchark@flipper.net>=
 wrote:
>
> Hi Simon,
>
> On Tue, Aug 4, 2026 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Alexey,
> >
> > On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
[...]
> > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > @@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
> > > +bool spl_falcon_boot(void)
> > > +{
> > > +     static int falcon =3D -1;
> >
> > Minor - since the return type is bool, I'd find it cleaner to use two
> > bools (result and 'decided'), or an enum, rather than overloading an
> > int with a -1 sentinel. It also keeps the value out of .data, which
> > matters a little in SPL.
>
> Sounds good, will adjust in the next version.

Interestingly, the conversion to two bools on .bss turns out to be
heavyweight enough to push the am335x_evm SPL image 8 bytes over its
SRAM size [1]. The .data section shrinks by 3 bytes, but the .text
section grows by 16 bytes compared to my v2 version, and it no longer
fits :)

I'm now thinking if it would make more sense to have the spl_atf
handover function skip looking into the FIT contents and just trust
that the loader selected the right one based on a one-off
spl_start_uboot() reading - then I could skip the caching helper and
wouldn't need to add any new global state, so there should not be any
size impact. An edge case here would be a FIT containing BOTH a Linux
kernel and a U-Boot proper (nothing technically prevents that, even
though the binman template I'm adding as part of this series doesn't
do that). There won't be any way to select which one to pick from the
FIT at runtime anymore.

Or somehow make the caching helper only apply to SPL_ATF devices
(am335x_evm isn't one), although that sounds a bit cludgy.

Any thoughts welcome!

[1] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/job=
s/62374

Best regards,
Alexey
