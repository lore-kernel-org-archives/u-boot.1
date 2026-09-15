Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B147AC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 18:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6331440363;
	Tue, 15 Sep 2026 18:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0oMxQNN0flWl; Tue, 15 Sep 2026 18:49:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AC73E40352
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789498199;
	b=Q2x0cVJilBtwivNTsTWuIdzHwQqMImwPbdH4Ed4f300sGxXwlUFDzqqBN7kxtU9tiiqY
	 oAnGxXh3wl4Ik7teedWMJTd+RPECF7Rz3ujcOy7PIWZQmr5jOG1f8JPgp6kLJFnteLssX
	 ymqMJbGYhQ0wlWMRZ6Pi1w6h0saa9IqPXb0UtWouR/h7HrBhDfeG0XUnBys6EpYnV8lRq
	 1KbX6I6jFie7CFkflPU5ZD3U0uuuiwYF1houC94eEbJP9oqTQBkChUArg1bKYuTwwK1sH
	 Sv0dUgfIbbbZaIqyOVaOLt7TmV9XHHOOo8K3gqgbocnAgTDN5Vj2KBz00BHW1T6HGfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789498199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nZQmuypJ15JcuDzfbTUu9NBbSMvPUdT+SBtJEk2BvPs=;
	b=nCCnyNTv6tnPPB8WyG9oe2TwpIYoSgTB0ainlk1yfyY98hnkjMO6Ljkdse2QaZ4pjrKw
	 YLabN4nz+ycU6QcQ7vEHC6XmCx8OlMY1Xceqhq5Wk+fyX4QrZIum+jjrSVYgEnxp3BLCt
	 jaRUK9DqSGQzjSDwctZtRqfGJjlXseDehP3i3RJEVM5Ga82AiQRcgg3Zn0yxt8QBqIzyw
	 F0ld2xud1fVHBcg6rMkdWrCuhd4UmlrVG9qRDVlf2MJ9776w+K68OQh0BeE7AyNwxf2HX
	 QAgyv16J2vNKkDjWe75tVMxq5lSR2VYMlfvZOIbc8d1utwhr3Mpn7m6V7bjADqB7IJA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789498199;
	bh=nZQmuypJ15JcuDzfbTUu9NBbSMvPUdT+SBtJEk2BvPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sBK3yp9JUgCUeSQbp4vyE0k7I+VeZ/ruVCgQSBnbzIIHR434CMbAhxcPgVcYzK//1
	 he3UhRS3rj3KRNlPPZt+xMxMMGfm0HxpPDzB90DwOrQ7uVPdVfMoIQNTgr8PARYTxJ
	 mTVD5MhPrgRV5Cuq+Ue4RLJmUmPeNH7jeWtqszawRNfaJVw7A+2nZ8KpcyL1omAJK9
	 ddI6NiQXhUBGYRU60ZtNigUQrDG4Soj49BS7J9nkmIwhY7yn3pAstf8IZogYOyqqx8
	 VPBfQBSVeDgPfHnqC5SPasghwQZ0X7SEqbG+ZdnTBuhA53HPvtWqk6ZmZXiP3srIjm
	 6M9uAb+wsR6BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC73E40352;
	Tue, 15 Sep 2026 18:49:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AAEF2E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CBBB400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Fqq5g3MtoS2 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 18:49:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E0FED400C5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789498198;
 b=BzwmSrv1JNbt45lS0vItEEKTAlZjaZiNwbFLT6YZyRbim57SZXyDpeLv7W4OPyMZ4Zwn
 RZ+nIhsm8LrJxQp/yyVhSXKg+/OVJsM8elbIiX48BLncP7jspejgwzjVrrO3Ls9O8cz+l
 2TBECt2Bq8oX56lVOu6HrAznxt1t5Bj8MaU1B2NFlquB5fb3G4J5xxbnWbEQq+Utnd6mV
 LWq3pbvp7ntVhDgoony6K/lftV2CsbFatceNG9qVdqublkWydfQdyV7QiRedukNoNtbD3
 x3RGVZEVu2mgRXPZD7Jab+OV15kE6mXGkz+L2FkKh38ur5emhaROfVlg5LHLTc/uDOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789498198;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=nZQmuypJ15JcuDzfbTUu9NBbSMvPUdT+SBtJEk2BvPs=;
 b=RtYRT0LCGSYtalSmveOISmQTFeyHrWjMlYY1vZrQA5FYTFNH06c6Xe8lOU6Er9/tBalI
 ENGKyppoCydjHPBmM+AyM6gG4LRVKe4YPjNi0p/PXD2xf1XLvDJdBgBAvMbutL6HNPVL1
 7PnGveeakDfNd11feiXRXoyIxf4qHsSWZ1brQhLOmoo5rjK+b684/pu7v4jxvUSayfsTX
 DZIAekAyCNrWjWEy2mkGrhbysWB/KUwzkzIhMyMKT1Emnufp7DlSxpUkNMGELh7LS589k
 ZKOUirAcpt6QTAlFwC3IjepmYhGP4FW3UISeWy2SDjdFQzzQ5fIZNdqOwQmhKAlxjnQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gq1BODLS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::e;
 helo=mail-oo2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gq1BODLS
