Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E9606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fFnYGfjT;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lPqyrIUI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D61C48165B;
	Sat, 24 Oct 2026 13:03:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aN5ISg-A0M3e; Sat, 24 Oct 2026 13:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AACF9817AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847019;
	b=WOQyx69WmDZfYrQZrqI8lYKRk/lc0h0P4KlYlgSJzC6JE6IHcgi6Fm/QEkHm1AHNsyew
	 kEJc1uya7xvUah0tX+SB1mPts9yDLen8B3eCQfrpFLqREU6J/Bq4wBRClQfHTfWfCjn9D
	 jRkNIfqX2kx9IGB0sTQj82vhoFbJuwjCkt4nCQg7+b2B2MNwd+Huc9YBYf/n2LM3mUv9F
	 N+XrzGw2xcwDdNqHILJC5V1MIgKuE4TSkuWqtaYYLQDcWDjqk1BK2yvOQni9q4wgDl3Vi
	 9bkvYAqNBr7Day/7h6wG+Sdju8UnHQ/g1ruNXB1p5NZT4Uk0yQrxgAx+jPDYgzFDYwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ORUXCPgLxBUKiczbLvePc2P/DOlgDEu37yYPIBp4Huo=;
	b=Ooq+Yb/0jBOgikteOD1nc8G/aR9tBRLOhWzUuaebbhaRhd0rVFgdFlfNXJohE2VK/qFo
	 dP649RAuEkgVDc1Wzbl6YLrAUG3pQgoS9W2DmmCJ41Q4tMppKSQdRozRLRjvmwupEyDyM
	 1IxvXwlvMS8yFtoHgTbiak4CBMhO7vtZuSBqOBBX914p4CgGAuJECiPS1VRJrj7vNJ/aC
	 RIaZByQlz3IdT8CrU79DvoyGZdAP9UzQB4J/pF0ZIvFBLU62RFtmkhfIZNLOljklSx+4d
	 eK4u7W5bzQnYiZNWNNuDZ5idMMlTr4BZZKK6XGjivOrQCZaGJnu8XEnnWWMlUcKOQCg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lPqyrIUI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847019;
	bh=ORUXCPgLxBUKiczbLvePc2P/DOlgDEu37yYPIBp4Huo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFnYGfjThshtTrtyXOzM8RBLrPbx+ZuEtkxvraurSyuOicWDTZBoS9kggcm64cSKr
	 6hCYT43EN5XPeDG3DF3Jj3V22K9QQ1Dz3Qj4c2YimFes8xupGq0C37//K+WGKcvTUK
	 HXXV3AFRn4Ed1PBXG683DBJuGmmsgkjoUTXrMDzcvIvdAPzOkhHCGiwoWfr0yBBPp8
	 2LHn40gwbIDbStYktqX1zgXFYmqqjxpTXM+Bj6UjdJxG2OddhYQawMTA86t1DUFZlw
	 yTbNgfoEXVCivZsztTfJD4Ksx2kP8JFd0nwPoCwDkzlbgE4a0c9QuBjkbkn/ttq8xq
	 a61FGQ6Y87cAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AACF9817AB;
	Sat, 24 Oct 2026 13:03:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18FDA43
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1698A8165A
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5gLf7hg9AUM for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B16F981589
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825225;
 b=ZjMYFuYn5Esccn6KdlPazrvXOLsQbbS++cIwbdJBniBNyI849WODrTLeubD2T5G7+OWh
 hBo7izl2wjEIkwNHFAKNdd8O2VedrfAJP2qpuemYXL7qdAaz4YzCEq7Lrtzt7EQ8OY2E1
 6KIH2FG5ymRYN5isUwHQsMWrnrTqm2SBOenLMw/9jsW7hlqgFF4yQLLCX3o/3Ey2yhlQ5
 c4Fci4swneFH1aILmW/jROmrpGIJRpKZCP5iyR1dYfYUJq8eHpdmlQvLe0wkePjtf+2fa
 HwTPvU6OwKrPzrwYT4ne5E7l1ad/lFtmI8A9b82iQ3klvTjpc0X18B8uZRxKc6FJ5mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=ORUXCPgLxBUKiczbLvePc2P/DOlgDEu37yYPIBp4Huo=;
 b=GpBxWS0rDq+si7UNlGXFgVuvMpBPNqxV6wa/fXWcNPF2fAbjpPOcz0Ug5kfpnHpL7rSB
 jNCrZeGM211dCl6LHebL2mGTBv1EULvgZGlvMUdTC4c2cwDzwqOhRJhXAxoeCU+wZIDn1
 DTnO77jTJ5iy1JjJzSDfWzGmRanTm+pCiTLjxTwYHZyNU8jgrkRiUvvtv4Ekuhsy3bBNs
 jkEB8JQQcLloSyZbAXvay0+qw6EaSboOcQnpYYC3oWw5IQPwK1XYzAOWuCva7YLt2l4xb
 +rI7qb7u8Otuu6VuMpuSuDj2n9ODHqgpygX0F/jJgjPiOzIwkM8fYHHgQ/Fg664uGLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lPqyrIUI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=lPqyrIUI
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B16F981589
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:24 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso2144808a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825222; cv=none;
 d=google.com; s=arc-20260327;
 b=YIlBncrgkHuWOe80ifVSOTzBnmwV1BPNAonH0ALjO8+h/nbgtYjD7Py0yi6S0etec0
 BjZTQAIemFGLWyVbhm5pseg57w7NkS/vED3oUAgk4lEyZOSVllVIhVwnTjXbsuZ8+7ME
 73mpTyRCWXYxE7Mra3A8LJeZN7XSd38+nPhpeSTlYzmyoHMWtem4QYc2Fua736VaB7zH
 F2O8uOUSYUVQY0PFVK/3tB2FImclKcNYAL7gHC61AsAas5HeNpp//zAJxQOqJFIpwQM3
 9c7Hy+30WSjDRr/fUxfPO+X2PLqrwKg0axE4jQSkgzv4nMiOm/eOF7A8rNK/s13hvLbM
 b5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ORUXCPgLxBUKiczbLvePc2P/DOlgDEu37yYPIBp4Huo=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=Pn9a94pbOwaEJ2q6m4YezNERTqCOMnLSFSPY8LOecLZ8gWaT/hqWaMwAXMhsG3z5oz
 n2V8/M9/cn2OD+QlWmQRoceTfMSu0s5/Vv9mQTKZjkab0KGUr+r52B52Uo7iItWpm4hU
 5rltfVRutle7fa7TqaB3jd0yskajRjEGaHA1iQqVEs/zuDogCjDkYs938yW4Odnca8v/
 n2uD/SH8PEo8YtG26fj0QIRnae3N80/ga5WYPii9PhPn/fo+MWdKc4kN0WIj9klyCdFs
 P8OFw4rWFA2tZf2I1Mf6uEZKh69RT44r5yABZaAUSfS0Lr7VicBBSI8m0mN78s6xN/98
 vnbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825222; x=1793430022;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ORUXCPgLxBUKiczbLvePc2P/DOlgDEu37yYPIBp4Huo=;
 b=lPqyrIUIrZuLk1o1FKe45eeSdbQlDjJZMqaPqRPj8h6VPPGDNcdMUwaecEbSIBW/W+
 AfO+hNpKm30qgUQthKtIz4Dib5oeLdO7qmPzQGCJFj9rSIFm/yC9adouwtTBliZWfwkk
 fF5KT+6M1Oc6nHD4v9gcFMF2VDZT81Qk4tmMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825222; x=1793430022;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ORUXCPgLxBUKiczbLvePc2P/DOlgDEu37yYPIBp4Huo=;
 b=g0koUp7hiAcCiBFQwvkVHRcJACh5MhBVvmJdSgXa5aw/yLjgGS6RZ2YoEQtclmJxUO
 JOp/DeBKS8KXykeaUinjWhpW7cI4dKkOkLl/wyBbgFy3CvikAIrxK5z0dhVQuLJ9ZUIf
 lp/XF4PIuvTV2nb632G5CbXZskRqRxDbTMrvkI8oXlp9RXPrrbNZnL/7eR+te4GIaZaJ
 u8q9c9y0gi3glmzEabUDS+9O7jqI7TfZBdBGVKK10dYMvG6ddENFu8l3K9hyRZbwqAod
 BXNQPIVAYT69hYcpVihsMSEAn22QGxdRznuWpfgb2oLkal8ulOs/S/kl9QBfMtcZYfAj
 99tg==
