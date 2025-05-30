Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B9FC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42061831EA;
	Fri, 30 May 2025 17:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XLuiAFod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC5682CB6; Fri, 30 May 2025 17:42:34 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A06801BE
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-604e745b6fbso4168179a12.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748619751; x=1749224551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g/39nu5KK45btYA9qbovdsJnhf0fgWPf9KXMOTqNQQ8=;
 b=XLuiAFod9I0chiHBGX6URfBARJpm7+SB3D6FTy7UdAsXTBagUaxnVfHp/wF3I5yKSv
 9jji2/34Lvgn9G1JJ1jQtvDkusXp415yL+oX5hYFeNUsE4XC7qdaC5dZ/RiM9jZO75ZW
 PwhntQK8C6Bc4bXoaoGo3fKPb5ILnbgwa1KWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748619751; x=1749224551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/39nu5KK45btYA9qbovdsJnhf0fgWPf9KXMOTqNQQ8=;
 b=bI+LRyh6T5EoxcOcKgBdzueMTxUz0UzRfFh7YPqFuTW/JnAtZL2m5Yq5BeRqzLp3iG
 jtWrpYU5qLTRabAVmxl/xQnSUm4I6pssvdoC2oDWAVanA6z0FvLUCVP6u+4bPsamaWyI
 wvG42mLjCionuJjJSNqtnP9+ntclA8Gs1DJXQAqQK7eXT9C4kTtqp6JSR26mCIfpRRMk
 U0qaNOK4A3jdVdoG97Kud+afmQY0GsOq0nRV4XMfKjm3x80BdJ+BKUNhj+/oCjrwldro
 SUHTyOOLEdFMruMYy+6Hr/x9JS+dlzHDDWcmqArkkGTbAkqX4YrciN9ttI6K5up/sL6B
 zHlw==
X-Gm-Message-State: AOJu0Ywig0nNF1ATHpMaA9dvgHf3ztyPOVfpL/vQk50P3Z8TwdXj9+5w
 CwPjKOBnKHmyRdWxdw3W6H9eI6+LluPEXDdO1+yBbuD4pe0mfgXWFfpR6Uh9aZlfUwfgF52G87/
 3CIU0HamB41tqcCwBh9ecw/AOwLRqaxLtF9YLZWLTWd8lBcST6PpvPA==
X-Gm-Gg: ASbGnctnXh5cGtP236WmkDmKs0jYgSz23nYTZpy8DCPolW7PIV0kBIUPuiSOBlef840
 sqB1Ovfa3pSC8lKdC2FCXPjsov/KhHn3Jbma3hJfdM0PV66Bf3SNvgDsVgitzdnKf8JvAEwFhq7
 YGtaT0QWu9KMO0NCxlEO4aBEvIqBmXBu8=
X-Google-Smtp-Source: AGHT+IGVQ0+n8mJiECwPqWHQCF6bo8iSZZ1vcpY1EiIS+ZlKYNT8GZadQmQ4ktEyTjKLwMorDNMVtoI26YpSRq5qgms=
X-Received: by 2002:a05:6402:2708:b0:5fb:c4be:b1e with SMTP id
 4fb4d7f45d1cf-6056df46761mr3563486a12.11.1748619751524; Fri, 30 May 2025
 08:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTiFLpYoJnu65CWgqKgq6=ffXpWh4kcXqSaBjAwgkoP6vw@mail.gmail.com>
 <20250530140650.GT100073@bill-the-cat>
In-Reply-To: <20250530140650.GT100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 16:42:18 +0100
X-Gm-Features: AX0GCFuoVXUbMy_j2w9HM_mQ1mgv6vw_hPDWlOYDARe77FVnIm8F13roG0lRUwk
Message-ID: <CAFLszThB6uWQuAM2e3UP1_x1qRWjBU24cLYApjs8RSN7oSHHTQ@mail.gmail.com>
Subject: Re: Azure runners
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 30 May 2025 at 15:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 30, 2025 at 02:31:13PM +0100, Simon Glass wrote:
>
> > Hi Tom,
> >
> > I have always found the azure pipeline to be slow, but I found that it
> > actually does support having your own runners / agents. I set up 8 of
> > them on ruru:
>
> I had not seen that before, can you please send a link to the
> documentation you're working from? Thanks.

Hmm, actually I used Gemini, but here is a link I found which looks
like the source:

https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/linux-agent?view=azure-devops&tabs=IP-V4

Regards,
Simon
