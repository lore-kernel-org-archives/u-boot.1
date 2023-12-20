Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39DAC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 17:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F9387800;
	Wed, 20 Dec 2023 18:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P0CwXSvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836B187804; Wed, 20 Dec 2023 18:33:32 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723CF877CB
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 18:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e2786e71fso6004727e87.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703093610; x=1703698410; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GnrONn7YYXqD/Q9DYOpNaA9Ccua1wqDoekSa2sAH2eg=;
 b=P0CwXSvi/Sv6cpWiTlijf4KW4bWuEut4IWROobh5Q2M9OM/4sAeiC1JPaxUn2f6XlT
 tZGozj+xCGxodGpLKuX74OatB32wa1dGEcPyFIVHBdF+B20anI5dQBup5EaIxjgbhlK/
 UU0g5gI1knu5GlAXbWfc4WBrj9nMcoesY5Ej4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703093610; x=1703698410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GnrONn7YYXqD/Q9DYOpNaA9Ccua1wqDoekSa2sAH2eg=;
 b=J0MpHFc2f3TQ4TJ1DXEIABTZTLJUZY2ZYstSqOy+YlNWjXvFZsf3VZ/j5Sow7IYb0V
 SgBNcdSW7PHTqEQzs+uHvkH81Eo+FUcvVXBELKHQXFWFhEKctDVy/osJczKXEPBEBpKu
 ZmFMhRoYqWR3UDWtt9U/TkboNf6fV7H6HBM68XjLfArkTMEFDb1lzggR+dPe9eMJHQ+c
 0I103fztJjA+KDxffU6aaJVoYgw/LZ8WkjAMQ1QNx9ZZvc6Kx5qC7rsy4PvTFSfTyL2H
 1EN5Op12BSEAnxTWGsUU5Sn7AtSUBjCTwmqr+ElkSXHaPsUyS8M5c0jN+FwaNj9XRCL9
 T94A==
X-Gm-Message-State: AOJu0Yys5XyrI9d2yBtLaqBTv1rJnejkvSvO/y4c402fc8hX+7ceKtFK
 jQGuWysCqsI6/y7x4qStFpH0C27439jpIkDY7kAe5g==
X-Google-Smtp-Source: AGHT+IEBqRKB0C//uvu7fvaDUGRsdLbZO0q4swev/KeoC2D8s5wsSHjHatjlxsNr9qnFpLq1J8aU/nP+ahwyLzXq2Mw=
X-Received: by 2002:a05:6512:2002:b0:50e:3dd4:39c4 with SMTP id
 a2-20020a056512200200b0050e3dd439c4mr1986864lfb.62.1703093609607; Wed, 20 Dec
 2023 09:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
 <20231213230545.GM2513409@bill-the-cat>
 <CAPnjgZ0L+kVG0DWExwDJXYG5FfObq34LULV=se9T50OvcmhfMw@mail.gmail.com>
 <20231214131139.GY2513409@bill-the-cat>
 <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
 <20231217184100.GC2513409@bill-the-cat>
 <06036b6f-70b8-4b80-823d-d9716cbbf160@linaro.org>
 <CAPnjgZ2wcmGOjbVdNCyzSWNGzBPjPqcjdVcbPu8J2wadnxFRrQ@mail.gmail.com>
 <0b7d6cd7-4248-47d7-81c8-7466177d5172@linaro.org>
 <CAPnjgZ1XP4+0sefoXNfvgSmMef2zsRsNPN-hzxAUFhb7dDX6Hg@mail.gmail.com>
 <CAC_iWj+DhrKz9Q6L9FDQ_amXq5pzrHX=yaT+QJBiNpjkG2bRBg@mail.gmail.com>
In-Reply-To: <CAC_iWj+DhrKz9Q6L9FDQ_amXq5pzrHX=yaT+QJBiNpjkG2bRBg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Dec 2023 10:33:17 -0700
Message-ID: <CAPnjgZ0R5z5j+2d5yCr6H64GRXUJHcc4SF6cVCjQi2w_4bmBqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>,
 sean.anderson@seco.com, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Wed, 20 Dec 2023 at 00:26, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 18 Dec 2023 at 23:07, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Neil,
> >
> > On Mon, 18 Dec 2023 at 08:37, <neil.armstrong@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > On 18/12/2023 16:01, Simon Glass wrote:
> > > > Hi Neil,
> > > >
> > > > On Mon, 18 Dec 2023 at 02:54, <neil.armstrong@linaro.org> wrote:
> > > >>
> > > >> On 17/12/2023 19:41, Tom Rini wrote:
> > > >>> On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
> > > >>>> Hi Tom,
> > > >>>>
> > > >>>> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
> > > >>>>>
> > > > [..]
> > > >
> > > >>> And my point with the above is that other SoC maintainers (Neil, for
> > > >>> amlogic) have said (paraphrasing) he does not want to do N smbios node
> > > >>> patches. Which is why Ilias' patch is if not 1000% correct, it's Good
> > > >>> Enough and will, if it's really a problem to have all lower case
> > > >>> information displayed, spur people to see providing that information as
> > > >>> a real problem that needs to be solved. Or it will be seen as good
> > > >>> enough.
> > > >>>
> > > >>
> > > >> If some platforms requires a more "correct" smbios dataset, then they're
> > > >> welcome adding the required smbios node, and it's perfectly understandable,
> > > >> but for the other community-maintained platforms we need some valid fallback
> > > >> data otherwise they'll be de facto excluded from some tools for no valid reasons.
> > > >
> > > > Do you know which tools require SMBIOS tables? I found sos and another
> > > > Redhat one.
> > >
> > > SMBIOS data is translated into dmi informations in Linux, and a little
> > > lookup in GitHub gives 6.4K files using something from /sys/devices/virtual/dmi/id/,
> > > and by very commonly used tools like lshw and probably fwupd.
> >
> > lshw also uses devicetree, so should not also need SMBIOS.
> >
> > fwupd uses UUIDs to indicate the device. So far as I know (and I wrote
> > a plugin for it, so at least know something), it does not rely on
> > SMBIOS tables.
> >
>
> It does use smbios tables. It also relies on them for some info for
> capsule updates. Hence the fix in commit ff192304b699

Just on that point, can you point to what is used there?

Regards,
Simon

>
> > Here is my main question: is SMBIOS:
> >
> > 1) just informational, not affecting the operation of the device
> > 2) important and needed for the device to function
> >
> > If it is (1), then I don't mind what is in the tables - we could
> > perhaps add a '?' at the start of each string to indicate it is
> > provisional?
> > If it is (2), then I want to avoid adding information that might be
> > wrong / might change over the life of the device
> >
> > In either case, putting these workarounds behind a Kconfig seems
> > reasonable to me. What do you think?
> >
> > Regards,
> > Simon
