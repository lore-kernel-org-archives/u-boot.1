Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3231EF94CBC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8770583936;
	Wed, 22 Apr 2026 04:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DtOp5uRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788CA83FED; Wed, 22 Apr 2026 00:42:55 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6479839D5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so869838866b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811371; cv=none;
 d=google.com; s=arc-20240605;
 b=KILquRT7nUwgGFJVmyG8ejA8Lf1ypT4A0tlH81dnc6Tgti/muigGEx6mRU8RL7049g
 TSwwwreK6ITF5LTIKEeNVgTbWJvRA1JfsTBjzumbYM+iVxPudkyWI/boSy4zhrwgqJ49
 R3Q5wbEASRlRRLqhnrB0UAGJkvSmXvI9rgQ6Mlnd31G2aEDV2CV1y5YuEmethysy0gi9
 QVnA4TvZwtkcZtvOEfIWLg3WSBSzulR+/xL+W5haJMrr0e3f5elDefGexpVOGO5WqY56
 UPJXII7PZnHIoP+KLNM6Ijm8P0iZXn136yRgp04ATJvUg5U5DmS0h2LPMxch24a1O/3Q
 mgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9rmZpHh4Vh3tkU/FHj4lOq9bOGUiD7f6f6ViJT+F7pI=;
 fh=y7nMaG+Z9eq5yB5CqAoZCLiMIM5ZLRxZQQigLqm0wnk=;
 b=WTt8XBZiFC2OoAauWWg8Qr8/QvEfCWf06ErsM3B6jUJ0f2PkyK9dk0ftmO6biW4VIc
 2SONlrXKbyIZAF/jCOSeWZ11dZH3ztUIKajp/pNSAVsUFR6bN0H6vLXSIbiaD8g18OKO
 3lIBNW5EjtFrqFiBDETBauseLi2y/0XC2E52fkP7dtyMmHF/ixeqOaxWkTynyojqH6+s
 YbOQLiwQWSiG1hWEfPXRw43dZjvUi8T8eIFEtM82rvzmm49Q7CjzVB9qSUXn0T4qSDzM
 h76G3HDWjtM04udVQPxn4YRilEeS6akwNwK8gWECqsE+nGew7YMRn34drPTR5pd/zqrd
 5dvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811371; x=1777416171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9rmZpHh4Vh3tkU/FHj4lOq9bOGUiD7f6f6ViJT+F7pI=;
 b=DtOp5uRWSWiadpAmAteJHexLYEFqhMyV0Jr6F74ALIlNLeJ9poJ7kE+vNmS87fH0ao
 e9VTw5aSxHjKwQOtpl4IU40PmAyQDQjZISMLy9krCvjKi3D6iTpLhXdckrTGyiT8WpKz
 +M5JXK2dpkfJFZUnbKGc6GWj7XFfvjzHDVams=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811371; x=1777416171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rmZpHh4Vh3tkU/FHj4lOq9bOGUiD7f6f6ViJT+F7pI=;
 b=lKGZc0mHAPkH10PPs8E2ndLDI5TbPZ8350/KT7hdlMlWB7iI4DBNKIUVsCoSx71D/G
 GFMM/j3I2RLtDOcfXjEove6K1tfFWfdV1F5Ztc/vtb5yOEZ7kDtm5/mlPMOfmTTpbvpC
 SUP6qOmW/mgvruRbYRevYRGr75cLY0KXZ/rMe3Jjqkq36DiJ+i4c2g3OudOfV3RZsosh
 pJZvYlIeWiVSdxtUbPzJmqxDHWx79r6QAv3vDeSUwZHmO8NRS72Zfcg+SQMFeU2CYHYD
 SKV9LQc3ZnMokmZRTb7EFz6shO6IYehP+a8PSSq8jF0thnYs2SulprWla07/Yv8jOR8Z
 pAZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TjoKcFk536SaR81wCHWR+nyxbaoJNq/Ml2n/z1vCKUBKZ4QSChiHd885KYV9BDWE4hJNNV7A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5kklWTaxQYeeMywD4qXiTIVYAjAP7XIjtljn/ah9KOKZbTlmD
 35kJuNKx+1/CmM8paK9JELfiA4x7Kq+wpmOVMu6FJzF+0by7nvYAWKcnze7LKxOe3TyUnPt7ewt
 NfCW+78CkXOeZXiNRMTS64wgKKbZFjj9t9oT/ZgiB
