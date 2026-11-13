Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA326079D5B
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XVqF0QjG;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=V1BdLo7Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60F078110F;
	Fri, 13 Nov 2026 17:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id htekn98R29W8; Fri, 13 Nov 2026 17:48:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD5728131B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592139;
	b=L68KEp9xs/L4H0scI2ez7CTIHU4kM1qaiFyo15OibqHNYGw3Pzg7PyeWLl7quNNcya3P
	 43F6eJGd5VRNGikScKtoX5Xh9noholceA7hddjzZ72i+yy7xQUXprAmO38CLrs1lzcPA1
	 tRwocYa9F+bFxP80z9rzgh2W9rnHcEMD5OlQwbXr9yHHcHdIqqd/5/v+kDA4LWnkRMoD7
	 4+tUZ1xQjGdetn1+Zew4UPgXMXx6M666T9CTl2MjNYMGqSB1PqEX9BUTINbPyQI7j1E2k
	 hEa6Ij5rdhvqfl63PT4D31A+LPOEFNOTQY7mpskFOhCrEnpDx/DEQMFoay318f52Dmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ePmXPRKkzVn49AmAeGWIiQckrQYH5Ia9fBiQJVlsmzA=;
	b=VgRbihn45lb2neYhEysGC0sz+ukjaifGmbN4aA4WgdpP2JRbwJFxfIuYneK0C5iCvEr7
	 ByBntznh/4LrWK9j6+4SpChUSXhLdA3975XWyEiN3wmhBYOEDegy8ZXryoKobQ8nVDhRP
	 jD1+kpSk2faWvEf6iTOlzFr7vctaS73YC/TiEZMCQrsxrqpehVb5WDSmmfpAdOU7lVQsZ
	 87065S9QThDGwi6ZIKl8PUxtJECbeU14gEehnbHyzodk7PRIDoYk6pwj76BQxRz/xR7OQ
	 W1TzVYGqC3Tmf5QEwFxH1P9yp7zwQAav1pkvLC4z1C2KMlzoMck6l9r+EAp3rjKp41A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592139;
	bh=ePmXPRKkzVn49AmAeGWIiQckrQYH5Ia9fBiQJVlsmzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XVqF0QjGUKi4gcWZkxCH0xLYrC0zdHKxysvGsigc+KkiFs2fLxEPEFoWHRW1OG9ZU
	 RGhRGcRjzeaSP2P1gj7v7f/sRoPFGz1IukJMfRd8taYt23V0ifJ/tueMDVLAQoLVBy
	 Sib+LfTKSUQxmUsgTTGODIEnQXfE0YGOXuOD/+zRSX6ZycV6jC06soh9Wxc3rgYwO8
	 ywsDMffrCLXpoUVpyiZ8tSgdkdD7ljNS2Xrr9iJDDejg+FaK3lq4Ky/bDqcf+YOMqs
	 lK8waGF7XiZf9miPOowmZX/o5V2n73NlUSpREGU7BSfwCmohbQnoW+nShL0UGMEjgX
	 qg6sw1FhSQ2hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD5728131B;
	Fri, 13 Nov 2026 17:48:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D8542F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B866460DA3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1eT6mzh9OUv for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F102B60D6E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=V1BdLo7Q
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F102B60D6E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:48:56 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-847ac7ccd85so1441542a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794592135; x=1795196935;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ePmXPRKkzVn49AmAeGWIiQckrQYH5Ia9fBiQJVlsmzA=;
 b=V1BdLo7QaV2s7/diISDs4rlj/PoflrbUD2puRtLPGufxEIbLhSjbLUZ+O5NM0uhcLO
 XhwDni+JnCvUA5VovVc5VZkp2bnd99V6kaY1vOiWISXiz4letZv5htkkjL+e6xilCMHr
 q/DfxSZ4LjmGSSSULiWOkNocqIGe4OwUn8lC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592135; x=1795196935;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ePmXPRKkzVn49AmAeGWIiQckrQYH5Ia9fBiQJVlsmzA=;
 b=hrqTsaDTrOK8Sm7gi01SgeqmUDiKHNwAG3xg+j1TA3wGlbjkwJqz02Q6+w02P517vp
 J6Xsxz6Z0knTaOfj9FOPwz0/0WS0YSJJpcgvcgnjUTiWZvULZ8JUY4a1Xcs9mIWf3W/I
 W/XIcxj608ekbOX2xOyBfh3XEXi8P1ZEHQetw6CtYJxWq6RCIaHrcWkJvxLRHiAgcpYy
 z+WQoIjjHHK+VVGks39YSWUVMrPtxSkp2ItofIgVFNWTsD36oezK/RR+1o4zZ01rV2fv
 crt/TpKSV3Ymrv19wpNT5IumDu4Jk9upJ9uPwc0BxfqKwdgR+TT4ppPsn4PzbYTJbKVf
 gMHw==
