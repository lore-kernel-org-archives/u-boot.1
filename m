Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC9606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pnhFv7KO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=OxqtrbNe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 001018193E;
	Fri, 30 Oct 2026 14:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYnNku-iwCXZ; Fri, 30 Oct 2026 14:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A40F818D0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370799;
	b=Y+PAsM/OAr8tlLHo8veUrTkTUc5yJy5wUsqXjv1e4NrKhZjS0nwkU9y3Uqj3P/eFJ2eE
	 W1vUGaxWKocDQ4QNWCTA5Bb9hTiUqHeE1RAakpQNWxxcrnfjER++DhipLP/JN8HfY97VY
	 DWmuwbDUcg4FSFVe7Rs9l1r7g8QW0W3iO3htRWaxG8iSsd4JOCP8GpZSJfYYmyXrM2n29
	 H9p8TFta9N32Z0DFQ5YWfBM6lY0mHAJ58KCOWT6dEDq93wIz9XMbNwoqGeXR5vuD9GRzR
	 KRDqXsJjc5UBXq++tkRHavqoxMiTAHl5Y161O51VBcyGGGrIPFauXibqgamRApRvnYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Vv0F9+0s4W+y++bQHIa0hrDjLQAG5O7bRX1yfgo5zjI=;
	b=p7f2TukzJ1n41aY5+BvWqeobQpA5OylBNP4c8Xc8yKXovUKM2mlqnAT0uDbnmqdyQ/pr
	 LXxLi5/L4IfUlPczgjaTaFrSFjIuYSG4gsMj/8Pax67M64/a3BlWifN4EltqsZwb5tcw/
	 KjJ+y0ANtPI75NLux62pA4wu+CcjsHAfEuqHCIvI/8yEGD9BhWChASjrBevHL+E/DIr+5
	 9vPx57E6c7BciDfgadsY0jcMw2dkJIqHDZlj0CE0gLd1i7/aJyzVLv/Urf4SyQQaFF6tW
	 C00YlVjj0JBY0E2DpAiOnmCVpUgy+qM96HvTqfGPlHUUF/Wc2b746oRyerTmCKP/OfA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=OxqtrbNe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370799;
	bh=Vv0F9+0s4W+y++bQHIa0hrDjLQAG5O7bRX1yfgo5zjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pnhFv7KOC3hk3DMOPFX6/g+tArSANr3JRNy6YeDKTRpdifV8DI82SbbhJWt/VlVrO
	 VrKMxCoF+/sBiO4iOJC++Xo2xpvs9eFEqnB5L0+twuTp4EB3zBJHAJ6kQ82vO1PGwn
	 e1xuPaXZemita0mipf/tOw5BZ+xDOQbacA4Y79NyenUEWWX8McKTrp2tVyddlh5tlF
	 seYZE3WoB9Lm5+QmvlZajPR02Nnu9MyqMCSY1+fSO0i7l3P5iPzVlwXJ89S1+uk8E1
	 I+247AJaIi28Em9STunhVkRJMFA0oAwXokucFESBW0XlCcPUnkH6qATby9B1bAoyPP
	 CeH0ma62Rrt0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A40F818D0;
	Fri, 30 Oct 2026 14:33:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 79A10D38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F1C9818D0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uvworxgHABau for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9221B818B5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793370797;
 b=Ux39D9EdACiQAV3NHaNsX+EsHi5KaLqbp1nqDciWBAa6U7lB+Jm7AAnXVgoNHalYOkk3
 ny7HK2cCfFdhvmnka4lA2AAEIfJu0rxNNQx/ejHYa0O3jwzGbS+KLRSLaiRxqUhJg/h+N
 HdlNIaE1SJMsx37dZI+zljWVXFJlFxC09X9XdBO6TzWggbAjZmHBX3kU9aDE2Zn4vBw4p
 sI/aJMHG9tHd7YYTSiZqb0gVlwchbjRmGhQxMF1dWgvwJ8CQqEEs+dWWst+ECuhxMByYi
 9z1O3GhzJvyErHYJ7YIIu3z7KbylvBwz/T6Dit1afPJswcIZM8PkI5OALfsx7rdA9+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370797;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Vv0F9+0s4W+y++bQHIa0hrDjLQAG5O7bRX1yfgo5zjI=;
 b=kKgVSDvaGbaW+Nvw5N9VAExlKi87PCFlXTSfJZiYl/Ke+6VCtpiQE/5ZxaX1a+lM6Afc
 WEDvGMLT2IxsrCQwi+SfgGuva1ZWZMNgTkzNOWIINhxX4WpPaulPsM62BDBjhIgnqiTgg
 toVnEXu+RdvOBOg35hLYfrpFO5xHaE5rlm5mW0G8kNn6QH1oAeAeBBcQ0AyjE+8uIkXCG
 vRpG7bsO3ONR+00FEO7AjMOZcu0QPFjHJoKdI8UVQeGx1zA2Jix2YnGJfM93m9X/hrBbQ
 MAhehiXzxMBMpemnV8PGsQdd9n/I5GUVZcRUNwZN4IkH/WGskMJIlYZG1D3Dj/+rjWw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OxqtrbNe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OxqtrbNe
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9221B818B5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:33:16 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6dd7070699eso572351eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793370795; x=1793975595;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vv0F9+0s4W+y++bQHIa0hrDjLQAG5O7bRX1yfgo5zjI=;
 b=OxqtrbNeZdZr9D4r2b+G6/eRj6+hKBA6w6tMbsHbdewSYZmbBNnkQSM1BsEOFFep9X
 rUfdAIthT0sNT0nHZuijcy1Eke0wyaCZmRxIbfMqHceGApzoLuSXJaW/jDkBMebEhwFr
 fdns5imS0wr1JGqKDwTzSpYyTMY8eFxHfHSEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370795; x=1793975595;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vv0F9+0s4W+y++bQHIa0hrDjLQAG5O7bRX1yfgo5zjI=;
 b=h5Zxt+xvo7hsaMbnJNqvgKBMOyX2rI6H5PllGt7Gsxw7a6Fhg2iko+edVQE94NvMo4
 y58eKhvGscrKJkmrxpQNQuepBCzaz4RYyHiZggzoNGSGc7Mys9l270LfbDoNaSNYrCu/
 fqIYqh/MaCjzrKMJ2ukMj5ykPHY94m2OnuDoGSlRTUFxRKwQmtOF2G9n2a1eRHHhg76Q
 UUgMb4E5zyIoHvyZgSd11h2ZXwtV85ke49gvaJy6uoKdooJ6rQlFe7pcvzDWbauH6rdP
 fFHibldC9+mX9+ARoLhomRLaN6IECnMdE/74bZXv8fIE+ZSdLGnyr9cDIkli2Yx2FemR
 7hUg==
