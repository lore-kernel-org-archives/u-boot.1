Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97531606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Esa4hIQX;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Bbb51IqZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E2FB80EB3;
	Tue, 27 Oct 2026 19:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9w-Y6Z51sAD; Tue, 27 Oct 2026 19:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B567780D7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793127932;
	b=j+D2El4GLnytnYj4IM2daTnd+m12KscRNTXge7x7CneqpKkmHrSrHiwRP4nWsqE5pi4t
	 AWdYPTXL5WQTgL0aAsqx6kdQgu5D3TrRTOUtW/dIZBt4plukgDNl7O8v7OBtPkM9ZTQGu
	 skDvniJIjRVKFPhi8SfHsBUZoVwhDwcC8LRKfvHClsEKSNONA6eaasDp7l9RbsWOYHeYP
	 Hxxpqj9PlQWQ4YVN3yXIjek4YcyOyEUYc7/DVRVHt/wNlymAqfPozcmuWzgdgjSJm4wat
	 9JachNINUJd48KLzpikLAZhnN38ygoTSwzqgR58WRv+QHm0k4JB1QTimFRcU1YWCr9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793127932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rnVjQ2P3Ru4QdhvOHTC7svCYOObjaP4QP3fY0BXDdXw=;
	b=KwvxwAuHQMem6CAY6mlT6t7S5lHVepBxw668YT/OVrl3Qqwy4Us2bpKRmY0JLSdmZ7iG
	 WypasL0EDKLYho+72Ggw5ATo/RKUjtbveUXyJGU3pfpUJy5TvypDVHQV3eeOSj5VSGjG3
	 /lvKLSue4CxncBcWzyzy2/SL3J/byHzp22WUFuKPx47yG8jFHpdhxbH/wKbB5m53jVo/Z
	 Je0V4bcxDBho0OyeyOQoGPBRjBNl7Nxc1hrJbKuyeJcX1VIcF0JjzpCmzsx0kFkTttv3o
	 jG6Kj4xuP6xcDeULQatAnDMtU/wrWVrQpsjP5EwTzgft6iVJfhEX9rpw+9QBBDzTy6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793127932;
	bh=rnVjQ2P3Ru4QdhvOHTC7svCYOObjaP4QP3fY0BXDdXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Esa4hIQX29ePY4HxHiFLwpF0566ushQeBJhTw+x8C5RhBHZqoF3hz1W6YlJYl3ozZ
	 79k5BBJxptjRKHUQn1JkbUtVRyXy54EjhwolT9ewZjZq1qjwa3My00eRgIM8wrO/pF
	 BjusURaLqScJpfHcI29S+3ujaIAySKAlKqUtVYiJ+8/EF+58FWP1qOa3y4L+ygC4wP
	 BJ+bSlUogwbgrSmBQJFjtSaftfzbEtp6Jts4JjVHDFVZpijqlWFXJonFecwiUPK0O/
	 EiOzDbhR+LOccHByxHIDdpW/n6z1+aTIFF+dKDRzJi2aV7JleJ058DNaDqFWJv0h3T
	 iR3dE16+/4LYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B567780D7A;
	Tue, 27 Oct 2026 19:05:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B72A279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DAB04016B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Ob-jMqBYhQ1 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 19:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AAB1F4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793127930;
 b=nxdopeTVN3fasKWmNjcCiHvh46Qd2szA/ekp8MHth1ubnmSf0fUjZv+I1zVYCf6O5f6j
 16D2ZVoKoGTiYWmxex6Gndmh6ZTAuWKlUkvKKrKsR9Inb/uiocrVVCuelBECpysl8IZjn
 MzhMO3Fr9bGZcmaqELyC9sg4ignRb4kEQ7m4J3XvKoNquB3XMD5xZD90JEZ6+eAnq/U0/
 V3kd6ohfiDy546VFYfk7Ojoks+i2fHoagcaw/ykihRs8nsbumFhwohVxAhA29wPXi440a
 M134x17kgkhJrwEME58qUC6cxBFvXdEMtaQJL91xlvf8K2+YoNvOi8s35P7ZW2LkWxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793127930;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=rnVjQ2P3Ru4QdhvOHTC7svCYOObjaP4QP3fY0BXDdXw=;
 b=SY/snjN1+ccMK6ZXyDeHyKE+HkXv+wUcBwN3qYxvQu1t0g7O+9brcamHyNgwztlUOVXi
 o3xS/JKl0AN05AHFlaz+lKy34NjhcDH5NI4eogUV1ZqSM+sKJAHTXHK98lZojwspgFLDx
 4ZYTKyzD17Rzea4mCygGRcK6zeLYz/8g2cHT8d1pCqkMTIZ5ZCefKlK6BJ0fQfc+tC3B5
 NXHn7nztZNiha3JPJLYqJ2Y4qeLPJPDDW41kOzG8h0xxKAbox0Lf7cX3qCBCeVgl3SY4p
 gXXS2iYBGPJvPVoDHYx6u50CXwbPU/XHTdVpwP0fZSJUkL5nxe/UJH31hZixY2wGgAg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bbb51IqZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bbb51IqZ
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAB1F4006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:28 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6f5a0893610so233109eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793127928; x=1793732728;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rnVjQ2P3Ru4QdhvOHTC7svCYOObjaP4QP3fY0BXDdXw=;
 b=Bbb51IqZY5qA/knb5BzcJ3GKAAYvbvj6SAwHbJ77UJ5UnIF5LmReDg7g+I+pA0uk+6
 PpgY2XpIwIFNscN9lNhDzGj1pJyP0Glmsmu/GV5tyrsWdQQvWvbsI+hhc2733fKE0aVj
 EjTxFHjyxVdhvd2vsv0xHY1zinmEZ+JQWm3YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127928; x=1793732728;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rnVjQ2P3Ru4QdhvOHTC7svCYOObjaP4QP3fY0BXDdXw=;
 b=JTiJTK1ATmwL1Ltqrk8Fbrj7J5YvVTkvn3oV1cMLfCeHVQ55C3eFava2NtDG8em1qh
 XiQzLyhCBpsCNJuptFvNsMfvbaxsqWrvyp+x9jSZDDnurL3OOYA6TaiECCnXWbovrbWg
 qffjyivgye5QxYoae/Ldsar+RV6cT1BUDTetdwnVV4BxgD5V1y43bL+nN4sJ7r81MZ4I
 p+9g8vDVNfrgVuJaRc/OIqG/MzF6c51HL0u34afeP+8JhKzRty8TjE2EfTvcdF+YR6DF
 mN3sF393UfLD6FkH83Ra4xUy85aGz8N48rXjMhgUq1fvYeDFt4jq5Nm0+sl011FEfI5a
 paRg==
