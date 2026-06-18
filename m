Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFC6CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257CF84874;
	Thu, 18 Jun 2026 15:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mHE8EMhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093AC849A1; Thu, 18 Jun 2026 15:25:35 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B79E847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-695737cf38bso1260156a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789132; cv=none;
 d=google.com; s=arc-20240605;
 b=M1/E074C8MU5zvRKImGteB9A/NfkG/0NnIrE71z0wtgzKuCv7x8V177VpAjpn31lMp
 KvR+KJmXIsxqc7tms8R29lnNnzsjpkbLLfIQNZ7u/zOJxCWOAF2Kn5Ytvyzypr1Nx7Ym
 pkWaxQXOYi6818Iq6BjSMeqDwrlr5r32OQSsz5GjXQW5ruYoKTCQ7M7IvvdcKtfdIn96
 +D5mATKL2NCuwHAkmfLAksn/V3MlyfowiPHrY6fD8l8AAw6WbHHYKjE4RGQaLK5oDnl2
 NR8et6CqiFJyTJJBTRHhvC0U+YX/YfCjJrAXH9nrA5Vm95qxvPkfg2CLi3hlGDbUWlOf
 sejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dAw1mVDscr/odfkCQHzskeVoPTyycuJoNTdWVz7lOSE=;
 fh=gNOd5VoWOThJSezvTZCfMINjufFCHR/n3KUZhadKTwM=;
 b=B89ySDtSbiqUndqZxQBH1NJwv01WU1gw37pYoOR6xOtei2VClMAN2eLuiCbWdAxI5t
 zPUPe1DZ4/M/LacboOul3TwWtSbkYfb6BJvPfo4QXOnZew6HQJ5WCJQI6E3zueqPrmJc
 HwOrUyzmhK/tpYUlBua4TY81uFVz/QxgXtJQwr+nOmfVl1yO53R/7IMX1iLPRiYu92Ap
 A53wDaqUsKKEqb0qfLTQwkhM7MIlDnA0IzSxzTg3JEwbIiSWo7XnZPOjwxtiW+fiX6YZ
 HEwCSr2gxFG42DqmV7rszno7VkharLxS1AoLDHhVNyrGQWoAOXlq9WqKkhUffET0P17p
 68tg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781789132; x=1782393932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAw1mVDscr/odfkCQHzskeVoPTyycuJoNTdWVz7lOSE=;
 b=mHE8EMhNtxBuh0l7en8U7PwJ6uYcYLBydIzsHvuS+qAzXzPwQT6LaiMmEp0zcYkuF4
 ul9zbV6938vz1QmyPZPr5bW402LCITEoZPljRrnZwqOCJHYypNxbE9k+4draDduf665z
 GCyqRySbHg7mXutFc2NL03xMODSOHEUElRsZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789132; x=1782393932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dAw1mVDscr/odfkCQHzskeVoPTyycuJoNTdWVz7lOSE=;
 b=ftxZQYU3kegRDL3BprrwOy60hu0MyVnSuvssATdMB0wI2i3e8n0JjrbY97WV6IkH44
 QLYidX60RMahcwyJCcN3rq/kBuUOc0cbjTghq7jMECyJ4o6/P6YZWtccq4fFgHCvT3tT
 gTJqJ2bKT0eLdee5LFBBpoFZdxe9YwLgTS6pR/u/MS1usPwD/NYNu1p6XdTzexgGhanS
 Dg996S8Hd79R01EQCaL817p7t2/5ZJSUorH8N5YywBZ5EgB7PhCsZMZ/T53JwIMDOSm8
 i6ftQf9SFDr96rjMXK/4Nus7t/ju2Cy4XtJQUkImeWjEWq0t+ycfOYuOaCWlJCfLs8jJ
 /yXg==
X-Gm-Message-State: AOJu0YzaTyHMsWTo/8vzODJDTjIRG06gIcmFjtccxM82o81SgYkX/qnt
 n6zJKzQ449NKy6fepJG4qTpKM4stklrSeX6q2oxYh7QuvdM+Lgzbpy1A/I3yRzsBZBA7BwPkJtG
 mrsxVpyxwMF7hWTJ7QckQ/4DVX3uw0dI34yA0psrI
X-Gm-Gg: AfdE7ckUZfWqetsIb5r5WybQVFgACUMgPXoCCpD/zO75FAKdXXirVV97S80T25GKyLR
 GmDXlIXPvZyBcH/A3PN6YdPARayXn044bgsReh2hCcq2/OMsCQ4C3DQuNako5qDN/7W+6ec0j8k
 aCbyVNNB5fWHOYOFhKo3/Xgfj4UDwagVbNA+rEp5IR0AbpodwwGOFqHpGMjGM7wUwCBwGN9P1O8
 URZ58PCLCvIJ2Rj2JGHyGQu3GKSROOEpqCJs+32YDrPE9EXwdgoxblNoP+YhRV+H2fphoM5zQ==
