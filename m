Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ADAC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA228700D;
	Mon, 18 Dec 2023 16:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IUo+8S8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5522F87E5A; Mon, 18 Dec 2023 16:02:41 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EB687E22
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e611740893so9960117b3.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NOE8Vu38wz4RXEK7ByWe31GH4ffU6lUE7Seb+5aQC88=;
 b=IUo+8S8Su+wUJzugD2pDiTXS6eCpvBgW/WktgZw7drF/9u5uXLQoBTClCWAegTMey3
 B4mm8SC37IucquA/k1HMoDGpU+NVRY5Vrr3YaEc/RyjjAgbx3q8gU9wN1t0rFWbKUHqh
 GqAuyhBy3mTutUW4WU3fE0/GI4S3ROUw3li8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NOE8Vu38wz4RXEK7ByWe31GH4ffU6lUE7Seb+5aQC88=;
 b=DCINJgIegJG4Z5dlzfyJsArA8eRwFem6n90U5TLIs4deAlz56VvC/9AGUhQeHZVy2y
 E6Bia6zLxmEv6d6/RpRvnH4tTFLVXCR8uGqSBprWxJUsB6ytajWAjkx1YueYWmhrTC5L
 V0duGh1ip/9ygj+7uyeyF34p6io9+l3ZH1p+7knJUqS2gIusx4Y97bzlVA8hZVBszfcC
 vXy0w0ba9Pb/Hq4Q0BjfV/kmqoApFNbrZ51nPALUfPU1g7qxu0I/gtbMY9lZ7tK27VJx
 wsK0Hj+2Czd55LYwZHVEw58R6r3QpMIfoFnt6vKGdP6QKV5woDQvbll/CRrDvvAgORiM
 l3sg==
X-Gm-Message-State: AOJu0Yy7c/P+XSTFC1YfSibYAyKbDtVBF/we+QgYlqqxxFiVtGSSTdK2
 7ZwFyBzgKrNy9/CQWUF2vWbTgrqvpnWdKAoG6GI9Cg==
X-Google-Smtp-Source: AGHT+IGkpuA9JLHouElLqUMPURRsN/zVQuYYB2VnEK5ZF3xoi6XPaWZD2Fy+2czEO/xwWZf/YsEHevDM5Dxd+27ioTY=
X-Received: by 2002:a81:6d51:0:b0:5e5:c45b:10e6 with SMTP id
 i78-20020a816d51000000b005e5c45b10e6mr2883556ywc.7.1702911752793; Mon, 18 Dec
 2023 07:02:32 -0800 (PST)
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
In-Reply-To: <06036b6f-70b8-4b80-823d-d9716cbbf160@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:39 -0700
Message-ID: <CAPnjgZ2wcmGOjbVdNCyzSWNGzBPjPqcjdVcbPu8J2wadnxFRrQ@mail.gmail.com>
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

On Mon, 18 Dec 2023 at 02:54, <neil.armstrong@linaro.org> wrote:
>
> On 17/12/2023 19:41, Tom Rini wrote:
> > On Sat, Dec 16, 2023 at 11:46:18AM -0700, Simon Glass wrote:
> >> Hi Tom,
> >>
> >> On Thu, 14 Dec 2023 at 06:11, Tom Rini <trini@konsulko.com> wrote:
> >>>
[..]

> > And my point with the above is that other SoC maintainers (Neil, for
> > amlogic) have said (paraphrasing) he does not want to do N smbios node
> > patches. Which is why Ilias' patch is if not 1000% correct, it's Good
> > Enough and will, if it's really a problem to have all lower case
> > information displayed, spur people to see providing that information as
> > a real problem that needs to be solved. Or it will be seen as good
> > enough.
> >
>
> If some platforms requires a more "correct" smbios dataset, then they're
> welcome adding the required smbios node, and it's perfectly understandable,
> but for the other community-maintained platforms we need some valid fallback
> data otherwise they'll be de facto excluded from some tools for no valid reasons.

Do you know which tools require SMBIOS tables? I found sos and another
Redhat one.

Regards,
Simon
