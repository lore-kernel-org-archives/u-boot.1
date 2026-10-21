Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5737606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tH4MVs7q;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TrPRudua
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7820B408CC;
	Wed, 21 Oct 2026 14:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-euRKYoW2il; Wed, 21 Oct 2026 14:39:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B9AB4074F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792593599;
	b=fl9oajnI+mnQYCWiKr7H3QCWdbEtDDIsBu8I1wNmjizQU60DFm/MiBbP+Vsp9Wk1Evij
	 oWizmzR3y8XuttZxd4lMnkoUoxqPBHEvaKE94tMpkzvpKZaoG8wbfeUSuYKMNVyo1aWiB
	 TV/iiYRULulTcOwjyKwlw5/Gpjfl34VyCP9YVbYJ0c0HKWvOHAl+JYWnep6o/CPzMCTg5
	 Loh+Fyq9J2L0QRLAoZfM00ffTFc3b6p/JhU0qcZbZy7LafZiXKhkw4zu0tW9Gqj5nYjK0
	 vC6ROAmfXd5IjHhEYMH6zCdoBsFAVnHCNzjH9pWhyUfxOa7FQc3P1F5ufFDV5GHto7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792593599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h42+maii6Q5hCjXNvq3DROB/BU5DhNexLKXjCUmJM0o=;
	b=Rw45lzcx+L6/RAlTbZT/cobJyQHdoND5IPM5ov80F2Cnt9fLF+TijaHR2HECjN6lhCQi
	 lvAra/eMe2nFeeXrb0bQxna0IsLynRk9a8iV0kd6GuiOvU2xkzJms75VZ4dhoKnexKuv0
	 5QPCqItqgUd46zPesGvzjE5Xh1aw8otxmsxeoVS2LaZoZO0gCK9ylGuTXgucy7/yIFMvZ
	 nKwLKcIpBSZ+1nl4WPtUjxApjDZgYuXtYeMp7JF5yg83iYZAP6TEDDDA5QjAj7Cood8IN
	 HYOLh0Sxn58U9eqgJSSW62jxHUf5HODG4V1zOu5lhlz+FbwbH1YvPj071V1pyggIWGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792593599;
	bh=h42+maii6Q5hCjXNvq3DROB/BU5DhNexLKXjCUmJM0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tH4MVs7qetvR8NXBS8SNJjpjEqe+GwmPOnue6lhQ9BVzBcHiQHiph6kILBmZcS2Pq
	 WexunqIyG+LekRuanD0mK0WuOlpatfDqLl8Rscm7zKdsnIKwioo0VjqO/ZUfXsn5Iq
	 N8nwXQi9rwGRzs1XBI1X/2k00hONGnk2WOzBxzjfrwe3tQaq2cyB2HqiROFGFCnLvG
	 Xb/E+Y1il4pcv0aTMY6A94S+K5+Oxz04RS6/XWJeY3RnOYgTFiZK53KQ5wpNRyi52q
	 MLg0xkl1Qi0+HLVda4c7zBqXd2U2hLMwJsgl9n6vSbGiD6Nd5kti/YKJPTbdLukT1I
	 QljzlbfSi73Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B9AB4074F;
	Wed, 21 Oct 2026 14:39:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BDEE765
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2260C81155
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1Z9AYzrSG_w for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:39:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 11C7F80D8F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792593596;
 b=UnPo+KIM3rW7WASHlSQJtiaIY2LsWR9z0LwuMXYDym/OoZFK1LF965keh044IZTAhg4c
 AJpsps7cxDFK5Dw/uLiqVefqjcMoUO9uvVp+b/ezuaKZlNvynvUc2gexXfZKNy+EU/aMD
 h3V3CJ/AxtrNNDuDOPNNnPf0IhwTTRKvRmH0lU9c3pN+akIQF/KXBDJgwXDU1kvuuALWi
 g+JUexr996TVEQenBOlnOGVtCTqVrPxii4Ut77eWwOEwVGQnOX23j9zvDANN93C3chbBn
 KhneRsVCrCOXCaKTWyvixza90xpzeCjA32kRFJP91JFEbK6Cdn7G35OkXLwYh+OQzTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792593596;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=h42+maii6Q5hCjXNvq3DROB/BU5DhNexLKXjCUmJM0o=;
 b=Gag8jyBjWersinTioJz1oQ24XoEQ7sSqU58l2MBLS3A57eGUI3fuIQ7SddkwJPrzrI3o
 cxAVGNy+8SwCJMi9HTHQ2+eN9WTRVH7oTlFBAiUfpXV/5y9q25eLBAlXOzbUud7wTEAqm
 di+jd4andoacjwZxRF43sEc12V7AdmtACieuZCAH05mHY4D80S9iO9kx02YKe/MaJqF4x
 CZQzOHwjD/9A04EbLf0pXoYJL1a/4DxpxK0N8PQ5l1vf9U1xHjv1io6v/LkMohVw1D/Pm
 jNDqA/ILzri30lyNjST0ylsE84xBLBIRqzfmmquifdAvVSz6O67S32z7E+zS0rDUz3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TrPRudua; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TrPRudua
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11C7F80D8F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:39:55 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-44cdbcd53b8so134006fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792593594; x=1793198394;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h42+maii6Q5hCjXNvq3DROB/BU5DhNexLKXjCUmJM0o=;
 b=TrPRudua3ffxeYrcMEy7eGuVwlwS7N7ZeL7LlfIO3o/RIW4B6oUQP+LFI1vjsgHlwN
 8vFRtWkA8Q1K+UkcmjOpSvmW3jtTY+aAl9LyPaj54W/MWA9CVK24iQF+MFEwUSD5VbYE
 IE1rEqfuEgJdX601yyYxPto2qCAeAGLCRt9Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593594; x=1793198394;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h42+maii6Q5hCjXNvq3DROB/BU5DhNexLKXjCUmJM0o=;
 b=pmPbvQX6Baae/YA+zonO3dwCzOmox0UGEArhOQm+9FAsjfEVaY0HV37eaObB7n9Ebo
 AEMa6HatdeUFyvIgL/uKrzSa19GG8/xks6oTQjpWWy8YfwA2Y2yio2rNaMCmtG5Z+yJE
 3wujH1etYi6JgoBNQcLLB2mfzaWt6QUd0cNzswx2qWzrJvX4v/NhCa18rv2L2gupRTC3
 PHle9ikTVCoaNZ1pnNu4giaQXLyXYGVItPnIxAAMU12mMqJMn2AnXec2GbWcmPshDKhQ
 vQnAa02mEhSLfh365k9GhWmnSU2TrceH1q87t+qCNmQfDqYqoJPjCTwutSJhDnJPYnvp
 JIjg==
