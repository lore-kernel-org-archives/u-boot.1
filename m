Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063A606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OppK6orm;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=hqVOnSal
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 336BA80D15;
	Mon, 16 Nov 2026 17:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buz276IfozKD; Mon, 16 Nov 2026 17:22:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 522BF80CD8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794849736;
	b=ETgGybe3clRnlllonlIb2Kd7EV1KA2CgLeIej6V1WGC0MC+X3jGHF7Fm+WuxcBY9vK5u
	 1OX91m98lgtjpzdmAiMnBNPrKBinqXXzvehVMrYKVG3W/ZilR/yV3wBloJl2oww6vusYh
	 xz+m9bflMTyKZOZ0tGJCv544IjpQ2/wKlcSHuqINXM/s1wmOfGp6DPm8CJGcAMez/SNuE
	 uGGMmN3Y883AcRBv+U4hnWC4j4wSk29tINqBjh/5t8LLtlRHICGtmbWeHfYoiJHvFMxtw
	 nmxs46ffnKG25Fts8+5INf43sd0IyH1HEs+aAU7PNIkJdCkRCmIcnamlMAn7hlAkOeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794849736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vLR2CF91mGMvhDFXHzTL53JOfEwjvmiDxF+2aP/cyDY=;
	b=OrZ+kyedDDJthQoS1bmTiJ2yciIGjFzooz0W5FeW0UvGHvFvGA4Z1pL2NZXan8cukmDi
	 wEo1Z6WVVVQhamj1BGgb+UUAqRdw+1yqhu+wgHORhL2m3HiKXAhxnr8WL883Deo8suops
	 M8oqnhVznkM5I29LIdHDWt4AxjAkg6ua0ElsZOFw3F26Yiv1ntY04TjyRsfdLnWpc1kGO
	 +GbkzlNUS6YXPXu64djWD1uVFGkHEw0QXCh0KaibzsazhsXNm6qHs3bfoHNiamSvPbc08
	 ds/d9nRCGnHvQ+E9wSS9qOUUNS7nUSnCrVXfAMViUUkMZfBALtnNqJoV63kIqeajGBw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=hqVOnSal;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794849736;
	bh=vLR2CF91mGMvhDFXHzTL53JOfEwjvmiDxF+2aP/cyDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OppK6orm4YNYpCxgUxydBpFubzikaKoM6ydGD/mW1+MIFoS+xMpLjK3PhDlrVvfKR
	 wCrQvmsPHBsoGUR0wvgJIScX1apaxDs5bvz99Bxc98emThqf0DgMi8wJs5na8LyAv3
	 2yGl49lxY8C58+dByOs3pN2ZG7oo2OOjAkcfT2l+s73KJH/TbZb9eDCRoaiKI1f4xB
	 O9CD1GKhJx+jn+Wn1VjL4haXBAwAA4xbAT6OkznicRd3QkQVsP07FmVpxVor72h8p7
	 pQYkOWrbq3VztiX3m2TN8AeZm9EtkGnyAh7CMFsz7JdUyTpjMsyDnSycPYcrkJnTJD
	 qAxmtxW7EtbXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 522BF80CD8;
	Mon, 16 Nov 2026 17:22:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 588C31E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DCF380CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hI1dSUBbUUBr for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:22:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3883580CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hqVOnSal
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3883580CCA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:22:12 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-862d919fb1cso302449a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794849731; x=1795454531;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vLR2CF91mGMvhDFXHzTL53JOfEwjvmiDxF+2aP/cyDY=;
 b=hqVOnSalpUoxMk5yVRY+ZtYFYcOOVJ4kGB1u8A+oNt4+moE/fUl/f5092NCv7Q/9PX
 vef5DL4YkhpTlbdgYL1GIub+BsFosYCfRMozFz8z7bZ4/VV45eOJONDoH5P5ulskPNO7
 2H5+RurMGfX0Jc3rDM7WpGYfB1ZPlWX4rf9yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849731; x=1795454531;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vLR2CF91mGMvhDFXHzTL53JOfEwjvmiDxF+2aP/cyDY=;
 b=Obipp7L3hocrxWFNWnU1ythwMiErIRPv+jM206h79TKfDIK//5K/COVZJRbV18LBir
 +VrltQLd/lWN2iHl641mgI2nptwi6YnSkjlq2ij9nSUSj05TRJie/ywmPfUGmUFPZvmk
 lGAyejdAzUECTJPjmOo6oU8WbQcUPs+sRM3NRPM2VjfbaVHIDAs0Lp4mYcn3cZSWG82/
 MxRogNdUXGzTerExtKmbh49kMU4tdfvr1lz/TwRdHb4zVrd/s2d3XwQcgE1D0VkAhxOO
 7jKxcWoBDSqHz+w8Qol9CTFdMTlzm4w61YhrIRJDFdFgjPNJKLxWQuClffJ5SUwnl48x
 RtUA==
