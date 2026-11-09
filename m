Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C1606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iuqdSCeg;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lwf1D7wo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05426607C9;
	Mon,  9 Nov 2026 15:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SE-LoaNq76L; Mon,  9 Nov 2026 15:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 220AA607BC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794237009;
	b=pmzHLiZI+an6dEkgwep41j9Z1QuXsRqfsCidjBoa/nPC28sRrHwALoTiORYFAwQ+UqJP
	 TcQWbKUTz8LtQNizjRQ1KNyIG02LLomytV8Z86AjGvnqyJDWksgfU1AA8aJu9dPLljSXQ
	 4vNe3SOKj6RRe0zmkXs2XqqKJFgReetECp8/NVy9mKVL0Z/9/Ik/MvXbqY/qqWwHdxnsf
	 dBy6D/jvDM3E61b0oSq7IpmZVqjH3Wz5Q1HI6gz3k4alg6Ey/5jUt90aASxdLSfgyxg9n
	 r1St7B8OM5D0JFnf8zCZnAwQqOXvMPQ0vBwZwgdQo+a5/Vr9OUSq0GDTkdkFYZE6nSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794237009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=I3L53hN4wNOuqlOmsiD9usdoMKhc3CTiisxJc3fS8i4=;
	b=mntVRNj1uUEdEtkV+HTpIq6T8yfx/VqU9yfdvVkPA9/YPFuQ0/g4JJ7zj+r8ox7Sd7Nh
	 mPRVDCWijjSrUk0npXJEeS8oQCzny26xCMD8GjyLA5PQPEaw3qve+4Ilufk4xnP+M/TU+
	 TzORJgwknrCwk6E3iv3XIJBt6dxDlIqPXSS33Xmf3gvgXI0BmHe0oBB/8gvnNnSiIDe/b
	 ag+YBihldS87xoEAJfOHrR81qJd+Hmrh5W5Jlm/fsxveYcce8ChSNqVwFUJ8RsNXROjJa
	 6n45nZ1v0rsZH8KGzxiiHb6uBjZ5BNFPlxT5AYxgWly/+rlTtbomyVznEvhUbzg9G5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794237009;
	bh=I3L53hN4wNOuqlOmsiD9usdoMKhc3CTiisxJc3fS8i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iuqdSCeg8fBdWjKcv9NIa3BWirWWabVun2ahJNj6pS1QKuaRTbQ5Wxx1VoOGbhp0Z
	 gqm8Q2hgGlWxcXvwK73a+dYNyVm7p98kYumlM9BFpqp1nNcEb079sISfzpNSFa0qyu
	 nJFkPy8t27jpRtLtCpA0l/Huz5rtpaTETrb134zLc81XYg6pTQHKf2RcPCbIIwmLDt
	 nEUOsY5YTAmSYsi11hL7v5EIWidMt3eO4nGfIe0jrh/pA/+wwxDGIgW3lF+PPssfQv
	 +GWWh7PceBJ2Y4vDlY+/MSXU2X28lZYIpuS4HOO1gprDv5DclS9nK0tQZHTPRE2tgz
	 pYV2CphGgT+TA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 220AA607BC;
	Mon,  9 Nov 2026 15:10:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BCD6932
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D9254008C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gTo65q29prci for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 70D2740087
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lwf1D7wo
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70D2740087
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:10:05 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4911df1e196so483948fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794237004; x=1794841804;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I3L53hN4wNOuqlOmsiD9usdoMKhc3CTiisxJc3fS8i4=;
 b=lwf1D7woxhFkgvzWzvCbqOrwMRMQ11zZ4Icl9eZUykiQ/fsDlv/iY7urhVsMP4BSI0
 7b5j1YxC0DvEdrqex+ka9yRUXg6IIRUdiB7V/GHoA/7wJ6VJhMqTHrlxr/aEttV9edDm
 13iQMwq+R9+oudQjWgcYwp/kFrS3SjAWjRXlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794237004; x=1794841804;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I3L53hN4wNOuqlOmsiD9usdoMKhc3CTiisxJc3fS8i4=;
 b=v8Nf2eUenOr/V6TrpoRMJZo0iINB/+XKgbbEGz1DM2+rRIfDG0RYhCy5k3KuAf7Cuv
 cXpbTk/k2ZBQxW4qpJS0DWFAs8szJPS5JSnS+ML5ppL8MdPNXlyGG3jGYfYjeNVDBH7X
 svxoGSwiw3lBrRtEJ6TTAql3a2k8ZJpqosxMax1JQu2NFZU+oDnK/6BJ40/kyW+oH8fR
 Mv6UKpxFD3yvMvCVSi/5jhwDdO6kJZCRC7ncTyq0SvINWYXZ6LUFIAvc4E9LbvqGcGhU
 YTAWgJhiB/yrk+dvUVCTnJ/AvPbZ0JEN+RMFsd9sNtmipE44cmz+Lnna+Nzohywqtbiz
 8L6g==