X-Gm-Message-State: AFq9FYIV+V0yc2id1kDRBVD67qbWtvLXHJ9QPgauIv4+G/3nPI4Q2sl6
 Y9PH1nsG7Apd1MP2BRBUQJh//f1EE/tGPUxpTmPNI1jMQAw6VjM+zM8DUx1jqSb6M/R06pT6gT0
 94P/m6Gk28GR4
X-Gm-Gg: AYBFou3glgIqLWKFdZvd8Obfj20tK9BfJ9EfmidKc5gTO6DcJHNp2JSTzFuuAlgYLP0
 9yYomb7CY6eqbwWqgLSY3M0lyaqCl/M6pie1ssCJ1N5XSSnEgdHvfLo44nLwWLv3WU1wSM4YvQn
 nKino21CgdrV9L6qGY+V3EdFvNLdQpsgrZSJxtRa35Y4EXh/pBaA5FjwGnBu1rKMseyOQrD4PBJ
 npyldYtVz3lF7iZNCvAbuJhH8ycGHvi5U1Xsd2ihuS/JBNYCHACQHo6HEn1wDzNCOt1kO/Kg+mW
 6EPt061llRZXmkACHyGK0oUMe+oNlJwRKDqjz8Bz13AcHW0mHQ1F/howxsZwlosIGPT54dr/Ma+
 Dt/LO1AjKdv+t1hMbH5GmAlC2ZkthSC4wf357jV7mhmzLHKnoWSwduQIOtocnSReoQhKs/nMPW8
 /pa5TAWm7r3WMYmjqGXHjKZhtX/z9W32AqmQcMj6x2thjjfGhrz93+/j9sAvk4XFRxn/jbjo0mn
 loKS1WLRhzO0L1OtjoEMpk7E+mfuayYkiUeJqplx5OlOiE/la4uDXeLYitGLHm/l5hB2omunCua
 uYYYJMqRJrcrUKSidKE5wSl3V3MmybkX2v9cx9RDX0FMbupgnPdMw6MphLrp/Oa3XH7RpfCsvMr
 h5lNdzct0sHLEQuGocZK8h8tBxDiKi3expUx0vJxo3ASRQfK/NjJOlFpzHPl9dPB4LLAATOsPdi
 j2H03TqcAuNXahBZPJNOUz90KcJYafkz+yehBoE9hf/wNydOCnlCct
X-Received: by 2002:a05:6820:1354:b0:6f4:9618:baf1 with SMTP id
 006d021491bc7-714f253a467mr1342913eaf.70.1793370795212; 
 Fri, 30 Oct 2026 07:33:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2a818b9sm2081513eaf.1.2026.10.30.07.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:33:14 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:33:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] Azure CI: Build all host tools on macOS
Message-ID: <20261030143312.GM3011578@bill-the-cat>
References: <20261030081436.86780-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Px9kJyb0kUi4UV6q"
Content-Disposition: inline
In-Reply-To: <20261030081436.86780-1-pepe.schlehofer@gmail.com>
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


--Px9kJyb0kUi4UV6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 09:14:36AM +0100, Josef Schlehofer wrote:

> The macOS tools-only build does not include kwboot or
> gen_ethaddr_crc. Set HOST_TOOLS_ALL=3Dy to include them in the build.
>=20
> Tested on macOS 27.0.1 with HOST_TOOLS_ALL=3Dy: fails on main at
> crc8.o and while linking kwboot, but passes with the macOS
> improvements series applied.
>=20
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Thanks for checking this part out.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Px9kJyb0kUi4UV6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauSqqAAKCRAr4qD1Cr/k
CsX/AQDpk8xX93bW4CCgCpv9zrDvT78OxJtcFR/2z1cyFSdTTgEArW3wGvegn3AX
s/ltejJwFnbjPDNHm4zkxnShOUsv0As=
=13ol
-----END PGP SIGNATURE-----

--Px9kJyb0kUi4UV6q--