X-Forwarded-Encrypted: i=1;
 AKwUvByy5GCAeuECZdVEYbT0807GDCNFwiIJn6FMgedFMuyCbEcIqDpADetmrwhpodPu8rlQQhKBTQE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK7xLsgagfBQp8DVrk2ZorH5QOHrbAYIirTR3AVhzPC7orZC2ok
 cQ7h3vg4oxKlAhw5ynO3W2YNkhrVb+ox2xXLy2DIEubYC+Yo6sJbXM+jE3cJ8YYwgSM=
X-Gm-Gg: AYBFou0p98vRr5ROCY17NLzDf5ofIj9OaPVU1b+EeTNnB2g93hMDTflXki/D6BY5lIi
 jK30hRiNIifT7WPGz8772nq4Ysfszx3Aahqgq40lCZ10N2HylMXUzEeK17JvXLde0Tm0mpC/Wh1
 +ruNjLn7R7TTb7w6dzeXocETXsuxOW51VjoUc/JoKYK5KX54J18yPtVdxtjOs22D3c65yjBJfV9
 3T6P0HlSu48c6A8wiL2tUxAn2laJt1lQy1XqSybtZA/Zqt1/slEv/r/fGeDKjLUpMZ2C0BS1BQN
 7s4k0E0bAnu7Z/vQwHBKrQ8OIbt62mNUVrFSKS82aazZnklgGpt226Sk2G4oHkEAuQINABOAe3U
 PmixpIQZbL1JoGlqYrPreg/E103r9HdaDpTIKdvaTfHkhAuESMkTf46N1tQOg5A3gqN16npEKFq
 xdO35q1B8WpThL2H5mccnYaWaXd+s3E9PDwUV93/EMUsko4StnMes8X5s7UJ/hUnbxWGrN1pBMu
 vZ/9qkoGzuG42sWp6xrfs/1y56yh8QS3ivZNqUJE+Hno0qwAQ+PbwxyhO2xVrhfOiFkdakZkyHo
 3QwPoKSLlTyka+xoFHDQ6xoqdWba+1RaqG/zDdIZHMUKIPJhOY30jUySCMR1r6L5bWPmVkx5/mY
 y
