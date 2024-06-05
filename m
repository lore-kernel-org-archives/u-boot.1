Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F71C27C50
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A47882ED;
	Wed,  5 Jun 2024 04:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHcKcazi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22DA88268; Wed,  5 Jun 2024 04:13:51 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8A988300
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6ae0bf069f3so29881876d6.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553627; x=1718158427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uLxQO9U0NOj18WhmHRaS68Ud3goD0GAkXmlDAjdnv2Q=;
 b=EHcKcazi3nL2SQ2c5UVsXWTTXGgY470ayAL7mrpwqUgTIguk3QnaAs5Dv2zg+sYpcR
 KltBRNNCAm5pE+u1ttdmEVO4+REPyQ6J0tqIuBMSWX9afer2oa4f9C4rwLoDtgSHAZlg
 rFMlBBBkULDjg5CEQXQ3pkQ4JCgJmzUJ2qrtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553627; x=1718158427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLxQO9U0NOj18WhmHRaS68Ud3goD0GAkXmlDAjdnv2Q=;
 b=cpdYIFs4SoEAlnwSNuVMxR6M0JtV8qdfYNlttw5ViBEZKSzqwN+kVb4pB70p5Xmn0L
 toRCrcX//qZiVt+EQCPyVZXue+jgIYIwZNoZ+/d7VswpQpJd9ChCBIdPrLtEnqtrQjP3
 7o0ceMdQ1YQVfR2A4B6Gie78IbfvICs8zwpsZS+bMqS34aSVjhlRCmwBqBvK0uutfN37
 buxhS5L/7a0JlK/Wu254LkW8TNPvuko3LWV9m1n5Rmcn9x0Np5VTe4/WQ4vgoG5A5V3Z
 Ss9S0ayNIh+2SuWQ/m4vSebFBMS409AoZCLd5t1u5iKCrA4q9jfYU4Omr0czNfOsr2u4
 kSbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq9samKRjTGWaCO6mPcQU6pX5cl7oBWJSrzP4UFVcI6w1hxvDiHRbSnOejTctruBy80XVaJktAH/bodY0ZRW9rrIoZcQ==
X-Gm-Message-State: AOJu0YxmSaQiGrWwRfy8rRK/jyVkrvsfT8FRR0v52OxBQvoq3mu7toOk
 z2O/6wCpvtogZ+5Gqnbwwz30NulEHYfca3QZNMF4ouyV50SgA0rdf2muSAZJKsNAfK8bHPjwmdS
 jTMrjFVw+s6XpQQgkTsE5nbFfp4uutyts1ppz
X-Google-Smtp-Source: AGHT+IHqxnuKJj1aLCL3YRxSNgdLSsG8ZywS0FXLlEYM5tyVgoQwHD990LvzD1yhFyjy6rvLxT8WDalIOE1CjsRa55Q=
X-Received: by 2002:a05:6214:4601:b0:6ae:e4f9:cb8 with SMTP id
 6a1803df08f44-6b02bf83096mr13312816d6.38.1717553627116; Tue, 04 Jun 2024
 19:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240604195256.1820285-1-sam.povilus@amd.com>
In-Reply-To: <20240604195256.1820285-1-sam.povilus@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:36 -0600
Message-ID: <CAFLszTgRAwRrhMQfoUDHg9tGaTf4zLBtHR_QWFQRodh4JyoNJg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Cleanup fit documentation
To: Sam Povilus <sam.povilus@amd.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, git@amd.com, 
 michal.simek@amd.com
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

Hi Sam,

On Tue, 4 Jun 2024 at 13:53, Sam Povilus <sam.povilus@amd.com> wrote:
>
> Sam Povilus (2):
>   doc: Remove extraneous curly braces
>   doc: add clarity to what a "fpga" image is
>
>  doc/usage/fit/source_file_format.rst | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

This is now at [1]. Could you please instead do a PR for that?

I am not sure yet the best way to incorporate or link the FIT spec
from the U-Boot documentation. I suppose we could employ a script to
sync it?

Regards,
Simon

[1] https://github.com/open-source-firmware/flat-image-tree
