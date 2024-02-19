Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC53EC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 20:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D989387DE5;
	Mon, 19 Feb 2024 21:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2IO3+zc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFD487DF9; Mon, 19 Feb 2024 21:18:19 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F8EF87DE5
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so2612042a12.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708373886; x=1708978686; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrldnV53t+qjH30K2C70d6VhswJeFcloQohKU4GoyAU=;
 b=Q2IO3+zcSoqlTSeoZWL5oDcxQPaiycQO2ESK1HfSQBM62vHuVJdWuLrhghpJaiU2WX
 M/mNRP4gx6jBo2CKkhW6af2unHI4kic21GAxTXwdDaQ1U6BSDOgwVzrNQoUIlXm5ORs8
 getCUA88mkdS9Xy72ZGmt/LhnpJTHOVJYbUapdTHX7+TapF3wN+LAHe9HJoLKkuqHBzn
 CfHxKHjiM6JpAvMEsLMkiOhFotbRCk3le5ZR9G6vaoYd6y5naVFJ0V3t4XPaw4E57HhT
 MH8rTpdmKezMkuOnxTGUCJcMyWJy+Wd7c12l+AnmMR7Y9yxdNRMOqnK9Q0grgUX06/sS
 g9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708373886; x=1708978686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrldnV53t+qjH30K2C70d6VhswJeFcloQohKU4GoyAU=;
 b=euuPnXUWPaXp2vcf7ImrKWlgSj7xub6/z3Dn3uD8RblKSS7la9ldirH35K8ruC/SgK
 0zCgEfU4xBME32Hf7lwS0p4MWBm59Ue5Ap/fUepmq4Oh/a3i8JDK6sloAtET0puFdwE4
 4OK0Rftz6PL9JGsa0QksIdJzrX2N4m8QFemJ9rNBbK+QGnnK709+WGVWe3diNsvXfYrQ
 7CZqrEfkETd2QwPQcOSuQ180zmTBFWRSSGKRmSwoi4BCwGP9r7ibwcrVNVquTtUE/SWP
 cNvKmg+z4E6zld5pYWitZkq1xy+p/G8MxlZK3YM07IRO2vwLyNqswpkeVEEBb87xkL5B
 9nvQ==
X-Gm-Message-State: AOJu0YytydOIf9ECjU6mgqgQW06VBIdL3M15wt4ZFMb2wYoudnW6CGk1
 tS+fK+8TvfvygdnnhKrd6mrDABvWY7sVk8jhNInXbtJ6sef+xnprfF8nH5e22i8BXnz47825wY4
 HkYSlbvz1p94CC3L9Y4AFCq05HUuRMpemEEg=
X-Google-Smtp-Source: AGHT+IH3RJFE3J4jmhJa1cr8eQ0tjmDVAXeAmnVlQTSsHO7X+OvkGw8R4KOshr7lckdgE75U+7/u43s6Z4zF4rTzBq4=
X-Received: by 2002:a17:90a:a095:b0:299:cafa:5e8b with SMTP id
 r21-20020a17090aa09500b00299cafa5e8bmr1857363pjp.6.1708373886501; Mon, 19 Feb
 2024 12:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
 <CAOMZO5DQruTiaWMj4zv8gKyUJqtYqb5bmf7Z-Upc7k2+6yCffg@mail.gmail.com>
 <CAOMZO5AgYn1i1U6b85b3-6GXigY3UoCJ=1Zy4PsREGD88B-uEw@mail.gmail.com>
In-Reply-To: <CAOMZO5AgYn1i1U6b85b3-6GXigY3UoCJ=1Zy4PsREGD88B-uEw@mail.gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Mon, 19 Feb 2024 15:17:30 -0500
Message-ID: <CAJFTR8R9tnycG2iV7QSDb67PqJBB9tJHnxmjxW8o-TzUBy_9yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: dts: imxrt: Add binman support
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Sun, Feb 18, 2024 at 9:12=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Sun, Feb 18, 2024 at 10:39=E2=80=AFPM Fabio Estevam <festevam@gmail.co=
m> wrote:
> >
> > Hi Jesse,
> >
> > On Sun, Feb 18, 2024 at 6:20=E2=80=AFPM Jesse Taube <mr.bossman075@gmai=
l.com> wrote:
> > >
> > > Enable binman in Kconfig and in device tree.
> >
> > Please explain the rationale for doing this.

Rationale for using binman is running mkimage will generate a file
named fspi_header.bin
which needs to be prepended to SPL and u-boot.img with padding. This
is how the imx8mm_evk did it.

> Also, it seems that this patch alone does not do anything useful.

No, it doesn't but it makes the next patch smaller and keeps the
changes to do only one thing.
I separated it as it can be separated into two distinct tasks.

> Shouldn't this patch be squashed with the next one?

yes, it can be.

> Then you could explain in the commit log that you are using binman to
> generate the binary that is suited for booting from SPI NOR flash.

Shall I send a V4 with them squashed then?

> Do you agree?
Either way works for me. Sorry for being a nuisance.

Thanks,
Jesse
