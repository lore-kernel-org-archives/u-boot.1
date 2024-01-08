Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38234C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E93D87A99;
	Mon,  8 Jan 2024 01:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hr1qbzKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CE387A86; Mon,  8 Jan 2024 01:16:27 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C91787A60
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f5c0be04cso14301296d6.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672983; x=1705277783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lFmWPUDd5eoZk/Cz7lrbqTlfpngs8ISJdGFH2qXvH6w=;
 b=Hr1qbzKot7S2Yg5jSYZ/oRecxlmmE4UOFIulPgMp+eNEsb+q/WiWuQLYofkhFekmcU
 U7Jf4UNhxrKB2P7a5XTQuZoOm+uoL8F6hhB52f0TlP2mgD8PvvEDXvQTmxoEvvpsvVma
 Wmtvz0pS8QQv5iP9ZS3VxTh0qElZBvQ75cC6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672983; x=1705277783;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFmWPUDd5eoZk/Cz7lrbqTlfpngs8ISJdGFH2qXvH6w=;
 b=OUGFAiaP/HcC7sTW6OSEz8HSGtdxlZ0yA3jBpCp7FiX3LB6S+3PT6s0S1SNhj/YEO4
 PVFCG3AhHmuW0XViPZwIyLTaLJc8DEekoHl/HC+knPqWJHIRMc7MW07ByuWEsz21/Ly0
 81W1Jl7nerTzgEXIpBHpQRBSZrjHlyqUemIUWPY3l9N+l70gmRHJTgTYNDQ5wPdYyALo
 6NOpD2yCwZONh0Jc0iQno4nVt4Rh3GvzJH3dRrCvq9+2AbaOljRFsPMkdiFdrmVMb4hL
 ZljQGazqCPxNCQ3D4qAxLBNN1c+3PApQwoWm2814fajzG3AxhZfgzFPHOCu42RxaCuST
 Yu1A==
X-Gm-Message-State: AOJu0Yyu/+jZGovn7fUH5hxoub2bG/IxYiCHF2x5Jrig/7ZekhV9b9ai
 ZVBnxht/qewOiPA3ktLiz4jspraxRCuVrGbsaEgtu0Z6ce3G
X-Google-Smtp-Source: AGHT+IFGuEJF5h8aQ6IHrgcWXTdCbD3wQibmdHfqWj/ujJRR0Mw98Tihut4P4jzU29Krw8AJl1emsLTqpEX2DK9kCLw=
X-Received: by 2002:a05:6214:519b:b0:680:c74f:5321 with SMTP id
 kl27-20020a056214519b00b00680c74f5321mr4636251qvb.51.1704672983111; Sun, 07
 Jan 2024 16:16:23 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:22 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231231152555.464874-2-sjg@chromium.org>
References: <20231231152555.464874-2-sjg@chromium.org>
 <20231231152555.464874-1-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:22 -0600
X-Google-Sender-Auth: tlNGvhiXmodRge56VXmGc7fSJG0
Message-ID: <CAFLszThsoWvOsFcG0ho74wM4VQjK+my-VKZDbJ0Fvy_6OQhLXQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] smbios: Refactor 32-bit code into an else
 statement
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

In preparation for adding support for SMBIOS3 move this code into an
else statement. There is no functional change.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/smbios.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

Applied to u-boot-dm/next, thanks!
