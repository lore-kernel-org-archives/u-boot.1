Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFAAC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7222340CA5;
	Fri, 14 Aug 2026 22:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMaqj4ft1PJy; Fri, 14 Aug 2026 22:53:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16F9640C8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786748019;
	bh=jv11V0ylsq+JHq510XvwxjhEi9HHIgBByBiSbZTD558=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S8JDqefMQ2Z/k6WiMJk8H8+UrY5mx3GkyhDanFacoNpcQmPwZFaXNTcD/JoKDaieD
	 Av+hYcnEe9yDuNqzUICHi/VaK6aefHs/yvRtSIZZ1bFV29VGjRJ55MyzIZ2SvdpXC4
	 +JOoIvmLELmF1s4iUWluvRsUQXBnymNukmNes8cqIqAE1aCg4UtRIJhZnv9MpS/LHT
	 e5csLMOXuM+2QnKvYFvP+p+X6XnMHOXSGZ4dIj7p8uYEyF709TnDod+smY4jB4Ubbc
	 /eTzfAQA8KO3hMI3GU3t0gtefX+Flt+EPXc/R6MzwSBiEyP4bxR147coPf0ENyOPMf
	 mOjEClYeIyf9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16F9640C8A;
	Fri, 14 Aug 2026 22:53:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3B60194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D6CA160B3A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RuQ_nIZX08WZ for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:53:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 588BE60B0A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 588BE60B0A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Mj4v4ERr
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 588BE60B0A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:36 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so2257843a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786748014; cv=none;
 d=google.com; s=arc-20260327;
 b=WJXOuZFOFHrvL83bltuxkSSIiEItLUF5PWZGGUN4Mc1MK2Lak6OAQMBCIQw2CsTTc4
 3JEWCZzcZEWPUvnWhM4mEgYWRRLYOs0EAAij9CBtHEsGs3R475rWVZgtbZKiOVZ3aGMy
 MquN0HdE2b6U3wn/IzY4Bbn7C3g9GAq/kYN99T/Edl2dOZQxBUrCDgAUX4l7J1OAVGni
 YEdh0/EEKmSTXrwwCwNcOo1mp8lcIZ8ry5jnZx4GaGIj1rWEudU1pNP2g6ql0rKOesxr
 PHggzGx8bTFKIyras/dHJcWzROPjFQXaeco0PptBRtCL7VB1WdRSLEWFHQZZseJaxjDH
 enwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jv11V0ylsq+JHq510XvwxjhEi9HHIgBByBiSbZTD558=;
 fh=ERrUqF38Ajw+amVFxryPWDy35g7pZruesooqW9gwTOQ=;
 b=odriqlE2UmkbYWTOwHVDP55H6jyXopcbpNhGfa3p3d4qKi1aybv5ipqEAb4v7BxCl1
 /UqckUg0IBVMrxXq5fJ11GRPIaV2eASKsq7As2M7YPhTq/Ry9ISvxCBemeKDABdeTxqE
 CHezm6tw3f+dg9ACqwRSYxVzFeC4YjrROiUw5ijqrFnkDui4qNDQ2ORZqgaKrocMLCMI
 YuIWGZbC1t2YxbZlyjyKjgBulHo9YppGxSYdujPbyDkZulPTdXE3e/Hhs2C7NnHg65qq
 VUkmW3RROWtDkLlSTQYxRjNsfCt0SBaV2pKthuzGD0QDmG0Zazsvz3UZItcBMxUJdeXv
 51NQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786748014; x=1787352814;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jv11V0ylsq+JHq510XvwxjhEi9HHIgBByBiSbZTD558=;
 b=Mj4v4ERrQHbj7qYtvKrRT9zqLwlqsInIHdsQMfdiwn6pZHM/GK5BfW19NzR9yVp02+
 O1XPZghi/hUN5D+StPbZeFnEyODhY/Wu6R/Y8IxA4Aa/qTJJOjMbCyHy2/PeK5siveFA
 Uo6YA3OqTiZHT5cpJG3/5DP9zJm0xi2mNa3hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786748014; x=1787352814;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jv11V0ylsq+JHq510XvwxjhEi9HHIgBByBiSbZTD558=;
 b=K7D1pTMxaywNiYxHvHrn22DhUbboL6TGqC+5x/qot2FPfhr1B700RnTa71xNr5ZUkH
 LWs8btEylFHctRvK3MLWbdIbgXNwixCDWmcVjW0H9XCvjEQkso2j0kx6iSOh9mJ4Tuab
 4MDQoD+XAS5YhN/3ltddQnl2cPWmbZjGqY7geOcrc5aQEq+MGDUoCu2iNJ0AdHiuFQ+E
 o/6kP6EN9OvVYMtENZKT24AaAZkddarz5hAO6VyddNxNfS+tCxOzBGu3eaSKDF32Hhga
 gjZC5Ubu0MBuhoQFJX4HQ8MzfNIPQvDRQ8gDwR/LolWa+L7BHyaOHvtc3seSt9hrHeCB
 HrYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRlZCmn816F7RgkDYmDU4+oqO9cxUpIuI9ckOSVi0jw/snxmBH3alcc9eW2hKZ8rUer7LzJ1w=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YytT1hDjr9o/nHHistkuNMP47aZJTsuDWinum8y46Z9i5XGGkHe
 sLHHsbD1MIyvASiz++8Ra3wloToD7kq1yKUYu5QXjKNeJ0GUk6P0+cYR0/wzLBK0TzGA3x/4T0y
 ZFG6jmCaGwHX5wi17/V8xSTRfDLPhflc69kLurt/6
