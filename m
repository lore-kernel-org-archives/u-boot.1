Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE766606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OrbAX5yb;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jHkCSETy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CE69607D1;
	Wed, 21 Oct 2026 13:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EcwyK2ToNaZ8; Wed, 21 Oct 2026 13:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C882F6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588457;
	b=nIOxD39KPAu/OwMThGWKpszm6qlP3cwIa734bkUpeL8yx2eYTI0GSY8eYxcpMdBUcBg5
	 wnL6gcY1YE/yfbwJh/B67utt3BLPvj/zTR4mTzHj2GnlVChFpPDfqpRXaZQWqZ7acBUlh
	 QpdvO6SM5k4WekcE06XeeFthIiSk53cYf8YEUQ2wUaemdOUqr24klGWVCE0g28XE1Dx6T
	 C++WNlOrKSQ0XvXzwJiBELHLa5Vf9ZTFKDdznQQJNlJcc9+WdZAJ2HEGdux7/om57Tj34
	 UYt2T067ihu0wUpP/Y2uVBf3dZKQmy6PR83uI0W4D6o6L9OeNnUVZOx2SlCPUyYk0/g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bOYq7UKv3HZiTQOl8HZkAYafQU6IIpTe9uQjIphkp0g=;
	b=hYrYeGDtrz00ijVN/x6aZR3DF504lV4kLl/9fBj6FbGD+9swicxtrN4dydf4v5rXvn/z
	 pbryd5n173ZnUscO5PxcmUtJM9KHtY/NxSzITZCKZDS0OzSFEY3o/tWcQSffpQU6fJp51
	 dRVf9fGiFD0CGnkr3dCKfee1S+vOXM3SH8xWZpAE+KpOpzMT9uj7s8OWVfCQLaQllMvyP
	 sIjUzVM7PFChxiwRId2vS5KqTeuxnphqVko0z+umP0t13CdIhbx58y2YGPmJezsDPIa82
	 Qw2uKLfSghKdvHBuVz9OksVnRJajA6RrLn1MX/MMPPGdH3Q6oqIRJdLNkwFhP4SZJCg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588457;
	bh=bOYq7UKv3HZiTQOl8HZkAYafQU6IIpTe9uQjIphkp0g=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OrbAX5ybV5PIEsmhKsUsr6cEmwkaQZsGBNFl6QXFCcbTlko0kR8zXtXf5l8p9Mo5b
	 MSej9l8fQT/LDcR28jUUqTUoFENOxkUrhUR4PQPwnFOKdz9V7wSBWkMtuRYxjEitFl
	 IytWMnFxPRmzhekPzJ1nPlM64JjhYM+vDV0ORGqAtJbHpJUymF3RDDIH1D6BNbyXdv
	 950dmZ88yb7tcTamv79InV2tTUyDWVnGwefdQJTTbStOg+XuvGYjxOUlQW39EWSqt9
	 +7uVhU0+0kG2Xb7LsYa2aAgftbobqfhHRxkF/RGak7iSqO/8EkqUYYgVvyKcjdh7sS
	 IwRZNqbyqSkkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C882F6084A;
	Wed, 21 Oct 2026 13:14:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05C9B930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFFD2403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNl5L7ikeJkm for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EAC7D403AD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588455;
 b=Flz7Z74/mFPg0wxgfmsUvje1A6LV3CrN70RpyR3B9fYK90UvpJkE6rfshtAoBuEV1Xy3
 gEnHYtAyslZ+6gJAY2Nt2xxlkprska+NF0xFaJH/A2L5Nb2XaO17wStU4LISkhUND7gGl
 RSjLjZc+Tucyczt7AlEKX4ZtpkiEi/cDM2pcodwIaE12xlxyf6ls3D1pyUo2IMl/g4AXx
 yTpdupe66QDt3rVDiiR6NHwo087OAFDPZaMhHJ+nNoEjNDi7EupwntmxpsW9N6uDoaSfb
 2HIGmicCBtUMJxF7ANTa9LGROI/EP9IU7ORFTDgzRP9Dp7q5wzdwgdacx3dwxfMR/fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588455;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=bOYq7UKv3HZiTQOl8HZkAYafQU6IIpTe9uQjIphkp0g=;
 b=g/C7QkqUe5TTcCdk5jm+i5mBT782ZOyL1gLTfKbvzT4MHfiHJTwu2hmcg/hsriGaVRRl
 TRKWWUORgdZ7lY3XawrSRmKgnj1So8i87I7mKIVgz4Hvn4AEjTRcJSKAftyeztfKgYGSI
 noBWAhi+Jb61hITvOzCTuE45oDp2mmkdbaMoHXCo85Nd7F9kqkqtvwsoHZtwdxpUzlpZN
 6zKr7sDzQQKWqKFSXvE+UymTJ/4ec6g1w4+AFkwU6ZGK0xZYlQTD8HMuHaLxl+3Ld7dlF
 BtF9fPI/MRpNDG2E8T8KYFSh6Tsb/snv2gd7iAB6n42SMIgaBokk0LBRZXG8cc+1H4w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jHkCSETy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=jHkCSETy
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EAC7D403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:14 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so950721a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588452; cv=none;
 d=google.com; s=arc-20260327;
 b=YP1H6RxYHYhGC8IWNsQ5YT4zUksgTc0ma73UWx5FOMhSuB2XsP37ds+3lJSBvYzSqn
 3z4Oc2sHywiQD+PT5y2azwwnYxH3nwjFnaKCaEIoWXEbebBDbWRqSskly8i8JrkiHOBy
 rw7M6Wgpwu1KnlKTQCO7bB+2dX/FDeeYzoOkiZQGeTrS6lU4TyFQypcUzFJPwl9Yml6o
 xiulZ5vDX3MdAmNPv2aFo9RQF1ppW8zo3nwCtyqTooAwooIKyi+Ptp+IO7AVLlVGc6XH
 LpkkPsnwDJX9tLcWBvJsdehJ9P0031BJfarSCaFgEdnpDVehVUiM9tuzPE+oS7WIJohx
 Mbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=bOYq7UKv3HZiTQOl8HZkAYafQU6IIpTe9uQjIphkp0g=;
 fh=lFEvJiD09eFkjC0zjxFrJW8v5KPieVD3ZcMao2sBQCU=;
 b=paSk6KPgoPbuGy1qKIOASn6Ussp5d+hL/er7vwYmSGsZZW2M/ij3jiyDGeq6wcqzK2
 2Pcn1yJ/Rf3qmup8r13L8TAMKVHhhDx9VAGxvONrTzn5JgCMvUzXypRJgc9bFtwDrtJi
 M8Za+ddjsnzpiA9dBQvTXhC+1fZ/bzusC+B0QW8emTdf2O0sOzSEsTOpktGlwBFqxs8L
 IuYeewTWFrdsllyEzGac7AFqpoUJjh99j1dWyrmN1u8BvSyAHFfrYgVbwcRXYg6igzEC
 Ev27Ozclq7l7C3iCPE9KMhx0B6/g6i9Y3oSNFvO6hl7w/38TQ0UZCgkHeJSusKfAm4dY
 /MBA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588452; x=1793193252;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bOYq7UKv3HZiTQOl8HZkAYafQU6IIpTe9uQjIphkp0g=;
 b=jHkCSETyLeaFeP9aMgbR59G/lYZ1jBadBIIBlM24LK4h+6aEZeUs6iz3rA1LND7ih5
 U5bzW/1mtatHL5UEkM/wqCtc6q/OPs9W7mCBy66AvMzM6NRfGk4eaT7H7MdfyHhvYnPG
 AQCV+wLX6ROKpVPZg0nwgpJ80DBr4vKGnAJ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588452; x=1793193252;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bOYq7UKv3HZiTQOl8HZkAYafQU6IIpTe9uQjIphkp0g=;
 b=ARzB5Q6xJOwOX4ThJyntF6gMGa+sEBrVLRJDQnS4sckRk2bHSBNU9RE9ytIEolR04Z
 Nci91Qk70JpgdL4KgLoeeP3CO14+fwluIVmoF7oMoD0cW51dxwkGBk+dEon7RIUQMluK
 r3adp34DjPQPR7DpfYFwRhcmqAa0SJy5pKn0g2oB2oaTrn9Dd/VRuLa3nlwsSNZ6MF1/
 rjLn5rkqZJUJaHcT3EXBCYJlLCdN+kMdiGe44drl3rnOx560tPBFs+tRERj9crlR0ehx
 XRdlLWcVbK3GASFTXKlOYgCCkSCWAlg0H6nScAiVjDzOTo8VeVBwpZa9KD1uOJCcrYmb
 Eg0A==
