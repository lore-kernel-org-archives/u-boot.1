Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54244C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD7681EC9;
	Wed, 19 Mar 2025 16:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="duCGLeHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A048212F; Wed, 19 Mar 2025 16:05:07 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47ABD82115
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22349bb8605so156270425ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396698; x=1743001498; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shMDfAtRPkPZ/jYYCBVlKNtqkRcaybLQIcrHkOHmTjA=;
 b=duCGLeHDb1HTrv0oVKfxEfIuKcdm61ijp7BXWt61wF9/8/j15pBoo1htN53AsRRyw2
 4aULdMcSouaiSqkt0/6Hlif1xH8pFmZuT8SllWqhTjh0+Mmv65IsSQ9nPgWyxxc503da
 yhLLlMX0e2j11MaVnmB9FUAbG2PjirkG7mR9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396698; x=1743001498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shMDfAtRPkPZ/jYYCBVlKNtqkRcaybLQIcrHkOHmTjA=;
 b=A6h2RaJjK1igvfl8m3bxq/r4ZlVyJKthnE7fuDx8EBllX1BQCcj9VrqP5u/CRH0oRe
 kwBFoFljmccWaplIJMZsNWmlMCp068sHJ25hcw024YiZIELep6y9cL03b9dhq1YA9GJw
 7zVVNfWaMcJbYtiNE084tm3xQyqQ9MlXo06YGSu0CkmXzEkt52QM1mLrI+GTBiHuQ1/3
 oN3+x3gBOfGwZ/105fnEw9AUwkw2vUa4ghHGa77woenITGJTf336alqjw0jm5jfc13Wh
 H+Uoueu9L4aqKaKA+ot4IaocZPJFeAx/snaq38lSN5AlLdz4+3MfoN1BFvgq00nyN5qf
 jg6g==
X-Gm-Message-State: AOJu0Ywax6PL8VMWd3MqKBdGy0ueiVUC1X0fD51YJ3GFTuXzhBDDvhD3
 LCJZRS3T6X81w/q5tB1sMZ4I33r9Ju39lDNS5gh60w0xdzUV+2l/G4hFISMca+neK6QGN7fUmet
 vLL2JEYnpqI/118h+Nu2QgNLzlX+0H7Qt8Mf9
X-Gm-Gg: ASbGncsBA8u/PByH6VlxqZlHa6NLVyFhSvCETPn1urola9sW+pyHZU8ZDxmZDSXQj9t
 tW3wjLe6R0h7K+CwHo8Kq24sjfom3Z/3ghwfHaezn1wKmeXdwF29AxRnPWo8qvuPharRA8ThaRc
 U3+XSckbt+GOL9m9am/6mrEy1oWbs=
X-Google-Smtp-Source: AGHT+IH14bft0zJYwm+XrHxKk7vyT2TecrAbAYoUnQpp62Z8eC5jqvKj2ZCKXZIScx5ERMqUEoM8Rf4UAEzPnUHujUA=
X-Received: by 2002:a17:90a:d407:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-301bde6e7b6mr5448560a91.11.1742396697758; Wed, 19 Mar 2025
 08:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-7-sjg@chromium.org>
 <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
In-Reply-To: <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:04:39 +0000
X-Gm-Features: AQ5f1Jrhtguj1OGw8IjwjijkrawnSTNviqatU3zkU33hqVlJ8Vwd4Z7hxH3V_qc
Message-ID: <CAFLszTj+ygCXS6u8H4Mk7TiQk8rGeJDd3efDnX3Kr8LqGEKWuQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Wed, 19 Mar 2025 at 13:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> Am 19. M=C3=A4rz 2025 12:59:08 MEZ schrieb Simon Glass <sjg@chromium.org>=
:
> >In some cases we want to show a signed value to the user without needing
> >to use the full printf() implementation. Add a new version of the
> >simple_itoa() function to handle this.
>
> Where will this be used?

In a following series.

> Why can't printf be used?

It can, but it is clumsy to do that.

> Why would this fit into this series which is about test improvements and =
not about functional changes?

It seems to fit in here, since I added a test for the existing function.

[..]

Regards,
Simon
