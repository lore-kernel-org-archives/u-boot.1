Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7CD606A31B
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RWerOJ+f;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VOphgJZT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 176D940664;
	Mon, 19 Oct 2026 18:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msqBX4e3Z_Ch; Mon, 19 Oct 2026 18:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AE8F40651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792433011;
	b=kyTcKNtfRHDVhCD9QKMDk+IDGFsWL1F/vd1RqNRHLdEjowQ09WAy5PWK2+hY1QWoU170
	 2hBrEJUsVanNPFQOWsJQklwqKegDI0bhWO7aBi6xbygPUiBpczDsc94qP/T0nnqB9HLtb
	 kNkZ++ieTAy1ulZ3hx9+8u7+K2qvvlQLrNv+ZsSfeJYxo0355mDCFOUDz/BRa+i5vViCb
	 TJ4T8t9+MXeFVtvG/R19BMEino+bNR4WOOQd8H7xH/gUVthNgOmfgH6z4f370eXanfGHo
	 8Kxug0dDtMKCB39FM7h6YKW99F2s5VT8PDjhXFDdMvMvEIfNVTF0DYHGAPWdbXzlqag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792433011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SqQDaYsAR8sUIxKIZ4lpU1M0qZ5PbqTEkAE5UaeW1Ho=;
	b=DQZmBtLcKbLwb5gQoThXG00iUZlyW9n1wvzwZNZ8Npt77nXf/W6bS6pyrNH/4bHQJ5DZ
	 opW23HEnPkHEwncPQ7SPU+rawzud7IKjjWLWqOgQ7AoG7HLs2VWYewK4hA5yNWHpk41mg
	 60cBrtur3vIQ15gFtXhEnNkHA1A5EqRPEcEvfBzQDrkXdRDuIZrQD7GU7xWdNKYz3IE6P
	 oGdH6q/uRRPkAxkzuqzvvfZoelRyIpIdrS/p4QGgzZl2rPynHs0KgR4KQ9ErZKBgzv/ri
	 iQVaDiUPJwWC4Z9PaevFkk0DX4SRfEQSChOyrMNBd7YyoDEpoI+KsYmntWr1SfffC2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792433011;
	bh=SqQDaYsAR8sUIxKIZ4lpU1M0qZ5PbqTEkAE5UaeW1Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RWerOJ+fK9pBO5MCIciCvethQ2EMOPc3jVp0Wc6QijI5opd8+WzSfhNtDnx93p81i
	 PsBvxK2CQBWl1Ul3OI1fPm01DDl0l7rVvCUat2NnDJqH/fMiRaAr0atnfjOwuqeMX6
	 dOQnUzYinoi9nnc/BiRMCEE1nzOcnbKEO2b9l36Z49ac1FqHY6HabWcZYMcKpEr9t/
	 njsYFG6HhaHv80YXxH1ERDH9gBm2RSrIfv8u91u95CFqvcWCJjoQsHss+19mksaJcJ
	 GJDn0b+6a/Z5zluD7DD5hl3xrbb/1WxE1Fil7yoDmWKEER3fJOknWjgTisAJNSdVRb
	 UhWwcVODKNRcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AE8F40651;
	Mon, 19 Oct 2026 18:03:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BC811AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D760400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tcBSJ4oisRim for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 18:03:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 867B64008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792433008;
 b=p7Mzlh1+Y4q6Q0w1FOvH8Idb25YvqqIcvzK0Gk/R2AXa7uVT5SXUK+ufSgaSwOt9u4ma
 R55qw5/yK6o3gS9/xDOxItsXiXTJZoc0DErDSXR4yDlXcOZ8KGF5y9C6yxvBIsFWsNaEV
 A0CrcfIehhJJGn1+5yA3XafFJVa4iTQ+0GR4vGDstF5TYpjjy/0hcJTgWwFsc2l05yyyt
 BcIcaOsqR3kLAp9W3wen/uFDJH5/PG75K5aaL8RcKvyEjf++dZMHWkuzbL70FedeQmQr0
 Z7L1MaAAJ4vqDfwmw7jlI6nYuTQkYi8zTRwAaHYVhzYjH0IhKCSFVNl5zLPHnfCMNMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792433008;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=SqQDaYsAR8sUIxKIZ4lpU1M0qZ5PbqTEkAE5UaeW1Ho=;
 b=pAfigPXIqUcCVXbnoKNleNm6lLyGrvpUs/vyYLbbcLCjzwLZtrV/kUjGyCro5w7qNWCv
 h7YW3eyi1wu/XZ7samqHPAsBPO6+fQxjWVk2JF5Afhenm5zuNeHy1/Dhip+FKgDpQ2qMq
 7FoHevj4HkcA9WhrVwrSYwHfBHz2UPCUPn5G2ciH1lMq6NFg8Vgxtbx9ySO+SyRmhx/Z1
 GaG/HpfxCti5aTq8+nRsDAZDPOCxZKlb9Gc2HlyA/6qqMo+GqoEp4YlnB5w1Z+9cnvQuX
 mzzIn9c5sxmCzTBzaPFuenJiPiVBB0cabKOfOznrUYLe8AF4MSFaZ1aQ9XHvt9Hd6ew==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VOphgJZT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::5;
 helo=mail-oi2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VOphgJZT
