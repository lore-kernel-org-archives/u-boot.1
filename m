Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCA0CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 267D660789;
	Tue, 13 Oct 2026 15:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YazCgx3SmOPd; Tue, 13 Oct 2026 15:05:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18D1D60793
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903945;
	b=Cjp2DB/SClj6xbB1K06sa9+drMkzY5P0BkwNaTOUKlZksFDM03IABiFegFvP15vATtHy
	 azK5AhkOQ6cSwidTl+4EH6Any+ZPxnMIyULj4DkCByJu5FcsMVwFBqwWxvzsYWz6azQh7
	 z84c5485qiLC8qngEtS041xF3Ok2UzXU+lnw4JngHfT08GTqeiIdYktKXPKVw/ARI0qsr
	 XKhPXh/9Ul06v9sXAnwR5z/cG/7Qg+YNpP5zhFndqXZyTfWeY+nZ9x53kAnqzHTYXYg1I
	 K5fdvprIKidm0A1IZmrnr9Gs+HiZtgb10KX2DbdLgT8qVGSujpWd5xJzsp2g5MY9ZsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7hbwqJNOyYpV9K6SVjtEJGH7ATsqy4Vxwv/1DWf80UQ=;
	b=d8vaWlnR5RnnJBvB/JQx0kFb8CE5/bZEN2kp5tuFCA91se6ZRH6bEMlU3GtY6QHCccdu
	 jGgZupzZ4Ys3Wi+vgqh6M9d/U8VltV4blBnuaN3SJEe1KLRzBR6eEIQ+BOMj2/UFWhY46
	 W4a5jcp1QZioidrCubpklHJXfL7k7gB3C23lYgl2gvnFH+tQDsULsQQZmJsZ1IMRj9v/y
	 yueAUczy0IwMn4YeNQE7eArNWGQe1NvEAfDOtSQpWjtmNeW+mwGU9N5brOkAfxDjS+atO
	 Nl94AGqBpAlCdwWXbwf2+486Jwc3I9bE0higPMt+xFVQqOEKKLcNGTzR7GXb+v1S50g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791903945;
	bh=7hbwqJNOyYpV9K6SVjtEJGH7ATsqy4Vxwv/1DWf80UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYWQZC2uJdSWMFcMkoaJ4wXP9RCTMHIZf/PguLJmItgci/NjzmUzoAP6619zU31/E
	 Q7c4HFPnyqCkidMwwQbXIXV9u4b67LpC8QmIl/wMJX9hCnRKdgrDX1Xvop2iIm3KKz
	 pTcDyUHjPQ8QcmABXZNXUMukaE2kLCt35VTk2AhyrXIzPiPVotBO/JTJb0xdjaxajd
	 uehPt4yGuqH7Zc91veGeI78f2fKwp/boL4mLcTornscMt3xAHr8tGBXMoAIfyyMIH1
	 gi8St2k8gZ8M8+CJvvsjWyY2PyLQ1Ok1XfF6iP2HBa8xU7Z/AIiLOHewgXFNoX1wQ+
	 2JxNL8lyVfshw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18D1D60793;
	Tue, 13 Oct 2026 15:05:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F289362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64E64402AA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7spFZRtuwyl4 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 967B44010F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791903941;
 b=SgmVN9ANXAlkn37vPBNjpm3+jF/ruhs61CLSW6xS34TaHGDyt9lGUQzrYTba6LEgoVtc
 Pa7ftLXipUFehrhs0Rg2TvPkmUji5GH48teaRXLR0fcE/7Z6VyTGDbakyn4tSc1pRPu98
 ACaO6p6P8PVI/nbP59+3BseKe57beKU8VMrnAwppTcBujaBMIBT6HMb6NBvnC5OCrBDcX
 FKiIYPMJ3paJR/sQvEn7ZOJchwCB+PWeSrEp+IOq5PbdztAgkedZJVV7gLF73IHId+VLn
 W/lS8W3azZLceuNJxTulnm7sHDNGCAXR9kTlXRUavClD3Eu5ms8wnvtQdKbzBGVZtiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903941;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=7hbwqJNOyYpV9K6SVjtEJGH7ATsqy4Vxwv/1DWf80UQ=;
 b=ZPHMPgdZnrafy5Amw/iWSjkBYPfIpA4TYSCprI1s5dD8SZq+2gPLwpBPlLJUoExx79mk
 deYDtQwj6zFGoQqGUqMu5NWoSYqSsjDZECQbEtxFn0lI0ctZF65+9RuY5PJTgz5UA4snc
 2THoBRL4Kk26I52DanamhhdkLd7q/2+VgQztXcRwC00atpfVubHZeD1pjsgrnfz408Rtb
 Px3socsFjeWrYP3N6megG9I2QZgj3f8HUxD7yoWu8AdZQu0NCaKB3XdzvksTXsAuhkqlm
 vYAr2A/naubW1WfgV4Qi8cIi7Y/kt6woVkU7aL0n2gM7IRxgVK4FSWpUtM3wqejsSGQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cY90LsxS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cY90LsxS
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 967B44010F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:41 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6df1eeb43feso1280880eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791903940; x=1792508740;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7hbwqJNOyYpV9K6SVjtEJGH7ATsqy4Vxwv/1DWf80UQ=;
 b=cY90LsxSAvcexmw5fO7achuwiX9ONraGjQ2h6kt27lJTgyBl4QDH1ITpMdxJrB/8j1
 /fmjXuVgX6oFWho/W2WwIJT8ujDIiD1aVtXPnRi7Zf9044OJiixdHkuyR6A9F9aFxVQy
 k8kijCu/fqPunQWlkldZiuE+bMeopmZXmv9a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791903940; x=1792508740;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7hbwqJNOyYpV9K6SVjtEJGH7ATsqy4Vxwv/1DWf80UQ=;
 b=ieJw/7Ry1FwzZQTd5e6cWriEaMEvpT9ZVkczgoBzovQzwY7t3OMHrTXsmdxU++YTrD
 oaD9DBGQNTRVCC8k8VByDGeowXhjysq+z1vgRmAoaFrkDcR6MOd4T3UJaQtmtUEvbPOt
 8/LVhtBHV7SLLBuTBvRgPE1THCOTdJ3d5ZGc8ZPHAQ+8/j0Y5qAgJhH+rEa/BAMRKPvK
 PCGXDdfmCPq1lyW+BezuMuyBt/riLB72Y3vpXU7+W/SJdbCuQWjFhwFsdtw2WO36Uf01
 Bw0j5JQMSqju4QNHuFN6ieWRvrS7fdya+ziuIntVLONjIJJ5OWkljquBWyNSV8p+MlOe
 Qa/Q==
