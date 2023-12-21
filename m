Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5915C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F1E8786E;
	Thu, 21 Dec 2023 16:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jVei83p9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB7D8786E; Thu, 21 Dec 2023 16:06:20 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C95887885
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f6739d7acso6410436d6.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703171177; x=1703775977; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnPSRpUYsMhDlnYT85wwhMLkoOfrfsW2g9LZBr+56Wk=;
 b=jVei83p9Ex3Rz+MSqc/eWw7YrpkxcMZb7JU/Npt0cjteZ65MClgXkuU7p6BUnbGeLT
 lMrqXtAl+8/PZTEtImUHS1D5JkwTYkjhKhgN6MYBz+7uS7LOT+MY09CjN8ax7rt5wCLu
 1jJiyoIppnI3IXTFkhBX85BLkAkRsgRdP08B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171177; x=1703775977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PnPSRpUYsMhDlnYT85wwhMLkoOfrfsW2g9LZBr+56Wk=;
 b=XABt3OCG5KYTT3q5pp3r1Webw9sUfXboXnyS+Nf4y5Mlt2EHMPN4AoP8AV3LacJwvy
 o5lf2HBhSxd5QYpCBERxfWjFhaf0xFDwcL2pJp7Sw39Mo9pqFVX6ljzhu4JErbL9LxKr
 eJj1oMhhaiyLHauBeTHB7yBdmqxRRHABFIh+yvFcyUKbq9JErd60k9XnI4RENzliwqIr
 cafHMDSBwUNNsvXodGCd1Z+0LRbnisJTQ+w1l1foO3pNQr00XjSnO0i7VhW0SD0YWc0h
 roxAFPJvKeFd1iR1vPkOc/Cx+Oy0pCAF5Sioa4qY1GQ3e0MFjvon2oJF9j/ZnVrlAYeS
 g85Q==
X-Gm-Message-State: AOJu0YzWKOMbn8jjz+bS4HvTnhRYYr57BltIyu3XolY7wpDSLh/2+FR8
 AhJAcEz8vEpV4hd8zhuBaqs2wBNrhpn1kIMAlp2Jmw==
X-Google-Smtp-Source: AGHT+IG5apKwtXFr/qIN2GZhGVgadZWZI148Nd4mrf/xGONDWhy1FW1ZvdrTAmfKxv6FcXAmR9+chOR0tE/pvrQUS98=
X-Received: by 2002:a05:6214:2a4d:b0:67f:1fdc:ae7b with SMTP id
 jf13-20020a0562142a4d00b0067f1fdcae7bmr1143632qvb.2.1703171176844; Thu, 21
 Dec 2023 07:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
 <20231214131139.GY2513409@bill-the-cat>
 <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
 <CALeDE9Mi73Fikask=4ve9_B=T=hXqkUOZWTVAeP_oACFL0wBxw@mail.gmail.com>
In-Reply-To: <CALeDE9Mi73Fikask=4ve9_B=T=hXqkUOZWTVAeP_oACFL0wBxw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Dec 2023 15:06:05 +0000
Message-ID: <CAFLszTjXzW_1KdPTT2LMHX5+czOsRXwfgN1ApUrHJWg2=AZAuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
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

Hi Peter,

On Thu, Dec 21, 2023 at 9:34=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> On Sat, Dec 16, 2023 at 6:57=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tom,
> >
> > On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 08:19:11PM -0700, Simon Glass wrote:
> > >
> > > [snip]
> > > > The new DT nodes / SMBIOS binding [1] allows for the correct
> > > > information to be provided, though.
> > > [snip]
> > > > [1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bi=
ndings/sysinfo/smbios.txt
> > >
> > > I think the only feedback I can give on your message here is to pleas=
e
> > > go upstream that binding, and then we can see what to do afterwards.
> >
> > I am still tearing my hair out waiting for the reserved-memory and
> > binman patches to be accepted. Every few weeks there is another
> > comment, but no action. Rob seems to be the only one engaged.
> >
> > Perhaps I should do a conference talk about what is wrong with DT?
> > This is my experience so far:
> >
> > - there is no urgency to apply anything
> > - no one wins acclaim for applying a patch
> > - everyone complains later if a patch is applied that they didn't agree=
 with
> > - people chime in wanting to understand the use case, but don't/can't/w=
on't
> > - any sort of expressed doubt results in delay
> > - maintainers hope that the submitter will lose interest and go away
> > - not enough people add review tags, even if they look at it
> >    ... because they are worried about looking bad to others on the ML
>
> You miss this:
> * Patch submitter ignores questions, feedback, concerns from
> maintainers to the point that people mute the thread

Sure, I can add that. It would be great to get the other side of the
story here, from the schema maintainers.

>
> > I would be happy to discuss how to improve matters, but that is what I =
see.
> >
> > Anyway, the lowest-hanging fruit at present is the U-Boot /options
> > stuff. I was hoping someone else would step up to clean it up. There
> > should be no impediment.

Regards,
Simon
