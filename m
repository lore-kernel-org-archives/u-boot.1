Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A32C25B74
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 02:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB218871F;
	Fri, 31 May 2024 04:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQp7Txnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F1F8872D; Thu, 30 May 2024 23:33:19 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D9188728
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 23:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-794e5e77ca2so91947685a.0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717104796; x=1717709596; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1usJbMmLdd6w9IQ15huj6ZRV7kAv40ez5nzx0fLtbsY=;
 b=HQp7Txnqjge012cwAzbJ0oTHFQiv6+4iOWxSccfKCHBfcWbRxNaoS0CJJo2jrshV+r
 2h7MLn5me13kM57pKNv+dvTPVZGKpp56WMZrsqM4wuLqugVhI7yhI5wr+ovMdcE3s1OV
 fPMDPwRc2ExlKnT0eAtUPlVYk9xaXhMJMWq6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717104796; x=1717709596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1usJbMmLdd6w9IQ15huj6ZRV7kAv40ez5nzx0fLtbsY=;
 b=bRvMvb6y0/LRgUx1nWWBOP2QkZ18iWR7MzKk48nThuNpZ9AysPegLN8WBHL2/rGrYL
 ixN3qUNzZHxyG1bQCplOncSBFgKYKHHjBloo3pFd2IpNMVNXpHpHFdlenVCCdhseeRxp
 s4bIRUesN4LSHrwM6CuGRGK5vcnxSQBUfbvd5T9MrHh80hQbGFGSal6LtQzgOpjH+/Ya
 +6H0dFEN2j+GSnjHVe7y6XfpQg0Ld11nWr4h7H/Ql6+tS0wcWH/yUeZ+xShvPVcr+cLz
 sijktCZazkk0Izhzs2iLsp0EymuJ2lW6YRXzPBH8bUhKO7dHkFSW3LErZb8s4R87Q0Ks
 6VxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhWIkfO6leWNd/5lsNT5GLDmjBi8Lr30HtxLLzRMVdPSPlowPOgrYIS+xiGYSbyDhLJwdIx8l6vDbyWg03S+VU+TYU1Q==
X-Gm-Message-State: AOJu0YwMtjUVWsJKwbqzio7tuP3RvF0pphjI7ZYBeWzxssXdvURUFUBt
 abyBOWg4/23SINvzT148VDYl/zseuLPPqtUNCSCcUYvCc59JrAI28gsGgdXZ3YOmIzrW4lxygZ7
 BkbjEzIh46TvWXkEXDWHQxNp6nVfWJILrPR8S
X-Google-Smtp-Source: AGHT+IE01cpfNZgOgIFSZ8cPbBpw0zQtytSfGA1payIEb56EMo6kF071sLdOC7agZjBGLe83ffUJqeIP5WBvqPEwSVo=
X-Received: by 2002:a05:6214:328c:b0:6ab:842a:dd48 with SMTP id
 6a1803df08f44-6aecd6dd1camr1291906d6.45.1717104795700; Thu, 30 May 2024
 14:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240525200249.3904352-1-tharvey@gateworks.com>
 <CAFLszTifTgSGjAZ-t7-7q6FYRjQ1kfH6hn2dw-hb0PK-2Z3WRg@mail.gmail.com>
 <CAJ+vNU1yQaLgW5f1tSHiZtbWQ_7GPs87GV3FHNK3uvCiFpLvZw@mail.gmail.com>
 <CAFLszTjwuDeQ=xxF8cpMoHmpVPVDkeKKM1a8QRGmVLFzCU=ZSA@mail.gmail.com>
 <744a2f92-18d1-4830-98c0-c6c686cd11ef@denx.de>
 <CAJ+vNU1Cse7ym46kS-85cfKUKAL7noKFuGhXSaJssx1mvLD9Tw@mail.gmail.com>
In-Reply-To: <CAJ+vNU1Cse7ym46kS-85cfKUKAL7noKFuGhXSaJssx1mvLD9Tw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 May 2024 15:33:04 -0600
Message-ID: <CAFLszTiR8Sgn8UtqA2T2rYCo8vrUOexRk6t1Y3Yia7EGpO1y_Q@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 31 May 2024 04:58:26 +0200
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

Hi,

On Thu, 30 May 2024 at 09:17, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Wed, May 29, 2024 at 6:39=E2=80=AFPM Marek Vasut <marex@denx.de> wrote=
:
> >
> > On 5/29/24 7:05 PM, Simon Glass wrote:
> >
> > [...]
> >
> > >>>> that is not yet implemented as DM_RNG. We also skip this if
> > >>>> MEASURED_BOOT is enabled as in that case any modifications to the
> > >>>> dt will cause measured boot to fail (although there are many other
> > >>>> places the dt is altered).
> > >>>>
> > >>>> As this fdt node is added elsewhere create a library function and
> > >>>> use it to deduplicate code. We will provide a parameter to specify=
 the
> > >>>> index of the rng device as well as a boolean to overwrite if prese=
nt.
> > >>>>
> > >>>> For our automatic injection, we will use the first rng device and
> > >>>> not overwrite if already present with a non-zero value (which may
> > >>>> have been populated by an earlier boot stage). This way if a board
> > >>>> specific ft_board_setup() function wants to customize this behavio=
r
> > >>>> it can call fdt_kaslrseed with a rng device index of its choosing =
and
> > >>>> set overwrite true.
> > >>>
> > >>> I suggest creating a sysinfo driver which can provide the RNG devic=
e.
> > >>
> > >> I'm not really clear what you mean but that seems out of scope for
> > >> this patch. If/when someone needs to extend the functionality of
> > >> specifying one of many RNG's perhaps they can follow that approach.
> > >
> > > The thing is, you are creating a way to specify the RNG which will
> > > presumably lead to different vendors all doing it a different way.
> > >
> > > Specifically, fdt_kaslrseed() takes a device number (would be better
> > > to take a struct udevice, BTW).
> > >
> > > Instead, I think you should define the standard way that the chosen
> > > RNG should be specified by the board. The sysinfo driver can provide =
a
> > > way to do this. Then boards can handle this themselves, using sysinfo=
,
> > > rather than directly calling a function in the fixup. After all, we
> > > want the fixup flow to be as generic as possible.
> >
> > I think this patch simply picks up the first RNG that is available,
> > pulls a number out of it, and uses that as the KASLR seed in DT. That's
> > what the implementation(s) seems to be doing so far, this patch is a
> > deduplication only, so maybe we should retain the original behavior
> > first, and do architectural changes in follow up patch(es) ?
>
> Marek,
>
> Thank you - I had a draft saying exactly the same thing that I hadn't
> sent out yet.
>
> This is an incremental improvement... for sure there are follow-on
> improvements that can be made and should be made but the sysinfo and
> policy creation are something I don't have time for at the moment and
> may not be the right person to implement that. I'm happy to accept
> something to add to my series though!
>
> So the question is, if we can agree that improvements can continue to
> be made later should I do one more revision that split this out into
> three patches and fixes the typo in the commit?

OK, well specifically, my objection is to the 'index' argument, since
someone will pass 1 to it and then we have a new API.

So if you can drop that and go back to the hard-coded 0, then I agree
this is just a refactoring and yes, this is fine.

Regards,
Simon
