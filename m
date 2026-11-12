Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9330606A33B
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=akCi9lKe;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IFFEJjRf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D285409AC;
	Thu, 12 Nov 2026 15:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hDRyJJdZvykz; Thu, 12 Nov 2026 15:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DCEA640AE7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794497287;
	b=FzFYMwpLD3IsYJxVeEgRBP10Yb8pOnJzA/ycBZa76Xhdu7fbFAseUIsvrR08j64JjV0W
	 gdYG1hoJjlSoswUu6BUXYL9puFqH7jJjeqpstzrwUp8c8DWXJ/zLzjbdF3zA6Esjc3yKg
	 aSWCqYOn0eRIa0RMhKKkjr+LBujFMlJ9n2Zro1/uIfl/Gz3QV9kaH/B+LeK2qzC6jelk6
	 u8c/WOF+pKPooryYXNJK1j2Sx0dMmWNnGtCtGFZr/eRQMTCtNqHhOLEWncB2AuVDlz8Gv
	 uBX6qmRXrzJQxBJhrSwU+PxgmHEdWAeNz87CqR24JrYvKN64xCUKVPfZSknVzhOikQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794497287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gsZfAr7Leh/34gE3bI/wxguTboTUTfLVLNc1+n1wNj8=;
	b=iKzrTbcuubDmE8Dr96H7LuvDWElImpfgL/mp4Q6serTzJ7Odr6PG8R5joMtBxy9Ilr2Q
	 zFbR7GZ/hrgOZfCr9smIT6K4ap/J7WJNect05o8H6+I5Opvf696dhx+i0x+6bKQV4jHT0
	 NIzVusG44wJ8dm3sYVJvNWnoztdgRJj682LUVBGK6Ge+kEfnqZTg/cFPZ8CU8EVydizDX
	 +9LOlrgfv0XI2v1aaznAlsZd+vDkrwQyv0b0J/j7wxBVX4ybKI4GyRzXtIPw6CZMEz494
	 omN1DwLwzHvGRugnWJuvRp/sN27+04tQzMn+QhL6RqPnxG+44vVnw8peyfLR3lcGUZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794497287;
	bh=gsZfAr7Leh/34gE3bI/wxguTboTUTfLVLNc1+n1wNj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=akCi9lKeNt4mIO4QrbtJthPUnnkuffpetl2ZdBRaDCefw8Yicu8T7iVpGnl2Fd3bp
	 tpED4/CieFLIBXER486xgiipriBfvIB0/f3xScriWDfPGG5h8FNTi5X8E5vK2fadbC
	 3dEyZRmkFkViaKRNK1YlLvclBCWEP29zMyzMKaKYsDDbOv6XYFpT9aC8X7dBHtPJSg
	 6q1HbaREZbGX9LoL3jwYB8DG5jSoD3MT1b7nnmRCegwFOcjSlZWIWrDKVpoqmtMbzb
	 J+AXbNvRibI+B6TVcDMFwfz0PmRzL+r7kcrwJ/xqsx3hrGkh+a1ZVTCNEPJj+HC+/V
	 QlIamrocA1Wsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCEA640AE7;
	Thu, 12 Nov 2026 15:28:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A80E2F46
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8DBAE8135D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTsu2tpcvPoZ for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 15:28:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBA3D8134A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IFFEJjRf
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBA3D8134A
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 15:28:04 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-48e9476e26aso1590597fac.3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794497283; x=1795102083;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gsZfAr7Leh/34gE3bI/wxguTboTUTfLVLNc1+n1wNj8=;
 b=IFFEJjRfoL60NfaCt+IJ6CnU4bIn7tiAQNo00wKd/le2QYmFRaYCU1DBpBBG9THJOM
 Iz0JeqxWS1tuG4pn08Pk8Jdk9FH3Og4dP6diDi36QT2mLxmKLjIYwJ9rzsILfdZmcagh
 fR2gnkPdXo+lFTnBu4w1eKGtIuEVuIbHFv54A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794497283; x=1795102083;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gsZfAr7Leh/34gE3bI/wxguTboTUTfLVLNc1+n1wNj8=;
 b=qBlLOEpGXNJCvalg32CrTtqNhdY5Dqi8jXP6fBGcfmriGdNlvJmkBkfMTXTtQ6Doa5
 pheKU9SE7nlYTidoZG+1aLwiaq4sJBhSYH8UejX8bm0Ll3eB32aia7WlXJwgIbOYxQdd
 cXWZTeXNzqytj5a0gHchd24TQS9ewW4+nd9k3TuFSipwfDexqVwKE+QS/P3stkVgBdpX
 wPGfTuRw/buuSk7RNf2So9a4nDK03mZyKsjyzRcpyj4Ihivz2+S3DIyZh4ipVsiEmZq2
 yzI/pbOyjYh4PO79xsEWjyitQMUg6+gbOMMnEbqrJod2j3fJWS7go2jmqypzXZ84TrW4
 oxBA==
