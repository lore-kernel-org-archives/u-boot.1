Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ED7C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98FFD60B4B;
	Thu,  3 Sep 2026 14:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gpoOQI8xLuC4; Thu,  3 Sep 2026 14:23:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1931D60B66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445434;
	b=ChIILJZdAXq8U5UaX/ySv9J7dUKl48hkd29T4KK57OTC9xv9oHX0haMNi5S8RIPDZWGq
	 YyxYyGjGZkrefJA/Kdn/noIK3B/h7D9MNBRGcVt6XFMbQIZz/fIIPAl6yhtjRmi1t2txm
	 ZemqU+CIzU37AO2e9ghL7weTePE8DOW+owZotq3yBp1I/EkIf53eoX5JR9M+44zbONCd1
	 Y8T4BhOb7YxGGnb+H6PtEIlAm0N/GGPNXz57TnTMXFavE6AIG7oQkFDnEx53eObGr4SvW
	 D39yB8m0DKhwFDUh0sNZdNVoyyIE979GmjUv7iGPB7Aw/chBmQKkvt48wyoOTn9Ahcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788445434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P7+/hfZN09WY1v4/PSnBSrfbB5szJzi7+XMi7TSITAg=;
	b=OZz5dzSUAtjRWb29i4u6nfw5E6DK5FfrTbjU+rSLUnH+UQCAh5PHq+BQITYGv9vH8+38
	 hH2QrrLffb8KY7D+pWbX+ioq1cnUdGvtl8/2/IVRo7EWNGwxeoI+GFJ84s9iEmVKWT0kI
	 imZStoqKp2XfGBq4Y9Ur44GXxiGmNzaN4Jdn3S2LUi35NQtwo9mdk+z/abBza/S0d15YK
	 zxNyaRnCjwGYvFlBuUvhO8BzZfSP5dtZ+hjc+6V+iNhxSJMH9Rd2fGo+KjuPfhJ3pELXz
	 L/NtjbyiNsUHLQ3mLGooqKbZ7FKttYZZVY29m/d/N4/rX6e8ShCqwGLPYqekdrwlcLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788445434;
	bh=P7+/hfZN09WY1v4/PSnBSrfbB5szJzi7+XMi7TSITAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/st440TEHXEE3Zy4dzUu+DdpRw+F1HKCwJ5kV0bOZMaU/6g+sNBGLBgrJFtCSVXO
	 j4JLSQRNVXxLtUFDRbfh8joRcjf5oOsTqU2vvocYDz9nvezabFdCtsvX9MWgEaw9uT
	 p3wFV1LwoMzZtp+u9uy+jBIQVvvcEeL9S3De+hte2IUM76Jx583a4hLzbBe8+GIkKN
	 Pw7kAoe5pEDCYL263qSUE8b6RSc+ifRL+KOeAWjInKj/lxccx3LaShhDAchm2HUDcL
	 T91Xh/EdLd+thWxKluPElfxWIPfVriwxZgEf+/zn3PpkylCXnbB23cxp/T05fV1ikt
	 mCqXrG/A01YRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1931D60B66;
	Thu,  3 Sep 2026 14:23:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A166E2FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8856E40755
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBNzHlVL9pFw for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:23:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CAF5640756
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788445432;
 b=IbXhtCL68xIRlPV1l5+RdHuUMUYAWqgbW0J0Pfr8TOi4yQ8zQradi6BU6T8B0JArG7dx
 +KoUwlFDXHLeOgAuHttG1ktae5Cz9MAUVwmPqY3KGfqpNjWJgxpaNWc8ttLlUMpAaeq8F
 tnE08W3ZcunAUHZndvevjtLQLp1k6z603zDOIg6GPA85ZTvQaWR7dTVoG4NFBxGWkdh0/
 +fa3SN28TOMWQCmJy6CsBimQ5KTPa0xS+JIYUb3s7P1y3AE69hLhkzoduZYAK4TKT0TOE
 PRV/d9xMg0JH0oXcsatJv02ZKxo2xc10Fbi+l+OWbWqyf27XYlAhagYwxdN5e9kWfuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788445432;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=P7+/hfZN09WY1v4/PSnBSrfbB5szJzi7+XMi7TSITAg=;
 b=G3MqNGo4gmdzQrjnhTF10dtQKCrC0r42VOifOFed1wVwD6ceyhNB16dSc0iONVHRG4oE
 oy5NvcOfXwTTQpL8hXnMl1mTolCMeNLOFG3/j5g+n2+Xfsv/ifwoiE6OioiMDNly06BV9
 MNPuRFlDv2kzHn9Yh0culeX9JQJEPdX9gR6ANFZJmTd76re6s1USZD5a4qMOksPEpyFk+
 wgLzTrGv2/i9/19b+m7WuFisUAhU8AeEiJVTstKG2Are4YUPTuo4Waa79stqkyt/aYKQr
 eT/Qt4zVA8saUDJrfKjnA2lGrchwn0e31Ie0/QXIUCLsI5NjtwI6T0A3Us11h7W0jEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gvPSYrgk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gvPSYrgk
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CAF5640756
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:23:51 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso2200725a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788445430; x=1789050230;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P7+/hfZN09WY1v4/PSnBSrfbB5szJzi7+XMi7TSITAg=;
 b=gvPSYrgkjhfb6KzOYFmof0o/ZtlhawmFqH+/fGexiRHnNe8Jq0WRb2Zpg2S7ku5ea+
 uGz+woxDp7xynHVYA/1J4XgPh925le7zXwK43LA/8OR1IlyxlqEL71zfteU26pX7kUz/
 2Kx5osfCPaeQ2Moaw6XeA2Cndt5UqhUKdGnck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445430; x=1789050230;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P7+/hfZN09WY1v4/PSnBSrfbB5szJzi7+XMi7TSITAg=;
 b=LN2udi5oA0TIa9wsjDSqukWn1ZVv5XmjCz2p17WR8o7LIr+RxSgnIW6UBvqRpcrib3
 PUxVubQIK9blLiOwuDatD6nDHg1sEb1But/6eSu/6JUeb8OXqJRWmPGwblfeyJ3qLMgI
 llfILBE5bgNfbZ5Hr4Wb7folaKHZXk5DKVhqgSVHRtlTVJMxJK0wEaZW3DyPXTNqLyDl
 8HuVVU4TmLZZXOkYSNXChXvuRRVNKQQfKKLZixDm6iRlUzzWnD88nau6U3cODt1ntYCd
 BUDUtUYjmoroeDm5UvGskUcJ1yMFsJQO+vMRxQzNDqMzQI1DHGElRkL3Y+6OPOKEBYer
 4mKw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBLX2I9bz2sx3q9Gy/lY4x0h2Warf+hOxfkDY9wu7M7H8xu0LGqirAwvmOVdG8feRxWH3B0ec=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lGlE/KLcksTKPAYm3pfT/P0D2c4ppO7aYE6iFAVBdN2DhvK/QL
 g9FMbe2Sn9lnx0kdneN51RJ8vAShuW9B1AuvACBlcpLuup6nDaNzPLY0+uN728uPu8U=
