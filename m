Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBA5CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF538460E;
	Thu, 18 Jun 2026 17:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bx/oHYs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1FE848EB; Thu, 18 Jun 2026 17:08:38 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6939D8063E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-695427c153fso1421270a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795316; cv=none;
 d=google.com; s=arc-20240605;
 b=ShgAyVUf3yHBOzQ1ignzRnfjaHAjE3Plg5R9IwgKIJ4bZR5/AViJw8O+C860TUdNzt
 WWaB9fWZVMa1hwnXhOCHff81C/Qr1XqOg3TYA7zm6smcP3M6E0/XnkFzvB3ZA2qRItV0
 c+N7rJbgyv3gVKKtDHUhT0B2xGFhNTKkVBvPzCk1obWzYR+2LzpEsKNhtGhpLIvGcHjj
 x8dqXVzrePI6M7EjAiYk4GvutwcWJFleyMZZhXG+yB333RfAmzj6jL5Z0pPpGY/LjfsF
 gr8c5UEVqnmFPh/n/4BTSVvCQef8+ZFlD4aA1OLLhU9iq90In+nJCyaY/G7nAI3OwvK4
 Atdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZkBk65jbLw/slfBaUDcBoGTgxtHHgewg/YSq1i2Hy0w=;
 fh=GQyKwPRr8dOXk65gAXuiKSXcuQM8h6Aog4njpiF9nLE=;
 b=QDS9CzWniT8BB1Ks4EoyxgSy6v3sPIgYb4Q8wypkbm9xfUIGS5+1UfTjXofayr/uuo
 NgBGltDy3yPX0PzXES+k/veO6xAMGHYGhuynC7FoIBRcZ6BzBc2mxlyyjr7BlmsyQgbn
 EwKWiKNpXVVBAui6vWEQ394s9BlN+WCyOmLv3eZv87+YmMDWSvcpqVgqdWkY5DzOcUme
 NZ6uOHVsPQzBZHCLIDVDqLtPm8MMXRzB7ZUYkN3St1a1zFU89IOctPh7YkLhVzEc8d6n
 UrL7bz7u+lSj2E/j871p1Ch4rF5tenWVs54YD5lv1E3ai1RoSVSBfNqpDzoxbmA+AUdQ
 KLNA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795316; x=1782400116; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkBk65jbLw/slfBaUDcBoGTgxtHHgewg/YSq1i2Hy0w=;
 b=bx/oHYs2ms3PGI5WpPSe+nRPvUBlgeqkh4Mv72tciQMbaaOhI3S1XMBjE15dTH9TPO
 ZPnuYuGmH7DIRKnKa4710GiCwzfcWoXLhPOih7Uy/dMLccKnZjEZFtQaQ/eqkcm/OcsH
 OCPw6KiGhBLgo9ACDK7a1UhCvsciCZ5nYnL4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795316; x=1782400116;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZkBk65jbLw/slfBaUDcBoGTgxtHHgewg/YSq1i2Hy0w=;
 b=BlA3h50veElJZCKXwDxnBaF3/9pb+s6PWJ+Fe5FLFNgmWahfRwB8+Kwlwmsiq/wXJ+
 W6ZKs/MR30OBFpPtydv/jIgSYluk+dJwk4nwfwGyBSkVXKdxPTThlU31j0eNi2qxpYc8
 H7LIu/Ut6SFFBqg4TefwSnaFyNVM/6O1xlOhwdKAVCaPsCxtiHhOC6fWdVQ/D7l2dWrt
 vkNMGwraMkVClnHUsJYGKntjzfA+G1Vzu52zWjXkZJCEnLoVPZDhh1gq/iSyMCDqSESa
 jH7+YkZQKkF0sgYCsgAQAIoEuyuYXGCV7oElM+HGGQtB2gKwvHEQ2/cdtH7vrUiV+Hj1
 T4qg==
X-Gm-Message-State: AOJu0Yx0vzmEoyf8GUbcZazLuglXxiX7kznbr62QiVOHDuLnA+R161gu
 w99z8jswewfPOZUK6LGb8Lc+uxe6LmyTQiqBw1GbhAfRBMGPruaiJboRSBNsjAZ76lErPUhs96n
 qkhpg0T6/xZzGuXRtBqIc4YuYuQ4Qyo5HdKFpec8V9IqnDjtJNhOTA8wK
X-Gm-Gg: AfdE7cmDOqYtaQ8/HRRHNuQmkKPutTCdLSeKxUT3p9VCG7pwnDh0aFdd/HOYSrxAa7w
 InmxvnDbVzFiNu5nWx66ahDGVSmrTFK/Pb9GqG7VA8SfavBfe/arlHTJTid0KmEY1zCWa/R9wev
 in0xhZ5hCOUNi5sjx+EizD2CenaIsxexQFEFZzRjw+hIKeJgn16U9YZ6lcFPBCdZWDjYa2EP/PN
 9l+3+M2BSR/ZySTCAeXKOQEPwhQFe65WWIYHxQZB6fdJCWZLraO38wRbXALpYY7Bj/j+DUzHg==
