Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF19C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 20:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E921581114;
	Thu, 17 Sep 2026 20:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsahKskMdPCo; Thu, 17 Sep 2026 20:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F0E8681125
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789676798;
	b=JXnGN0guoju+BhMzvIQNNshcDDAMZ5iezXZRLhSe0wc4H7X12wwEjmIqXycPQiEoUJXE
	 utZkEwsxmKshtigCA5guD7hCd7Yhxa7ZoJBz47KiUBKaSjvX1Uy7+8zdoMw6gCDspZVoK
	 g3OBRKdZuH/3tVIKhVwSueppOmkq4kZykv1b31iHvD1KpKUn1NtT3D9jr2VjGJfxWUIUr
	 tBmjXmBMFf3EZeCPW0rFHR4qwdI/VNYbeYTAlM2REw4u4riX2ZCRMgFDncMmDsE4da96H
	 uQH6zeKb4e/WRwWAai8r0dtuIv5kE7Q5rwXwtiWNAtIon4hjnzHsKZOG147mdWiPSlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789676798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mYUhftV+4/6Me2hUfiU/8xuGg/ipDZXjOkY9epBXOO0=;
	b=jru9YXiemgrXgymnlWS0s+pBcLJTn6EGqll5SecOXJka3+1JPslFEWngXf06EeOLtywc
	 T+2NfC8PtkT9izI6znf7XQlfYVo8C0bM8ndTdDNHq3ewFygtC7XAS4isTbvc9u83Qeltx
	 C10JtT266hVRJ2g3chtfw0ponj6gdl0wlbmvdSaBLpr5gOIYF1frHXhkt2LeHKvQ9GZhe
	 aBqhdDWYGEByrVMGchBfHBBFq0JulAxhiQMfGnh2BST2KKFAzVSnXAeu6jaQ5BMm7oXV3
	 gbCCAuPeej2Tvw84X+X74FJzwlW61gaNh07lfwxW1/5GrXdwomY9mxhO+jyyfE8ZSYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789676798;
	bh=mYUhftV+4/6Me2hUfiU/8xuGg/ipDZXjOkY9epBXOO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ed7m0DASIS7vmdjNbBo/UT0xXbC4WtQ5ig8P6d5C13C24f2Ec8fQO2qmxlFy/d84Y
	 rzlw8DPzDw7w91RsAMbFut35yJs3xIutVuJPaBrX1F/gxPjN/iH3++dyoD+QKhIYvG
	 HpusRxk57FrPPw4bwcviLcrxoy6eWb1CgSkAIjuBKFablCwQmTbLJmG4mVcWAuDifb
	 7ussekDGkh/MOOyuISkiTx8QDpkbDliDOLO+cyNFedkwOxSXhOyilXdechj2gTQV+a
	 2zg01LwYsZjllZSAFea0nmEsUfEwkc0fPgPaIJI7opq3pRbPeGzBfLFzXu2y6T/VGo
	 brdT0xU1uSuHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0E8681125;
	Thu, 17 Sep 2026 20:26:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D7903B6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F26360A8A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddkYchzzwB-9 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 20:26:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43EBB60A74
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789676796;
 b=QEtOJZBy2LjfP9AkJ8wVvKptEA71C0yEUeE0sQHHX/O2zeidRSCeJHgjiqXd3yBqE6Se
 JoyXE/g2kJA/Um61UE0CE6on8jWJGCgJ2XJBwpGVCry0YvRRWroN9X1bLnrFls48bgfeA
 9hXbeML5tTEqkldmqcboRnd6xzQdDkT0Tw8f7iYP03s+UVO7hxNlKWHxkwrCyOwks59vq
 ZhfrRwZYeKRhwcXCHhPt3wqeHhG0JuB01ySs02fY+z5zKTqBm9U3bRp2WrMRlOLTMznzK
 hIUO2o7L57rk/h4PQ1DB/qbSoe8tNV6oDZrpNHRaEECYFwrYUJYbMra7ZmXZpQPQfPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789676796;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=mYUhftV+4/6Me2hUfiU/8xuGg/ipDZXjOkY9epBXOO0=;
 b=LtqJDNMel+jARAYOXlk8yS6X6TfoXJfTIE1Pb69OtTw9+Fho9qBUDNLG7xzpyULrcrun
 SbSxd5xzlowHhVfop6DzWLlzuNvDfH1l+h7gVsbhU0/k+8pPnuu1afN96GWCL5MtTUhfj
 0ZZflk16uYHpYFhakyJ4ys25OQSB0siLJtbhqdzFmb/qEkOBtkM4WdD4pH8XjZKiubmIo
 eiPXWzkxkJljSPdysZRbgBo8rxXMfdRpvOTPTjEvYWqld42DDajCfli8hh5hc+QCLboJd
 iwVJc4A0NCc5cGpS4FmEiTnfqSjmWIVxcNBW/LfosCUor4IwgDWoZzcCsvlPIdDCNFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QqkZL6ru; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QqkZL6ru
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43EBB60A74
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:26:35 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 46e09a7af769-801706d7e6dso554845a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789676795; x=1790281595;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mYUhftV+4/6Me2hUfiU/8xuGg/ipDZXjOkY9epBXOO0=;
 b=QqkZL6rujvgCAXDlzpU+DEEIfc/swM6plHR4gzYS9594D/5gBLAXAKn5FCzpAHjg2O
 aatofGynEeiCkPjGOTT8m2xs6tVG3OvoGXrKLGszBCLgwtaMCQWRQhVK/DaRJJNzeKgz
 pILn3gu8Qh4i2LiYlj0EZBn4W5sbTmxeVoNVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789676795; x=1790281595;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mYUhftV+4/6Me2hUfiU/8xuGg/ipDZXjOkY9epBXOO0=;
 b=fKyfjbZM9ojDciSWEsf+y0mph+Aw7dK1OCiED14sigtt1tVPZFM+QBSaHbYhHiCBaq
 grAnnQ16drpEsQkY2lNvub51b68lhg31gRT8SBsApHofInDyjDYp/9n3NTDrnCQG0xEk
 WKSy78tN7+zbddMtE5O4DyMfIncHBc2ihqlRQ7NfyDXfm9gicXLcXNqbeH5SUNJVf5Jp
 PVoFZSmVSCuzO7o2WkBw4amsjChsibBAX70oWlMffhigq54DP+wgK0nBjsgURVTcjx+t
 In313+oH0PG0B6o2Hl6rlua0IPP6Net4gtSfUPn3Hzf1M6pndg9RpaBTOXHHP9uliMg2
 l1ZA==
