Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095F0C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 21:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B36788263;
	Tue, 18 Jun 2024 23:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="NYsSUx4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A2B87CDA; Tue, 18 Jun 2024 23:00:57 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBEF88263
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 23:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6f09eaf420so704312966b.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718744455; x=1719349255; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3d41LaZAHlGaBxEq+cYbpI22Od25a1t85IFWSBvIO8=;
 b=NYsSUx4CGrjf0ZAdyekjfIgSA/2gxVojCeJi/dp0TdjWUAf6NncmaA1VwxU1fQIGlA
 9w8dgj43btidcI2uOgXXB14rq7zggSzWpj7KF6ADlZi7BuC868+qSyVliDog/r4HrIMP
 Ktwq1PdcQ8gNc2HjyYwZ8gZhyVsPTJMAEX+Hpraa1JfusedWdG3MnFYhEEjNTr3Mnl/g
 wT2SLG9xqwklduDl1W7g9ofaPy8FehNXamrMPBjVG6rciMSInCNRZPmUQGSEcXMHjWl+
 T1S8/0jf+AcuGhTt2lvKUdaDo56fPgt4shn23/n5yGh+wfPMrbzBr1Lmmz4Pkmp+6iWd
 9FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718744455; x=1719349255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3d41LaZAHlGaBxEq+cYbpI22Od25a1t85IFWSBvIO8=;
 b=OcXKmH+mKxgzAxIixGxSQonT9SBDYVRfLc/uL3h6zk/Uf5co2AE50WZZSdbgtbMEiF
 otuydqaFGnM1dSpEDDSWi1jJPYiAeqI1Aiiu3QtYrx0V0Rjlorexp+xE7+0LWughRlFs
 IO5aglVdNoVEbrrCCnyKa+LixbDflDkitZxBZsRRZawo89eXeW7Khk5eTX2Zjg7mlQWE
 PALTpcqtRjU/t//YwujubsGG6uAbjvijTL/ZGBedrCo8wqWxQthsxEB3mdxTvK1/Es3E
 BVUw7YRc1JpBouGNMZelIPhMbeBIJtF+vmdO5GXYlg85hFJYG4RbWBbR/sKzYNpK9GKd
 g0WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsgyyXyyaLNNRe++mESkX59vS49tDuGDjl5wbgOMI7QQd5tTA/RyLVjm8vlp/0aoV0S6tesUMJmZfzQtgK3dTVEtlzNA==
X-Gm-Message-State: AOJu0YxOnn3bjvFe2vLMZ8865bSrINVCP+UyzfAFw5Kr1SMDfDilQ3mI
 WKdrB+pi2LSiyy6URcOLL/fgvH8vCiZFdzbWUO3KnfsvX21aRLZvm7+2Y9N/ikWDoS+YjHX0jIm
 KB+nXitbswl16ZK8YoEPD7Al2k32RearmClXxrA==
X-Google-Smtp-Source: AGHT+IE4w1UDj8KlZuNzqjMRf9Y2R0Ucm1zGBKlejqkIA1Eb1sNXVy9xW/9MGTAIznszCNmByyX5ddBK3kiRY8fhJqk=
X-Received: by 2002:a17:906:2555:b0:a6f:796d:c747 with SMTP id
 a640c23a62f3a-a6fab648bbbmr29426566b.39.1718744454538; Tue, 18 Jun 2024
 14:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
 <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
 <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
 <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
 <CAJ+vNU02a0VASJzAghDpSWm6XuOseQj9T70eRn0bD9deiHo6dA@mail.gmail.com>
 <CAOMZO5Cs6xWs-PvMq1u91n1Jmt8BDsZFMUwK8hCx1LWN3VPSzA@mail.gmail.com>
 <CAJ+vNU0yoe8kNw6BmqpB_NjEoZE=efFGihTz=rQ5OOs5ZJNF3Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU0yoe8kNw6BmqpB_NjEoZE=efFGihTz=rQ5OOs5ZJNF3Q@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 18 Jun 2024 14:00:43 -0700
Message-ID: <CAJ+vNU0j4CKtei5inR+Mobms7FsdO0oOJDttpx7svCbYBncATw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, Jun 18, 2024 at 12:51=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> On Tue, Jun 18, 2024 at 12:35=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > Hi Tim,
> >
> > On Tue, Jun 18, 2024 at 4:30=E2=80=AFPM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> >
> > > This seems like something from test/dm/wdt.c and unrelated to my patc=
hset.
> >
> > Do you have this recent commit applied?
> >
> > https://github.com/u-boot/u-boot/commit/1fd754cebd38d7456caa82bef15225c=
be77960ec
>
> Hi Fabio,
>
> Nope - I'm 1 day behind :)
>
> That would appear to be the issue... I'll rebase on todays
> origin/master and try again.
>

Fabio,

That didn't quite do it... I'm seeing Azure pipeline timeouts beyond 5000us=
:
host bind 0 /tmp/sandbox/persistent-cyclic function wdt-gpio-level
took too long: 5368us vs 5000us max

Seems silly to just keep bumping this default?

Tim
