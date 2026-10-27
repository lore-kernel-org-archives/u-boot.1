Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA8606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Id2DDQQo;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=d7kmzMwO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EC5D407A2;
	Tue, 27 Oct 2026 16:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LgiBAY9iiGvO; Tue, 27 Oct 2026 16:49:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2FFA4073B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793119790;
	b=mV/lF0cvN7MT7hwkU6RC63Axx1QkfnoCyZdDxCqVcdkL1Kah7NHvi6jV09WQ3tSXk7p9
	 h+Ktx3htEnY9NdIYphps66QZgjC5OM+CGny4lKufx9dZuFtKPWDuzELdxq/X3fN1VTNEy
	 e0Vy+nCDOXMEO7TK4D07TfsY2JPsmpmM9mebvt+QGro4S6rgGoslii8inVNJ8ymBuiAQo
	 JtzOOQCzdKV6yVzkWbw7FIFscXh/Guwceao5vRljxqRvA+ZyV8Sga56RrGs+vhBJ2QWPt
	 mhd2GiGNihA6FEz23JvieX95Rcy1aWk0FpYIrOa+FI/bg2sxQEPHNgG/coWFQtgRecg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793119790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/mTNRJEgLu1zeusLg+hGC0ME5UHbOBiaxOrjbHY6dwU=;
	b=YBpFc+jGGGCOKU3S9Rsz890i7Ijph8mZbWlaats7NPPOeZtRggCeJZNvSTndrvTVNUJk
	 NHEgpgsDG/STCqnvmc1K4vKXVFwAi3sWvzTnCCaRluMKopFLp/GVzVUzk6rHHnyKqk4l5
	 t250pjivUOmUlcChiMEz18X2k5yFlsUpFCnpaur1rbUUnmDOQrlklVnA/2B0Vg6y/iaSy
	 l15Wko9e2M74h4AwGy3OFsAVHceeFvYcH8Pr8wbay9OieZiYdSt5AgT1sumLYnRBF3QUp
	 D2ukWG6cEUazfDzJQuMQwypZBQdUW2KeWx9SIXWE+FpFqHgZ7IMWev8hT/Gf9yg+XIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793119790;
	bh=/mTNRJEgLu1zeusLg+hGC0ME5UHbOBiaxOrjbHY6dwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Id2DDQQowUSd8aC/+MHXlgaF5MtdWLxI2AZACTLr/f1QmLNKDlg6ERqMnPLZtw4hw
	 t1rn0zEl9g398+DLFlQQ4F6AlKyIN2ICdZOyPqqW4xOpSz/9CxXCwOjpQQGYGlbliZ
	 TYuqCLCPrdY5cR7MdioVGj57R54/ciTZg/D+eymUerXvF40nhssijuuuZhntI1RARO
	 +ZzAV09ty2u25NsOrvsc4D748C334PqCy+PjtQDgF4H6nVEon0alyk9fc2r+56pI9p
	 J6omtQQz/yAMtSW2S0senP5t3ABMqYv+kddlPen/9kFR+g6nm/+AW+7JhG8gbdcpwi
	 InAXyRErly+Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2FFA4073B;
	Tue, 27 Oct 2026 16:49:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 886C772
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A1F64010A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fA7f_x1cwp_E for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:49:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8FFD540024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793119787;
 b=DrdWxof6Ew+8sAPoBiUSbjZqpop4BIVAN6BaF8m2jRcO5OK+p3/PehTH64Hz6mTibv7k
 UXAmdolow9B1/6G4z6162kXjHW7zP4U3Ebf7poq5dAKfgYUMUFn4PVgir035lGy1Zvs/c
 TvDOn/AOACiUMlFNKu+8M1eR+Lp505nCQvJ0njG2yq2eKyYghw9yL1CvdfvE8TpqmOuVL
 x7CxHPFVm3YGefj6e9s8F2zDpFZP4ZHNyScPs4A0gnBY8nI5TYeIIGa7DBIY3R0gIyh8Q
 0BTSewQD9sEUkxIe29nDqN9kGUBb/fkLZoDpW5BSLsnhZcBAOPvAJs82iVnbbWkrhgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793119787;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=/mTNRJEgLu1zeusLg+hGC0ME5UHbOBiaxOrjbHY6dwU=;
 b=NRmsXg3IUg4MRsDSU+eE90WV5NVV55cdIgKEnBz7ESg3aJjxv7e5kfygaMtU7q7wPCXE
 FWZO4TVO8cqbrfboZxNubDDv0wCl9YK+Ql4SdqU32RkCCTWHHFqc1K+QcMdoSCcHs8vRM
 94ELPXdDvy8GeIX1t9vOhnLOaaF+n2CsF3B4Zgh/HJDs5X2jRVo1u2hMXKeC67+ElEWRc
 oMfFGultiZzeqTAeZvkugU+klKdjKTESHb/QkejllCBhRDaOLcLCAPyw90bT3U4CEBL/j
 Ur0v49xjEEWMHiiEH196/ulYLBBVOCHkRlvN7B8MlVFKvhjOg0YQn6yxrxHZNpYgUJw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=d7kmzMwO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=d7kmzMwO
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FFD540024
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:49:47 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6df5e315bd1so110506eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793119786; x=1793724586;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/mTNRJEgLu1zeusLg+hGC0ME5UHbOBiaxOrjbHY6dwU=;
 b=d7kmzMwOZjz1MsCpLfF5W5+9rj20s5TMNwPPHzp0n2Z24KsHQ0f1PKAA9gimVoQ0zp
 CtmW1n8j7izJdovI37s/6F15ubXAk/3prvdb/65pxmuYV/PLTEuPW/0tjiymBCCznSKd
 glhlG7JW6t1C3A3zFJTKEtxk+5JVjrlIgXxQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793119786; x=1793724586;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/mTNRJEgLu1zeusLg+hGC0ME5UHbOBiaxOrjbHY6dwU=;
 b=A1hgpzAOtZxkC6AlTxmg5NDYCqwMBoeCETUWJczwNZgDzwrxixX7Ejm/hibpiUEsoj
 InnjBekVG79ATIwD4ZF4aWli35g8X7Z6FySvx2LnaIpxVUsVfJ3q/8QPdL3LYl8vTs4r
 4JnlUNyEiBhs+ChwV6r8qua9iF+VuPOofz4cNqcJQCnFGqmKo/PXKnrgjhzHcN7VvLuG
 BLpxcIDg2pqVstU2+x9/yhXCK/9Q0WF7SuRYGHgtfSYMGc+HaHg17PcLhBs6+m580P3t
 ykAv925nSZ2JxGETggyHOwx8Ibm/jhCCkujMK3Titg0z7kGfeFbKrrRb2/dBUHh3gsTC
 ybVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOcT6veBbLmcDucQXQFGiruEowk8VlzOoAEdAm/wqsFxtBMBN6m34OTlNZ6zTTEabhkqqIMws=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLRhoal5+1HJhbGo1SjOBYW2tjIEgFW1v6V3LML0BzVupw3RGRt
 Qaoz4ReaZDhfWTrgtTnUfwZneLrf7ztQVjBIA7L9YxVbkTBew726+Tmui7YL/XjcUfQ=
