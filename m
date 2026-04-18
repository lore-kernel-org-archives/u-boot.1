Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AD5F99C88
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 18:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E8B84286;
	Sat, 18 Apr 2026 20:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gn9v0Iot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055A4836AC; Sat, 18 Apr 2026 20:15:42 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BB084286
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 20:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6739248020bso2588333a12.3
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 11:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776536139; cv=none;
 d=google.com; s=arc-20240605;
 b=iR5weLdYg5a5jt0sGQIsII44U7PVpRxpblfm5Xc1kAV/NrHWNiT0uXazA7Kt2ordkq
 G/V89O5/YUQEPemI5thFIHCYV6q71ZuvDyYQcJMdkz8pjzg/WvtqKyyU+DgQXEKUGRcq
 ZgevmdxpMAl56SnYWgb8VJxxJzXySBAnppxjRs892cSm05IEDsbMRpSgZ7e8jLmzj6LZ
 0qnipnH2za3dGuYAt75m5DtruXLBEC+3hwZKnI0cLlZbN0Irof0+x+s8tRTk0YgKcIhv
 /+2K5DNjNqJpMiZReqgbQFhEufAv/uwdT6lr81Q6dcm5tUm/jJfNUmdMGJQIh1emrC/t
 EeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v1d/sDo+km4vFj/YlwCTcbLKYQrWJEukUN0JSQxrGms=;
 fh=8IvGFgIQGpCK9lofyQ6MjKtFku6Qt40yCPz/fXotJak=;
 b=C/cscKvj4wgnMd49gJASLtHj1MjpILUIc0TK3ErJF1BZgFaqfmUwS692bGzHXvdhrB
 8dLCv5AegOqCDvbNDhkxGaVyZx8kGWfH/lp+s5Rv830yPVjCM/8hLmfeT3YaJGsJpp5o
 A6qRaUukWUncUEHgkoFKS9ccWeql2KpadED4r/lZrQuJvGj8vLXSjH6MXqNg+h9PRoPO
 uOYR3b3HiuDuTSIxV+2ZE21Uuw826+1oUWhtQHd2ngtCgYEhZXHm2EX5328AMI2IGYoO
 DfO9192ItytWOVKEAjtl5+X8bHtf2Rm/aPcSxEBfWLVCx5g61s/c7yEcZNMzsS7ZzYlu
 h6gw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776536139; x=1777140939; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v1d/sDo+km4vFj/YlwCTcbLKYQrWJEukUN0JSQxrGms=;
 b=Gn9v0IotY4ZRClwsPTOy4VP0ubI2FxsGEne22VxD/MOKYuTU5UqI9czC8/7B0bwCv+
 fIPmV5il3JfpdudfTuVDO8C9UX3uk/MU4HjwTfG1rA+Q8jUZIOmXxHUyB6h2Ax/FghuT
 w3LmQlTlk/KER3zAhJAb0PDLLmKV5xyJlivfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776536139; x=1777140939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1d/sDo+km4vFj/YlwCTcbLKYQrWJEukUN0JSQxrGms=;
 b=b+4phB5+dywuZXWYcM/Zq/7JqOkbJ7pZoCBl1Lg4exZPQeGTzYPzvNTKyUztsMPnHA
 979ohFjXunUXxT0LElovAxtU2LmnwvzvuEOLbIUUfVhsK1rJ2hkgpagKOwUvBJ32M2BI
 YG51rQd1/XGiMfnUQgAlhenOMzL0z1Z+wV39UQ5SKnXgiCW7pVbEkOWxlSwFnRLdbjoa
 HCexSSjf8jkjD1x8VqM0MuZvXiQvBat1WrurUpzNwmHqbrTUUxMcTIqVRc2MDirYY857
 98ClMcnwjanP6SdwOQHpaQhkrLjzRWElVHSTKPrEHaiTRk8KA5Fbce03bRCHm1B77gZ5
 d99w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Zc3njc1v9Cy1gv/FzqRNL4gH6NwCU8k9qXdpznFiizZuLwIfEr21EZmg509PbEY4YxkaZ7bs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3yWfDKV20ortoR0VUCX5uBZ7FS1tjpq9+QSkUSn17yjeEFb26
 qupYBbfaX98OBPHdogOPhIpkHOKbVjWTOT7gimsDw9/bt4fiB3MJFzh9GE7doQlvncYpXJVvdao
 64wHSqh+oqsoqbOLplAA0iXKRHvYloQdWYM9sAUbW
X-Gm-Gg: AeBDievqjKLOYcUDz0oSBBHTnacp/2TfVKgLVLo5iBcemo5rQnmLvch+6JoHC1MXkjw
 XvDk3KNyZrvs8cuyMaNwmujSCyxuJURtuiOg9oeu+sixNeFYFFPbBDCj3cov3jHmHdOJpBraCF0
 Z0E9qXDVyv5g9pdRCauNUR2NTfSFzzszDoK0Sxe0SxtBK3zZ4mZYS6PPtwMh2BFNhDqLEwOvBT/
 cNiLbtWt7+RyvQDRqDSqY+LWPyh9RpFuCxUH/anvUBDBIAm5pREZu4YzhGGroES69p0Fxlx9zD/
 D23E9wrLeZNjTIBC4iGQ
X-Received: by 2002:a17:907:93c4:b0:b97:c684:57db with SMTP id
 a640c23a62f3a-ba4191702f4mr241074266b.12.1776536139570; Sat, 18 Apr 2026
 11:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260414131558.538656-3-yan.wang@softathome.com>
 <20260417083050.499955-1-yan.wang@softathome.com>
 <20260417083050.499955-4-yan.wang@softathome.com>
In-Reply-To: <20260417083050.499955-4-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Apr 2026 06:15:24 +1200
X-Gm-Features: AQROBzBRdcoKdJRnStflnvj1PJb-6FJtaYBeN0jPQQicNpcxYpk_q7Dtlp2uCrI
Message-ID: <CAFLszTghkxzka0MSXKfEYW1L_SA2vRJ=yhmLyi5DhBfKAPf+4A@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] tools: binman: Test signing an encrypted FIT with
 a preload header
To: yan.wang@softathome.com
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 paul.henrys_ext@softathome.com, u-boot@lists.denx.de
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

On 2026-04-17T08:30:47, Yan WANG <yan.wang@softathome.com> wrote:
> tools: binman: Test signing an encrypted FIT with a preload header
>
> Add a test to verify the preload header correctly signs an encrypted
> FIT. This test exercises the case where encryption uses random IVs that
> would change between mkimage calls.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/binman/ftest.py                              | 21 ++++++++
>  .../test/security/pre_load_fit_encrypted.dts       | 63 ++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