X-Gm-Message-State: AFq9FYI3Yty+cQ5Eh8JzTbvo3ZhOwrFpYJSXmOCqrevFM8WZBpjyvVN8
 OK+tE1kXidvQ9R7t02QJoDn8EkLDucxHp4A73L+wI4iA/nO6fU2XtRzBWIYlbBUo6u4NBQhd/5i
 ViRM4dtbu6PJ3liJD9JhFkAzgQKtL6NFdiKSyDWmF
X-Gm-Gg: AYBFou0J8TArYuQCIM0UPSHEXtPuYivRKcbUO5t4oTFcpsdiYQqL9JO26Sf7dFSIVRI
 ZCPhFec32TQgS0e4YOuxZwIlGAqv0BObOmSLrvYZkgUiTKjlmd0TvklSnVZ02pPyWoH49OYLQbq
 xzyumC4sg91gK4jS58uLdIxATlK0NCtnqcSJmK4olcnz1KoUJbqe07jT3eSw3MEABiwJRWK9qD/
 FZDgfCf4Rv/BPshaQXF1f2qlBRTFHEck8kXb67PBiPl2FvN1bEkVif21v+7+N0RqdfKFuhQcAex
 NZjNGyM67wfML8RchH4P1RsbnF4/8s852Pt09tOazVR9zU0X0L7BUzprl4YZu1RhAeq20bZvKqA
 9b/3V2t3XPwEX1L/fEEmSLyYoBWQvp2a5f4o=
