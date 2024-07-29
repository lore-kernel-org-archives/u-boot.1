Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB37C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C136B88847;
	Mon, 29 Jul 2024 18:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UJIY1EqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725CE8882D; Mon, 29 Jul 2024 18:19:25 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E22288872
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7a0ef0e75so20373176d6.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269960; x=1722874760; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D61uzWyvRyM070EEhc4gSKZhoyIFnEnBr19G6iO2Gsg=;
 b=UJIY1EqBvMkPzsQFKlM58HZGC88z09bDLmCOrQFZ68k73OsS6Ra5f08eF4MuK54Y1u
 yfhe1ngaZCbGQu6gOuCMBY3hC7bheGUpuJZIaP6dh/mxwNULSjDmuqtASkliWi1AeVIg
 DMk0giNwgOlDpx3vK7+mo4e7x5i0648sGK0Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269960; x=1722874760;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D61uzWyvRyM070EEhc4gSKZhoyIFnEnBr19G6iO2Gsg=;
 b=aK4HK0lEzpU5CWiGHE5Adp/vSK5fQ9gl3XYGQMWKTY/DFn3MSJQ0deRhrgQeygQwk5
 VLKap4ewUcAhYpGxDjWekfec2I2IOjfKqpvl1IRe/8HhK6cHQMjeZ29GmmxDSAclNXXA
 TaDR39iBjWJqd1aD3T8ZlcW7vg7T8oxxC2+jAXbMuYfQkSf4ni7d8mSybf78Grc21fVT
 2OB3ark/UOOsEHGKeVUUFdIbDfyJlJrm6KoiSrnH/TS5rOAD1Z6btXFLQgIq4NQ4kOFp
 c56C+zGJp7EWi8B5/YrjWCKbwekAA5xt2J1kwAnun0/V7hoxTil49+JO2nr+642GqkIr
 G2UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV84abOCg0jQtuw0iIS97HYmQ1EVy5bePRF2vRD4Fg+M2ynlO/EGy8ZEp9KXQFRKzubwuuTU7XCFP2CcufsbvlRus4Ag==
X-Gm-Message-State: AOJu0Yyd1Hwwwpyk4/0iaY35UfsVBCuTkqgVq9ILhYZUaNFiV+RwBA3k
 IphhxdYfbju1ygssHx2c3N3UL1v1RLNPXK8gjQ7dd9m9xOGCm+LW7mFu7q3XfRCOBy+1VZAjss9
 KjBEyC7hEZxfYkZ41zOFftHUYbz8VfK23piCu
X-Google-Smtp-Source: AGHT+IGDsOcxvwsXMKymN1W4aMC4voNjxd9eNA1HpffK39hicC5a1VdBt2WjfPqjwnx4cMTwC01sfSoas+ZHmYCTTmc=
X-Received: by 2002:ad4:5c61:0:b0:6b0:6dba:c947 with SMTP id
 6a1803df08f44-6bb55a0b2abmr106363446d6.18.1722269960364; Mon, 29 Jul 2024
 09:19:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:18 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-20-sjg@chromium.org>
References: <20240720104950.2730773-20-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:18 -0700
X-Google-Sender-Auth: RBV4_EGS8z-QjFVmAL-DOQkO-LY
Message-ID: <CAFLszThvvprsEM-q=bTTrsLp-5Nguz09L1d7bbUcQjdh4s4_SA@mail.gmail.com>
Subject: Re: [PATCH 19/20] Makefile: Provide VPL devicetree and padding to
 binman
To: Simon Glass <sjg@chromium.org>
Cc: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Provide these parameters to binman so that it can produce images
targeted at VPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

Applied to u-boot-dm, thanks!
