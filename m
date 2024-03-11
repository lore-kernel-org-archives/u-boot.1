Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6562C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA5487D3C;
	Mon, 11 Mar 2024 14:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mAkAW5T0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A1D87D50; Mon, 11 Mar 2024 14:08:17 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25E787D35
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5769aa0b3so497358b3a.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710162493; x=1710767293; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6ZdyZ1womQMM06Q6Xf/+g1VlkBrcWJJddBi+FL7ets=;
 b=mAkAW5T0+ZgsyxO4MkCmFOC1IpnFHXpMPT/3Rmm3OCdrmCaHQnwbEEw+xA1ebCEnQ6
 4iNa5h3BX77625zMm68mU34gsuEa7j1g4OJcE1dRQ8gIC253kYaW3Fm/JzZZL8oO0EWM
 Q2SgFTp9wtU2L7FytmeWRqFMPtaeIgoI1TP5AFWwqva3LF8uJfJZs0mJAgnJyzvZaW/N
 OtdQ7wut0MI+MS6pP/GNvYFxrkHEUM8LDZAaBtpL1F/vrZ08cNYVTGfQsTzV+TuOv7+d
 OGfUSUMPa80Jzd/XDMixxgX+vwkDI4GTi1ALRmCoBOTxgIZg8eemgJUozU35z2O1GART
 B8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710162493; x=1710767293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6ZdyZ1womQMM06Q6Xf/+g1VlkBrcWJJddBi+FL7ets=;
 b=B9LgnuwvkzsQdrR3WGXMW4iG7GYCyLHba+0qV8Rx0+nhBfLs23dFlyuuCEKqy3ZHCX
 q81ZKVWXHs2YhQ2Bkt9KtGgmoB8QG4rKGh9dWEm/mSlMJrZv88U25yMH1MJQPeWpq8Jt
 fm2t0uDrmMmOO0yEBiAEuhKzU9u8WJ4cXbtzF1FrQRG2pT5HJipZLMfNtiQY2Zz0BCiW
 b108aHH5MoYl68CnDIUlcfU/7U/aEkSRKX0/dtK158lGYqgjypT7IQt+pgg/4VpbiKz/
 gKr7eHOJ4Mn6VxiQTVBBITAKqwvgwuj9t9u1zbFMkxMK+F0L/ofvmrQjiA/fyUNk7qOv
 sYqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5e7+FsUAW9E8c94htzj2KeckXnboG6yVdabG4JDl187Q6wlaoHI7URLw8loMZ3T6rDg2MQu3jG1AdkyAdEJEY+TPnRA==
X-Gm-Message-State: AOJu0YzJqVWsQg0vh0vpe8I78nmEtF+ARo1vr3nRI3JCI8eoZimbZ74/
 843Z8DJt9/kQgvXDJOywCGAL+BbYD6p+Y6E7oulC0D8SQFYNB6N/Oy4rGT1CAnNrZfJeQVtQbIp
 RzUuuHTfNS5FBpXvd1+gVxeQ9/XRlBz0y
X-Google-Smtp-Source: AGHT+IHg9APpgafLkYZydxykaf9mvlyVJZQp7rV4UFqz/mvp13xmhyBf8BTAqjUq/pV2oVZGpD9gwLwnJgOBWkNR/24=
X-Received: by 2002:a05:6a20:9587:b0:1a1:67a6:511e with SMTP id
 iu7-20020a056a20958700b001a167a6511emr8979350pzb.2.1710162493397; Mon, 11 Mar
 2024 06:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
In-Reply-To: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 10:08:01 -0300
Message-ID: <CAOMZO5AFS=nC3g5_CQNHKPS8F-x93fwcWAHvyLnW=N_mN66mQw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] board: phytec_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 6, 2024 at 1:18=E2=80=AFPM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:
>
> PCL-070 supports 2GHz RAM-timings from pcb_rev 1 and newer. PCM-070
> supports 2GHz RAM-timings only from pcb_rev 3 and newer.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Applied all, thanks.