X-Received: by 2002:a17:907:6d22:b0:c3f:7270:10ab with SMTP id
 a640c23a62f3a-c4679607758mr174190566b.14.1792588452519; Wed, 21 Oct 2026
 06:14:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:14:10 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:42:18 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261012101054.2104707-5-lorenz@sigma-star.at>
References: <20261012101054.2104707-1-lorenz@sigma-star.at>
 <20261012101054.2104707-5-lorenz@sigma-star.at>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 13:14:10 +0000
X-Gm-Features: AclHuK8lXWv0vYqnyKTaiXrqjBd2-gWehn2HhcW7593-Du90MSHf0OnCM13-u4M
Message-ID: <CAFLszTio2h+fP_Pfrxd+UXTj0MFWbfqmPnMD2FtA5z=DoMS75Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] binman: pre-load: Test signing with an OpenSSL
 engine
To: lorenz@sigma-star.at
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, upstream+uboot@sigma-star.at
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-12T10:10:51, Lorenz Kofler <lorenz@sigma-star.at> wrote:
> binman: pre-load: Test signing with an OpenSSL engine
>
> Test pre-load signing through the pkcs11 engine with a key imported into
> SoftHSM.
>
> Add tests for:
>
> - PKCS#11 signing with PKCS1.5 padding.
> - PKCS#11 signing with PSS padding.
> - Reporting a missing OpenSSL bintool.
> - Rejecting a missing engine key name before signing.
> - Rejecting an engine signature with an incorrect size.
>
> Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
>
>  tools/binman/ftest.py                              | 88 ++++++++++++++++++++++
>  .../test/security/pre_load_engine_pkcs11.dts       | 24 ++++++
>  2 files changed, 112 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
