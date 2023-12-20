Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F214AC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E7D8763E;
	Wed, 20 Dec 2023 05:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kjwHToaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D2F870B7; Wed, 20 Dec 2023 05:46:43 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0410875FE
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2339262835so411392366b.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047600; x=1703652400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qi6S4vjECqeDnQ+UzHD5B3PjN8rKAGBMuUUTssQbaqw=;
 b=kjwHToawD/EIOIspqo1HB2J6mziN5paitPqtl7ufJBWM779Qyv0uY0MELJbavDogPy
 lgictVD7reUhVsR7hLKMyiu+ycyUT54dlEurJ6GCKnvVhpXh1V3ZzrA1shC4lLNppcdV
 a+z2IyJYtWgxruE8OCNmvWhDiIOUsKJ7nnSAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047600; x=1703652400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qi6S4vjECqeDnQ+UzHD5B3PjN8rKAGBMuUUTssQbaqw=;
 b=N4e6M4PdQD8xKujS+1x/u1MaayUxt5Kbf+0XbcOzWd4aXE+iy0OI6gEr5dwaGcI82q
 ARim/thtt8kWcokGYhX6sXdrihKvk8FgnQPfEMQD2dg/ZgjLjoNdgELDfztZx7ehqrsT
 gBa+fWpGzoQqKzoH7TNJ75XbO8ec6x/F8+9jNmXCzyNWWo6CoCNAOByrGVWMt8Wa81XE
 ssRlZb3KZpVdGBuKD6pbSa9kcsGHL7dNiSW8RnBBATeot/Fn2D0bQH0xRN99fljRHHoe
 dnF9Yvo8mSC4yw6VFXWDXdTP09X1d2zD697YhOxqDfdgh3zqLFLGGuX+2+Y2/M20XkT4
 hv0Q==
X-Gm-Message-State: AOJu0Yz/2z/U2BiLR+qvit9+3o/FrYtPu749QDXaE6bRZgD6z2qHr+f8
 XyeZLVv8dol76rn6n6RDH1dD0UppZlH60638Y3/SWg==
X-Google-Smtp-Source: AGHT+IFUeUhJsSC35WAlWOwWYmau55xHTvL9efz8HqMFijFkBNb+LAVsz4lixDvN5zNAVHRDduxI+v0kF0dBQh6bShA=
X-Received: by 2002:a17:906:7493:b0:a23:dffc:7a27 with SMTP id
 e19-20020a170906749300b00a23dffc7a27mr1065512ejl.27.1703047600113; Tue, 19
 Dec 2023 20:46:40 -0800 (PST)
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
In-Reply-To: <CAPnjgZ1XP4+0sefoXNfvgSmMef2zsRsNPN-hzxAUFhb7dDX6Hg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:22 -0700
Message-ID: <CAPnjgZ0hfGARdygcO0wV1R2_XNZ5mUvHfRxsKv2f1AKXiHghFw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 sean.anderson@seco.com, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
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

Hi again,

On Mon, 18 Dec 2023 at 14:07, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Neil,
>
> On Mon, 18 Dec 2023 at 08:37, <neil.armstrong@linaro.org> wrote:
> >
> > Hi,
> >
> > On 18/12/2023 16:01, Simon Glass wrote:
> > > Hi Neil,
> > >
> > > On Mon, 18 Dec 2023 at 02:54, <neil.armstrong@linaro.org> wrote:
> > >>
> > >> On 17/12/2023 19:41, Tom Rini wrote:
> > >>> On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
> > >>>> Hi Tom,
> > >>>>
> > >>>> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
> > >>>>>
> > > [..]
> > >
> > >>> And my point with the above is that other SoC maintainers (Neil, for
> > >>> amlogic) have said (paraphrasing) he does not want to do N smbios node
> > >>> patches. Which is why Ilias' patch is if not 1000% correct, it's Good
> > >>> Enough and will, if it's really a problem to have all lower case
> > >>> information displayed, spur people to see providing that information as
> > >>> a real problem that needs to be solved. Or it will be seen as good
> > >>> enough.
> > >>>
> > >>
> > >> If some platforms requires a more "correct" smbios dataset, then they're
> > >> welcome adding the required smbios node, and it's perfectly understandable,
> > >> but for the other community-maintained platforms we need some valid fallback
> > >> data otherwise they'll be de facto excluded from some tools for no valid reasons.
> > >
> > > Do you know which tools require SMBIOS tables? I found sos and another
> > > Redhat one.
> >
> > SMBIOS data is translated into dmi informations in Linux, and a little
> > lookup in GitHub gives 6.4K files using something from /sys/devices/virtual/dmi/id/,
> > and by very commonly used tools like lshw and probably fwupd.
>
> lshw also uses devicetree, so should not also need SMBIOS.
>
> fwupd uses UUIDs to indicate the device. So far as I know (and I wrote
> a plugin for it, so at least know something), it does not rely on
> SMBIOS tables.
>
> Here is my main question: is SMBIOS:
>
> 1) just informational, not affecting the operation of the device
> 2) important and needed for the device to function
>
> If it is (1), then I don't mind what is in the tables - we could
> perhaps add a '?' at the start of each string to indicate it is
> provisional?
> If it is (2), then I want to avoid adding information that might be
> wrong / might change over the life of the device
>
> In either case, putting these workarounds behind a Kconfig seems
> reasonable to me. What do you think?

Hmmm and I forgot the other problem, which is that there is no way to
pass an SMBIOS table to Linux without booting via EFI. But I don't
follow it closely, so perhaps that has been resolved?

Regards,
Simon
