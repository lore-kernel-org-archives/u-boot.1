Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18354C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 07:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CD188747;
	Mon, 15 Jul 2024 09:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MxljDHtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694C788747; Mon, 15 Jul 2024 09:11:49 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62515886B3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 09:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-79f16c85da0so265123885a.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721027506; x=1721632306; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2BNxLKhoQM97ZJYQu3pNQ3GlRi/RKu7nr/x3kvS0s3I=;
 b=MxljDHtBcuusYOLiL8KNCsIuxKVSRZAhfw+QTcM4Gg7SKk/02M+SqFGviPRC3pPx66
 5GcH4jDtLxzu5bJ93eAqv4LyK5Ye8JlmCoAWhpbipG+42ASQOj2SBFuflM3enDN9thxK
 +K8AXfEbehowfoGFnb2RhD5Jm1nltdt+CPLuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721027506; x=1721632306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BNxLKhoQM97ZJYQu3pNQ3GlRi/RKu7nr/x3kvS0s3I=;
 b=Fuf4IVQJAZ+0CKt7wIJHBqOoz8ecKexNKTwP4/eW2ZGaAnV3VHzEpVKP591lfKujvQ
 6V/EfwIHRf6NAPrpFuwCD4TSZzUs0J3IOpYVOqc6HSE44Js0Oy2/rFk/hyJCI75Xzu/U
 ofpzlAobGqoSWACoKXwarK8m2OnfW3TYcqCszKT9Lx50J6MPypdBYkIvX5ToSRriQj+L
 /aHgBZImH7aQvUg6SCqwiMtAnUrU8vNcKBYX72TGzfhJwuP+ODZYkXAkSLz4gICly2dp
 QUOE6NgJjCrn2tvGNu7hWmmLgrPiVzrohSEXxAN2jElQ3ex9rTVPxduuwbFwxccaW8cz
 Bnlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyos/CDpxjR2Cbv/YG4Z4lFnAir+d5o3JZUyD7XJSWTdyO8puzOFKcJSp1lt/ChBAaz8mnEUobW45YLqlMKChVTZcA7g==
X-Gm-Message-State: AOJu0YwLLzUOaAFnq+CF/dpGMQODtvStovUcIuT+493OA3Y9QigfdB2h
 6jrGuKctXN24zMX4AYEeQwsqpObamp2FovVMMuHPB3eUhRrISHvUUlt45Oss1QH3+0IlOW0PK9X
 bfc+Tbn0/FWeaPBWb8gHLHTcejS/B325qswiF
X-Google-Smtp-Source: AGHT+IHd4j37N+oPnSZYeg3tcCoJRmeZMvFTldOqCeAoCtxzIXWnYDUTLDiVnlZH0jjIPoqKNvyny4nQANjJQ89hcCY=
X-Received: by 2002:a05:6214:5192:b0:6b5:44e4:eb3f with SMTP id
 6a1803df08f44-6b61c1fa5c3mr230873576d6.47.1721027506339; Mon, 15 Jul 2024
 00:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240714071804.40534-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240714071804.40534-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 08:11:34 +0100
Message-ID: <CAFLszTjYvx_1=PeZmccLsV3rXC4RALz1qphjeUtOr3TsB4arZg@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: move out-of-tree building info to HTML
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, 
 =?UTF-8?Q?Milan_P_=2E_Stani=C4=87?= <mps@arvanta.net>, u-boot@lists.denx.de
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

On Sun, 14 Jul 2024 at 08:18, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Move the information about out-of-tree building
> from README to the generated HTML documentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  README            | 20 --------------------
>  doc/build/gcc.rst | 28 ++++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 20 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
