Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7ADCD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 11:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DBB584119;
	Tue, 16 Jun 2026 13:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PNQR2SCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795D8846A4; Tue, 16 Jun 2026 13:47:16 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B0684105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 13:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6611669cd16so4597265d50.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 04:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781610432; cv=none;
 d=google.com; s=arc-20240605;
 b=jntIKUv1qEkxTgD8tTIg9nXKPsUJgcDro1xZ8mlRYuuiR6q30KiayXaJ6Hkq6BoQ3p
 2JYmy2iXCZYu1bNPsNLgkgaqSn4hbzL5Aovaxh7qkyFLt1+Tzdv5dly87Vtv7fTWYh9G
 z0Tkvw6fbI9HetkHCrzoe9RPBiW/wFSeSFJ/hMkfWcObboWXN2bY7fNdSvkuKTNaEdPp
 QlkUKWLM45mZu4NhUBEI+esM8RvjJ9Zj/QAfbNkoxLt7UR5nPqcXmMIwd/JdV4WuO5fk
 f3b3BLbrnbjEdwanYUlnKCAEr3rUTZxGI8IT95cNxZrcMrXikTFFBlR0BJttHhdmPqb9
 1l+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G8Cx1B8VrtM2qbMtBNHFPNBy3St5xMXhpkA1reIkJ2o=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=aKQjUn+Wx2WBsfhTOeWvuGAwWLD7yFSD+TUO5kFMdh8tLfZWkuOlkVKBoj14+Xo3Zw
 3EpLCmrK688cA7YJJalNtn0PRf9MR7GNVzl/t6kEviRq2Non+ZnBQdy9zfGdGTaA0+R+
 etSZXLsM4GZiQzW2AB8z0pCt2Bay38++x7c11sx3iPy/Y26jhpMbj1K7R9SnS7KXaguW
 G693SBZUeb87XV87rF3hOKiAsM76L7a0FsiCp09JQFJf0B2xeHNUeIapda63GZTHfgy4
 UoL3xItbMLN10fLz16Cf2xnmTBma1BnTEtlOho7YFZ6mgEPxu3WFikmHWqps4mCRfYNn
 eggA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781610432; x=1782215232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G8Cx1B8VrtM2qbMtBNHFPNBy3St5xMXhpkA1reIkJ2o=;
 b=PNQR2SCWWzjyPPCNyBoD2Uwdwsb785AtpA3mgZV9pAZIs151K5WJIHSDLDM9o3ugot
 1hFwYSl/lU9i/5THknqCNZOgsMys/x/wSn5ZfyVzBiWHgCupGZSUz5oljdkib6utQPrJ
 P5VAdgMk2ojbcewo3T1FvIW163ODcpeSkTYDhy5xg2IN9+bnAUCfo8nKIdh6OzCIReMc
 Drnzku6BRO8ymiaumdrmyzjsUnDKMSHIDkgFllE3gBajg22zmBUnknpq9Gv0JeHpoJon
 X26JkHSvSE1QNtnmGdBUHCQDajDh52yuiYiDdWuy68BYxzLeGneiFmOUu5riogtx+DMc
 n49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781610432; x=1782215232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8Cx1B8VrtM2qbMtBNHFPNBy3St5xMXhpkA1reIkJ2o=;
 b=VFx7GfluqOG1O+TS7GHamX01VDeEf+jTTfNmCn3Fy+BMcCLkX3K5nBYhFSINBKx97t
 CKqKDtbgIgCj/X9Gle5Qq94cgf0DAZsK92zXbmI1IcDjpBEzHAyphepDP02ubqSH8zEY
 ET8oXZWveyDX0oWtKh07vhFGASaD3itt94/yENjW+vowSEUd8aihgsGi9n4sqxHCnGVL
 +2PZKUC0lBRMrIUlFyswf14vGt9Uxr3WhFf/nu7QJMy0VJVft83+l234SEDXYARsvrtX
 /53P++iu4UmREAHKCUr+uK2wBkwCM6zFlP+HxecEBu0VJC8vnGRef9wjypdMDJrimGC1
 T5Ug==
