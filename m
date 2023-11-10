Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B113FC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9D4875E8;
	Fri, 10 Nov 2023 12:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YDyY8dwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 699D787585; Fri, 10 Nov 2023 12:50:52 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824D18767B
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9e62ab773f1so86786466b.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 03:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699617050; x=1700221850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dsRNpY0vrDO+FW2upv7hix6RPlI0khs1hOZq4DWE0CE=;
 b=YDyY8dwJq6L2fjJxZ0JESaybc+zOflkOXTfb1uyisBawFFzWmwjMijI490E+VgaMsB
 GO+hm21qAwfv0cOcdAQfRANRaBJw6ESDALoy02bcOOV1OhZ1dsMSEAODozm+I2oLVwmh
 jTUuHTs/M+UoXnpLNLUVWOms/mA5tFq4y921U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699617050; x=1700221850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsRNpY0vrDO+FW2upv7hix6RPlI0khs1hOZq4DWE0CE=;
 b=Bth+e4V4mYLVCn8hmSsS2OpX8LPl4QGcUh0u7n6Cpvfs66MNwEq7nQluTXB39AyZnX
 mW4FL0+5eU2xWYWy6WvCc7CRE/fcNwlq95FJ8DfnXBAlNu12lYYD5/F8dd72bQCYHK3g
 kMjBp6cweKn7dFE+3pBW+TN+YoAQB/sH+Pkn1pPZhApS5HywQJxZhJcfEaP8DazXGaYg
 m83Ly99R7XNGZlJtUW8Gx5uBC66BPUO/hDOonc7AWEHZtyBRf5lF8ueed8b9wih+ZopL
 DUBEWkGyUG9LPTS6wFmsmZHv3hrwDCQiz2EdC+lvMxPmfSGBlKoB9ZXkhsMUpD+3oE8K
 fQBw==
X-Gm-Message-State: AOJu0Yzi3LJOzmt5KLdWA0ETfgtWSyC1w/Qyw9QtHDEuXHwTULW1hHmu
 qKQeL9/j2SXstk97yX1ZZcaNEk8Q6duwWMfolAGweg==
X-Google-Smtp-Source: AGHT+IFzIkQ39jwvu7JISAUzGbWEdt/pjco5Vj6SRZtesz7bRd3fawXuDq0XPTz4OmCnGbdw+ndhBfgxcJm77FAx0Dw=
X-Received: by 2002:a17:907:ea3:b0:9dd:8b5b:7873 with SMTP id
 ho35-20020a1709070ea300b009dd8b5b7873mr7335664ejc.52.1699617049996; Fri, 10
 Nov 2023 03:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109200943.1.I1c2b8677c33d4dd9e8a0963acccebeb5c56118d2@changeid>
In-Reply-To: <20231109200943.1.I1c2b8677c33d4dd9e8a0963acccebeb5c56118d2@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 04:50:38 -0700
Message-ID: <CAPnjgZ2ODM5-A9r0afzWz05Rc5LvC4Bq0gE3gX4S1LhfmAyMcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] linux/time.h: Add Linux time conversion defines
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, prusovigor@gmail.com
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

On Thu, 9 Nov 2023 at 10:10, Igor Prusov <ivprusov@salutedevices.com> wrote:
>
> Currently there are no defines for time conversion in time.h, which
> leads to drivers declaring those locally or not using defines at all, so
> add them from Linux.
>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>
>  include/linux/time.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
