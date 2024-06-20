Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A082C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F9788528;
	Fri, 21 Jun 2024 01:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BRIwuJi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF62884B2; Fri, 21 Jun 2024 01:05:40 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26BDA8834D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b5052defa6so7421276d6.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924737; x=1719529537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=trl9InuhOaGaNfSKzWF3ULCG8f9KcjLbPnkIv9yfWqE=;
 b=BRIwuJi9zmxR1A7ww66SLNSQcYID8vrSlSrGM1mGSYA41ubBMjyhmnc/i20F6pjRmG
 3j+dNOm/m6uIbQHLbbfW9ONS7HhmkfTJwQ6oUoV9LjqtqO1yiyjsq9bOvETRYM0bHZ0p
 KjCyot5Pgqt7G2Sv0myryUQs5tGqq2oLj+4Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924737; x=1719529537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=trl9InuhOaGaNfSKzWF3ULCG8f9KcjLbPnkIv9yfWqE=;
 b=qprbWSD0wmyMDSCh5WMkMHn1F2aNwcSTuxjWZq3KOqgeRg1RChcC2AkKMoaBe5hw9J
 fSwoC8lIXlQasc801q3bt9+a3PFaSv7B4rkLZsbRrsYajp+Ml6OxE7WZNfAEsLq2cV5N
 8iZ/mnK7O7WH7dMqOH9JlajrPUBSdK/4ZPNiatZsW1zAvT6Vyyqp749HdX6m/StPrArv
 xINsyqr/h2k5l9c/HB3o/PuZgjr5P54PK5pG2gCkJ7fJtn9Wssk+FcyRrJZPDCPd0jFz
 IwCIu37iLsHxygwQLxpGyxKzE39pdehLxC46Vgmth8h7+UR86MlRYkAS6BHVKA33YvYc
 rJuw==
X-Gm-Message-State: AOJu0YwuevHnTdXazzKkmw8L68njZwrzYq3y5l/JbY/gRdyqWr1eVtIM
 BpFwX6QQqJeR+ADV8w20oGsRe8sHLJxuYNMxoUPdI0FwcXoEr20FbwNX6fZ87O0VHbMaLvLx5IK
 cH/DruxCn3YDpBrmL0jSQhBXhCL6K77zr2wY8LGnKj0MvQuc=
X-Google-Smtp-Source: AGHT+IHGcm6zETmxxynh9rkRW5fo3vcPtVbNanggEldyIpp3as+Guh/Jd8Q7MohIjrSXv0KglLVhS3SlPXKDMGF1XxM=
X-Received: by 2002:a0c:ca89:0:b0:6b0:9048:9801 with SMTP id
 6a1803df08f44-6b501e5b3e4mr79058186d6.39.1718924737077; Thu, 20 Jun 2024
 16:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240620133346.1135479-1-sjg@chromium.org>
 <20240620143950.GO68077@bill-the-cat>
In-Reply-To: <20240620143950.GO68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Jun 2024 17:05:26 -0600
Message-ID: <CAFLszThPrA3_B1cwcX208OFZT_GgXrHH4L5NuY9O5sDQwXKyLg@mail.gmail.com>
Subject: Re: [PATCH] RFC: Add a tag for the world builds
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, 20 Jun 2024 at 08:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 20, 2024 at 07:33:46AM -0600, Simon Glass wrote:
>
> > Currently the world builds run on all runners, including faster and
> > slower ones.
> >
> > The difference can be quite dramatic, with some builders 4x as fast as
> > others, resulting in just one world build taking between 20 minutes and
> > an hour and 20 minutes.
> >
> > Add a tag so that we can select which builders run these CPU-intensive
> > jobs.
> >
> > With this tag we can also increase CPU utilisation by running multiple
> > QEMU tests in parallel. Currently these tests leave most machines fairly
> > idle, since we cannot run more than one world build on a machine.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This conflicts I think with Jiaxun's desire to make our GitLab job
> runnable on the public runners too, and where we'll end up with 10 world
> build jobs ala Azure.

It probably doesn't actually conflict, although I am not sure if one
can add a tag to jobs that run on public runners.

Regards,
Simon
