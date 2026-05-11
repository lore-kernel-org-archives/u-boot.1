Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BA7CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23174838BB;
	Mon, 11 May 2026 15:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IF5Mqjkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B788341A; Mon, 11 May 2026 15:08:04 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE5D4800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so15363166b.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504881; cv=none;
 d=google.com; s=arc-20240605;
 b=H5aM/rPmUwpi/2464wa1xqMNNX9WEXLR4HThHpUzyYHCnYgQ007zaMco/2VDfhUtxO
 Jp72RUtkxebqgqcY3I1flHT24Dy4ms9F/YV20r9b7UhSJOx7mAcZr2b6SxenOjyXZr7A
 0UjQ+F5iFFnI/5ZMdULkQ4DqN3CLBnv5Tk1nXnGA7CIyPLtQeADy+B+ZEX1/TmGgxtu6
 4g1NUqDnDNy8g32+9Gjt0GD6XOu7CsDSVLmvBEJnnN6gnQdGDeTh7OGCbxhkRbqusjhg
 C3APvaWwbSjJ7AuLrY08XgslJ9RLZvOf4h8CnTscLJMvn7B7UVLs2IBkqdsIR3KFA5M3
 JsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8q5qtGJbGy+HF5WwRUr1dkQzor3GtpcAbnSmiurjTg4=;
 fh=HETYs42XC2J3Nzrj9oD/NKAgoqGIITp+mgX14VRzVoM=;
 b=jMIX2OJ4tL+3/s1nEEmFr/WeZBInCN51dzqt7dRCW0BfV3sg4HBVr6wGqOLHgKRA9R
 Lx/nTXY5+1fJW7nUM8j3gdqtNwgfxsu1qnYBRh8cuJ2TyK+RNx6aIzGtbdQxeswO0y4k
 PPZWaGxY4qtdgOyPKM86uvj855PNOE4ghNeDDhAudU2Ss/uk4QGXazYKhKef1myCvwdg
 zOZ7gFaCC7JylOH5N+tlAOMKRhA8CUDU1V2jqPTJu1Qq8dzlOzZ+YUO1W2ek8Ay7tceN
 E0Zy/mgsocKB0Cj3htWmBgR4BdCI70WC2UGrWW1GGy7UY8jbezopggzizrPHLjzXuVOY
 2QIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504881; x=1779109681; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8q5qtGJbGy+HF5WwRUr1dkQzor3GtpcAbnSmiurjTg4=;
 b=IF5Mqjkk1/EBnBCGNXRtHRy/WIbxxEV9TBfsdR6udHLlCxzdkVUhGmrHpR0uM+/fdq
 Gti1W7C8IiXr1eJUxqV20xosvm0bw8zPB2OZhxUWNspwknpgOuK6cubLSZHh1RCWIcCD
 7eJd+v4biBTxvHm8/uoeP1cxLN3/dwB9l9KKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504881; x=1779109681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8q5qtGJbGy+HF5WwRUr1dkQzor3GtpcAbnSmiurjTg4=;
 b=HVdPuwhwAyTUgEYVTPCZTahDXbH70g2LGGT1dUMus5na019rhgRkcJ3ntpmWdo3qH7
 mRnskQEIrbJoSYx1ot7tfrY/6g5Z8LZrp3qY1OVwZ+DISqk3zs9Uao6FAFU9pgVfBbfG
 vw47Ye0tghxri6qggsoq7/u0Ws7NA6r0wj46aWs+l/viMUCJazwChykHKtZShKWvtSLS
 SGwGCxEWvLYVKqd+T1EbD4lyvss8SdL0xDVWGjDJYmFxomE47fRl+Xxswemvumxx0jyg
 pq8AjEB7RyB1kQyiWlsxPjxS1uwEi0Nifhhh5z0NAiMfxJvw9RJa+oeAM5CWzF8hzcEr
 Z+XA==
X-Gm-Message-State: AOJu0YwCDta2q0XgAAjZpFnWkActGDtVGyfq1a2iulu+6zstOnI6aM6m
 +E/fWhH0tve7uG/7NMeuY23sZb78SdyrjHpvUWQ5SSjjrny69GgKa1krTsk9zeWYgyg+XN+VFL5
 /rFgXUAtznFyiyV1lmafF8aCfpgebC+APvT1TTAqy
X-Gm-Gg: Acq92OEHXCdS+5+Sja0Snzo2KAxsw1m0PwBgPMgC+pJgGAMYhIM9utT1xsQarjz8PS4
 OOylDnCFkPm9GXXOAR6Ox0Md29os+S+xzDTcccIwMTfODOnDIUqVT2eDuugakI4yQnqJSTQ1Z6f
 OEsu9oUma4rVxQKFU5eAShkkbsft2ad/j5fMgEqhKUVho8fiDbp/mS7Gi3K38h/16CVmES1axq9
 0H9ZlpvazY3S1he88uhrB73zXHNEG6PLeUIIcMkhDqwnbIMh8cK/8jgVZAODMeSsuYQrubVBYb8
 Xl79FA==
X-Received: by 2002:a17:907:3e05:b0:bab:cab:c372 with SMTP id
 a640c23a62f3a-bcaabe38d2bmr780538366b.22.1778504880943; Mon, 11 May 2026
 06:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171802.56897-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171802.56897-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:07:44 -0600
X-Gm-Features: AVHnY4IIyGIHUhhHqKUffF5BkXYLndTfGxeizFHdb811ID8hSyU78xhUkgFaAB0
Message-ID: <CAFLszThFb0Y2d120LKZmMP6j-hX-qL=yCbkU14HeA1-NvOPz_A@mail.gmail.com>
Subject: Re: [PATCH] virtio: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, 
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Adam Lackorzynski <adam@l4re.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:17:53, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> virtio: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/virtio/virtio-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
