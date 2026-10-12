Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8C2CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3540D60600;
	Mon, 12 Oct 2026 21:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxOfqiw90Ob3; Mon, 12 Oct 2026 21:03:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 47196605E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791838987;
	b=OW2bJXTUEcleAhoj4+6u0UFiCfnWN7aya8ZMSC2NOFt4GkNIfFEQj6cGyNkNktezkdwO
	 jpl3avC5wrUpftdclxphTwvMuGoOGs4hzTgFIHyua4TwL9JRWHecbxLyymMVhwhIlzF5k
	 pQxzsWI5FKTfIcgTDt4AaZPMXLYak5RSMezYJQQcdq+xagzlNJzcQIBOgIbcrjakb9bpx
	 iDiYZf0Wnp2xSaoNU+uZ4CkBLF2Ht2/ddRbL3hrK/EPLyG55OgYmrdeL9fzg2KVUVr7si
	 WgG59T82BNr96U36wNYDiEYq9eC5JbsfyIWIlUzxWsszN9sIyH2Lu9GdlCXG/Jg4crw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791838987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0rfVdWg2avbxiPrnCu1bq+fZoETD9r5fM7cMOjxmPV8=;
	b=JswS1LiiWSqcNbPzrojZfTSKcJL0AKR9fyDwWze/K2/TnIHzOxnBMOew9OsQbgjoxS0K
	 u/CO8iP14ZB5JxsEPEmusRTck7eb3xqdEGmNQiMFxM8knm3P5Q5rGZWiWzB1ZpKk4KvTK
	 lWxvxD5RpCPEv8RbvDgNjtnPjwGHFWGJ0+tSxrNte2qWF0Jaaxy6BZHJ12ayKB4qaFTfT
	 7FxsMnjA+awz907AS7FXi7Bk0ZZq/Blw8QxFmOSMZQX/B5fpQg7XP7QgqPrws664n4A1z
	 4aoHB/Qbk80iC0PHe2hjf6PD6srQ+psKRZMf7H7hKIzbwHPAcF7V0Xout7mT73cRSvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791838987;
	bh=0rfVdWg2avbxiPrnCu1bq+fZoETD9r5fM7cMOjxmPV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CWdyis/VoDxpe8gazUIxwrQaY8xCMwnBC1DBZldCkSIaQJ4N6/RLhVp/WgOoD07j5
	 SB2q7QshNDIxnQE+Oc+yA1uxypFlS9Wz4F/G1q4mqv65nVhtuCNa9RWxrJJPMrjJhf
	 fym5yAkJCW8cnqHsi9c8XSx+Xke+N395Nq+O1NBl8q5dqJuU89PCm/TzmLwkLNBrAm
	 lBb7AT8FVvEqWKZeakaZIDyefjdSEmSRWYd4psf3cJxUImoWR+XvrGUNmddfNm8Dud
	 HRmldHkOXGFQIqJp7HxXCVg1qMTLMTxKSr4BKxETB5193TTtIjnc9VDDoAVysc3z7I
	 kOV8D52W86qPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47196605E1;
	Mon, 12 Oct 2026 21:03:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A84CF2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C1A34010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtVAVwRWCgs5 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:03:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84B884002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791838984;
 b=ltm1ycK3OGf2lNOOCqtx7wuX42/xaYpQ9Ofro2vbs8GlWKEzjeM+F1+3i933AO0xQdHO
 P2j1RdCgaHoT3M6NufbZofvdUb8/enRiuvCno1YC8X8AMyuV5J37jXhR7Wjj1yN7Hx4BC
 xJZiz8DU55MwEBNpJCN44Xxgt2+Ow7nO2VWuryJEprcDqf+4Wu0iE0PJvceNMVGLOzfRQ
 wNKTmwn0Y05jhNt2lmK8WNN6KquthZfaLBgHH9uD66HQDuaV0eBFIbhwV44NQJnAv6rx2
 yPgPGLIYYFiNyk0oWNDPwAg/JCArNFBiXtzfH7NOimC5NgIujtJTzAnv7TE9MPYCheA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791838984;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=0rfVdWg2avbxiPrnCu1bq+fZoETD9r5fM7cMOjxmPV8=;
 b=FZTzipLEri77O0GUYuWUYfIQVxwOjtDJ4c4fsf2BIP+kUPigijQke6YfHQDeQdJdh1c4
 Xnmu8HcT1uroOmG9uhzF9JD54LrzAl6EcFwhY++EEaUVa4qYIIT0VUClgDaHpa6OOT2fJ
 2b+HY0DYlLF2ZCCrj+pLH4o/sGsGkfL8Q/oskVjV3XaeHXZmF9pWYbHNFXAyutdoH+3kM
 0wjwsNMOT5l5ytkePwUjXLreVIvJpM+IbMyeD4wulydDH1oNGyebW30UMLdH8s/JPT+nK
 wpA8m+CU43Tlbw9zMxRpRFGH9XZe2FLgBVSzbxM84xG4Ezb/LAcKTt8DB8zarWDCUxA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nAYwLdgV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::6;
 helo=mail-oi2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nAYwLdgV
