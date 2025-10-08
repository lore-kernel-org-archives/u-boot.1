Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0B6CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 23:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B818394A;
	Thu,  9 Oct 2025 01:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C9uqmwxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7EFA83987; Thu,  9 Oct 2025 01:10:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85E7838E3
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 01:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7b7325d8fb5so237692a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759965009; x=1760569809; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Fkst3p5U3WdSxuSvcL8aPpmZkvpj8lOuHt44VJz9Z4=;
 b=C9uqmwxaVcLaM/kV0Gb1Y8D8EWIWqJQSun4xgE3GahlP4Hl8MPeCwi05ntLTsEx2L1
 FTbcuE+OQIxtQrmOKJltsqcDrEvtJoc/LAgqsP07HC7NzKoUqfLnH/tea48J1eErUsbi
 ErEW22icM0WUG6Lqq9VjlV63NW1my/S0NeFmw+ENjHb6tLLcfkkVxKvjbSwtDRraH9dI
 vwrrrH5E+NOJhxGJ5cyAEvHvkfOq/ASlM795KcH26pgUA7q8PGWaKkKRWyQP27WrNDUj
 U+ofF6NW/q2pTFgcegTlZTOP8f/BSoGFxB97SD9RAcDuSbDne6LYxuYnFxoP4wxyOyxj
 WQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759965009; x=1760569809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Fkst3p5U3WdSxuSvcL8aPpmZkvpj8lOuHt44VJz9Z4=;
 b=GMp2XOGImXE7oOuE66SgT+7m7QtqSc8WrkXO0Su3hHkkXIsLFcYW/gvkym75azVO1F
 sL/wxbLA5/4W/jlCWbCsBs1lytvDM7YVvArPXT+WigADXa0ztaJfTQFo1gGORs6utwmP
 CLKFz3YYlfqt+fleEX+Wx/HUSfSv8R4UwKvvsoSLKVN5UlbFsxZPNChQCkGS3Cemh18t
 tCmsTGWZPLTq+cbAkVfiu8Tko7nj6QpZkUJsUnEQvsnKzOgV1L/60126MmmbSAzv+Dag
 +7AruZ1QsgN+fZDSfuYYq+Wcu0mAdxSEVY+TAz/PzoBSGm/G2dtzAa2iglem1/jCXIu2
 252Q==
X-Gm-Message-State: AOJu0YxwNL+4Su87dwCjdcfjU5TQfcPaJNqOt8J4H+r3GpmA+WS5veq3
 6pUB2IZ3Ia/lP5335Gumtjos5RLWjbT/qvyx0tmDWGUqq8P5ZzfVABSiTfqyaV/wYcK66pz/Y/m
 fJdmc/Trv+FjPyaqtjhq/MKz4wG0XmmE=
X-Gm-Gg: ASbGncs+ATo0V6zCOEpdhP4HrORJmiFNOxQ1EQLFj3m4hCZgfBgFKy7mBMhi8QzwQ5v
 TszXZU44Gw0CalNQ9toUccHOxiy0iUCsyoAtABHmkqUKQPE7LwmSvFfzfphGZmNOiAWqWWZp0sW
 58O4fsWrM6WogIakTPXPZ0stNF/Ae/bcAKAyWM3VHk00AJn31skYYVku9eud6kog8lbfUPsAKg2
 4D7ppkkE+shzKYbFAghbCFHDvNkFDo=
X-Google-Smtp-Source: AGHT+IFf2FvMcEotAbe6OiN08NbQRQrJPv2VcsaDSI2hpoWvdYlEJDNtWTQv5U22eyscP6nE5yoCyiqCt02lieQNuYg=
X-Received: by 2002:a05:6830:3901:b0:7a0:239:8098 with SMTP id
 46e09a7af769-7c0df6e3f2amr3462452a34.8.1759965009462; Wed, 08 Oct 2025
 16:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251008204103.1497-1-briansune@gmail.com>
 <20251008205037.GL298503@bill-the-cat>
 <CAN7C2SBPhtd3+jzmc48+4g+6bU6FO8QZmnYjWgsXQoH4YOjohg@mail.gmail.com>
In-Reply-To: <CAN7C2SBPhtd3+jzmc48+4g+6bU6FO8QZmnYjWgsXQoH4YOjohg@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 07:09:57 +0800
X-Gm-Features: AS18NWANLExbcANMddhvanL1OVFFmozVAYVYOdKsv5_i1DuvFmLO7863FJsyXcY
Message-ID: <CAN7C2SASs-1tK15SzQhN6VWRqao_VswFohOJ7LLc+CZVp6RCOw@mail.gmail.com>
Subject: Re: [PATCH v2] cmd/dma: documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> Aaaaaa, no idea why my env no good.
> But at least you checked.
> Thank you.

I debugged the caused.
The previous warnings are all introduced due to disk access right.
And possible share driver thing that block some tools to run properly.
I can also built in in local trunk.
Learnt s.t. =]
