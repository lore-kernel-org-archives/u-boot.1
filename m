Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D5AFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC108488A;
	Wed, 29 Apr 2026 16:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GLucb/vK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32A884897; Wed, 29 Apr 2026 16:20:47 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C4C84874
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba51e69988aso1750437466b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472445; cv=none;
 d=google.com; s=arc-20240605;
 b=VVIfZolKuHHXUVcp3cWhvDPztZXFNhkqd/g/9WyzQG+I/YQAs37s4vz4LM4uKT5tLu
 Vq7JU2hyWMVxcL324Y8ghOMfXZQ5j9tUCGII+X812yNl7gaUkSAntZi7gU1gj68a03yu
 6RU6gctg52+R83V9Tij5bXsxZshwib1ZhIvT+GdxKFYzsc0aMIf6qgGnkngDhFL2WuYU
 /TJa2lRh3D2mU4lNbyK0Dh/UK/KKK5J/JWJTbXIbQU0gpNhwh2Jd+QL/janGoV8tp7fb
 VqGXMQdtsENf2CVcuodcWVBtwyiYq/e4JmZZfoZw4+u5OkeItYrWCbhTko7NC7xSsq0Z
 yjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a+AeE0//5V/SGxEQbgscVP/JdHLIp/w4UIk0ocNxjr4=;
 fh=IX/vxJtcOuW42bjJFlvnnr3CYhWZhtsB6OJ4I+752uM=;
 b=XjdpXE0DEqtsEI8mNC8FjcSU1TIkzvl9VMS0JYcRHtc69/XO1qkTUs+ofhda0AWHjk
 J4aF6q+boZ5BlLXG6EgIfxUbGApt6qHff1KSi21X3RobAJjV9C0zr/7UU0xhsVa4KGg+
 tooMfGnaHaw74TK61W5YDhGvNdd70XjJ16cPZ4mmHPhPllloA7UED+gFvxnpDtSstg2i
 q6qzErBmnlnhcbH7Pu4TpqVsutAHMWiRqpcfkBkjlI+qDWUBzS1Yu4pdoCACl+SIx5G+
 Xii5DvbwslQnUvqDkbLZbx73yDCJQRCA8RUthVsJsACVWcaJNup1vtOP0AF7n7Llzj2r
 oAEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472445; x=1778077245; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+AeE0//5V/SGxEQbgscVP/JdHLIp/w4UIk0ocNxjr4=;
 b=GLucb/vKpMjkzz3D4J+wzNvc3/daHh/mVSWBfbKez84zQrgQJNfAHo5VfaQ9hjjVGG
 RjaYkDB++gPg5MLXppJn/B6tEQZrML3mTPX3lHbqKrfNt8VxcvC/+QPCRF3YJMwjSX34
 0IxBC0IFpmhPkS7twprIwlhKFie/G/sXvAWxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472445; x=1778077245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a+AeE0//5V/SGxEQbgscVP/JdHLIp/w4UIk0ocNxjr4=;
 b=dgXLawDsDVclw6eAysTR/uzhr+AUIp+1yFfPuWl88RWM6nO09HxcT58VopTZl9ee3c
 2Rrvf/s73SSM6Vc8Mx2C8crwzeojx1FGdQ4+964003LUp7vCjCFlsoTx7NI+YDiZvQDJ
 YtwPSUNnyfSCfz4ixIYyL1qsaMui9U0N/mnnkPbLYB4zMYwqnHeegLCD+zwWWwkCzt0d
 zgIREyBlFnz4bgKxWoQAeBvCxTr+krFkbPxY+qsTAjM5lYidSZRDpTNf8yFkGovVEuft
 UAZJdMIvX3eXM4R1jn5PT88qq8V7dq8cDH34BBeqSGvCOhIV9B9GGwuXy3DWVFc6C3Yk
 t1xw==
