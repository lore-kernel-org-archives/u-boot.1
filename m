Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45000C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 360F1607F7;
	Wed,  5 Aug 2026 21:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1cQG19f6Kaq; Wed,  5 Aug 2026 21:25:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01CD2607EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785965145;
	bh=f9Jawq3tdYBIDNMJdlh85r+bgkeRMQnx1dzAwKZdcJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TyEuSQyZYa9dTK+kROawCmGyyo9DU3YxKVh8AYHcV7O0x0sWhyGC93hUET/JLXw6A
	 evGtxS7ZE9zotevqq2YQCIEd5ynd5xszOVupIXXV7H7fjVRlS6a5Rw2sg04FN0b446
	 7Nq8RglWZnqH64ltttAv2/ywUGK/jQ9r+MzinIBTchAd3MeqqJbwPq6lAJjKt1gwSU
	 WXrxNeuMRpqa/eeE1OTlUxAppBTm7ZdMUCFIsQFd6/zt3tQCrLA6kgqwYhKqgluC2v
	 9M6R5BJJ1ffCLoQcSDk7fSrmIrT7n+7ikKE9IzKqDVBqZAnGpIOErgC5BiEGKS4s5g
	 hQmVqX/TC6gkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01CD2607EA;
	Wed,  5 Aug 2026 21:25:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B318D218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3F2E407C0
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E71CnZ8KZelU for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:25:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A6436407BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6436407BC
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6436407BC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:25:42 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so2285192a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965140; cv=none;
 d=google.com; s=arc-20260327;
 b=qj3onoy/7Q1NL1LHkaBASuCuBZLa/6c3bPMkEOHRqu+CfvfShTAmjdcEXy5ejXBBuE
 +en8v6SQxqHPOFMWA4LwDX5EFV0n2iOYXC/hktDLy+KyfPlkhVmFeuYvfxWaaClnLY1V
 sRIdUQEqRpmoMOq315+vq8Yl0fnuBrWw+Uyo27Lvb3AdeNwcgDIDcV+utpH6rgvyXjgr
 MeudulI3KY9rxjpLX31VDK3QQj9YDZcft0EHfwJ8PaUNu3anXlCtM6+r2tSgj1oPPcMi
 NDvyzK8f4s0XxgnsGCvV4H88/r8CF/HgjhAEYVN8rmYSUH6ezAQ+MhuTEZR1J0xhuq5V
 wLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f9Jawq3tdYBIDNMJdlh85r+bgkeRMQnx1dzAwKZdcJw=;
 fh=+Puy9fwYevOxn716JvYlrlfH5sZHDNuisEZ1T4FU56A=;
 b=bJNPVUd3pfbnH5bGnUKX8tjTTVYbIZcIG02lL7a4tOApJR1bXB/4ldkl2TFNl2SI36
 QE+VDRQJ9uYADPUS3c7zMQey2Kf49fcgAcAX+UBXFpBdvJ7zOlNafPTZkvwCasz7z4pm
 dqaRnWeTpIv4kC0d1NNc1WEOvLeurU999XgAH95U9dq0R8Rb7fQuvdLBXIh+Akl3sBKu
 HWJIhqzfB/h4Vync5hNkejtdpfadcotasWMkvRycehVCx+ErYVmGzxjTCAbk0XZQR0xg
 P0bpr5XkFCKF2akKOqnk3ssofpKw4Q0n3st23I0JU1i4WwAqiddwSUdu6nCXOcmIkP9v
 q3Tg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785965140; x=1786569940;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f9Jawq3tdYBIDNMJdlh85r+bgkeRMQnx1dzAwKZdcJw=;
 b=O63CH2XpWW4DAA//khx6Gu08t1WB2OaUmgCDcULJfa9YSyOmEZRg5Irl6J2omWdNVZ
 7wfhcLwV/ywD/olB1U/RilD3yUxpqtm2NIZKZtndTED/9uOjZoCZqrJRdh1usqc/DYZB
 57grODISy2xPGcFZsxWB7SZjnXLAJsGzyhRqPGQzteDK9FqAupqGFAwRLWVgH80ekojj
 FMliFt16uGVXb+9UJI3f8ZIqnXhJ1ACtXetdhuWnL4pd8WYgEHc58cgAW/1DFSZOdPym
 yxiF4AOtIHjkYx/gU80HZpFgnnTn7hKnZK29LFcZLIkLVfv8WjqN9wT/Il/sU9qIvLYH
 dxCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RryFiQU6OOl3qMkeEDU7tuEcqbItsJGoZbPw5DDgbJWUOAkIKVdyf7GlIS0vXMPyoIxjVlzoe0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy5X3XtyA7pit1PTobAkPV72x/7uPJAodhB5oTYVvJbA5TeqF1W
 U4XRshRTwOI8nCddfttZWVk3da9Ba/nyLCPt00E0gRrKn5uc4+OinDphVNPph+cFMK0x7znpSqP
 Jxv1tUjvmoTb+0FzjAeF7CeHCgwTCh2GG/wskEZ1RYNRf/0FHwCw=
X-Gm-Gg: AR+sD12MATDcoH+0oLO3MfWHrtuFsGz33XzhHm9qu5zUx+7cxOMEYW1XJ/I9NBKMh/0
 w6qoomU6zRWuAdbxYiQPGryEt1uEpvcf2efC1SQUThV93c7T6Fb0264WsbbDAwjE9rfbWM7xRBF
 7WT11elSxRObS2t3AJGgWSwH4/lUGg+mKw5lC8yx+SU9tJSgtNTdvUo0h3oHQuxDNQATUE3l5s9
 eSiCmVWCNyHYrIta8BZrCzEIqY8IuGerY7SQ7fnGGhd2wSBrlivJOWmgPG/K81qW211ayVdKuvm
 0Lb/HCOckeAlf21MEWNI3+F5Z3fxWKRZVBkCv+UVjEc3tzCnqsjmygs=
X-Received: by 2002:a05:6402:40cd:b0:6a0:7a0f:ad5 with SMTP id
 4fb4d7f45d1cf-6a14f104412mr5424732a12.8.1785965140453; Wed, 05 Aug 2026
 14:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
 <2712b581-461d-49b0-af20-8abe98181d48@gmail.com>
In-Reply-To: <2712b581-461d-49b0-af20-8abe98181d48@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:25:20 -0600
X-Gm-Features: AUfX_mw6gFLQM8d1NRPYeeY6tBaVrGw0pO_iPh2m0rhqCoC4Jpoj-Q2XZUU6gME
Message-ID: <CAFLszTj1U=Skv2V-XXgV=Dc5ODsVoBDRjxDZMQtgh1EYW6diww@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] rockchip: tools: rkspi: remove reference to
 README.rockchip
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785965140; x=1786569940;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f9Jawq3tdYBIDNMJdlh85r+bgkeRMQnx1dzAwKZdcJw=;
 b=Tku3nLrAhRs4dhEBechEQQ4epqXCFH2H1Vepq0vlSScslcjW+mVayEUj2VtgjNxA1o
 DklE+0OhegT320Oyr/Q7L5ewyUPI2gf2jzEeHNo7CDBNscjqFokfeJabyQ1ydyXNETsJ
 Sho1OxhX0kPE5EDLrkUig7yld8+o4RbVVdeaU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Tku3nLrA
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

On 2026-08-03T19:09:22, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: tools: rkspi: remove reference to README.rockchip
>
> README.rockchip must be removed.
> Remove the reference to README.rockchip in rkspi.c
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> tools/rkspi.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