X-Forwarded-Encrypted: i=1;
 AL+hErESJ12BsobszLdZgHVOG6LMZ60HaeA+/BHwPL3F8svbkHzARDyOYg9iu6l6J7fWX9H73ul1WMk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z98JfCf4J8LPLN+1aCq/YOjqSPI6NnAnHDS0GyOJzQ6V2s5Mthb
 X6fi8FGv823cdOzIQTTtt/1oKXL5rWxdVbAD2Zs3C9jsaoqQWUAgbnZ9R5vzy8Z9zU8=
X-Gm-Gg: AYBFou3edh8TxTnYL3YICwe9re6JaJrBeyZftgkP/ICyvbBdAmrCtMNOExttlZihEyH
 rYuw0cxJJ2bxtE/gXweyYac7emmoLU8CVF/JTwwjhfnQxH792fhMkUC3RE89pREFDUwBGDeS5gP
 hcACWDmRceI8dT+DZOVyj6reBK0wsvt6+wbCsEzR8QCKpYX6NxE2Ve9+N9NMuCuaXUNGoWwg5c3
 wv1o+SG57rGGrcXKnBmRM4XjjFBQCO6+8cUXeAVoTNzkX1NKPpn0/PzRKx+zg7maTcsPGFD18nx
 i1/MpwTZHvczp7RuekY0hw0cTk+i2RTvSAFcGkUYmWzRLfPrbNf+UWqBf0t0rSMwlMlAeWFUgcG
 D5M8wUuu92+aTkIwu9chpJSmroV6Jlq0SB19m3IRyChLW+v9nC4fWOHGhV/FNXHOAl6bLmWlehh
 UTpiDTlm24xfc2fdpDPGQfCrmdHHouO1t0GRFV8SK87HZAJaY3e8/c5KtX30pCXmKpsXfCLp8QN
 tnTISuZnhj+bl9LU1ACzfgB18GGpStleULcC8Nop4hYidMi5J1MCT/3FzGFz7aHVgdm94VQNkpI
 akH4G8FOlw1N/Rh4bGUJZTBaJkEIuIlu3K1+/r/SR7FQz+y8Z9ljDHiQbHAcqPK2iBCc8OUr4kb
 y3q+1u6DUVVw0SkBpIIgE1aGTE3ArOalLhhbeu+EDcRrvnc4DpsuQhM7araWAnSGzJD4mwN+raB
 rUVfs80LRA0qjmHtEKWtNOtFCtLe0Ucao=
X-Received: by 2002:a05:6808:150b:b0:4cb:f21c:a794 with SMTP id
 5614622812f47-56e641c9fe8mr2112039b6e.28.1794592135472; 
 Fri, 13 Nov 2026 09:48:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e6b195b80sm2676845b6e.0.2026.11.13.09.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:48:54 -0800 (PST)
Date: Fri, 13 Nov 2026 11:48:52 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
Message-ID: <20261113174852.GN554944@bill-the-cat>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UOQnxor6vEv6oV/q"
Content-Disposition: inline
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--UOQnxor6vEv6oV/q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 03:14:55PM -0600, David Lechner wrote:

> Anyone who has worked on hardware that uses a devicetree for the
> hardware description should know the mantra "the devicetree describes
> the hardware, not the configuration".
>=20
> Binman is describing configuration and not the hardware itself,
> therefore it doesn't belong in the control devicetree that describes
> the hardware. So we propose encouraging the separation of these two
> descriptions into separate devicetree files. In most cases, binman
> info is not needed at runtime anyway, so combining it with the control
> devicetree is unnecessary, takes up space, and causes DTS validation
> to fail because binman is not part of any standard devicetree schema.
>=20
> Currently, only Xilinx is doing this kind of separation. This series
> makes it possible for more platforms to adopt this separation. The first
> patches fix binman so that the image gets the U-Boot control devicetree
> rather than the binman one when the two are separate binaries. And they
> make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
> The remaining patches update the MediaTek Genio targets to make use of
> all of this.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

My more direct concern with this series is, who has some review cycles
to step up and co-maintain this tool? It's already been privately
suggested to me that we could drop the lofty "one tool for every project
to rely on" goal since most projects continued to develop their own tool
for assembling binaries anyhow. And that in turn reduces the scope. But
it's still an important part of the project and so needs some people
looking after it with a more global eye.

--=20
Tom

--UOQnxor6vEv6oV/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavdNgAAKCRAr4qD1Cr/k
CrQSAQDkGu5rh29LG7FpGIMysSDUEW5wP6YO8rfqB8jD+n5P9gEAk5y1WRAPLqMo
WW2O3qW3uyJO2rHrIgVfwCGgVxQJKgg=
=LVYz
-----END PGP SIGNATURE-----

--UOQnxor6vEv6oV/q--