X-Gm-Message-State: AFuF++lbah/t1iOYK2TNvV+pSYah6AWEyf5eF/jughQ3WdXbFnUAK26M
 Fpgoufn0UfZwpTeLQYivYa8/Ba/vozV9GS0bbW/1MLANLSbTFSYEkjN5hZ/r70Lyva0=
X-Gm-Gg: AYBFou3FCRFXIcrVuHEXRFEURLxI75xfN/yaBJLI1CBuFzJEgbSR9KEGT+aE3FV67Pq
 RNdffvkQ8E2GDTSXfGKGx+SlCGGztUTQV06Xh4GJaVCJQRBbcZDPCG/2TZJP+s4GhyezVc1CNDe
 t6lAgi34gGH4t3DQMJykeXCpXo0tCmbd9gDAdlTCeyz6X7wPepfd/fLUDEXnvkLyTzJBLkhPPio
 FEVyDxuSjPrfFdWHwI1sNVarGXhWCa1g+fJs1MOgzTMwSkU/Fq3OR0Vh8X6y87axStHbrK3onCZ
 9ViFezrjDlBlq8VSeHFVeZCgOkXOKq2YF5Y4f3A5u1BAxGu9b4AsR5X77OCbPWdRMt0giMr40oz
 8A0gb4yquOTrWCOoNRDK7N1iXyanCnYrz3+HBgQmocYZ16uV//MTYXpKil9gDd9ao7D01xmuAZ+
 WVcnKfcvVjSvwSTeyhAFrtfL5rCuo4sMxmtfYyRT03CrqVDCJnHkrK56N/cH9EbcuX89JCXg5aJ
 RNmFqu14zLyiDvS1NX+SMvVTW7oZ23N+Y4QnciPxyXSfp8Oj0TN4OxlARWXvLUQc0Txo4XvoL0+
 //gR29Ry6yll+elTmIE=
