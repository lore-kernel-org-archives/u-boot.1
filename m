Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F77606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kgYgBIcj;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=AJZfa5gM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0D40606B0;
	Mon,  9 Nov 2026 17:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BC_5nupGZqsK; Mon,  9 Nov 2026 17:29:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB9E360838
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245364;
	b=EhwFlyclOo4jFa8f6KDrEbOKHHeufpbACe+bwg4Ipq0LeaIBk50awi17FV/rEpDy6SMy
	 dJen9IU5KQPZimCnubyviKy7DUKr6wG2TFcVQCn5QygUEa3t1nkRrP0nc1UgTHik7JcQZ
	 kTxTGRFFJoTxip2jOQ5wLoCZjiTqjB49ZQSBFVB/lC+XN9HpUTxdQPrpxrSqHyKS9yZ5V
	 0IQB+thpc1CrZ2EYc4EUGd+QIGmehesWkmxiEe18Xw8mu1PtFzDgiJFPQG9AHy0Ic5/M+
	 umuGhF+z9egEp8FICWlx904pgNPSOKDRm6B+ygStvN7wf1dxAMzcw4rTSjYwYcXhghg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hA5O+IiyrNw8MsM15s/wdjOoDgASxDpjAgPx8gluAjE=;
	b=kIBGT4bDT/G9pFlX2D2xhsACiEdh5HGT7Fz3CojzXugdKvm9A+1qz72SuWa5u/cGSEsG
	 wJ1tZN+p5jQwzpPkbf8Int/YooYYJrgsfqFJzlkixP8vRvHiXHxHuKwxeMP+iqrFSjORf
	 gn6TPPe0wET5yvnfszh/QtHtpkOUjmGdEKsqDi1BgO2i8FcQuUDjPsgcRzaW0g0cwspn3
	 a+nyuSVqx57HWH2Z96QDZkgjtTPllq2ad/RvsYQCmiLgPw5rCQL+B896IAvK3n0/box9x
	 Cv6b8FlNhfZcfPTX8e6ACewIcQFPUwhtRgBH+NJO6gN+1P55jxoS8MLRSznCu0t3r7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245364;
	bh=hA5O+IiyrNw8MsM15s/wdjOoDgASxDpjAgPx8gluAjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kgYgBIcjwElJtyj99tg7rleNVU5aqYuM8wXHmbcwhZNoEXxb4OeLsPIRbvrE/500Q
	 Xon9CzZRAkRN4i7j1jkHLMuJ0JYYguJC1ifUtQdqmpUtVTmEItvIIdQ2AS/GSQYU4D
	 zTI2BHXpCp1dD1Bt2yYjem1Kg9PLbi6o1y9ZNcBu5dnFL9KZQgCDzSoBQPy3iiHnfn
	 eV1cJiohWJANIQmLtZfrHqV0C1RSG/+TeJJ9FODCtRQK5UREN5vKMf9GVv3tG1SqCo
	 TyDU2K9odFUyFa4qH/c6kkPiRv57icgtMltgA7cdNgGDKbpgNIDce51Bx18idaHbrK
	 4HPNQOG6tcxGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB9E360838;
	Mon,  9 Nov 2026 17:29:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9D56251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBE1C40176
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3osifsWO8N94 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 05F7240068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AJZfa5gM
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05F7240068
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:21 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-854e904005cso753568a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794245360; x=1794850160;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hA5O+IiyrNw8MsM15s/wdjOoDgASxDpjAgPx8gluAjE=;
 b=AJZfa5gM9/qHv1ebhpguI+xyZHIE2pKTRN4bTEvefx29d/zcBz+NsBUP5SX1RYdaHE
 8KEzPyFTxV8MzPs8nLXV7AgV//lWKcloLuGTPOuDdvQ+F1Ep1QitykJmx1DSt6QM57jr
 C+z6my4phgmLX+O3mNNbup2QS1wfvtXOlHVqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245360; x=1794850160;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hA5O+IiyrNw8MsM15s/wdjOoDgASxDpjAgPx8gluAjE=;
 b=0mk506BYr+kIYAl14q+9ui11pNaxSuwsOPFXMyMF+4ZQVkcH513A8TVboyrm2l4rOP
 DzHtIZHJf+tSh7MhWlDzV1O+tsS118mgBpeeB9wJ3bmSo53dgsfGoxRP2EISF4Bw55vp
 2ElKcB3tSLNvibwJY0jogn+SpgmS6lNr50U397jU/XN96CBdYsJR/fKyKRa/pAuJjxiU
 EWYnz7S0xta6IKClbwEZms0GocQeedptAZmePPmV2pyUsj9GmZqk3l/MGBUOhBZPWRc1
 3rYSyb3SVj/+qCMilcX/CyC0v7qQBmh0Clvp1tPO9WeZnPUK9vjAudpHq7LBRLKNW5z/
 jPxA==
