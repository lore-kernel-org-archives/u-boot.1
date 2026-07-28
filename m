Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342BCC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B351681371;
	Tue, 28 Jul 2026 12:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIV9zG0Q2aMO; Tue, 28 Jul 2026 12:49:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05E0F81364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785242944;
	bh=AA9gV3ehlfLl2BX/3dovxzahw5Se4gGqh9oaULfLuc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qnjqE7aC0lMOdDszwmzv5LJB2Zuv+DPWqJB055vetMj/nBsY2nkGEfND+oPSDIO4p
	 1Z7OuLFudkxDH6o7eY2oFeq7rY/gIz672s4TTB8W719u7IdMKAC7JKTgLL+tr7SVoR
	 PgbEZeza4rBsaS7L4hOV7hfSXADwugDA9zF+fPaSic9T50fLp1QWOyN9+8Z4cmkj3a
	 yyTkX9TG7S/BtS+eAgVXIfZv1GYbmnDw4f4R0tMroz8OsfGI8Lm7ZxRWDTx1Eub1n8
	 FRwg5CPSSDkax2e43sebgAxdPyBgUr3sojsGLZ/Ac0acaaQMAT8j6irKL2FmJwz5i0
	 9lP0d9cgu2E3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05E0F81364;
	Tue, 28 Jul 2026 12:49:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C70E1194
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B8FA681364
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWBBYYxDt31R for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:49:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1B0D981293
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B0D981293
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B0D981293
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:49:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A538494B; Tue, 28 Jul 2026 14:48:58 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D135848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:48:55 +0200 (CEST)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81e83f1f15aso13557927b3.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 05:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785242934; cv=none;
 d=google.com; s=arc-20260327;
 b=Myuv4aVSCRurcLee1pq6gEKajEHnvoA27EWF9YTKr12wC8ZhgTU4G6VS/UO9vnOsNW
 XZD+zJCwumTQTIYlcfwYOneKkxgu1x7nwS9b5V1JnAHpAXdYg8OPLKCAebxZXcpAP9kF
 1ATlfZn1zag/JKElBBNn1KCpWCzvoacb4Bv3ui4y0xoG002m2D4dQIqJUIGMJDqfZ8wx
 z0/iJsF7v3fgI24YjSnY8A6p2JDZI6mF14i/ia/oL/g1vTsp2A4XvEp+60PGEfe/1hMa
 8xWREsubNqiIq2HzvtFlLa8w19eVf8EjYWEfletu6Fo3nKTtf6PPHlTC+8zqHUIz/jOT
 ZwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AA9gV3ehlfLl2BX/3dovxzahw5Se4gGqh9oaULfLuc4=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=MUsFKQiujyPnIt7IdUb4KVQvs2mJr6cyHBpVMMcy12pK18FVzifb+KGt7UwvxotpA6
 0IzTdiE7lhv3hFoQGdmafN2KF5ERZb346fBVcz2ZCRHhbK3Cd+m06WrxtipqRZs67pS5
 BPbHqhdXzZHvvofIUyKEUvSfSxVVDnQRn14YP/WAxMXq4tBZyqhuYJsT4DIAsHJ2R83M
 HZH9Wa3xlRv3O7ZD7dzmS0Oo7a8f/9zLDs8LLlqvl/X0S4lPADLr8AbmJFlR1HCgvSP6
 2udiVCqmWUM0Bep/Q+kEbR39Olkr7hb5SoN310joLZg3ckPnDk53zcJwjTG6O1NU0vli
 yrrg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785242934; x=1785847734;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AA9gV3ehlfLl2BX/3dovxzahw5Se4gGqh9oaULfLuc4=;
 b=SOKKdRQ6KxIHYnx9uUVYU3hzRq/1hmotDDIKUY1JQrtjBEn9GddBI/OnQ1gP9KTqx0
 Vtz7c0CXZc7WIsp6FWgdm/25tGcVEJ6E9HhOTWuQgE5sa1f6QxTRIf3kvtTdKweJ3yk6
 wcuosDA0hXVd9Wr0iGglPE0o8G1CS5hGjdQcKRQait8ppaduzn2BBWqv59oLW62VZXQ6
 r+3HOYyM9/s7s3NqCIJaB/XeifGckBi1dr49cqM58HGfAwxxagCMf8YDVPoVjbfU9b13
 g60HLp/2jJgiv4iLuT3KqVaglfKSaDIbSWBMB1YCrpAWkfCW6l5ojHzhGN17hHYhGNAj
 nsRw==
X-Gm-Message-State: AOJu0YxaQwAO9Z2d6Sko+2TVB3e0IvEOp5E4ubcgIt0E/SLK9WhHWrn9
 QhrENINn67ER/0XhbaDRmaGIU6QAQ74+KfkgryrpdgafuSw84H7jOuU1BYc8sakIEUxDDI6PyeA
 EI361c31ljDn3CEEktsN726p8hgu0092CjoHPveBuHQ==
