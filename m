Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D42CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAED783CB9;
	Fri,  7 Nov 2025 11:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q3Uzdyn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC8B83CCF; Fri,  7 Nov 2025 11:01:31 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85DE683CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7260435287so80254966b.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 02:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762509689; x=1763114489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DjmbdB7vHbxfGldPvLcOi/5rC9Gx2UEfMmdYVVW6gjI=;
 b=Q3Uzdyn9KE7r18V3ylCUk5sGz4lFBIWn3krVty5suGlv7lKDqASihab/PnsBty94rl
 cJ72KjXXFdIZb96jA6UKfktaeuiAGYIL8JaiZ4B2d2dd2L0xAoqexFQQ9zVead7bVJXC
 KRVqnB4y5hki9L2sgWbT/cisw+oeB9Qd+nQXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762509689; x=1763114489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjmbdB7vHbxfGldPvLcOi/5rC9Gx2UEfMmdYVVW6gjI=;
 b=A1of4VyI7OSADWr156l10fYe3O/YFTs4M1eZJP7+TKZs7IMSjh9wV9r87KDxzSGCYl
 B0Z+NINVvIO6NmThYZ2VglTnsXesjaSjBiBRioCs5dbNJOrfhipPD3PfK39OBCH/O9s8
 WTRgrSH6zE67ZH8VzDfs0umNxSE3+HPm3y1TR3NmXXtM7G7gZupsRWJv2QISGo/eTHCy
 Nq5zoO62+mqjEszXw04AOnNlOXxNjYRJPOIUfbIb/xdo/BAGn72WCvLhYnsOI3WJKiDy
 oSFNOjZhU4AnxNxPs1ABswabQ2WBESlG0BhFY/Hsc9+KTayULA6NrqaSJMcWEtLTPvM2
 dr1g==
X-Gm-Message-State: AOJu0Yy180FLCgVhPBs6VQzXddcSpkBTa23fQNedgKqseQEJtsHAPK1Y
 yf/O/ulvyjNBBa+RMOwloxPfavpAi1vskgy3Onr9UMSY0EdypFVQPcaq/Oau8+5XbVwPHG883mr
 oj0vjgkk/dG3BlVV/GVxJQjkHgS3pMGERbvC0NJM+
X-Gm-Gg: ASbGncs+rG4r7WvWjlK+iy1zgeAtNGa9kWEPVfFDxQYTc963iWrdG2w1QGWiozo2cHp
 DOq7BerPillCWeTRAdpdIhppV2KBmI3GZUozsRLJwjxiThnVd7mK1Gb8FojrY1nH3OxiAIb7i6V
 XZKL/clUzU3im42sf6av6A8QQkk4ckU/BCQCKth+xmtB8CalQiyVHXNMNfdRHmrufDeUEclSJmI
 26inaxsuqA7IRKYdcpNy74eQ4yl0H25PX9l67hjNWl8GWCobc3dPJZLuw9AwQQLZoaf1gfL6Y9t
 yIrH6w==
X-Google-Smtp-Source: AGHT+IGIplxKUMSCKhcWOvdvzVzpkugxZYZ9Rkn4l0dhqRxlKgdyO9lUhh6MsJNKN/aGqqmWvhhnh0829yJfEc1FB3M=
X-Received: by 2002:a17:906:6a08:b0:b72:5a54:1720 with SMTP id
 a640c23a62f3a-b72c09b669amr259629666b.57.1762509688747; Fri, 07 Nov 2025
 02:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20251030043558.2620797-1-trini@konsulko.com>
 <176246627096.3129497.682434390557357881.b4-ty@konsulko.com>
In-Reply-To: <176246627096.3129497.682434390557357881.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Nov 2025 11:01:17 +0100
X-Gm-Features: AWmQ_bn9hbO5AvaSANtn1O4QX7UrBxk4jyrB63iQ1d8DbLKCx1AI8CJKAPOBX30
Message-ID: <CAFLszTiCY5z6ZFag87rtM+UpGmYUywhgkH0Oi9WqysB6J4mr1g@mail.gmail.com>
Subject: Re: [PATCH] Gitlab CI: Rework our tag usage again
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Thu, 6 Nov 2025 at 22:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, 29 Oct 2025 22:35:58 -0600, Tom Rini wrote:
>
> > Now that we've had jobs running on both amd64 and arm64 hosts for a
> > while, we have enough data to look at usage and findings. For the world
> > build job, make use of the new DEFAULT_FAST_TAG and only build it once,
> > on either amd64 or arm64 as we don't run in to host specific results
> > there. For sandbox, continue to build on both arm64 and amd64 hosts as
> > we can find host specific breakage that way. Remove the mistaken
> > restriction on sandbox64_lwip.
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>
> [1/1] Gitlab CI: Rework our tag usage again
>       commit: ddc916334a7a7e180b532dbb2cf1b778466d2b9b
> --
> Tom
>
>

Good to see this! I would again like to suggest breaking the world
build into parts.

Regards,
Simon
