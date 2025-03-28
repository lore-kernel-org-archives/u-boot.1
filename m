Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5856C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36896810F4;
	Sat, 29 Mar 2025 00:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OMs28pqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF60481E47; Sat, 29 Mar 2025 00:42:38 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ACE2805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so503480466b.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205353; x=1743810153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=spg/ecupFQqGBAMkuvdsbj8G0gRdpU6ywU54LrKCdew=;
 b=OMs28pqHANGlKFISssqkaTxI/8LUPM4xvbR0Oom/txn6VReyqYnlnQFVO7U23Jab0X
 8ZeFBhPr4QZqr9B3sUNnNmgWCSn/0dOUS/te6eyZlZwaw/Hnb6EXDtq3qRzpfTrAX0/6
 CMNYK28PL8bhq9bn9osjrhDZ90ahIBlRfKQ40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205353; x=1743810153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spg/ecupFQqGBAMkuvdsbj8G0gRdpU6ywU54LrKCdew=;
 b=pvaE/DnWVzlRr8DPlzMBOvfh6m237+I6UlroWHZI/kpdsF7O0DkdKw4J8aV8VLZgOY
 S7wJQ9LuK47fDi2USr90+MDg5b2Wd9wQQiheLNrV37Az/wkyUjsBiwLkPIU/BY8gw/Tl
 JYyCamFFNMT7CPHwAjSto6LEYgMHsgzKLCQoe9m+p3xMlxLYRipGSyAuL3d8dzpabV8N
 rLTAglWM9VxmMi8sJ8ccS4Z+OnFeBaoNfI77nR7mzJyIFooh5btnGOHCcsYVSZgbqQnW
 tGdDosVJ4kY1MN1KA+8laPdviBR8WUd2qRUdfWDw/naSzvLHlkJXkdrgR6welPCWbm+M
 VD4Q==
X-Gm-Message-State: AOJu0YzFm2PT1P8JavQVN/t8ADWXdagFgKmrVPU/pLIZwXLPbIy1lH+y
 WkHytt5pe8bZOwnQgDaLgzKXTiRQ+cE7GYzF1DLE621v1V/GJvCZV/96t18q8ra6yMnguJlgi7t
 mvK6Ofm5BSKBeY+TZA919YBXRnLOvo/JM5yFrXfT/mM5TMJk=
X-Gm-Gg: ASbGncs40Jch9mMQ6yLDgS0yDL3NBX1ky3Al1wXjnqwe00g+cE1inC4+lmrE8iBNEVg
 auaIBxoxPsBiQUPquGI5n2IqB8hqjpj6II6u6bBtajlNeZnZ0CF9Gr1brban0xzLYFMjDSzVySh
 /IAVT5VYCKyfEWim9m6dQe8uy+9hVDiugvQobmKg==
X-Google-Smtp-Source: AGHT+IH1fgxjKKC7ZzlSgLgFKzI0I+HGZBu1E4B0kZbLyoiCOQXLQEI1FurCzjhs2Qdxm+2/7iB9jM3LIY1Td4SRaek=
X-Received: by 2002:a17:907:8689:b0:ac2:7ce7:cd2b with SMTP id
 a640c23a62f3a-ac736707a4emr163165166b.2.1743205353500; Fri, 28 Mar 2025
 16:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
 <20250310155336.GJ2640854@bill-the-cat>
In-Reply-To: <20250310155336.GJ2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:42:20 +0000
X-Gm-Features: AQ5f1JrYlftOLP1MPCOHB-nPK20aSlxT60fm4GADGV8IIIws1DP3R36jBHVivbg
Message-ID: <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in the
 project)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> [snip]
> > > Again, back to this thread, if you want me to migrate things, consider
> > > applying the sunxi patches as I have described above. I will then look
> > > at the next target for bootstd. But while you hold this up, I cannot
> > > move forward with more bootstd migration. It doesn't seem that much to
> > > ask.
> >
> > I will take another look at what's still relevant. But I believe it's
> > still blocked on the fact that it changes behavior and breaks users.
>
> In details:
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-sjg@chromium.org/
>
> Now that the underlying BLK problem is resolved, this can just be
> dropped I believe. Removing the BLK dependency from BOOTSTD can happen
> when you're supporting a flow that lacks a BLK device entirely. This
> would be another reminder as to why putting unrelated changes in a
> series is a problem.

OK, then just don't apply this patch. Problem solved?

>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-3-sjg@chromium.org/
>
> This is fine.
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/
>
> This is not fine. This is also not a sunxi problem. It means that we
> should drop bootmgr from rockchip, where the conversion has already
> taken place, and would need to drop it from future conversion too.
> Neither of which are desirable changes.

Why do you say that? I don't understand how this relates to rockchip
or why we would need to drop bootmgr from that.

> This patch in particular is
> where we have the note:
>
> "Yes, the introduction of boot standard changed the boot order and
> specifically deprioritizing scripts is unexpected."
>
> Which should have had more attention than it did.

From memory the scripts are a fallback used when the other things
don't work, so that was the decision I made at the time.

>
> This is the thread that to me spelled out in details where the
> conversions are now blocked. We changed behavior and that in turn breaks
> users that have come to rely on ordering.

I don't know what action to take on that comment. We cannot have 100%
backwards compatibility with the scripts, which after all weren't even
documented. But it is very close.

>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-5-sjg@chromium.org/
>
> Is an alternative to the above which then turned in to a discussion that
> I would very briefly summarize as "no discussions were had between
> stakeholders before integrating efi bootmgr with bootstd".
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-6-sjg@chromium.org/
>
> This is fine, but only relevant once migration happens.
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-7-sjg@chromium.org/
>
> If Andre is fine with this, this is fine.
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-8-sjg@chromium.org/
>
> This is a generic bugfix. I will take this to next today.
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-9-sjg@chromium.org/
>
> If Andre is fine with this, this is fine.

Well, is he? I thought he was. Can you check?

Regards,
Simon
