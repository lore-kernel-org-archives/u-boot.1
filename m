Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D9606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nNe7vXcj;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=dmuJzsZQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E69D6065C;
	Tue, 24 Nov 2026 19:07:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVChyj6jVji5; Tue, 24 Nov 2026 19:07:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59A3560744
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795547226;
	b=nN+qg7YjehsdL0L+UNcMFnp1yuQxbhpLA9yMptzFekWOPBVB3+ZCbp1/YBUZj754ihzp
	 twOKGxnh+lOaASAXSRMa0QEOJ4aEE4VxG5Gf0Ti5DMsKLuHEHpmsLWL1aEvd6vVe432gg
	 4hGQnSvH8AB09oQhn6YnD2JxPtK5gNPg0f5VNojpVUx7unioG7r5ynL89mQvJ+921dd/9
	 f7Cva5YaiYd2V6d1TYvVVlY9qmmjebtHwEwlxE/GM/y5QzswKxQC7bfqSsebGpVCePAWm
	 0//mxz754XZednfJZWBf8Bv+xHwUN+8mi54WyLYBfvKDncRspOuOz8XkCjJqJ/vyfiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795547226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=v36Sp2D1uCT6zoSqqx3dEHGu+40YlWXGJKVb+DRG6iU=;
	b=g4W5fnl8X8Kzh2CbkdoAADq9ohJHwz1CNMdPg2kQL3ZIaDl9OCp+YLyZ/y2i6hAba5+8
	 SUl/b1HVtuCBAL8WxPNSrfXwT/uUgq8/eBODv/XwLvjOYii7W7T3XcqlIEb0kWNQBE6+r
	 kmLKmBCqzcE5XM+fyn8xw6gTH7ze2/PN72pDR6Fb5wVCQ7tOvAW4pRvdwUGelLsJOBJ2Z
	 ekcyDj/DsWM9U04O8xk3kBJO3bB//Dsi4+J3FuKfPFnHODihZrSp80K4hq8DZsvefBAF6
	 L0Zypbezt85lfzowPZ9UQ6/NXAr/O4eEVjrF1cH7mO3XPqTnbahA5Z/N9KvznEvoytw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795547226;
	bh=v36Sp2D1uCT6zoSqqx3dEHGu+40YlWXGJKVb+DRG6iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNe7vXcjQHNpFaxPo7NO3HiBIAqUtxMxSlVtZ5ePlhowDHSu4KOuwfJ1i1TdbNVOQ
	 9RU47hzHo6cZOzUn3bNCrc2h0d6AkuZpZd2lrJRlk6TLbSL9ZbzUGWxJ0JQe2hdceK
	 jXusouJZ5Rf8Mt2Te6LhSJ5qtRbTHWgeOgzZzwEHPkasbo+oxda5LOhjhhgKftN+Aw
	 t7nfp2MPBo8VnLO2XbDnr9o+p+18i/njvj224gnORfRUGLuggZfOtzwQZtzV633Vbp
	 vS5O2g4kKIDwk4OAmwTZGBz8ZX/+9EV4hVJ8dxpY5SX+npstXik77p0l2dIPX7Ll8+
	 K6OXFQlwquh4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59A3560744;
	Tue, 24 Nov 2026 19:07:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB622325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1081405C6
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4nHU4oXrm8eA for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:07:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F61C4053E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dmuJzsZQ
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F61C4053E
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:07:03 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6e560e00a86so3234076eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795547222; x=1796152022;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v36Sp2D1uCT6zoSqqx3dEHGu+40YlWXGJKVb+DRG6iU=;
 b=dmuJzsZQppumQx2p9U8/PbFQuYWFdQfXkXpPRo3aeuGkfHXLaF9daLKjOIJPEdlVuY
 dZ/pwy8iimUYI2UCYmpt81O4FMx986qKmN6DIBJTIxjOAJsH3KI+QhpxIRnBWjgLrcpk
 B43BfdwfdoCRQ01UB3qw+IMSnex2AwbDAM5BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547222; x=1796152022;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v36Sp2D1uCT6zoSqqx3dEHGu+40YlWXGJKVb+DRG6iU=;
 b=OHeA/tfOhkwkw7m9crTNIUfeWnfULqAJ+QNpYB73pv6xJthDlUWeECMq1BztAFOVLr
 BJg3i150DK/Ur+t2MapPw+iq/JcKu+7WOxbgx2HecXMNY5OeOwcoVVFGpaicuaFzBhnz
 xR8CiXs+rj4lLxb310zC0A3Yn2uGcNdDfG9YNbKmpUBxAElmmwrypH4ygCozEr/GBwLO
 cqL71uYTKhpAhZWx+k0LAAOWxcdRzHaK0AR56iPoov59BkLA21UI+WkzDR3TXAs9mfei
 YOyHuj+rDtLRCJndtVs3f75HJrtkNdUK+v+xQl2tkBUvVkMXiyXfygk1W77Cts3VJrTn
 9/wA==