X-Received: by 2002:a05:6402:1f86:b0:695:572a:7ab5 with SMTP id
 4fb4d7f45d1cf-695572a825dmr3992594a12.19.1781789131794; Thu, 18 Jun 2026
 06:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260524151431.72296-1-aristo.chen@canonical.com>
 <CAFLszTitaXsCZn1e45m+Wn0v0=mD5LVdpb3vtZJZgcvGr8yqGw@mail.gmail.com>
 <CAA=k7=k5NjdPEV6jVtxWBhVuL602J7eFP7TLM6aQtL+mKyVT9A@mail.gmail.com>
In-Reply-To: <CAA=k7=k5NjdPEV6jVtxWBhVuL602J7eFP7TLM6aQtL+mKyVT9A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 14:25:20 +0100
X-Gm-Features: AVVi8CddaD1L8jwBmPfFkDo-_e-iXj9vtXeS72ytOQTs8i9uQnABb9u9jYy8mfg
Message-ID: <CAFLszTiBWAwqGnBnGFZdBqcLbYs+=yiQws4dFw3HPBGEYQGSeg@mail.gmail.com>
Subject: Re: [PATCH v1] bootm: bound-check OS index in bootm_os_get_boot_func()
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Aristo,

On Tue, 16 Jun 2026 at 11:02, Aristo Chen <aristo.chen@canonical.com> wrote=
:
>
> Hi Simon,
>
> On Sat, Jun 13, 2026 at 2:22=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Aristo,
> >
> > On Sun, 24 May 2026 at 17:11, Aristo Chen <aristo.chen@canonical.com> w=
rote:
> > >
> > > The boot_os[] table in bootm_os.c is a sparse array whose compile-tim=
e
> > > size is set by its largest designated initializer (IH_OS_ELF), giving
> > > it IH_OS_ELF + 1 entries. The accessor bootm_os_get_boot_func() retur=
ns
> > > boot_os[os] without any bound check, even though the caller in
> > > bootm_run_states() passes images->os.os straight through. That field =
is
> > > populated by image_get_os() from the raw 8-bit ih_os byte of a legacy
> > > uImage, and by fit_image_get_os() for a FIT, neither of which clamps
> > > the value against the table size.
> > >
> > > An attacker-supplied image whose OS field falls outside the populated
> > > range therefore drives an out-of-bounds read of boot_os[]. The caller
> > > only rejects a NULL return, so a non-NULL adjacent global is accepted
> > > as a valid handler and invoked through the indirect call in
> > > boot_selected_os(), turning an unsigned image with a malformed header
> > > into a jump through an attacker-influenced function pointer. FIT
> > > signature verification covers the os property and mitigates this path
> > > for signed images, but legacy bootm and unsigned FIT do not.
> > >
> > > Reject out-of-range indices in bootm_os_get_boot_func() so the existi=
ng
> > > NULL handling in bootm_run_states() reports an unsupported OS and
> > > declines to boot the image.
> > >
> > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > ---
> > >  boot/bootm_os.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > I would rather put this check earlier and only for legacy images, to
> > reduce code size. For FIT I believe this cannot happen, right?
>
> Yes, you're right, FIT can't reach this. boot_get_kernel() loads the
> kernel via fit_image_load() with IH_TYPE_KERNEL, and the os_ok check
> there already rejects any image whose os isn't a known type before
> bootm_find_os() reads it, so images.os.os is always in range. Only the
> legacy path takes the raw ih_os byte unchecked.
>
> I'd lean toward keeping the test in bootm_os_get_boot_func() since it
> sits right at the boot_os[] dereference that every caller goes
> through, and the cost is just a couple of instructions in
> CONFIG_CMD_BOOTM code (not SPL). But if you'd prefer it scoped to the
> legacy path, I'm happy to send a follow-up moving it there.

Actually I do think putting it there is better, since adding a check
for the FIT case is actually confusing - the check can never fail! So
let's deal with this problem in the legacy code, so as to avoid it
bleeding into the FIT code.

>
> >
> > >
> > > diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> > > index ae20b555f5c..69aa577a2fc 100644
> > > --- a/boot/bootm_os.c
> > > +++ b/boot/bootm_os.c
> > > @@ -599,5 +599,7 @@ int boot_selected_os(int state, struct bootm_info=
 *bmi, boot_os_fn *boot_fn)
> > >
> > >  boot_os_fn *bootm_os_get_boot_func(int os)
> > >  {
> > > +       if (os < 0 || os >=3D ARRAY_SIZE(boot_os))
> > > +               return NULL;
> > >         return boot_os[os];
> > >  }
> > > --
> > > 2.43.0
> > >

Regards,
Simon
