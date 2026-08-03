Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1C1C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E00BD6070B;
	Mon,  3 Aug 2026 19:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NjRi3O2S9ntP; Mon,  3 Aug 2026 19:26:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10751606A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785785192;
	bh=s2iXVDdo+8hYhHYksbPi++Zs6WZMGHxq0rb2nvtAbS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FqGXtGN4Rl2wyAUzQAeEcktJuu1x4nUJxAsAG+/DP4YrhJuqt9nFlGZw6KyILRilP
	 naHYOXT0IgOfon3Nv9cYY8kvxZHgr0ajp7W1hTtD5eGyJFCOdOZdIKtQ3BiFOAsm22
	 r9Sf489vzZjMCR/zoldk9lOjlzygpzvJXbmqJLAjuBWYpuztkhGwe/eV8fpNba/B0+
	 HHPVdIBvY3ah+OU5Pkkt/qTG2Ef7evoCrp5ICOyXmTi+EWi2g668+9S48/qZyL3clD
	 w5Eb6qgymbUIx0lk1Eeljp/zYnNSH54ee3BlBq6aMD/rI0B9tKovOzM1hhh8RRJtQl
	 HARP7ZmAuwo/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10751606A8;
	Mon,  3 Aug 2026 19:26:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9062A2CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 823EF4010D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ZDKl59M8oZZ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:26:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BA3604005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA3604005A
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA3604005A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:26:29 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a08a2b7e5bso515820a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785188; cv=none;
 d=google.com; s=arc-20260327;
 b=eibMNhFoY3G+WTCdv0hR8pgVzEne5ZzufAJsYtqrzBoL3HFC0xvAepc1I9TH7mOogF
 uDs0q5rygBUhvKFDyX9sY3NzQcLsQDZXVBUW38ra4YobATKWIZgBhRHbz3WPO3LA6xiV
 5E6NwpsZZIZpDKwodfIJ2LB3w9ebzcfBQG7x9NH4Ce+Hc9U7kedmWnfG7a/pDoJvfpBF
 ZaQ4oraYMPAg2iTmLMj7KPaW6vYu8pKea60P+9CSkpxFiF9WZbTmXD2FiL+1M9uMGfEy
 Y1IG0hJJKP3TSGwJ3cuICCorKHMmuv3iUURoceCvIaAxg42anstbnv7pzYYlQJgB++ID
 qEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s2iXVDdo+8hYhHYksbPi++Zs6WZMGHxq0rb2nvtAbS8=;
 fh=mmPxdJ2G/zVEnO0kkwO7IpmcprJCuw1ND+QV0f/fx0I=;
 b=hDQv/0baWxhrmtt3l50tOyQCdi4QOMfnezVm8FsUoofqqvYsRXhV6bX8rRm0lAMnjB
 AkWKPkCAZ5vlBaBmrJA7H+likZZwieVundyhXW7dxHLgzt9MiXohhgWxy4i/2BpZvYai
 ieE48k/NBA+HhuE5DfGIerk/FuA2jacV6KjJuU5t0PhhhjkRsl+Udp0WTiDuoJ9O5KYD
 t6X3H3zaEvh9i3F7NDevQnesFFOdbWooJqMejQSNjsXiKIbgbeFKjTPalG/jB/6S49b+
 mpISWpihGTRxOEjzWbFAur9ESu6AvuPQk+tiJrxYjzS0VHK8jcVbGovtvtWA8BYjkTxK
 NTjA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785188; x=1786389988;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s2iXVDdo+8hYhHYksbPi++Zs6WZMGHxq0rb2nvtAbS8=;
 b=if6gjaubVmBIaKYO4aMjorADnySF14C2StV4J8KZFHZ7+kxiL2AHSgPFUSIUaWAK0s
 IocKYdTVa35pSNU1bfgtIw2f3MyJ9LMzn7ClZFQcRjiB42SMMSIgfkV9JurAl5stEBcR
 f/Vl+wx2sfQK/iXnzsQgLFJ7WoZmy8nkBgw7wn54yVZYekZ/5cIJ9AQFLzHaaZ2IKlrz
 b9a0BsuZDspl+MIkTyVnmsESGo0ukozhrw07CnBkHYyzlHdM9y3SnxgGz+xFkioSpQsM
 hVN6XW0CxtljGG/bTHPyHot0fVhy8jmlYS+B7QZXYc+NzAgkkTKs6rw7VEYQXTWM/Kzy
 ZiQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnHLbSIjagcgRHBzayDHoY2qPifS8Jq0pcC27m9E/r4IA8aMeo2NDIKBYOSzv/r5pH7BneG8s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxrHliyiVlW6wilQS/i2N2B7IYWGkg9t7ShMwX62gX7qz+6MbBw
 TRVN3OJ4Q8o2tg5Lc9T61OgoWZWWFaRWT9VRQdkbqhgpULkTjja4c+6iZtGo/BJP+OpOmJPDOP3
 LSq0oJs6iVbLx6H4GHbpqjYMXsl9hHAEf3gGCDGji
