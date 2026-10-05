Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0ACCA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4504460725;
	Mon,  5 Oct 2026 17:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtfbBK9mNKEL; Mon,  5 Oct 2026 17:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5B3EA60754
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791219968;
	b=dXszqCpO+TozqH5wJ7QQaVqGxYkU4M+HenGrojmGrlR9feP6PeG/tY07AifK+fVGPm0G
	 lL9GjcZhzeob9tK/0Vs6wrI+GeVJU5IjO75WGNeI26kxzO66xmDGHT58koBd9Wl0enP6D
	 fO2PtSAgQ095EMOZx8m9AZGBrxzHWUnyUevjutGLdYUOpXEl6rTBNj/IuW3ZxM9P2tIk5
	 UlpH7gJ6z+rEfFf0Sh52e/EhY365h53AZoz4j7lGjAZvM/6xgaUaA9KKZneUoM8mbyyE5
	 kazEb892iHJ/qbiIufEOoZLsod1o8WEyKgg5JhkY6mFEmGqe84FWO0sLSBBcsFDUk8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791219968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gw5+QRn16xF68oYVB1DZAsmeXKFNWYR6tAZoESKPheY=;
	b=Mp+SQ1maaX/26u6ieiozVw0x4vT2VtwtKSy25YU8szH0m07ggKRUFj+NU4xsukscWlcJ
	 XoZosyeN8bi0cjxh27sdbAhkkpmMQpcBEQ51zexAAMn2TSQ056nkT9nod1WUPg/bp2qQP
	 vBytFsFP+vy7JV2upyXQTsR3p3WwPaZWRPAtaDkovQXtmP/sw5sw9IwXdAyxNe1IiVmVq
	 gDtd0ecYAPIixia0Rgw5Cz+9IX/roQp92WKwadZnZ2u1A1Qlvs/jxB/ZkOAL9jC5cJAg3
	 6ZT1lmsVBtb3N/eWZ3XwFpC0k3SOWEZyeTI6KLzKrZfF9KUOfA75aucxnBTcWCaFGSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791219968;
	bh=gw5+QRn16xF68oYVB1DZAsmeXKFNWYR6tAZoESKPheY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MVUDzWG4CfaTClvbWV0pbReZG30pxqxsflmFnn203gj3MCORz7WG8aBP3HCp7Nhih
	 vY3pgheZFG4VRtVoYvOYt4YVC1oKHTMtuMfhZMkTnbG9o+2AyuJqTTzDesWkC6pYJg
	 wjn7ErDVhm+PWp20+uJeeGOd5qwPTNlTkYkQOCyBgSGSF41OID9/Dp3oIeHVU3fFmJ
	 xuCkEkwAKNFVLQqs/yYxesFcJhdRvT9vKhdLJh1klxuog1q01BMchFZS2WavnLYGND
	 +b1DsGI2ZyRVUpcLpAHljjiajTxfnpP5DhMob0u/7P3X4sjyEBY0Qyt931uOGQ2F2o
	 lu/4Qv6SZil2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B3EA60754;
	Mon,  5 Oct 2026 17:06:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A0C22E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 804C640201
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATJrW0-NLeOD for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:01:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A9A2F401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791219711;
 b=Daqk5v+d9F42J9jriB9LLBFZWipVAplrT/cwdOxiqSXDXjZr0X0OAIE903/piqlqFEza
 vGSXL0K4rRiVs9mysucwuQNmoKxdNfAiWyadyHEVUxI1dzvAxYPehvIg1fp5LRjx12mpO
 ilbVn4NMgUwsewDPstkOEE6SryNDrWxNREB/d9/mKXg5EM+z34V/iWDx5izUJV+2TzDiB
 eHgfjAiMAQn+OgHIFYKLqhQyJIE66raUWPVG02WZCVFGQGlRiI9v/OmddaA9/nMflBNfb
 SD0LFJZ2Q7NJDGRFkuNZDyP2NBqZwZtULTRfcbzaflkYgvO4f1EYcziX1E26nj1KTuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791219711;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=gw5+QRn16xF68oYVB1DZAsmeXKFNWYR6tAZoESKPheY=;
 b=BCQTSPNWZE2mGVyWjt8aiLPyZ5EuTpfpXnj1afB5oo/qgho4zK4hakUI3vDlhOBmNhZw
 AF2CsASbMtPgV/11azAONZ76XdJy7s2N56710Xrpx7Wd4UrQz90fmmQ4DyY8VxFUy13hu
 B68m2KAqIisNZl0nebwcJlCt0IZ3BKOa5nv/PZi7++KiqT2QR338SxXGcQsJ+OFUwKKNC
 MtoDlXT/9Z2iTbfgz5KVpEC+zPwf7q+2VUoogtE577T1pM1xSV4ZxjkvAC/TI13MCrf0P
 X2G1FeXDzSKvjnq2JBlkGnx5O4vlsNwJQUM/rVERHs4TL+OU7UeGAf8FsAdXSmvT8uA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DhFed+EQ; 
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=DhFed+EQ
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9A2F401EC
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:01:51 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-451a49abd8aso1141788fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791219710; x=1791824510;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gw5+QRn16xF68oYVB1DZAsmeXKFNWYR6tAZoESKPheY=;
 b=DhFed+EQzQfi23Q+d4K0yG3piB85awEi++99mYUPlktEVMLuXQrxifvcTlvB4/Fr32
 nWBDCu0+8dLO9Y/YUu4clu/OjJz/ezqRtGYVQNTPZwTFK0JJ7MWHTL+GDYUUX03JsxbQ
 eHgEH7L+7kyILKRGjLDnZ0kRDrh2fWzAf4FAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219710; x=1791824510;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gw5+QRn16xF68oYVB1DZAsmeXKFNWYR6tAZoESKPheY=;
 b=Q/2dSNxz11iFM2QStyYgenlQ+x4JYVukgMHboX9PgB1XL/rjR8Cf7KsDpSlNS5KPFe
 ziOnM33V5QyAakM7Ki1MwPQmWZh39YjmOeH8zML5pJiOKz+J0Mbsh5C/XCGXPAPZyVor
 mRR4q7GlpBuTSHmejxxxyv9gZhCYK/lDf54Nz8URSLL0NdLDdATkSiqE0HFQryxxzynY
 twRGiXjknE9XwteVY4wuWS+ogp0eLWVc/LnFi1zNxY0rYSOCdGpa859L9NEgyLyRPcyo
 BJEK2Tz7io5+fSfKu1yxYrF3dlQ2vMxSkS3YTOSG6Qf9Weo/evFSssQ7vVXbdfG6q265
 LREA==
