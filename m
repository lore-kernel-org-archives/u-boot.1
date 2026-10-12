Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A1ACA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7159D405B2;
	Mon, 12 Oct 2026 22:45:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ii11YQcnNiSC; Mon, 12 Oct 2026 22:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 693EA40596
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791845139;
	b=qCRhsQ6nHsX5UJQdz5ea/Jo4DYMdn2s8yrz25I7ZYrsmhhGLsSxW5PxS/MyANbUGyXwz
	 LAXkRjo3VfUteQztR+teCxXwL53xVdD3nWOSpBOTDUjNqlD2RRRZLHVE6AD2DIUb5/lrJ
	 RHMS5nPN681SLGI6Ka2hsgUra+lnX4LwxoSq/GTnwGX86yukClPNHEgkSCE4bJXCatsAC
	 cdQS3cvtzVgtquqyeccl29e4SNEtTLPAJt5kn9dQSvb47KyiuIUG/4lYBwujejszu0+Mv
	 P1XprPE2Qk0NhbhoMCbP1odN09i+51XgrMEiJrNXvX2JMloR9JI3U0y7Q+m0hJVRLJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791845139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tzqodt3yi6SdNenSkP3mYGEfUlce+Smo6uDKqrW21ds=;
	b=DVyyzgUHS5svb/VWHfSQZqD9mEsJuEfCQkvWsfssoPeQrnVlYGOTKTADKHkBoHvXsGvR
	 +Dm1oz2HpqpkQNwPKLDCWx7XgjoVuC9eDiojlR1Utwkbm7IBqPuc3GFqYCs72OaBMJuCb
	 XdgF2h06WyVxk2OpfL7MkwZHQjtseXCc/mAHtXHLscHnjIoUEOIOuiacNEYsx9oKfuiDy
	 LQmkCLK/gZuSqz8Bp0smAF+btI2eC6yZu9ULFGjB+qUd07z8MHNzpEBNWMsLRLG75gHst
	 kpl2tHZXuoZIss5ci3mGJtPdsd7vewWGqhAZiRMIzpYB+A8yoaZYandq7iehi68CCHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791845139;
	bh=tzqodt3yi6SdNenSkP3mYGEfUlce+Smo6uDKqrW21ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vjaxz9lPi7WDJL3uey4jnzOABa/Qgwb+pClcKXEVU6CwKxYVQtkmMahJbfPYUeo4j
	 06vA0v5XCRyEXOh0laqtXPL4RXYNBqm/YUzu6GCMJ74ORxSzA3btvGZYEVUzAg4ktp
	 74ip0aNgwlaUoTYDB5YFIM8ySLgpOUwNAt7xuRs9JvL5DDL6nN1knx6RRr53W1zjoE
	 PYJcVxzAmI70I8gTfQwqcl/n/FEBYBJ+Em1obDKawWdGzqVYzen3J8WZtqBj1+TOM5
	 MBbc6hVlAl52GcHCOQgzz50CXatPX0k86ky5UU6/yB3/gOuiah3fUAdPK+p++Uok+8
	 IzMHTbI/UXkkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 693EA40596;
	Mon, 12 Oct 2026 22:45:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4459B788
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A03B6071E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GMuMZmJRsyar for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 175B160714
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791845137;
 b=hlZNIPnbzr9/tFScgZMMgx5LgGodqNdG3HP2Hz95E5yP5b1I/KAqXL9N+jxktueyrYzs
 eMmsZ82FRV0kcjv50Pzoamfgdv9DbTGJT7tZaDG43XEkZRYDnzAPUalXzPMiIhgjrUCQ5
 qxkmWp2uSs3Nb/zbUqaRD83/Jtv0kbcWCXAlfgLEMH7VkDvB+gESPW2mbjdD3MSqq0Pmw
 tAGnuBz7dVBBLIV8Ku/SWbhoROkJ9O4Lbcoo68rWJ1iKShj10gpBOtKL2hb/IVzBJOFKQ
 +VjVukJOD03vE/B2QkB51Em2PfLe/ssat0ZkxTrbNcsaJKhf415fDXIauVrryGDT/Ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791845137;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=tzqodt3yi6SdNenSkP3mYGEfUlce+Smo6uDKqrW21ds=;
 b=MwjBD0IOm91LPQtsZOvVOD2jri6hZMR++NY0sgS+5Y05Bcjpr5ZN9iuuxJRwdYr+B78T
 HDDb3e5Vds/+4UgVAs6MYdmn3jm2XyK6t6JKYHRKepVkKOkHDB30nT3po6s7BkaIAfSkI
 HVGE1GhdswUxhmfyz6bVDdTiLxZ4iMso42mqTCP465lT01gGLYqd/D9rQhM8vBnYSKu1K
 ZeWVgfR0/MVDe8TOyYn2OxtJuoHvMiQlVLsE7cnJcVRUlI8Qsind0mzt5MbPjzf4T0B3d
 V10mTOUM1Gg9gOvx3TcPFErVrlJVzOMWZf5yHVk8qlEa73PcJM81ugmuZDBfsxTcf/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="b+KWNr/p"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::;
 helo=mail-oo2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b+KWNr/p
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 175B160714
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:45:36 +0000 (UTC)
Received: by mail-oo2-x00.google.com with SMTP id
 46e09a7af769-8235d03de17so897873a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791845136; x=1792449936;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tzqodt3yi6SdNenSkP3mYGEfUlce+Smo6uDKqrW21ds=;
 b=b+KWNr/pLRM0e7Mmwz+C2zBa8R0cVhx+Vy/IL4Hr8HnMQG4BnMk8aMo2dGOUnI1ugQ
 kCx+fHy/pgPOjXBN3P62aXZlID0NV+IAZ2aKaOxlU+ppE3YooGn5PzvbJKMDnfZ/LvyG
 d7wtpci1Wi53sfwILk/XrzLWoefj70Zl1tqfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791845136; x=1792449936;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tzqodt3yi6SdNenSkP3mYGEfUlce+Smo6uDKqrW21ds=;
 b=YWdlNCawKnKZBhoM8jWuFB9zoJgCD+CYA1/QIfP6to/h2fsZ5msolenZVqRcYiZU/b
 lQafkm3p9CF6ejQTDJe8AnR1s+X/Za/RcbjQrv7iePzCUngZUvKpQIbRoVFJu5Dts1pu
 P90+o4CbxR4pyQU84HaRkNIwxqdJ/jJZQutbkNScyvgT2aSfit8b2dPMlxiGz0EGEq0P
 /aGYeiZKUa2o2UmfNlnROoO30GFRB4wgi9nFVvRsE7eRp94oR38Iy3LPCgH+71gsxY+E
 rXU6g7ki9/+6w/6J/h87j9Nq3xNze3tvqmbqaNObseqNtxjyACoq/lbZbvD9ziDLBDBo
 XgYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEQeNDwEa+wjGz6Z5CiJgMxRv7zyGtaDQ9w69NKf2TCauVwe0mBG7jjcChb7dKVtVifv5/cGU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLfpM2wDdwkq/mG4HW8q6ZTyiCMSW7u2kjpJhF/nsbhJTEyIfbh
 JAy523l6mQnYHsj/JT+ZQZvR1YLZCGbyO5M8fdWbF7sE9r5LQULTd8sIFwsr4MTXSGY=
