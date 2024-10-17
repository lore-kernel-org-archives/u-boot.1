Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0735D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1CE890F7;
	Fri, 18 Oct 2024 01:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TjbHNpuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8BA88DA0; Fri, 18 Oct 2024 01:11:48 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C7A89117
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cc2ea27a50so20383586d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206702; x=1729811502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=smPPqa9xo0y6VRQwj6CkGasMibxH/uVmRP3pTdu/L8w=;
 b=TjbHNpujk6veZsmAK6bli7dxszlFn4nMxX+KExhYUCQuT6WUs5I01vS9Htmmk90yhI
 dQ5RUzHt0q7Zd9MPVW7vzvksMLXUKoVHBgfWKMXYo7Wycuf+O++SjG4ihnbtkAToKxD7
 Qlx/VA7IGZ1BaMm/As2K/ELDHa30KmdNxEKIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206702; x=1729811502;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smPPqa9xo0y6VRQwj6CkGasMibxH/uVmRP3pTdu/L8w=;
 b=iEPtrtipr5IKQstWYC1UVtGo8sot70XSTijEFcD7M8269Or9RqKhTO0mJnNFJ0TtYx
 emPr92iqXLHu89xH673mX+t5QVxML1VBlQbwRrEWeQIR/U+nLErh5rv7ULYPz7iyw0kO
 Ogme4B//FOvgwrtKzLj/70Ta8IiZudXM5H2jqxcWhMuafoRA6PQ70v5xMz3SKEGHLusj
 N8hKzNjxKFhx5y9ZmJGc0DYvWUwEX5SoTZ1ayf9I90MpSLTzQJOewxD2otnwBV4jpfOC
 pK63WtHh5SJ1x1q8evSjXIRF8zQWOa/hc0B+xU6bt/1Zax1M4rwWz3wDaI34hN1i/h9A
 FWJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVygv8wR4MNWl/uf1MVwp+Ooy5CBzVCDiERoHOWGuWUFlGn/VIV/7z95Vas6/hLV9s/hXcTmnc=@lists.denx.de
X-Gm-Message-State: AOJu0YwpcoYEX8ZZJm9DmKHTYy0soLbpVpHXQ7Iu9hWByj9Z9vkSpu8k
 mida0kkGDOh71U7x5oll0DKqo9zkPTbrSh7cXSaD2Dn7P+m3NmiEawnLht0z26VEch7pvCu+qSv
 bFLthR61qC4vdYGN+eLmA8VdJbN7MkWtNCNUks+OOhmTgmhs=
X-Google-Smtp-Source: AGHT+IHFaY0rp8C/vw6/cPPnBpMXhNEnJK0JvPMEZ8bdW06X1q2WrLK3yF8lP8cJibFYCg40jQIx3MMBCuXz/Hmcxa4=
X-Received: by 2002:a05:6214:e83:b0:6c3:6344:d4e1 with SMTP id
 6a1803df08f44-6cc378ab19dmr83112036d6.20.1729206702551; Thu, 17 Oct 2024
 16:11:42 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:42 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-4-sjg@chromium.org>
References: <20241014223212.2212442-4-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:42 -0700
X-Google-Sender-Auth: s7Aek-hvzCZnbLAruesvp1X5f9I
Message-ID: <CAFLszTiUubDHV2UhJ0JoWUvQpvRL4PjhY3FF-HsuaCN5pW4BnA@mail.gmail.com>
Subject: Re: [PATCH v3 03/20] expo: Place menu items to the right of all labels
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

At present a fixed position is used for menu items, 200 pixels to the
right of the left side of the labels. This means that a menu item with
a very long label may overlap the items.

It seems better to calculate the maximum label width and then place the
items to the right of all of them.

To implement this, add a new struct to containing arrangement
information. Calculate it before doing the actual arrangement. Add a
new style item which sets the amount of space from the right side of
the labels to left side of the items.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c          | 13 ++++++++---
 boot/expo.c           |  2 ++
 boot/scene.c          | 52 +++++++++++++++++++++++++++++++++++++++++--
 boot/scene_internal.h | 20 +++++++++++++++--
 boot/scene_menu.c     |  9 +++++---
 boot/scene_textline.c |  3 ++-
 doc/develop/expo.rst  |  4 ++++
 include/expo.h        | 12 ++++++++++
 8 files changed, 104 insertions(+), 11 deletions(-)

Applied to u-boot-dm, thanks!