X-Gm-Message-State: AFq9FYJ7aRgc22mo2fPeL3hHo7BiK8qA0jjk1GyoCDXOwVQVqQGMF4Ko
 Igy8VGdr/wbqWcCUsjq/gPtlWJxyRdM2qbUJRFSeavKTFntr4stGCWl+4WDTRQq3u4k=
X-Gm-Gg: AYBFou0rUT4sMO3ySD6f2t89xhjmZjG1Ivkg6cNctNRHE8fEfR6PbCJzi40eTPp79Jf
 HX9SJTQ93nfA3oGAkyxKHPJ1PLNS4sPOjjw+wrDvZWQFpx5mEEoiUo6Go5+7xMKPHB5gP99r3zn
 o1/Q3NxRt6gtZy05ZMlylnoK/CumC7Szx982+YErQgQH6APZLXyIaj4tW7S6aR3zVMf7Y7Ih6H1
 D8I3BLOd8T5l+W2kJm9f0eoSWXnbBh2jdlTah/+lX2CjF8sdCATrcsDECWwcasALsJRVJU9A9eN
 RG/548NigX0VHuJ7aDzqibD+K3G2mEYIHCNSxGpGum0rOvPuQ5wS/QcjHAbxndKkfPLtfII6/4t
 67pS3h8c4kBeO1umIuDZhxxKeVa4c1KYkQHdyC0BAZyXR80SbWQC4bzsJd1jEQV9uTAOEhRYqCm
 I4Qd7HBh+Plc1JzKpHEyKmy5Fu1CbAXaMWo6jVZt1gQ8gMmDItZZpvhHtJwdt8ooqY5fjS737eg
 uqdIkumbmoz0iRi4OAHfMAGpD5VTmH+Ap9+hJ9zXjplrllyX1qTEwegSx6/6M6DgNTPu1kYH+Yg
 VVhPocm5i2uGJO4SJ6k=
