Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD771090253
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 16:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C882B83DC9;
	Thu, 19 Mar 2026 17:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EhIbnwEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD3683F00; Thu, 19 Mar 2026 17:49:45 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98DF583DA6
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b976536806cso171956766b.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773938983; cv=none;
 d=google.com; s=arc-20240605;
 b=BSpTep8WbrIFvg/B2iMsxtAcc1ut3fM4yB4K5AoIr5HW7Njx8dzF9VePCSF3F2O5Z1
 y0VqpIVsVH/jqDxus3jBa6Z2Bkuo3Pm9psBDH2aEULl+Bqv8cw0eyqdkITBcBw3xX9MM
 4gyS4OYormAMoWKTP2Cp7DrlnXjSsXTTmN1SIfLXyKIWiEy0xVFNAj9y3N1F/NO4y3Ia
 Qu/qtMBak0Rnk6foYWcBJvyIZiQnpppkwiWmKw7swqgBQCTzMueAL/pIXPHvakrulniq
 jbayfjiA4VKsL6e/Ty26Y834FteIIZrDhHDtHl7XD2upOhNwP8kK2OvoY2IMMsIui/lL
 cxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lnb9j2EY4aUmY+6Iu82mbxIAZJET6sBRqcYPJFCdgHY=;
 fh=OI3hGuGcYo5GkzEArp9tydlJN9SkUG+StzJs5H1SHB8=;
 b=A08fw5vKkEY473I2XnTxVkDnHoudHItnIgCWL57q3rB9JsrbI9/3qDVSFPkm6znd9Z
 v1+05SB7SgXZ9PY0SmzVwKIVdosoTDInWWbDQ7wESq97Ms8gAcfqRpR9PPGcWooyCY8S
 zL0OmbNak0Hu0O1iw8adeXrqwhjGqcLReSMtenLWMwGJ9yX5TL1GdBOLTm4AntfbHxL5
 GtIvN/2P7/ewfbG7pp6RKNzA4GFsDuoaGoNRc2NnKRy9GsJ9fBk44xjdVweVSj5GZ024
 PSoUWJchKpBx8sW0he5CDVbe4JE0e5aKkpK59aFeeCgFoEDli/JNIPl06ldobkaxYoqU
 ev5A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773938983; x=1774543783;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lnb9j2EY4aUmY+6Iu82mbxIAZJET6sBRqcYPJFCdgHY=;
 b=EhIbnwEXA2nyu3aDSfe9qLE91ootststbItzcBO6yUHEw6d27bUWeibZwSG6d1ZT5s
 ojelX6GLeLTa0HmQl1Ug3XmsoTg2ILETJL8eRb3bFSYV5wjOwbZAwuHW5jmFKXmtirsP
 MM+dhL5YcdS1hwJ4k6FsIVl4PMQy3wd64b8WtsRrtpQ7eKVBwrN5zhO6MvkMF6BAWmAc
 Q42kPSqqM0P6UeXYjtLwtEYwXAfI1rd80/+9B1Ne89H95DYCcl1d5NSukp5oVen0wHSl
 AbXAFXnhlafI7WXdatHqKKnIcvZO4jqhFJl0aP+6pWhuiCEmwe4IuzTGNUkB1bK12rNA
 Knww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938983; x=1774543783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lnb9j2EY4aUmY+6Iu82mbxIAZJET6sBRqcYPJFCdgHY=;
 b=ZbfIABxZ5CFlRH4tIdDo39BqlkTUipuBuUnlnnVzNdP/NrrZQ7DFd7xTweA0bupxBd
 V8KBB6YE9R2zPjbYrUO0XhEc4ZvuDrfwLPbYA9wVCcZoJp+sqOAPQEb/z5IN5zGfhaCz
 EzQwNexuJabQUT1YUy5zsfRPRe+mdqZ+zjRu9aay0veoTQcQ9+vebYumQiudGh+18cPt
 KkzIkpnzTejGS2hJc1sxYMUtDm3FOlxjswrhww1y0h/zCviPfAFIzWzGgMJPi8nfDyaU
 mclxsOWX2H7aKi3hY07kYM5hOidjBnrczfXmXlxWLXdKQ7WMemxS0YIuvqyoOyLIBVAz
 mdrA==
