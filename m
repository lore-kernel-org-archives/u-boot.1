Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780C1C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FA58758F;
	Thu, 30 Nov 2023 03:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EfsFSdOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE94875CC; Thu, 30 Nov 2023 03:45:52 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 978C287076
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a0064353af8so312064566b.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312350; x=1701917150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SAsM3ek5fpEHQ7zFUqd8MkfDJ0vPeQQN2cSohVIgsQY=;
 b=EfsFSdOS9HP3LHA0bia0NAFqMGXwYjdxIeWg7zxIW3ZUIS0Tbty5ZINNBSN7dK0mDO
 4xnVYOGKhCpF2VLy9RL5LRRARkjR9laRTSFOkHRNhVvXd+WoPuyWunewB9LoOSWJSdQD
 p7v02fIHGDYQh7LQoWDPVLqErbVqessaOYQTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312350; x=1701917150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SAsM3ek5fpEHQ7zFUqd8MkfDJ0vPeQQN2cSohVIgsQY=;
 b=PRFutCSUQmgZRgB1Za7vJplIPAGiaG38nMjcAqggIaNvfdjY0YLPpxxsGjxrxBg56b
 E5+lGUn24KDNKPBtSWbykomQhENoUwGiIuYCVMA9xXkXVn8giEmtlYxKaqBj0kGxMTbM
 7vet2KgWVNAlb5fyETKuqImQMRwN9zz1oXWzWeEhUea5Jui3EeSslZgnkfCKGcOJTmc+
 DVNdgmlJ3fgybxRNuU8nRLeXBVSSH3Z30NL/5MVRKyO+pXlVi73OUOP6ytjaYeWVKok6
 GGlYoUIbOBXff0auVaiNOaPxS29mAwQYIoExnzDnACemiB4R6SsO0xrkGR8XlNWpVz6y
 ihYw==
X-Gm-Message-State: AOJu0YxgNHf4tPt4eo0BDEn7ffehnXX+Vn6bbW2sbHV6PV5XT0UMhRQK
 n3930KNekCNG6WpT0H4QHGJSypsQXXt2Q3TV7pPmgg==
X-Google-Smtp-Source: AGHT+IGDlwXRkSGqkwpS14qzedsnrUjbL23zl+OH4OTp0V3C1RWhdOH1UVgSLAklzssp9VmM6qiqXKwOMFrVik4YIoA=
X-Received: by 2002:a17:906:e97:b0:9ee:e5f1:fef2 with SMTP id
 p23-20020a1709060e9700b009eee5f1fef2mr20733399ejf.11.1701312349890; Wed, 29
 Nov 2023 18:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-20-maxim.uvarov@linaro.org>
In-Reply-To: <20231127125726.3735-20-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:29 -0700
Message-ID: <CAPnjgZ1PxrSu=R9g+Yn=dFPAsftvTJOb3MsR4y8bqL+P9zV4Yw@mail.gmail.com>
Subject: Re: [PATHv11 19/43] sandbox: eth-raw-os: successful return code is 0
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
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

On Mon, 27 Nov 2023 at 06:05, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> all network drivers return 0 on the successful
> transmission.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  arch/sandbox/cpu/eth-raw-os.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
