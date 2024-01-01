Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675A6C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D5A87915;
	Mon,  1 Jan 2024 17:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iFUCTFXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A510D878E3; Mon,  1 Jan 2024 17:53:25 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222FA87908
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67f91d48863so67982766d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704128002; x=1704732802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I3r1/w/9y5hLzDiu4nUYVmelI5ZU69Cuv7/zPChM7ds=;
 b=iFUCTFXRas3aJc6MGXUdh87/v9oTKXAC8TltpyuAI7Ei6dynTRlqB5A8WNqp4zf0KI
 rca7+ts+0G79FWdH78v9zvXLMqMk5wOmvoTPHREWJQTHVEdlFHQI5iOE25sJ1Q/2QD4Q
 8EVhS/JC54ukHPW1iK6OMONUH+sAD2JLnkugo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704128002; x=1704732802;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I3r1/w/9y5hLzDiu4nUYVmelI5ZU69Cuv7/zPChM7ds=;
 b=Y1msHzy8aG07LuJuNubTBh3ej8qsW7Qc2NEN3lYIKQinlENg8Ac/feFPTejDp6+zWS
 xBLziGTHgSRPEui3aaHyhblOA0yzMT2VLyRozx/Z6vaKJWvcfyscyxci5zDCBTPf4sAW
 WwyQ0WkWZQDP+6gskcOknO1m0yECV9wkZXmCeaqMjz7xxzs2cJ67m9AS8yQ+62kseONc
 qF7ahtQ5Uk0uCd/Db89KV8CEnfx9wu8lFcFmByk+D46T8RwDJ/pd3VatTm5TBzfgXHgE
 Wg5h0Q3GrXISsHmAAALOZNJJi/xVAadbaWDOxjp4kArR9cBrjoVnyb+WOWxyAOKL6bKk
 vowA==
X-Gm-Message-State: AOJu0Yy6EYPK/QE61x1lJ0YBFy5yj11bWLr8yILO1XlYly4t7XBb6vjG
 8Q1qsCILmCV/hVgrPUgtX2Bvr6jxEK2vDI/yaMPMKDw7+ZtZ
X-Google-Smtp-Source: AGHT+IGDbDyvjpzHKWeFxFgqa2uHoWs2QNsXD8ui36lmXuDYSEqEkcm7N/j8mO+tbiZ4ZesjxUOMiMmygHT0OrnTPMs=
X-Received: by 2002:ad4:480b:0:b0:680:a13:3852 with SMTP id
 qd11-20020ad4480b000000b006800a133852mr12524226qvb.131.1704128001970; Mon, 01
 Jan 2024 08:53:21 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:21 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-5-raymond.mao@linaro.org>
References: <20231229174244.892818-5-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:21 -0500
X-Google-Sender-Auth: VrC7tYwY0MgCuiIa-zoKW728vrg
Message-ID: <CAFLszTgigX=N3Q8pB4yg9KMQ+Mq+0Nx6pWjM6bisnVnmd8K19w@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] bloblist: Set version to 1
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

The new bloblist for v0.9 has version 1 so update this value.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
