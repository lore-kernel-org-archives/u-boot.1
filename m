Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE688C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A691487C5D;
	Sat, 16 Dec 2023 19:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I8sTG27b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081F787C11; Sat, 16 Dec 2023 19:48:24 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D07387C04
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d9f8578932so1384162a34.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752500; x=1703357300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jU2ICr5sj51GOU0mTYawScqO+yKfy3EuLLtMfEygbPs=;
 b=I8sTG27bxS+Prn+i7fvZKqrSq6VWd/TiwZvKIuTzyLhx0zLdXAYF29a8RrTuVzemfN
 3YaTUtrYLTX5LY2/rcO5nR2gCWTKGr2nFjW5v21zj1An0leMQedEzuW8i9bJ9WS1cqF5
 inqckOeGPLyW98QV5Fm9ckvqs+OWHLeKbuiw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752500; x=1703357300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jU2ICr5sj51GOU0mTYawScqO+yKfy3EuLLtMfEygbPs=;
 b=tAK+DiJCRr1a6+3ftFtfwV5OqqMSFfgm59NABJ7RuJF0lPm8N3UqBkXfKLkxJtObnt
 va5tk1d3k3IUYwzeMCrczYn15BzYMTVhZXRm4qzK+4SKOJN2xywAx2Moumd4ZAE1OzEs
 kO1c3WR8Y66lUVSd1VweqagkcRhNARNKMZGvpZxaajGmL5ifdeH37q9HvjKFOb1KRRDg
 QR0zIQFhX+a/yjEGZM169FgozHGPbiCf5zutgQJhj8LdnFuTKfZv9HvtUmQ1ybY0Sonx
 GpVrrfb8Cj59Be0vF0ZH2uehQHt9FHdp8Ymkz8A8boCVtnswZNowNoNuaUuXYy//hQMM
 uOLw==
X-Gm-Message-State: AOJu0Yy9P6aYXDUx0i3g9YYoz6bqY3DeGUsobDoLmfzVuO5m3yd5/2ON
 zANzZOhePAPe94skf+nEFd3+Y3Lc2hLZfFiFqWI+Kg==
X-Google-Smtp-Source: AGHT+IGEUkMJRFV/Dolf5BvBIxMr0jKFcwYXCnUZqLvTrbdJQRw+U+7mXolEby4Ore+wmK69soJZn3oRoNbXcuxvjcY=
X-Received: by 2002:a9d:7384:0:b0:6d9:d41e:286d with SMTP id
 j4-20020a9d7384000000b006d9d41e286dmr14137702otk.18.1702752500101; Sat, 16
 Dec 2023 10:48:20 -0800 (PST)
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
In-Reply-To: <20231214131139.GY2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:18 -0700
Message-ID: <CAPnjgZ17b7sZX-dey5mdXJJ17g5ho_U2UZkawyFYU19R-gidhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
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

Hi Tom,

On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 13, 2023 at 08:19:11PM -0700, Simon Glass wrote:
>
> [snip]
> > The new DT nodes / SMBIOS binding [1] allows for the correct
> > information to be provided, though.
> [snip]
> > [1] https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/sysinfo/smbios.txt
>
> I think the only feedback I can give on your message here is to please
> go upstream that binding, and then we can see what to do afterwards.

I am still tearing my hair out waiting for the reserved-memory and
binman patches to be accepted. Every few weeks there is another
comment, but no action. Rob seems to be the only one engaged.

Perhaps I should do a conference talk about what is wrong with DT?
This is my experience so far:

- there is no urgency to apply anything
- no one wins acclaim for applying a patch
- everyone complains later if a patch is applied that they didn't agree with
- people chime in wanting to understand the use case, but don't/can't/won't
- any sort of expressed doubt results in delay
- maintainers hope that the submitter will lose interest and go away
- not enough people add review tags, even if they look at it
   ... because they are worried about looking bad to others on the ML

I would be happy to discuss how to improve matters, but that is what I see.

Anyway, the lowest-hanging fruit at present is the U-Boot /options
stuff. I was hoping someone else would step up to clean it up. There
should be no impediment.

Regards,
Simon
