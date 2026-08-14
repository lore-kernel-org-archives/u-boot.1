Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B23C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4715A60837;
	Fri, 14 Aug 2026 22:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j9RHD-IkXzVv; Fri, 14 Aug 2026 22:53:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D77B608B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786748006;
	bh=rrwmsMDvYwnA7/7McXe4XdzGd6v6yplGpXsFrp/XGE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fCRCRvdo49/VKepsL53re20Ju61pUATRfNc9AcUHoQnfIDNI3ZhZC3OCvBcUKrXab
	 v2bjMwHPWfWRUayaVtIXG6MWmnJM9KmclK+hVi8tl0eCym84Aebv77vIfQm/uyIM1T
	 /S5Wb/bBeBOGfA5qzwfFfDv+1CjnOe/gM7jCou+wJCOdcn422/qSroX+visBEH60uQ
	 QcnJMxV7Qb+hJqX6IusCGtmFd1looK2I+GEHe/WQgp6RH4qIM5urnkQvbpLbN7uSnx
	 mtMKE7gt703JH5ujnYAWYKAYSYskFXwQ9iQwL3fZswBp6VFHST2nhNDBQJ3YtEaZJX
	 fG6C6rtg9tXuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D77B608B0;
	Fri, 14 Aug 2026 22:53:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23E433A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A22760837
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z6f0qaM5GKCD for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:53:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 14A85608B0
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14A85608B0
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bblXpbN6
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14A85608B0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:53:23 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so215237166b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786748002; cv=none;
 d=google.com; s=arc-20260327;
 b=h8dXWGbU0/aHmkDWRVRVUnJBOPOb5Hg5bDPbmDFUvmcVJ1zwbex0rwvAeTjCxWSiLy
 YB75JrLWoVmYmfszOpkUTVanDmlpb/0ytjNFUw4WM93qi4V28QFMCE8q6Av33ILhbGCO
 RUN4xzw7F2qTOpNvgzb30D59Qppe4U176adHGNOiK2Tr8ik15BmMrjHQPl69ZhY/Wgac
 iEjA+jw9LKMD0lu68vwE6+WoOPsaMco6O4DRs3lDhTTfX/P8BbY4lEqTiZU3h7M3Vnbr
 aJ9gyZwNTnrSrXsnssqMnVmkc+autUdPIi3aEfPCD9ZOZr5XKwWrEq8YLf7AmI2gbtAQ
 qzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rrwmsMDvYwnA7/7McXe4XdzGd6v6yplGpXsFrp/XGE0=;
 fh=2h0obhbNOdUPqfYUba7hsorYl/QPLVzySm0J1bcZ9Ac=;
 b=QoVkOlgEHksiA7MS6kW0H4Yb17DAfz20DZ40cKmPxCVHag8bv+HMwiSVllNCrvWdmq
 3R1u8wurxcmlNxWfgFhGZJTY8qyThdS4Bxq6PTLb6DeC18UFPxYXTrd2AoNwSx1VY1B0
 O9AvPb3sQ/5oiOCVjVGjydo7l2+cgVIX6+RFe3e0k2TZHjr7t+A+7+RSG1GbNyDD1wlB
 Fl/gCWyWF5aXiWyqLqK1bmlmKuss7sGt3oOxOHXOWFeYLb3ospXkBghIkyCYCAeGxKef
 N1Xq3VsaJ5T4XW0fxh1ldAmp4mZABqhkfwn8AuIrOBVsusx7gAV1HayvmJIosod9+YDV
 Z9mQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786748002; x=1787352802;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rrwmsMDvYwnA7/7McXe4XdzGd6v6yplGpXsFrp/XGE0=;
 b=bblXpbN6Sm6UE+cow40ZKBXuqBGwUg7ObZOJ0zoa2//MkBER52kKVhVEu610ECDHCM
 EVrqFAfvPK3RB3UBjQ/MUxv9bQ9aTIThXxkzyykHzTC9C8CUSKTeSNaZ/WDRXYyhRfgI
 ycKCpGfBOMZHhE+qLbSMQ5n/TL4K5yltO61lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786748002; x=1787352802;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rrwmsMDvYwnA7/7McXe4XdzGd6v6yplGpXsFrp/XGE0=;
 b=HrM94CNZs2Um/cyvSiCxEzNBxSkrOpdP44HW5472JdPJd+xmfqzUFqUKDim1EtYl8j
 EWF/gFqtxQqOwMQTnpLI0y+L3Yx345LjIUr6fdc/DOGc5BCuHn36V1g61Vd5rOaTemC+
 nxEv4whWskerWOsz2dnlJtF8x1nP6UDt+oQs2ciM6oX0vSOqfjMdSjtTwUxQ0jcWrlWl
 5o9wL8rJ2ZbX1o3Ry3OlE0VzHgx/gufY682bPo60eiH5RmYIsMMXYsh98uwvvtzd2jCJ
 nvWKVC82KFGBzchtXjnDY3Hi1jP8EQ+U3JgzA8GN9xk76ExKdEqiOEiE6FxrtdkXv9ck
 TJiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEYnoT5s6OMNiIudCezm/qCNBuwfM4D3uPVN+tJmYbSm1C/ytvb6p2zdVyscAVk30bqRsar10=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxQy4KafOPgNyk5MNZCQc3UeiRC48T8hOLeVc4v9yaXndxLLF+/
 roX15pxUMMLqLrxqarwqueXnEeSlxmS2qXrhQO0Iqzbv9itz5SbW0qrZzl2fl7ZlD2mOWXL10Fn
 0McrycBoMqDEFoFeXygyzDnZTdYDmok4zLERJUsVn