X-Gm-Message-State: APuU4Z9+04l1Q6DUzuvcMlQ1V2E6L4jsLGXAyiKKJvt7wXB+BZXeq/Oj
 8aXeYcZrX19UN1X+yAziJqBTapBVDDCQyRhTGZFefxJhitrFY9w4u7SVFjUeZVvfe2E=
X-Gm-Gg: AYBFou0CEyoznWF83jDVjr0Q0yk7VvYQV1o70HDUMihinml9Fzv2YdAiTB5tenlD6Jv
 /bBHEDdOD9J4p7EqDc+U3DrRZBzph1lKRL15czEzAKOqLZCpO6MIzRE8r+X0YCaSiRajrNmGjpu
 38MQEeLf6A6GhFsD4pp9MxHBndt0qae8dogmqWtJQx0jAuRkR9tCR9ia56SuNLQwLUb5xF0MKGW
 1MbhssbK98/SJnYZQtO7UZaD/fDKrIRsW45wV/qyYVwOM1RfXbyxJny26YQsG5QBXm05ygG78S6
 moPV1dfXu+RIZHO8xQWvcoha46il2+Us+AOD+sFji0QWtl2KgzLD9Y9UUl9x/F9m2JdIIeky3qO
 lL9dMdErwG8EDW7oGrpMzqQKuI10RjtSbGHVNrOARYqnW1h8x3XT7HXDE8xW371SAxtHkJ8DBqH
 zUGEGApKqBkWjw5OMSSYNqi7yo2CzZoJBxSMz0fQfaubYpSZvDbGXZ8Bt/ZMDOFiM4b2FWEcXgo
 XDKtklbzJaDckBPVqmojEfsB+1PcBwYyFAtNt5WyuPpXpVUhZrGLshdxyV+dfbRnpDmBXyYaEta
 53zOaoRqURcxWJLmmXwn2jO9KSlJZtQamn0uxAtOGsEt7Fanz6VqFyjCI/e4P9yb0PpEMbt5cYy
 3x/Wy8rF7QDGCpPIYWamO0yA/x5soR+77Ox8xRnKLjplBXFTcdy2u5xqEGQfKD9BZlZjwjt2MRP
 aB74pfcESTENXj7xVbxPUe4C2iZlzkwAtP4PFe+BzZLNy4sojDZwI=
X-Received: by 2002:a05:6870:9e08:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-4adec026233mr2315355fac.14.1794237004037; 
 Mon, 09 Nov 2026 07:10:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ade6a26d74sm5171561fac.15.2026.11.09.07.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:10:03 -0800 (PST)
Date: Mon, 9 Nov 2026 09:10:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>,
 Johan Jonker <jbx6244@gmail.com>, Denis Mukhin <dmukhin@ford.com>
Subject: Re: [PATCH] block: add legacy block support for TPL
Message-ID: <20261109151000.GM3741582@bill-the-cat>
References: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eGhiFTKsHh2vDNhp"
Content-Disposition: inline
In-Reply-To: <20261109-legacy-block-tpl-v1-1-aeee138e9288@postmarketos.org>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--eGhiFTKsHh2vDNhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 08:01:02AM +0000, Ferass El Hafidi wrote:

> Legacy block support is only selectable for SPL. However it is
> useful in TPL too, where the full block driver (with DM and whatnot)
> will not fit.
> Add a TPL_LEGACY_BLOCK kconfig option to enable legacy block support in
> TPL. Note that it is hidden in menuconfig (just like the SPL variant).
>=20
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eGhiFTKsHh2vDNhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavHiSAAKCRAr4qD1Cr/k
CgPkAP4uuVgjJbWyNPzztpv7YnP3PzIDhtBCSgrUOfDxo3VoIQD/c6n+7rQnRpFO
sD1LJF7LGQDtofSKkrGs1YeTrOOB5Ag=
=kSEJ
-----END PGP SIGNATURE-----

--eGhiFTKsHh2vDNhp--
