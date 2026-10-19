Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDA2CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B3B281082;
	Mon, 19 Oct 2026 13:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPq3R_YWs2y2; Mon, 19 Oct 2026 13:26:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DFAC8101A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416369;
	b=sVNlYjXCnQE4I2HItYKlcEoNE4boxbWWJ5pRoEGwoobTU5z7euwavmhxgywhhZ+qX2ew
	 ojFyRCTZSDqURJEZAGcMVUUxvRHZkhiyqNAREDIrnAIZgZksytQbeVAS0bBy9EfrNl7Bq
	 UQcHEXRQRJYsLi/wph+ZeC8F181b2zZk7Ia1Qny225YI3HxjIbbWUkMrAbhHYzfFjyXV2
	 WP/1V2DfOg9k5ZYonPPezHVrCjODzLNw9rnW/WdPhFZLQAV6sxerSgOnwzUXaFFPRZWYW
	 0FM94V02Tz+AGDrfJWhf9oDYAS43GU/7J/btI/v83XzTjv20/+0Dk8YIhUHKdhpqzyg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LE2FbKJUN/tknBzlVfEId2LLTx6bCVMaj2BM4rGgDx0=;
	b=gUzY01js8wk4vSZ1i3XUeGQpsFRdjMKaCUKlMZU22VIzV4E3uQHgNpLXhPeMfuAnHqkw
	 NC7kAeSBIULM78CcTQ5M/FtQcde4qHhXvS41lAWlxl7IEmKekB8fqeB5HoMLskA3Yf5xi
	 ItkKR2o7sPpuPC4VeeNdMToeZVcc23sXlv03VBYCqhckyfnc4zYJoRpS7TwzqgWcSqUw4
	 sfrpP+MDpVaMnF5tqoZLdEbj7BF+dcJyF8BFqW5G/+U3nVJcHFIG0IJFqu276K0/qMrCL
	 5wZcMJsF8AfgvdM63vE2rhE45UeMshSENUcGvGYfQipKrZJ3JVL7AVB9Z9+xzFohU0g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416369;
	bh=LE2FbKJUN/tknBzlVfEId2LLTx6bCVMaj2BM4rGgDx0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZFDy0c4Ovb6y+rKDc1G4KDzP20FRvCEqsomXQH/nmGB8c93FUveJhIDilHAAObZBT
	 iFAnESfHOInuAhEode1JkgbdjQIfI6T8MMANuYVdiTlF01wLuGzjYST2DaA2QnAL9L
	 doLFEKqeo3TeCKQUhcVVFJE3YHQ6gEt8V/5/2WaPIgFz/0UyMe8vCC7fNcEbaA090Y
	 TucquHiBf5Hj+YounZQBvgDGEHD8JAkw3jXXjAX8j6KM1DIiPNCyO7ZPPWKcKLC7LJ
	 ChzFRtlp3pc6IdaT4zcPbcTfW4GbNKAh+F5xuXoWbEw0t9g2vakfhFM7TecLxvMl5K
	 N9ZKve9NskTcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DFAC8101A;
	Mon, 19 Oct 2026 13:26:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 11E8523A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC2F36063F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6llLw_gtIgJF for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EBD8760644
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416367;
 b=f951KtNddU/2sZLE8ZvnjSTXFRiDqxRCjEJjJaUUQiEUCaqZqACaUVwt25YBq27JYJXN
 2r9X1aVNjvWPIVusuEsklU1IdzCFklu1RYxVg6SGoQulV7Iv4Beu/ttWhcEm66PJBhGjK
 Hi+cXeG9ETWhawrB2e8Qge7v0Qm1MgtEOH4Ig41ld5uLhfaIcD1MCkBhjwibKx9F8N04r
 JmUIzoksbFIGSWD8GJyJ7aRinTDsepJrpLgM+yy+iABxGfPoaGnii3J1/29QME8li899+
 DtZoAXRQJNNCqI1rsNNYiv5ikD1YYxWWzwDpccmCKvSK+Y8oKc0tMW+ERylMhBZnJCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416367;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=LE2FbKJUN/tknBzlVfEId2LLTx6bCVMaj2BM4rGgDx0=;
 b=sipl4OpgtP2fHqdO0ucmxvKbw1AMxZe3lEahL6hj379AbBuemsoAMaDGhT+GvGX7Bg4M
 kSJsYu9BFX647Jtdm9uSBkvH/1CgOe3Kxwm/jxEb5wvwLR4g7bJIQW2r2Er42AUknRCZ6
 kKGWkRDSUJCWZ06ePRaXBHueXKLfSmMRJo8KIVqkLXu1Hq34Xbm09hgJxFJGidm87FbKo
 RaXrsD2FkaOKCpv957WX9h6Jlp+iv6jpXbzhzS//U3FFbEAVXbc+/zJsW5ChTN+V0fARk
 9ZX0MtIHkuZHhwN5fXEH9ukl0ywCjrZa5avWHPHWRu6fxBYK3JbMVCcpNOuA3bE5Yiw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KxA1rsZI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KxA1rsZI
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBD8760644
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:26:06 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1f4d8e09aso2999380a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416365; cv=none;
 d=google.com; s=arc-20260327;
 b=RkbbMYhBYSmloHSQTNCyZP7OrUyXdGGY/QzWgkFZKEhJB8XKwI4errEJSKWGpOplv/
 VG6++7HVO/W3FmVEPnWqUJf168ZwNj0wF01OLReO4MPL4E1gXBfCnU2Ey8abpIVV+ECu
 /oDIYWBp5f/hIexz01xo8IA1QKbTVv3oUgIHvdg74gxdsx1JGjrMzkjeqiJFWUXVXGzk
 MVMj2MRgANSWbUn9V1j0/G8f6eIQv0p9tQEkduBWPhAoI1tO+cWrhO0so/mCMM6s5/2P
 y5uYuFlfKm5BvB93tmQQ27lLDIpFl365Y5q23eFKxiHohjEWvk7OS6LJEuxWx1LX0piv
 DKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=LE2FbKJUN/tknBzlVfEId2LLTx6bCVMaj2BM4rGgDx0=;
 fh=/DD+xZkoNTprFhrw2DcgvRFrzcYjpf6tnw1WZgtxNVA=;
 b=M20FjtYN3BjKIacTSOHDaMNml6+tM2+nMnb1iKVZEzaP4DE2SCffrOnrLJr5Fa4aE1
 JX3TTe4UMphToiOD/JroRnRNssoFBrIV98FA+VFL/qmHhhoSYfwihXQHTcoOC7pB+Juq
 vINVrGDIytKVHCc42th6y2Fwt3iMdUMwIZj2oihx3QZo0fUodvysoRUAkWZBzkRZwKdM
 EfQXSjFHP5Zr+CpkT3z8bs5FBbFMiHlvEc0b27UEUbdgCrpHA6aiJnprmOxeMeM+36D1
 670W3JaeL/59lhRI6i5l5T243AVE8GffQp2J3S/Jqrsc5yP115D927Jple4hZvNv2oNt
 zn+w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416365; x=1793021165;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LE2FbKJUN/tknBzlVfEId2LLTx6bCVMaj2BM4rGgDx0=;
 b=KxA1rsZIpCDdWC+f+6yGliN5En2zbPeZ+XyRIFWR4zQmb/svisboMNOXzNelKidGUQ
 +vk/+ctg+0ht1FL1MJe1Nn9fcHfveuYa4J4z1Pt9qHkPu/uwgMjq2N6IA/GQVb/rurVi
 Tp3MSr3vVvwOHhpEeNwCvkmmNYikCPzSBOGvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416365; x=1793021165;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LE2FbKJUN/tknBzlVfEId2LLTx6bCVMaj2BM4rGgDx0=;
 b=aPwD58fGUhIYRAHPXAzuIq4lo6Pg7b2d73MTBmIkH8SGoT5LynrrDJT54XosrHCZsX
 HaDbsYyEXrSA2ewLQJAIBxweRLWXv00EWGbrRX5onQnf3J4Dvm4vukYOTjDonadij/8N
 IJ8x/BvwsFxpirOS7s9PkX5edLFa/rpi4BqPJhCBG/+s3bbDi1uSs5u1ZXyGixC0SIWh
 TEa0jrBifzlpRZD4qD8qygxxLX0f5xZZ70wZ7eSnwl8FhKsZ0pr2nnGenRsoIUxAS5nV
 38IjR4qQlxZ+M6fZ2HR0J2RJQ+lMKBy+FANnBzm85gqMcbh+EU2R3KK6CV/3YWPRMYQa
 Xm2A==
