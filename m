Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A356CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 18:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065D883314;
	Sun,  7 Jun 2026 20:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQUWdm/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E7084715; Sun,  7 Jun 2026 20:19:50 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF2284704
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 20:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso31564515ad.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 11:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780856387; cv=none;
 d=google.com; s=arc-20240605;
 b=g7FwFZgOIXuHS3Tv0K+I+kcv4otdh2vnfDQDCk/MykOxw/mFloeqLs3XsEGdBekGbv
 Qfj/dFAx0VpweSeGqT8KzLJ2mvFTL/st+wICYhos0enzCUqMgH2/yAT1x0aOxMq6fLkd
 d/7UDFYk92+GdejImIu9GKOo+5R41amsFaaS+rcQvdPen9kgd0h3s+Emph18JvTTBLJS
 Q0u/HtD3n2t6oxBJabPGXKc3AQlF9SghwXJitwKfhGlMe1BmgQ/7+/6a+ocjbpk441v8
 DcIh/p4gmQD/CVSfeSR+xxh0jmA74zV3Q6aShN2+3lGxUsrcRVM0NK9FN1M5kuOlHFdR
 vLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9dI7viJWkSnC/emTNKYMOU675Nn14UCft033JgROKxU=;
 fh=HhHoocG7UmNcgLkNcRLB6ITA35F+V2Ktc3znvuFj5YM=;
 b=cA1J+l7xeYViUWesPfVTQ93zb0S2l0Gz+Xu/Op0z8TMaLnmrweP0Cn/whkosDjmnXb
 MtTt6RUbweqPQgL9ItTWAvFrjFjwxjxanbLUM1SRmX2YW5c7TYqxnt6Qg0ufW8rYWMCD
 MUOUnJ/YWcR8ucQGg+MJl0ZAEK06HHyveQRU6ZFgfdhurv3c10lG200AYNcl4dQBRcAW
 8pA4AO1zbIlcU9k1zZoyCC9QgB37aVdKv4O/XCdHdbWQFdqd0PcZtAgSNid8/5kgjIC4
 opyZORPIQ71QfGs6k7SwRb/TxU1+voCBi3PIZP0gC5fxjF1MAX68aiJ3Sv6/hkrWRKVR
 UC0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780856387; x=1781461187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9dI7viJWkSnC/emTNKYMOU675Nn14UCft033JgROKxU=;
 b=HQUWdm/6l3ueK7e20zMUQc66QiuZ1kf80CMqDH9ncp66reLtaqXD5Os2KEscCJTrSZ
 xkIo8ZH9/CoA3pYx0xmwu7SKRU2Rw88IRCZVKHoxMQIFHXMcDSeDwiQCVV6rw7wnYMp3
 D1J3YRkRN7/L8VvqETr5UBdfD1ZWbw1YbycZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780856387; x=1781461187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dI7viJWkSnC/emTNKYMOU675Nn14UCft033JgROKxU=;
 b=ojM+tOSZWdUJzqnNDB1hSFTGab3LOjdCQi+lHyT8YXuDOJvbt2sIgBjoTKaBbYvEjd
 3NSk+rhWlTeK1LMChS6k79fvmQ1KGxNajcAZwFsl+q6K/s6uAf92svJpnpbyxhZCV61V
 egv2FI0QA9Ezrq1AIME+gIDvBnseKRwl9ULAvG15rN0fgvkGkljLNZJViglrAT7+A0tD
 D1aWqQ+rRRuTJOuPhAYIOx8o9MWxiN5860yQJf1L040YS8A++R6+8hqwK8ICXtrRSjBK
 I03o7Vs5HENdsIiHBHyWGpgzp9iMiRtWm48/cPplV+HAsUMe8IKxC/Z/wvg4qowf/XWv
 jVZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E3cmhzktYxI7PNr4LCYZr0/P2rH1/3kVYialB1/I1FXYUn7W1CM/mCyBoqtXSspbsHF8f3YA=@lists.denx.de
X-Gm-Message-State: AOJu0YyI/JAUi5uYVx+rZ+p5BIr9sQSJrgN7GBlVmHgoLl0FKMreWHJg
 qEAdyPh99FhTZN2c2PuMMZCoctq449cWKEB/yj26yPN1QcQrnEgCDSCFSJyvrIBXIqRt/w3FKyp
 330O0T8t7I+K0UcgTSLBSrWA/zWof64TiHTx2kVJg
X-Gm-Gg: Acq92OGlvVa7mvDT0XVlZbDi/LS9Bo6/aIERsi4RaRFxUAjrSga8EGGX/Ot+OFKnROH
 fvunSflNF9XcvR6z+uv8nqklYn2XBShb8Hiaj0r5F3PNHMg9gvocxCH5/dj+dWkL1LPAQR2kOor
 O75lygUi0lOeBHi3Lc89iLW/a6jLY3X+qhEVNcLWRUmSuUPrA6Ztxdxlg4FP3oUifVw/qeKxIq3
 tGyGu5Dbo6oDQ1nLeXrj0wrM7Fa8ahzlFR06Qy3gK3k9uaR2OEST23BSi3pMNyXzHgpTV6Uvc4a
 zz7CWKuZ7+OhACpa
X-Received: by 2002:a17:903:1b44:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2c1e85aef51mr154732245ad.29.1780856387255; Sun, 07 Jun 2026
 11:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-7-ilias.apalodimas@linaro.org>
In-Reply-To: <20260604073719.48723-7-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 7 Jun 2026 12:19:14 -0600
X-Gm-Features: AVVi8CcOFqwlVFvSTUfkcoEBCiXngf1lUdTvInNlOHxhf3e41cSu4mPo2LXsRFI
Message-ID: <CAFLszTga+5dVPToo02yxV7+PsHQL5VotO9HVBWFJ7CuGJvFkfg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] configs: Enable RELOC_ADDR_TOP on arm64
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-06-04T07:37:05, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> configs: Enable RELOC_ADDR_TOP on arm64
>
> Since we added an option for relocating U-Boot to the last memory bank,
> enable it for QEMU to get some coverage
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> configs/qemu_arm64_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