X-Gm-Gg: AR+sD136EeavamefK0BYBLaBJeffHzsWIkMmmA1h656b1gjSONbJI4THWLRBXAvW2jU
 h8437cZNuTh460VKqy0pCwvjx3SEKE9ZhBgHp/ZWkKS8d/CV65b+sK27cSK98/8SiGV4VyPs05l
 7b6OTfWeLQpop77gIpZPVQwiGEyLKWQROoeZh/8I/I6xyrQkJc8wbuchdC2uh0pVYQyZl7Ray3g
 pg4NAfx0vnLC4+QjJLDrxQpYold4Lqx3x9nnjA7N8ctB/4df2B4lNVcEXRAjtm4fuyRCz3CPNi7
 5KI+KahSomefHpKag8EjzLbTKYWPdwxHHvs7Hb+ZjQ/nnKdO8MSiawvUhJTjw6ehpuryJSb48jw
 yxFct4PDoSd/+GXX51eX4lN26vEYGofaxHXLlKc8Gqb5PgrKGevC+jzfvII5TNnRTPv04LEHuYB
 5fcWaw0Npcj83n2zMAuzfKhaw7IdNwyqtQOVkpyW1qXbH/ECo2nTr35WBLWWelXAaV6yIk38kl4
 H9NDqHSm6uaiEIwYxBonaW0kgqw5WLWnUF2C2s6NE3cavmgOt7uaTR+GzDRbOWbi+8DAg+XmJRH
 Nkqd9coFsbJWJskod98ujVj9CyiQdc1GohnxjRIwpJqOGzCQdZxOE8bZrq8T8+iaDuOEBxeIgID
 IE5JtsNYQZkbkdDqa4Ae/USA9QM7B+mycMgO/k6sDg9Q=
X-Received: by 2002:a05:690c:ecb:b0:80f:469:3ca4 with SMTP id
 00721157ae682-81f9925be44mr10537557b3.13.1785242933718; Tue, 28 Jul 2026
 05:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <fb1ccca20dc7ad495fcfad16c7e146500b120981.1783426581.git.michal.simek@amd.com>
 <e00432e5-a700-41be-9aa3-6e544236b8e6@amd.com>
In-Reply-To: <e00432e5-a700-41be-9aa3-6e544236b8e6@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Jul 2026 15:48:17 +0300
X-Gm-Features: AUfX_mzbBtBIiGgi7PkezSl0ZkJObJqUrmaBNPe-qsR0OVOPxHwbMo6kRKJtNUM
Message-ID: <CAC_iWjKtQoMDcyBxPgtYiesheXTJ-rngeqWZMyA2RacOc2mwDQ@mail.gmail.com>
Subject: Re: [PATCH v2] fwu: Make boottime check failures visible
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785242934; x=1785847734; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AA9gV3ehlfLl2BX/3dovxzahw5Se4gGqh9oaULfLuc4=;
 b=SYDIom5GA9J3I8qPbAmzjORYBAIDkjTyQi2WuxoP+3m14/I1mETkI8XjrWPJo9STJe
 tbxgbe32xwIm/Q1GeJOouZ7/Hbqj/o1VCv0YLc6ImEMLz1xyDgYRLpZzYLvBEfOGIayK
 60+6B9jnSrvVJfRb3Gz3hDn+v6z3RPYJxH5MpUicLKOOi/qc5fZgEyhjnvi1zGrmvC55
 rhXinFIIA27rMnzf5U6DwJBLlkUQpvWvHkbBwT0PFfuDOC19NHWHFVDlx2VM+DywnuBT
 V3EZWRopXyXV3utrlVnAHNIy3nlZ+29VzhdvCXW6uYAYjfH1lC/FAIvkIP71/O2nSC6e
 K0wA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SYDIom5G
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="SYDIom5G"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Michal,

Yea, I'll send a PR tomorrow

Cheers
/Ilias

On Tue, 28 Jul 2026 at 08:19, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Ilias,
>
> On 7/7/26 14:16, Michal Simek wrote:
> > On systems with FWU enabled but without the required DT changes the
> > boottime checks fail. The failures are only reported via log_debug()
> > which is compiled out by default, so the user has no idea what is going
> > on.
> >
> > Use log_err() to make these failures visible.
> >
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >
> > Changes in v2:
> > - drop fwu: Gracefully handle missing FWU metadata device
> >
> >   lib/fwu_updates/fwu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> > index 2b11e5da061d..e9bb1b4fc656 100644
> > --- a/lib/fwu_updates/fwu.c
> > +++ b/lib/fwu_updates/fwu.c
> > @@ -759,7 +759,7 @@ static int fwu_boottime_checks(void)
> >
> >       ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
> >       if (ret) {
> > -             log_debug("Cannot find fwu device\n");
> > +             log_err("Cannot find fwu device\n");
> >               return ret;
> >       }
> >
> > @@ -771,7 +771,7 @@ static int fwu_boottime_checks(void)
> >
> >       ret = fwu_init();
> >       if (ret) {
> > -             log_debug("fwu_init() failed\n");
> > +             log_err("fwu_init() failed\n");
> >               return ret;
> >       }
> >
> > ---
> > base-commit: 313a1a7bb065319dd3d57e9ab6559422771aebae
> > branch: debian-sent3
> >
>
> Can you please pick up this patch?
>
> Thanks,
> Michal
