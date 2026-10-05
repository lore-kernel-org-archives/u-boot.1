Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C154DCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 606B140711;
	Mon,  5 Oct 2026 17:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qxWYX01UqTqv; Mon,  5 Oct 2026 17:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7475440706
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791219970;
	b=cLINFe8M+5eSlxUkbdhws1DaFP0pk9irQAwzV7k+W49ukG2AaKYBz6Mc/Sk62a+5lyR5
	 IbSb0dIeESYXrYAQ8S5gavxHt/7sOFK1B9r/Dm+pNaNdiAw4uA9rE4zPp4cZRcCujvL4Q
	 s/iXwVLIJ/rE433iFIuk0nTLxMk4owKLQBgZ/0AVs6COKx7OGQXdum7II1DcSTGDwQh4D
	 WOJXIRlPCoLsYGYCWK36D1xnrI5C4h7+twzR1YID98hJ8Ym8VE77R7i4EXIsIpqvl06cV
	 bTwGqU5DpdssDRV6HwfV695lrM/PbjDLE40A6Qo+oYUKN9spqcYIso2OkbWql9gFdMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791219970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tpmL9kkeIbcAqiAb0w8P9i6y/OBhooVUUZdE/g9cNQQ=;
	b=rjR3h37qqTaOPf7dqKlyQcN4BSiRtXddDw8zcJCfvTJIXpTUAr/u4/vBlEsqyUhXdOtc
	 XnpeD70v9z+2zgmust4wgOUGX16L78FDufXzOdgliTlQ/XMWyvCkNtcRe950ZcWV20TjT
	 svyhr2XALzEttL9HQMQBj21ks2kt9BoILNkSc2MBl4iVEJ2JDjt5B4Sa636FnK2E212b3
	 xSKIp/avZjYdAvghddxCrScVNkQxQdbpe39SzBbIkRNdo1yPWeDHrjnT6818S9Z0WoNi+
	 0il4dEHQbjyGfLqbhlp+576Da2UC8P4wVkhFrojNTf2a6VnwaTsuQRgMxa1Ms3Wwx4A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791219970;
	bh=tpmL9kkeIbcAqiAb0w8P9i6y/OBhooVUUZdE/g9cNQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LbVh7ySP3Fp5q4AXOaPWaCwpdeMIPnHBMmul012Kxw7TDwf31C1cUVIVVuM/NG3mZ
	 8AfzKqfmICKf6Mo8nfVS4oYWzuLzxxF/Z1LFIbem0rExk9+xd6wgbYqhq5kqcMxlsF
	 Sofl+Yd4icWul96gCZNDTgxVShgniugSlWmRArd3pH8HcIIOhTttbAChkwkJiemP4G
	 E1IcrzHAU18pg8XvXjz7NaP/lcjn8M/W8rrcwRpukqYEEE5QEXisI6jCI0FEB3J2EZ
	 i8oVenG65VKk9NLr0XhA95dPQ7xHdY677T5FnJ7jFFFJ/kVxnYvcHicAMdDNfLEFTd
	 jGqp7DAeGcsJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7475440706;
	Mon,  5 Oct 2026 17:06:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25C062E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BD8A80C68
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1tWlLGzPPXt for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4ED6280C11
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791219718;
 b=MDCBupPAOMAGqQ0KjFKZwkr9LHCG5Jp47JXO3doDJVn+duqtFhDr15DLqlKG/MqfJ7mM
 yXTMOI1Sg1Fr+292AuCgFCxPR20Zvo1b4Jvj1a3hlk1IDYpOkjuDNquElq0Kk/wg+0vv3
 kyCFTJAa5lKMnD76OXE4F8HoXRffmkLir5CTMdTdKeJ5uvERMCN16S504LX4pGymDo/mW
 DY3Cjxxj2PqbHnUxj5dDL+7dlJcfmLKhJlp8jQitFtX+dczSjF7U0h1C0wlz0r3aG7kRc
 StjaxvGtxmcftwHJrUyccni2QES4OFbONf/qsARpuusjiWePMCV2KIHvhRiYB5A+tiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791219718;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=tpmL9kkeIbcAqiAb0w8P9i6y/OBhooVUUZdE/g9cNQQ=;
 b=JKkJ9YpvWbVYz9O7W0fBoA/uqm2ad4D1HyEH9LMiIfwo/6qS2VOw43pov7Hqlt3JEXvF
 AkFOoHw7o04Ptue7Mf007GyAlhKDb2icC8HkPxjSE89HKkK9kfXBj7jefaDBvhka2/4UC
 8M7dRAx5XZqVaLi2qbIrGglEejTAXtrGjqushxDw9KgYIPwtjQ6aj99SF+18QRigIsR+O
 NRfoDOXwf4Cr+vQCfoFy6woqFvR6v93BlC3fF0UVvWpqXmkZK/95KfRPsvHHg6wH9rpNe
 UeavNz5ucY2dZYRGh/TXn0qUEYXn5gIe4grC92JoZDRcuB6A8MnlrNpGuuRgF7YMipA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AGzQQmF6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=AGzQQmF6
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4ED6280C11
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:57 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-82374c2d7aeso75810a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791219717; x=1791824517;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tpmL9kkeIbcAqiAb0w8P9i6y/OBhooVUUZdE/g9cNQQ=;
 b=AGzQQmF6AtyITm+rtF2jkNpQPeE98zKfwAOaJA0xlHtkGC+G2OymNisHrKormHpEc4
 UDjQhyMWGo6dbCb3THmZ75FMSHONniGCTolsmA1NAVedB9xVeQXVAa+P12g7Nn1epBx1
 iy0cEfgTImHgZVkVWTp5bH0F0kaeRcbeyPkMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219717; x=1791824517;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tpmL9kkeIbcAqiAb0w8P9i6y/OBhooVUUZdE/g9cNQQ=;
 b=QGnKYv2sQeiliA5pn7Zk8YrOm5IGNP8nNjcsqbIMd75Sxehyimv56/og7thv4F3J9s
 f8G7w+FN7FTYdiZGFjpJTcn1Hcfavrxc8GeVkwSMQUOmia4o5WA3vBV7pjAPR7aRklQ9
 Sp2byJ2TZWHZHnAVSL3qUzMjWAl9byBaxwdo7BPTEtysysGul3jS0FvBNIIBMVOr0obo
 cnYRog5Dxf9/ku6ZNlLqJGGVrgOWLDgH67jMt5qQsiNCIJRe+0kEDPpgYLct6Y44b3z9
 cSUkvsI5wDkUTqWjNNgk7naDpL/ZVNYcaeFKQ17we2db4ehEQvP4rygkwhoPQWTVe7mz
 9tJg==
