Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A322C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC27F87622;
	Tue, 21 Nov 2023 23:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oYGRC8Ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAD987631; Tue, 21 Nov 2023 23:11:37 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D2986538
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-da0cfcb9f40so5981043276.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604694; x=1701209494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pvBi6zp40wGeOvksZjl5UQryTbM38wdNVX9FQJZx/lk=;
 b=oYGRC8IhHdtxnwEBZi6DsKgkOYnyhnNyI9ioJJDEGQ8PzuhsGeZgXpS9dn8q9RdpYW
 FnENPEa2Y4TmkDyrtW6eVhskCQqtLdJ2Rscfm23oV/IkAp6zU7pLMqgOLNA+p3l5gPZj
 wAjKp9e8Bh8v3+wcds4e4Ljbp1ZNEm6sLdJzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604694; x=1701209494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvBi6zp40wGeOvksZjl5UQryTbM38wdNVX9FQJZx/lk=;
 b=D1nfrbyGqngd4uqJ4G6/0BK0pipHtgdvC+qr/oHDVjtClMtQQr8dvYRfkTURlRCRng
 Oiyf2UBOm/n1RlxLuQTi/ZHXB87Hc8fOIpYYA6sgCWUS/BMIvuaY8qJY+ODuImTkOG6O
 YbjJ2Il4uVHeOmZVrsXJhMbxLhis3mPwKXxunhmAwIsumut5tXi9qjqDOFav73lwOEZ/
 ILsph40OkCzZhvRUthcMNZudHvK6lWdykfdbNAs9+6AemQn8k0TddtG0OMhGCPy3Gva7
 i5TwxMOa8O6cwY/ZjutzdNCPMUab1xsZluWKS423dZ/vMIQ1pve7oq3lDuyeo8GfzpOE
 zpOw==
X-Gm-Message-State: AOJu0YyRVF+IIKhdhUBH/o+bC36IMXQV/pEQ2RzgfhxNt6UlJpeLuM/9
 yEATjG7e6vQvHeOWYkWTi5OuobyB3iNf14tCI3dMAg==
X-Google-Smtp-Source: AGHT+IG2eH68MDsi6lDtXZ1F/UOBRGejA3HWOkUmHOhquhwWq3vMHOAHdyFuPqVpLzPR9xsApkEW2jEbi4tFGZbWGCA=
X-Received: by 2002:a05:6902:46:b0:d9b:eb86:2b26 with SMTP id
 m6-20020a056902004600b00d9beb862b26mr320247ybh.21.1700604694021; Tue, 21 Nov
 2023 14:11:34 -0800 (PST)
MIME-Version: 1.0
References: <ca3435b5-25de-727d-ca46-a88a234f9fc5@gmail.com>
 <CAPnjgZ1eCwAg=i27Kkd0mk7PeR8Eu_955utAjBfkNrMvKZyUgw@mail.gmail.com>
 <b99a114b-2715-2cba-cb0f-0dfafd32c29d@gmail.com>
In-Reply-To: <b99a114b-2715-2cba-cb0f-0dfafd32c29d@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:11:13 -0700
Message-ID: <CAPnjgZ2t3RiCUjxknrPRqxEcEJtCcPOL=PGN6uuaVRJiWDQ3hA@mail.gmail.com>
Subject: Re: U-Booters at LPC
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Sean,

On Tue, 14 Nov 2023 at 06:30, Sean Anderson <seanga2@gmail.com> wrote:
>
> Hi Simon,
>
> On 11/13/23 15:26, Simon Glass wrote:
> > Hi Sean,
> >
> > On Mon, 13 Nov 2023 at 11:15, Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> Hi All,
> >>
> >> I'm at LPC this week, and I'd love to chat with anyone else who's there
> >> in person.
> >
> > That would be good, but sadly I am not :-(
>
> Ah, well, there's always more conferences. Maybe EOSS next year?

I hope...I might have a lot going on in April...when does the CFP open/close?

Regards,
Simon
