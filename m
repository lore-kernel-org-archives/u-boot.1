Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B680CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 21:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C825C848BD;
	Mon, 25 May 2026 23:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S+FaN8yk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4784848C6; Mon, 25 May 2026 23:53:07 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC3184881
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 23:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso20015226a12.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 14:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779745985; cv=none;
 d=google.com; s=arc-20240605;
 b=lU9AVOwhrNqKlUoXOA8bOtkEEf9A7fITZ7qhxGJMpNscilyuOCnvs1m9VhZg9TFqTh
 tR4tAFhT0GW0KMSaJc/U/CMZIBDV8FN/Zivk9XkPt6/xzH6lcBM2UUFOhJmVgzXn97lD
 obbGOkDb0gpEr//KcBMg9bdYzx4uVYjWH1w0kxhAl/ZlT3a5B0dtvaEyAg+8OO7s3pm9
 wmNryPCcMyMkeTnOAhGcIlUrNHrm3OXk3WUF7QHnJ7EFk4eCE+23iyNh/nsZQQkHJgkg
 YVXHVkPFDPzLxSnHwMnDieUgOjyLnGjUBVFBuqKf7fVfSHYhhmM5vjPqsPFRGgfVxtck
 KsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4pd6JI3siTTs7jQ8AqLIUW7JnwbDwj3rA0IKgEVoIYU=;
 fh=YcVKqAQD9d8z/ZjukhDpVFSzdR+veAfSP3kPO3mFdm4=;
 b=jaPfuQ0xMUZwXa7vVkClS/ZJ+hfUZlEez9Dd/uwxf51C+0/Yx7HI/zPVh29U/swBoi
 jUigZ+G6c/lrio6syOTVl02NLN7DJ6M+Z3FM4Z3WfRNHr4YX76ec1+5YXIBqF99eJbqC
 0SrqLjwo67aQzDvv/J/0kq06EkUbi4XLT/4aKFeKFE2aT3M8yVZW/KVO9Q6zs+fAgDR2
 dFldtbJyyqyajbluVEgbJlusXxkDzV0jvWZfbbZEy9Pxime8fwWGTErqesb+tehqwPaK
 SkU69l9P59RYxqHBOXrxJ4084rQW4FQ1wFM110HELXe+3xsdXm1uuWcvrueG1aMh5Rwo
 LHXg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779745985; x=1780350785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4pd6JI3siTTs7jQ8AqLIUW7JnwbDwj3rA0IKgEVoIYU=;
 b=S+FaN8ykMXby1xcnfOpHwIAarx5UpeSAPGE1WTiTiALoXmEBwfYMLMDxH9nrp2Zmbd
 6f3bJTb/3hdF3cSfXKv5JoDsmttkMoEh8aUZBkjW5esWfkGfs903dvtNoh5f0WECqvtE
 2g7Wm/l9mrm4AdJKB5U2YIr2pBvywR7yEoV1hX3UDfeXb361KUTm6iFHiKqJKC3RVEpZ
 8nMOHiD41M9tB1iS96Xd3OVdadgRz5g4tCQwQEibb+/MWxbdadtWfLs4XL2NKBonKcfQ
 FeYGfn8jSRUdfhCmraZ2kNrq0Bp2/G+NVdufQPjiMqdmuMKwmRJxQwiFUGb7CGgowpFf
 ftCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779745985; x=1780350785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pd6JI3siTTs7jQ8AqLIUW7JnwbDwj3rA0IKgEVoIYU=;
 b=EGpYdScbddYD4fjon9GcJtOHtx2gSH9UEDzVAPu5j/9uajB6AUXGK7s7OwTIcPEtts
 HpvIB96gw6gSZ2vK/UZm3kLlVpRZieQNh9ABEmuEbNfZ57X+KxvUaAT6/W28ZfHqDQBY
 bCGByKNBj9Nsjnv7PmNAvOj8LGf0IiViAsqe/Esx1k9Rf+yVMIK6n+leDFQ2udZVadmc
 bkS97W81+iVOwDT64acUQ913QYpCsgxQp6iWISeN/k6IJvXMOwSrjDeYWrtRjXaUDM4K
 UVm63yougwsv8LwjgdeS/+ctwpfqw1qJ0oVJJAlW3xSx0X0Ase+cIESPp1ILDW0OKePG
 zL6Q==
X-Gm-Message-State: AOJu0YxEfaJnRVp3dMgqv7Y3idOc/+bNE2afR8tEwtqlrILoyEN7h1l1
 FP/tTa3VSOkjpcg3NnARo2oySQq2RsScjhofHq3bPeKv52unvVS58HONAMzPs0CQcyqdClJ4fy1
 w+9kwM1fTAmHGTsfEDiOi2VGEL6xU5R8=
X-Gm-Gg: Acq92OEtK3eojv8e/mCJGfazP1VVaBJ/IHk1qKp+UkNIfYPqoICxLVpusNQmAx+Toww
 ljTyDIgAG2VX4g8qRoWiYGKwA1Edihxrv/IfJsrfj0mL809sWV14mCfkbGxv3YJHTXzrzspIzGc
 hrGawLQkri2zlgYUbN0Ien9Hwn2aI1Lf6tVnReF4QYMABHstVM2/Co9cJ+/BrXmF1eMM0uSD8Pe
 KFTM1SlxEg7XvIEC6Nj1WUBJcJbEmMHXMwe1rsVcbQegkk/hxdOlJYI3rUmFLBWeQBEmBy6B/r3
 rBMtIZ3ZsFE2qmY6HiEQAsFkjDXAhcaHfSy8WmpLnL8Xzxf3TIbqNzUFyutER+dnJNUHsj+dtDr
 DX3OPylyRKPkXSNsPohYTfJs/0c0ztRWhUf6VY+GAZTBS5tlhRFhovHAz+uaf0G3foO6LLcPIKk
 8kx8xZUHTGKvc=
X-Received: by 2002:a05:6402:11d3:b0:679:223c:d191 with SMTP id
 4fb4d7f45d1cf-6889cc37577mr8485813a12.13.1779745985153; Mon, 25 May 2026
 14:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <10af0a6535788f5000f688897f51d60cbe0c0a86.camel@opensuse.org>
In-Reply-To: <10af0a6535788f5000f688897f51d60cbe0c0a86.camel@opensuse.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 25 May 2026 22:52:53 +0100
X-Gm-Features: AVHnY4K0EBRcM3UYODfHFGMMWw6W9E2xqkba0oRXecx2QrUFFzoRecLlCpCpHCo
Message-ID: <CALeDE9PfEDe0m94Ao+KFzszZkiJ+uXOYF+k1TGPxMqmAwNJMYQ@mail.gmail.com>
Subject: Re: Raspberry Pi 5 and GPIO TPM
To: Jonas Kvinge <jonaski@opensuse.org>
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

Hi Jonas,

> I'd like to get u-boot to detect the LetsTrust TPM on the GPIO on the

I suspect you mean SPI, or maybe i2c, generally TPM modules don't work
directly with GPIO.

> RPI5 at boot, is this possible now with the current available patches,
> and has any of it been merged?

Currently, on the RPi5, I don't believe this is possible. I'm not
100%, but I believe the SPI on the 10 pins header uses the SPI on the
RP1, and that's still being wired up, so it'll be a while.

> I see there are patches sent recently for RPI5, which patches do I
> need?

The recent patches I believe you're referring to are the PCIe ones,
they are the first step towards, RP1 core support.

Peter
