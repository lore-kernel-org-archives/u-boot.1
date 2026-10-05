Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D86CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 21:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2168880BA6;
	Mon,  5 Oct 2026 21:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZPlREZThFPs; Mon,  5 Oct 2026 21:54:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 28ED280AEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791237258;
	b=HJ4qJSZ2AmjN1ZxyqnmeiAonfvXUAyduIWXPhCdipccBkkeXSiFMb9YJwigC3hdFH5Ho
	 kUJfSeStUTGzZCqPVz3uxODIU/TfZGnApXBzZkdmsErVOPPvdEgUx3Yx42bxlYaiJuRzP
	 cmTxtDmZjKeVbQiq7j4cDvJggvB3MNikjnwxaYtxXMbHtCWtRRvetoBnC7fAJL3xzT4gD
	 hj8F68wXdKw4uwuK/1o3okxHuBT8XItxAn2N973i0Fl4SxH3C+7x6AyhS0sdQsvv96re8
	 36OhadGJecvA+EFltxvyjMkezU0u5UVsrJI0nYvELehJLnCCGQbExQy3eku7rhVRc5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791237258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uXeomqQccenWhMzp37ijm5/DgeATkao8Z0v5hTGR0Tc=;
	b=GsB+Kb4EC/36grXP2ln8vMrjJKDpBsFzzerq5MFRMTFNfI+RSh3ptLMiA8bjQgwA2ljY
	 ZYm1pKPgJzNLf/pOG53Cb9icPoCFzFBjjKzW4rr6Y6nXNj48PGRSy88m4yr/pSo4ceMfk
	 kejORoa5+Vs+zsKp2fZ91lSiJMZt46g9WK1SHoEEhul35mCbj8JWJQyy6M7E3zAOoy3ER
	 ONMpuaLeSLEZMWy9TjPy7CWfAy8+BE8zvLwuwJ1UueP0pnFYtLlP30VFfTkwOSC/t3p3z
	 cKIoaTkvzuczaILaDQmi0NGZj4xU46wFq695kwiSy0O99nh67nNpJwjjujYjEO+JnmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791237258;
	bh=uXeomqQccenWhMzp37ijm5/DgeATkao8Z0v5hTGR0Tc=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gK8OD41C/r9dAVttkVC2ypa9kqT+infG42ibRmH79pHuKQ8i4Ieo6nLwa+G7y/SpA
	 wO3qgARwLQvneZWumtk5XnzM5Mrpu9OtbDzyl+ZET+62420Csman6winpp0Ai3OnoT
	 Xdufqx/0r5Bv+2CPqb+OXVhScEYRUK/hdedI9noQZ1Zawk9Pm5fZ9xHrRkz+/IhGJC
	 8kmyS/PmXakiLRKikBG4X8eFZtKQVSYWoGTJusbUOx6F+hOd+XFhfCmSAoWlGwBm7a
	 EnAT+jLndHwOjVC+SqDjk3BwShqUI24disKawnTYWnTuFVhD0rwyQppLawDc6OTJyL
	 bShBxyC31sKfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28ED280AEA;
	Mon,  5 Oct 2026 21:54:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 102D4361
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9F606069E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p-bltNELxSQK for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 21:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F1CAD60645
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791236370;
 b=nugWzaLj5cThTZdUoOdGJunQs8Q9f2BREp8PmR+7slICxrILJCqfImrOgzPoM4K2lCST
 pvzS1Aboi/Db6B8/Hhu0G98QYjg2s3uRPiX12BekuOLJ3VpCNsBB5+dRI67XD87KloclG
 GmhzsqbWqNlKbtRxzjBzxYLwsWQpSbfdbpuueBSNVFkt0iGH84E0L0Hn/I5DaIwD5OTfG
 ErzVt3VrPI0B2+cM3/eYIRfGAMXYKdkojbJn0QLPgv7X+L4PGOoGnCt/qz+qrjnQ2m2vO
 U59fTuXc4kGIx70EdDcI2sy1uK50GFVVPbdzPqPHfA5LjgHQAY33VnWRacURmk7JkXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791236370;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=uXeomqQccenWhMzp37ijm5/DgeATkao8Z0v5hTGR0Tc=;
 b=poQ3XKZN3Bd0+gndXeB5HVOEIC6efCSVMK7nPOpWzzRO26TtT9wM5X6+Srct64xapXlm
 YkS6TOc1J5kgV+74OieF8Ha8ohxAEyvs++QJobELJmsP6gu/4S/MOpSiBxmUg6dTs5j/k
 zNwPlAHC2+4pqBsfn/CVFaC/SjUxXhVK/uaDuMvfqO3mQehIQFp8Ze7VpPU41sFeAyfXv
 /8ArJ1kKaMzExnR0v2YSc0H3C5qdRvXXIZbU6Y95ZIeIL/lU9qF97Ezjj2lx9xVopETxq
 yX+cfxnmmSLBCrwg4LIvoDpmU034SloPit1F1ijb1eeY3Lq0PBg1zh5jL4ZbYnodDVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WoVvkPXf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::8;
 helo=mail-oa2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=WoVvkPXf
