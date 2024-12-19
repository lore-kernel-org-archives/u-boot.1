Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF81E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 03:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0698022B;
	Thu, 19 Dec 2024 04:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LA4d+9xB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF6280241; Thu, 19 Dec 2024 04:10:57 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF618021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 04:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-467a6ecaa54so2403931cf.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 19:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734577854; x=1735182654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vf+vnMgDpcib60wHj8bYZ5GsZfr8iHcVptR37I0THGA=;
 b=LA4d+9xBoH71OBl0QXbduS1XzN4fwpEH8uqNWhBNP+7oav/FtB8BCOsd23n+v+RK6a
 DyW499D4eYE/wwbSHN2BLWzlF1gh0g10i41+bcXtWms1ssOUmo9VCRLlkuzd81z2VBeQ
 lISCWt4OsEkHzbDA73ylHTkv/neDARgpkQKZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734577854; x=1735182654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vf+vnMgDpcib60wHj8bYZ5GsZfr8iHcVptR37I0THGA=;
 b=We15CQS48DVA17T6BkYl3SLL0iKcKavEUs21ItFlFxqKlEUF46iy/oybgLV9X03sV4
 /2M71dRxOD0wdiS2Lc3l0TDXf9ZiEh21nVfS/80CEJZITPOxSGpg7wOHAL3zLExvgP3U
 1W8lY+jfMBXpnAX17EYOnhcFmKIkhTwh5RTkkqZ5Wj7LuYY+MAEvTvDkYA4+rPA8Wlt2
 WSUZfgslHCZDpdYf8DlUQSHdD80AYv4aIp5Ogfw2w1QP1VH/ShTip90K4nNBm/XNsI3u
 qMNBt0TPHDlCyrRNB99yRsAjjuwdkbufMymG8tct/Oam4YhZih1zQDzZRczEaw7X6wkD
 DF6Q==
X-Gm-Message-State: AOJu0Yww2vfNcaTXaWb6bLINgEGm0f3+XjyfPe5/syLcQR33//3BXU6F
 RRdqWOEwKpTVOVaYWhER5jsAkfJgKXD98UjtM1TOwtQX+VLnb0HkO9bl8nrQ8d0=
X-Gm-Gg: ASbGncs5AyBVR3UKRlyRTK/nxwglSQcfcblilahUejkL2AyMqitGLB/Il6uWQ87lowT
 Zy87fLJ/MuageYapU2GfDqzJgXMjkVyf9Y60BfF8yPhvAs8QhWNv30BWlXVcZwcBy9FAQW9Gmcl
 aIOfU+zXLAFx9zc8ejlJlLzWiZCWFIcxobYGmeHY5cbLBoHrPlmJVxekOzk16i5pVN9TFCKrz/l
 KKpgyfk61vrXPoN7NUhB9iYEVOnnWKtgyRstOy7RM4Ij/DOcgajc2I=
X-Google-Smtp-Source: AGHT+IFbjBLnSm3VC5aNsXTYqcar/XF0PIOb6rJ28NCwIvuDIJgAJE4Ia60NP+AbaP1mqfqxv1M3LQ==
X-Received: by 2002:a05:622a:347:b0:463:1039:fc2c with SMTP id
 d75a77b69052e-46908e6f470mr91716971cf.37.1734577854638; 
 Wed, 18 Dec 2024 19:10:54 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64cb04sm1751541cf.8.2024.12.18.19.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:10:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hiago De Franco <hiagofranco@gmail.com>
Cc: u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
In-Reply-To: <20241203123302.298188-1-hiagofranco@gmail.com>
References: <20241203123302.298188-1-hiagofranco@gmail.com>
Subject: Re: [PATCH v2] verdin-am62: fix FASTBOOT_BUF_ADDR and
 FASTBOOT_BUF_SIZE
Message-Id: <173457785215.3566318.2598505748536409449.b4-ty@konsulko.com>
Date: Wed, 18 Dec 2024 21:10:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 03 Dec 2024 09:33:02 -0300, Hiago De Franco wrote:

> The current value of CONFIG_FASTBOOT_BUF_ADDR is incorrect for hardware
> with 512MB and 1GB of RAM. The RAM address ranges for these devices are:
> 
> - 512MB:
>   - Start: 0x80000000
>   - End:   0xA0000000
> - 1GB:
>   - Start: 0x80000000
>   - End:   0xC0000000
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


