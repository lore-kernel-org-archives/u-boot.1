Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26900C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 18:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C575E80D1C;
	Wed, 19 Aug 2026 18:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WuFDYbVF0WDk; Wed, 19 Aug 2026 18:22:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787163777;
	bh=oEpCvtyibme0JM6K0NU8+ujBisKwLfo8mo2B5yJ01Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iuq/kiMYbnMnjeNuOq34lSvp5vmrs5QHq25mkwu166eb8nIjXsuf604DTjTGf61gw
	 x+Tx308PCstaohRheSrY5cTN3Pf912tb1jFd0yIyXvvf0/QB3WVgBqdjb/4PU/PkhK
	 BfhuHVBr7spIdEb5ajhRS8igz0fAnHTXMUoqGgZw/Invt6ZGj6qBfm9DmZvHKQ0PWp
	 eXmLP6LMnf54nv8QskPYDetoUjBc8xBzqVexet8gBjdNxw6n5eRIEjbpGcjjmpww78
	 djYOZ+w5hSik6KlEfcIhaS5bBDpFdwr7Ovbq9xllO1geAK1gdrRWBWd9lz9KhPJCMb
	 uoXDe7h1GVhrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A4CF80C95;
	Wed, 19 Aug 2026 18:22:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE030265
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 18:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3C77405A3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 18:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TgGGTNhot51g for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 18:22:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=atk3XorV
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0436B4050C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 18:22:55 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6ae6e407bfdso753407eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787163775; x=1787768575;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oEpCvtyibme0JM6K0NU8+ujBisKwLfo8mo2B5yJ01Rw=;
 b=atk3XorVdP4bR9w/prffi/cfQ1UAh7Fk8Ip8i6GIEZ51Q4tY6YrpwBBJArg7OOjUfF
 7MiaGwdolI/7NJd56nlYG0nXsBi92GHaFg156ornriXSUBmgCo+EZ5CJqY9Y7qhmCyny
 v4gc+joiQ7q84CPfE/DYfG4J0rBG4LysIqyQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787163775; x=1787768575;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oEpCvtyibme0JM6K0NU8+ujBisKwLfo8mo2B5yJ01Rw=;
 b=e5GAyLKkLLGBoWUv3xfpnj8yJOo/YWvuVA6OGlMRKIam3mAxXyK3gMynS4NN6sPiRL
 Ps4138HU0bnWIaI0piaXc9gGKkHrGo5Ma5aN5Bey+MRbp5L5y9RIqRQmo2MtruG+TA7S
 VxV4QBQYYad23neRG/EDhNgBorwP2Ospw1bNxxKAa3F5TGjfGIBh2aPB9fzr1Rb4sSc3
 28iq3h8dJLLPVAbYDklS9Z5ZkUdcMaGW5once/eLHCxrICkrrB872wpknMFTfVtzdylI
 6qtw3Sp0S1x7j9RcG2SqGkfnpNsMDRCR/CmjRAk05XIhIxY9AgTy1BkOKVd1YU6j3QRX
 S4XQ==
X-Gm-Message-State: AOJu0YzK92JAvpWCPrOHJemRm2rGMpvhLbEqmTOHcQTSsf7FVUm4OeId
 lbjC4ZhJSQThLJvGJVTGXXwbQQlgCydsF+vrNToaPVnwWhs4shU5mu4pYXKyITdXkAM=
X-Gm-Gg: AR+sD13ZE1JUOnYn3PWWydmkpnCC67TgUI4dygkU0PHqO2IMk4ri8CWXEXExsDWZYC0
 F0GlU1QqV7tI//+MnFdJz4vNCG4KsTlkrpusV/VXw1pOItiFFlz4bRzVQeyKRgV0D93yQzGvugo
 VsZFgm862rBJq5EO+By0iCJz68OEJ+iHWK6ODzeNROBXSpM5SNQClB55JbDZB6X+E2rW8wkLQVC
 PVN4TSQuGSLIrK7aO7LJtO5VzX0DhyIARZNxhdCYA4nA7k3UjTmS8DSsEAiXb+5/FxfwZJtu4Ql
 Rp328R/D/HOX05luJfPUEMuBoF69vuxSIFM2a62lwsjL2VWJ9hg/tXucgzldSRTBCAMyKSPHSas
 g36AU7/g1uExd9MK652UjLTGPp4Q6VrsgVtWqprhQFjIlM/p396wyaISqjRiVQ1LLRUabuc9YcA
 9jyBgxFaG1XtX5PkALiujjX+3pu8tQX0RFz0XGGVR9+d0YeBCWw6spi6vLp5sszfKXAtG/wZp1N
 NloYCrqS/CiAB/T36rEnAIFqorMPf7YwF2FMcE2PC62fE46g8fSfXf1kAl10zme/kZXl6y47sJU
 ad31NQ+eC3dHC4nmqXc9