X-Gm-Message-State: AOJu0YyTSrfkSuoqZRjMWIyuckwkryjJAJYyqsgJ2/euYB3nOD1V9BNJ
 oVrq4j6uHJv/UbcWBmcOw/shiEfDe+1l/kKevOSFOTtlOx59tfbp8yz1Dyj51kaHlt2hTIJZYx7
 NZgE30ylqOo0bm//qT1PSLYJNa7HRRgcamC6DitdGmoC2jWDCO6A=
X-Gm-Gg: AeBDiesNGLks/U/jMqaQeNn4e4l93hHP2hBFO7JLEYSUgy5IUiuKbhWVI4OzGrRsQQN
 hiPScgVf4aWOB3aOcGlf1cFr87R7RcWNIiUgCqi+2WMmsXOTv0sniSJCQU0Jr4YAKwvWYt0cVDR
 660Hr2LEJDY6PPktOCJxoNjI/+CR8Aq/3Q44qkR6Nfygtvd1DaRtt6IQuntkexRKnmMiVuJIp8e
 VRLAoOMAk7spby9BhF0OnUTqo6Sd0nOkGeXtvkxStKYxffyOtWqJCmqBFLPGs+Vx9YAh/IMrxvL
 gQJogfqyP6S/wFh1
X-Received: by 2002:a17:907:720b:b0:baa:8895:735d with SMTP id
 a640c23a62f3a-bb7ff068b92mr436773766b.0.1777472444868; Wed, 29 Apr 2026
 07:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260428133612.669105-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260428133612.669105-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:20:32 -0600
X-Gm-Features: AVHnY4KtkKAPc69GSXyzwNI_TdqZqR1m2g6dVmpKqlRvxcMhBolWXU_J7ABMsJI
Message-ID: <CAFLszTjT691ZQudD_tJ-Os-pVnsLQjto2QeYv32tS5Us7wLWRA@mail.gmail.com>
Subject: Re: [PATCH] virtio: ignore ENODEV for boot device hunting
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Adam Lackorzynski <adam@l4re.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ludwig,

On 2026-04-28T13:36:02, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> virtio: ignore ENODEV for boot device hunting
>
> 'Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
> failures")' returns -ENODEV in some situations. That breaks boot device
> discovery. Ignoring that error seems to fix the issue. Not sure it's the
> correct thing to do though.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> drivers/virtio/virtio-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

>     'Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
>     failures")' returns -ENODEV in some situations. That breaks boot devi=
ce
>     discovery. Ignoring that error seems to fix the issue. Not sure it's =
the
>     correct thing to do though.

Will need to firm up this commit message :-) Also drop the quotes
around the leading Commit reference =E2=80=94 the convention is just:

   Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
failures") ...

A Fixes: tag pointing to it would be useful too.

> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclas=
s.c
> @@ -382,7 +382,7 @@ static int virtio_bootdev_hunt(struct bootdev_hunter =
*info, bool show)
>       ret =3D uclass_probe_all(UCLASS_VIRTIO);
> -     if (ret && ret !=3D -ENOENT)
> +     if (ret && ret !=3D -ENOENT && ret !=3D -ENODEV)
>               return log_msg_ret('vir', ret);

I don't think this is the right layer. uclass_probe_all() walks every
device in the uclass and returns whichever error came back last, so a
single bogus mmio slot poisons the result for every other working
virtio device. -ENXIO is also returned from virtio_mmio_probe() for an
unsupported version and would still bail out here, which is
inconsistent with what you are trying to achieve.

As I understand it, the placeholder/empty mmio slots should not be
reaching probe at all, i.e. the bind step should reject them - or
virtio_mmio_probe() should keep returning 0 for the 'no device
present' case (wrong magic, ID 0) and let DM treat that as nothing to
probe. The unsupported-version case is the only real error.

Could you take another look at 70101c3217ae and see whether the fix
belongs there (or in the bind path) instead?

Regards,
Simon
