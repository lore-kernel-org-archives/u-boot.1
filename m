Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565A9D1CDC2
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893A088EC9;
	Tue, 22 Oct 2024 11:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ilVTrhZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B2688F31; Tue, 22 Oct 2024 11:10:36 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBB988EC9
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so52102585e9.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729588232; x=1730193032;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hh3HjRx1le/37rgatrcb3p4FaFzUpMfJsqVFOM2/dts=;
 b=ilVTrhZx/zwFxkJ81gKzzGzyZ3fNI/Tm8QjIKDWrwgCcNGAi/cd22iLz9+FHFGkTcp
 5QrAKSyagJkhg+o7V1p4kami0JbxMgdfZu3FS26wRFnuTAv2h2tVAeltIIifRVD49ESd
 7rL5+bwmwpD9OPmc7UgwvBpdbH4/o48MbTwV1DylKgn1Cer0FwF27aAXOgRfy0vRkjum
 GvCWuuVUFz9/H6OytyzDhAjSThNyKPqGTzBEQDGdB2Ovq/zoP/XSCAdzhI6ajC83HtL0
 sV7E/Hw71dKYqkn59k+xAeQ7orYmGkakCE7qOaP+FR8G/lhtd0a97V8kYBXMZpM5mYme
 u1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729588232; x=1730193032;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hh3HjRx1le/37rgatrcb3p4FaFzUpMfJsqVFOM2/dts=;
 b=O1WKESNCtj/PnLlqtHYgrmbx24du8hzXkc4I8WMNkTt9xInsVGBHePu74Vxr7X4EDZ
 9F6a14j5robA/8KwjrqjrtrQWw6305TfbrqlYDE7S67waXyofUrPROeIjQT67VW2xQEj
 MsbwUMmgpKnPoLc+vEfuMISv2oV3LgYvyhqLkeNiwuH56B28Pem2NWi8zJBuMEzg8NG4
 lDeL/SCltsirUq2VSznXfPmHLdraNqFCADFEl1B30PLulOZ2Qt/V2mI8rEVnk/zhDWmf
 Ijaph676DkbnC3oUPnyLsylQmitAXDyAo/v9hvuX3/l2/BTZ73pwekOkO90jaWCv79t7
 2Urg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvlThgCrj1NotejIEzhu9wy8B+Ilc57IXZc1Vh960GHRHXbSNniJF6tDYK8kTL3fy9TMxHBZw=@lists.denx.de
X-Gm-Message-State: AOJu0YwkKXlzE6sUgpgh3ej0o+pSSQakEquhgM9SFFzrvp7tQ2JKXW9/
 MB1lf8d+Ai26X99YWyQE5I3TDmLiyJP+JS5dbrEbpKSriF4IOS66FXR78nN25Qw=
X-Google-Smtp-Source: AGHT+IFXitAA8QpJ4As+ASkuu1KXZhj9CXP1uy5wHl2Zv0VaL8uH0LTpsnB+tueYz8AKs1dNWgLKyQ==
X-Received: by 2002:a05:600c:4f11:b0:431:5c17:d575 with SMTP id
 5b1f17b1804b1-4317ca9b510mr15895435e9.11.1729588231968; 
 Tue, 22 Oct 2024 02:10:31 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2b46sm81686185e9.36.2024.10.22.02.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 02:10:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Lukasz
 Majewski <lukma@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/3] dwc3: gadget: properly fix cache operations
In-Reply-To: <172955350574.3031532.4179642258271087474.b4-ty@konsulko.com>
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
 <172955350574.3031532.4179642258271087474.b4-ty@konsulko.com>
Date: Tue, 22 Oct 2024 11:10:27 +0200
Message-ID: <87h694wlj0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

On lun., oct. 21, 2024 at 17:31, Tom Rini <trini@konsulko.com> wrote:

> On Fri, 11 Oct 2024 16:38:23 +0200, Neil Armstrong wrote:
>
>> We experience huge problems with cache handling on Qualcomm
>> systems, and it appears the dcache handling in the DWC3 gadget
>> code is quite wrong and causes operational issues.
>> 
>> This serie fixes the dcache operations on unaligned data,
>> and properly invalidate buffers when reading back data from
>> hardware.
>> 
>> [...]
>
> Applied to u-boot/master, thanks!

I think you already pulled this via:

https://patchwork.ozlabs.org/project/uboot/patch/87iktr2l9t.fsf@baylibre.com/

>
> -- 
> Tom
