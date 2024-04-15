Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B567BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 10:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ABD2881A5;
	Mon, 15 Apr 2024 12:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fXhyzT1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9699881EF; Mon, 15 Apr 2024 12:10:35 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 396648701E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 12:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ed2170d89fso2388201b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713175832; x=1713780632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QPZz0YUYLLp17edDTo/1LR1H4Kfx5+7EQhK2onYeEq0=;
 b=fXhyzT1mFRCO1jp4PZzPHRVZ1ImSbTyR+X2Q7mRk2jIQoxmr3Wk5arixZ8Kswy13IF
 bqXzdElsSpIGtpNSkkI3pm/yHALnTRiPlz1itXMrVWX8aAXNsK3BamAIm6L3wuwJbXLq
 vs0oB3bU4MZGOJArsC4+JfaZ85QiGdnJRY9a/tRy9cQpB1jbjoB07/lny70ogRU+eurR
 7KOkwmJbXWNgv+TDgGBG7bwpXAiW0zOnmgzsygsq0ZxD87M2va7/IacfeFMSKmfHvQDw
 LWs0t+3LFuEbweFv8qpFx7wKqp38igXQ9SY5vNQghRVLywKkcR8hFv26hCUeOoDDxBtU
 NJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713175832; x=1713780632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QPZz0YUYLLp17edDTo/1LR1H4Kfx5+7EQhK2onYeEq0=;
 b=pp4UL1DIe0HpFqi5rYdkJEPj30RNHIVI67vDoDYelSoDDEJQh7cDcb34IWvhki7Gi1
 3R/f6DXGyhxNrNBjs0j3SFJzcZiEAia9TFNhrr2cAiBxt1syGXySkcm+dB2hIUAt1xxh
 wuDOOI5JbD/6AmLD+Dy5yYxlsp5Ko+f9+1mGiTpwkYL8kjnNOFgaCVRO9z4Oom3/BOSy
 N3IV6dYceVfW8xCly2E2lK5mwO/BBeqQy/i6Kp4t1wPDMahbc8h7VIktoVi9thRsxjvl
 5fUN04BwHH0L/9LMfFrqS9xdAbB14DqcCV6aze64bV3+pa+ovCLuNlUQA2RaRR68SIb6
 ZrSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf/hOBTkjCi8PV2it6NCYKKb1Ujp/QbOpcsBR3BiS1GTmuYxrdqRXXK3KY7rD8VBU8mIicT3pO7jmxG3AEMaLi1vHPHA==
X-Gm-Message-State: AOJu0YyKh0QnXFeJVyyoLVkXJS/IhUpiQ3/f80ai43xwvz0Aigev0h/e
 Pr2dFZg8JnVVQF/Xy0v7zCytK6bk/iYoA+YQaGjY4NzWI0xWSdK2j2zhxJhvtyvHQVN4vWgEX0h
 B3VM079Mj8fPtNTfa0PDasHROEcg=
X-Google-Smtp-Source: AGHT+IFD6/IkfBgEd6EymbQ6S61egbIvJYyBGjCTqX+c3XMucG8pybJ2u0ji89AZzALZ73ruTe/HnC2Lupn1JsoAga4=
X-Received: by 2002:a17:90a:4886:b0:2a5:df97:b with SMTP id
 b6-20020a17090a488600b002a5df97000bmr12879137pjh.18.1713175831714; Mon, 15
 Apr 2024 03:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
 <CAOMZO5C2YGDokPoc_8Gr+5prMWfQS7xh8KWRrhjj7BpCVthADQ@mail.gmail.com>
In-Reply-To: <CAOMZO5C2YGDokPoc_8Gr+5prMWfQS7xh8KWRrhjj7BpCVthADQ@mail.gmail.com>
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Date: Mon, 15 Apr 2024 19:09:00 +0900
Message-ID: <CALu9rSYHbRTnua8SEre-sk0kTQwnJOJCNc5-MJy2ugFUn66eog@mail.gmail.com>
Subject: Re: [PATCH] net: wget: Support retransmission a dropped packet
To: Fabio Estevam <festevam@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Fabio,

On Mon, 15 Apr 2024 at 04:04, Fabio Estevam <festevam@gmail.com> wrote:
>
> I tested it in the hope that it would fix the following issue:
> https://lore.kernel.org/u-boot/CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com/
>
> but I still get wget corruption when loading large files multiple
> times in a row.
>
> Would you happen to have any suggestions?

I have seen similar issue apart from this patch and will investigate
it as a next step.
If I have any information about the issue, I will send it to the thread.

--
Best regards,
Yasuharu Shibata
