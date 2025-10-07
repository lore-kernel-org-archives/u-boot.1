Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AE9CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 17:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCA783939;
	Tue,  7 Oct 2025 19:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="THUf0nGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBDA83927; Tue,  7 Oct 2025 19:47:16 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4391A83939
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 19:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-43f4650340eso3539758b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759859230; x=1760464030; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sr4Vie+wS/gNKXvSpYDxdvU9FCp3EEvPPv5577QVNBg=;
 b=THUf0nGwsUL60SvRFWAgtox4P3061r1pjd5OEnx70cneLZfVZKAtv5iUC/9f8x82QN
 O11DnHLxq3yR1oryar5glBHnfUArLqI3bDRRwUOBBINYsEuwO4ZRh8At4sLknxQtQMZ4
 JiWC/kB5/2rKg26t/+guaRp5aRvBMaAdjbUS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759859230; x=1760464030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sr4Vie+wS/gNKXvSpYDxdvU9FCp3EEvPPv5577QVNBg=;
 b=QHj83yT9/iU+LyI4U/t5fu2pLED6j0ygnZcNyOu8oRe7B6nDnZn8PmjeUr/T8Ml5N3
 EUM2XRN3rcisoTQje+KrCOevpfO9Qcb5tjgkZPdLAGbWofU3Pf6KryEkvEwzcvewJaMe
 3nXxiOoLsEZYso8YzSOS9uw0Jrgck2qjczj6KolWQqShQHAWeV/9xvr4gOsk0E5yAUsA
 DEyzAc3BKZHThu3xWeS5kd3C4dq0N5dYnB/zEasIbeQLjQlEicaEwaZx1uwnjSFDpH+Z
 tmGSSAC8qVPny229168ETf1mhQLKYTl2vzTIp9a8SVYu6k5GIVluff6Vy5llHJzIj24B
 UbFA==
X-Gm-Message-State: AOJu0Yx+RVriE82sMzZ9stgCfkzaMxagytOLDuHnRSnrYFFbNvrne+Uy
 Bbb2dIrLW3CLyLNDBFlroqLBfEcDsQn/QgKPNs5TlbVWpQ5jm9rS90ocuFs317RDKhjAkPMqCMc
 KoMRgRds=
X-Gm-Gg: ASbGncsq/guq/QhDD18GSKeriyMQXIRe2tq340UOnrqzAREoJOLKtD4zt/P1aS8Lmzd
 YZwPSOIMNwBdzS2/yVxKuIlp74Ow0fYCUIbAkUwieUU5jwkFqGDKdlrQMrB5Uum+XOU5tCOSUVo
 xs6phBW2SXIpZQhjhkeGc8sRcWHmpjPwdP+aJYN6pM6HQXJqwF3FX3Qtkdyu2DKpX96yly0U6b9
 mUIIt9tA9ydkgrTqs0BtaKM6BteKqQRXyEBU641H7JH1IEWBp39xFKbBMtTl2fXWjixujji5IRM
 Jk1de/qstZyPDxuBsNwsqHN0Wn88ShPCqERGH7INDoXzvv+RUMBW5hmN9DyT8C4Q4DL2w4//bns
 CCPZb2P4hNKB+u7AqtANcuVfRXCsqNqkmnJUMD5PL9Te/peMpciwV25NKXYKHjaBJZaioEC4ZSH
 qSBxxr5wra8g==
X-Google-Smtp-Source: AGHT+IE441rKJRw0ccRpufeU8rKbcTp0CtIUyFFAmdXVHQ675/LXlHhO//yK5/1gw7N2gdw/z2KIUA==
X-Received: by 2002:a05:6808:1591:b0:43f:78ff:65ec with SMTP id
 5614622812f47-4417b2ea5e2mr222009b6e.19.1759859229673; 
 Tue, 07 Oct 2025 10:47:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43fb25b991esm3830365b6e.26.2025.10.07.10.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 10:47:08 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:47:06 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.10 released
Message-ID: <20251007174706.GM298503@bill-the-cat>
References: <20251006191406.GB298503@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KfHHQGaDhwhLDuCk"
Content-Disposition: inline
In-Reply-To: <20251006191406.GB298503@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
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


--KfHHQGaDhwhLDuCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 01:14:06PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and so here is v2025.10. I will be merging the next
> branch back to master shortly and pushing that out as well.
>=20
> As this is a full release, and not just a release candidate I'm once
> again hoping for a few more people to read this than do my -rc emails or
> just regular mailing list posts.  As I mentioned with the v2025.07
> release, I was looking for a few people to step up and help with the
> overall organization and management of the project. To that end, Peter
> Robinson and Neil Armstrong have stepped up and have been helping me.
> This has been part of the process for the project to join up under the
> Software Freedom Conservancy's (SFC) umbrella and have a legal entity
> that can help the project work with other legal entities on things like
> donations. To that end, we'll have representatives from SFC on the next
> call to answer any questions or concerns people might have.
>=20
> With that said, we'll have our regularly
> scheduled community meeting tomorrow.  The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> October 7th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

