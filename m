Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0459FC72C2
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE7F84105;
	Sun, 22 Mar 2026 14:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P59G2cxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE24C84109; Sun, 22 Mar 2026 14:34:07 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEB084101
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a27a7f711eso2537537e87.2
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774186445; cv=none;
 d=google.com; s=arc-20240605;
 b=f2EkS9/0PMXJDXqr98WhIjR+fhkCXauOn6Gjx4iKMp79T/avQvG9j9OjGPxhKq6dgY
 XEO9och9h7QvKSWpaQUJoCNuA0eQ8g9F+gzwV/2TAYJ/mmlZFfjolDtUOwi17oP9p27R
 fjYWiku/wHJj++sqjmuXm/EAjZtvxKAMVVAqAPWBLel0NX1EPfcpgaEgrOrLcKD9EXYD
 xcpmhBn5N1vpoSNX+O1O92soQpWo+LQT5XE4No54RUK0Vck+qpbSYifaqVgqPJ1hw2b+
 aBLbbScDGE1ThY740elcp6gQ1bH6DV0/jwz+Rb1iksk27MeAdFZp8rZFGa2uB6mjm+bS
 UmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K/nCN5bKjRwfpkho3KnyOJ8zv/poPOSm752TJknsYXU=;
 fh=G8grUqmXAQWOlRtQpkdf44KL0t22jEZVRHWldP5hbxQ=;
 b=V44c+Y/rwAxATS+IUsxK1FrWVmrQeCHzeFkU48B9u1VVyDVCdmc5cLf+GRIdkFdVpW
 pgr2n+aUyqepKpkRHv5RMvBKERnrIw30iLFDddZ37k8ihwBwRqqFglX3Rcxb/PerbAB9
 jE+DxkoiASNuAZ16xAW3zri/vapjuAtuMostohJvNq5P51X/vr3u6TgCbpyeR3vXtKTr
 UzHoo2Dc4NZOqR2pV5XAwRzYVM3Nfg5GW0pXQQ9mtMRGQhTPrej+Ii2GI9lcE2kienlP
 zetm/HKM4EqhaE0Sg7c2jUA9LC1me35UVyscb24swBP+a+QBjj1m4nQ+84xZB9meVJX9
 xEww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774186445; x=1774791245; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K/nCN5bKjRwfpkho3KnyOJ8zv/poPOSm752TJknsYXU=;
 b=P59G2cxI/alh1b8l09eexH9ezVx8+6pbn0e8CBrxqVdMnacDIvV5Gae+yc8C33wapH
 5TS57ct2rQisp8csh0l7Ud9XXN2yihqeOxZQNL/Ib6uUrRYEgqxfG67owE94B9DTPsmW
 MJUrY/eFdyLAnfLRO9ftUDPBc2rymn9y4kvqqqnn0aPa2zUd12J4d1b2sJu/FzOkeXcP
 bcGTwz0Y451BV0hyFfM4stVhyjdP6W/+OHzwTrTBMoAOTjKnmQuZYIkjP3wfATpX2btL
 bbLRX1qvVXxc6v9oDljKDDJiRctTSVIdSfDh7WyeKM8NxlzLDhiBWApQ28jFo5MDorci
 VRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774186445; x=1774791245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K/nCN5bKjRwfpkho3KnyOJ8zv/poPOSm752TJknsYXU=;
 b=MHsLXOb+Cef0/Mvq03WaPcFCtFA6j7C7e4g6M8svLzYNs2I+yBQyAkXzY+ldlwlNaN
 5kbn3DfOjqeF8lT6IPEkJBKJOyB6Yl/uHww6NqgPUKOCOnO8FTtStZzmIbxD7QmWV1kP
 OjLzwZiKf+c+ULHoZZK8pGPbfbBxPAv/8ulVuZnjpmyuXMdVYt/I3vVJpBSFpIIlL0mW
 v6c2rVTX5ur5b9R190ardCWK2O/S+bv9AYMTzN0KQudklQOFczl33eJ5QHNn5K1D6Dh5
 8DKVFq2RAoN891/DOx7IqiBJ7uBDFvo9o+lipwkEqkZZoPu7C/0Y5UA1WNUfqM8Go3jN
 LZCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOBfUYFeb/X4gaaU0OV++3rOQURS7vpyk+7DDD2YKLGKI/qCMrTzEJzaTHmFm+Y7qCcEnx8rw=@lists.denx.de
X-Gm-Message-State: AOJu0YybG2prOWWOyxd+FExxBHzHsNy1Qqsyl1YQqE6f+m/PkKyLBb42
 fXPRr0tdp9yOaec0fY2hUq8YE2GEd8CXxcjCbUvPRVBQh0k+mD3WxwwqXeftpdlsNqCKS9oo37A
 TdDAj2kzzzLTg38/UmJ3jkcePkst2jwY=
X-Gm-Gg: ATEYQzx9eX5REVr3HhYGy7Pk64I8m1V9p0UULnXCWSVeIKrIsNDjXHSwWlNUxulkSb5
 5PBcKfa9YHLA/VjGqgajOdkgH4WAX8uBGysOqUlMWDQ+moNawqPswdmEZUbwx68O1PNYOq9VlBc
 9klGJbn9G+O1/fUL4r6fZ1bj7CeHXRZLpZ1chgPUvT7a9zalRhTnb+mDH1RmixQh+tRbG2w23eU
 VCw4cgt+KXjHFFQ8mfzY/+t638/KscsGiqcNMOMzeAa+wjWUO0wkJcczP0bSfFMZ0TgeFDjCDh8
 lYQeI7ghSa4HHbUoYSvsW1U6wrY4P28FwhVBUbyUux/JkDv05fOyHEbU/3ot/l4TPynwSac=
X-Received: by 2002:a05:6512:2244:b0:5a1:440f:512f with SMTP id
 2adb3069b0e04-5a285b6da33mr2910859e87.27.1774186445059; Sun, 22 Mar 2026
 06:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:33:53 -0300
X-Gm-Features: AaiRm508B5kr4vlAlhcObp4x2xfZSQz6ZjDtxE-c_CUWnXMt3Ue5c02hp2lbKWc
Message-ID: <CAOMZO5CkBp7FJbnvMsiB6HSchZ+z8T+aU-08C8baWYETrBHVsQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] TQMa6 with preparations for integrating additional
 TQ boards
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, Mar 12, 2026 at 6:57=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> This series introduces features for sharing across different TQ boards,
> simplifying maintenance by avoiding code duplication.
>
> These changes are implemented for the TQMa6.
> They will also be used by TQMa7 and TQMa6UL, whose mainlining is currentl=
y
> being prepared.
>
> These changes also serve as preparation for further work on the TQMa6
> (in following series).

The series looks good, but two points need to be addressed:

1. Make sure to pass your series through CI.

2. Improve the commit log style (Use imperative mood. Write full sentences,=
 etc)
I sent some feedback on individual patches.

After these points are addressed, feel free to submit a v2.
