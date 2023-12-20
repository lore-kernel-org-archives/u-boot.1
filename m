Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C810DC46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36278870B7;
	Wed, 20 Dec 2023 08:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hgg3wd6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665F687530; Wed, 20 Dec 2023 08:26:50 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FFA8700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e3cde8ab8so458889e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 23:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703057207; x=1703662007; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UJyuc1a//N3lCivdxCEglyZb2ZS3jIdwsxWWc7oYFfw=;
 b=hgg3wd6owyr/1c7c/53Kz/BbrAkdmrTYQveQrubDr2AKpvAN+L5SVpYNIHvnx4XYG+
 LEsvRtt6OisVb8UokElGT9RAaUfEzBVjuLXYyvjLwtpZJlEBeO75orvXkVUIkZ3QetmK
 Pqx5la+EUApzpv1sIi684JJN+k+ohMzkkZyUpG3qcwxaPufoTuIYfl/sgEgXTISO7Cru
 gBSnsk2I/07GqO/sGbeOc0tjXFMm9inGsgKit182BRhLfiP8naxiX0iDBrVglcgDJNh7
 Kxc2Hnwpx5PYzKbilrt2VllEAM3zLNgGebYZWexXm4xpg90nH2hWwy+1/fNNiZnb514G
 CdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703057207; x=1703662007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UJyuc1a//N3lCivdxCEglyZb2ZS3jIdwsxWWc7oYFfw=;
 b=G9ZGvdJ/LTwgoTk7Fqqadm5CiFrMF3fOp7k6iShoDa6FzRdplm2YTGRoWlLF8GD/Qp
 tP1VSlhxRkX+F6L5VWjnZl86SxkxwnyndrLaOhpMiaIWIg0F9FiI4QuGNLF0TVAJ5LSR
 rM0XzdCBEi4cWq/oJji0qmdU/zp7QEL/FrNX1So+7RcDplrrTB8RftxDe3TWLFtPALNr
 lGNu9TJO98HgOy6Ju94yd8GI1JGtV2wVyo0dn5cQdxKdyrUuxn470DKsmoh942+IgCx/
 8a1pbsqexB8By+S9rOyQLojl4g3zlKIOuD0EW/K8EeBQvuD7RtWMCVeEh9u76+UEN5wg
 XbVA==
X-Gm-Message-State: AOJu0YybA7UBZqQ3rU52E8ZZ/IpJ0xB+kuUJeVCASkepEcsR8pZktYjJ
 QO1Ihod1ozBE6Wwvt5mHSrHIRz/TDf+xFUOWaoxgr45X0gzI8g==
X-Google-Smtp-Source: AGHT+IEGkrI+nNlGP93yOKKQuynP967+RbGMD9clAEWtwQqJW5KYyg76s4j10nGswQKhMSJsH5BFeFyAlGMVAt7e09Y=
X-Received: by 2002:a05:6512:2351:b0:50e:4608:11cd with SMTP id
 p17-20020a056512235100b0050e460811cdmr1674469lfu.32.1703057207014; Tue, 19
 Dec 2023 23:26:47 -0800 (PST)
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
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 09:26:11 +0200
Message-ID: <CAC_iWj+DhrKz9Q6L9FDQ_amXq5pzrHX=yaT+QJBiNpjkG2bRBg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Mon, 18 Dec 2023 at 23:07, Simon Glass <sjg@chromium.org> wrote:
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

It does use smbios tables. It also relies on them for some info for
capsule updates. Hence the fix in commit ff192304b699

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
>
> Regards,
> Simon