The meeting transcription from Gemini is at:
https://docs.google.com/document/d/1ww2zFC1d9DG-Wybmo_Nz5u9IuvTO2UwJCAx2C-d=
Zy9w/edit?tab=3Dt.oyswh1neakco
and I've only edited to show that MV is Marek, in later contexts. The
summary, aside from a few errors (AP Boot Manager should be EFI Boot
Manager) seems correct. The link is viewable in a private browser
window, but here is the summary tab (the full transcript is also
included) as markdown.

Oct 7, 2025

## U-Boot community meeting

### Summary

Tom Rini announced that the U-Boot project is joining the Software Freedom
Conservancy, with OSU OSL offering to host a GitLab instance, and the migra=
tion
is aimed to be completed by the end of the year. Discussions focused on
standardizing boot flows for embedded systems, specifically integrating TFA
into a FIT image and proposing it as an extension of the FIT image boot flow
rather than a strict UEFI standard. Key topics also included moving the AP =
boot
manager to the end of the boot chain to improve flexibility, integrating mo=
use
pointer support, and updates on Kbuild and MMU features.

### Details

* **U-Boot Project Joining Software Freedom Conservancy** Tom Rini announced
that the U-Boot project is set to join the Software Freedom Conservancy, wi=
th
paperwork expected to be signed shortly. This move will facilitate resolving
challenges such as migrating from Denk's infrastructure, with Oregon State =
Open
Source Labs (OSU OSL) offering to host the project, including a GitLab inst=
ance
([00:01:28](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.69uuqh2ce80q)). A representat=
ive from
the Software Freedom Conservancy expressed their excitement and willingness=
 to
assist with any questions
([00:04:12](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.hkg52to2w760)).

* **Migration Timeline and GitLab Instance** Heinrich Schuchardt inquired a=
bout
the migration schedule, with Tom Rini clarifying that while there is no
immediate rush, it is desirable to complete the migration and data backup as
soon as reliably possible, ideally by the end of the year. Tom Rini confirm=
ed
that OSU OSL is capable of running a GitLab instance, addressing concerns a=
bout
the specialized skill set required for such services
([00:02:52](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.qpi1k2wejoy0)).

* **Boot Flow Standardization and TFA Integration** Heinrich Schuchardt
initiated a discussion on supported boot flows, noting Marek's (MV) interes=
t in
booting via UEFI using a FIT image that includes TFA (Trusted Firmware-A)
([00:05:49](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.s6w9d233u8po)). MV further el=
aborated
on current issues with bundling U-Boot SPL, DRAM blobs, TF-A BL31, and U-Bo=
ot
into a single flash.bin, citing licensing concerns and the difficulty of
updating TF-A BL31 separately
([00:07:43](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.el7xywl0griw)). They proposed=
 a
standardized boot flow where the bootloader loads the FIT image, including =
the
kernel and TF-A BL31, to simplify updates and ensure ABI compatibility
([00:09:30](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.o081i45tk1uh)).

* **Debate on UEFI and Firmware Bundling** Andre Przywara expressed concerns
about bundling the kernel with secure firmware like TF-A BL31, stating that
secure firmware should ideally be part of the device's flash and in a separ=
ate
security domain. MV clarified that starting TF-A BL31 from a FIT image via
U-Boot running in EL3 is already functional upstream and their goal is to
standardize this flow with UEFI
([00:11:03](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.xx2r3tv04fud))
([00:23:07](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.tk7jgdwuir6l)). Tom Rini note=
d that
while open-embedded distributions might support such bundling, other
distributions like Ubuntu or Red Hat would likely not
([00:12:13](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.671m41uhflpb)).

* **The Role of UEFI in Embedded Systems** MV articulated their interest in
UEFI for embedded systems, believing that larger embedded systems will
increasingly adopt standardized boot flows, which they see UEFI providing.
Andre Przywara questioned the necessity of UEFI for MV's embedded use case,
suggesting that the described flow is a pragmatic workaround rather than a
standard UEFI approach ([00:14:01](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.ua0wnf=
htpog)).
Tom Rini acknowledged that ARM's perspective is to move towards UEFI for all
platforms and that MV's problem is a recurring issue that needs a solution
([00:15:20](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.gp5usmy34p5y)).

