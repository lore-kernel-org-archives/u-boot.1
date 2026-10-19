Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A7606A321
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cDanwFqz;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D+nED7wK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFB116075E;
	Mon, 19 Oct 2026 17:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNqm2vwpnAon; Mon, 19 Oct 2026 17:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D6B4D6073F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429513;
	b=aq4SsBr0xQ8GJXCBA9zlIwWakqaL1wcmodwxHpZ4HlUHrSZava08SEm6iYT7EXFypSiq
	 lTuhW69jfWThNnfzm3G3ie8G00PyGXpKAEkHfrVLd74moQhs5dyGQQqwWsD8vO0jzSoDi
	 9pHzdcR1uUOjyHl9u5IVHnTZo7lHOiL6uBVwM95E16aWpta8l1FRQO7Sr7Z8Z17GlbMuo
	 fY/LpCHoqJ90kYl2nf1Q4wK7oeiMqn3Zium2i55sRX5xlaroSHe6lP60aqwYIYbbSh2m3
	 qlFUPzg0aH3h5/sBzcYlOCbBe58FOxje4bcakoWu1FYwmwZu/zXRtTY0TfABnOeBoLg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1tijc5WQxeGpCoiDrM26EuGUQ8ivh/ezxPI6sIzVTnM=;
	b=cpNqk2qQNE1g9MJ1y8fHOEeLXZEC92T3oPlV4pVgFwengUtWGeuTj1irthjDoWu1eJJY
	 vIEcuzf0uavSUg48PCP9daWVHGntI2kFnw+8fGCeQd2gK3Uj5/qNJMoRyMvkfzoxz7LZ3
	 g2u49y2MhoxBwiCVFhtuDX0TGF8faXH0EVvI1ETyYW6NBJmxR8YiV3LPm+YSyvi4rItIs
	 bxIqy7rQtV7GDGeBcfIItkoYNlijGoXc2FOFUb/NLCzGYceH5Y2RN+wCdHbg/sEDy3+w/
	 OvvzCbuRaTYKwgC3Zst1SF9cfu6MXfZ8dR3FEqLvgD1VSA8pYoW8hFMYsoU0OrzFdyA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429513;
	bh=1tijc5WQxeGpCoiDrM26EuGUQ8ivh/ezxPI6sIzVTnM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cDanwFqzE2L75tzvldEOVlpnroj9P2v4ByUsMIp83lnktY2sQ8SgU38tJMztnpndv
	 O/shaVkw5Vt+CFD+a0574qo/AC6yKXlebxsD0dUXUIWchWxqKdBm054ze6mFRzZPUI
	 8M79dnpWOFDX6JFcVAGaEUToJ45+LY5MnX7Y6CEWJvFQviVTi3knK6phFnAPytL+4z
	 e5WxVPyJ+lNW7NgvmEXNy+jw3gTu37qzNfS9ncVOT5pxla8wjIjHbOqtoQbO7mSxVO
	 Y8kaTrvyaNeBgGzRm5pXh6PbiBGiOy0ZRHwrgIqL9Jeq3PMprn4VcZPw28rO+CYtnf
	 QMb7KQQkBh0UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6B4D6073F;
	Mon, 19 Oct 2026 17:05:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D97F23A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03A524066A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBcMA19CSF2a for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 609AB40669
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429508;
 b=KYOAJAfb89k4pJi8W2hFC2glkX4s7uuRx7Gc4WKSE/H2lc3W44+cCtwBLFxWPv1eeJIA
 l4uwvZ+GboNp+Oh0eTArdYkvXB+YgP5J2wc7K0a8Oc5R/Go4AjnyEZKUK6bKFBjeyWAKW
 W2Fo+hnAsD7kZ86woCYTILJbcWk2s4ORoXruDuP2wBrv4YsmkKxB2zHAqOUUO7yLLMWMb
 fPbeZ9FQD6ul+LAZZwydauW+k7G2Zo7JvU6CSlySuPCWEoD8e35CGH1+G5/ZCFmaSuYC3
 EkzeXYYDBhMeNaSbAHtwMzai0rasdac7Igsiuf9M4oAizSO0tGkcZsvZgZe5RHZMfow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429508;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=1tijc5WQxeGpCoiDrM26EuGUQ8ivh/ezxPI6sIzVTnM=;
 b=YQ8Veyj5HyZTzc2xH6MIE0l567SVbBLXEdUoQczSjOvfIdvR4bnGD7Yttf4lYZyYK1oZ
 Dm8OWEU7Z6SVZAX0uTeTYyh6krJVHy+6TrCxbvoJxvEkH4mGaW3VoOqISJdoJsoay66ZE
 fr5zMa8hxEKqm/wTgMZQqqUHV6fDC1ccro20tetAotIeO/z5WUMYCNT4S//OiULJQ2dBJ
 A715VHTr3cEuMvP2t4CWMvFOvGR7LhtGPxImABkLBwxGN0oCjRAnpoeEYU6jkCkl6bOfJ
 DOSUYpFKFljdikRW7T9cuersSmNSficynqECvg6mParBUpYpJNCyyTzLH1Lrgv65LZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D+nED7wK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=D+nED7wK
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 609AB40669
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:05:07 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc4dbcf2b85so953415a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429505; cv=none;
 d=google.com; s=arc-20260327;
 b=e4EOTuNr+NQ8SlapVqwIghKod/cs2QYgWz6wGlUWg7dzkdIZM/DZlHKNsRG0vxi/WC
 v+cYTOr5U7VSqvC1PtRNMYOAwcJsAT90v/Way6TGXxHD1rC8urShCYx4COqd0yQtPesY
 Fk3lvzzYIxrTU2ixeataZHqcxWjKO5rPedHL6aliX95LxpTtWwB1/ikyAmXsveZiRMaz
 NAm1sJzG8agkC2T6RG+NptywPU3xc9tDn6QWHBgGgek871makmvYtAoUuR+gsE0OYQsd
 lbVeM8pvh4yJ70iwGsF+8MSbRRa33uV4E4iWxbwKWlhAkONVsfAPJevNCK43fXTMBAUR
 wk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1tijc5WQxeGpCoiDrM26EuGUQ8ivh/ezxPI6sIzVTnM=;
 fh=VHWOFrSro2r5LXCX6DV10K4KxxRLTwzTER+qnqcT/zY=;
 b=Wr1m5dEpJd1Dn9SN27QfhhKcKNuQX1W9BtNeBsuDVzIju0vVDNwFvL981+blKwqoW5
 Pzg/ywENZKjm5LrIsHkBDZ4Cx2ZFbeLAjn/kMvTWlyPwHbR+7uLzubAJQVLZoYPlwrSp
 sRWKqSBawqrDLAFnaKqeHx9IV5ivJDW5DTBRwwwSlY3sNaR7D07lcT+mkrvrPcXFb/hl
 87x++ZZf94IoBog2uM3vMBqxf3ELVdcAO+i2dN8uGRWRezURM9VaBqy0N0eAo1KWLGQx
 FDbi6SKN7emUWpm5KPBzDiPBMjGDae26P+bMm9/DFNYtBpvpVqGo9mN1eA8kAeir2f45
 oM2g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429505; x=1793034305;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1tijc5WQxeGpCoiDrM26EuGUQ8ivh/ezxPI6sIzVTnM=;
 b=D+nED7wKrioWsf7oYdZFpiLfm8OBqnjhZQtgfQdYHx/ch5RmdX0udNZN2hT04VcLJ4
 CMr5tWbJEj6nfUE/RcpD9MS+2AW9gLpsGxYnGfQeGTxftDQyg65hhSbE6+QThcarBGbN
 cMhS4eTLd3LzSANhkB9QjRnHSvW/hmhI1sw3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429505; x=1793034305;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1tijc5WQxeGpCoiDrM26EuGUQ8ivh/ezxPI6sIzVTnM=;
 b=fER6xqFCebPddU7PLYEPN2Pob8J9JDhOZk/4Zh2THdodr0LOfSqRy32PYewePLF7jI
 E6A9DZniHaHz2QYO3vbZNxEs8kf+kSj/dY6hpkGORPdK3WtdwpRdR/ZdFGLQuTNHrLv5
 uwglBl9y3LAY0G9X/a7dMiIPBXwMm0nBVQl/S+3BTvR+77yhzt2Adp9LuTQqmsqrO5Lm
 IVjxzFb5QjaEuKmzxNbxgvR6yvdG+SY0V75bw7kRVlqnp/2XsVRSIcaTgRKEHgxw+m7l
 3dQEbV5DEowelYVkJYKWfuRCbHRha0iI5g4zAcVeJNCppvyEfjRf+wgZWKT2euXpgeBl
 69Sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBykZLKSqc1fgkpz8pR4t4VLRutM721DhALrY/YHz6Awl0q9G4Oh41SRQe19HEHY5F4zJvVD5/U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJLmk5i++ilmDN5d/BA70rmUnsx4AqE0zPRWsk7hoWTHFMOoNci
 7LGvwgdfks/LKEyIY+zfF+1+KtIcQO5amEUNhPf7DFAK555lecwunOb02nwW5e7NxQzH6Y++qeJ
 3Pr0IPDw50boNooOTLvXBTqS+U/rRJLXT1eGvqOjK
