Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA0EC79FBF
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 19:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38C5540836;
	Thu, 10 Sep 2026 19:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FxO_hwi3m-Yy; Thu, 10 Sep 2026 19:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8EA9540839
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789067391;
	b=au5zxHrLIBgo65AXc9b2iO+odRR6QD/FU22MKvpi+qqHACx9ffsOW2lfsMepKlEFvyJZ
	 HQ7qpWg8dMuWYgC6pohADk/muQeOKLOj1yiX8BcBgBwcQjSI1UgyLkqudlh08fuGpV4ba
	 UYwh3AbdKbrF+1ayEHa81+NomHC850lGEYjEEKWkgX9dLnjh8HHiOb3GY0YPV6wgTG1sj
	 hYwSr08/pRLYzSbdASOFgNOBXcEsodkHQauEn2SNu0ORKDcy3Fqf2W0tCPID4jon5rgVZ
	 AuFyOFDcNz91AVSctc3Hmjr8+IalREEd3XNg3IhAEiaUU/J5fMgDGmbPs5mQvyteWyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789067391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YsC+hFVPhJzQYvTPaZ7+5Ab3vDXPmsvViySwk+1VqfA=;
	b=strEP3LRU1KQOcOaMy0cR88NDE6lzSaNZo8Khi+qrmxfgMaSn7JggyUBwUl3/tR2Eg+X
	 rBrWennBfHzyu+56ejMUabASVaH9dSdrTXkoalPWF/Xmj8eOO2cts2+uybnnIrFkDpF5r
	 /EeiI4GUsbWfh1FWKsDl7oXazmfuV8WquMeKUreYu+be/OvLYfEiHLbewzNZl4QWwYTx+
	 MHEh5fgZdtKrcqtV5p5C2cWresVI6gOTJeDbUD9Pk4yz3aM5H8qGFrQcOIBfVwrXrTrTP
	 8rIVgl2inNFdcMilJI+TarfWj34V2SWr64HNWex8aNPzn+i0rByQik38PQlP/O8bolQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789067391;
	bh=YsC+hFVPhJzQYvTPaZ7+5Ab3vDXPmsvViySwk+1VqfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VcWFAhUnHCvAujzF+zjrG07Npd8if1bi9v1kFr9vzD8qo3qLsth8mW7kfj4CCdHD7
	 7uRVDlYlkoo6QufyhBRJW6D/NF1NkkyFvaQXQxWovRaO2vswF6uEDDB5hcAmP9uXc1
	 ZJ198dB5RIUDWy6kO504YYvXJShgDj53lNcF6GL5eOtjNhnzhjs86Oxw2VseYZX00y
	 qdho6A/FHlAnNRY46IpixsHAmqoBFIaVXDuoV/XK5TWq7zClvYo88xkUDNCwElOH1B
	 NXX/WP9DzDz660PJce76sXeoF5KZQmfsPRv86g03tHXxCOV9WxQqmt0HSanS9LARzb
	 8CYIFV8JyzCHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EA9540839;
	Thu, 10 Sep 2026 19:09:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E53443F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54045811CA
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:09:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9YwlzTFtQcs for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 19:09:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 964C0811C9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789067388;
 b=V6kuHN/nd4zb7UNI2Gy68xkW11F+lAHRItA0gZd0mNKtT5iYFc5KfbsBXNCVRsOrxJm4
 sS6U6k39ETdwaX1yGaDeOI+WtO56fB0NCJ9JSH6zM0NITG2IpM5Xfhul1LQMdcizclWzX
 zOonxRBhrXhsPrPxunQmK95iv48/t2TrmA8aP7DZ9AtHm2xn3lh93gzsFaHWmHIiAnLI6
 VVVAfzMlzgL1IVhW4Vuz4ef3uZyv3pPPLXKDTIFbZXA/6fWWqgZ9wqs4svLBe1gpOSw3w
 LGTTC3yIzO0xE/J3JoX5DolYhIhtH1jAB2yl2RzEwKaCzQNc2Ta09+uj51tMLGTI43Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789067388;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=YsC+hFVPhJzQYvTPaZ7+5Ab3vDXPmsvViySwk+1VqfA=;
 b=bz/v8XvXV/K83P6sZzHERWyyjHeIygemhMRTdyj4MsWfZmJ+orWdRsy5+Ex1Kzw4Z408
 uFUFtQa2982TwXWl0or7OUspB9atv7h5ltP4UDjs4oaafSmdqC8DqalZGNbiCLhiI5tf3
 6IwIE0K4Nl2qVPLokvLPAx8LbD0j3Hr3cMyLSjQx7YXO7CM8Rvjlp9IQpV7DbKen2KnwO
 ML805Iu5T+8RyyGDfRexOzoweMu1EnM/utIwOb8pNKsBkJIs8zRArcj6LUo+GzqeTQ1RM
 hEuTFHCjCQAhoScfHwQaWhmth9dLccv/Rw3Biqb/4g4jAGkF/CikiFR0IFCB4VPK49Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fs5sKb7c; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fs5sKb7c
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 964C0811C9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:09:48 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6b1334a3b16so160983eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789067387; x=1789672187;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YsC+hFVPhJzQYvTPaZ7+5Ab3vDXPmsvViySwk+1VqfA=;
 b=fs5sKb7cYnYGItzNllVkeBCag0bx+JjVYI8EuOkB9HWt56Gu0CirLRAQn1dSKHhUfT
 A9opy2QtAsVWfXAhdjvVyTUEvTBOtQh7EXKMHKKQ0SQbpuz/xTY59SOA8PbvE2Ei2Dh+
 l/wiEDYbKtklQD4lwMrkA0mvcBEDOIGuPgwMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789067387; x=1789672187;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YsC+hFVPhJzQYvTPaZ7+5Ab3vDXPmsvViySwk+1VqfA=;
 b=AvCrX8EyaPq+orQs7gTnmAxFXo/eG5IAMYAGi1a2C316QvoCIYTL+xgOwWrCHWaA+J
 9GmG+3JuzIJmmaKcVNErpLfthcQCUw2d8OjY1P/Ggmb+0eeHORRQM2hLUVVtr5vjsZty
 DGxm/9Q3qSTaVLjNzflZTIu30b2I9zSgFLyqsd2suYONsrkx525kfG4dcpCs9BbD0lS7
 9i3M8ZHmX/D8vo0VWLlt2yqbFa3IWEK/vqBwJfMdQ1Mohee7s4/0Yv3tO35n6noEqhZk
 fSsSPVPUaqjfAzHo4EAgzZckmhwZ0w3vEqdwB2DQeCR9FXru52zaGTbxb43hTlBuVSx2
 Vvsw==
