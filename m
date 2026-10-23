Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9046606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZGs8a1nE;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=L+Tpwvy9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DE0380DEB;
	Fri, 23 Oct 2026 18:37:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BokCjSFUka2h; Fri, 23 Oct 2026 18:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC2CA814DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792780646;
	b=Dmkvinx3tML+sw+y9n09LYJU+eUmpAkaA/z/3xAJEiFcHhU1EFP72I1BV2n6RL7zgz0C
	 DLqcMVOlr+GdZMjx/3byRJvTxePlSWE2GO/gGKgbs58fcXC4n2KT0S3OxNIVG+5vIkXXz
	 xZulUG01edLbryioPxmKN58x4jCjgGiKujS7NVSKMpbOGsDg75VQm53g5xcs7QhOt6DJq
	 g443sAYBtRHGmmpybqSs45zjZyDMHWSnbfzkvkZ7k/mZiT7zJGz0P1uNcFlD0JPigRGjO
	 G010x4SXti8bO4D/LqK8GdP5kzADm+BQbzhxVyKI2BN/k5wgKu2nb2RzQqX7ulq0UAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792780646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aHq8lsYPZReHK6LRupP1S+4rYCZSBCIv0X3RNPYGuU8=;
	b=Raczuvu1+qtJMD9KHpeWmfj17X2rOFrOtXb7Wffq00wStol0v1Ud2IIpu7D4FW1LZGgj
	 3jC1G3o8md8DoI/JthkdGrqjts4f54jj9QCInYtwSwK3+BiO4CpJWsw5WXt4RmdpYGUpn
	 ZIDJfz7TxPlO1s/xao6pgJVEGLDXd6Whls11GyrAZHYt2pI34Bz3rxnnRMnieEPk9Rxwy
	 MLJ+hYGMnnlXpcpmuJTN+1mIFe8rgyO49WxffJhirWTe7ymcKS4FY/x/GWevm59SH99GE
	 Le3GrswdRvLGAdFxhCeW0AOgWJ6bzzobcNwcQ+/4pfmToPDhlnawsyMTmIgw5qz+cZQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=L+Tpwvy9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792780646;
	bh=aHq8lsYPZReHK6LRupP1S+4rYCZSBCIv0X3RNPYGuU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZGs8a1nEjtmL0KPd9F1xi5U5ct0K0MEWMFBEelzI8OeVVG2UMWSCIemIl5MshKyvx
	 ADwCFwKr7GDVmlCYCW9TYYxG17BeJ00lI5V0wjHpDSb3D5iOhpWPogHj50O9stYu3c
	 6YAJ0BqE6w7BiflC+Ay/1oMkSsfzmPsvLv1tz5pfaynkq1o01h917vdvAbyBxqxQJk
	 ikT9ybwyyUy43A4CI7y8L1QrQZ4Kb1zFj+wuAnjkNbnLraMg5I2innwcP/5yTe5Cpo
	 sPVpy+rn9pVTdwcDT7gsdKcTxXkxC0YPic1uirW1Ihdka/lNNo8AxBnKKZPZjXca2E
	 U8FasEK2aZ2pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC2CA814DC;
	Fri, 23 Oct 2026 18:37:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18F12235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 18:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F210E814DC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 18:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bsFqJ489PbS7 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 18:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36DFF80DEB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792780643;
 b=jok6V7W+Xx6cdDeTJXRNFxSuAhTMjJiWpORxw6KhImQcJHGrnI7J6wSLM7dv6p6sAri/
 yNoQWLhsAzjI82VAZ4BF0AJ+pKen552TxWYHfZpNFQfn0kLRdjqJRSAtiHVFA9GG++VH0
 1uZE1V1HwJR9+H2EcjZLHMvrIlRySBSfzhOod+73f8OmH/91L276Q2rtsDWgRh0SZsqqz
 c4z/4KygVsrj3qRyLK+nzmK4tUlO6cnQXZGBCruB4j2/GDMwgxd14A8AAvcEKSJ4SdBxL
 0tFKkPesJ9ASXYh2/K2sge+IDxriSDHOv7m22LFGUi3Vr75r1EYZSXzum/GV24iV5PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792780643;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=aHq8lsYPZReHK6LRupP1S+4rYCZSBCIv0X3RNPYGuU8=;
 b=gINWFeovrkH37KEreMk8dLpHFzPYPGAIDQr9sFHwZOVsyzATQjDC5nU0Yt6rmR6+PnRP
 +eK21TMNo/IVKVPO6CoU+wDvha+xa+VP5FpCqQSMBXrlrWI20Xdxi8FCPyFKVZSabusvM
 6SYo/Jdn84zPkt3eNYQZ81VGzrahrA1L/EUdEEdOPTaUAwQz/fpbUuzywbmCsQ3TEVYiq
 NyrvAsmYwEd/M2Xd6GC34cY2hAqJOPE10MK3IiaKVguAJfr2ZD9swFjq+zZg4U6v58+PJ
 vfcDJm/lQAlVK26hquP8lIQxjxeGEzvJbdnsQFeCmjQPfvlwx3ZYK6zY4XS1iBDEH6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L+Tpwvy9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L+Tpwvy9
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36DFF80DEB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 18:37:22 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6dd4f3f696aso721594eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792780641; x=1793385441;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aHq8lsYPZReHK6LRupP1S+4rYCZSBCIv0X3RNPYGuU8=;
 b=L+Tpwvy9vvauhMwAHsGRl8W2kdn7+yavEeBwDNvIq6z+v8KwR1ALlZL3SkMiCTUIyR
 D0lgO4LkELzY1d/m31WhIjDkrCSyVKC2SG7Zv0xWJaPE6Wy1dRTMris20bKuhxRsXKrN
 AjQ0hCqRG3eazWxbzFx3b/9D+nzfDwQsZiku4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792780641; x=1793385441;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aHq8lsYPZReHK6LRupP1S+4rYCZSBCIv0X3RNPYGuU8=;
 b=VCziMQrhHdQl9K+tMz5HFKgHAqRZhk5kG5hbb3y1NkbGIaWA+2rA+2h3Oh/SWCUhit
 pH1iUsQb7IFVWaieMXNUvffE6kOgPXr5EuJHPu+ZHesVgY1pKrm0psv1+808T/4z9+4T
 hPhiD7q9N37PRqX4AnOzbSH0oFoyDsGlB1OBzSf0c8m/4M4F4xUHTnNBoKy4W2mZOCMD
 XO/Lm+s8bAmsUlpLj6xLcbbw+zf9jUGLvhgcrpX/CB1cPY0saJGjKgoT8otvV+oCmmbD
 ijCRI3IyXH38RQvds+hopuTbk1eZhMENNjvzNm2hzXtIMDI/vnfeaFERPt61+/MaHuxG
 YfEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxeNb6xw3vSPfsZ8VFZjmGimgA2fgVmLWfPLgTV7IlsvRZT4+vOSEhN5iAk6cZEl9y5D07jCc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJTKHwfQP255N0DSohENwbvDvht7tdWRxQAnzPEruIr6/7QFiNX
 1tNybd4udwhMFehSSv3/wQ1Bsng9IejPbVXbuqYxwy8itYH2/sZeOtZsYgTB1qBm/FM=