X-Gm-Gg: AYBFou2+xci2jx1k4kTnGc5S33kbnv8O6hacXKZY3gupskqufDLY1lC09CWsOHpeEw6
 6luydEll6WT/A02yMlScbJeBcKZRTcUSHa9j6pn4acRJ/3V/yVt1ud2pjjT4yk4bdcNIoSDioiA
 UOZuFO/JtDIhD8RgJBWAwJ2dwBZ7Y1lNx7JjcqgcOIBKtJDmLxbk2BuiyLcDHcWSLewJ67KBkWt
 1+ylbM51arp5uOZKmHcWC13JJbEez4nGrkbV4zvJsbcZcGtoMr9yTKKLtvFYH51VuLWkddGRMmM
 cM5Tk7v90UTOE3/Ye7qCaXHXjr5P5gNaYlEsMht03qJGmk1JVkJzPTcmCFpC27VIURL+0mufEYf
 uHF3qSo2EFI4YoF8gKpijEZqoaVfJVitFlXn23kO705mFqz5tBPnZKh1JU1/As/DwBbEuVMxWsa
 hiZYnmvpINunXNX10jpYgocNEu/n9tnlfUquEviYNJ5Zz8wdtdFZFq1HJ2QvNtkIZtrrq1Q+mXa
 URUsXDF9HUGobKY7yBTu7zpttwkwL5cDZ+v5v1HC6D/nK7pPcqa1fw6tcq/6N6SFTzAvefTl8UD
 EG7piQpwuPYmPjT5m7F0EiBHqbc+V6UBqgud1SyZ77KH8zbKQFbnN0VmYPP3cRVEpIWplZAHwJE
 jU6mKeQyKakn4mh/n3wdHt+Dr/ddV2IzzMKPUTe5Ha2DttTIK39BZ3o7diw==
