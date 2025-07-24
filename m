Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363E5C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 10:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0ABD8380F;
	Thu, 24 Jul 2025 12:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IGG9bOrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BCE83831; Thu, 24 Jul 2025 12:55:00 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1CD836D5
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 12:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-608acb0a27fso1493935a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1753354496; x=1753959296; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MXnPIj5Yo9+zLB/ITN1lcwCS3Bmgsoqp6IaDgg4Cr4I=;
 b=IGG9bOrtsgzZ1QIRJ2y/I9IVu9SeA3hCVcE8AdWNhu5cPgIFhC7gSzvvoJ9D05a0BL
 35y0CwLJDS9BinUjnAHQeFmJjqnN/Pw5QPbAJtplreFAG3eY5iAWnMJtpmsBLuGTswOF
 8YjryzqbhEBIRr4ZIsoXQf0KF3G9gtt3yJW8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354496; x=1753959296;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MXnPIj5Yo9+zLB/ITN1lcwCS3Bmgsoqp6IaDgg4Cr4I=;
 b=Vpk9Y6T5Wn4ntxtlEjrtM+vQB1gvdKqmeTK9KGe7LCNbzYnKrsstMU42F+P1++ClBK
 0QNMryb+BUfQl7fWzoDstv0UStnxuuMLvP+zGgbIwVvhMuW8X+uglj8GVpP3n1HnMUj5
 B4ZukgtXHOU0pg/EKNWczFmDcHzJKQe4SiiGwQotDRgdJFa42XOPiutN5qHBqIBVrPKm
 kFxIpsuxO0BV7sq1kDEY9LUB2/rubP2Z36bonZvP0W/U7Ncr7zSdgX3INPPtuskKBSTq
 rozIy+od713/MJ4Mf5Q3dnPc2D7nhG144IfIRQpkuAfS4x9IAGvdEJEabO4EN6JUKLo4
 d0vQ==
X-Gm-Message-State: AOJu0Yye58J3mlz68PEIvWRIGTPXaGVOy3z2IWdDowp4/22ZtXNWvFis
 c2UelNBYVOX/pzXp9KRqlud0f173KXjYi1FEBMU8eGomu6ppsziY27CZTb5TYY6SlaYhUvAr/Lh
 /VJ/ESEZThKslCLKxjoJjxoDVh+mLa8pPRS/eETwkikjXjKqMJa0=
X-Gm-Gg: ASbGncuStJ+t10fyAEdEXcfWHvQCIPvZSHG1NXwzjDJq+Wjo+7fATIjwZDe7ImgFKji
 hu/77PuicQaBFcadmyAmrUMaanxi2uMz402k//i2u6FKmiylVsyA6bc3uVbWoFbFTtej8Hn2bRv
 sbehjLVQh9t7yMDg4vxFE7OVqDSbMhW7d9AGPziiVuTXpdA+gdjfmIHIUz/XS5CTjcsfFZBbACm
 q18womaVUVurAj37uo=
X-Google-Smtp-Source: AGHT+IEAqnTgzhqp8Uas2dQHCHNn+hJGhzfdQ7RvEkcZk+4kqO/J8E+Ke70CAwXS09UdzFZv3RGw9tsX8gM5VFxBDnk=
X-Received: by 2002:a05:6402:1652:b0:609:9115:60f8 with SMTP id
 4fb4d7f45d1cf-6149b589a43mr4696293a12.21.1753354496311; Thu, 24 Jul 2025
 03:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105148.56598-1-sjg@u-boot.org>
In-Reply-To: <20250724105148.56598-1-sjg@u-boot.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Jul 2025 04:54:44 -0600
X-Gm-Features: Ac12FXzhw3d9re_iEJfWwaLo6WZ-bih13F8KZI6qv6EHZbTMi5tTXOkzjRa65-M
Message-ID: <CAFLszTjeJGrhrMrO-tfO=ho1zEpNrKqVBAeB6VdUCF3Rg-s_5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio: Add a little more debugging
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, 24 Jul 2025 at 04:52, Simon Glass <sjg@u-boot.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Add some debugging to virtiofs in the directory-handling area.
>
> Drop a stray, blank line while here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  drivers/virtio/fs.c     | 1 +
>  drivers/virtio/fs_dir.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Sorry for the noise, please ignore these four patches.

Regards,
Simon
