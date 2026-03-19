Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9261091929
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 22:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD7F83FC0;
	Thu, 19 Mar 2026 23:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UFNoXLSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84EB283FC5; Thu, 19 Mar 2026 23:55:10 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B588983F9B
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 23:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-46704fbf62dso1019475b6e.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773960901; x=1774565701; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vNXVYTOUaoIbaiWM3pX9CVmZ1DbNwbQtzjQFshTqJdg=;
 b=UFNoXLSH/5kmL/uJUqG2AbfIPDB+am4+4D26xgEiFt5+hpm/IyggyD3Junyd8JzZmJ
 MEv+2EO5X0oeSF/5CKMXCj1nK1SvdsEjkZ4BkIbhMy4xGcRAPfUQfHWAtxc6ASAZzxIC
 ZJn4bGJUw6yLsHRyebWdYIY4MOVQvocF8B4kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773960901; x=1774565701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNXVYTOUaoIbaiWM3pX9CVmZ1DbNwbQtzjQFshTqJdg=;
 b=cbImOANPUTTaRapJVU/uqw0GdAfFtyGKFfSQ1l7FzlWkxUvACIn4PlzRamO7SGpvcc
 hy8x73hj1azHObB/KiDOb4ZPK6rxl4D8/BRvXyA7UMDS9TvhgI/4t0SClI7EElxEvft8
 m+uViOE49iGYItkbdZ1S4h9WbftcFkezSGVkMUURRM13gHUjFO9bk6QClIyq68nXrxn3
 C7LNTKwDEE+SVzEcrTrkwM4B30SGlnUUe+n0Nfl3qkf2Nj0NvwSSsF6OeCBf6sdVHNJC
 ZYqWjoFEDwydG0KhhaV5iZsSdGTZ3YHBvpsU79srcY6eN+/auGpWRZ0vIi4KYxpDY3Vz
 Y6cQ==
X-Gm-Message-State: AOJu0YzYhnIn0h8hk+CFPlZOH6bZW8gu42qnI873TgJ7UZzPNQmqeLOm
 TtGf7AhGEF1/W3e/q+d8lxiV1iHGu31lAbgMsE75k3gmwmldeqTKWBTsK2IIhVW/QPQ=
X-Gm-Gg: ATEYQzyJ7aPadvuZxeh2g0m9R+3KHW0cfyNjJlryH6vS8NYoSy63infg8fQpB+3TBU8
 HJ5D9+hWhJ/C9DqLc6qq7GNFERrXI5cr4X3DWbx+Ny3L/DeHdh/LhhgGMoR/vkDj9KK3o5Hz34V
 xEs3ESQuw307Xlzh8ebx69LS1UzsXdqPtus5JOFssdhQ76uA/+mEimv53EbvhzVYNGADzYEfgFj
 X/b25hSra1N/rYGVk8foApVIClA5RzDLQc/XZdHXRNXhInyNFlPeSVe0qncZAsRC4dzEVGvFIHK
 7NitooA3Bs3OpHPzpJo52YJ7VqtkypzNU1PIJqoEYP0hDsoRTvBXx9+7pa3u1mUaMdkPOhajSVG
 5b7va3hNxbsg7KdCseeEcjbWPw4YUP4JpYXbzVl7LBo6Um5oslGysVLUBnoiyMSvH8F5V/unTTX
 jGxXCkqDGcaJRtDB1hsWlh+OQ7vZQhMMIvmGb4wV2garKFwysIqvsMNnzDIT0NhoHM/f69AL3ja
 t9dK/GSqEQu4O29BUUASz+1bneZ+gugcWA2pcYJJP2PnI/2
X-Received: by 2002:a05:6808:190f:b0:467:2f84:b09f with SMTP id
 5614622812f47-467e5ed97e1mr554159b6e.38.1773960900922; 
 Thu, 19 Mar 2026 15:55:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7a96c3asm276959b6e.0.2026.03.19.15.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 15:55:00 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:54:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 dlechner@baylibre.com
Subject: Re: [PATCH] scripts: merge_config.sh: support include directives in
 fragments
Message-ID: <20260319225452.GW502704@bill-the-cat>
References: <20260319-merge_configs-support-include-directive-v1-1-dcfb1c7f934c@baylibre.com>
 <20260319162134.GV502704@bill-the-cat>
 <CAEHHSvaHEpiakXc1QOXeJP49gSs9yf4M29Fw5OsQLqtBV-y75w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="baC8VJY1bLXNUw1j"
Content-Disposition: inline
In-Reply-To: <CAEHHSvaHEpiakXc1QOXeJP49gSs9yf4M29Fw5OsQLqtBV-y75w@mail.gmail.com>
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


--baC8VJY1bLXNUw1j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 05:49:35PM +0100, Julien Stephan wrote:
> Le jeu. 19 mars 2026 =E0 17:21, Tom Rini <trini@konsulko.com> a =E9crit :
> >
> > On Thu, Mar 19, 2026 at 05:14:05PM +0100, Julien Stephan wrote:
> >
> > > Many defconfig files rely on include directives to factor out common
> > > configuration. When running "make some_board_defconfig", these files =
are
> > > preprocessed and the includes are resolved automatically. However,
> > > merge_config.sh script currently does not handle include directives in
> > > configuration fragments.
> > >
> > > Add a preprocessing step to resolve include directives in all fragmen=
ts
> > > before merging them.
> > >
> > > By default, the include search path consists of:
> > >   - the current working directory
> > >   - the fragment's directory
> > >   - the default U-Boot configs/ directory
> > >
> > > This ensures that existing defconfig files work out of the box. Addit=
ional
> > > include directories can be specified using the -I option:
> > >
> > >   ./scripts/kconfig/merge_config.sh -I <additional include dir>  conf=
igs/some_board_defconfig frag1.cfg frag2.cfg
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >  scripts/kconfig/merge_config.sh | 56 +++++++++++++++++++++++++++++++=
++++++----
> > >  1 file changed, 51 insertions(+), 5 deletions(-)
> >
> > This forks us from the upstream version of the script, and I don't think
> > upstream will want this.
>=20
> I understand. Would that help if I submit this to the kernel first?
> and see their reaction?

Honestly I don't know if the kernel or Yocto Project is the true
upstream for this script, but yes, if it's not a local addition it's
much easier to handle.

> > When I make use of this locally I do a two step:
> > - make foo_defconfig savedefconfig
> > - merge_config.sh defconfig frag1 ... fragN
>=20
> That works well for defconfig inside configs/ but if you manage some
> configs outside of u-boot and they have include it won't work.

So, in my case the fragments live outside the source tree (they're in
fact just mktemp files). But this also makes me think of the issues TI
has brought up while trying to handle both "we want to test things from
Yocto builds" and "we don't want non-upstream changes". So perhaps
understanding the full use case here first would help inform the
discussion. Thanks!

--=20
Tom

--baC8VJY1bLXNUw1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabx+tQAKCRAr4qD1Cr/k
CmH0AP9bBvapLYcPkYNA2wyIv7vlidspsGe3ovBqGzH9WfQ//gEA7XISzo9R6MZq
+h0bu6vqpDUHIREEjuzBQ8jb9A8yGAg=
=wGE1
-----END PGP SIGNATURE-----

--baC8VJY1bLXNUw1j--
