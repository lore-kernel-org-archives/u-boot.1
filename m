Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677B606A332
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CzM9w7Bv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=QkwusiRx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F82A60642;
	Wed,  4 Nov 2026 14:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vigHaJILjp18; Wed,  4 Nov 2026 14:30:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEB0E6067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793802606;
	b=iK20LoElf5VF/173LTQRUFRMQd5Ll+wWyydn9tnM2/bcaTeZ0q/HAd98t9XO4kWQlIcc
	 SERO9np3csFqinjRbz+w8daHOQpqcKet5/YlXfDqA9N+7ylOE4xIqkuzb78DqegGHxCY4
	 qsrel7BXIYX6l+ylHhBi1+Xw2OVwXsM5NJKVjnwDuRs/PuJbU+0QBPjUDpPJnMAgA5yqV
	 OBv+ZMUKsTK+7X5rnIPEYyJp5GP3u5Ov+hiFq1KMAQF+tLW1rW+Oqb7mlOoZAvUfgfKtt
	 17Xy3ZNxAd1wb7HpDNTrSFsrVaRMwUWxbEYcGnSlTI/rfvJDBWmqCrWyzz0BeEQ6H+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793802606;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NSRJn45nH3qYV5lExvvAjdUfpDx/AquMAvSyCnV8qDM=;
	b=oRtn4ZcvgKnfXn7ZjyDbDWzcVVb+5HlX/U4BcUDln82LtgZm8CzVauNTEjsQEVAcUUgH
	 lptV2oEo+MpsABMpPHmhYyCuuPmVhZ5AuqCHJOPKJTsljbwZevpZmBegLAXvfcVdI7qvY
	 WdbbqiDD/SJJhGq2pJHqgSjqZO4ZH7xSE/rNMKKObmRYTh+IWEv9y8ffjqVVDG+LEmdna
	 0DnDm5oq077Giy7rFUx2aoSemwAr0GhtHuFiVAgk8aPH/fn6sUnJKV3Q24gPzq5KvrgE7
	 XpOu2kNu97RQ4cmsCYjKDYZoczlBnPgszy6gTfjoKJqs3dH9O7+hd+h6O00hHTD+/1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793802606;
	bh=NSRJn45nH3qYV5lExvvAjdUfpDx/AquMAvSyCnV8qDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CzM9w7BvmDagDQmxaW0XGUkiV6uXjjrMFeU2OeayeGSLGAN31jqXJhTTN+Y9a3hgE
	 kcfXnHq2yapYsootBJUN2pf8TUlJAJO9o3NiBrGmHcXp4hrdwRrE71ZpUUkGOHUnmt
	 mLtC31w/lmxJIq/ErBo3PL+y9Ypp02jbAdjfr9ikdymH+0cn/+JDHnBcQZwU+G9xq0
	 keTycyyAOofTbNfmp6//jXW1ZD17WJ2gWN2gCaI5u9oboiHr7UoDYt0/vox0eR3N76
	 ogfQXfTfO6huAYiUyOxbUzzg8xGNmbEK/cA8TSa/HrLhoB7HG/zDdkHhZ160aYFmwZ
	 FMc+UXued78Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEB0E6067D;
	Wed,  4 Nov 2026 14:30:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F190C435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2D64405C6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCRBNfztwQUk for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 14:30:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2747D405AD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793802604;
 b=B2Xq4cWrUekfYWY2otyKXzc0U+unVClLBZP3kv8z0vWiSAMlEmXZ9B2XVrkP4uhyBZXJ
 86d05CuTya8MJayhBW/l79SKt8wAWlB3gM4J25pMPitV5CgaLUaHVDxN5qOkxaRgFd23s
 ipGlrKxnlDW0kmT7/DE4FAapverK5zF+6VbobOIVn2aLgD3XLM0kfmCGCWYBEdHegGurl
 DUUbH9KQh9Q5qmsS707wD3r0rgHm6AlC/3/dGDUg1JiWT3OVqgr3tJN7FG7VTMTf+qPUz
 jiukEshfzay4UQTgHYkioebKpuqPYQ1ZXUNrwXfDqUpIYTzTnGRLuRwhl4id/nBtK/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793802604;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=NSRJn45nH3qYV5lExvvAjdUfpDx/AquMAvSyCnV8qDM=;
 b=W0wenzzDeK7EMgdA2R95DGvvnd3itJf/DMuJ3CH2rbQ68rNWo+SgNtGg2J7j1Savk66n
 /iXBhY1ncrfWy8fkFH/MHhZjxFUbEzb50Yk8FIyuf3PrXAynUVovDEBdCXl5ux8yYzK5f
 wh09NAtKqava8KxgZQH8CrI6pBBmLK4rOsyFhYtCbZiEAVIq3Ozrdiu1A4pjXdq1/NZ6s
 MgR0Btrkr2PcYxpkBg4Ml6qgHQ1yuijJ/LkysQNm+aB8dDQN8iG9irRHjRfabQ4TUKcj1
 AWu/4hGD2K/9mOQKpqshIN8ac/zW1JtOtc2dltxKBdwd1JoGanJQeOkjNEFCLP+sgxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QkwusiRx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QkwusiRx
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2747D405AD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:30:02 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-70b875f6f1fso689715eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793802602; x=1794407402;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NSRJn45nH3qYV5lExvvAjdUfpDx/AquMAvSyCnV8qDM=;
 b=QkwusiRx4NoK5Ecw5wCmdxLRVpzkHXlBuYrKJcr3Vr2x3unwj1pgr/tAfv20Xw9Wir
 TUxfl+n8Ev5C4mNW0PGY/f+Ygk+z2SlArOY8uByF4NfQQd5WGSYz+7cJBMVpCODF8ecv
 +bIZMRXhPS8zb9E5492w7ZSge++Zz1rCNNATc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802602; x=1794407402;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NSRJn45nH3qYV5lExvvAjdUfpDx/AquMAvSyCnV8qDM=;
 b=VPO15rGjOEf6vrlOH73nfTejnWPFiRy+9ukxAf8O1OSRSobInBeXVszwc88uKfZnYA
 JdC8GWPZxZ2HDefMkcMdIGCD8Cdp8YXOgfXq1AAy21gDnGsuhO/PjQcCGXnB65YaYNZO
 XNXB+/gSUMEnJlm/Yuiioy6dAgrbhuj+SiEaPjXSpAg8y4KoExz65iWZInkTTPU47/UR
 kzQKtzMAs8/gntGxASwGa/GnxsEMcq7TNsn0vc3Y+XjpeZwSz61jHFxHUgW83n1RxIri
 9wZXkbn42U8v5FVZkha3UTH/gjvyj6XRauP6Iv3KcVGPzH/9X1hgYAQM5o3xQQvbfo7l
 5bvw==