Received: from mail-oi2-x05.google.com (mail-oi2-x05.google.com
 [IPv6:2607:f8b0:4864:32::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 867B64008C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:03:27 +0000 (UTC)
Received: by mail-oi2-x05.google.com with SMTP id
 5614622812f47-4f3f1adebb0so964440b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792433007; x=1793037807;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SqQDaYsAR8sUIxKIZ4lpU1M0qZ5PbqTEkAE5UaeW1Ho=;
 b=VOphgJZT9jWeCQl0ZcmVFBXnqe4rHMzcqXE0vXqLoteMa9gyPIAJ0NU8x9Ru4pb490
 TaUyfFR66ewmzLpQastJKs5XdO9cGldMYoaZ1VzQFwpmXQxXdR4k2yiQ+dzgmRqXmo6Z
 1xThkSLwbFN8KQ3lxoDTHe9IwlwMj0VPC+xL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792433007; x=1793037807;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SqQDaYsAR8sUIxKIZ4lpU1M0qZ5PbqTEkAE5UaeW1Ho=;
 b=xAuRZXd4926LJosaXiQDnINygLH2fPc5yifqHoyxxG7BgfFxqGxq6b8I5ZjWg6I7Jd
 EUcLJXRHVbu7r2GlEeA/JThB/vbZ977l+2HOiXrLHEaj1Yw2oX0rAuA+JwrnT2aCohel
 RhyrakBaC4EzCyXNsh44cihY9nUJQBP27BaEEQaqoWT4O16/AHUHZjs3PPt9m/Ol0GH9
 7rUGXDjEB5DYaxOfQom58R/m7txRHQ2qGPzaiM4MDdQW50Y3vMpaNj1ZCLxEloqmFav5
 1naAkglHaeHNs7bRuQFJwXAoUnHZE68l7sQlwydb5Si/Ad4fqBPLyX+OfCj+LxusN8Wf
 V1gQ==
X-Gm-Message-State: AFq9FYKzI3eSqEm8L9tt6fqSC+53ni7i0qrUU82/EZeyw0xUp4YIo8mW
 i9FJQPzqSKcpLBZnl85liGO9d969m44PznwWto/wrJYPcuO2KgNwEkAG4Oo/SObZpBE=
X-Gm-Gg: AYBFou3tBls1wf7E9JYMNkTPZPVcWpwiSBPKhTLe9JlahQ9faCbLf+Xc6jTv1qJpYQe
 Anb6XCO7Rz+eDXawxg4khGR2if5S1CPu+iFBuuzASTfCLljFRHNwjCwDhcoBs2IXf9x8uB02CM8
 KoHJPGSwAKFCd0r4tvOMsgLmARQgouu0PBigKbHs2XfFBEBhtvR8S1xPanZyAKdBR/2XlPaE2yZ
 3ki0B3TSFxq6IEpnvuR/fF/T9ZWF2BC/HeoT1E64O2cW70Vnoi46fXNUbKaau0gD+TZ3QAfKCvG
 Vi1+dWXg4dfjcZuuofynOJgQzjaCKvGAQDnmLV+TtrbfqlvNlMs6pDRvIGV35yvkax3g5Vl9YpM
 /UV20tHx7IdpDi4ENxvVzZrpCynvy5UpccpBSvsT/67nBq1sgJDWirC2MlqKbzxcy3ljNs+WgDj
 DnbOuUh/l+QNoSpWRlFqQKbk9W1wouyTnoE5jYC8AeTblhBxvwi59vRZK9ymt75gzn6W2ipTiJH
 7U2eOFaTYXIP3cl35Ro0b27Nsk8LEqsWEEh7qKjEv3sxaUchF1omho7+GNLLu74kAc/dSKhEKlC
 WwL6A86and49hVNhcbo=
X-Received: by 2002:a05:6808:14d6:b0:531:3bcd:41a with SMTP id
 5614622812f47-53cd1cb38eemr5980305b6e.59.1792433006797; 
 Mon, 19 Oct 2026 11:03:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5388d8ab165sm7297723b6e.11.2026.10.19.11.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:03:26 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:03:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH] bootm: Relocate RISC-V Linux Images before booting
Message-ID: <20261019180323.GC720525@bill-the-cat>
References: <20261020-bootm-riscv-image-relocation-v1-1-e583a2dd1d14@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Na7gM6dO5zU27RaK"
Content-Disposition: inline
In-Reply-To: <20261020-bootm-riscv-image-relocation-v1-1-e583a2dd1d14@pigmoral.tech>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Na7gM6dO5zU27RaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 12:13:03AM +0800, Junhui Liu wrote:

> RISC-V Linux requires the kernel Image to be loaded at a 2 MiB aligned
> address for RV64, or a 4 MiB aligned address for RV32 [1]. When booting
> a FIT image with a kernel_noload payload, or an Android boot image via
> fastboot boot, the kernel may be placed at an address that does not
> meet these alignment requirements and fail to boot.
>=20
> As already done for ARM64, call booti_setup() for RISC-V Linux Images
> to obtain a suitable load address and relocate the kernel before
> booting. This reuses the existing RISC-V booti placement policy.
>=20
> Link: https://docs.kernel.org/arch/riscv/boot.html#kernel-location [1]
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Na7gM6dO5zU27RaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatZbZAAKCRAr4qD1Cr/k
CmUWAP9yC+saXhQ+EOzW6ed+/oaW9obv8xV5RgoN1lTKHqtEvQD/bE8Hgj5KkuDS
t8lvZbaCRZXRCb75fLugHrwSBA1HrQo=
=wzde
-----END PGP SIGNATURE-----

--Na7gM6dO5zU27RaK--
