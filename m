Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F8CC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8985E8758C;
	Mon, 18 Dec 2023 22:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GzagEmU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A600D8758C; Mon, 18 Dec 2023 22:08:01 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810E48713C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d9dadc3dc0so3116172a34.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702933678; x=1703538478; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S4Zg7KpNuXshbpLTPsDkhgsp6569p/pt82qLy7J0s6Y=;
 b=GzagEmU1xLo/njMmpdxzB71imjx10TMn2DHyyKN0fIdpTxAEJDVxAqbKlhu1pYzRzB
 7lix/YshX8nYDYjYwGAPEXqDKZb8Ks9KdvRj8M65GJgpF1t+QPtWJrqhKe3y+tHeidXL
 BVf3bT2Z4QnmJP1hL/WDaVrm0UBCPt3SB0cd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702933678; x=1703538478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S4Zg7KpNuXshbpLTPsDkhgsp6569p/pt82qLy7J0s6Y=;
 b=s4/lz1JMKaPi+lvArkva0XCqg0NWPQVgmjXDicKr7tu/lBK2eaWl+ibw34jFk0LT/J
 HrpMDz4IDVn4dvC6Oy5zGUmUv8iJRlacpj8L5+yJh1XrlW8PRsTrKMiM1qzKK0oLkgVM
 93cxbWOS0zDDh+AJD4XdMZqRP+vs8/juofEAg+Z0vW8kyuSc8PKH51NBpR5XddjT/heX
 0af0J0/7gAvrYvwTEj7xVT6TSJAEUT5vGNT2nzHLGy3M/AeudM4P2a+KTGWRV1YPIZzH
 CSa1Po9NWXTEEapogO23yDSYhcvX4kbAb/RZE2lplUjsTRCD7QJloTDgWAhsa8gvyJkE
 45sw==
X-Gm-Message-State: AOJu0Yx7L/qNHUe1JtMpwdd48NLEzGsiZgw98fs9yg0zvFrhPtxK6Ulv
 kwXSMFCOiolK8b+vWBNRQ2nF9mxJu5TCpdMUuTxgFQ==
X-Google-Smtp-Source: AGHT+IGl5KeiX/xSxQjOH1cSv8Aban3ObsAPy0Ef0x4UUHeku1VGgAas0LwDpeSdGy+k6CW+nSAjGz1G8CHLXNZIlpY=
X-Received: by 2002:a9d:68cd:0:b0:6d8:7c4e:d11a with SMTP id
 i13-20020a9d68cd000000b006d87c4ed11amr17306384oto.29.1702933677942; Mon, 18
 Dec 2023 13:07:57 -0800 (PST)
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
In-Reply-To: <0b7d6cd7-4248-47d7-81c8-7466177d5172@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 14:07:45 -0700
Message-ID: <CAPnjgZ1XP4+0sefoXNfvgSmMef2zsRsNPN-hzxAUFhb7dDX6Hg@mail.gmail.com>
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

Hi Neil,

On Mon, 18 Dec 2023 at 08:37, <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 18/12/2023 16:01, Simon Glass wrote:
> > Hi Neil,
> >
> > On Mon, 18 Dec 2023 at 02:54, <neil.armstrong@linaro.org> wrote:
> >>
> >> On 17/12/2023 19:41, Tom Rini wrote:
> >>> On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
> >>>>>
> > [..]
> >
> >>> And my point with the above is that other SoC maintainers (Neil, for
> >>> amlogic) have said (paraphrasing) he does not want to do N smbios node
> >>> patches. Which is why Ilias' patch is if not 1000% correct, it's Good
> >>> Enough and will, if it's really a problem to have all lower case
> >>> information displayed, spur people to see providing that information as
> >>> a real problem that needs to be solved. Or it will be seen as good
> >>> enough.
> >>>
> >>
> >> If some platforms requires a more "correct" smbios dataset, then they're
> >> welcome adding the required smbios node, and it's perfectly understandable,
> >> but for the other community-maintained platforms we need some valid fallback
> >> data otherwise they'll be de facto excluded from some tools for no valid reasons.
> >
> > Do you know which tools require SMBIOS tables? I found sos and another
> > Redhat one.
>
> SMBIOS data is translated into dmi informations in Linux, and a little
> lookup in GitHub gives 6.4K files using something from /sys/devices/virtual/dmi/id/,
> and by very commonly used tools like lshw and probably fwupd.

lshw also uses devicetree, so should not also need SMBIOS.

fwupd uses UUIDs to indicate the device. So far as I know (and I wrote
a plugin for it, so at least know something), it does not rely on
SMBIOS tables.

Here is my main question: is SMBIOS:

1) just informational, not affecting the operation of the device
2) important and needed for the device to function

If it is (1), then I don't mind what is in the tables - we could
perhaps add a '?' at the start of each string to indicate it is
provisional?
If it is (2), then I want to avoid adding information that might be
wrong / might change over the life of the device

In either case, putting these workarounds behind a Kconfig seems
reasonable to me. What do you think?

Regards,
Simon