X-Received: by 2002:a05:6870:b48c:b0:48f:e137:dc81 with SMTP id
 586e51a60fabf-4a7dc2a04e1mr1397853fac.58.1792593594392; 
 Wed, 21 Oct 2026 07:39:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5eb8fc0sm2162795fac.1.2026.10.21.07.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:39:53 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:39:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, ilias.apalodimas@linaro.org,
 marscheng@google.com, eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/4] arm: google: Add initial support for Google Tensor G5
Message-ID: <20261021143951.GM720525@bill-the-cat>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <CAFLszTgb+w2mbsw-h0fHmqoVztS5ZNx2ZCM+R-V3gaJONBAOKQ@mail.gmail.com>
 <atiB14EfQYSo2g5o@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2csbOawgX46eGxvw"
Content-Disposition: inline
In-Reply-To: <atiB14EfQYSo2g5o@google.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--2csbOawgX46eGxvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 05:11:51PM +0800, Kuan-Wei Chiu wrote:
> Hi Simon,
>=20
> On Mon, Oct 19, 2026 at 06:27:31AM -0700, Simon Glass wrote:
> > Hi Kuan-Wei,
> >=20
> > On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >=20
> > > This series adds initial architecture and board support for the Google
> > > Tensor G5 SoC, referred to in code as LGA, and the Pixel 10 series
> > > boards based on it.
> >=20
> > Thanks for sending this.
> >=20
> > Please can you add a doc/board/google/lga.rst (linked from
> > doc/board/google/index.rst) covering how to build this, the BL33 load
> > address, the DT prerequisite below, and what currently works.
>=20
> Ah, I always forget to add doc in my first version.
> I'll add the doc in v2.
>=20
> >=20
> > > The device trees for LGA are queued in the Samsung and Google SoC tree
> > > for Linux v7.4 [1] and have not yet been synced into dts/upstream, so
> > > cherry-picking those commits locally is required to build this series
> > > until the next dts/upstream subtree update.
> >=20
> > One thing I'd like to check before this series goes in.. as it stands
> > google_lga_defconfig cannot be built from a clean tree, which breaks
> > bisection and CI. It would be worth holding the defconfig patch (and
> > perhaps the -u-boot.dtsi) until the dts/upstream subtree has picked up
> > lga, so the series lands atomically. What do you think?
> >=20
> I'm not sure what the usual process is in U-Boot for this situation. I
> originally expected the maintainers to wait until the device tree is
> synced into dts/upstream before applying the series. Do you mean that
> in v2 I should only send the first two patches, and resend the last two
> patches after the device tree sync?

You can wait to post v2 until we can get the dts patches via
devicetree-rebasingi and a v7.x-dts tag, or you can cherry-pick them and
include that in the series, once they exist in some -rc
https://docs.u-boot-project.org/en/latest/develop/devicetree/control.html#r=
esyncing-with-devicetree-rebasing

I expect Simon missed the cover letter where you explained your
expectations.

--=20
Tom

--2csbOawgX46eGxvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatjOtwAKCRAr4qD1Cr/k
CrhuAP9KvpNM97z3s3bEO2OMNoPdWLZObjmcufOyMjRCUDBUqAD+Mc6I6brBtgXF
GAhX1zZ24/j6DHmKoDIwKHg2i5JX/g8=
=u7Pn
-----END PGP SIGNATURE-----

--2csbOawgX46eGxvw--