X-Gm-Message-State: AFq9FYLITcbHr8xQYsko9VqXPbo/Plr4Boc0an6q5iei0nwzF1I+JsZa
 iFpRmYMDKritWQJCC8+60O9qyL82ZL1kyk5BQPdfX2VequlLbch1laNrVqF5gxaI2InNDGKNblI
 WQiDsVoVsPjbRtEE0Qc+tUtAbUlYaRYTTzw8gkPhe
X-Gm-Gg: AYBFou1wsGUI0bvlldBgNqfVjNmexeWyp3s0e4MlMNlnpWKiPBOzBXggUP4MKDRsxug
 SvcdbTN5QJ2tp9KZ18HkNLksHczXijgt9MXcI7ZXXX43Z+GQOcqhOqGtMYabSgnaMpuKGp/m1YY
 +AxYVLkzoKxY1T1VQMh+AQj1igfc0MHUAD8Chx4Ac58kE0sIlMj+dCqmydsV/T9WmDaCkEBvrad
 SIElEV8XvtNtvB+Qh+z/vim9mNtgqQRUlW+Lj3veia8VGHt8VjnY8I8uwiKV2BaCHR844WugDNy
 rhXi70u/TNV0VeXp3hWx+iPWju2ODhBGdS8nC2/s3w7EnJSY3waj+tDqXPzzPlYK29QSoy/uSRV
 rGt77ZqV22630aJ3HKQJK1CVI8F4+/Mtp8fM=
X-Received: by 2002:a05:6402:a6c9:10b0:6b1:b9e9:6cfe with SMTP id
 4fb4d7f45d1cf-6b442fd8931mr1000810a12.14.1792825222100; Sat, 24 Oct 2026
 00:00:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:20 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:29 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-9-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-9-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:19 -0700
X-Gm-Features: AclHuK8l3qX6IpmUjbbdBDBeIKJzsBcAzHs2M6DQTCrCkV_ZyiFhjquMQXs6abk
Message-ID: <CAFLszTisqus0AHeB91keDJAUpoYU46h4w8gazrzKi=EJBb=krw@mail.gmail.com>
Subject: Re: [PATCH v3 09/23] test: spl: Keep the payload create_fit() is
 handed
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Keep the payload create_fit() is handed
>
> fdt_create() clears the whole buffer it is given, and for a FIT with
> internal data that buffer covers the payload the caller has already
> written at the offset create_image() told it to use. So every
> FIT_INTERNAL test has been loading zeros and comparing them against the
> same zeroed memory, and would pass whatever the loader did with them.
>
> Keep a copy of the payload across the call. Have the callers compare
> against their own copy of the data too, rather than against the image
> create_image() may have clobbered, so that this cannot come back unseen.

spl_test_mmc_fs() still compares against the image in this patch - see
my comment on patch 12, where I suggest moving its fix here.

>
> Fixes: b93cc1e73e11 ("test: spl: Add functions to create images")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  test/image/spl_load.c | 46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)

Regards,
Simon
