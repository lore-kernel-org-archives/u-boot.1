Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CA3CE8D58
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 07:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2E789099;
	Thu, 19 Sep 2024 09:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E69IRiEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39337890D9; Thu, 19 Sep 2024 09:26:45 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3109388FDF
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d3e662791so26349966b.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726730802; x=1727335602; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qYbvkWsnfnU6qkXDLVCB1i3Jwy3nXp6nn9QRp/Ge3Qs=;
 b=E69IRiEmIz6ZlrgYmjN/Op9S5sDcBTmxuYXvdwYk+x5A6Wv0D9sqxL/eigN6veko1p
 oTz905M5TYO4AdKuEHjagScBM4w4eX1bCaKj9Nd0SNRBW6UvxiL9d/YXtOhHbmQvp1IS
 kFf0mCJxz6EwPqthlvVEP+XLnCZR18aMdD9UgZgO+G7W2Z4M0TGonhV+CzSkYbzX2qgT
 Oigr1rO4OxlpKcPTMsERNMFYJ0sZGHZ2Q5uo1Lyxr6MyE+9qBcwV7evumk8r3bAR0I0F
 lt5af+TFtlcNJTUCJSu7ba+SGwD4AO/LOZyD9GQMhtqVbeeOH82WkEa5IYaVn7CM4d6i
 +bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726730802; x=1727335602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYbvkWsnfnU6qkXDLVCB1i3Jwy3nXp6nn9QRp/Ge3Qs=;
 b=AWRhSufq/kfFJIXWMiD53dtdbQDJlrjYNZwM2RWw29u83dx9vRA02H6Vudb4MwV6Br
 Jh+HY7hovqjTlY0Y3VZpzt38Ot4Lz9a5lLWuImWRfpJOuaXYnxbNoFtgEX8NKKDvS6PX
 KWyMrkYL2cqss7GhJyoamfVmL56M5OPPb411HaABCNscLfLXzem03WlWj1rJuxbQXV4L
 hbMi8EumMr/K03jAt17AXwzhcI6Gsq8UusmNgutvxGuoALeQccC31nRKAiJ0sxQ1L1wm
 pJ0fVdlO535zOtb7MMauSV/qUtGNMQmcdDkSywdlWP0g8HaXPNOOO0bqemSnC0V8r0i7
 MZeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLjTu0cIK0BKrbUaaMqgHar4xUpILoKOQO/oDnVa/aBgJv9j5CftQsmG0VHs+nsUF8UYDdPqk=@lists.denx.de
X-Gm-Message-State: AOJu0YwQCYg5tNEJBYXfo2Aq4zTuYNeZTNrVk5kslEQ/uco1ILSrbDUp
 VUaUCs7VI4TzKbBxRz/jTmsTAgH5LWQzcgTD62d2cuk90zNZ+w3xfXjLQfU7fwrOYTtKmFmYm1n
 5QLYo9SzCEEp0jV3L3j0adT35VtdgniSdU9nONA==
X-Google-Smtp-Source: AGHT+IEARxWT3d2pQykKcjsljNlRih+CM6PuQU+t8z/a8dT7cyp2fSbeT5VRJdg0x+v3eckUk04FNidHOCosUQjNxZo=
X-Received: by 2002:a05:6402:1e88:b0:5c4:235a:e66 with SMTP id
 4fb4d7f45d1cf-5c4235a119amr26649731a12.34.1726730802583; Thu, 19 Sep 2024
 00:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240918213934.19875-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+2C8LUuorb6L7cEhBLGNUQLJzMaKgDmw8P2pDsLCWJaw@mail.gmail.com>
In-Reply-To: <CAC_iWj+2C8LUuorb6L7cEhBLGNUQLJzMaKgDmw8P2pDsLCWJaw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 19 Sep 2024 12:56:31 +0530
Message-ID: <CADg8p976LdwxqM9brOn6JmzvAEwHeHYu4T0Ps2TuYxw1gA9KAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lmb: add missing LMB_NOOVERWRITE description
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Thu, 19 Sept 2024 at 12:35, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 19 Sept 2024 at 00:39, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Without a LMB_NOOVERWRITE building the HTML documentation leads to a
> > warning which should be treated as an error.
> >
> > Fixes: 5e9553cc72b8 ("lmb: allow for resizing lmb regions")
> > Reported-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  include/lmb.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index fc2daaa7bfc..8ed5ac0a4fc 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -18,6 +18,7 @@
> >   * enum lmb_flags - definition of memory region attributes
> >   * @LMB_NONE: no special request
> >   * @LMB_NOMAP: don't add to mmu configuration
> > + * @LMB_NOOVERWRITE: region cannot be resized
>
> I think the description is 'can't be overwritten. Sughosh?

True, 'can't be overwritten' might be a more accurate description.
Maybe, 'cannot be overwritten or resized' should also be fine.

-sughosh

>
> Also, I'd drop the Fixes tag for non code issues.
>
> Thanks
> /Ilias
> >   */
> >  enum lmb_flags {
> >         LMB_NONE                = 0,
> > --
> > 2.45.2
> >