X-Gm-Message-State: AOJu0YxaP5DGKaVaoRMuJrR10/isLIHDd672FouanV9xkTktS6wJm42q
 lxiPanQUx8WC6NoDdglmr/ssPgyZErslzQnVX2Ibf6bD3P+KEyQMNxRfoE7AqL5uHtPmIWdQ9+K
 lVeGSsohJJIywrJspHeIb4MsL7evtMbP3FOKQbGDR0A==
X-Gm-Gg: Acq92OENLrlSJCPBHWsi2W1mNCi8xiMXC0dA8OCnQwtI3a0oqmO+Ug1L7J+DFd61HT/
 Yv9oakCRNeDu5GsDHMV9iWoBVSJbN4KalgmpEBaeT24b0aUYWFBVfHt7BK/IthUe/ChyxtHc0E0
 IL+RdlKx25q0pBJrCnTwc1rxX4ZCvCUiU6X2Li9WCvcuvF6MdE/eSLSguN6n7z+uaecXUGe7R0C
 qOHdklJ9gcGVILAqsPPUe6e9w5hU/se/rGWiF23BnT1+Psxg+a8DHVNtp6h33XD34wgjs8ArC+d
 5DpFyAB8ASl+fcyt2DY8aKxj6GYOoJmnDe87QpfUApacEHLNG7k5wWmycn+E78dzYCbR507ODMz
 Yz3zV/bvzY2pHMYvCPl9PPF/eBhlwVBxzLGPVSt+Q/zWIuUEkewECEaVj8QH8VA6EPHI+AzrEQr
 amE9i8BiEPqfXogh9C0IDPJeNlLxfJtEz/S3X6SgpCd/mp0wGLhBim6+iXVvpBc45Z68gzgjDOZ
 0zofGwphSConbqNs2iWrSte2v6IGVqtdZQ5aZh6KnX73lNfc6K13xamp6IZ8mtyVAs3GzYVEszE
 W7HHVugapFM2a0eRs4T+6YayWYVXCEchYR2qPAj9dqapEL4+i7c+Bx41rJwQQLPAskFRQA85ENg
 tI+nVF4M=
X-Received: by 2002:a53:ac88:0:b0:660:689b:1539 with SMTP id
 956f58d0204a3-662b62ff158mr2470976d50.58.1781610431838; Tue, 16 Jun 2026
 04:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
 <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
 <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
 <35833068-3d06-4661-b98a-1633a6afbbb7@siemens.com>
In-Reply-To: <35833068-3d06-4661-b98a-1633a6afbbb7@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Jun 2026 14:46:35 +0300
X-Gm-Features: AVVi8CcVpWKE5_7DCcEJMJVujbs8Q7FgYVNwMgVXmF97nddZYZzrJDt9NyidIQM
Message-ID: <CAC_iWjJ-dMsT3W5fSZ8KUFZeUz8djPw4gs2WHZsfhOjZ6jktGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

