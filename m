Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94306CDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86DC849EA;
	Tue, 23 Jun 2026 16:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bAJaoO/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1AC5849EB; Tue, 23 Jun 2026 16:47:07 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D33849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso7767539a12.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226025; cv=none;
 d=google.com; s=arc-20240605;
 b=MarYq3lzArS62T2pQFMoEazNsumq8NH3O4SCa9/Vtj3cQaKD5U7NLk4TrrnE+sAb5W
 h8qXoFUTfrtpeybRNPReecU5AC6Ij0KTLEHeIzbyL70s5/7Hv6lYDEfzFX+4w23NvUdQ
 z0K2WFr64g2ubs9pfU6Q44MRaBfG3WuOxJ4fPd9ABUu+/w1M9sKTsEXLuY/hM+wvr5BX
 yBaB34MSVXqnlAn2Jm9J8dDJtokWaZewVmXJJFRX+PVyoaWp8qbgid7drmeCJeAJlmiZ
 vrg99SufW+zc2tAXHFkh075gYyfKCVjM8hFU0BNSxEaXFsitoWnWwF0w807wLBJ1yqfA
 AmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+m2TwPEC6bUYoDmjShOVoH6v3+KcoJrEk89DxE9sX2s=;
 fh=SJzU0vqhCd6XZ12LivayWWnEo0s7vlwiBzlNcKhQZ8Y=;
 b=L/4+HcjMNrkZs4M7xyBHSCVS1X/NnOiX+jm+M0pjULxkZwdYTZMhWac+6PvaB2CsTk
 5xzkSw1F5DJQ56TdV3dBxZU3gPgNkPF4my1zM2KgY8FH87yhAft2G4KLlZxlyVkcNx7X
 D5a4WrAzv0YNgkviFjoiT8SzeEK2N9z27uYBGbuk/hDg/RU6jPDCVZ2gF1gtI0nVvx8k
 lO8QDT1gLptxLXHEiScojN+zeKJmEtfbF8j7hW0+sun87HOTNqr+/useWwip5V+4EPbk
 6YZhwiYtZPinShzowPnvW8xeK2sFIj1iycLa/Wdwh0KyomXDXH4JxLWTkxQeg4j7CN9W
 RX3A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782226025; x=1782830825; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+m2TwPEC6bUYoDmjShOVoH6v3+KcoJrEk89DxE9sX2s=;
 b=bAJaoO/z162zVGZXh1gPOZ7GN5yotrzKZiEm+jHmtOWs9VzqvtZbVw38OtSrhx7wjV
 kXZHfbQpX4rvJXZ3slnR1hJ0VEINHKpIWmD5iFgzt7K+YR3vevwDtCSdqRD0Jz4dszii
 siCu0JSEkuOadP2XDrR5qB9I7d3828C6VdwuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226025; x=1782830825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+m2TwPEC6bUYoDmjShOVoH6v3+KcoJrEk89DxE9sX2s=;
 b=OIGdrcZ1kkBoX6ARqRxjpdOxOZ9G14K1oeXCUcC9nGFC+GsRXv0NbfviG9MTip9H0W
 TWlJiDBOI/bEA8o3wEE3gDfbH0r1ioHb9EaRIPN2U54Jw+vk6EWr46VXTpRwYITt4yji
 wwQYUX06fNeVD8qWE+yf9QpbrmLReVdu4eqIzufL8v8pV3G7Uhf7SXA9+92QEBeLCd4g
 d8oGqaTw3QF9E+LfolUTGwLmsnXpfEadw4RHxWx2XfQk4FUt8pX4etsLvvTa1zo/9k1M
 1LAfOZgZj8/mr/GgO5Usn6Jh5WnJ2LVLY6RhwVbhn59Tq15etNl/xn6PG4Xc4NHIZrPF
 BbOg==
X-Gm-Message-State: AOJu0Yy3J3rP9wnDPUljRpEysSzz9JQoyzB481K+Im8wgQISxGqgll2b
 mgz4qfjLVTRsfhAwJf8JlYrGiPvu481BUIYQOpTPaP2GTjeVeyth/lD1/ifsmf1yZe+aWZEFetI
 ZF5wj8s+tXk/NIBTxMcKMhCTS903o/B7w6QQ1B65c
X-Gm-Gg: AfdE7cmeXbQH05w/j7QXY4j7Ksbn1209EDdVcwxr2QYFkgoWDwArsymBD3hRjNO2qXt
 loNAo4eRSGdIgSyUIdQnMeuu7yC4H61Ti6t0VY8uOH7Gl+fEcSd6l8OP0DxvO8SfAL/BEEIZUzD
 bP0sBthVMw3S3gNGiV6m1jjLSCG/yzGkha/p0M1dWOQYLl8+OlSco9iF9ib4lz8e2zJmxIWRYDT
 THsuOhb/ovBHtSkX8reUsQfrW6UMOSOjxG41MGSkDBYAyCTJgzKZ8Y7A0Yjk43hv/qjHjaNtw==
X-Received: by 2002:a05:6402:4515:b0:697:e94c:1d93 with SMTP id
 4fb4d7f45d1cf-697e94c20a3mr635223a12.19.1782226025114; Tue, 23 Jun 2026
 07:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260622111933.1488593-1-nora.schiffer@ew.tq-group.com>
 <20260622111933.1488593-2-nora.schiffer@ew.tq-group.com>
In-Reply-To: <20260622111933.1488593-2-nora.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jun 2026 15:46:52 +0100
X-Gm-Features: AVVi8CcPBX4wf40n7WJnYMImn6ocumHpKZiJ_1Va-xGYuW_7plvKGFxWPc_EOtk
Message-ID: <CAFLszTi2pDzmBdCLWA2KM5_YzjgcRHZ2r4XWikOHQgP141bo-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] bootm: warn about load address for
 IH_TYPE_KERNEL_NOLOAD in FIT
To: nora.schiffer@ew.tq-group.com
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>
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

On 2026-06-22T11:19:32, Nora Schiffer <nora.schiffer@ew.tq-group.com> wrote:
> bootm: warn about load address for IH_TYPE_KERNEL_NOLOAD in FIT
>
> The load address is ignored for IH_TYPE_KERNEL_NOLOAD. Instead of
> failing the boot when none is set, it makes more sense to warn when it
> *is* set.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
>
> boot/bootm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