X-Gm-Message-State: AFuF++kIu/g3D74k/BKUDmaZWnDaJKUl4Jpr6liFHpVFQ9YZ0xwNxXsV
 5IzeugTsDcSilUwBmQFlnZW4vhys1UtZPZAKh6hhunA20DsKXh4cUqyrGrR5MGMMtmc=
X-Gm-Gg: AYBFou1qhs/7OUrOPnito00N5QuKXZRMVki01oUnNUug5+EBneJDskfVlqJe2zNvzNb
 7x4brx9/J/UjKQWimhuoG3misT1KzXBnzAAtGJrKNKABPwHRgKlk9KQPXBML2RwTXCiPwwz5FES
 q0ZCJAB/r6YeabfCYTA2lIueDJG+Nc5d5Kd2a6uoy9dRRZ61gnldeENwrqjoyxLs0J3KGEwUeHL
 8cfpa47eEq6iX5M7E9p34Q5ecPyq0/22aONs5hAxM5gFbGC+H/gsjW+InFRLAQ3wEpbwIP68o9s
 mdI13CTzDTOpRw6h+7W1P6xHNKZXCdUSHbyh3sgKpjfqF0OdFjUuroSIR4z28m7hWfuP97VDb+Y
 gXdd59LPscKm+Tr4LZ92MeScw29Fuy9Sm3KLptZg3gqYuN9mHmOROZdIShp/+aMRYOB7OK7HfTh
 Wg/wS1s2P/WfTNQR8NW+3bLreLODdmDOeKm9NS6I7o4kWxdRMTOp0tIFN5wuocfUkn5LDt7SB3F
 r+HSw5QdEgqJYFG8OOmn04Ytqk3lxsw44LUAb4K+4hYBpwurU8OpTbFVpzSwbiryUf1GcWmprb4
 0zqggO6sP84hb0/bNWNhUFIzFyed6dQ=
X-Received: by 2002:a05:6820:190d:b0:6ba:1356:2038 with SMTP id
 006d021491bc7-6c0be33d275mr265878eaf.65.1789067387356; 
 Thu, 10 Sep 2026 12:09:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c09a122443sm848777eaf.9.2026.09.10.12.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 12:09:46 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:09:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>
Subject: Re: [PATCH 2/4] boot: image-fit: add overflow guard for FIT
 decompression buffer
Message-ID: <20260910190944.GN1764417@bill-the-cat>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260909192016.217183-3-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Eso7hfM0rOdRISVp"
Content-Disposition: inline
In-Reply-To: <20260909192016.217183-3-sriramsriram@linux.microsoft.com>
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


--Eso7hfM0rOdRISVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 12:20:14PM -0700, Sriram Sriram wrote:

> From: Drew Kluemke <ankluemk@microsoft.com>
>=20
> Add an overflow check before the 'len * 20' multiplication used to
> compute the maximum decompression buffer size. On platforms where len
> exceeds ULONG_MAX / 20 the multiplication wraps to a small value,
> leading malloc to allocate a tiny buffer while decompression writes the
> full stream -- a heap buffer overflow.

OK, so lets assume an overflow, or just an invalid max_decomp_len,
shouldn't image_decomp handle this case and fail and we catch it?

--=20
Tom

--Eso7hfM0rOdRISVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqMAdAAKCRAr4qD1Cr/k
CsIdAQC3IeK69YbrdY3WIMwCBvl7+/dcW8zrWKPTzG0c2RFd9gEAwyklTpQhM/Ys
qmOFMTWVgQsX3B0NN4QTPJeDudFhPQA=
=p2HA
-----END PGP SIGNATURE-----

--Eso7hfM0rOdRISVp--