Received: from mail-oi2-x06.google.com (mail-oi2-x06.google.com
 [IPv6:2607:f8b0:4864:32::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84B884002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:03:04 +0000 (UTC)
Received: by mail-oi2-x06.google.com with SMTP id
 5614622812f47-4b374c2cf2cso280256b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791838983; x=1792443783;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0rfVdWg2avbxiPrnCu1bq+fZoETD9r5fM7cMOjxmPV8=;
 b=nAYwLdgV8I8INl96ZDQFdFVrV1fk96tfQwyqosxbZxYqS5BnUkcahXaN6SSwQjjqo4
 lJTK0C9UCGVVDmEnAy7BUrHJtxcNKHJ1stodz5X9z5gLtYaWt9LxKufhnBVw4CkOZ6+X
 VBe46AiLUcfT3BaVHzbVVuiWnuWCyjGuVYBjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791838983; x=1792443783;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0rfVdWg2avbxiPrnCu1bq+fZoETD9r5fM7cMOjxmPV8=;
 b=JCtmCkKdJRwVVdRM9lW+Il2ltYLetYeUq8TRLtytAeq/6Btxu/5hMyUGI04wpip5Sn
 SVn160xmg9/DDfLqpsJ3SD/SSF2xIBUPiPqH5g2TfGXq8v9S8lBezf6/krWNAP8hIGYU
 egxdGRfxTwsPvLjPWLCT1/qte8fmR6Vwc3Ip9hIrvPN7UuWRyQjkR1YT9ssIbKOlZpTk
 z7T7/KL5sbHoXFRXpmR5LjWoWHJyDmmDN3COIzmSmocBGQOkip6w8fX4Ek8VlSW2vt2C
 LHxZFMM3mbKB1TUjWUEntlwgSaRNxZdTZeixdVF6B/w4J1A+fVJNhlnPUl3xmrx1KRmQ
 +Uig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwruGR+Q8NoNi04YeMO6kwaIfX7TD/lVYwnsxKO86T8GjMpsjEUoCbVYJkOHbd5XgR00pxh9Fo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLwaNRbXwQDHx8DtPGyG7qAdi5uLbRPOftw7qQTdrvsbSyYa6/N
 1+5Wpkbx3+shvUNDiARLKKgSK3N2BOprvtGPlp3ESfBNDxZjpg3u1jBLZz/OvXBJA5i5ep7TZ1y
 XHP38mVYT4H7gIR4=
X-Gm-Gg: AYBFou3JqpyJZbzepKlwnvCErrpmR1J0OlnUPWGBhZV2W6zhdDUqQC0aJ410Q10id+a
 2KEwi7fh96jsGaG2buOY5EWxUv2BqEBi8TK2oYIx5IcEXEfsfpc/ZJNpQwRNsQ09Duy416QhbdI
 DwuTLM9zkzsOnqLVlu3TB5MyPaG2aZeh+aKOel0l0uhsDjATA7bL+cRBb4OnjkwXHyRupoLFlCf
 rXwedrlm0CH0Nrd9DlgJzWOr0Pqu9S8/U0uBERr+bhFfqVUaicAKVPpMdAy9sfQRnHVzZ02QAw/
 Qy5viOa6AdILajoHmUjwLENztb08pocLvJHioUkCLbEcmHDjYymmnn8ihYfz9ugcDOwOQnhibEb
 eHL+tXY6YDKPUIWHgrHLRZAfqSTMwyveharM8e2CLQWKu91pkXDbS8umUhTFthSSu2T7u3oEmIR
 DZrLp4IsVFd0XzNbgExDA/pOKrHJkPVyjuWLobQ1QXIXA+1n9B+OSBF+YrZtc009apqeLC7/TLX
 i+7JnB9fX6wPAQezQkmpc3pjvr53cheA+PGAZdLY9Sh+VjWfA5nguQDb22eTxSKwW8AkEVuizEN
 yJJ86yUT1HgtlCKeKb8=
X-Received: by 2002:a05:6808:10c6:b0:4f3:68d6:f12c with SMTP id
 5614622812f47-50c5019e150mr9206393b6e.24.1791838983152; 
 Mon, 12 Oct 2026 14:03:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a7e58c0bsm10991892fac.0.2026.10.12.14.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:03:02 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:03:00 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
Subject: Re: Please pull net-next-20261009 [corrected]
Message-ID: <20261012210300.GJ3722450@bill-the-cat>
References: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
 <20261012200814.GA3799261@bill-the-cat>
 <CADvTj4pfFC6JOSwK1AUEQwZ9=6niGAx13e5fiP09L6hbey4rzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sLYQnfO+08wHDfUM"
Content-Disposition: inline
In-Reply-To: <CADvTj4pfFC6JOSwK1AUEQwZ9=6niGAx13e5fiP09L6hbey4rzw@mail.gmail.com>
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


--sLYQnfO+08wHDfUM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 02:41:42PM -0600, James Hilliard wrote:
> On Mon, Oct 12, 2026 at 2:08=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Mon, Oct 12, 2026 at 09:47:05AM +0200, Jerome Forissier wrote:
> >
> > > Hi Tom,
> > >
> > > The following changes since commit ed869863c7e2aca50d57a05d843830dd84=
3138c4:
> > >
> > >   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-proj=
ect.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -06=
00)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ ta=
gs/net-next-20261009
> > >
> > > for you to fetch changes up to 28ddd369e2f7199539cdefe22ce014c592b890=
bd:
> > >
> > >   net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-09 18:5=
8:10 +0200)
> > >
> > > *** Please note ***
> > >
> > > Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a =
build
> > > error detected by CI that would otherwise be caused by "net: e1000: u=
se all
> > > RX descriptors". I did NOT send that one out for review to avoid dela=
ying
> > > this pull request, but if you'd like me to do otherwise just let me k=
now.
> > >
> > > Similarly, the test added by "test: net: cover lwIP DHCP autoload han=
doff"
> > > initally failed CI and I incorporated my own fix (see the commit
> > > description).
> > >
> > > ----------------------------------------------------------------
> > > Pull request net-next 20261009.
> >
> > Now that I've fixed the sage lab in CI[1] I've found a run-time failure.
> >
> > [snip]
> > > James Hilliard (20):
> > [snip]
> > >       net: lwip: finish DHCP before starting autoload
> >
> > Fails on BeagleBone Black with lwIP enabled, none of the network tests
> > run and the log output is:
> > =3D> setenv autoload no
> > =3D> dhcp
> > link up on port 0, speed 100, full duplex
> > =3D>
> > and we never get an IP and so can't network.
>=20
> I think this should fix it:
> https://lore.kernel.org/all/20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9=
751568@gmail.com/

Are there likely other drivers with this problem?

--=20
Tom

--sLYQnfO+08wHDfUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1LAAAKCRAr4qD1Cr/k
Chg9AQDKiZMNodzGR8LwJHQqlSmLbYSYk4dpVNqK6k0YKXMbPwD9G/XgPA/Bcfmu
ZIKdsclVBMtA+vmS08WnZHulQBk7mQg=
=nO8z
-----END PGP SIGNATURE-----

--sLYQnfO+08wHDfUM--