X-Gm-Gg: AeBDiesN7gGD7WNmqlSMycUKiVnQupNO5qANhZFtw9xpZLKxRrw0Iokz8MmSwn2lGO4
 4uAQT/Cc3All5dxLppqp5moYvj4uYu1bjYhH3sAdBF15CRWLMjB/uHr9vgVoECv/vi2aR2kYUT2
 gykKTs5xAXgjydhDlFgqyzp83l5QgBdK27ZJiSYu/kowj9iVLC6GrUWMwP05JxHin5o10pqNxy1
 Ta2k6J4zJdhwSiIAWdmbGENhS1nUzTmvVi0nB2DipD3Bn6+ciSy3vPrHnTPp19eMuzh3D7YeI4P
 RKFFWehgSalGE+z3bTgr
X-Received: by 2002:a17:906:7950:b0:ba7:1191:6402 with SMTP id
 a640c23a62f3a-ba711a0ae21mr625797966b.27.1776811370402; Tue, 21 Apr 2026
 15:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-2-9900002d8e72@cherry.de>
 <CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com>
 <9ced2644-d3ff-49d5-a524-5439f9ca4831@cherry.de>
In-Reply-To: <9ced2644-d3ff-49d5-a524-5439f9ca4831@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:42:37 +1200
X-Gm-Features: AQROBzCz0okK9N5nAdgk3AOs3EhEwwxF9Pd_71s2RH_yPMfi0Na1OS6DnLqD8Oo
Message-ID: <CAFLszTg4ZeeFWkqXoOcqpEmEFTx2Z1EEicgQUx0GbO4x7fu-bg@mail.gmail.com>
Subject: Re: [PATCH 2/6] rename NET to NET_LEGACY
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: foss+uboot@0leil.net, u-boot@lists.denx.de, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Udit Kumar <u-kumar1@ti.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Adam Ford <aford173@gmail.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Stefan Roese <sr@denx.de>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Anshul Dalal <anshuld@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, David Lechner <dlechner@baylibre.com>, 
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Beiyan Yun <root@infi.wang>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Sean Edmond <seanedmond@microsoft.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 22 Apr 2026 04:42:51 +0200
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

Hi Quentin,

On Tue, 21 Apr 2026 at 22:17, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 4/20/26 9:42 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On 2026-04-20T11:36:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >> rename NET to NET_LEGACY
> >>
> >> Highlight that NET really is the legacy networking stack by renaming the
> >> option to NET_LEGACY.
> >>
> >> This requires us to add an SPL_NET_LEGACY alias to SPL_NET as otherwise
> >> CONFIG_IS_ENABLED(NET_LEGACY) will not work for SPL.
> >>
> >> The "depends on !NET_LWIP" for SPL_NET clearly highlights that it is
> >> using the legacy networking app so this seems fine to do.
> >>
> >> This also has the benefit of removing potential confusion on NET being a
> >> specific networking stack instead of 'any' network stack.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >
> >> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> >> @@ -422,7 +422,7 @@ includes the full set of commands, more error messages when things go wrong and
> >> -several filesystem and network features (if CONFIG_NET is enabled) so that
> >> +several filesystem and network features (if CONFIG_NET_LEGACY is enabled) so that
> >
> > Shouldn't this be left alone? Or perhaps restored in patch 4?
> >
> > BOOTSTD_DEFAULTS selects BOOT_DEFAULTS which enables network commands
> > conditionally on !NO_NET, meaning any network stack.
> >
> This patch series is about renaming stuff, not fixing stuff (though you
> can see some trivial "fixes" in patch 5 and 6).

OK, fair enough. This is worth a follow-up though, as having
NET_LEGACY about the place suggests that the code is old.

>
> I agree with you that this needs to be switched to (new) CONFIG_NET.
> I'll try to not forget adding it to a v2 (as a separate patch) if
> there's a need for one, or send a follow-up patch.
>
> >> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> >> @@ -159,7 +159,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> >> -                     if (IS_ENABLED(CONFIG_NET))
> >> +                     if (IS_ENABLED(CONFIG_NET_LEGACY))
> >>                                printf('Net');
> >
> > Similar question here.
> >
>
> See above.
>
> >> diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
> >> @@ -232,7 +232,7 @@ void set_board_info_env(void)
> >> -     if (IS_ENABLED(CONFIG_NET)) {
> >> +     if (IS_ENABLED(CONFIG_NET_LEGACY)) {
> >
> > and here
> >
>
> See above. This one seems ok, but I am not really planning to modify
> individual boards that I cannot test. This change would mean in a way
> that CONFIG_NET_LWIP has been tested with that board, which possibly
> isn't the case and I cannot guarantee that either.

OK

Regards,
Simon
