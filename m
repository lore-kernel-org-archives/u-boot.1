Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB15BC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809558870D;
	Tue, 11 Jun 2024 20:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P2DehXoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43C38864D; Tue, 11 Jun 2024 20:51:56 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC52886F0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b07937b84fso7109926d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131913; x=1718736713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ji6uX2V38NqJuC/ZktluwlgMS8GpWD0A8sLQLJ8ZjTY=;
 b=P2DehXoaCQEWSaJKMMyNVYSalRNl7oV/It/0gMiT8yRq/IYdTlQjauZ6wFVOv7+DMm
 kwAkgvHoABVMrzZyxdO4OOyLxY61aQ829Z9arUOX9IyW/6hhTx62esthMFKpqjvx3LZR
 njhfpdPsd7KlRquHGOp1fmDoK+r7ZvQnNOeO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131913; x=1718736713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ji6uX2V38NqJuC/ZktluwlgMS8GpWD0A8sLQLJ8ZjTY=;
 b=jzy5regKnDAlD14GqturmGQGyadCyYn16MnwMbM0A1ByAs2suNCKOTdu5xgDZ8nXA0
 sgqY3g+zCxe9kXqDhn9sBBAIcFogTlQkrIxX8Ymzig+MieeHpzb7l3C2xTweHEIerG2a
 9aAqGvw3hLJddiIYJiXlrkl66n7Oqvyvn2Qc4+9e2Z2Rp0Nc3HX3/LveeeQH3IFL7uzf
 dCM+X2C05ROOzM0f+6QEkSjCInerIxpAOd/9y4oJrjlfWPieBGaE5zxiZ4V8wl2zIH/k
 xVwveTz55X2UYvP7chANnUtjA9C2po1EsmBf5eUvZxfdjMwfN2o9pNsiz+UF6gqWy0qF
 nO4g==
X-Gm-Message-State: AOJu0YxqHPueviSRoeNbkqfSurNANw/1G/jw7N0SaVc4/rH7ZhbUH2PV
 b6TqOjLAIHIzEn5uyePOg/yB1oNpYTPc5y8/3kX0x+cET4/2k7fir3QJdQ4N2vKxPPCgYQfAizA
 uN64IKgK/IzTqu3lj7tiCrz6HrD+X6g3tVBlm
X-Google-Smtp-Source: AGHT+IHlvXLYsdO/IzyVfkU2gHvwCugAIRm16AeEB6mqtVPLZlio2K5Tu+NWFf0XsZXv131nVc/IuhEF9g2hZKZj//c=
X-Received: by 2002:a05:6214:5982:b0:6b0:7ceb:3076 with SMTP id
 6a1803df08f44-6b07ceb3333mr66621096d6.12.1718131913633; Tue, 11 Jun 2024
 11:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240610222743.255386-1-sjg@chromium.org>
 <20240611162815.GK68077@bill-the-cat>
In-Reply-To: <20240611162815.GK68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:51:42 -0600
Message-ID: <CAFLszTjk52G1QmWHL9rmu-OCzc-f3qqfw+RpRsy9jzccuNaT7Q@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH 0/2] Add support for Labgrid
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

On Tue, 11 Jun 2024 at 10:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 10, 2024 at 04:27:41PM -0600, Simon Glass wrote:
>
> > This adds hooks for use with Labgrid. The only existing hook that really
> > does anything now is the 'console' one. There is also a new 'getrole'
> > hook which looks up a role to find various things about it, such as the
> > U-Boot board name.
>
> Overall this is pretty neat and I'm happy to see it posted. Would you
> mind linking to the Labgrid PR(s) and sample .gitlab-ci.yml changes you
> have as well?

Thanks! Yes I will send the U-Boot series with that (PR linked in cover letter).

Regards,
Simon