X-Gm-Message-State: APuU4Z9hNAio3Q6b1Ge6EvsKn1yn2XYasCKozU5NUnq6Z6VGQ744ZAu/
 c9tWxaFawI1xWvYlGKgGYt+tFU/ah/VOmdN/bpJsl6UOHYViO2EvnHMeKHprpBpDAOw=
X-Gm-Gg: AYBFou3fJ5bSLF2YaD0T+ntSToKiU123o7T8GLW5EVA4th7INVCHHXgvd/3cxK08Tdl
 a66Zhhc9bsxP0Fy74WNn+22Qbpd6i15eZA2urawrYGLPoDD5/bEkSaHg0vttwKqEoru63bFhcFh
 B2v2Ea9Pd819KvcdENg4f5oVygjy09uRPJn2hbQyZMG2bkYAjIBnhe+7lBF06Hu7cwcTzASR4pW
 yS0IcYGQCbOnAcHwjZ7O4Y0y4C7fyNanxDOo66CgHum79Gre0AqvPlUdXPnxJQf32nfA7QWa7KG
 QzjxEM9oo4Wrt71Qred9yiXz6umMrsvrOI1Sw9golT7XFo6CKz2ImsB54H5h29waGl4vF2wJiAA
 pRklG5W2utEqZX/zuP3oPk2YV0JQonz0tQIhPQioQ1mYORxjD170YsgCL+E/jL/WXmFFKyU2+La
 ZODs/Q+v9Hi3jcOBhblVeEzG/JtdYXZTyULe+BlVBjMPqPZcGTbgFFdRD1DGeVJ3KsoiJn/HZuS
 MrgNYihs1ohwlkumlao0CIijNaMBS3T0gIpq7+WIcB4PzwQu7BUF/PvpRBewZ+syPlN5kAORrjG
 YFVKd0WsDs6V+1acgb96E3TZgV8QdYaBQqJ5839pXwV4V2kBL3vD/LnZkRNaRfOjSQdO4poR4Ge
 jkXGgvqSTTzsMAWq5VTjXGczHFK5AT7ZjzYdcdjNQMph5VsTu0tvjxcYP3m7A9Vb1KXxaayLrag
 +/l9WX26lagTDoIW6xeNmc2ZpL1ZkAyw==
X-Received: by 2002:a05:6820:a65e:20b0:702:dd8d:3167 with SMTP id
 006d021491bc7-714f2a0b974mr6661848eaf.53.1793802601744; 
 Wed, 04 Nov 2026 06:30:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c131789fsm1784560eaf.12.2026.11.04.06.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:30:00 -0800 (PST)
Date: Wed, 4 Nov 2026 08:29:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
Message-ID: <20261104142958.GA1112376@bill-the-cat>
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lTJ8V30JBUlHW4/N"
Content-Disposition: inline
In-Reply-To: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
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


--lTJ8V30JBUlHW4/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:

> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
> configurable boolean, and update all defconfigs and Kconfigs which
> previously only selected REMOTEPROC driver to also select REMOTEPROC
> itself.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> Cc: MD Danish Anwar <danishanwar@ti.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org

Unfortunately this misses some handful of at least TI K3 platforms. I
think using qconfig.py to confirm which configs have REMOTEPROC set
before / after, and that they match would make sorting that part of the
problem out easier. Do you have time to do that, or should I pick it up
and do a v2? Thanks.

--=20
Tom

--lTJ8V30JBUlHW4/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCautBYgAKCRAr4qD1Cr/k
CkauAQDcHUQ6vGnzxqwleTwfn/i/vAPitfBspp6tRFy8j9CR6wEAjthwNQ4rmsVW
xbrYnwNL3jz0cBqpKQJEcGHENcW03wY=
=pkJ3
-----END PGP SIGNATURE-----

--lTJ8V30JBUlHW4/N--