X-Gm-Message-State: APuU4Z8ycLhzcbTS8kvHf7DSqIXYIrJjMkDlEwNEQg8t0zQZDRajEL9U
 +0aialCH4mbHVr1MZgbaZKQ7a/uvRs9DUkD3HWtT/z1S7BNGEt5DPNoUQK4LZpo34se+hFQxg+c
 +ezwS6sTEUp5w
X-Gm-Gg: AYBFou00I0u6/3ILBfW6+N00TbMhH75O2KjARQ9whGIfs5DMVVlpf9zQDezKPNEvxz9
 LPKr9NrevOV6Cfds/wND1CHg8KgQzt/TwGi+AaMcYXMWPmii98Ocjzpd+ttItub56ZIZkTaPRPS
 tmQrCP5e3uNk3kP+jUSDhsCbp9Aqo8gwXM+zbTjZw/v8vu7C8c9vNk34RzY69Z63aoG++P5dODf
 ZHMpygZs42UgCy+sqWqgyq+Bd9qIXvWt+N7ka4ilHEg0WV08E1y5mdIjDcb9Tpf7U2WQLZ+43F2
 L8sHM/zQ6lv2+/ll3JYRKEtUlHTLn66I7gtcTzpx5dIvo2jKscTH/VCgua77TojeIyq6M5lntWH
 L0OzRRVVFJCBAt1wf/N2AAwJkz9XAW2rlA1KilMaGCeBrtSGwRNPafLQK5ZQ6CHEJ6tuwC9BzWh
 TbL+3atALgPqNyz+ssPZtg2DoMXM2nTCLv/xOvjeREWIbD0Oow5TPFM3dfZnI24lSp6lD22AZDp
 wcFDhDkSdAeO4OGdhJucNgcyQcNQA3xYRvflryR1Wj23df8d+ciKqw58g5WrJ6ZnMLmEbWhMc5h
 nCjDnfNIC7bQTciDZ1vALZcYe4fBDhbkuVkIHgp/xxwdgfYXhHnwhLBnQ91TICE5TXUnwf2/una
 jbBWDkM7WT3xcyz6mjS2k6DPl1B1TCq8NB+QtT+fJCqw1+bITl9B9+zohcGKaZbFlA7KXwYiTsP
 jB8+h+v8WosRtyg9Rb7L0f73kZlYFnvPw=
X-Received: by 2002:a05:6870:658a:b0:494:84a6:cd6f with SMTP id
 586e51a60fabf-4ae46c29ec5mr4879825fac.41.1794497283022; 
 Thu, 12 Nov 2026 07:28:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae23031a4dsm5074856fac.14.2026.11.12.07.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:28:02 -0800 (PST)
Date: Thu, 12 Nov 2026 09:28:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] .gitlab-ci.yml: remove Simon's lab from CI
Message-ID: <20261112152800.GD554944@bill-the-cat>
References: <20261112-sjg-lab-removal-v1-1-4473fe34c2cb@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gZcImD5dwj3FTY4u"
Content-Disposition: inline
In-Reply-To: <20261112-sjg-lab-removal-v1-1-4473fe34c2cb@cherry.de>
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


--gZcImD5dwj3FTY4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 04:05:04PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> It wasn't migrated to the new GitLab infra, and won't due to Simon's
> departure.
>=20
> Stop creating manual jobs that can never work.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gZcImD5dwj3FTY4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavXa/AAKCRAr4qD1Cr/k
CvyiAQCCiMV3+1q9CB/PuaAba06eIPBMijekcKpUwJ/axV++MwEAjwn8FP5415SS
9xWwe/Tpe+W5mlucnOC6LC1+2Oe+Lg0=
=4xOj
-----END PGP SIGNATURE-----

--gZcImD5dwj3FTY4u--
