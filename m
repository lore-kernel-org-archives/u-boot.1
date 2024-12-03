Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934CEE6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26E818953B;
	Tue,  3 Dec 2024 01:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BH2LOiNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88D288A0A; Tue,  3 Dec 2024 01:23:39 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11AC895A9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa520699becso800160966b.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185417; x=1733790217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1MWdOQGHlQJ9JfKU7IyAnYi7CBbrzqyEocSpIiQUzk=;
 b=BH2LOiNgZN3CwmDOcTej9gC0idGemfF2gHNlI1PClMB7coVamA5TAfkZALMRXNK+UA
 G6t9g5/ticVIKGCdr9KDK5Yge4ZaD+EpwnaY0/kJKkp9/PBpT28crMI9AO47dtZ9y6xc
 Er3tcwmJW08G7qZvxHB0IJlOYDreAReH0Vtno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185417; x=1733790217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z1MWdOQGHlQJ9JfKU7IyAnYi7CBbrzqyEocSpIiQUzk=;
 b=EuI61UqkWGzokRdgzLpD3P0rzx9aM1X/PmLmIOZPlQl6fUR5lYgspDX5N59KKH3Zic
 BeWapPGRgKxsNqmVcu6D2WywL32zRZyBssh8zCwzDVA1sRoO5zkaG7YNVE7JLN0hrTtx
 PUEySA0Hyy1TzhqPETETf4ySRWJvQyAH/PhIzj5IQzA//YmRuPXUuv++0TY0YIfDnK8t
 yUofzPIdmZynoVHWrHPllSimGDdf1fgza8lohSDDRmS5p/gEHRyDBgQ1Bl45LqHbqOeB
 NAiolyKG6CM3ot8+AoURE/lSyJmc3Ebmtte1QFftPX2fpr09QCt/c/HQSq3VkU14HpOJ
 +xmA==
X-Gm-Message-State: AOJu0YxEbQOz/HBMWkGa5yD33Q/AgOmYPyxY2upvQW5UEQiU8HnGflgJ
 S7TPrls8o/Bocv+XMffGXw9eteeSFp6wmFscrnVy3dmn7TmLCvfY3an9HRroUin7mu8A7Q0gfcI
 9zgYpXgbieHUL1N/N7m4XAXb2wwFk5ygV3UkSaXJ+8bYGYh8=
X-Gm-Gg: ASbGnctyckfhlqlYd+u8fD1B35ILpVlKRANa6bcNsr79H5mqIom2XKqpQuv0Cs5Kz7z
 YWfv2VXOl0EZrZ9j7loaN06HMJh32Uf61
X-Google-Smtp-Source: AGHT+IHARuPQXed7kA1vndQ075hUqCsdsZcgCXaYK92is4JPqrPWP9tj5rfjFdPWTWJkPnj1U8ke/LqqvtOx/XbNnVc=
X-Received: by 2002:a17:907:770c:b0:aa5:14a8:f6d9 with SMTP id
 a640c23a62f3a-aa5f7d4dbb1mr18137066b.14.1733185417358; Mon, 02 Dec 2024
 16:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
In-Reply-To: <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:23:26 -0700
Message-ID: <CAFLszTi0SQft1EUh4GYrkcC3F+r_s9h2PcMWWUjtGTVSLAUkhA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] efi_loader: Add support for logging to a buffer
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich,

On Sun, 1 Dec 2024 at 17:24, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 2. Dezember 2024 01:12:36 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >It is a bit of a pain to log EFI boot-services calls at present. The
> >output goes to the console so cannot easily be inspected later. Also it
> >would be useful to be able to store the log and review it later, perhaps
> >after something has gone wrong.
> >
> >This series makes a start on implementing a log-to-buffer feature. It
> >provides a simple 'efidebug log' command to inspect the buffer. For now,
> >only memory allocations are logged.
>
> In my previous review I suggested to move your work to the level of the logging library lib/log.c.

Well, we could do that, if we actually have a need for programmatic
logging of other subsystems.

>
> Why are you reiterating your series without exposing why an EFI specific solution. should be desireable?

I don't see that need yet, or at least, not for the purpose I am
heading towards. In any case, we can easily refactor the code later if
it is needed. For now I believe that this logging feature will help to
tame some of the troubles we have.

[..]

Regards,
Simon
