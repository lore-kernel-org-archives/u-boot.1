Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AD606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I3YUn6qG;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Guau/Nlp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D8B860AFE;
	Sat, 31 Oct 2026 09:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsEQlsyKCkJO; Sat, 31 Oct 2026 09:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5286260ABD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439279;
	b=WirBZ9dNNhgCdrI2UAbd4C4REDogvi1m66MSkT4mUp5ccjGJfX1912n/SFA63AYFXPie
	 oSEY/2NPqPzy2T8V6q17rkYh+6vrNgHwcJ+tljHK/azqWi2vSbMpy9Umf4nOrtiLjpzic
	 RbmMtwmW4iA9//PbG7N8gYvN1rnzbIO84LE4CzczANOsMvC3Wqli3hogsqFSYYjF7TXBJ
	 VUzArg5Z4/7ZFeLnDsqkfRN4XFEvZ8myarNlA6ha51d/VXlSGX+v54S4FesaPk2a2h6lz
	 BInuaThOQZVGKoiPuFU1ma3rncFYaEBr7u+u0ZbIso1DVJLjWMznkvz6itANtuTvmOA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fBrCehzA816sh3WRdzGhzbMKXTCtbJtUHe9ZiLgkyRM=;
	b=J9AVmF+CPPGktD9S5X1uXeTtKeQ0FaJzaKhla9NOZi+ITrl+jyyB04vhqaj3wsNiTFM2
	 ASYbopojw6aB5kPBw3zkIM0E+TjXrmRM2mUKsb1pdRHvVWxjPaM99TrmtRjg7srzwLNdR
	 9zDJEkgLs/XrxJ5FRDuMF1p3F6H0QLr43/B3Xbba8VWB3A2+iHDIb6ie2mqrKP8tkbr7L
	 7UiPTKwEQGQWS0nt1Io2EUrkOTOWQV/NY0SQQTCfbBJq+FTZIStsIgMZgSA+GIuPsZiHH
	 wxS7WsADJhm3gZkz2vjdYyii8HmX8JKkTgEqt1/N5Na5u+at5WDPIYmBGHRQxwS94Hw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Guau/Nlp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439279;
	bh=fBrCehzA816sh3WRdzGhzbMKXTCtbJtUHe9ZiLgkyRM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I3YUn6qGpdKLuBTLevbjwFh8WXZAxPDkPoxua4wv2XH+fJNuZ3T9HYGllZ+e1sQZy
	 61pbiSrqt6rzxhdIOuk5f2juNjNWNd7SpSWflazYNeSnzeEIDHI+g3WnaMXW++mNht
	 ySaE7wwAwmNGROPPqRoTSyKqWo852QM4psj77PFBSYZiis0qxyq0HRF6C2D04IH7l7
	 K4TGUsJ9QtfTlsfW0v58Lw7fehIe3L6OvEekZ25ivfiMPVCZlGs5Vt+Ga8SplfNbyE
	 zcwk5TgolFitBDepwvvDZUBkhbNkacZQJUCAQJ/DIHE34/OTdxVMKdHjErwLbmPoUX
	 q330u5JvEh1jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5286260ABD;
	Sat, 31 Oct 2026 09:34:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BB024BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BE8660A88
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lPrJAxLBtpc for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 928BE607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439273;
 b=D5BBVwafaY1bpIvBqy6oOcNU/BbjCWMS1Pk6fz2ZrzpS3oox4ZXjFYFr6ZJFZwXriqjG
 W/Dtq3slTZLOB/LwlAon9sYzFNRXtkjl7lbHlQA4X8pL31fs30ezft5S5Z3lzzTcXbQWN
 DmXtuXOrw/JuhheJ9P55Gub1XCiwRb8GqWlkFTzS+PkT45YTH7LmkSMnqIvPCr40CMqbG
 x2i8W7ywumAWPDyeZ8VmRLBZKvDJRHwtB/nbiU5yMAGa6q5fMh2n4nk2F3UelREitSLav
 MLwlNikiAJx4Gj7i8IOnXCY1R/6R7wdtJGVXw+sTJYDVoLXhEnTekVx9lmJ7BJ5ybLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439273;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=fBrCehzA816sh3WRdzGhzbMKXTCtbJtUHe9ZiLgkyRM=;
 b=FZU+OZ2SC7d+IcKX4znpctcHrdrtRfAFoziy53RG00kAltFIPXWmUa0D3pti09N81Dnv
 Fe/4G8oOIYrESYB5L+cyVuf65psg/0jiEvGKgljqHQDriAzaKE5AvIZZOunvOruQR0O2x
 xLHkY79KQz854zu1qJo7Ox/qLOBg1THaIAE49nXTx8S3snpNSSVQ+HxfmStrpUUZ/ENXK
 tkcxzlJuVxn77HVZPiZ53UExT1zUFhTFJHZhguChe80j9BF7Q8boPZq7YCsA+0UGNevbx
 BNOecZJDmEu9J3JcfD5tLvP/gvSeTX63CfP+JYlVtvUTK1yFLLk067PQguX3ck/p5QA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="Guau/Nlp"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Guau/Nlp
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 928BE607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:33 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e942864693so8477035ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439272; cv=none;
 d=google.com; s=arc-20260327;
 b=jbJZNh/YRmfsbY2wd9O6H064BMBksgoAKWJb4wLCEDThIsBHmt4fKrZdFdDyZSvUm1
 0DEVpWj4J0lawwGx021v+Qt4B6ddt3ysKzNC0ORhT4HNTJ9coqt7b5DuwAZmGiC8hiCE
 7bDTi1JLNzoZGT4vDpyOebfA2SijOJVJ1xwcrtNqudFpYV1Ah/Js80GuKhekOeFzmRaE
 xzqbYVpwUlrPNKOhFVbkIesUARtfW3MxD0pjXgK1ZSHazpRjJ1k+WnZQfkWBWNDG93GO
 22VgF12JqlTm0A3dUd9SSCs7MIB6tIg5bZPQIf5ITgQQcOooc40ZJNJnnJ1toJ9aqoNN
 dCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=fBrCehzA816sh3WRdzGhzbMKXTCtbJtUHe9ZiLgkyRM=;
 fh=1BsyDM0tF9l8HcVUdoJETElzcrkLzFQWdduAGD+evFg=;
 b=g7l8Y8M9grRNGYfvQD0CwyDEbs64Rq1sdsjMmY739DmhIiP+Yp5fQZX/wvYhftQeKd
 0NF/48j2CJI0yBvVPNKW4Tblbrin5o6UID2jU2NmEdVtmLJ3fBvvpyevJK2gyY8d0smE
 GCXKbsnktoHcXlGiTjywoOtfYjXkkZdsVPa979Zs7BPsBrQg5skkw0R+RlTSMs+LXEbI
 iyZmEU3wXsETi4CoJU5M0s6VSZBSNIEo+n7/BsAYHcJtsAqG4pPm4JKR5kJsoxWHx84L
 S0XNqWisDEhJHJ9uAW/x6KJYRDdijTWXwjqHoF3Gfa37nRUtqbJ4boBHQuI30b+/Yfvf
 LwAw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439272; x=1794044072;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fBrCehzA816sh3WRdzGhzbMKXTCtbJtUHe9ZiLgkyRM=;
 b=Guau/NlpI99OqlxanfogVw9L5xoIPgi5qQJjdpHhfA2u/kxccoL8jbV8LTMrC1NDVD
 ctV6DC5EgVnRMeeq/PEmuYkNN0mOBAvQSiKqpk7TfEWhC5XzBP9nXEIBiPe/sXct3gY3
 E51jK4UGEVdJzF1QpX4tU1ZBT8XA0io3D/ywI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439272; x=1794044072;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fBrCehzA816sh3WRdzGhzbMKXTCtbJtUHe9ZiLgkyRM=;
 b=Hu9UIpbNudH8qvZMsyTaxnjk9tbO6WsuGn79YqdSKw8Y2SADn+tly+cYTuNI+T+N2n
 M/T8+vTybqNpvEAskYRo3TaUykio0wUcsthpEhVbfy1yzI2H8sxIr5kKOqjWl+Zrx5C0
 eG55VQHaFgNXrml2tMoYzPhDXmDa/RpyH+VaYpaEzwvh1SZX9Iky3w+WRSXRwV/JtuSw
 rEqm7MvZZ4lIg2JBUhUXdN5xvICvOe8YZfNRu97GK4CCPw2KqHWtVyrL3rRrtpml6Nz1
 AIHhkovdAFdmb4gSTzbSeLvFj+nUXgJU+jgkNCJKiTiyMUXoGUzFAxXdGoZ+0uYeQbTj
 b4zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEbTP26FfmZDUpe6AEfVN+kHY3wXzDhhc1KMaUSkckYXCWJ06xQ5f/baHyg/XHSUGs7GbH8L4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIioHzER1hVHY4+qtVCXxuk/uEBFTj5JUqwOJE+CoW+dQgjJpzQ
 7PLB14/1WcyQo6voKEOk7zOuLH14gI6opZ3tb2V25jS4ln2Orm5dAs19J0w53xSLdpUSHJ5X5aw
 lgtTxGHi7YAi8QGjmzi9kysL+brRpjnxcmY2uQVFs
