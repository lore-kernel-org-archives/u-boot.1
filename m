Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57234CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7702D84881;
	Wed, 27 May 2026 14:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RRzAk058";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B40839A8; Wed, 27 May 2026 11:49:33 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABA18056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5aa4b50e054so597231e87.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google; t=1779875371; x=1780480171; darn=lists.denx.de;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lHxrSV8cA+jdhFM8foa0x/t6E41H8od60xTo95YJAu0=;
 b=RRzAk0586uyfMTj5wbfnBd9kMtW+LMrJQoZ9L2BWXfa+xILETReubfwuIfvoGSugSH
 5/Y9jKkZp7360UqOCRGQhcwNpiihxKeaN5M0NkOY0wwWkzgTkcXYvUYzbz/EwlHOB8+9
 GB+HyoTAq/gvBJvqvsOsPEUKuYKz5qpQNdexk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875371; x=1780480171;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lHxrSV8cA+jdhFM8foa0x/t6E41H8od60xTo95YJAu0=;
 b=XWHJxBzWUx/s4NsGnxt6O+1czbJRozz0HfJOFcT3Dkc3sW98y3xntjj5n3k+Q7lAdn
 ayQaf/BsjhrJhZGPfY7yhWvHGHkCgFeTYEAL448xEI7nPAB2AMAvDnGoRlSpyUEczgNW
 K1jObdKnUPTgw9+HTtIPos7IkmH+yEt/IiyvKMiBunPa7LcxM5NSJZcLsLXFyqKAL2EU
 /bvjDC6k08uRYSaVgSbLse64EMzXicS9vyTnyt4S0FOWYlRIYUcPsIAEwoEIOsjLPFAI
 ZgbSLrRn360m1XPO6rclrIoTDj4g+QxsDcad+sjZ4qSO6WNajUD4C4j5w+nBMAPQ2CzA
 vrMQ==
X-Gm-Message-State: AOJu0Yxjf82rJ5w6NLNijUY5xythGiNnScaYup2RygKQIJV3lyR84TXd
 03HyojI+CNQ14e+dXDgZmZ0afTKsIyTMjjvkgJAHsyj21tZLgUZtKh5kED24JpP6rQFietov5U1
 lgkyiokc=
X-Gm-Gg: Acq92OGeA1kN92/JVnP7Pi7JCwdIZGyFRs1hczXYEcNMlpBSoHH3eP+y8uWtlMKdtr7
 JZiZOxRcfbFB15QQ7HrRCKr7T/l7xAtkQTMvo5EDQU09sE4Sg8a9/EmCgWsWUMRQLGVmxsAG2lf
 XqXkOWyEOuat0CfBH6yi8oTtXqkEedB93EmaQ35k7h/WpIiTuMfDGs9UTMD5FmvjATeOEg7LFwS
 RSvQi8aQU2YcKjeQnRa1XIkcVLekRDvZfIOmrsdXdYV5ldAE16RO4IEBCEogAy18jpVDJgqGz5z
 +FIBje5h1q1zfIH14PSLBxshZP+b4EIAqu4O8M8KFX32FjgfcZc0x0aF3dwPVMME2lThiLsBT+e
 nwXMlRgCeiKEsfs9rkdlyxz3pcbrj5gZJm2wVL5S7bVtprZVWo8wci2YF8pnDUrlAtciy4mhIsk
 Ydh92/MTITPyDp62x3gGLb5A==
X-Received: by 2002:a05:6512:39cd:b0:5a8:88a6:3d65 with SMTP id
 2adb3069b0e04-5aa323843c5mr7557451e87.34.1779875370633; 
 Wed, 27 May 2026 02:49:30 -0700 (PDT)
Received: from localhost ([81.216.59.226]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa462d995dsm993214e87.25.2026.05.27.02.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:49:29 -0700 (PDT)
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>
Subject: Re: [PATCH 2/2] dtc: libfdt: Introduce a can_assume check in
 fdt_check_full
In-Reply-To: <20260526202218.4004070-3-trini@konsulko.com> (Tom Rini's message
 of "Tue, 26 May 2026 14:19:28 -0600")
References: <20260526202218.4004070-1-trini@konsulko.com>
 <20260526202218.4004070-3-trini@konsulko.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 27 May 2026 11:49:28 +0200
Message-ID: <87a4tlji6v.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:52 +0200
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

On Tue, May 26 2026, Tom Rini <trini@konsulko.com> wrote:

> The current upstream method of having a function omit various tests is
> to use the can_assume macro. Take the logic we had previously been using
> and instead make it a can_assume(PERFECT) check within fdt_check_full
> itself.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I will be submitting this change upstream and will follow up if needed
> here.
> ---
>  scripts/dtc/libfdt/fdt_check.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/dtc/libfdt/fdt_check.c b/scripts/dtc/libfdt/fdt_check.c
> index a21ebbc9239f..7509c11d8580 100644
> --- a/scripts/dtc/libfdt/fdt_check.c
> +++ b/scripts/dtc/libfdt/fdt_check.c
> @@ -21,6 +21,8 @@ int fdt_check_full(const void *fdt, size_t bufsize)
>  	const char *propname;
>  	bool expect_end = false;
>  
> +	if (can_assume(PERFECT))
> +		return 0;

Is this right? I think that would require changing can_assume() to test
if the given mask is a subset of FDT_ASSUME_MASK, not merely intersects
it. When called with a single-bit mask, those are of course the same
thing.

Because as-is, can_assume(PERFECT) is true if FDT_ASSUME_MASK has any
non-zero value, but I don't think FDT_ASSUME_MASK=ASSUME_LATEST, for
example, should imply "perfect".

Rasmus