X-Received: by 2002:a05:6402:4485:b0:68f:cc95:8c11 with SMTP id
 4fb4d7f45d1cf-69547450050mr4982202a12.28.1781795315769; Thu, 18 Jun 2026
 08:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
In-Reply-To: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:08:23 +0100
X-Gm-Features: AVVi8CfPTPUmDMsDMerOYJ_YmD8TZ4Loc1EfJoQM_6rqt7nsUR3RGplHlNJYvt4
Message-ID: <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Wed, 3 Jun 2026 at 06:06, Simon Glass <sjg@chromium.org> wrote:
>
> Dear U-Boot Contributors,
>
> I would like to introduce the U-Boot Concept tree along with a few though=
ts on its role in U-Boot.
>
> By way of background, I have been a contributor for about 15 years - arou=
nd 10k commits and countless reviews. I have introduced many innovations in=
to the project: e.g. sandbox, device tree, C test infrastructure, Binman, s=
tandard boot. Of course I could not have done any of this without the U-Boo=
t community (nor would there be any point).
>
> As the U-Boot project has matured, the demands for mainline stability and=
 rigorous review have created a natural friction for landing complex, large=
-scale feature and refactoring series at the necessary pace. This structura=
l reality, which has slowed the adoption of ambitious efforts like bootstd,=
 VBE, xPL [1], and CI-connected hardware labs, is what the Concept tree is =
designed to alleviate.
>
> I strongly believe that projects must evolve in order to stay relevant in=
 the long term. This includes code-refactoring, new features and subsystems=
, along with migration of old code to use them.  A look back at the U-Boot =
of 2010 shows how far the project has come. I don't think anyone would stil=
l be using U-Boot if it had not evolved.
>
> I have set up a 'Concept' tree, a possible future for U-Boot, as a way to=
 regain the old pace of innovation. This environment is a proving ground fo=
r new features where we maintain a lower bar for risk tolerance and complet=
eness. We will accept partial and speculative features, provided the underl=
ying code remains robust and of high quality, with the shared understanding=
 that features may be dropped if they do not prove beneficial.
>
> Another difference is AI. I believe that AI is the next step on from comp=
ilers, which also took a long time to produce good code and find acceptance=
. The Concept tree welcomes (and encourages) high-quality AI contributions =
and reviews. It accepts PRs and allows reviews on PRs or the mailing list. =
It relies 99% on automated tests (sandbox, QEMU and labs) so sets a high ba=
r for testing. It uses a separate Gitlab instance for now and of course use=
s a separate mailing list and Patchwork project to avoid cluttering the mai=
n list. Concept runs an AI-powered cherry-picker so that it keeps up with m=
ainline. In no sense is it operated as a fork.
>
> Once features are landed and functional in Concept I hope that many will =
find their way to mainline, although inevitably some rework will be needed.
>
> I recognise that introducing a new 'Concept' tree might initially cause c=
onfusion or concern. This is an invitation to work together to define its r=
ole. I welcome all feedback - positive or negative - here on the mailing li=
st, privately, or on irc. Let=E2=80=99s discuss how this initiative can hel=
p U-Boot remain the defining firmware for the 2030s.
>
> [1]  https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3DieT2o=
aHfgLf3_nC+xXA9g@mail.gmail.com/

Just to report that after some brief discussions, we have agreed on a
path forward here (thank you Peter!).

Concept will become a custodian tree in U-Boot's Gitlab instance. I
will run it, with access to my hardware lab. It will cherry-pick from
mainline and accept code through its own channels (PRs and separate
mailing list + patchwork). When features are ready for mainline, I
will send patches to the main list for review in the normal way.

I have been working to migrate things off u-boot.org (lab, gitlab,
blog... and email). I am transferring u-boot.org to the SFC once this
is finished in the next few days. If we do end up setting up email
addresses for people on u-boot.org, I'd appreciate keeping sjg@

Tom, Neil Peter, please can you ack this to confirm you are happy with it?

>
> Concept tree:
>                        :
>                        ::
>                      ...:::.
>                  ::  :. -
>            .   ::::::-  - ::. ..
>           .:: .:      -=3D=3D  =3D.:.
>         ::.- ::::. ::. :=3D:. ::::
>   ::. ::   =3D..  :.-::: =3D:
>     .:-:-. -.::  ::=3D-:=3D:
>   ::::::=3D.  -.::   =3D=3D=3D:       ::.
>     ::.:::=3D::=3D:   -=3D=3D=3D:--=3D=3D-::--::
>       :.    :-=3D-.:=3D=3D:.   .:  ::
>                =3D=3D=3D:       ::  :
>                =3D=3D:
>                =3D=3D
>               :=3D=3D
>               -=3D=3D:
>               -+=3D:
>               =3D++=3D.
>              .-=3D=3D=3D:

Regards,
Simon
