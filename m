Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475AFC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F9498836E;
	Wed,  5 Jun 2024 13:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EA+KNvB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4748836E; Wed,  5 Jun 2024 13:26:16 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A133F88365
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57a22af919cso8314a12.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717586774; x=1718191574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Aoa1RZoymo7tffdZP6t7dJPb/69CbFp1jQT8Ka4h3Z4=;
 b=EA+KNvB8zUPX3xrpXe82k1MDuIRcBsIPBjXeXBTVjvg75yA1tHxt/ckqTLZSzvrKNH
 i6Ln9n4bqjt+1P0nwNuUWHLlj1flTto4TdvclKVTXmESb3PA3DUEuE+dvMSAg/1jHOVs
 AbE2nR4vbHQC6yOGVVy7eIO0X+KwfA6lFKaD1PE8NoXhh/vvLlr6jz1D990pasPP3GUh
 X0jfMQtk8bYydggUS/P3MwupmXHlT+LTbi12W+FGFma40NWO5mPOBHRhHTTa29FSgVwq
 R/mRwHavPuLN3b1jCz4QajZWFpDq2NbtPWoLGAIph3r2lKZO8U4MD4pD2sKb+PmoWtOx
 AojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586774; x=1718191574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aoa1RZoymo7tffdZP6t7dJPb/69CbFp1jQT8Ka4h3Z4=;
 b=epsSYfRzFp/85wTTuJNu8vcqFbFUCtcwoWYK0iFDDu9qbtffJFN2AqMtqUz9tUhBYF
 t6zFe7euAGS6xM/JAsJHMUGIUsUdGlSufJEWTE5dCl1Yi+sO0471flBC8hfUpiEAs3hv
 3tScMU43IaLUQi/vbL0M0HEOZb8DEGXMr3YdKNN/EyixPAmGqQCZYnT+p2eeUvfCUtSp
 eGzDVoAb+BVbCt83tW9enJKZc5tH807CclppLH04gCmo9zV4+Z7NyDbwFHKZJc8LYPZe
 Ctoea6ZIBrUjwWyhrCCKezWkvc8sT/N8Vri5PAxSz9SMHumkCMSkaqi6ggujxD0OK2Gp
 BxTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2bAjsAy5a4CwwB4ka2vEPEBkahz2cDNJrnJkGGm8e4WlQ2PNlu05dD6u1cdOmDC4w22aWoVsb+HgeNh5mPWct43w9jg==
X-Gm-Message-State: AOJu0YyBT6DhXuYRm6wIOkYNvvOOqJfiuvRgUOilcUB5UmPYlvA4WpNQ
 zeHzrefmOaw3/8FkgPkj4gKq2Qh3vsQIyW5TMYH+Bv7lkB044lYbcz4btnkc/ZArpDBg7P/yNh5
 0UzNCoAMUnjbtshYNzFIzQ2iNfvHoPko5KXqe
X-Google-Smtp-Source: AGHT+IHRdy8pwj04OUtWchGia3Fz3GTHrNP/3o0jgiivsZJrzr+tPC/dWizAAriNnTenvUVGab0AR+tCA+nms++EwJ8=
X-Received: by 2002:a05:6402:1051:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57a9089e5d0mr174270a12.6.1717586773692; Wed, 05 Jun 2024
 04:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240603-bcb-compil-v1-1-4edc2c77eed3@baylibre.com>
 <44f71d7d-a999-4479-9e7a-be2956b650bb@baylibre.com>
In-Reply-To: <44f71d7d-a999-4479-9e7a-be2956b650bb@baylibre.com>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Wed, 5 Jun 2024 12:26:03 +0100
Message-ID: <CAOWkq4kL2T41gjeZjYde4R9_idcr1NoTCqw7msBqXZ5uh_Mt-g@mail.gmail.com>
Subject: Re: [PATCH] cmd: bcb: Fix bcb compilation when CONFIG_CMD_BCB=n
To: Guillaume LA ROQUE <glaroque@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, 
 Cody Schuffelen <schuffelen@google.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thank you and sorry for missing that

Reviewed-by: Dmitrii Merkurev <dimorinny@google.com>