X-Gm-Gg: AYBFou29hXT+OMFrUdZPxiOhymWfxgTuLahrG10tVtaBB9mP516G/0ulLZfvSdB9ORw
 URj0OhlRQNNGKGYQbg7rCDBHL81fwVUZp+YmBNvd4xFg9p0QdqK9f9Umd33S0i+kBvrxIlFPaEc
 10W/qmkOpEXoLBLcp9G3Q67W6EAqmY9C+8j6HjIi6/9hJuX79KEWwRTAhsG1/88qSBjqtF2aDCn
 OJOl+ceiuPUgOp+5HEShzWDHWS/mBDEjqiKXFbUBBSmDi0vbMFu5dThKO5AkEuyGtAC6k/bJLX9
 IKI6OMZmrUs7Jym3Tpsu144RpaPmJoA86jIDMwnw4P1BRihYf33/5cHwQtO6t6X/LkvCOA00QBY
 i/eA0h2mHacmr6fkfjb/k+Fx6kazOE5ax2cFtItLsxEYREiJVTP+kLlrmbiv5JBwqEmAixFO2Pw
 ByNvJMFWTPUl7pzLah0ZmLAfthqBhATL4uHysx0JFtbcRq11i7FbET25mZolEaSB/xI9CKBKJkT
 rNS+mnSfwVA7d6IGgA8trfLDV8cR1dNx5iMFFcxbwmpkofcdWEQ/0NPvrnQ2AHfw61ucYM5TbhQ
 mjpn4VQEVu/md34P4YF4zC1BKi6N67+JjpQxd0S1EF3ck1jJ+rrwq21MRr+1l6V/eAgERD2sFVh
 QESd6h0eSb7r5tClQF2O9e4DmonxWtEAUQ5UowaI2voIBxZTnWykJo0RdSQ==
X-Received: by 2002:a05:6820:1621:b0:6d7:a13d:fd7b with SMTP id
 006d021491bc7-70b889b7a48mr1899889eaf.28.1792780641650; 
 Fri, 23 Oct 2026 11:37:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a837f40492sm553704fac.1.2026.10.23.11.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:37:20 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:37:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2] arm: dts: lemans-evk: Add SPI-NOR flash node
Message-ID: <20261023183718.GJ3596691@bill-the-cat>
References: <20261016-lemans-spi-nor-dts-v2-1-70307aab80c5@oss.qualcomm.com>
 <20261023174443.1552137-3-tyler.baker@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aJFkeTVERhF9MxjD"
Content-Disposition: inline
In-Reply-To: <20261023174443.1552137-3-tyler.baker@oss.qualcomm.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--aJFkeTVERhF9MxjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 01:44:41PM -0400, Tyler Baker wrote:
> On Fri, 16 Oct 2026 at 11:40, Vandhiadevan Karunamoorthy wrote:
> [...]
> > +&qupv3_id_3 {
> > +	bootph-all;
> > +};
>=20
> Do we want wrapper 3 bound pre-reloc on every boot, or only when booting
> from SPI-NOR?
>=20
> Should this go with the wrap3 clock patch and the GENI SPI driver it
> needs?

=2E.. and upstream it first.

--=20
Tom

--aJFkeTVERhF9MxjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatupXgAKCRAr4qD1Cr/k
CgjYAQCWFgWUP/hLBd7mhvGIFIzCVT7LsdxD8QA/FB3Fm+smsAD+Mz/J9PtGgyhx
UM7d8AsgC615kqraOb0WYvasA5EyCwk=
=nVDi
-----END PGP SIGNATURE-----

--aJFkeTVERhF9MxjD--