Received: from mail-oo2-x0e.google.com (mail-oo2-x0e.google.com
 [IPv6:2607:f8b0:4864:31::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0FED400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:49:57 +0000 (UTC)
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6b1ae72186eso117177eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789498196; x=1790102996;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nZQmuypJ15JcuDzfbTUu9NBbSMvPUdT+SBtJEk2BvPs=;
 b=gq1BODLS/6ItiOHRIriMouX2M3XPLymC2L+Ly1Hv2CAwaqsD+rZQxt2Al0D/k4GX15
 uxCwDeDKJUi7ff3gyct/6RbcBZfQFZ9VqjNkKBQTxHVI5fliPWFajJvXKg5vyA5AAjWT
 lCtPX8tz5SNy4mETCdiyj7SNdYY6BJsBdU3sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789498196; x=1790102996;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nZQmuypJ15JcuDzfbTUu9NBbSMvPUdT+SBtJEk2BvPs=;
 b=guobSrT8IgoZ7KdL9bvPwcXi8sNkqs/KwXUb/RzX43qBIgvLvRucRy4qXPb3VFjM4m
 5BUqLDVyTm7wPU3IiNUNISCk8d7kkKio6sdB+8f9+xTuJ2wE8xp7mupoU6QgfpOWiq+e
 eVGqPdU1mZQSg2QRKnvDNo0oJDYbLq12sGFxlAOxSJnTjfLo2USOr6qbEa9RoGS1ctYN
 w73lobgOAx5fLzQ2RULgWYr1+P8ev/SOBNXgX3XJQSUnyyXk97b9pN9K9tEeZtQOBG+5
 SwmhUdS6ph04MCqsBkzU3zzRITNoSN4ctR2EekI3fO/IjxhwiQP/a03vCkNuwFNbWrkw
 rgsw==
X-Forwarded-Encrypted: i=1;
 AKwUvByTVb/2L8Pw1j6nZF/YcWnWICumZtxyLV3bhmArcMvW3ppMnNpT58BCHIBRCam7/tWREOGzQWA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lsUE2g6dS1kYCA6964JpaGp+qldpUGt/UjO+dRNF5dnlvOVK2t
 asQpnC8qromN3j1yIIhhqRtePNU4F2Rh2KMzQGqkSyZhQLYhe6XK1i73/Qv2R6dokbM=
X-Gm-Gg: AYBFou278hWrFkcZXFRZndpUG/D3UFk8IDgK+xhI0MOB6NrcsnCRWf+WMYwmGX7IqP3
 w5MXKcGVLlaOtnf+qZx5IaxPaBlR0XyqyVbprkf0DtdNSJY54W/Nlb5Dr+fo4m+HjQd1OuqHZop
 4AcDmgopQt+Q7dCb37aMIKE0wSrKcVCqqNhb0yF3/SG8ZyqBuF4I8Ftb4ccbrohJtezZnZi2p0f
 2hz13tSk4IWiBQgXHV99lEaTNLGNxXqqXeNu8arOclqCZd+auCa61/dEOj2Aga/Ox4axZwA9nX1
 fDIpz6ivKH1dBN3kwaH/prgJB2fvmcoofTGBzN6r35fC2CzTTcSsE4BoBlxJ/jwWcoPcmtz60p+
 oTeaHpz+G82j6jLyYb5IYe18pHaoDiwynkUBURUv57np03rPrgtJwv5CWSycUwuW6aS2bNgI200
 KAWsG2NIgHu9qQFsLqiWe+wePUJoWxLeicLZdid6gVpuF5m7Vt7G5tgQPq0SxSWeJRr4+hLrD2k
 IccE0VwMXQeAob3bnQ9UlVVTs52YTl99ykFGRQAE0P7soWENKhugnnQX/KkxnTV8Yvzg9UlS/ow
 a3bozmnPeKrjd7O+hL6d
X-Received: by 2002:a05:6820:f04:b0:6b9:447b:8798 with SMTP id
 006d021491bc7-6c73a15adfamr1824605eaf.63.1789498196110; 
 Tue, 15 Sep 2026 11:49:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c7a677b3bdsm527895eaf.6.2026.09.15.11.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 11:49:55 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:49:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: sjg@chromium.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
Message-ID: <20260915184953.GA909517@bill-the-cat>
References: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xwBASk/Tmxy6859T"
Content-Disposition: inline
In-Reply-To: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
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


--xwBASk/Tmxy6859T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 03:50:35PM +0530, Naveen Kumar Chaudhary wrote:
> If the malloc() for the UPL handoff structure failed, ret was checked
> while still uninitialized, leading to undefined behavior: either a bogus
> error code was returned or, if ret happened to be zero, gd_set_upl() was
> called with a NULL pointer. Bail out with -ENOMEM on allocation failure
> and only read ret after upl_read_handoff() has set it.
>=20
> Fixes: 0fc406ab20e ("upl: Plumb in universal payload to the init process")
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

I've seen this a few times, I'm curious why you have 11 chars of the
sha1 for the Fixes tag, and not 12?

--=20
Tom

--xwBASk/Tmxy6859T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqmTTQAKCRAr4qD1Cr/k
CoSbAP9FcFwPI2TFaTQ0Kq3NMI1R2ZkJPEBi6+Hjik8pMjD/ywEAxNEb//sA6RfG
LIgjaNCesLzSlcDO0/ZDXlEESxpzkAE=
=za6O
-----END PGP SIGNATURE-----

--xwBASk/Tmxy6859T--
