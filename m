Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB14BCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4542B83BC8;
	Mon, 11 May 2026 15:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dkFVekBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8FC83CD3; Mon, 11 May 2026 15:09:04 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC5B83A41
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-834da62e52dso1799381b3a.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504940; cv=none;
 d=google.com; s=arc-20240605;
 b=T8RhbPEKvNv+535DR0F3iwIY92FblT4eqzQhM3MurJzE+h05LiR350s4E993hRHWEf
 cE/oHIs0yIi67qNJKXfCN8nt9RmF7f/t49l4dqFsxc5uz/ZO3wWI2LgNSFqqFVHu0B5p
 YqD8T7KSA0l0ipRRS5a7t9kX3DeRa4yAeWRMvo2ySHz39VXgrxC612ut2LDudouNv3We
 ZRFBotdzOiLJ2XMmp4hs/6x1JSy711JVuSbfLPLmBQWlsQ7QnqxdjlBYHCpvNoXsA7Hh
 UB/cy87rL1HF9qxKe+tKnnFpNCB33dn05VM/sq2sCgd50r7xgrC69Yyv9ULYqdeK4bO4
 noSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b5jg8YCs8TXYu65H0V+xmB3dbPEvIpF6pLMKRqO/N+Q=;
 fh=DHWba/x7tuoorNirX1jlfatUYioWd7qRviNee1YRGB0=;
 b=LvtphdzkvzlXos1WrFbeon/x0DY/9jzJalUrHB2uvQg+PbEB8mTbXB5AU9dKbTjXvg
 bjo4Ymk6aTC1gPyd8EtzYzHFPoby8VCZq6NQ67x4iKwjF40jjZWfVMqfYvx2qW8eAO/a
 e3MemtyIuzEeeTeeSjiS4VQQHBjiZn7TvDFxcLsyfcIpDiCsf6Rm+JIDEBErtNY1BVZa
 xn89fKGFwchlmk41U4NtYeFPVZ2lGQLHSJY6ifMMV3OiLkNjFwxVA8i51Jmgz2Vowg/+
 VzDSkRF2Kf9qmOrjXHD9KkBmAoZ+rYtkuunhKL+BvTUw5nzosUid9QBXlWbpkxJuvPeV
 UhIg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504940; x=1779109740; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b5jg8YCs8TXYu65H0V+xmB3dbPEvIpF6pLMKRqO/N+Q=;
 b=dkFVekBEuIyhAWF7bTw/BZKt2F8fsn9GDaKU6yFK+Gd3t/75M+zWUjraX7uahR0OYT
 8L8smhxzt18JHE6Y47S1AT3yHtTTcbLlzKMuud9jWwBtWVirmgTNi6EQVvcHCSrOCIEk
 kwzjjRhaEgmpQBHTIhKQpwu4xNIVjdPhbPQuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504940; x=1779109740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5jg8YCs8TXYu65H0V+xmB3dbPEvIpF6pLMKRqO/N+Q=;
 b=jZ64maH3XgR91fdLMp4n46tbndBzxnGSN1ZlcCK5GF3tLFkniQYe0JNd+6dGj2Eery
 4b/42cohOiiqFDWgVJvGrhjJcJq0JvlFs4dzUhj4OsSqcJFQH1eBWHs2aBgxxqLDhGaK
 eOjUv6wtddaNeFzj0jY8hvf8ZgtKxm9+1ljRa7dMaAloL7dAL+m0AunNHwexV+bB5FKE
 al2q/DINTRkjAVWe9qhNtEEVgOdmXSehBPATE4cyg/zuvQRC8U8/sMJMxXrbr+vf4n44
 QuP+6yWSspNPfqAIp6dqDh0LlXssgCj+y3Z6vFcyDR9WSedeU0wENAhSr+kvQcFYUG+p
 vItw==
X-Gm-Message-State: AOJu0Yx4ChBGi33jq56Z3cfznbXCVQogx7uLqZgq1KT0etcQ1qWfYZjQ
 XfrOsQcGstw9NBkZr6joKDALSSjr9z+6xhKrkGoXGAvAVZ2igkE9G86yvkzETvJhYBdvE6Y1Ibn
 cNQNw+Te+htwGTdz+zPDT8bbP4Ity8CMckEH1hQ7y5vS/axMeoR4=
X-Gm-Gg: Acq92OGT8Ftf3d4HBb/VqP57oJ/yx6GQpEvFzrHRjrHYnNEvYjvzVkfU/Dz7JFbzpYJ
 ncUyOE5g74sFj8XpyVJ15zHvQ8ILXLTivuYn9YpEr8H8rsNvvilm2LbZoDi06CAnsu0GYppBIr5
 CIPoJZxA2uxFN6rmeCcBbMQct71Mg0/WKGQqwWcaD0NuwHwu9WwEWffZOuNQdSoOR29yFe0buPs
 gAPbgzEqQqXGBkryPCD2/UxIrytBsSMp2d+v+BmbfTxdcP5fxWQyA4vjt31un0XepQgFJ/ox+wl
 p+RCPg==
X-Received: by 2002:a05:6a20:244d:b0:3a3:a69c:216e with SMTP id
 adf61e73a8af0-3aa5ac23e75mr26159084637.38.1778504938245; Mon, 11 May 2026
 06:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-7-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:08:03 -0600
X-Gm-Features: AVHnY4JX6rwyEuUKiHECHdUTA8Iw1-30hh2PklwLoLY8kp-bWH2rbA-d6uRq55k
Message-ID: <CAFLszTj=rb5dutAZj+U1TN8Nf2H5NX41cYy8pSJ07axckw2AeA@mail.gmail.com>
Subject: Re: [PATCH 07/11] video: dw_mipi_dsi: Staticize and constify driver
 ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: dw_mipi_dsi: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/dw_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