X-Gm-Message-State: AFq9FYIdAHtSPPqZI0AZnfPPf7fD/Tps+xvjazM4T6ffSCXRANf2Zz73
 oZm++6sbjK4ceWPufIhrs81wNuicGu7GSh/r6hpix7azlVfp9QbNg7BWx9Y44h6kgG9PNbisoqX
 QtxiNYCi5XwHfwdbBcqH42QI58vsCM2T0FTRDOKwfBYF3tvxvHnprJA==
X-Gm-Gg: AYBFou1f6xWynXkCCRONwTtQ6jy1FpNI+NP6w2+CvelIlMjS45psqzrP3/EuYv+GmZD
 yEpNRHWy2U9Zw3mntxSK7MgB8xWt8kXFuV6RiuNrtaSoZUVIlYj7mQJ/iZNNUPpB6/JL/V9/p0x
 OeFcmF4/c2kb5YSLeuJevgJtX5r04pFmD2/6Z65cocBvEQfAiMmS5kQlxTMA8+sTRuWn4i1Aor/
 +wqZaSMeJDxcOwLIWVag3GRVhjhUfCYgVcgLGuf1Usi7srvQZ0KUvM+uKUDQdOIVskngJyfN/09
 lzPLt5sWbsI7JW7VZwcZsopT0gyIaM+5m2stK2Cm/A5X0HV1Lp1/kA==
