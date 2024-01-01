Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8014C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C67878F2;
	Mon,  1 Jan 2024 17:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TGvRsQna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12C78790A; Mon,  1 Jan 2024 17:53:23 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98311878E3
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-680496bc3aaso29849026d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704128000; x=1704732800; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+7SJgA57XSF8SYO++sQc2xOXq8MF2gkDdh5WeQUSXa0=;
 b=TGvRsQnayMPNtaRLR6AgQm0Uknkgdajc3e0snke52DaKTrKRehhgJy36vgMRLtK1Jp
 7r5XgCFk8vovAvCof0hkB5Hw/t0LFAb2dsNGqxPcetbJHBTwS94GFs4xhzBg2mZk1N1G
 jJtjl4YzqTU00WeqPJnXGVjznBrqgwmtJXmVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704128000; x=1704732800;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+7SJgA57XSF8SYO++sQc2xOXq8MF2gkDdh5WeQUSXa0=;
 b=s1tdHTvTegoz30KhL9SsLflvLDnbO+nDPAujThOrelx//uioq5GKe6n4m0iYA2F3si
 1eEa+9zXbJQzZomDNO3TCY8nQys10g+OKfMTwJQzzjklE73AR3T9zXSYd1rE4EB3ZOiF
 h5gvsbxS7XD0LgobN+0lRWKtwUIHkn9tQQ7OFPwNpupnxZ8Jzc4iOeEfHvZyjese1XO7
 hIWKHfZL1KvlO2kh5kvG3DUNVckBk9VmSgrZBw/LBEQGLJ1N+tkQ/aLVScCpLZj6nrSa
 w0JhwXFmLAAwt3rk4300dy3vYxt/HctdAPyKe7Sa93NPv707gsDMAfDIJQWv9YpY0iVF
 qQOg==
X-Gm-Message-State: AOJu0Yzltjka4n8DAu/7VWz9M43qg+61xutrpJNHoX1a93Nc81Vg4Gds
 d3wxclJOFJFF4PHW6y18tgXkmCPAq8rLuBM90J84AbvH9Fglf40VBlwNpJaiVg==
X-Google-Smtp-Source: AGHT+IFAwOXI79gii/WPcbSuU+MyRYcI1ie8l++zVicAi05DZVMXRPQh4/FoxGWJrwaY3Pmj6nIegKbEmKMgMfFhAmA=
X-Received: by 2002:a05:6214:b65:b0:67f:9128:8d0e with SMTP id
 ey5-20020a0562140b6500b0067f91288d0emr31250229qvb.46.1704128000459; Mon, 01
 Jan 2024 08:53:20 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:20 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-8-raymond.mao@linaro.org>
References: <20231229174244.892818-8-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:20 -0500
X-Google-Sender-Auth: y_CLBNRyrdQcVkBSN71P7keM1gs
Message-ID: <CAFLszTjp9woBd7_ZP2HXEuJZ1Bu2oU=2xeuRZUMfeScCFtMHbA@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] bloblist: Handle alignment with a void entry
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

Rather than setting the alignment using the header size, add an entirely
new entry to cover the gap left by the alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v5
- Optimize how to calculate the new allocated size.

 common/bloblist.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

Applied to u-boot-dm/next, thanks!