X-Gm-Message-State: APuU4Z/XPI5PcXvWQfBywT1nhoiKGDbGDdudjWYmhydRh0Xn7Pub+xEj
 ig2MN+3zjrdGlKEoXxoOB2jkAuMM7y55+WR05+QxwAmw5FRMqkc+ursJQ+ctUXdyEcc=
X-Gm-Gg: AZFdTZdhdv7kuC11LLx1LsHUQa9Z+tMu7z81UjDqKH8oAGVYxrM8NLuGBAmEWIe72ks
 DwpGEKUs1LAvhwYFAVGDd94rC6VvkZlhPUDwVoNm3PtzfPm8rKKbloPcJZBytIESANMVeDP1MS6
 dKlzJI+9xqvldciB4j8mmlT80CYq2x6M+9uBmpxWdSscCMjbG2yHNyto/j7FqUdSua/YxxWC9An
 7GDIn9l4LrtcGFAZy7LS8G5MEkR02VbP8lb3GYHAMO4GI1voZv+0PXloJo2RSxyof377bwsK1TP
 0CYebf9stLbQFl59Feo6ZYZuMW+NpeG6hbW85wmwU/yjAOrqBgMePdvYTqpE5lc5OJwvDdeGJWp
 yhlN2U16qM62r7Ga0nOsKo8fICMRCwX+elnUOVZddII7jf0Z/RJ+EQwmZX0toLtrz0Uut2Rqzgl
 FJQh5s38LqkulY9vuwGwQiDKDHRkOdl5Y02hDlcYfjoDxMf5/ty5A03NORQa/iRvRa9EZRrNOzF
 xGxwaE7umyGQLLE2juYFCAzrleoIbp/PIiZ+1enI4biWMysBDgOCDZvsJcyE4/CbfufyRcz+PT7
 IkUo1iUxSJYqDsTb8MjElp7neRbi9Z8qGSTMy6iJ1T6RyAlubfy6FlZXkVoRLvb5rg/2Sy6USk7
 gvlLE82D2RMLsuZhzYdDr7TW+NiH8kfWm86e64833Z4b6koyElTsvtdgJqPAOgm8JF9++4BduTW
 2lFrvBg6dNT8kDw19VMWNJEPqxlalTz7w=
X-Received: by 2002:a05:6820:a748:20b0:6b1:a812:987b with SMTP id
 006d021491bc7-71b394d5fd3mr9150375eaf.14.1795547222128; 
 Tue, 24 Nov 2026 11:07:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b3806fc45sm9847350eaf.8.2026.11.24.11.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:07:01 -0800 (PST)
Date: Tue, 24 Nov 2026 13:06:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Ssunk <ssunkkan@gmail.com>
Cc: u-boot@lists.u-boot-project.org, takahiro.kuwano@infineon.com,
 Jacky_guo@xmcwh.com, vigneshr@ti.com, hs@nabladev.com
Subject: Re: [PATCH v2] mtd: spi: spi-nor-ids: Add support for XMC XM25QU01D
Message-ID: <20261124190659.GA1069051@bill-the-cat>
References: <20261101131239.1566-1-ssunkkan@gmail.com>
 <20261124114629.369-1-ssunkkan@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9meu9ZaRuqKMiSx4"
Content-Disposition: inline
In-Reply-To: <20261124114629.369-1-ssunkkan@gmail.com>
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


--9meu9ZaRuqKMiSx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 07:46:28PM +0800, Ssunk wrote:

> Add support for XMC XM25QU01D SPI NOR flash.
>=20
> Link: https://www.xmcwh.com/uploads/974/XM25QU01D_Ver1.0.pdf
> Signed-off-by: Ssunk <ssunkkan@gmail.com>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>

This too needs to be rebased on to the next branch, thanks.

--=20
Tom

--9meu9ZaRuqKMiSx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXgSwAKCRAr4qD1Cr/k
CrqDAP9y6uz7o/eetbiQmewOXlEOZ/Pp59VrBjcK6/OnYpkw6wD8D6sOpsBVgRKp
g7rEM26XK1BxFMpJAR03XRgkmHfxYAQ=
=UrSt
-----END PGP SIGNATURE-----

--9meu9ZaRuqKMiSx4--
