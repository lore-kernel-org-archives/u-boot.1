Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB92E95A68
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D42E86DE1;
	Sun,  8 Oct 2023 01:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FFhqqAo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8ADA86DE6; Sun,  8 Oct 2023 01:45:31 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A4F86DD5
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5344d996bedso5963344a12.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696722329; x=1697327129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MrQdc7WqcmWgIVj6FgqzZeoYjCRMRaynKzCnXkpcAw8=;
 b=FFhqqAo2cBxwb0fCzUzu4ypMp16MaZd0S6fDN8SVxfPpEfsrFjc+t/8w+4o43xYPKY
 CFDLlavCxEW3H17+eS+tGhIw45jDr7WDSGkO3E7YrbhMXGK3dXN8KRuiQEHEMpjeVZ/R
 4WitD6/TJzBVnN9seQULBE1FaaU5VhzoBv2Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696722329; x=1697327129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MrQdc7WqcmWgIVj6FgqzZeoYjCRMRaynKzCnXkpcAw8=;
 b=iJc/mUsmYPtA16nqq/T5obFRwxIaZsY/x96R9//P+EqtfBElcAI37AR+7UGSu+LYJC
 H+IdhTQafvGMUVgS5y6sJ9CvaWQ11bBsZ6384j39UcRiyWlcNj7X6wm5ZMCAcgmz0A/V
 jwChtw8jgjzb8fVU19XlhVhxZq/G48vbvQpk99NC4kTBFt2EbhuVO2bEggmejaGKmYFb
 Ntq3mrqk4nmEUqGY6qllQzvxf56aP2w6VV4t1DSV7HXP+U2uI/QJZmyOK90bA5q1ysDW
 GVuu5KHbdZpxhEkAQPf/GYMA0sufcVzCe+LHV4yesaS2ka9unBgTcQpTRasSTzhomocR
 CMlg==
X-Gm-Message-State: AOJu0Yyr4iWGfRfK27okqOhu90MrJkONXAf7khmdrw5Jm+mwEB0XVbTJ
 005t7kWvqbX9cXI9vd99fC5y2qiEBz2OqKjcgNn2Uyy2YHwEboTfboQ=
X-Google-Smtp-Source: AGHT+IEgWMW/OOAhc7XFOI2rYHw7CyqEKN+3qIOXs2a8VUMRAZRSZV44bAEoooIICSiRImZ9fUeMEuUTyYwhKu3wwjo=
X-Received: by 2002:a17:906:2258:b0:9aa:25f5:8d95 with SMTP id
 24-20020a170906225800b009aa25f58d95mr10923927ejr.59.1696722328767; Sat, 07
 Oct 2023 16:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-5-sjg@chromium.org>
 <20231007233219.GI2227687@bill-the-cat>
In-Reply-To: <20231007233219.GI2227687@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:45:17 -0600
Message-ID: <CAPnjgZ37DN50orkHmNFs7w4yA+npw_7W0-6iEU=wwtOZ60U8rg@mail.gmail.com>
Subject: Re: [PATCH v2 04/27] bootstd: Correct dependencies on CMDLINE
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

On Sat, 7 Oct 2023 at 17:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 07, 2023 at 05:12:23PM -0600, Simon Glass wrote:
>
> > With recent changes in boot/Kconfig it is no-longer possible to disable
> > CMDLINE. It results in various link errors because some options which
> > require CMDLINE are enabled regardless of whether it is available.
>
> How "recent" is this problem?

Over the last few years, I think. It was definitely in better shape
3-4 years ago.

I just realised that I sent your patches as part of my series, sorry.

Regards,
Simon