X-Gm-Message-State: APuU4Z8KsLl8Na/iV9KG/g5GGoBCBZz3nfrsioaiIYwe034yWqa4bc/V
 Mm2VkSb/G/PFIn9nsM53Ql932f/KOxgFA/w6hC7uISiUorbJ8adLRW0zY1uuni2FMfhgH8W5nlL
 5/MX5KtLGdA==
X-Gm-Gg: AYBFou3gOhwXdH3VpFobaxFaEJfei4+8zUK2hJuEURPOF8vv3rs0RzJGTup/XFzgqQm
 3sY+NN6z70VsOALfSojcJo/RigJbOgdKYU4FyaGHA4djbvf/ayl+U0b6WcwDkBc6P8eG3xn0qAW
 rbcG7CI0q1HGZoK+8UnkwPQT/vZPw+xaSy3W7HyS8u750D5SfJNu9nxim67rxQ529Db+t+25XE4
 8mXIhGVP7SJPgZnsEFTLCAvfVJVc5iGSKmLt9UhzCN8ZTBZhzIdmzhmIlnwdnQls4SQnrcnjSrf
 uY1ayOEmjGHuHidAjFOsoFV9coIVfQr+YQQ7VMMvId8vanRgcqWYAgBKSAq8eP4qBM1nAEjguqW
 9BsUOaolNxtuUH6c2HR7GYf09VX8szfxSOWXX7HQr0UKgRJFkhrw3/lt8zhGhwGK/YJMMOm6Tlv
 pWDWVAlwZDvQegIQsmyT7j8tNq/oEInOTW1KznVi+0JfavjmXWos22pH6ySpXCtJ8tLQt/Eh7We
 hY229ivjkax2ZIuemwqhyiCggBK5sR1L0uJh02rvhHQ35/88/hRJz0fGXcWJfbo+ghZd2n3+IOD
 KZOf1/GrmRiOHU512mf2KHqAJPGmXKt5tXSeNGizOQCz80R5FA2lOu4Js7ojMqGh3BMavfvnGlb
 MFOc7oZac8GlFD3nDL4j0c+7z6TSJfNdK6ZifasT8IWm/BuWTFgMH6UMSqebB0MhVoROoznkdcE
 fYgQSKtVVs8xR32DK7NtzFuj16dknCo0tK8KBqzx2xt58GR+v22H3f
X-Received: by 2002:a05:6830:2b06:b0:844:4959:e840 with SMTP id
 46e09a7af769-8628986fac3mr9563932a34.21.1794849730992; 
 Mon, 16 Nov 2026 09:22:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a82c4625sm7191658a34.22.2026.11.16.09.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:22:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tomas Paukrt <tomaspaukrt@email.cz>, Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261114203948.1521305-1-festevam@gmail.com>
References: <20261114203948.1521305-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20261114
Message-Id: <179484973032.2141271.12987163446959152819.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 11:22:10 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 17:39:48 -0300, Fabio Estevam wrote:

> The following changes since commit 8ea02c99391d2d922810065206721ead2863f075:
> 
>   mailmap: update entry for Viacheslav Bocharov (2026-11-10 14:57:48 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261114
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