X-Gm-Gg: AYBFou2lUDuRyRevI0g2Bgos9OnwdCvZuS6jauQRFS7MUJGI+fimeWkyi1XBvQqgEi0
 NBIss8DpasPwaJn2Hnf5MxsiA20xzV/CSCXZd7SNWd04lLk8QjUe0k1I2d1CjN9/u0umn693n+f
 geDWwdBq3q5ir4y3uNSOUMif+LHEWgIDUkTuFYq0GYmzqSLkEFUinFGHQjGTUEbil27Og7mO4lJ
 qNYzPdYyCpYRJX9623vOs2ET61xe6vn13QN43VsKoIeN5CY4XTpsAYi44kzBOsKz5IEpix8E1xw
 KcYlKM/VydYMnvqr+pxhx/F3Z3uUdpXazuAn96jnpwGlg1z6IEfgv4M=
X-Received: by 2002:a17:90b:3b89:b0:3ac:b3ff:b476 with SMTP id
 98e67ed59e1d1-3acef50673fmr6946280a91.38.1792429504903; Mon, 19 Oct 2026
 10:05:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 19:05:01 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 17:20:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-9-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-9-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 19:05:01 +0200
X-Gm-Features: AclHuK_9W2O1JI6ydQDJUROIx8QvGRTpkgUlnt0oKweu_3Cwb85g2kz3L_GAMZE
Message-ID: <CAFLszTh8Td5P+-euUPA5a-M-AJqH7_PaGjv5dG-x4saQ07Uwxg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] usb: ehci-vf: enable the vbus supply of the port
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com, u-boot@lists.u-boot-project.org
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

On 2026-10-16T07:25:19, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> usb: ehci-vf: enable the vbus supply of the port
>
> The driver never enables the vbus-supply of its port, so on boards that
> switch VBUS through a regulator, such as the Colibri VF50 and VF61
> carriers, the port stays unpowered and no device is found.
>
> Do what ehci-mx6 does: look the regulator up in probe, enable it in
> host mode, disable it in device mode, and turn it off on remove. A
> missing vbus-supply or a build without DM_REGULATOR is fine; any other
> lookup error fails the probe instead of leaving the port dead.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>
>  drivers/usb/host/ehci-vf.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