X-Gm-Gg: AYBFou2H/ox93Wio3TEf44rc9vqAPnHNwVLR5UUoTzmoNFro/KSnqmNVECU/tw6pKgU
 0LoInO+aVrNUrQ7vsoj07qawXIMJ0l0qWzF2chZ0a1aOo6uOk6+roNjevv/mUs2RjKxA1Q2dsgQ
 J1LBFfdskDtjAbdm+jaSHkXrXas0lzQB134mixk20teImperowGX7w3Du6BZvo6ViRhc0qGrDC7
 h6KR9nt7tzbFdCIhTuWRxc+8FwdGc+x+nkL/4KxWIhIXq6HnHE+jYv16aytDpWzXAivpPfzb2Y8
 YvFYXWqEZ/SNay5tVJVdA+XtGnl471K4jiIvoutcjtx1Hldoe4hObgJ5ayLPHog9yW6HiRnSDdP
 2pT0Sg71pelpB+EtdsGAX4svlfPqiBFF9zLu38vzrDE3kP+e6HDMH6ecWxTx4KB8jBOUw5oo=
X-Received: by 2002:a17:90a:f944:b0:3ac:9c37:9426 with SMTP id
 98e67ed59e1d1-3ae897f57c3mr4117478a91.31.1793439272558; Sat, 31 Oct 2026
 02:34:32 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:21 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:09:09 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-13-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-13-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:21 -0700
X-Gm-Features: AclHuK-8jdKKImVj5OBcM2MVFAQ9mXscJcAYL61hQ3Vz3eM_GqI6XWAPO-URAMs
Message-ID: <CAFLszTg-1hrwaE1UJx4c+sFS=D78SwdOzqfu8DPaKjU3NFLy0Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/37] clk: rockchip: rk3588: Use correct PLL rate for
 SCLK_UARTx divider
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@edgeble.ai>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3588: Use correct PLL rate for SCLK_UARTx divider
>
> Calculate the divider from the CPLL rate instead of the GPLL rate when
> CPLL is selected as the SCLK_UARTx parent.
>
> Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3588.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