X-Gm-Message-State: AFq9FYLW0QZS2Ao4/l3yQRGVB1rEgxX13O2/oNrjqBIsWSoyXJdLkkkU
 0+oO8dIppiVUm0oUeefx2GL7emnY917fWdI+je/G39+xlU1xwyfgk1ziYKqJdVwZ1NI=
X-Gm-Gg: AYBFou2pffF1bUw12sLTiD2i5d3aktD5xjxECS9I7VnDGVXdEsMoA2XtiRyz3t9KMS6
 lRIDasC2QkaXzNYdxw7u98XASAmt+kTAQCwo4XptxNXmHiesEkczyuKsPVq/vQI/qutwohfD32f
 f9u/mH2GQjpFC3WQ+CWdfN9CodbgmImG7MA49pXhE9pDMr7lpriFq9y3AH7LTleJPxmzjgEhlAY
 C6bL0dRw0WHiYzmhl0ljBi2QoobmLwiynX2l/8MUdRvCuwpNpyF67/6uNGJqaV9hLd2k3wXwJ3W
 D17YvVNLYSF7rfEme89lWJI+krvn7ZGHN8IMtkG2JU/fG0foiaO+/OVdNiJKs/ezbZ8piJmrAfM
 xl5nYCVOxZqGiXuzxAEMk0tQUhL/j476pgjSuTGtPhFfu8bSBWzRvgmHu7iyAH86cURMzqR9i69
 uyuEwB6U4ly+uJrM5f3P625Rm4flNhSbFvEuz16A0gPZHCzNR9Gzut71TITTTIV3SQz0cQHzy3X
 eEllshqWVZX5GrI98/Rqpre6Z3d1Fxlu1FTb3d/Hv2YeT64gPsdU/5Ie/6i404Dtd9dadwPlD5A
 /THwJhtcAX4BMZ0w54d6OOaDVpoEoGg1unVWHY9egVZrxam2O6nK+OrxCDmn0gsFJH7eP4A69TV
 G41m2TubJDQvC8kNeN05N5gJ2jJdZ1peKQVCXq0hsFFkPw7h+RAd4E1APLRMx4TyLjkFTAxHvGc
 Ic87s=
X-Received: by 2002:a05:6820:1381:b0:6f9:2ab0:3329 with SMTP id
 006d021491bc7-713ee08a839mr21389eaf.31.1793127927845; 
 Tue, 27 Oct 2026 12:05:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9df06ef8sm10291246eaf.4.2026.10.27.12.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:05:27 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:05:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Vencislav Atanasov <user890104@freemyipod.org>
Cc: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH v2 07/14] serial: Add support for S5L87xx to serial_s5p
Message-ID: <20261027190525.GL2177077@bill-the-cat>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
 <010701a17a6cb643-5cd1313b-806c-4624-b87f-1b00f80c8dfd-000000@eu-central-1.amazonses.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nvtubVU0m9jBjHFI"
Content-Disposition: inline
In-Reply-To: <010701a17a6cb643-5cd1313b-806c-4624-b87f-1b00f80c8dfd-000000@eu-central-1.amazonses.com>
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


--nvtubVU0m9jBjHFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:55:07PM +0000, Vencislav Atanasov wrote:

> The S5L87xx UART peripheral does not support UDIVSLOT, also it needs
> the NCLK bit to be set (clock source selection).
>=20
> Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--nvtubVU0m9jBjHFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauD19AAKCRAr4qD1Cr/k
ClSZAQDu2l0zwYZmXPWAUdyqayG7aqDTwRtx1OYCZrj6MoNFbAEA3AkFGjANZ7TW
cUH+Kw5G7K6gJ76q2HQDtOnZ8jGKTAM=
=e8Rz
-----END PGP SIGNATURE-----

--nvtubVU0m9jBjHFI--
