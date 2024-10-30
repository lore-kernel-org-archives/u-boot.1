Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8976D6B6DD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 23:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A715889276;
	Wed, 30 Oct 2024 23:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a6lBzO0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3448927B; Wed, 30 Oct 2024 23:59:40 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D71748927B
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460c316fc37so2715301cf.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730329178; x=1730933978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qu7tpzIonREGIef88MUDLfS6ZPyJgbLnLnvHZ2JGq08=;
 b=a6lBzO0Us44XWHHWvSMq9kwz61kE34llsIM+Q5IyqO1wtbWGCuMurpVHJmTZqQXcpp
 1GWWXEwvRWCG7EoVcaFrNhw87OgZR7d3ea5JuZ2gvVlCGJeoy64nHhHub0xWpGOHpkFi
 +bcPK9ZFm0iZhfUu5pQOR1clTILO5NgIWlbCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730329178; x=1730933978;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qu7tpzIonREGIef88MUDLfS6ZPyJgbLnLnvHZ2JGq08=;
 b=iCwGAjmpTqB84PIskapg5IsbLem1X56RlTLFT9kDMMBrKIupTFCsIGLrvbkzkmcURA
 kGowczMNlOE9Wf6FOd0nb22KEod7Mz+50hZUNMX7bZ8iOb3iVWGbkxRVRrC4SMlz2uzX
 +KU3eIl99mvql7zM3B415QOXI1CudvG3SPfiVutoeOgm6Ij0M4hHr/+szwsy7i5XW6ni
 p8ua4HLOlB4zZl3FPYDWsPtkfMzoIIxtwdyX0Ir/3uo6kd9X4GSnHCOV2mv3bh1Q2461
 c0ECot85Q8h/d8KHBNBq/GSaQ+lXLwzxCIIxQzmRwpHDws2H1esEByJ3hCvzrlx+VMtc
 U5yg==
X-Gm-Message-State: AOJu0Ywe/rW8HQy0bAlkQFANwhJCNj7cSjyC+CV1gQKj8ObaJVyKcrcH
 aQvtNt6IG3+sWD+F5HGZy41pgno+yQti/V/psG+uBMPjMzIhWxwHd0IXH3fYcOc=
X-Google-Smtp-Source: AGHT+IHTsWswvlIHaYjIBSTj3WCv1o7a0kdIluKsGFLKICoV4pcccfaFtpFS4vYnibcq4wgJNEx/HA==
X-Received: by 2002:a05:622a:1b8b:b0:460:8f80:909a with SMTP id
 d75a77b69052e-4613c030d57mr251304561cf.32.1730329177762; 
 Wed, 30 Oct 2024 15:59:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0896e9sm1257861cf.11.2024.10.30.15.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 15:59:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Markus Volk <f_l_k@t-online.de>
In-Reply-To: <20241030050716.854676-1-f_l_k@t-online.de>
References: <20241030050716.854676-1-f_l_k@t-online.de>
Subject: Re: [PATCH] scripts/dtc/pylibfdt/libfdt.i_shipped: Use
 SWIG_AppendOutput
Message-Id: <173032917648.2233801.15079687798185605744.b4-ty@konsulko.com>
Date: Wed, 30 Oct 2024 16:59:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
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

On Wed, 30 Oct 2024 06:07:16 +0100, Markus Volk wrote:

> Swig has changed language specific AppendOutput functions. The helper
> macro SWIG_AppendOutput remains unchanged. Use that instead
> of SWIG_Python_AppendOutput, which would require an extra parameter
> since swig 4.3.0.
> 
> /home/flk/poky/build-test/tmp/work/qemux86_64-poky-linux/u-boot/2024.10/git/arch/x86/cpu/u-boot-64.lds
> | scripts/dtc/pylibfdt/libfdt_wrap.c: In function ‘_wrap_fdt_next_node’:
> | scripts/dtc/pylibfdt/libfdt_wrap.c:5581:17: error: too few arguments to function ‘SWIG_Python_AppendOutput’
> |  5581 |     resultobj = SWIG_Python_AppendOutput(resultobj, val);
> |       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