X-Gm-Gg: AR+sD12FFlg7o+ylr73h0gNJacUJiw2DDrvf66F/qRTcXlR4HoGrAnkrMqEHPWwhbEe
 YCjhm/LB2P4hYtaZOGK6jMbQBHq4uoF4ZcDWZP3mQh9ta5EHY6M/8QDI1juA3Y/5TWfAOFKxIrd
 O8A+FP66j0sV116XrFj/ff1piV+ibARkRNGvMi22rUlSHbzGps4Rs6JzLxTqqWSI+nk6ddx6uqw
 u+mGSXn9SpkKcyGYD7mrWoTLff3zZo7geArtMVYJS6FiBOiGYCZmc20TNEd7IG3JHuBd6v2zHXD
 SvcnpSPAw+rG/bKiL/3qbu9KdLRA/MvQBVsX5slfpME=
X-Received: by 2002:a17:907:1c03:b0:c1f:97f3:7225 with SMTP id
 a640c23a62f3a-c212a185b56mr334997366b.6.1786748001988; Fri, 14 Aug 2026
 15:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-rinta-watchdog-gettime-v2-0-d8a5a7aa0df7@nokia.com>
 <20260812-rinta-watchdog-gettime-v2-2-d8a5a7aa0df7@nokia.com>
In-Reply-To: <20260812-rinta-watchdog-gettime-v2-2-d8a5a7aa0df7@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:53:09 -0600
X-Gm-Features: AUfX_mwe0BnHg4ZZxbsVBdqZTaNoW9YPQNBc96Y9_DRHF79pqK1zxD_LIjVIki4
Message-ID: <CAFLszTgm39atdsnhAxe-zYBU_Ht4TuNdD_ObhLcUemR1Hx4LNQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/5] watchdog: sbsa_gwdt: set max_timeout_ms in
 probe
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
> watchdog: sbsa_gwdt: set max_timeout_ms in probe
>
> Report the hardware-limited maximum timeout value to the wdt
> uclass by setting max_timeout_ms in the per-device uclass-plat
> data during sbsa_gwdt_probe().
>
> The timeout is programmed via the 32-bit WOR offset register and
> lasts (WOR * 2) ticks, so the largest representable timeout is
> (U32_MAX * 2) ticks. This is converted to milliseconds using the
> timer clock from get_tbclk(). The value is set only when the clock
> rate is non-zero.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> drivers/watchdog/sbsa_gwdt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
