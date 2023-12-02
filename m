Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9605AC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7311C87675;
	Sat,  2 Dec 2023 19:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V9Dq6RIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D66F876FF; Sat,  2 Dec 2023 19:24:07 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC9F87675
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-db548cd1c45so1455074276.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541444; x=1702146244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ImkkBITeONFl4ag+yA/gLr28vCWNPF6iMVXBHHvMk04=;
 b=V9Dq6RIAhpYwTDP5EwEEMh/0xt5V/Ervk6VUQSZi+BtqyCVFlB/mwMSU8NEMZovKyE
 t/F6X/Up7T9rzgkt5cF2PRiyHO24E24+IdhfzB7fucsrzQ7j5lEvY27/1tKR9mIrqXpZ
 W5jLjsdALnYDNIz8wxvZCbs3QNCgdlh3+j49Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541444; x=1702146244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImkkBITeONFl4ag+yA/gLr28vCWNPF6iMVXBHHvMk04=;
 b=VourqTXdJZlmk2CxbvsH5+KYlaqTCe3JFnwjBYgsTbWrhVfjGemo+1Vhzoc7aPJyQ6
 FzOuEniTKsAsoa8/z2VCTEXdqqIvBJCcFYcx2FYcgIw0owi7S2tbUZX+BX8NXLzncaSx
 gN6fWU5bnOX7gMBQgbUmhkcfrTsbjmH4ZR7O66kwDrQYbUjmwZwNuZbfFHKy5RPdN9xu
 HuP+hU++tZ3OeYZV+rSHTQ6+uEJsIPVcsC3HSNgN+F0C1IoCuL9SiQooaaVtMIEGoU37
 NNBpd8RC8JzxOzFUaT6uwwzYUSyIH4P+YjG3wkif+jRoPUkGsiPtYvWshdRdj0nKAORT
 PHmw==
X-Gm-Message-State: AOJu0Yw2X6dEg34vcIaAOJBbFXoZTHPXCt40v0m6+CrGj2IaoupWDEN7
 bRS4IEebpKfZ/eHTAwOVWB1s08nMhppRZgJxKv0bZg==
X-Google-Smtp-Source: AGHT+IGYa1YzJ3Qtd7srdje40LsI6Hvy0NI23IrnQuurxDrL6wiv8ItwgwjNNNzPCPolqtLk2L4+Nv+scAxAomkJ8pA=
X-Received: by 2002:a25:e652:0:b0:db7:dacf:2f18 with SMTP id
 d79-20020a25e652000000b00db7dacf2f18mr1038515ybh.95.1701541443999; Sat, 02
 Dec 2023 10:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-2-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:10 -0700
Message-ID: <CAPnjgZ3DpCTgP4tgAYi9heea8a63KjvV_s=NmR7cA00TR01DfA@mail.gmail.com>
Subject: Re: [PATCH 02/11] arm: Remove <asm/types.h> from asm/global_data.h
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

On Wed, 22 Nov 2023 at 06:12, Tom Rini <trini@konsulko.com> wrote:
>
> We need and include <linux/types.h> and this in turn already includes
> <asm/types.h>, so drop it here.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/include/asm/global_data.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