X-Gm-Gg: AR+sD13wBvsGkq2AfLHZabl9J2N0m5DSFqR/YJvWvELF7SNadq+s6axnmGIYe1BDQ8T
 ww+LFtAjV90UpYCWPtjmbUJl9bAZ4vhR3vL15jD7ii5wTZoiGC2eXZ1Mobw3/P7KkaWwJw1jAV7
 +u2HRs8XVrB+OpTeZuVXIzKPjkximdTcYJMRr33ylMIAQyzB3yRdZrIpixsKHxVNvUWbgtjf34R
 augCjBiUdQRHf+XaEGzBk0d2GI5UupNlTN+5uq7nDNpAYv8XPZlDEbJ1X4O38VR0DbcESEY+WC3
 wFuAgKdY/LUI2n+EtFUbdtRXxcjj7wpL1CKluiIR/lk=
X-Received: by 2002:a05:6402:5383:b0:6a0:d320:1ed4 with SMTP id
 4fb4d7f45d1cf-6a122e3cb39mr921024a12.1.1785785187796; Mon, 03 Aug 2026
 12:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260731001347.35624-1-aristo.chen@canonical.com>
 <20260731001347.35624-7-aristo.chen@canonical.com>
In-Reply-To: <20260731001347.35624-7-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Aug 2026 13:26:10 -0600
X-Gm-Features: AUfX_myJBgMz-xsPoZvDsgdK0NqEyBUXu2WIqP9u1V7hMRb5e4Z6dYyM66Aciz8
Message-ID: <CAFLszTg=rQJweERV_TSZJ+11RUSTb7pnT4cJrBjX0BTWre=w9g@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] test: fit: cover mkimage load address overlap
 detection
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 sjg@chromium.org, nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, 
 e@freeshell.de, jonas@kwiboo.se
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785785188; x=1786389988;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s2iXVDdo+8hYhHYksbPi++Zs6WZMGHxq0rb2nvtAbS8=;
 b=DnAcSYxZmLIbjDb+62j+dWv+ccY4JMWjfq9ENe+T6gEoHLY1/4cGO1QW2yekwX7TU6
 TchFla8Q87FX/3vnuapgTvwVrQe8Z+teM1zIwD5Zf06iLzyqFz2DqQujmZzi6bYVzrfq
 DZDfSgJO+r+wAXeL21NFTvACH2A4SBE+B2Tfw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=DnAcSYxZ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-31T00:13:34, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: fit: cover mkimage load address overlap detection
>
> Add a test that mkimage rejects a FIT image whose configuration
> references a kernel and an FDT with the same load address, and that
> the error message names the offending configuration and images.
>
> Also add a companion test for the intended escape hatch: two images
> may use the same load address as long as no single configuration
> references both of them. Only one configuration is selected at
> runtime, so such images never coexist in memory. This mirrors the TI
> K3 tispl layout after commit c85bf61b14f9 ("arm: k3: select tifsstub
> via board_fit_config_name_match"), where each security state has its
> own configuration and all tifsstub variants share one load address.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit_mkimage_validate.py | 136 +++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