X-Gm-Gg: AYBFou0RY/nXwitATKG/Ji/s/QbutoDuBoRXBZ09YUHgEQ0sZcdspSttKnWoTX5SFKO
 U4tUnqCLJIJushgBWBA7EW+LtxFJ6EmXYNx1dYDtNb7yL2w5vZV+rWk2rXofiMX9Fb2xe426RMd
 +X6iLtu+w48dPB2VXb3DS0F/VB2TxvWS63vsgJJWOjZmD3puvoUOJj4VKwYe2e/DQfoPIwb4/VR
 wphbLt3iSbTFlrYGJZQD12ZyuSpmbbbIE9l4LXe8JS5NYQNuaHmvDgDKFg+FOphb8aIwNgfZ28N
 JiTPF+HJqmp3xTqiuFncTumISJIyqv1+69aRtvP4UgDK0CcTyfe6Z0QZAUwXfCvEk2k1cT3057v
 /aLxbeE1p9sr0pXvrFr1p0Lew1q3HDwAYJCoVHG0QBGeKH5u2mp+hQLHkYyNZUa7C9MiOK8wq40
 o+TI7wGwXg5NMzRr1Du7ltwuEPIVsFfzDn6rPRrbinAyzYG+Vy3oasiJSJa27l1OwA9PdhJ4kvD
 y3J3meAWT+GSGx3KvrKhkkcyyVB4UO/KDZ0+TyKzK476nP/wFiBY1EDmeL4MR5we1AxlrUkzPKC
 xE5+P8879qhoT7Ixh6s=