X-Gm-Gg: AR+sD12XF4lLMOPz6TnixIu80yowv1W7RZ68n6zmkL/3CeJQuTy1KrCEQcK8TGSdwEc
 /dWQAi7ys7nWI+U4nYvF7PaKcQNvyt54FTVrsSmOcOut53j8onwbv1JiAte2Q5ooEIKlJZVlyer
 oXV3D1g3ntct04jjaMf3CMwFC+Xr/tBMr/YDWXKD4zLSLe5OSDjrmENO2x5HQZm46CRACPVLvzR
 7K8aPDDdVr5nNaGAQOJd6+Ht/bU4CRShl6qVat9jOspX/n1khZGTm7+X7qRVroyRBbxEQ0j4O/c
 K112WovScQcqYNiCGvcus9PuLql2CF+LVKJ0jXQ7hQI=
X-Received: by 2002:a05:6402:1ed4:b0:6a1:e4b0:3385 with SMTP id
 4fb4d7f45d1cf-6a38a999a62mr3851486a12.11.1786748014299; Fri, 14 Aug 2026
 15:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-rinta-watchdog-gettime-v2-0-d8a5a7aa0df7@nokia.com>
 <20260812-rinta-watchdog-gettime-v2-4-d8a5a7aa0df7@nokia.com>
In-Reply-To: <20260812-rinta-watchdog-gettime-v2-4-d8a5a7aa0df7@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:53:19 -0600
X-Gm-Features: AUfX_mxbCoIukK8obZM28kw9esOWem7OQFxD9Znikm4qk-H_035QtJr0dRiLdAU
Message-ID: <CAFLszThgwEacAB_za5Ne+dxar4rah4KRyRUoMORtAuMrivENFQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 4/5] watchdog: sandbox_wdt: set max_timeout_ms
 in probe
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 u-boot@lists.u-boot-project.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-12T09:48:39, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: sandbox_wdt: set max_timeout_ms in probe
>
> Add a SANDBOX_WDT_MAX_TIMEOUT_MS define to sandbox asm/state.h
> to emulate a hardware-limited maximum timeout.
>
> Clamp the timeout_ms in sandbox_wdt_start() to the defined max
> timeout value for testability.
>
> Report the maximum timeout value to the wdt uclass by setting
> max_timeout_ms in the per-device uclass-plat data during
> sandbox_wdt_probe().
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> arch/sandbox/include/asm/state.h |  2 ++
>  drivers/watchdog/sandbox_wdt.c   | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
