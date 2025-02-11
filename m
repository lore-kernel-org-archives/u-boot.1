Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5D3C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 20:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4064180BAD;
	Tue, 11 Feb 2025 21:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mx9+4fhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B27C80C5A; Tue, 11 Feb 2025 21:49:37 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBC980842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 21:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f710c17baso61992085ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739306971; x=1739911771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YTrrNAuqSBTnZAsA8ClJH0vb18KzFkXhYJU1a0sN/yc=;
 b=Mx9+4fhPVZXN7Q4HStCWXiiANIQSzT9GiEdbybw9fH3EoGV9fLTJQwxmdu0Evm5jCz
 G/aiGNv9qRwJZwAofGH3EnOyb/+z49QW1b41ylofT3GiZcKLZ1SNzkSjkOgIeuQSJg6c
 tZlI0PMcORSDnOOljEoYlUuD2+lT95q+3KqHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739306971; x=1739911771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTrrNAuqSBTnZAsA8ClJH0vb18KzFkXhYJU1a0sN/yc=;
 b=nbdthqg5uwvjYtnVE7UQ5hHQM9EhfssSsmvVpsT3VJ6TkDQwL7nkBuGMjv9wizrIdi
 iMWCi0fP+/zlGgOS2QGpHwIaN2cD2ATYRg8c9Yy+gpupOjXj1rtUNVEwL47lW5CJ4Y1c
 cd3qDPbfxmb0mZ7nScRfoc316eHLvAF80GxzsZYHtkyi6XndUNDmU0E4CsCEinSm7wHE
 KR2wcJDpFKHziSlQ/XIYtO0MsF9na4b1gk58dwvGr5gAZ4jwYdUZCmXLv2Pspu8l56sW
 y5mkK49LbVeTbzWV2FFqG3wlHHi/XxXCCuvOqMJvGzu5HsJDtiOvEny8sJ5OuguG1CRR
 UFbA==
X-Gm-Message-State: AOJu0Yw187tR3Zim0c07PbVVmS6m0cg97G64aPcdnDFJiQrTi3aa2nuc
 QhbYloS9/JI7DLLPOOEZ3KCJOb7v4SQ3kJcmaF8xlKOklmAhqGoK8aQnfy4N2IcfS+b643wVBmz
 CVCaTIg==
X-Gm-Gg: ASbGnctqRbAeKVmQaq42D7pMvJHxld7UAU3UNPFIy+NEUQqaw2O0t8Pt7b/hdrndzkq
 gv6fHtWyyZWWxMZaJCIJisoqRLvdvsa7XuhQcgH9fk8SqUL9k2KlJeUnVRdYyrX0FlInqCt+c47
 jFOfjvTDQONXkQTO+H+dyuQmSfR5P9BwTVE9hKflfcQgT1ixenKhlQcXwDN64Ft1CYK3jC+jolt
 SQpcFaFh5hgs6x8dD3X8KvK8Vq4hB9rrr0YykDhnpFeLeVOR3kMyHxuQp4NMr9sJPObadJfXOvZ
 XX3MqMiSWT7IYEk=
X-Google-Smtp-Source: AGHT+IE5Gg6g/phg+asaeCCCR09+7OJxZ4yvo2uF8AzrasDYBtnbW2FVHKGBB1zAPeMin16b4BJ6SQ==
X-Received: by 2002:a05:6a00:409a:b0:732:a24:734c with SMTP id
 d2e1a72fcca58-7322c38759bmr769859b3a.6.1739306970733; 
 Tue, 11 Feb 2025 12:49:30 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730832c8419sm5172763b3a.38.2025.02.11.12.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 12:49:30 -0800 (PST)
Date: Tue, 11 Feb 2025 14:49:27 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.04-rc2 released
Message-ID: <20250211204927.GF1233568@bill-the-cat>
References: <20250210220151.GR1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="frJOxq59tVsW4hAf"
Content-Disposition: inline
In-Reply-To: <20250210220151.GR1233568@bill-the-cat>
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


--frJOxq59tVsW4hAf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 04:01:51PM -0600, Tom Rini wrote:

> Hey all,
>=20
> It's release day and so here's v2025.04-rc2. As this is the -rc2
> release, I've now also opened up the -next branch and will be stricter
> about what I apply myself, and what I see coming in for pull requests as
> well moving forward.
>=20
> Continuing on with what I started after the -rc1 release, I've
> scheduled a video call tomorrow at 9am -0600 and the calendar link is:
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
> and this is the same as last time. I've edited that event to be
> recurring and will tweak it as needed as we aren't quite every 2 weeks
> every time, but close enough.

And here are my meeting minutes. I'll preface this by saying what I
mentioned on the call, moving forward I'm going to get in the habit of
sending out a reminder about the meeting, maybe a week before, maybe
just the Friday before (I'm not sure yet) and making sure the release
announcement includes the meeting information itself too. I'm not
entirely sure why the calendar link is wrong but I'll make sure the next
release has the right one. With that said...

Michal Simek asked if Tom had done a defconfig sync prior to release. He
had not, and will do so (aside, is done now).

Next, Michal asked about CVE-2024-42040:
https://www.cve.org/CVERecord?id=3DCVE-2024-42040
https://vulert.com/vuln-db/debian-11-u-boot-170342
and if anyone was working on this issue given that it's for the old
networking stack. Tom confirmed that no one is currently doing so and
that it falls in to the broad category of known issues that also need
someone with time and interest to investigate.

Related to this, Heinrich asked about when lwIP might become the default
networking stack, and also if networking is used in any SPL cases. I
said that maybe by v2026.01 we could have lwIP be the default and that
yes, there's SPL users of networking (and no lwIP SPL support today),
along with being some uncommon but valid use cases of networking
protocols that lwIP does not support such as NFS. This means that we'll
likely never remove the older stack entirely. Michal noted that Xilinx
platforms now default to using lwIP in mainline (not internally yet) to
help with coverage. Heinrich noted that the changes in:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D442578
are important security-wise and should be applied. Tom agreed and will
follow up with Jerome about a pull request (aside, being sent after this
email).

Heinrich also noted that the string function changes in that series are
part of a more general problem and Tom agreed and noted it would be a
good project for someone or some entity to audit the codebase with that
in mind.

Heinrich brought up the topic of EFI bootmanager probing all devices and
the suggestion of using a "dummy device" to try and use EFI bootmanager
after block devices but before network devices in the default scan. He
hasn't had time to make an RFC patch for this due to time. He asked if
Simon could live with that approach. Simon was unsure and noted that one
proposed alternative was disabling EFI bootmeth completely. Heinrich
explained that the problem today is the global meths run before specific
ones, and some block devices are probed before this point but some may
not (NVMe, USB for example, if no "start" command run) which leads to
missing valid boot options (both when presenting the user a menu and if
configured to boot a specific device). The first idea was to do all
possible the probing needed, but this leads to boot time delays as
various probes require delays for the bus to settle for example.
Heinrich said we could have EFI bootmanager not probe but run it before
network bootdevs are tried. Simon asked for the right idea to solve this
would be and Heinrich explained his idea, which was essentially (Tom
paraphrasing) with a dummy device (bootdev) for global methods to be put
before network and Simon asked how it would work for when not using EFI
bootmanager. Simon noted it would check block devices including USB and
asked if EFI bootmanager would handle network? Heinrich said yes. Simon
re-iterated the desire to more strongly integrate EFI bootmanager with
bootstd/bootmeth. Heinrich noted the problem with that is that it takes
too long to do just that. Simon is OK with this approach as a
work-around, but thinks the right way is for EFI bootmanager to be more
"dynamic". Heinrich and Simon discussed how to possibly integrate this
more, but a potential problem is presenting other possible options.
Simon asked if network devices takes a long time. Tom tried to clarify
what network means in this case as there is a difference between EFI
bootmanager today (which checks for the presence of network devices)
compared with say "PXE Boot" (which will check for a device then perform
a DHCP request and then TFTP the config(s)). This means that networking
options in EFI bootmanager are quick until selected to be used. At the
end of this, Heinrich said he would make an RFC patch of the "dummy
device (bootdev)" approach.
(aside, Tom asked for Heinrich and Simon to clarify the above if
needed).

Heinrich next noted that he's been looking in to multi dtb FIT images of
late. Seems the design for some of the RISC-V platforms did not follow
best practices, and some of the general FIT documentation could be
improved. He said we need better documentation for implementation. Tom
agreed that it was likely that some of those changes / designs were
copied from another platform. Simon suggested Heinrich would be the best
person to update the docs based on having just done this development.
Simon thinks there's some part of this code which could be tidied up as
we have similar but different approaches to this conceptual problem for
xPL and full U-Boot. Simon has a RISC-V platform as well, wants to look
in to this. At this point Michal Simek noted one of the Xilinx platforms
addresses this problem too (xilinx_zynqmp_kria_defconfig) as another
example to look at, and described how that's implemented. Heinrich asked
some clarification questions, and Michal noted that in production Xilinx
doesn't use dtb reselection. Tom asked for TI to chime in and explain
how they handle this problem and Vignesh R explained their EEPROM-based
solution and dtb reselection. Michal asked where/how DDR init is done
here and Vignesh confirmed it's done in SPL, but also yes that DDR does
make this tricky. The TI implementation can be reviewed at:
https://source.denx.de/u-boot/u-boot/-/blob/master/board/ti/am64x/evm.c?ref=
_type=3Dheads#L71 (entire file actually)
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/am64x/a=
m642_init.c=20

Heinrich asked if OF_UPSTREAM is documented, Tom said yes, generally.
Heinrich how binman nodes get in for example. Tom mentioned that it's
handled via -u-boot.dtbsi and that mechanism isn't well documented and
that better documentation is needed. Tom mentioned that binman nodes may
not be upstreamable at this time however bootph* ones are. Simon said
that populating nodes to parents should be done, but Neha Malcom Francis
explained there's still cases where that's not working. Tom asked if
there's a gitlab issue, Neha says yes there should be.
After the call she sent me a link to:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21 and noted
that TI is working on this part of the problem internally but is not yet
ready for external review.

Simon noted in chat that binman schema should be upstreamed, Tom agreed
it should be when Simon is ready to deal with it. Simon would love
someone else to pick it up and continue. Michal noted the SystemReady
"clean dtb" requirement and the challenge comes in here.

Vignesh brought up the framework to support expansion boards at:
https://lore.kernel.org/u-boot/20230710145026.128481-1-rogerq@kernel.org/
Heinrich mentioned wanting to get better overlay support in the kernel a
few years ago, back when Beagle and Pi both had their own frameworks for
handling overlays but kernel reviewers were hesitant at the time, and
discussion died out. Vignesh mentioned handling this within U-Boot is
still wanted in part for secure boot reasons, and set aside the kernel
side discussion of this. Michal mentioned transfer list for passing
along some of this kind of information as well such as which cards
should be applied. Michal talked a little about the kernel side as well,
including removing overlays being part of the challenge. Simon mentioned
that having a uclass and building on the extensions command would help
with what Roger wrote and then be easier to integrate with standard
boot, Vignesh will pass that to Roger.
A link to what Heinrich was referring to at the time is:
https://lore.kernel.org/linux-devicetree/1482109835-9000-3-git-send-email-x=
ypron.glpk@gmx.de/

And with this, the meeting was brought to a close.

--=20
Tom

--frJOxq59tVsW4hAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmert9cACgkQFHw5/5Y0
tyzWlgv/UluyUe28dUN4zem96qwve1x+hOLDmeHNz9RG/R63NCAJoFB0XH+1BZnc
JAzGB9yUdRodH3pBlJiFg+d+pORO5zt018xGZhyUCXQ7lpzZuLczTIun/nhYD8hw
GsQ9ZmAKh7JDLx/yZZTbUo0ltuqvdGoa+7N0h4A0stBVsL5mPECW7ceMB2gQMw8L
38IgN6bmFXp5UiRv7BYk9FQxulLMvtTXxo9eJB1id2RoN++Jjol5RU4eff+lHwc+
PnkttLYLgv/7aJs609NriuA6hh+R2TCVm1OL27ToRcwLzOVcN4TDhgQUzwuwZ+0A
1LlP373d7RauEhftQ1Z5vcVbGvroZzIUl3JduOJv1e+gh4UPskJIdmJA9JhP52wU
uU4cEvTTNu8G33YQLKnjL4eT8+AM/RwLnxbs/xkr3gjiZz5a6DB89HYmHdTAvlD5
7Vz1pojKzyzLXZHgp1HEIuS8Sbd8qG6Ap4dJ9owCjaYtGnUmm/ajJbXnAv1Yhoo1
huCVoezz
=6y0C
-----END PGP SIGNATURE-----

--frJOxq59tVsW4hAf--
