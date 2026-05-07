Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E9CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 13:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D0B84AA9;
	Thu,  7 May 2026 15:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Md7J7+Bi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D784784A75; Thu,  7 May 2026 15:27:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B59384ACD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 15:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so113359066b.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 06:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778160447; cv=none;
 d=google.com; s=arc-20240605;
 b=VHvfyXJIA02niVDYE0ZHu9KWaJ5QmPLN0CUb8+fBcBbLuqhoulMigrliWbGVUFqlCz
 HWxcs5Ejx0zxrHoyqjPuXHI06TyRNY8a9RKdamusyTUv3Y4i2yiN/TxXCQTOUq9o+Az6
 gSM03jN+mW+RyLOJd68l3eK0LnIkRjP6EL7qmK4zhCOLJaoGetM5obMKfgI6HscB3f04
 B7Zp0qoZaAMwKzPWz43BlX6RF+hvlmDFA6I55ZOlxiFAA1nv7RSFF7mwTQGWAyfs5bmg
 Ue/rxlGeN9AjL2bMcIsfFV8UMFAY1mC3sjSCnnvEWNnXasXkmsI1pOaA/JN320l7rEoK
 QkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=siaVQD4y//vTnu45zXJcujPoK8gxAGbzytrzf8IbFDQ=;
 fh=DgLR+5PxGH5qYwxlPhnszHa5mKZEkQO3XKmANW/HplE=;
 b=VKh6EnFU6y235w7ZnTswOkkmV61WsWw6aai4YZA6xRT1F29nKHSafgiVwzB2sHt5kT
 WXV1r/04UxncoflOdNVi7C4vG0ICfC4lWOBcE6/zeK4wJ23BkyvU6eluNJKng6iRJb0g
 WfE9j2FeZHRSswHp5NuTehaZyvu8FM2jgdj/syd3yV2laBBlrOimaqNk4zX7HP6LYotf
 pqhhRior40A+ycmBdHU+APfsGiE2oK+VKynbTNXNiAWJWPtmGHSYmxdKs9ka2dSjd5Nh
 KvGbaOoeuEwuw4LktNBAr0yYgm7bHLZeY3UbDNg97hVrvIwJDNGQTUiNwv8fNLkHZjHn
 1KQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778160447; x=1778765247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=siaVQD4y//vTnu45zXJcujPoK8gxAGbzytrzf8IbFDQ=;
 b=Md7J7+BiSugxvWs0ASAmQ53brIK/sm/ZaZs3YWRAOmSzybibaPvfiHTufpyyD2xA8v
 F8T5NhrCD8c5P33BWj3yz3A9nhrYA5xZvuj5gqUSi+0oXd5/v3FuuhQ7pPOnXBhvaF12
 mQij5pv84dWMGWqIj2P/io1DGH20C6caqwbEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160447; x=1778765247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=siaVQD4y//vTnu45zXJcujPoK8gxAGbzytrzf8IbFDQ=;
 b=apHotJm7iLSFtt2+GJFlgcf+czYCkdkQVQmaDNC7eaKe20tpvEOcp97hiOyOkeN4FP
 3H4ZyMwuNa3pjUG5YWhcLQ/oM5gzuJzFBPSNICTcuNyVe8msueGrNlIYJ+271xKStfIv
 IP1+H5KcA67bhp2703EaM4gmb1WiI1wY5Fla5WHVC7BeJppwsf6mbcj0UvU5BQCP2C0Y
 DFeYh8SN4ziCB13MJII2DaXmM0LUlD2F3cZN3jdezPuibrN773+nAMuJbtRj4X99+srh
 +w8Np8yzQ7ma0ev9kfrmJV4/tlfT5lWxCXL/lh8alXEUC+erVr7hxDzb5AJSu176PySf
 OVoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pWjdCaleJ19ZSwa1/oQmDN7baWlUtTQZSGtI27nkrnE4YeYkC8ks7Oa3XCe4vGqd8ES+hDRA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxni0/LN1HSE6HHhH2ltJgAnxOr06g4HrxuaLgvitjOarbphC7G
 Hlg/CJHHzDHxcmYm3BS7YkX0j6Ov+8Ge5Fle7YoFbSlTalIo4fwkMyPrqdWJfXBJT2DzVZd7e39
 wdzafjH1ndgnNM5o8Z75jOpb5k+TiGHwRlq8dWlBy
X-Gm-Gg: AeBDiev8TadHQDbZ7kfFnwqzrYDsVipFkm+Q78HqqgUR44vZMyFi+piyZD853XsfcQn
 PnwxdjNGBo/03BwGHZDEYGjEn8n6QYOXycCUCEXUXkykcS46DywXn57qGN+oeyUHZzH1EfhHHyk
 FMSinn/jW/DR5NGkkP9kroM8HVPRLizmj3L2iOEarV/EV8kL1lA2MhirRk9a2sST5/ZNm7oxH4P
 qu9jhBsSIQ7kgxKD8kLSASs/9TbPO5dRXSHYOGD5p5w2bYtLH5apu5PtuTyqOTH29fuO1Vd1jQr
 Hi/cryGtatYV03tkLINMGb02GmCWm6qAM8LtZg==
X-Received: by 2002:a17:907:a806:b0:bc6:14b3:e835 with SMTP id
 a640c23a62f3a-bc614b3f286mr407791466b.32.1778160446364; Thu, 07 May 2026
 06:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260505074948.2603870-1-daniel@thingy.jp>
 <20260505074948.2603870-3-daniel@thingy.jp>
In-Reply-To: <20260505074948.2603870-3-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 07:27:11 -0600
X-Gm-Features: AVHnY4J7YUuNv7vGDQGrncuQD3t237oZwt7QflpIgv9EtjAZcd6IQl-7lqultxE
Message-ID: <CAFLszThdm3xZUmH7WY4-GL5m0gYR9yhESDuh0CCDraR9=R5WWg@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] rtc: goldfish: Use __raw_readl() and __raw_writel()
To: daniel@thingy.jp
Cc: trini@konsulko.com, visitorckw@gmail.com, angelo@kernel-space.org, 
 bmeng.cn@gmail.com, sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-05-05T07:49:33, Daniel Palmer <daniel@thingy.jp> wrote:
> rtc: goldfish: Use __raw_readl() and __raw_writel()
>
> In QEMU, the Goldfish RTC is explicitly instantiated as a big-endian
> device on the m68k virt machine (via the 'big-endian=true' property).
> Currently, this driver uses ioread32() and iowrite32(), which works
> by luck because the underlying readl() and writel() are currently
> broken on m68k.
>
> Use __raw_readl() and __raw_writel() instead to avoid breaking this
> driver when the endianness of readl() and writel() is fixed.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@thingy.jp>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> drivers/rtc/goldfish_rtc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