X-Gm-Message-State: AOJu0Yy3//M0/WMMjj6JlplaDcdnww+jZ7LuzZQzKLNjqEmXBOo4njGr
 y7gmey8pXY3XYjhlmlKzINGLsZYyZi43fD7Mc8NpK4h9h7/kK247NBuZqpl4IYQcfHLNpmbTk3A
 5hK6X6fTMU7xs3YBxxBu5BPX35OvuYyCkyYB2stI9kA==
X-Gm-Gg: ATEYQzxC6DxwZ+osBcRKhuBSbx9kt860vlLPLXAI0R8qh84TIMzxZU5CKfml5aD14qm
 skhos56srZAvpW0prKcvYuCVaEdkJGQUeL0xYFJCl6jzoVl6nM3UJqcmDswOfpMg0ObOspt6IGG
 l8OkLKkf4T/pUghvuQGWLbuWM8HzHYiimyg6aN7mRyGhVDRcKJGXjFBANFvhGVIt1MUh7qc7Iy7
 J8eGcU0y2TTJjclSuLzbtzrn2h5f9CBQbq/VTQW9W855dVCEFP5rrI5RuvfLIRiwOttRmjTlonv
 FZxMPwsmyjgUSM8Sh1g4738QcxjhHPKlxnUHv5Syweb43rgUUtgb8HuurLZAjh0wKrX12Ngb2ui
 bCD2ZgIds3UwYL9X88e5R8+ldSQ==
X-Received: by 2002:a17:907:75ec:b0:b98:2732:3dd1 with SMTP id
 a640c23a62f3a-b982f3b712amr1793466b.42.1773938982960; Thu, 19 Mar 2026
 09:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-merge_configs-support-include-directive-v1-1-dcfb1c7f934c@baylibre.com>
 <20260319162134.GV502704@bill-the-cat>
In-Reply-To: <20260319162134.GV502704@bill-the-cat>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 19 Mar 2026 17:49:35 +0100
X-Gm-Features: AaiRm51drfLWJZDIaaNU1GkYd46-AyA4z68Oqe4k-tCKKJzsR4v8D87V5sBQ8w4
Message-ID: <CAEHHSvaHEpiakXc1QOXeJP49gSs9yf4M29Fw5OsQLqtBV-y75w@mail.gmail.com>
Subject: Re: [PATCH] scripts: merge_config.sh: support include directives in
 fragments
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 dlechner@baylibre.com
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

Le jeu. 19 mars 2026 =C3=A0 17:21, Tom Rini <trini@konsulko.com> a =C3=A9cr=
it :
>
> On Thu, Mar 19, 2026 at 05:14:05PM +0100, Julien Stephan wrote:
>
> > Many defconfig files rely on include directives to factor out common
> > configuration. When running "make some_board_defconfig", these files ar=
e
> > preprocessed and the includes are resolved automatically. However,
> > merge_config.sh script currently does not handle include directives in
> > configuration fragments.
> >
> > Add a preprocessing step to resolve include directives in all fragments
> > before merging them.
> >
> > By default, the include search path consists of:
> >   - the current working directory
> >   - the fragment's directory
> >   - the default U-Boot configs/ directory
> >
> > This ensures that existing defconfig files work out of the box. Additio=
nal
> > include directories can be specified using the -I option:
> >
> >   ./scripts/kconfig/merge_config.sh -I <additional include dir>  config=
s/some_board_defconfig frag1.cfg frag2.cfg
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  scripts/kconfig/merge_config.sh | 56 +++++++++++++++++++++++++++++++++=
++++----
> >  1 file changed, 51 insertions(+), 5 deletions(-)
>
> This forks us from the upstream version of the script, and I don't think
> upstream will want this.

I understand. Would that help if I submit this to the kernel first?
and see their reaction?

>
> When I make use of this locally I do a two step:
> - make foo_defconfig savedefconfig
> - merge_config.sh defconfig frag1 ... fragN
>

That works well for defconfig inside configs/ but if you manage some
configs outside of u-boot and they have include it won't work.

> So, I am hesistant to start with to change this tool more.
>
> --
> Tom
