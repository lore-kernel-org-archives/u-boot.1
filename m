Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30FFEA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 00:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7267839D9;
	Mon, 20 Apr 2026 02:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OyRmqvhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64DD83B99; Mon, 20 Apr 2026 02:46:23 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB823836AC
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 02:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-671ff4b716cso4129869a12.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776645981; cv=none;
 d=google.com; s=arc-20240605;
 b=kYW72iFya0tNCydBidEqla8dQOMVKyNQATLtCWFHEkPFtruO5rbyD9TTrkltbksirO
 eEes84LN5DzJLi6QxzrH6GpeE7iS7Mxpa8qFnLbB1Lrna+HNDq34eXjfVVzONiTIJfmQ
 y28d79W2ofh1TeyvvO6QgcgaWaHz1gut+KTea98rMPSBQazK9IYyQpb2sSlvoe/xEF9S
 F22cztsMxW7xgepe/3CP4f9NNX+J3QK/uXCrGU8sV6MwG+MzlIZ/R1/ddC8q1pA1RiJM
 bBHEKwB5asqETeNH9mZsjzSyXQfCVL7jW6eaJ8lzjDGGxLGncTMQ3f/h3uVeb695rcBh
 LKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u78qjSebkeQfE5WHtLyH+CG3aVRjIWKR1zgEfyogfGQ=;
 fh=WOVsvKJBz/bhS6YncvwNdIQFC5VbL/nEBQ84w0ymC28=;
 b=EiFXfpV4p2AJVLlYmaXsTgALwFJBUKfUIjjNI9CWB2cymkxyZwB3EKX/05yd6/DsFU
 XEOHxYWZXBOubTcY0sjn94dFk70+I2FOhmXnggraqlwp8qdGdDRHq1OxoWOaygicuZ5m
 93taz7mLmYXqwwZPCxQ4MtA0TDZ+9XMMAjNAiyM4RK4oyhXFKfWhStIJD/MwyfhARGSV
 j7l88443CX8dp6Tq2c77tCHFmE0FiL/5l1jnforBhfeiVoj8yRlhkLY2y+BJ0C/oUTdg
 weXUlmedueYWEghNFy9UIRfwtegW3bmjULcD2S5+mETOXG/UMe/bH0UO/SSOA6usTKut
 YAEg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776645981; x=1777250781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u78qjSebkeQfE5WHtLyH+CG3aVRjIWKR1zgEfyogfGQ=;
 b=OyRmqvhJUD7kY2REMN7gf27mbPEu2meYVtw13MfunyXatsK2QD+OqEG0pnmYtnIPyO
 GR7+iwby/CQD7gX6dtIOAsbRseiartdoSXPT0ACogQ2oorqmVkP2o6izyrUAcSuJSu9k
 6c7f0C3C/PpwHL6Q7mNWZPdYcIXkPYlkccNC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776645981; x=1777250781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u78qjSebkeQfE5WHtLyH+CG3aVRjIWKR1zgEfyogfGQ=;
 b=EMuJ/YXo15+OncPoO1pOZmHvTJI5CPkWTjV5tfzwNu8YBTRKmBfMlsrJAv4oDVt+xO
 LTi+Py7Pbo22Yc0q1z+164c7htPkboCyiPPNUzLlua2MjbVP+d/YkO+KokdX4QrYuATo
 nmMOXeM2z3+pXRb2bbFxfjqpfDY/7Hv9Rzc/Ce85LaCs+6F0HlxcmxtIoLJYpHOkWdT4
 EU3c/lrA2CCe1e4GMals0yug48JCjycLxihBTrCzc+idKUFFHdhMfGrVbcajgSDJebuD
 dOzNz/scEQrpWatCxNcp/Stgfia2XN/2LjXOZApqRi2YD9E0BvwrzITeEwyRRF4OISfY
 UARA==
X-Gm-Message-State: AOJu0Yz39TmyqQMiZhtIxmeho60pRW+riWE/UiPRgmVsAsCOTz3D3toc
 PcyagYUpx47DLZXuZ4PwjIPPxe7ZmseXsrPX9aGHLR7kLzjpPYTsFZzIIdIzXR9tjc/nOTo5hdo
 4hsNxP/y36JLQxKeXeKpQh3iNBeKzXdGlpnsAmF6G
X-Gm-Gg: AeBDievCno2x69WTOckyvhrgnsXgP3b9rRkpuCgCgKaMNEdV6F5YcU+nAKsyAwqqmm+
 0SUz5bVqDFTQ+vpswvsVKDZFTqB8Q/Ul/8yox1Dt9XowDTShfAztnG6EbTPwWHbGghkRXlkwVpF
 7A27bsvEFbcDFEX/O0v+B8dkXAdRSH8ufKIf2rO3txa5RY4eDYPFi+rplp5m9g1oczql3nhKZ04
 Ezrtd7ASGZ8ZrnY3pu2zdJ+5Hm0xMNd9McSa5/TrgKnikFL04qpDHZYfpUETPc9iUlWsE+w9PrN
 e3Hj0ty5mP3wKSRLKl3K
X-Received: by 2002:a17:907:7ba6:b0:b8f:f08a:4b80 with SMTP id
 a640c23a62f3a-ba41828cc02mr529229466b.3.1776645980939; Sun, 19 Apr 2026
 17:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
 <20260419143247.437733-4-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260419143247.437733-4-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 12:46:07 +1200
X-Gm-Features: AQROBzCfo2LY0JYHy1BSObwy5gHseciNWbZSzT2plxYNYZ9gyzjnYHnnydvhAgc
Message-ID: <CAFLszTgicZnHwqWOW-EQtf3CHg_9vY9wCseBei-mmxMeU0Y_WA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] test: cmd: add unit tests for part command
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-04-19T14:31:40, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> test: cmd: add unit tests for part command
>
> Add unit tests for the 'part' command, specifically for the 'number',
> 'start', and 'size' subcommands.
>
> These tests establish a baseline for the current partition lookup
> functionality by name. This foundation will be used by subsequent
> patches to extend the command, ensuring consistent behavior as new
> features are introduced.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> test/cmd/Makefile |   1 +
>  test/cmd/part.c   | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 166 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
