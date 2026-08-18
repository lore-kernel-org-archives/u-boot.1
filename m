Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341B1C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 20:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBA328108B;
	Tue, 18 Aug 2026 20:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCsTIJNvPTGH; Tue, 18 Aug 2026 20:17:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787084243;
	bh=b2lfUUwb4CzXoKvLMX8+ZAasR2Zsaka0pTZvfQ61bTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pq7d+JSvo3zo0DUcwmq0WEO/k8dhfgVlYIhIkSMDNFTgdepgP1Ke7JeFl3tRkAO55
	 gyEtXIjmAwnkN0NECDs6pGoCwKCie3dJh809zCgm8upNPSdomUMULg2H2IWoWCgLyX
	 bf93PyrjL6tXR8EDJPQZpMQeHv34V79lpK56gWXdtjKQ/SEUVTScLLQGcMN1FTVOMC
	 tlBwtoGbbN7ZuMeZje+6cN/4C5qKl30bdLIJp8CWvfKH7ZCN+b4KL1rc7F8Lm6gG3g
	 y1AquIVhonZxXT0uqJlqz5vJou7SlIcG6nXDzvw6JZHw4uCRHQ3AI98DeX1a+wxAH7
	 snjzFR7JVOvrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C538780E08;
	Tue, 18 Aug 2026 20:17:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D2A727D
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4329A6071B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEV3cJP2Tz-y for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 20:17:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=htu+xo0n
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49C9D60712
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:17:19 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-451d8064238so246342fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787084239; x=1787689039;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b2lfUUwb4CzXoKvLMX8+ZAasR2Zsaka0pTZvfQ61bTg=;
 b=htu+xo0nFDqLYzEK5MGzCWzI5yOKFZrL5m7Hmjzc7zORvti00z5VhkOgxtoMTBSLOh
 2MS11nf/iB9PHlJNPt3HEDLXLWubP6ppjYj+pUOzoJ92nVNFAzBrx+ZBC8SuuJPCFHxU
 hRziYzNPp7GNSJJUjvC+1m0OQ131BPZGyNp3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787084239; x=1787689039;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b2lfUUwb4CzXoKvLMX8+ZAasR2Zsaka0pTZvfQ61bTg=;
 b=e8jYl8Sjx0vmm32/YxpI7lo5jHsbJgU3Nfzalo+ewcFKzp7NBC6+fMEqremACOxV9Z
 ykNN06dVJWFd8b/rD5Flm2GF8evsQskQqkL9Gi7yyYj+Q/QRYuaBuXg/gRyb8Y2oEdYR
 o6ubxBBWndUHdnkaaSAavcn0VMMpV3axe4wROzE2TnS/xe0YY0FwrnrIv9Qq/uwmbLU9
 0ltsEg10q4BublzYQLmS5773EO3nrcmt8DITb9LSK2AmHM8Gt1Wbv5I35DXQ26NaFq9g
 2ewpW1tFi8xOKh90Rv7sP30LXkC6HUdwKu/5D5Nm4cDw/CjXAzZbdZLFYGLoYy2Ithbq
 SVTQ==
X-Gm-Message-State: AOJu0Yz1bjuBh3ezs9zkOgSLCPptNiWIRiGA28Hb5ceTvXuwfYpOy53a
 TAhD+FRT1ztEl6IWqAK9WKCbpECa4o5P4DGYtNpO8B0DNk5re2vtgCljTR/3UBXr+3c=
X-Gm-Gg: AR+sD10Emo8ITYlVKXgZCiExmyMaVnplQP7LkinyGOXCbSrENhYbTsNtA3P1yeo6MsZ
 TPBsGm9kYBrM9KYZGv1iTpprYAD23r5Gxj7i1wPBfBNDUZMB01bgKRwjoLPL30BTMgoJ4VzXHpm
 LFpDgtjghtLZxrrkfAcaEb+QKeakcZ01ddD1GafxgBsFVWrzuoQ4Vnov7yX5+L9y8yiEvqo0lQz
 de7EA4Puz+GR907TpZe7mYzvY9UBIPC6ewT8bT6ApbtE6WKDAENHoP9+U6VSuKuylZGmM04V1rO
 gAWIVad0qKNS03j3IVZC97F9oZZJGkCoWwBqymMlnjoxHX7PxHcIa9uaxzrzFpGP86W0JJPpC1s
 ECEAywKdT7zkXz3AOz0eR+t96ZJkTxFgsAUnIOb1i+IyFd4E6iJUIVGHyR6wVSDwAfylQYG56K8
 hSMgkpMcIr1U/GK/T0hEUwhkFG/I4raaBSexqAwrPdR/Nz8GGzsG5pbYGJpGrvUgSnQVXkrSpvv
 WKj56AwP1iz8GATdtG3xtRvds9gq0K+vJzR5ASF6sIRjYsppqLwbcBXUIxznguc1cGT0RMCkf4k
 qTXAVHDm/w==