X-Gm-Message-State: AFuF++mXD44kOCgK7yYmapO04wdJ/tWh1XPmhQovPAEcNlbYOJOJgbuM
 NBsSdwOuwAzbHiuJRrVgXRDyjaklzr1Ot1sjnFNjEl10pIv0QpwSA7YM1s0qqlldhhtmVAZVvko
 mzhnVNFnvAPnV
X-Gm-Gg: AYBFou2ezzyDNKCS6Avzyyd2Zqk5GLTtuXI8VEw54xxqyFX8007jg4zl4hlzEufwsUT
 xZ7qPJE+6c8lJXmBwyFv05M7TCR7SLyi8YdRLLPq6fMeZTVwnQF+pUTZ+uT5LfVTuA4M0h6eJnK
 EqsSqzc9HcbA4m9ihuL0YQuOoqnEMs+pWDtF0gKG3ne04H57sqhBixWdVXEUa5httQH6IRW8E1z
 6dCnBRsNxHJKzinNTjdyFS/Ab0SVgCPSniGlMYho+nFAKx7pfLL/h/dHmh1E+aXZmhh0i/ETrwv
 a7ZMi8BzTxR4Mqg3DAB0OoVfv6UYSidTUCr4PQGkX3VhjSoLEtfOMcYdHJfPXxT796wdNtIiL5i
 AEisM0Vijlr1W88RnybI2pCDPUr13AtbMowG0kDEcL8aj5y1OD8L/pOKDAqevtcknArvtkzkv/1
 g8z2KTw7SvTqMiW4aUDTpAvBfx29DxC+Xb6B4xVrejbiNhgyi/k0bbBuz6d//MpLLAHWuLhGz+8
 NSQNxM+W0Hz43WqRh+ZCbd0i2z85e5SEEJiBKIhSOLDduLCTHM+6OWyyWgQBzIlCrXmKtKMGCFJ
 w9neg9QiHbjJcnvfC9Q=
X-Received: by 2002:a05:6870:3b0a:b0:465:2bde:8b5e with SMTP id
 586e51a60fabf-49e3a5862d8mr6696821fac.1.1791219710252; 
 Mon, 05 Oct 2026 10:01:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16545353sm9917780fac.0.2026.10.05.10.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 10:01:49 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:01:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 3/5] lib: sha256: use memzero_explicit() for the HMAC
 key schedule
Message-ID: <20261005170147.GC3724959@bill-the-cat>
References: <20261004152715.1574-1-18102059357@163.com>
 <20261004152715.1574-4-18102059357@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6u9fMa8oH3TngNrF"
Content-Disposition: inline
In-Reply-To: <20261004152715.1574-4-18102059357@163.com>
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


--6u9fMa8oH3TngNrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 11:27:12PM +0800, Xiaoyi Suo wrote:

> Same as sha1_hmac(): the key schedule and keybuf are locals cleared just
> before the function returns, so those stores are dead too. keybuf holds
> the key, or its digest when the key is longer than a block.
>=20
> The memset() that initialises keybuf is not one of the clears, so leave
> it alone.
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Xiaoyi Suo <18102059357@163.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6u9fMa8oH3TngNrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasPX+wAKCRAr4qD1Cr/k
ClRjAP9ovlymBNnEvzsRuPuRbPB7oe6h4i1bIcaUgIhj4n1B8AD+IK5nusazwCLq
hy8RZM+LjCO/c+Hf0XLAof5k++JYzww=
=ljYU
-----END PGP SIGNATURE-----

--6u9fMa8oH3TngNrF--
