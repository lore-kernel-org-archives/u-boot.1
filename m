Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16218D35154
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 20:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F5F8407E;
	Wed,  1 Apr 2026 22:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U7GulEmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1038408D; Wed,  1 Apr 2026 22:25:36 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1852E84011
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 22:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so46582a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 13:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775075132; cv=none;
 d=google.com; s=arc-20240605;
 b=VDQkG4Wod6k2kTFjSKo/BrIeRUgZVOlQEtTKSVy6JEXRd+veY6sLEhGTxO4K6bOk7M
 vkCyreNSv770v9di+8+FbibBiLNgFhVJWB+iIzgB2G5c+Rhld2YckWjdyrayJTJuA9N6
 On4Sue8ntFEcH2u6oec65LVsJHUc9PT/ElQ/S5MYXPF9jiT6MCpovCYvGZwFnfGQf4Cz
 sIWnKlDkkCyRVgbzg1yNNtgAWv0jy8ew3z5kS+8HjDg4bXn9/iGuFymZfZmcQVUq9l37
 y+IQ/p1LpsBwCiVDAAaVmbhGRhFvD1j7q2pENokdIJAEYTnz66Ea1Zu2uvOhIRaSDBlD
 5kOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TcYKbIKFn9D7nnUiuWIZw8+FgzI8Lr/t1lr75woKnfI=;
 fh=RnB5lhiZ2zWwUKd56qUm2o6d636ryv0VxB/lSwXL6qU=;
 b=cUkaroZANar+LFtG5lwFTIXZyoVCz7YWa51EnqBPCwIiKlsSx3FEh4Qzf1sOnppwS/
 QsZ9jhVBa7eyhzK2VXY9zMtKK6KryecbTS1t7i45yY/Co7lJ2NJlA7+Fh3q2yw/+dPxd
 g4uo4G+9rN6KriIiQV6F7p5f8f0xe8KyEXoh4n3Bf8/41XSbEcyHfPYgoQRwYaq7TvJJ
 M82Va8I4KQtj0nY8jqjhrqjNRonqFrkIzJ3fWY+Utzzp8+TLiBpOGy6fp+AXngMrjgkY
 5Xm8ASu16w82491tSezCzjA8UKAQJYJeti2ocz9SzEesOpL92OASxSHIdsd9Pxlda4qS
 QQaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775075132; x=1775679932; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TcYKbIKFn9D7nnUiuWIZw8+FgzI8Lr/t1lr75woKnfI=;
 b=U7GulEmdV53uipdjZo4FdPYm7tceQOJ/g45KlBmXFdmi2TdEOX/pwZbwzZzpnGoLbF
 v2faNqPEiYvd7prVMaqk8QnjNMGX9pDoJSBp79aK4z0Ngb3dhUFFuJBNpeEOAOqp1Ew3
 S4ZaZeGJS2I/k9oKENjWdEiU2F1gwli4oNq0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075132; x=1775679932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcYKbIKFn9D7nnUiuWIZw8+FgzI8Lr/t1lr75woKnfI=;
 b=NBv7oruf70iJcHFK3oaYUt2ItbManbKjalFHHYjViNzNAGsRfKMuMamXqlQFvfXyhV
 QkpXsDytItliQNP//5XZ0pt7WW1JuxNFMGfkQWV+EaZiP7svcTsGDxH4DP6ruDs3rkSW
 12O7GskZaRESMOGEmCo4A5eODs2pT9FT/5dkOVpPHGbVcYtgVRQlWTBEFLLSnXI9ek/t
 Rry9ly9EPdxGkvj9qlsgSTrNDrDs6CM4bFIj7dI3kwWCK/w+1NTh9gNahT1MFaJMxiGH
 bsTzmvK7zTYmicZc2wa5Whx6/luzGVTawRjbRIHAozda4aJ8CoURiNeMDVEFa3ujkpJI
 YmQg==
X-Gm-Message-State: AOJu0YzmKUDM4bJJF4pLvIk0KZA3ftggEagnd7s891ZOG2YjqVZo4m7j
 4r6PdP2qN9wb+BYNi2mKJvFh20LUANIG0GJyfcRbMhmwNVrdlP5cbPO5E3qXBfGp25DnBL+3uLT
 KwCh+/2LcVDi6iSDQNko/goLf4AFqITfA4sD5AOBvKDPhbDHLq8lrsA==
X-Gm-Gg: ATEYQzzyQnFGjSdRkFN1VAzddsyLJK/rf6yIEyS7RgsFXQVz8Kv4CS58oXFoFXkJ5wh
 6qYedhaffC0kNA7Qh4feK7kZdABsgchsZp8rhKBrPVTXJ7yt0ChGQVyKtJtFgkcBDrvdTpaSaFt
 sbguJsnL7NlAWvBgzIb0miBdMhXUhdtSn72yVRy10nlKNyZO7brHoC9hllkJYGzyVP9T8ESfdiE
 5TygevbuJE7t6ccZag4uDJoCHZoeiyMdleBZIMlhNLYv0YJNQPnOAD/hzA3KL4W7wTBa8mszhoq
 IRLTz43MBA4aE4ZUZtkHMBgSPMppA0uYyIfwjw4=
X-Received: by 2002:a17:903:3c4c:b0:2b0:67cc:adc3 with SMTP id
 d9443c01a7336-2b269abdc32mr49726435ad.14.1775075132557; Wed, 01 Apr 2026
 13:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775023421.git.michal.simek@amd.com>
 <7fec12cfc852b25785577b4871b11d5629a14a8e.1775023421.git.michal.simek@amd.com>
In-Reply-To: <7fec12cfc852b25785577b4871b11d5629a14a8e.1775023421.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 16:25:14 -0400
X-Gm-Features: AQROBzDaficsUpum8ZBhbxjk0IPU6kHpciDL2ixYK4uzUft4mlD0SqIFyybluJU
Message-ID: <CAFLszTguTjHyzqgevoeQwMNdMYyrq10_Ou5eTLJQYzDbqUUFhg@mail.gmail.com>
Subject: Re: [v3,3/3] fwu: Move boottime checks to EVT_POST_PREBOOT
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org
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

Hi Michal,

On 2026-04-01T06:03:43, Michal Simek <michal.simek@amd.com> wrote:
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> @@ -790,4 +790,4 @@ static int fwu_boottime_checks(void)
> -EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
> +EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, fwu_boottime_checks);

The tests in test/dm/fwu_mdata.c still call
event_notify_null(EVT_MAIN_LOOP) to trigger fwu_boottime_checks().
Since this patch moves the spy to EVT_POST_PREBOOT, those tests will
no longer work - the g_dev global pointer won't be populated. Please
can you update the tests to use EVT_POST_PREBOOT?

Regards,
Simon