X-Received: by 2002:a05:6820:3415:10b0:6b1:4250:6a43 with SMTP id
 006d021491bc7-6b142506b33mr3133219eaf.17.1787163774801; 
 Wed, 19 Aug 2026 11:22:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cb51ebdsm2518712eaf.3.2026.08.19.11.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:22:53 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:22:51 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: u-boot@lists.u-boot-project.org,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Brian Sune <briansune@gmail.com>, Tze Yee Ng <tzeyee.ng@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [GIT PULL] SoCFPGA updates for next (2026-08-17)
Message-ID: <20260819182251.GA1954583@bill-the-cat>
References: <20260818201715.GC523975@bill-the-cat>
 <83d2b4a9-ae55-46cb-9dbd-9d603fa1ec94@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D3L5ufjOLkZ7xNUX"
Content-Disposition: inline
In-Reply-To: <83d2b4a9-ae55-46cb-9dbd-9d603fa1ec94@altera.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--D3L5ufjOLkZ7xNUX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 09:16:43AM +0800, Chee, Tien Fong wrote:
> Hi Tom,
>=20
> On Tue, 18 Aug 2026 20:17:15 +0000, Tom Rini <trini@konsulko.com> wrote:
> > I know CI doesn't fail on this, so I only saw it in my build logs:
> >        arm:  w+   socfpga_de10_nano
> > +(socfpga_de10_nano)
> > +(socfpga_de10_nano) WARNING: unmet direct dependencies detected for DE=
SIGNWARE_WATCHDOG
> > +(socfpga_de10_nano)   Depends on [n]: WDT [=3Dn]
> > +(socfpga_de10_nano)   Selected by [y]:
> > +(socfpga_de10_nano)   - ARCH_SOCFPGA_CYCLONE5 [=3Dy] && ARM [=3Dy] && =
ARCH_SOCFPGA [=3Dy] && !TARGET_SOCFPGA_TERASIC_SOCKIT [=3Dn] && !TARGET_SOC=
FPGA_EBV_SOCRATES [=3Dn] && !TARGET_SOCFPGA_SOFTING_VINING_FPGA [=3Dn]
> >=20
> > That needs to be fixed.
>=20
> Changelog since tags/u-boot-socfpga-next-20260817:
>=20
> - arm: socfpga: cyclone5: select WDT with DESIGNWARE_WATCHDOG
>   ARCH_SOCFPGA_CYCLONE5 now selects WDT with the same board filter as
>   DESIGNWARE_WATCHDOG. socfpga_de10_nano no longer warns about the
>   unmet DESIGNWARE_WATCHDOG dependency.
>=20
> This pull request updates SoCFPGA platforms with Stratix 10 and N5X
> driver-model conversions, DDR robustness fixes, Agilex5 storage and DT
> updates, and Gen5/Arria10 maintenance.
>=20
> Stratix 10
> Switch to the upstream Linux DT, combine boot-flash defconfigs, and move
> firmware register settings into the device tree. Enable the system
> manager driver, refactor the S10 clock driver, exclude S10 from legacy
> MMC clkmgr address lookup, and improve SPL data save/restore and
> watchdog support.
>=20
> N5X
> Enable the system manager driver and switch firewall setup to driver
> model. Adopt the upstream Linux DT, update GMAC nodes, consolidate
> ATF/VAB defconfigs, and use common SoC64 environment settings. Enable
> CMD_MTD and ISSI QSPI, split the reset manager into common and
> platform-family parts, and drop the kernel node from binman for the
> non-VAB flow.
>=20
> DDR and memory
> Add ECC DRAM scrubbing and DRAM size checking for Gen5/Arria10,
> secure-region support for the ATF flow, a delay before MBRDADDR writes,
> and a data-cache flush fix. Use dev_read_addr_index_ptr() in the DDR
> driver.
>=20
> Agilex / Agilex5
> Add an Agilex eMMC device tree, enable 8-bit eMMC, restrict watchdog0
> autostart, set DTB filename and kernel-node removal for non-secure boot,
> disable gmac2 on Agilex7M, and update Agilex PLL sync-to-async
> configuration.
>=20
> Gen5 / Arria10 and cleanup
> Improve QTS handoff prepare isolation, fix the PL330 TARGET-to-ARCH
> naming, enable DesignWare watchdog and random MAC on Arria10, select WDT
> with DESIGNWARE_WATCHDOG on Cyclone V, and apply related Kconfig, FPGA,
> clock and MAINTAINERS cleanups.
>=20
> Please pull the updated tag.

Applied to u-boot/next, thanks!

--=20
Tom

--D3L5ufjOLkZ7xNUX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoX0eAAKCRAr4qD1Cr/k
CpthAQCvVSgW6SLzNnmNCBVXFXx0ymjgh4oRKHEKFAmoyY6qkwEAqiAaPKIZ03kB
KfT1avPQmux2/HuVwPn31lllF56Jqww=
=p0+o
-----END PGP SIGNATURE-----

--D3L5ufjOLkZ7xNUX--