X-Received: by 2002:a05:6820:198a:b0:6ca:3ce1:ed36 with SMTP id
 006d021491bc7-6ef100968e7mr8354320eaf.47.1791845135678; 
 Mon, 12 Oct 2026 15:45:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6f47500ae30sm5181193eaf.1.2026.10.12.15.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:45:34 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:45:32 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
Subject: Re: Please pull net-next-20261009 [corrected]
Message-ID: <20261012224532.GP3722450@bill-the-cat>
References: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
 <20261012200814.GA3799261@bill-the-cat>
 <CADvTj4pfFC6JOSwK1AUEQwZ9=6niGAx13e5fiP09L6hbey4rzw@mail.gmail.com>
 <20261012210300.GJ3722450@bill-the-cat>
 <CADvTj4rP6nobpBD=N2m+babdvwVHCK7kHWpVuDix=oZNFh_gSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kVubCKdnz0s5nDg4"
Content-Disposition: inline
In-Reply-To: <CADvTj4rP6nobpBD=N2m+babdvwVHCK7kHWpVuDix=oZNFh_gSA@mail.gmail.com>
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


--kVubCKdnz0s5nDg4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 04:43:06PM -0600, James Hilliard wrote:
> On Mon, Oct 12, 2026 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Oct 12, 2026 at 02:41:42PM -0600, James Hilliard wrote:
> > > On Mon, Oct 12, 2026 at 2:08=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Mon, Oct 12, 2026 at 09:47:05AM +0200, Jerome Forissier wrote:
> > > >
> > > > > Hi Tom,
> > > > >
> > > > > The following changes since commit ed869863c7e2aca50d57a05d843830=
dd843138c4:
> > > > >
> > > > >   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-=
project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38=
 -0600)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git=
/ tags/net-next-20261009
> > > > >
> > > > > for you to fetch changes up to 28ddd369e2f7199539cdefe22ce014c592=
b890bd:
> > > > >
> > > > >   net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-09 =
18:58:10 +0200)
> > > > >
> > > > > *** Please note ***
> > > > >
> > > > > Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixe=
s a build
> > > > > error detected by CI that would otherwise be caused by "net: e100=
0: use all
> > > > > RX descriptors". I did NOT send that one out for review to avoid =
delaying
> > > > > this pull request, but if you'd like me to do otherwise just let =
me know.
> > > > >
> > > > > Similarly, the test added by "test: net: cover lwIP DHCP autoload=
 handoff"
> > > > > initally failed CI and I incorporated my own fix (see the commit
> > > > > description).
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Pull request net-next 20261009.
> > > >
> > > > Now that I've fixed the sage lab in CI[1] I've found a run-time fai=
lure.
> > > >
> > > > [snip]
> > > > > James Hilliard (20):
> > > > [snip]
> > > > >       net: lwip: finish DHCP before starting autoload
> > > >
> > > > Fails on BeagleBone Black with lwIP enabled, none of the network te=
sts
> > > > run and the log output is:
> > > > =3D> setenv autoload no
> > > > =3D> dhcp
> > > > link up on port 0, speed 100, full duplex
> > > > =3D>
> > > > and we never get an IP and so can't network.
> > >
> > > I think this should fix it:
> > > https://lore.kernel.org/all/20261012-submit-cpsw-rx-eagain-v1-v1-1-0f=
bdc9751568@gmail.com/
> >
> > Are there likely other drivers with this problem?
>=20
> Yeah, this should fix them:
> https://lore.kernel.org/u-boot/20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a=
20425c15d@gmail.com/T/

Thanks. Lets drop this patch from the PR for now (so please send a new
one Jerome) and take that change along with all the driver fixes in the
next one, once there's been time for people to review.

--=20
Tom

--kVubCKdnz0s5nDg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1jDAAKCRAr4qD1Cr/k
Cl++AQDErvjvLPai8KuC9nBXDt7rts+WyLh1Q6lRVsN9d3bDhwD9HUjoqk30ci9D
XztfxLL+dRLPkNpSFB43C2ICjxfQvwc=
=pyEj
-----END PGP SIGNATURE-----

--kVubCKdnz0s5nDg4--
