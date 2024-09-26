Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B06CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD4A88EAF;
	Thu, 26 Sep 2024 23:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fm/JCNvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3EB888E26; Thu, 26 Sep 2024 23:33:49 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2EF688ECC
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6c548eb3354so10510036d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386425; x=1727991225; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=541CPsfUNDLcCWczD67CYcRUHMQaSpZDMqIB7EQAcuQ=;
 b=fm/JCNvmUA8rXpEmLUbbx5AYkVBqPBeiDgGiP1pxmcHb3S9ZvVB5jy/KhMMp5hIWdR
 S5LwIa78+42cF+hNiBzvDMZjeNpR2XqBWJVFvDWPHwIZ+nxH1Wa2SOYE5LWdi7HH3O10
 L/cPUm1o/zJABtSDcAMTokl+1JP5hQdJITZDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386425; x=1727991225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=541CPsfUNDLcCWczD67CYcRUHMQaSpZDMqIB7EQAcuQ=;
 b=SE/yLByqOeC7Ew1cNkCJfCWp+wD7wvdq3r14zjfsra1EQbPbDHSnScPZAKupX99soa
 j9B2AkL1oBGHlDLLWW6a2TIbDMLMYAiGm9b2X6SHj2rO32TEsKbZXD17l2BnZ+DC3hAp
 M46lBR+qaCSzNFsnfuxSkX0XlbKbF4nd5R37wfcv9O7RS6nYNvFDruxxcNUhVhqjZrOW
 BTZRJbrWqjfpZkELhRILL3yRuswJkU4H/6A+g99cmBLKGo6kRxIeMDejXVK5Ys0D4eyK
 YdhmSgqpEsd4YoszHhrKW+hGLMbgdwaw47QunNWuytTpUsEzpSiAut2TowbLOwqqz4Jq
 sSng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa8AYNY679bKlWA66+JAMxZf2TT+PJtA2v5MD66P57YvOkQTg0uSoLEzdwZCz1kn9zCznrkTI=@lists.denx.de
X-Gm-Message-State: AOJu0YzxfBDkmVKyFPTOdCeUWuqc9YuJZ7hKP8BQnukZs1WHu1FgUVj8
 AUkUhBZFDBErsAp+/NyZQHYIHav/CR7lACXlLuQ4VTxzjpWlr1sn6L9cJBBHCGDJVSismbpYXZi
 e6g3/1YPFpPe9is/26+c84MRYqFErCDKhS/7A
X-Google-Smtp-Source: AGHT+IHufi6Gzp+oltsAgyXNxMMJ+ajiCws/1hWUKqq3xZkZNOiqkUtt2ZggKg1cHlckym2Mq8LjFUYY7ITSZpxdPx4=
X-Received: by 2002:a05:6214:2b97:b0:6cb:370b:ca45 with SMTP id
 6a1803df08f44-6cb3b5c9446mr13173646d6.16.1727386425651; Thu, 26 Sep 2024
 14:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-12-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-12-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:33 +0200
Message-ID: <CAFLszTjE8Kb9MeUqmX3gCMO_8d+ceKoYf48wyM7ONe5s7e5LFQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] test: dm: Expand ofnode options test with new
 helper
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

On Sat, 21 Sept 2024 at 00:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Expand ofnode options test with new generic helper for bool, int and
> string.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/sandbox/dts/test.dts | 3 +++
>  test/dm/ofnode.c          | 9 +++++++++
>  2 files changed, 12 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
