Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD92D0EE18
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 21:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981AE840E6;
	Tue, 25 Nov 2025 22:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P5HvrRQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F1784132; Tue, 25 Nov 2025 22:47:42 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7EF383F3F
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 22:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c75fd8067fso3477421a34.2
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764107259; x=1764712059; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hACXirWnD3p+YdHPp+NGswpmgpkggfn32ycHMjQR5yY=;
 b=P5HvrRQManq4Tfe3J1b9Ou5jbqFwHwICQ0mjcCom11opeTQmHt51yaiXjiQZwsBhrl
 rtYFjzSGXrC5QXQHiyFKLJN6v+bPwoo35uv/Bo3SUtzgSPvUgLjUiOtFoKIySK+Wgq1y
 ZMqIm5wWzNqsdUqQUl10XkkAR3AskCRESLoyS+itUVnWqsOjGh4xvhI6wMgw0K46d+da
 /Pk1x1M6OWwcmEi8aBp0SmI3tMTt5SepkIfWOn7FJxQeDE6syfoliYsiG+Xhjk+IQEY2
 qX4AAhxA9+4ct6JGl1M3s6P5LT7sKNlrHlElroQLEOjoeLz9XT8xP61YDpYdWLZOuWKL
 2XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107259; x=1764712059;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hACXirWnD3p+YdHPp+NGswpmgpkggfn32ycHMjQR5yY=;
 b=CxirI0i8I4Q3ti//SLOkBwBAOH+DORqM7iPS5xpfwVTTEq8SIpwyBU01qMigv1x6cg
 tSf1bg7jaYyPjNDOQhFMDz5N2Lvagw/wOpKYVIhMvF3zSMI9vm1L4Lofq0fV95Q3J9+r
 qCmLxQrqNTaXlxu7JCYsqkfpbzPHDHUpu0La7uZPgC7EH2EfuH8MrmzbFeaaZ9Q5hUQr
 GxZvjFh98xXeX5lQNUeN+GIX9MVjcG2TgngVFQGK0jTQMYCuoUGUeTzjW49Vx/yKVJ7Q
 tsqYWoVOyqvUpV1xOP/8YRPLfLf9gFy3huSs8FpUTGir2315bfZ46E66nZ86N7DatVwf
 0yMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXEROl0m8Ul+M1J0TjnywBcBI1p/45wub7xgxxw46S25IDoofjOY446wDvR4n88YXZuh2zVf0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5o8mVDJxj/LtJAFMgGpqgzbM0pMUmAxuujxBkAmu6TTOTMy5P
 SapgbwkOJh/2Zk260x0DMEnIPPBQmoRXXjxMjpivspaaLrAB78NWtB5y8LrXhC3FYAcUsKBoB1E
 CMLs+n/VjtOiTMBy7bNc1vfzhegRhYmUZ30+EvzXTDvqN
X-Gm-Gg: ASbGnct8xKPqoT8wvZTWfuD+Wssvgvs6SN7Rfk/fynj1/v6CiRSOe2LTOCv7dFkkfGy
 mJ8tYlutKEe37Xbj8WWentFL6fnHiH1bYmCVyC/QIi30JCkM84+KGm94KeRVKH3OyL8WYgGDtfd
 8wWDdhXkKT2MZavBJi33Sc+NtEyoeiqoHy6E+J0LA0j2H1OabuZZytDDSifl3YVX60AGfuk3QQh
 8/9iuFcXviSAPpguNY3LeKzgILlSq6lIVS1tCzBy+MNEQi8DKvDvfCVcGwG+pSzjJpEVMCUpLMV
 VCAo
X-Google-Smtp-Source: AGHT+IEUC3AfcDVXX3z4ucPVDLrW3VMl2Zjfk3xsrTGr/0TOFsntQcbpysAwIUODsZCFrgZo/x+zzdCeqWa6LIGJcbk=
X-Received: by 2002:a05:6830:440e:b0:7c6:e92f:41ca with SMTP id
 46e09a7af769-7c7c42a837fmr3046321a34.8.1764107259599; Tue, 25 Nov 2025
 13:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
In-Reply-To: <20251125212953.1733-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 26 Nov 2025 05:47:28 +0800
X-Gm-Features: AWmQ_bkJLsM6jfs6xKs1Qz8gULvrZTmAht-y6GdbFD5M7CRTSo0DlijeDzsU9sc
Message-ID: <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

> +       select CYCLIC
> +       select SPL_CYCLIC
>         select SPL_ALTERA_SDRAM
>         imply FPGA_SOCFPGA
>         imply SPL_SIZE_LIMIT_SUBTRACT_GD

Hi Quentin,

But interestingly do you tried any case that when defconfig
had given
CONFIG_CYCLIC=y
CONFIG_SPL_CYCLIC=y
but empty CMD_CYCLIC?

What my observation is that it is automatically turn on
CMD_CYCLIC during .config recovery.

So I had no clue what you want on this correlated settings.

Brian
