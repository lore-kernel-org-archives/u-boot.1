Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96004C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9272487923;
	Mon,  1 Jan 2024 17:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a/dN0ifa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F538790A; Mon,  1 Jan 2024 17:53:27 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368AC87905
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6808c3938afso24362896d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704128001; x=1704732801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zAC10/pSog9rJdIhRqToXdWf8uHKVS4ve8oOp+6lIbU=;
 b=a/dN0ifaLM0ujXAkPGwamjdCNEDMS+JOH7LkGSwftDiDQxiTDM6s6lPDkeByYNGEZv
 /9A6v+AiZD+UUXPeKp9gfF9cPJ9tAs+fcKsjgSsWonDTc2IrfM7g7W6VNOCOPnsmBI7c
 CF7aD9aQY9pkeuFUYPFQgFQWUIsrXehkGONTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704128001; x=1704732801;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAC10/pSog9rJdIhRqToXdWf8uHKVS4ve8oOp+6lIbU=;
 b=HkjtD+L8TXbj5cbdIShQ8cDEoT3EXlgw9rrN/An5LvPJ1AuCJsmU9jIf4LNjI/lqws
 fsJyXDeFgdZmpWagYQ/Z4AqpAiZPsh7UucshE/ExPp8S0sc2UNIGzCCwHfor2Z0tYH8s
 dXysUu6NHmNXVeSrI/zmCx4C/q1YP92XQt+tCZTp1xlPugdMjpn6e9EWNZ/WyBhadiRF
 Zu2qkcADd5jhQwED4G2hnF+dWqesl4PstP6cj3pdCxPc0Y0GysPrYZMrbrdij5VNI/tC
 eYnWM8XkZbe8eGI7KluHmtosoZAd64xJP/DIiiTHoaGYOCesJcFwhyS54Vk6+STdRCHl
 NffA==
X-Gm-Message-State: AOJu0YwmoEDWTXF5LvLZ92jL2GNGpSXoW2toiP7eyycVxeXHG+aHa5Na
 KTkaN9XcxQXO2rqsCSXsUa4XHkDA5JmASFM/mUQd3Ntw92MK
X-Google-Smtp-Source: AGHT+IEaMEs1yALUxNOvwE9eDubnl5ytYhyiP7dDyS62USt/Fzg0p0A4IZtXLstY9IwV0kBj0VKPNIEcrifnlqn80uw=
X-Received: by 2002:a05:6214:62a:b0:67f:5784:bf24 with SMTP id
 a10-20020a056214062a00b0067f5784bf24mr23700149qvx.48.1704128001065; Mon, 01
 Jan 2024 08:53:21 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:20 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-7-raymond.mao@linaro.org>
References: <20231229174244.892818-7-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:20 -0500
X-Google-Sender-Auth: hRk9uqJSeZ3Hssrc86itXcTWVyM
Message-ID: <CAFLszTitd7uvz0jZ9_ms7Q=O+aZt9pkMMYAi772egaEuvUfL+A@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] bloblist: Checksum the entire bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
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

From: Simon Glass <sjg@chromium.org>

Use a sinple 8-bit checksum for bloblist, as specified by the spec
version 0.9.
Spec v0.9 specifies that the entire bloblist area is checksummed,
including unused portions. Update the code to follow this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4
- Patch #7 and #8 from v3 are squashed into this patch.

 common/bloblist.c  | 13 ++++---------
 include/bloblist.h |  5 ++---
 test/bloblist.c    | 10 ++++++++--
 3 files changed, 14 insertions(+), 14 deletions(-)

Applied to u-boot-dm/next, thanks!
