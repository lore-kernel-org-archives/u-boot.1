Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174C7C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 08:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735F181F0B;
	Mon, 24 Mar 2025 09:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xO4vGMuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621AD81F0D; Mon, 24 Mar 2025 09:26:07 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3064181EDD
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso27411575e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742804765; x=1743409565;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cw6+qYs+bmDrR7gXIZq0QUGtvQxHDPBi+awqwtTF9pk=;
 b=xO4vGMuwCGTSKxopJApNm8OF3QpTLWL62YyEvODlNXxFVliqO6oEjnq4womWSfll2i
 O84ixBOovJZuJ008/FKQX++xgQj8/jIfOKy/gF/NY0wuo+T0t3Z0bV87O5ei9vXlvbt0
 QW3u9L5Gl/qp//sgDKQ2mDxmRldk40CmO1p1ukfykoSh1DKxRvHH4M42P24c/prGn0BV
 RDvcbW5iCJCBMtOEVSP0HL4S3/vfT3DJFf62hcYs5+U9Y1d1i33UkoZ+3xltS7ZwpVaF
 H+7KztB1OMKNF2lynVYhwQBuP+v637h4XASFHhm3FrzVIWT883CiclNNzbSfbb/mCAaS
 6NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804765; x=1743409565;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cw6+qYs+bmDrR7gXIZq0QUGtvQxHDPBi+awqwtTF9pk=;
 b=B/Jlp9leRu5pwb5Hmpqn/K+NuK5qmv+q/PB7cjWZwhOUTo3bKOmKpCZfjCeJGVjIyd
 XMx3lMSJ8+1ZIuSuIgOW5ZwkT8DuRuVTNGHzooGhh51aUaXd3dqRFd9U+jky9PaW1/Wu
 buuo6UJrpw5OjYupWjCjv9QH8FwAa1Gi1lqAHqdZOWqEWGj0rDfhLgO8GcUlip9MhcEJ
 /WI5+FKQJBP3e3aRywHapTghPpc9IgxFvRF2ZBB2vD0j+foCW4DLIjNxeaTNfMxXOs3r
 Z9ZTIKQu1wWXFarQfw56DdQi18fjLIPtwkrcmcxJNiHoDU/8pCbB8wzfeLiNeSvVJ8mu
 7RqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+cfA+2zUD0YCIbjzi9c2DGdt1yEf4XFDFSW9gSF+4QJglUmfzkn5dvB2uMLsCEiNJrqLciaQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1/n9Sb6hne4NaAoKIZAmh51OtV4BZlJKthpiuTeyfxoOWLi7P
 XdzeHnUfHKZJwFDxXRhR9sP8CftsF9QKcLme6mMGkdxixyiPa/R0hMm+d0iZuiU=
X-Gm-Gg: ASbGncv6cGS7wOPdYPYEXii5+EUEybPasytuRs19FZgebbiypaY0kAjvbpWMBAtQDA7
 S2wQIja6xrPLdWk/iz2cVlCFHMAcpA0t4uK4l2uYqi9j/YYWrCjQnWKUwlTG6nSuOLgFs/sB2yO
 vg4Y/qGtvjIZGl/z71psUTgZ67aQjTfVHvadEps/2VkHraYrysw6Ni5nGKxvdwEbRTYjID2kSu1
 AWhGq3XUtC65wpFRTrtQC7BtDTG883FjUfGYmfF/G3cbTcK81lqm8vJyU9t6cSYucoFv7mXTBoW
 Cshw06TWnJNj+/KvBBas5ICM3qfBaA8WyWdYv6WwW4Q4rSzM2bdG8FM=
X-Google-Smtp-Source: AGHT+IHtllr6KLceg66oH1y+ooHC+wpt2iKigi++v0HPas+0sdITgrxdyY8z03eVL3KoYOLvbOqmnA==
X-Received: by 2002:a05:600c:568d:b0:43d:2230:303b with SMTP id
 5b1f17b1804b1-43d511012a1mr84021105e9.20.1742804764548; 
 Mon, 24 Mar 2025 01:26:04 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdab7asm164040185e9.29.2025.03.24.01.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:26:04 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
In-Reply-To: <20250324080315.GA6932@francesco-nb>
References: <20250319220805.219001-1-marex@denx.de>
 <87a59gdofd.fsf@baylibre.com> <20250324080315.GA6932@francesco-nb>
Date: Mon, 24 Mar 2025 09:26:03 +0100
Message-ID: <87pli6esx0.fsf@baylibre.com>
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

Hi Francesco,

On lun., mars 24, 2025 at 09:03, Francesco Dolcini <francesco@dolcini.it> wrote:

> Hello Mattijs, Marek
>
> On Thu, Mar 20, 2025 at 10:47:02AM +0100, Mattijs Korpershoek wrote:
>> On mer., mars 19, 2025 at 23:07, Marek Vasut <marex@denx.de> wrote:
>> 
>> > The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
>> > it crashes. This is a result of the previous hard-coded EP setup in
>> > drivers/usb/gadget/epautoconf.c which did special-case EP allocation
>> > for SPL builds, and which was since converted to this callback, but
>> > without the special-case EP allocation in SPL part.
>> >
>> > This reinstates the SPL part in an isolated manner, only for NXP iMX
>> > SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
>
> UUU can (and in our case is) used also on non-NXP i.MX platforms.
> What should we do?

Do reproduce the problem (UUU tool crashes) on those platforms with
recent U-Boot versions (v2024.10+) ?

>
> Francesco