X-Gm-Gg: AYBFou3Q0nZePV4iAtACblW7pD5x2ITAk62jgsBCeM7RL9uce50Hcf58F01o/9JB6Vb
 3+r72IG880fvd4LwnA2qzAlBJSKkgXpuKNmc1Q4T4Uv8tdrI7vnz5Z34aCqn5N8xt1e63I4pt9a
 ubuTw5gxwCjoprgHus+vL2Fp8IQB6dY4FEhnG8YqpH+RXBK0znG81jlYktrpzJr7D8KTfFjywSj
 grXb1ij8Ify/l9DafAww4cC3WVz/PhToqoPyI4V5OOIA1B0sY0ZTazWzOuCTLbLNa+Taky3FSfE
 viQDG/T/f7NsyTUzsAbOr4ey+fucGPYXSC5iVp8QFTcmp5+P/ldMOs0fezQxFymGK+H/hBnDeRj
 5zYOS/G/pH4MvoW7ou8zHh0a7SBgsH3/W5y2WaWa37FHG1NI0mWeV9dVXYtbMPjizQAlv5yKrrV
 5kBoI7HpdVHFku5keFc95r2i6yqvamy0BX5u/jiqfWXk6Bm38Yl2sVyh9S5pK8m2fFL6bq0pujI
 FSR+ILD/X7lzfXwKEYHaY12fklx0ZvdC/MZ/qwjt3wqs3yo11jB83K4Q30Oz1xfuL9Nw8LSjHdC
 9zE6q9UZow==
X-Received: by 2002:a05:6830:2a8e:b0:7dc:c4ae:a679 with SMTP id
 46e09a7af769-7f781489612mr14480588a34.9.1788445428561; 
 Thu, 03 Sep 2026 07:23:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74f3e4a98sm4631267a34.18.2026.09.03.07.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:23:47 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:23:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 2/2] video: fix build with CONFIG_VIDEO &&
 !CONFIG_VIDEO_LOGO
Message-ID: <20260903142345.GH1764417@bill-the-cat>
References: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
 <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-2-18c22bdd9f2d@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eA6aTxGdHp3ytJUk"
Content-Disposition: inline
In-Reply-To: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-2-18c22bdd9f2d@baylibre.com>
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


--eA6aTxGdHp3ytJUk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 03:59:35PM +0200, Julien Stephan wrote:

> Building with CONFIG_VIDEO enabled but CONFIG_VIDEO_LOGO disabled fails
> at link time:
>=20
>   video-uclass.o: in function `video_get_u_boot_logo':
>   video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'
>=20
> The __splash_u_boot_logo_begin/_end symbols are provided by
> u_boot_logo.bmp.o, which is only built when CONFIG_VIDEO_LOGO is set:
>=20
>   obj-$(CONFIG_VIDEO_LOGO) +=3D u_boot_logo.bmp.o
>=20
> The only remaining caller, video_post_probe(), is fine: it sits under an
> if (CONFIG_IS_ENABLED(VIDEO_LOGO) && ...) check and is eliminated when
> the logo is disabled. video_get_u_boot_logo() however is an exported
> function and is always emitted, leaving the reference dangling.
>=20
> Guard the splash symbol declaration and video_get_u_boot_logo() with
> CONFIG_IS_ENABLED(VIDEO_LOGO), and provide a static inline stub
> returning NULL for the disabled case in video.h. Callers already handle
> a NULL logo pointer (e.g. bootflow_menu.c), so no caller changes are
> needed.
>=20
> Reproduce with any board that enables VIDEO without VIDEO_LOGO or
> enabling SPLASH_SCREEN (it disables automatically VIDEO_LOGO).
>=20
> Fixes: 0d3890188d6b ("video: Add function to obtain the U-Boot logo")
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eA6aTxGdHp3ytJUk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapmC8QAKCRAr4qD1Cr/k
CrS5AQDk5RCBXil21MVgAVUs9r6txLpkKfbwCDS2DSjQmawBrwD+I1nDFjFeYeR2
kt+FLGPt7FTWwEFbVG9V0XZH/P0wswU=
=kGHT
-----END PGP SIGNATURE-----

--eA6aTxGdHp3ytJUk--