X-Forwarded-Encrypted: i=1;
 AL+hErFvkeiAIIBVbWE5Lzj2eZavKDF2CXwSkfqk5oscsGvyJVlfCH3IppXqJWGX3/8tBkwa+WnS5tI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/1/MuSSa2UvknIZFT8PVy1OF1VNrdwWazdShlp4suU8FvhldBY
 95wWUTlT7KeZWkmh/ZPGBLMDHuR7F/iYD1a9utGhHCtZ1ROTiK11MQSEZ35xQ64z5+Q=
X-Gm-Gg: AYBFou3KNSbNb/5UQwILyNan0ohttahnv1U60neH895TUPGX2ul4gOCwrLW6ytpg1bd
 J0s5NpeCDk+1jMbBWonTx/82NzlYohugUSA2f5oDBKFBllTwcHCWdpicgaglQcqrMOWQsSCWMNz
 2lG2D3AnT22HXbgmr50nx2q0B9kywwOUKBRzpCo7C5TSTQyJhaVJpIF2tNrJu8uSCfsekI7wWGe
 IJYF9qXAanvVzgUImUPl44cLfkI7fsCBZtYzRHtp/hH7+w01rTMqrpfstMx7wY4wxasfL/YFfuh
 ynastEQkOm9yVVZBEAlYuOtqp01WQYsMLE9fUOJt0Sf6zThuFq0ivC7DEEVVMlJmusNsF4385lC
 AFCIAtH7zi/h90BU+MYR9iHjryDmYw/ReSUQzLyJlrV7+hmFc5rGjGKr+mJrdmCHVvWuRj7qOc8
 BUQeianX5gXe7U6CWHPLQlcH0JV9uG2z9NIHESCy4H4ru4yct/bd6J4hx9NBH+n0+PVyCraW5Hm
 HvPW9AR/5cixp0D3CoxusAudKcws1y+HhHLfAJSu2maoL9nJRN8xgpOIbYHexda9ebRh7R8WLYR
 KqbQHzF2s08HquhIqHqvjV1QOIDDAvSUSurfCDyYa6fLMS6s4SrtwKlRk1z2xCIArCQTQ8PTpvV
 Powci/rrwAvcrlRWp0HVxHITfvbdML86pdh3c5zYEmO2V2wNNpJMsdWerIR+vd1UB2A85f1FKJ5
 wKxMyZQ2exlCptEbVzmpXjmjhJobnYqA==
X-Received: by 2002:a05:6820:a510:10b0:6ca:36f9:178e with SMTP id
 006d021491bc7-71899400429mr55706eaf.28.1794245360429; 
 Mon, 09 Nov 2026 09:29:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8cbfbdsm3697812eaf.7.2026.11.09.09.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:29:20 -0800 (PST)
Date: Mon, 9 Nov 2026 11:29:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/6] usb: musb-new: Free the controller if the host probe
 fails
Message-ID: <20261109172917.GQ3741582@bill-the-cat>
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106205608.GF3741582@bill-the-cat>
 <CAGG=RgD_G2Ottv+0=JOBYyP8MsdDGGUhCB0R2BAHWa8mS2ECcg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DBgA+idudkeeW1nX"
Content-Disposition: inline
In-Reply-To: <CAGG=RgD_G2Ottv+0=JOBYyP8MsdDGGUhCB0R2BAHWa8mS2ECcg@mail.gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--DBgA+idudkeeW1nX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 06:19:43PM -0500, Yuho Choi wrote:
> On Fri, 6 Nov 2026 at 15:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > How are you finding and investigating these issues, exactly? To cut to
> > the chase, this series (and the other two patches) sure seem like what
> > happens when someone sends an LLM to look for resource leaks. Which are
> > not great. But the bigger concern is if we handle the error case
> > correctly. Thanks.
>=20
> Thanks for the review.
> The bugs were found as part of ongoing static analysis research on
> configuration-dependent resource management bug patterns.
> I used an LLM to help verify the bugs.
>=20
> The patches only fix the memory leak. They do not restore the
> hardware state on the error path. Would you want patches that
> restore all of the hardware state on these error paths instead?

So, the general project policy for LLMs is please don't. Using this as
an example, it's less interesting that we might have a small leak (we
aren't a persistent OS), but as the part of this thread with Greg and
the sc5xx driver show, there are potentially interesting problems in the
failure case (and we don't need to restore the HW state, just ensure our
internal state is consistent). Digging past the initial leak to fully
understand the error path and that on the software side we handle errors
gracefully would be an interesting task.

--=20
Tom

--DBgA+idudkeeW1nX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIC4wAKCRAr4qD1Cr/k
CuSaAP9eAMJ5pi3u1mt9FoxaAEpnOyLlNQpmyD46RpL/efl0jQEAlxq2kZWZYdJX
DdQx4IWUGIiP2qO34aXfLgMS9DmNiAw=
=RUwy
-----END PGP SIGNATURE-----

--DBgA+idudkeeW1nX--