X-Received: by 2002:a05:6402:2354:b0:6ac:ae52:8b75 with SMTP id
 4fb4d7f45d1cf-6b3a81d9e74mr4622032a12.44.1792416364478; Mon, 19 Oct 2026
 06:26:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:26:01 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:24:04 -0700
MIME-Version: 1.0
In-Reply-To: <20261017184622.3925389-6-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-6-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:26:01 -0700
X-Gm-Features: AclHuK91A2UpAzXmkBcDwyZXkIRjGaWY78tExZlCfs7gohYTBzL1LDtx_MEXgss
Message-ID: <CAFLszTgfmvmXgn9tkfMyN5FmZUh96V7nsFOyF-yn8oCPTFG8Mg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] test: dm: Add tests for the virtio RTC driver
To: alan.tseng.cs@gmail.com
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com, 
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-17T18:46:22, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> test: dm: Add tests for the virtio RTC driver
>
> Add a virtio RTC device to the sandbox test device tree and emulate it
> through the sandbox virtio transport. The emulated device answers the
> VIRTIO_RTC_REQ_CFG, VIRTIO_RTC_REQ_CLOCK_CAP and VIRTIO_RTC_REQ_READ
> requests from a configurable list of clocks.
>
> The tests check that the driver:
> - does not use the virtqueue in probe()
> - reads the time from the first UTC clock and looks it up only once
> - remembers that there is no UTC clock and does not ask again
> - reports a failed request and looks for the clock again next time
> - gives up with -ETIMEDOUT when the device does not answer
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
>
>  MAINTAINERS               |   1 +
>  arch/sandbox/dts/test.dts |   5 +
>  test/dm/Makefile          |   1 +
>  test/dm/virtio_rtc.c      | 306 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 313 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