Received: from mail-oa2-x08.google.com (mail-oa2-x08.google.com
 [IPv6:2607:f8b0:4864:30::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1CAD60645
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 21:39:29 +0000 (UTC)
Received: by mail-oa2-x08.google.com with SMTP id
 586e51a60fabf-48f1c6a7779so928790fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791236369; x=1791841169;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uXeomqQccenWhMzp37ijm5/DgeATkao8Z0v5hTGR0Tc=;
 b=WoVvkPXftRC+0gq766oU83qa6WqHUQWmEYK6ZyGULk7t5T6MW1zH3kF2QxF8t97nsB
 Freobx9VQYqvZ1jVXFGQSU6oEIkKegiY06joRktuWrm4tsWIA9Ync2lt2HU7Ss5bYptd
 0bKjUMDqI48q1O/nYQ91ul0YtHVt9Y9xEBGvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791236369; x=1791841169;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXeomqQccenWhMzp37ijm5/DgeATkao8Z0v5hTGR0Tc=;
 b=qShWz3GZbSWvhNBrlFfAGJRSiXSrpbt+g60GAlpdveb6tTjFLkP+1g1cY+DoapDXLz
 q4Uy022H7jWfXr1U22OhRv/nGx3GUD/J38OmL0c4jD+RujS4brI7u1hFAuzgG/jzAfsu
 D0QcUoSacceg4rx+ePAf9L4NAdt7wMoTSVjmC2sYSh8NliHPyQhYF/OfKSIZv6RAecgt
 1iNO8twihLAaA7caF5NO99q2bLWaOl796+6kaVaxAtABdzh6TS8x+S+0xQEE8BRRsEGm
 n3KNmcZ32Fw0zFcwfgOfyeO9HQ5xUzpEqEgfti8AH66grSzgRVw9CTRZh8RsvzSUzDpW
 Fzhg==
X-Gm-Message-State: AFq9FYJEBiqSCkdt8LZWiE5sKVcdmWw/ca3GgJWQGS0MwYLZf+3uR9LT
 az8LaSTPRH1kQRZuzszEhJrSVdWyNaNAVFYZHesa2EOMz5y62S08xcLi4OvLqbN62XcbHJdnI9p
 aWipIxbnnZFW2z1I=
X-Gm-Gg: AYBFou0NmHBkxysbOBshxkCG/LVJbZiLJ3zTJulVjJNxMTt2O5AEft5AowY40QUVPr+
 Wju5uj1u6K1btQwN5qAMvx5g7nfWBwDLaJuUpH5FtWiG7ICmLQIFsV+KU+VNiVY2WasvqYD1ddT
 PDxi1YTPt6eTAIaXYkzB9TQCKMkRwB4GVOhbJaJSjnaDy8pChe1VR5FkHz5G0911XuQCtnhDaUU
 1mlWWY+dSNIfIY56phidb7WHyaXHhDWLgFhE36Sr0I2XlTVHJkMVruRjdgxna6tp7BS5D4lZQD+
 GcGxvVL4BLfHJQCxCqB/ykFPlf0GKXfOBpSO+fHmmaFcXbXF9YKasb18lIL27fk8uM283i2WXaT
 qSKrUX2XS6DQIMI1e/YmnYfLZdl/GQC4xi4aqp9nxDvsvmFmxo9xcRGuWJ7fzsFaUCupt6ZbclF
 mYlC4xUr53kSp+2PKGf54lHlkHRlzRLfzfcJpb4rqKT5lc89fvlhap7m6SvRgoNq1f/mwlx72fx
 c1Dpgj7gXOw9Risku3WRf0/lwEIE0p7tFtB8aMxMPtzZPbnH2rsAJPV7ZieMWaSpGEt/K+wecRf
 5PHntwazGzgbY9vHDAo=
X-Received: by 2002:a05:6870:9508:b0:48f:e107:3185 with SMTP id
 586e51a60fabf-49e15f76c48mr10427726fac.56.1791236368578; 
 Mon, 05 Oct 2026 14:39:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16e3caafsm10639517fac.9.2026.10.05.14.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:39:27 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:39:25 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2026.10 released
Message-ID: <20261005213925.GG3724959@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZvtdkPmkVRc2Qgeu"
Content-Disposition: inline
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


--ZvtdkPmkVRc2Qgeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out and I will
pull in the next branch shortly.

The next infrastructure change (and this is also a change from
v2026.10-rc5, in small ways) is that our release archives are available
at
https://git.u-boot-project.org/u-boot/u-boot/-/releases/<tag>/downloads/u-b=
oot-<tag
without leading v>.tar.bz2 which matches our historical naming scheme.
And the release itself can be found at
https://git.u-boot-project.org/u-boot/u-boot/-/releases/<tag> so
https://git.u-boot-project.org/u-boot/u-boot/-/releases/v2026.10 for
example this time. The change from the rc's to now is that the openwrt
folks let me know I had gotten a few things wrong in the migration
there, and I've corrected them over the weekend, and populated virtually
all of the old releases.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/yyx-dsaj-iwr
October 6th, 2026. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1

In terms of a rough changelog for the whole release:

- A number of platform updates and additions.
- Almost all of our main subsystems had specific pull requests with
  important bug fixes or additions, mentioned in their respective merge
  commits.
- A number of code cleanups and robustness improvements in both various
  commands as well as FIT image handling and verification.
  - A specific update here is that FIT images can authenticate a
    dm-verity roothash.
  - Another is a fix for the spurious ERROR messages when booting on
    some platforms, with respect to reserved memory areas. If you're
    still seeing this regression please reach out.

I'll be releasing v2027.01-rc1 on Monday, October 26th 2026.

Thanks all!

--=20
Tom

--ZvtdkPmkVRc2Qgeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasQZDQAKCRAr4qD1Cr/k
Cl5+AQC/yxei8Ee/+FVjtAk+T9uy3MRWf2v8KMgIoICAROtY2QD+I2nOyXrudTFP
ynKqAx12RVTvicCqr9GsSnZQmS2kEAU=
=f6Ld
-----END PGP SIGNATURE-----

--ZvtdkPmkVRc2Qgeu--