X-Received: by 2002:a05:6830:4908:b0:7fa:5c49:5254 with SMTP id
 46e09a7af769-80de3be354bmr346709a34.27.1789676794253; 
 Thu, 17 Sep 2026 13:26:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80c466a74d2sm3706575a34.12.2026.09.17.13.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:26:33 -0700 (PDT)
Date: Thu, 17 Sep 2026 14:26:31 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 0/3] spi: Introduce driver-model support for SPI EEPROMs
Message-ID: <20260917202631.GA1519344@bill-the-cat>
References: <20260615175118.53720-1-joaofl@gmail.com>
 <20260905102431.426747-1-joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EyFLnUMosKGcmkkw"
Content-Disposition: inline
In-Reply-To: <20260905102431.426747-1-joaofl@gmail.com>
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


--EyFLnUMosKGcmkkw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05, 2026 at 12:24:28PM +0200, Jo=E3o Loureiro wrote:

> This series adds a UCLASS_SPI_EEPROM uclass, a driver for AT25-style
> parts, a sandbox emulator and a DM test.
>=20
> Simon, thank you for the detailed review of v4 - it was a genuinely
> useful read. The point about the hard-coded 16-bit address in
> particular sent this somewhere better than where I had it, and chasing
> your comment about the non-standard 'size' and 'pagesize' properties is
> what turned up the atmel,at25 binding already sitting in the tree,
> which now drives the whole geometry.
>=20
> v5 addresses that review. The main change is that the driver
> is no longer hard-wired to a single 16-bit-addressed part: the address
> length now comes from driver data and can be overridden from the device
> tree, so 8-, 16- and 24-bit addressed devices all work.
>=20
> It also fixes a crash that v3 and v4 both had, and that I only spotted
> while re-testing this round. Adding the EEPROM emulator to test.dts
> makes "ut dm" segfault in dm_test_spi_flash: that test picks up its
> emulator with uclass_first_device_err(UCLASS_SPI_EMUL), assuming the
> sandbox SPI flash emulator is the only one. The flash emulator is bound
> lazily on first transfer, so a second emulator described in the device
> tree is bound during the devicetree scan and lands first in the uclass.
> sandbox_sf_set_block_protect() then casts a struct sandbox_spi_eeprom
> to struct sandbox_spi_flash and writes past the end of it, which trips
> the dlmalloc heap check. Sorry for shipping that in v3/v4 - my testing
> had been running "ut dm spi_eeprom" rather than the whole suite. New
> patch 1 fixes the test; with it, "ut dm" on sandbox reports the same 28
> failures as an unpatched v2026.10-rc3 tree here (all fixture-related),
> plus the new spi_eeprom test passing.

This series causes sandbox_vpl to fail to run and so CI fails. There's
nothing interesting in the CI log at
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/95436 unfortunately.

--=20
Tom

--EyFLnUMosKGcmkkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqxM8wAKCRAr4qD1Cr/k
CkG+APwOImoeR+mfH1LmL3CEpVouFgFlJFPOgbsnn1BXHH1lrwEAiAvN/xo9w8Do
6MlTTfVGnS4eIs3N9XXpQDaFf6H9Tw0=
=8BAe
-----END PGP SIGNATURE-----

--EyFLnUMosKGcmkkw--