X-Received: by 2002:a05:6820:f035:b0:6f7:f03c:229 with SMTP id
 006d021491bc7-6f7f03c08admr3057800eaf.74.1791903940047; 
 Tue, 13 Oct 2026 08:05:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6fba22b94e2sm281005eaf.8.2026.10.13.08.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:05:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:05:34 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 06/10] mmc: metanoia_sdhci: Add SDHCI driver for Metanoia
 MT2824 SoC
Message-ID: <20261013150534.GC4042005@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-6-bc44cf0e0289@bootlin.com>
 <20261002152935.GV858934@bill-the-cat>
 <EDoKM1LoTYiVJ09AAx_ihg@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S90omzyvRJfexmUV"
Content-Disposition: inline
In-Reply-To: <EDoKM1LoTYiVJ09AAx_ihg@bootlin.com>
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


--S90omzyvRJfexmUV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:45:09AM +0200, Beno=EEt Monin wrote:
> On Friday, 2 October 2026 at 17:29:35 CEST, Tom Rini wrote:
> > On Fri, Oct 02, 2026 at 03:02:24PM +0200, Beno=EEt Monin wrote:
> >=20
> > > Add an SDHCI driver for the DesignWare Mobile Storage Host Controller
> > > (DWC MSHC) integrated in the Metanoia MT2824 SoC. It supports eMMC up=
 to
> > > HS400/HS400ES and SD cards, and implements the MMC driver model.
> > >=20
> > > The controller is a DWC MSHC instance, but its PHY programming,
> > > voltage/speed-mode handling and tuning model are silicon-specific
> > > and differ from the existing DWC MSHC drivers.
> > >=20
> > > The PHY pad drive strength, receiver select and weak-pull settings
> > > depend on the card type (eMMC vs SD) and are re-applied on every ios,
> > > whereas snps_sdhci.c uses fixed pad values.
> > >=20
> > > High-speed modes force 1.8V signalling and HS400 uses an explicit PHY
> > > DLL lock sequence (set_control_reg()/set_ios_post()), which snps_sdhc=
i.c
> > > does not implement.
> > >=20
> > > Tuning relies on the generic SDHCI core tuner, whereas snps_sdhci.c u=
ses
> > > the hardware auto-tuning block.
> > >=20
> > > Keeping a dedicated driver avoids per-variant branches in the shared
> > > DWC MSHC drivers, matching how snps_sdhci.c, adi_sdhci.c and
> > > cv1800b_sdhci.c are already split in U-Boot.
> > >=20
> > > Signed-off-by: Beno=EEt Monin <benoit.monin@bootlin.com>
> > [snip]
> > > +static const struct udevice_id metanoia_sdhci_ids[] =3D {
> > > +	{ .compatible =3D "metanoia,mt2824-dwcmshc" },
> > > +	{ /* sentinel */ }
> > > +};
> >=20
> > I don't see this compatible in Linus' tree currently, so what's the
> > status on upstreaming all of the device tree parts? Thanks.
> >=20
> We are currently preparing a first patch series for Linux, but it has not
> been posted yet.

I'd really like to see that get posted and commented on, so we don't
have to have churn here later if there's changes requested.

--=20
Tom

--S90omzyvRJfexmUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas5IvgAKCRAr4qD1Cr/k
CrvSAP9KxBkXz//foornzNmUhAKh6xSEDTfNJRgvwJCzylZGkQD+ISEOH8mUYEJX
n4RYN0Al6CFXjFCm3abQ/CYngGk3YQU=
=j33R
-----END PGP SIGNATURE-----

--S90omzyvRJfexmUV--