X-Received: by 2002:a05:6871:781:b0:456:76ed:9a93 with SMTP id
 586e51a60fabf-462f5bf9345mr82931fac.14.1787084239004; 
 Tue, 18 Aug 2026 13:17:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45f22d6a29dsm3740364fac.11.2026.08.18.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 13:17:18 -0700 (PDT)
Date: Tue, 18 Aug 2026 14:17:15 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Brian Sune <briansune@gmail.com>, Tze Yee Ng <tzeyee.ng@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [GIT PULL] SoCFPGA updates for next (2026-08-17)
Message-ID: <20260818201715.GC523975@bill-the-cat>
References: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Umd73ocYG48kTEtp"
Content-Disposition: inline
In-Reply-To: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
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


--Umd73ocYG48kTEtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:29:50AM +0800, Chee, Tien Fong via U-Boot wrote:

> Hi Tom,
>=20
> Please pull the following SoCFPGA updates for next.
>=20
> The following changes since commit 527115ef6783cec49e5610c523c124b3990113=
61:
>=20
>   pylibfdt: Replace removed SWIG Python 2 compatibility macros (2026-08-13
> 10:12:41 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
> tags/u-boot-socfpga-next-20260817
>=20
> for you to fetch changes up to 96ba02bb50016fe70d2fb087d7698c56793f7d46:
>=20
>   arm: socfpga: Improve handoff prepare on SoCFPGA (2026-07-29 00:36:13
> +0800)

I know CI doesn't fail on this, so I only saw it in my build logs:
       arm:  w+   socfpga_de10_nano
+(socfpga_de10_nano)
+(socfpga_de10_nano) WARNING: unmet direct dependencies detected for DESIGN=
WARE_WATCHDOG
+(socfpga_de10_nano)   Depends on [n]: WDT [=3Dn]
+(socfpga_de10_nano)   Selected by [y]:
+(socfpga_de10_nano)   - ARCH_SOCFPGA_CYCLONE5 [=3Dy] && ARM [=3Dy] && ARCH=
_SOCFPGA [=3Dy] && !TARGET_SOCFPGA_TERASIC_SOCKIT [=3Dn] && !TARGET_SOCFPGA=
_EBV_SOCRATES [=3Dn] && !TARGET_SOCFPGA_SOFTING_VINING_FPGA [=3Dn]

That needs to be fixed.

[snip]
> ---
>=20
> This pull request updates SoCFPGA platforms with Stratix 10 and N5X
> driver-model
> conversions, DDR robustness fixes, Agilex5 storage and DT updates, and
> Gen5/Arria10
> maintenance.
>=20
> Stratix 10
> Switch to the upstream Linux DT, combine boot-flash defconfigs, and move
> firmware
> register settings into the device tree. Enable the system manager driver,
> refactor
> the S10 clock driver, exclude S10 from legacy MMC clkmgr address lookup, =
and
> improve SPL data save/restore and watchdog support.
>=20
> N5X
> Enable the system manager driver and switch firewall setup to driver mode=
l.
> Adopt the upstream Linux DT, update GMAC nodes, consolidate ATF/VAB
> defconfigs,
> and use common SoC64 environment settings. Enable CMD_MTD and ISSI QSPI,
> split
> the reset manager into common and platform-family parts, and drop the ker=
nel
> node from binman for the non-VAB flow.
>=20
> DDR and memory
> Add ECC DRAM scrubbing and DRAM size checking for Gen5/Arria10,
> secure-region
> support for the ATF flow, a delay before MBRDADDR writes, and a data-cache
> flush
> fix. Use dev_read_addr_index_ptr() in the DDR driver.
>=20
> Agilex / Agilex5
> Add an Agilex eMMC device tree, enable 8-bit eMMC, restrict watchdog0
> autostart,
> set DTB filename and kernel-node removal for non-secure boot, disable gma=
c2
> on
> Agilex7M, and update Agilex PLL sync-to-async configuration.
>=20
> Gen5 / Arria10 and cleanup
> Improve QTS handoff prepare isolation, fix the PL330 TARGET-to-ARCH namin=
g,
> enable DesignWare watchdog and random MAC on Arria10, and apply related
> Kconfig, FPGA, clock and MAINTAINERS cleanups.

And I did miss that you had the changelog here at the bottom, sorry.
It's helpful but not required to have it in the tag, and most of the
time people put it up top, so I just wasn't expecting it here.

--=20
Tom

--Umd73ocYG48kTEtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoS9yAAKCRAr4qD1Cr/k
CoDnAP941mFrrA1TWEgemc5He+4COVuvdJutDLbg5TnFzrFjTAD/WUgqUi6OOyBO
QgqiXXK+Od9A+uVQWdx2Yle+QM/IVgI=
=3F1M
-----END PGP SIGNATURE-----

--Umd73ocYG48kTEtp--
