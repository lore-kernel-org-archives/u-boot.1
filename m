Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E56C2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8610B86A4B;
	Thu, 17 Aug 2023 03:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mvEmxkeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A00E86A4B; Thu, 17 Aug 2023 03:56:29 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEEA9847D3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so930343a12.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237385; x=1692842185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9536EFf5V60tXmgNunccWIQXJmgxXPOhF1lEEQ+i/+M=;
 b=mvEmxkeBERKAZW82BcsHzh4gSOw+XE/ahpdc9p9NwUV1fH6IGkf7LAU0yxhz7wpWrY
 SsqXJzvGQmsvdaJIwbOgCmKAqZwO6VzEuHWOMiR6YHjD+h3ypf7WTy/wr9REiq4H7em9
 33klVRqRKgWjCNfAihFiZCYCiW6Ego1glS6a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237385; x=1692842185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9536EFf5V60tXmgNunccWIQXJmgxXPOhF1lEEQ+i/+M=;
 b=VhUvqb6308dQzlkT3OVhInklar91nQLz0akK+0BtF/Ck950V5pKnbFS8pRJpN0qQ1F
 BuG6Xgcsg5IRX5G3j44q9kkDbMa35dDcnj6telBeG74ZU/z3Zy758IX3v1nlXhPJhm1t
 gs1xqKUheElgg6o7lSMSK1zwI7kNgR5MJjqpPEKkfd9RMsoVZsR7zoO8hvnhTI0PHPaw
 nH5BgpRLWKT370T/aRAh8y8oIBKu3385xhGFu0vZqy3vaS6Qtb55HPQ447Z/zoGq0LW+
 Vq5rfp+deK7pkjaXFj4gKJfrKTIl5MupcmrKWYizMQwZ+pGlRmyg52mIO8tnd1Uw6hTJ
 SqWQ==
X-Gm-Message-State: AOJu0YxBWfZNW3XrMxg7OfW8erPfEe9StcODoXBdCM3cne0CH5rDqJ3r
 4AzUaJOe7IlvjFypHkC9bdt7up7jjLwqr8h8G/gdYw==
X-Google-Smtp-Source: AGHT+IFjtuiy2k4CmI6AzOgth+NWshg0EUwC1sskk3GAfS3IwaV5msCPnCqXSQKjoXqNYYByxXs0+5xQTk8gYwXLqoU=
X-Received: by 2002:a17:906:8a65:b0:992:ef60:aadd with SMTP id
 hy5-20020a1709068a6500b00992ef60aaddmr1657330ejc.13.1692237385134; Wed, 16
 Aug 2023 18:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230813201038.413362-1-sjg@chromium.org>
 <3a9a731f-15f8-02dd-b0d1-9626031e0c77@googlemail.com>
 <CAPnjgZ05xtrLQZiKC7t4NQvMJCAx2E7bu+LyPTqKjAmAPq-kwA@mail.gmail.com>
 <12a87716-829a-a24f-8221-c5e1ed1cb316@googlemail.com>
In-Reply-To: <12a87716-829a-a24f-8221-c5e1ed1cb316@googlemail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 19:56:13 -0600
Message-ID: <CAPnjgZ2qHx4egjL8x+tCPic310dRi06nNeMg-jAwTheG4UTvpA@mail.gmail.com>
Subject: Re: [PATCH] x86: Update cbmem driver
To: Nable <nable.maininbox@googlemail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>
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

Hi Nable,

On Tue, 15 Aug 2023 at 19:41, Nable <nable.maininbox@googlemail.com> wrote:
>
> On 15.08.2023 01:42, Simon Glass:
> > I believe the original intent was to indicate that the buffer had
> > overflowed. But prompted by your review I took a look at the coreboot
> > implementation and it now has an overflow flag.
> >
> > So I will send a v2 incorporating this.
> Thank you for this investigation, v2 approach definitely makes sense.
> Btw, is there any reason to mark 'struct cbmem_console' as packed?

Not that I can see. I'll drop that too for v3.

Regards,
Simon