* **Challenges with Standardizing Boot Flows** Simon Glass questioned how G=
rub
would handle a FIT image if UEFI were used, suggesting that Grub might not
inherently support FIT images. Heinrich Schuchardt clarified that Grub can =
be
placed within a FIT image and started this way
([00:20:19](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.et19coo8jdd)). Ilias Apalodim=
as
corrected the misconception that U-Boot functions are inaccessible after
running Grub under UEFI, explaining that they remain accessible until \`exit
boot services\` is called by the OS
([00:19:23](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.kyn38w6xqllt)). Ilias Apalodi=
mas
raised security concerns about loading BL31 from U-Boot, as BL31 is typical=
ly
authenticated by silicon keys and should run in EL3, while U-Boot usually r=
uns
in EL2 ([00:21:20](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.u58myncx66h4)).

* **Proposed Solution for Boot Flow Standardization** Tom Rini suggested
documenting MV's proposed boot flow on multiple non-IMX platforms, such as
Renaissance boards, to establish an "ad hoc" standard for 64-bit ARM platfo=
rms
dealing with potential kernel breakages. Andre Przywara proposed treating t=
his
as an extension of the FIT image boot flow, making it a U-Boot standard rat=
her
than trying to fit it into the strict UEFI standard. MV concurred with this
approach, agreeing to not focus on UEFI for this specific boot flow
([00:24:21](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.1oi3q6x0ziml))
([00:26:49](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.1gmyx6dnamg)).

* **Moving AP Boot Manager to the End of the Boot Chain** Heinrich Schuchar=
dt
discussed Simon Glass's 17 patches aimed at moving the AP boot manager to t=
he
end of the boot chain, just before network booting
([00:31:28](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.g4y66tc6cx8p)). Tom Rini expr=
essed
optimism about resolving outstanding points and stated that the changes are
moving in the right direction. Simon Glass explained that this change would
make global boot methods more flexible, albeit more complex, by introducing=
 an
order to their execution
([00:33:02](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.jbkt0hflfk5s)). Andre Przywara
supported this change, noting that the global boot method was previously
unpredictable and an established order would solve existing problems
([00:34:29](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.ufyp2uxkjl3f)).

* **EFI Boot Manager Improvements and SunXi Conversions** Heinrich Schuchar=
dt
brought up the possibility of integrating mouse pointer support from EDK2 i=
nto
U-Boot for graphical boot managers, a feature Simon Glass had been working =
on
([00:34:29](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.ufyp2uxkjl3f)). Tom Rini requ=
ested
prioritizing the resolution of the global boot methods issue before tackling
additional large series of patches
([00:35:39](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.3id2x16rmft0)). Andre Przywara
highlighted that the SunXi conversion to standard boot is currently blocked
because the global boot method takes precedence over existing boot methods,
causing breakages for users relying on traditional boot scripts
([00:38:52](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.x428xffwzdy8)). Heinrich Schu=
chardt
encouraged Andre Przywara to test Simon Glass's latest series to address th=
is
issue, which Simon Glass intended to resend
([00:41:15](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.8xnc1coo6x1d)).

* **Kbuild and MMU Updates** Tom Rini reminded Ilias Apalodimas about
outstanding Kbuild updates, which Ilias Apalodimas confirmed Sugus was hand=
ling
and would post soon ([00:43:47](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.u8luwdvjp=
l9n)).
Ilias Apalodimas noted that the most challenging part of Kbuild, shared lib=
rary
linking, had been completed without issues
([00:44:44](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.735mexbsad5k)). Heinrich Schu=
chardt
inquired about the status of setting the U-Boot binary to non-writable in t=
he
MMU, to which Ilias Apalodimas responded that memory permissions have lande=
d in
master as an optional feature, but configuring EFI runtime services as
read-execute is still a complex ongoing task
([00:45:47](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.mn59kqyfilfq)).

* **Conclusion of Meeting** Tom Rini concluded the meeting by thanking ever=
yone
for their time and scheduled the next meeting in three weeks, following the
normal cadence. Tom Rini encouraged anyone with concerns about the U-Boot
project joining the Software Freedom Conservancy to reach out
([00:48:03](?tab=3Dt.ef7rmkft6mg6#heading=3Dh.lrh9q6iwa0a9)).

--=20
Tom

--KfHHQGaDhwhLDuCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOVSFgAKCRAr4qD1Cr/k
ChqhAQCdkan70wrJ/X77SU6rkFVru/rOg/0/5RILSSdSu4MQOgEAsNSXCx3u9ult
wUUiMYYF2duBszEA/MGBCXLAiVRhbA0=
=CQOk
-----END PGP SIGNATURE-----

--KfHHQGaDhwhLDuCk--
