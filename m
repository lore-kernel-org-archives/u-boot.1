Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990B606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FQBEBlv6;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=depEsjoN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6896180993;
	Thu,  5 Nov 2026 14:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30E4FZawZimH; Thu,  5 Nov 2026 14:42:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB1FA809AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793889735;
	b=qvaZhQiULilIlvAt6yrNOI6w2hlWyxrT772nNlJ9X88cxr9UTJGdVDOY41/7Ivmt0pbL
	 GWI85y+8Zo4ui0kaw3WIk3L0izGl0P07iB5eB+J2dqubG2YW4A2+qZ8O7GV6sqaL1epNv
	 Byn2YQShJUibcE9zYYMjv8Rmq3cJOcATx9p/8UgAoIifrJVhXIkaK76Y8iP/QjRlMl/gG
	 tn1hD3e4PN9YjFnGKuDUaTO1FiClyj5d3/JnSRz2+NrACHpjhE00JG2A87LxuXzF6XYY2
	 UDzFsOWQWb6ksyvLVmJAF5KtekQpx8tJYy0tyaKVjrMUX/YCoN8nL3ucI+ghgnThkyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793889735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hZ7KhHxgcNaf5aYOQtegfDqyLF1J5MBPDJTe6mqujmQ=;
	b=SDdbzhX6xx76SK8J/zT955NXABfR17NWm/xDYRpEMz58AfDR7+2v++AW1Q0l2VUvnoY4
	 AaCAZ/8l6KaTUmF1SUsZSJBp1benVp0eCruSulBmJESxwd4PXjyc+lXc+5YgSRjafOFsG
	 8CuT8C9ssxQEz4bEUNAn9PcVFhrmkOB+k3dPYWo8yEzGXVdq1WHsqfi+f9WyIf+GTCpvN
	 ehOblytBugZFK/mqp6f2P03Lh4/h3KY+arOPw6rte1UDd7pAYJmcxouxBvs+Xm1k/GReP
	 s6ZiOYhv8Pd2CAct4AT6zJwzguAZRFVyn6BvAXDYtOup/0L9aVWVhLppgsqFclrc3dg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793889735;
	bh=hZ7KhHxgcNaf5aYOQtegfDqyLF1J5MBPDJTe6mqujmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQBEBlv6uaZgS/IagX/G6QaYtWumzLj2r1PDfG6wkwRd3c74jo0wYojhqsngcu8hx
	 juw+SdCN19A+Z+80vnF2EBu2y2hUnc16vG3XwTNSkn/2Qh1LiMe9wo79J/BAv3VLUl
	 M+CY1gZ203rt553KExXzhPo4QIWhOaV1Nc0uZJjl2LZRzlBNxNHK1DBo9dFG6/fJfI
	 4CXJ77jz7lK5TrWybP0a3Koaw5KxU235aao6KNsSRbby1sHbv5gPtbMGFEDeUwSbfa
	 JPDnlqXNCwWefKg+BkIymSGJZeac/HOA05xXpRufx8UbZFXXY6yaMAVecBqG2sKqSS
	 LoCMAt6dd6lGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB1FA809AD;
	Thu,  5 Nov 2026 14:42:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 560E731F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 478BB4088F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:42:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkKPGXDZxz8N for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:42:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 834C34088D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=depEsjoN
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 834C34088D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:42:13 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-82380b0f55dso879129a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 06:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793889732; x=1794494532;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hZ7KhHxgcNaf5aYOQtegfDqyLF1J5MBPDJTe6mqujmQ=;
 b=depEsjoN7C1Q6etv7u37mhycIJouDANcLCbtFaS2ztuLWgMiG0dWmVyPzFdBCdYP5+
 mSgnSBnlZTlpG7FrIPC+r8p3BKiSBfx9OwlBncEw0o6y27GGg7fgObz7KgIi6jHPpT/v
 mKQcCrUKBsOCTK6ap1KnCRf+1COcAfLDB66QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889732; x=1794494532;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hZ7KhHxgcNaf5aYOQtegfDqyLF1J5MBPDJTe6mqujmQ=;
 b=rDXCHfKMlkKWOdmPlyQ1PoOqyj1huawNLSob8hUGoUyxa9wR0NX7b3FJB1lxZPkwXe
 kh9Sj5CUOxGHLfuzmDAKsjOFQo19ylozisxp3+ZnKgeDhfo2dJbrkbU9cWKOgXGWZOy7
 d7TOI1KpMc2rRIh0mYetuOALpt/roH+6VGIBbo2xVmbBfbrcZW8mUwSLwuRH6PqYhHqi
 PJ1wopZP8EtWyF/++pUoNs9/7HKfUZq82p9vlufWJJl1W9Jt3JECNTJgIl12YN55WWt2
 UD56D7TNS7BEqOvxRiNihtcTong3wkbBe4oNTKvasluaXNkywwrEKZ1eTwG26hgt8B0I
 rHXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByR3XiMPtzTA0eICXEUJL0HstgJ41YjiOHc7Ghz83ODzDYQdtZvXt6nXyNZ7DKCaAFg044AZMA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/cXS5oz/lJDjF8eYDj4aRO3mZtQQppn8ZpbDKrvmCivgZT32ga
 byNqkMWGW9x6DztX3KhfP9/kzw8IaWZaGMzBW0AljRT7GDxCQ1olMzK4Tgc1ZhnsG8DB5bmVcEH
 SFpHFlNakcMlI