On Tue, 16 Jun 2026 at 14:06, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 6/16/26 12:32, Ilias Apalodimas wrote:
> > On Tue, 16 Jun 2026 at 12:39, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >>
> >> On 6/15/26 15:25, Ilias Apalodimas wrote:
> >>> On Mon, 15 Jun 2026 at 16:09, Ilias Apalodimas
> >>> <ilias.apalodimas@linaro.org> wrote:
> >>>>
> >>>> Hi Ludwig,
> >>>>
> >>>> [...]
> >>>>
> >>>>>>>>
> >>>>>>>> I'd like the eventlog to be initialized before calling this (look below).
> >>>>>>>
> >>>>>>> What if I removed the log parameter from those tcg2_* functions instead?
> >>>>>>> The event log belongs to the tpm device IMO, so should be initialized
> >>>>>>> with the device.
> >>>>>>
> >>>>>> Measured boot EventLogs etc are primarily described by the TCG specs &
> >>>>>> EFI and we only have a specification for it there. The DT describes on
> >>>>>> how to pass it over to linux with sml-base etc.
> >>>>>> However, in the EFI case the Eventlog is allocated as ACPI memory. So
> >>>>>> you cannot allocate the EventLog a priori, until you figure out what
> >>>>>> method you are using to boot. We also have use cases people using it
> >>>>>> only for RNG, due to limited memory, so we can't just allocate it on
> >>>>>> the device bringup. And lastly... Some first stage bootloaders do not
> >>>>>> initialize the TPM & drivers. What they do is prepare an EventLog and
> >>>>>> expect U-Boot to replay it once the TPM is up and running. In that
> >>>>>> case we obviously need to preserve what we have instead of starting
> >>>>>> from scratch.
> >>>>>
> >>>>> Ack, we are on the same page here.
> >>>>>
> >>>>>> My main concern is that I *don't* want the EFI and non-EFI code to
> >>>>>> deviate. I have some patches that I am playing around for quite some
> >>>>>> time and rebased them last week for this reason [1]. If you think
> >>>>>> those help your use case or make your life easier feel free to include
> >>>>>> them.
> >>>>>
> >>>>> Good idea and orthogonal to what I am doing I think. This duplication in
> >>>>> EFI stressed my brain too but I can't care about EFI right now :-)
> >>>>
> >>>> It is, but the deviation in EFI is pretty minimal atm.
> >>>> - EFI calls tcg2_log_prepare_buffer instead of tcg2_measurement_init()
> >>>> -- That's what my patches fix
> >>>> - EFI has it's own version of tcg2_measure_event() -- That's easy to
> >>>> fix as well,.
> >>>>
> >>>>>
> >>>>> IIUC you are centering the change around calling
> >>>>> tcg2_log_prepare_buffer() in efi_init_event_log(). What do you think
> >>>>> about aiming for tcg2_measurement_init() as central starting point
> >>>>> instead?
> >>>>> That would allow to remove even more duplicated code.
> >>>>> It should be sufficient to have tcg2_measurement_init() accept an
> >>>>> optional pointer to pre-allocated log buffer memory. Attached patch
> >>>>> maybe explains the idea better (just as idea, won't compile).
> >>>>
> >>>> I agree. In fact I mistyped the functions names on my previous
> >>>> email.... I really meant tcg2_measurement_init(). The patchset I
> >>>> pointed you to already converts tcg2_log_prepare_buffer() to static.
> >>>
> >>> Replying to myself here, but.. In order to do that you do need the
> >>> unification patches. tcg2_measurement_init() will need to allocate the
> >>> appropriate buffer depending on EFI or not.
> >>
> >> So this is how it would look like with your patches on top:
> >> [...]
> >>
> >> IMO the untangle patch is not needed. Does that look sensible?
> >
> > You can skip the untangle patch the way you've changed efi_tcg2.c, that's fine.
> >
> > However, there's a few issues I tested for
> > - A u32 err; that's not needed in EFI anymore
> > - tcg2_measurement_init() calls tcg2_log_prepare_buffer, with NULL. I
> > suspect you meant to call with elog, since the EFI booting is now
> > broken and the kernel complains about an incomplete EventLog
>
> Oops. Yes, that was a mistake.
>
> > [...] But
> > since we've gone through that effort, wouldn't it make more sense to
> > have tcg2_measurement_init() set the priv->log if the pointer is valid
> > and provided?
>
> Yes, the series paves the way for further refactoring :-) The efi path
> shouldn't have the 'static struct tcg2_event_log event_log' anymore IMO.
> Should be sufficient to hand the allocated buffer to
> tcg2_measurement_init() and access the log structure in functions that
> need it though 'dev'.

Exactly.

> Refactoring (and testing) the EFI path is out of
> scope for me at the moment though.

Fair enough, I've sidetracked you enough already.

>
> Anyway, do you want me to submit your two patches as part of the series
> or you want to follow up yourself?

Carry them over imho, they were rotting in my branches for 1+ years,
but I never had the chance to send them. Your patches were a good
reason to rebase and revive them and they fit right in as can only
rely on tcg2_measurement_init now.  I'll test/check the v4. I haven't
gone through your changes in depth but they seemed reasonable, so I
think this is fairly close on getting in

Thanks for the patience
/Ilias
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
