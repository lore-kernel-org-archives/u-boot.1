Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECB2CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F9183FEE;
	Sun, 14 Jun 2026 18:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a/lhZBsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12AEA8485F; Sun, 14 Jun 2026 18:21:20 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C2E983EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bf046d4da1fso226856466b.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781454078; cv=none;
 d=google.com; s=arc-20240605;
 b=en6WWit55mDpvMj2cfLe7zJYNmTWGpq3Sr6rpVWXwVkqNso4gKSwsveaTgQfYVp1XN
 t+l86kqbONqI/Ymmvalz2MhRkFCD138bqNZ+BqN1f3Ak4M+e4+qM/IPrasZU74ClSMTO
 ga9K4H7wtaH8g2AGkq4OpZKZAkOKuAAALjaAWCuydQoebl0eN0raQr3Uxe4V5T4sdlPU
 YkX4gB4C0MuZdSE4gPGbW3DhShaYDNl7hZJLmk1qyy4Ki2oOORtBettRIuyoF1lluak5
 ix+OC3uxNZHyId+SukCv9YtkP/dnjigt2dXtuODeyrZtSmSEI/Qi1T5EwY4ozA5XM9sD
 l2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cK45nqv3rgbXeZFCucHkFwFTavyxyaBvnEbtoxbDzns=;
 fh=UHUx1BDKHdocvmGSlr/PQ3KVOzKk1jhgkH55wk7Q0/c=;
 b=Z5iSp9p6+dCSrTQR1/DCNkIwh/ay4uZBtxMNu1DgB081OaCkexBZ8OD6y03BFAhEnz
 tIr0sN9FJcKim/7QDCiDLKq1FfjkF83p7WolQ+8KLhzG6b6uyWa/Z4crKxyhO/pR1Hde
 7NY8QzG1TpYi+ttoA5fYfVOMAlimnWnU+9SOw/Pqa0VUefYbDqC9YwkR3XXWFhKJKe2f
 XvojXRdQ9QzgqzlZizWur1VecFQ1CXT93vvLOF6AcL6dLmqKc2yNKm8d8aRJE0AhR3fq
 bRavzbMXL57mgnuxB2pcVVmmNJhMLxLd8ISvmpAMopph8RnBW2uAd5WtG/82c6RfUbra
 XAEw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781454078; x=1782058878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cK45nqv3rgbXeZFCucHkFwFTavyxyaBvnEbtoxbDzns=;
 b=a/lhZBsG+53umJenk0oiVg1aIm2yI/AB2B0RNHFoKiKwntQvVDgCcYeQN4wF7n5Qi3
 FE1vNdiEgAf1gNovntal26nRvJLWNNyveUNVWF5lJsZ8l+OMjbu3j/wRHuFPmyj9KUsj
 ZZBUcguGC00HIcVTPlB8ST/G/CIUIPoeFXv30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781454078; x=1782058878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cK45nqv3rgbXeZFCucHkFwFTavyxyaBvnEbtoxbDzns=;
 b=LhCLqTCenkdG/+f/sM0F5AGKInIJ3tdLPAImCIdsdUGE/E5nj36tSFg59enCj4Avez
 Z83jpFX4nhyQy8ogpi7hLRw2HOZ21t+iqjWYf35Jl67yF9tR+/5b3tceKL+hYZj+HRdZ
 9URMNygrKm1oW5IYE4RKB7xpniLE8ItYws1SUqVJ6aoxPCN7l6OMGqqWHJbVI9rgCwFD
 SfnWQhagvVHIQLxkm0OAKQYcXKt76sItbO8I9aB7dWNNzw2ulSSyTA+SCHQQ47yMY1Jx
 vr0QLJmTYiqSC17ebPoxzNYRn9Hm0LyV7PON9aYpWCtQU7lbBKpiaKkOcjgjZSHmGfBs
 HouQ==
X-Gm-Message-State: AOJu0YyBRvq+x2IaEVqZ2GpGzgNdMO6fFdLhKmiRYYVm3hjy52o2AtKg
 +KKEoe6f7XxRDNh6GvWWLiX2P8CS4yjCby212qeP5ywFuAfO0i1UOrQ5YEDTAfJxvjLwm4UXIO7
 do6JYqUoJLaRHlmqPEbGVfhHs66STj1Pn0V9TmGb0
X-Gm-Gg: Acq92OEiFBj1aI5iJW4Fv3O/G+qy8VmV+S36AReEsT/HK5RTRmtiz8ii5TycGv8dch6
 upw1VWQ7KGBtt3GC8idFcQ3XyeM4xNNhzc12iPatV0GDhRzMglpJ+wtsCLhKn7kSq1lLnOqp3ds
 U43ultlU1suRQNeLAy74rJEEFEYkcXrJE+HOTjieBYlTCXq7g7nFJQb0xW6nWY0tPIGQFndMlL8
 y72MLac4BsVl6+walq2o3RrJVQed3WdYRvdJ9WiZz+i5SEvpA+ml6fl5lAh0J6GHKdlHF67uNCx
 ux1f8g==
X-Received: by 2002:a17:907:d87:b0:bfe:ed06:5a15 with SMTP id
 a640c23a62f3a-bff4cddba89mr334847766b.51.1781454077501; Sun, 14 Jun 2026
 09:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:21:05 -0600
X-Gm-Features: AVVi8CfH7o9eqGMD3ugh7BITTK1_mwCPP_7ZyVoI9Vw0pkAmWVV_NeVa4whO1Ow
Message-ID: <CAFLszTiLj+ic26SuHcMExdvcuZM+FjfMT8WXBy8hdh9sib7p_w@mail.gmail.com>
Subject: Re: [v3,00/10] Generate Android boot images with binman
To: devnull+me.samcday.com@kernel.org
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

Hi Sam,

On 2026-06-10T01:27:41, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:

> Binman configs that produce flashable boot artifacts are introduced for
> the following devices:
>
>  * google-sargo (vanilla v2)
>  * oneplus-fajita (vanilla v2)
>  * samsung-a5u-eur (QCDT v0)
>  * samsung-gt510 (QCDT v0)
>  * samsung-j7xelte (DTBH v0)

> To date, this last-mile packaging step has been trapped in downstream CI
> pipelines, blogposts, documentation, etc.

Please add a short doc page under doc/ describing the
android_boot/QCDT/DTBH entries from a board-porter's perspective -
what to put in the -u-boot.dtsi, how to flash the resulting image, and
which devices it has been tested on. The per-etype docstrings are
great as reference but a narrative intro would help adopters.

Regards,
Simon