X-Received: by 2002:a05:6820:55c5:20b0:6dd:9a5b:cfc5 with SMTP id
 006d021491bc7-70ba0f6e4c9mr3983580eaf.89.1793119785618; 
 Tue, 27 Oct 2026 09:49:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e2196c5sm10156768eaf.10.2026.10.27.09.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:49:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:49:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH] board: qemu-arm: keep U-Boot below 4 GiB for 32-bit DMA
Message-ID: <20261027164943.GE2177077@bill-the-cat>
References: <20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com>
 <20261026191817.GJ646438@bill-the-cat>
 <CAPzfCAZZhj8JsU0W=CtFSrAYqu_oEusD=z3zg=YC9Z3BMd8_4Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s5AN2SjSjA8Uir1C"
Content-Disposition: inline
In-Reply-To: <CAPzfCAZZhj8JsU0W=CtFSrAYqu_oEusD=z3zg=YC9Z3BMd8_4Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--s5AN2SjSjA8Uir1C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:56:41AM +0100, Igor Opaniuk wrote:
> Hi Tom,
>=20
> On Mon, Oct 26, 2026 at 8:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Oct 26, 2026 at 07:44:50PM +0100, Igor Opaniuk wrote:
> >
> > > U-Boot relocates itself and its heap to the top of RAM. On the QEMU
> > > virt machine that is fine with -m 3072 and below, where RAM ends at or
> > > under the 4 GiB boundary, but with more memory (e.g. -m 6144) U-Boot
> > > ends up around 7 GiB. Every buffer it then hands to a DMA engine that
> > > is limited to 32-bit addresses is unreachable by the device.
> > >
> > > The generic SDHCI driver is such a consumer: it transfers via 32-bit
> > > SDMA or 32-bit ADMA2 descriptors. With an emulated sdhci-pci eMMC on
> > > the virt machine and 6 GiB of RAM, card initialization data transfers
> > > fail silently, the MMC block device never probes, and bootstd finds no
> > > bootflow on the eMMC: autoboot drops to the prompt with an empty 'pci'
> > > listing as the only visible symptom (enumeration not yet run), while
> > > 'dm tree' after a manual 'pci enum' shows the controller bound but the
> > > blk child never probed.
> > >
> > > Clamp the usable RAM top to 4 GiB like other boards with 32-bit DMA
> > > constraints do, so U-Boot and its buffers stay DMA-addressable however
> > > much memory the VM is given. The OS still sees and uses all of it.
> > >
> > > Fixes: f37770c7707b ("ARM: qemu-arm: Bump RAM size in AArch64 MMU tab=
le")
> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > > ---
> > > A single fix for running U-Boot on the QEMU virt machine with more
> > > than 3 GiB of RAM: relocation then places U-Boot (and its DMA
> > > buffers) above the 32-bit boundary, which the generic SDHCI driver
> > > cannot address with SDMA or 32-bit ADMA2 descriptors, so an emulated
> > > sdhci-pci eMMC silently loses its block device and bootstd finds no
> > > bootflow on it. Clamp the usable RAM top to 4 GiB, as other boards
> > > with 32-bit DMA constraints do.
> > >
> > > Found while bringing up an Android boot chain (TF-A + OP-TEE +
> > > U-Boot AVB + eMMC/RPMB) on qemu_arm64 and raising the VM memory
> > > from 3 GiB to 6 GiB.
> >
> > This is another case for LMB_LIMIT_DMA_BELOW_RAM_TOP too, isn't it? In
> > this case the generic SDHCI driver should select it?
>=20
> I agree that LMB_LIMIT_DMA_BELOW_RAM_TOP belongs in this picture.
> It and the clamp will complement each other in this case,
> but LMB_LIMIT_DMA_BELOW_RAM_TOP cannot replace the clamp(
> if I understood your comment correctly).

Because there's other possible issues on this platform, even if that
driver was disabled? This gets to what I asked Marek in a different
thread, on if we should invert the logic and make the new behavior
opt-in for when platforms are safe and need it, rather than opt-out.

> I can send a separate patch for adding "imply LMB_LIMIT_DMA_BELOW_RAM_TOP"
> to MMC_SDHCI driver.

Please, thanks.

--=20
Tom

--s5AN2SjSjA8Uir1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauDWIgAKCRAr4qD1Cr/k
CtfvAQDTpHfTahRmkXhtjeN+4gOcFTFhbKeyVtpM4p9pojxuYQD+OwdjiK8W0xAg
szgQrFQvdrSc1mGUqwDpkUjODNXHUAY=
=yQgu
-----END PGP SIGNATURE-----

--s5AN2SjSjA8Uir1C--