X-Gm-Gg: AYBFou0tQXjebAYxprvsK5jc24TvnGQAW6YfjqI1pZshlrGaXWloDIhNIFChvzCEeZT
 zEV/d9nE6YEyLxXHo47gVA8J6p4qXo8jkRp1Lg+F0+WkCsWt5EH41wbykg7kz3SZJF6aDCdvlxC
 YMGzKDEAZq+CmLQjNXOxw6BueAmYXuzQpKgpJm2kLozyJjdUwzh99DEjcXipQZQoun6cYn6aKUU
 0QZ7cqh+jYIpejERjKCK108UGI+vF5Wc8Ncd1aWA9YFHNhB1X0PwO/vB/lGQEsEOxndD5Qcfcl+
 ZdeiidWLavh73zqBAFSxJKmQJ1XI6H4xOk92YROnNuxgrWn3EZyHAnWN/EwHyXzuBtMI2/ZCBiN
 BZC9F+VI1HH3WQy/zopDzvwBDdGiGgih4EPUUb1/YwlS85XMZ7PgCMpe1YrR87waRZjJVA72PDq
 J52djbfgYQi7LMAac6YeNzEtcQ6nBWPSuEGjQCmBWfXjYCNzVm6dEQU6uH0W9f7DV14nxvIh01J
 8hc/qJgNx5XgemPOTBcBjzC+XRJyEk3oHyxqA4ge+xdDaAZ264clT5xQSNn0bslXzsd7BM/4gJ6
 xxt+IltXiY9Y2LTwdk8HbKVObeAbtyei3oWj06+Y4pWDWCSx7EkqMxrzIbRfvth/EvqmJZIOriZ
 a8nzwca8kT/qDGfv2G4ZBiBetXq9nfkv66lcJ86aJ2TL+9RfiGC2KhLg0tbJGUOoDrNOPA9rc9e
 aq3MDYeLDypCdHY9LEctB0LWBEXhf+xw==
X-Received: by 2002:a05:6808:3a0d:b0:54f:a72e:1f28 with SMTP id
 5614622812f47-5640dd47bddmr14133915b6e.25.1793889732057; 
 Thu, 05 Nov 2026 06:42:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9c7bbcesm4288847b6e.1.2026.11.05.06.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:42:11 -0800 (PST)
Date: Thu, 5 Nov 2026 08:42:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
Message-ID: <20261105144209.GL1164024@bill-the-cat>
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="exLo312r/BAhbc/i"
Content-Disposition: inline
In-Reply-To: <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
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


--exLo312r/BAhbc/i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> On 11/4/26 3:29 PM, Tom Rini wrote:
> > On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> >=20
> > > Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
> > > configurable boolean, and update all defconfigs and Kconfigs which
> > > previously only selected REMOTEPROC driver to also select REMOTEPROC
> > > itself.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > > Cc: MD Danish Anwar <danishanwar@ti.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.u-boot-project.org
> >=20
> > Unfortunately this misses some handful of at least TI K3 platforms. I
> > think using qconfig.py to confirm which configs have REMOTEPROC set
> > before / after, and that they match would make sorting that part of the
> > problem out easier. Do you have time to do that, or should I pick it up
> > and do a v2? Thanks.
> I can respin this, but do you know which platforms got missed ?

I lost the list, sorry. It was a number of the r5 builds. Perhaps some
fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
and without the patch will quickly show which oens it is.

--=20
Tom

--exLo312r/BAhbc/i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauyVvQAKCRAr4qD1Cr/k
CrXKAQCMHp8fQPIh5oNMm7BL2xyh83bp1AjTSr/U8pAJxtwxogD+LsmfinMB/Lrr
YX7pnobyYfpEVXUfOAkPU3FLnufssA0=
=URbY
-----END PGP SIGNATURE-----

--exLo312r/BAhbc/i--