X-Gm-Message-State: AFuF++k/NuIEFn7ddnAw1PgCrc41J6LD6JPCFLcqoF/HUnaL/boCaihs
 fqF6d8Ws/KLko9vbrvlXlE2YZ31Fnmc9ZkshDAYjbP39hLJT+9zpNS1nbQoiHhUrv7Y=
X-Gm-Gg: AYBFou2CNjPTg5We91Shck0ANrR+kAPTO98r+Wd6UXv7ILoUzMeMBlkobo0wJUnbJuz
 gRC1RTvvT6a6/DMEvG8wyWk+JcCeTXEAOdZhqveSPnittmrx+vTplfEvscoOY/+ancyV+xmBRVk
 2iYRZs5VxN89aZdPNRoDl6HFAghur1eK++sQgSL0kDrW6qEw1QWk2jgPgOUMD4F1YIvlVoS9vG6
 2EN+U2PEcTZ8MGN8OWL/RwzgMswmvx4ujVBa4PckQHzWwDJqYd0Wbb4bNGK7+JG6L5Rz/NHO2iO
 z3DuXvHewC3ohidau4uPZLlv4Ab8gaoBm2Y63rrXWFVxR/TltooBdpbiLZMm10NOUhF/XpZQwd5
 nET5PvWr18lxqWDwiUOV6wC4qVQWnorXiPOOylQg2xIQJiOBzHnT7Vnzg/UeI+ZgepaBlCrszuj
 gDv1RwY/TE+dKO2/MVcN6cJGt58+ezoXyMWPEu/s1RarlToI5dvV7Q5vRMqpoCAF3WRufveX21A
 QObMoqk7F6k7EufxrYP7/So42bb4IvqbTGnKmeoecjdOf0qjoE8dHm6uoNHs4mi3OaeuELnWWZt
 auzDQB0dW61o+w+RP74=
X-Received: by 2002:a05:6830:a144:20b0:818:6f1d:4a4f with SMTP id
 46e09a7af769-8280443c0b4mr105602a34.36.1791219716606; 
 Mon, 05 Oct 2026 10:01:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8227a36943bsm12067717a34.19.2026.10.05.10.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:01:56 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:01:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 4/5] lib: mbedtls: sha1: use memzero_explicit() for
 the HMAC key schedule
Message-ID: <20261005170154.GD3724959@bill-the-cat>
References: <20261004152715.1574-1-18102059357@163.com>
 <20261004152715.1574-5-18102059357@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hILqWKKCYuCxwX5Z"
Content-Disposition: inline
In-Reply-To: <20261004152715.1574-5-18102059357@163.com>
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


--hILqWKKCYuCxwX5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 11:27:13PM +0800, Xiaoyi Suo wrote:

> lib/mbedtls/sha1.c is U-Boot's own shim, not upstream mbedTLS code, and
> its sha1_hmac() has the same four clears as lib/sha1.c. It is the
> implementation used with CONFIG_SHA1_MBEDTLS, so it needs the same fix.
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Xiaoyi Suo <18102059357@163.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hILqWKKCYuCxwX5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasPYAQAKCRAr4qD1Cr/k
Cj+hAQChLh19f+4roSMC+7Z26pqVnPNP1Vb6D0HlAsS0xFQ0VAD/UCr1ZOwz0QGz
VFaWn4cbR18dvM35ChGRjSmTG52QKQQ=
=8UYR
-----END PGP SIGNATURE-----

--hILqWKKCYuCxwX5Z--
