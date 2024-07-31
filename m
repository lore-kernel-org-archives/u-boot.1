Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C45EC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B5D788958;
	Wed, 31 Jul 2024 16:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iLBv/cxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E1CB889E3; Wed, 31 Jul 2024 16:38:50 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AAE88958
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a1d3e93cceso97301685a.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436727; x=1723041527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pkLh5oadxtR3ODYxhFgf6dwOUwbCNANESwF1Y0xyrsA=;
 b=iLBv/cxd1Ex/60i7jgjQ85XwZ1zZSrOkZW21e7MdGkA/18/ueerAOjNCo3LRmuCeAl
 gsRb4AL2aTWec2rQWwWhM0t1r+HuT4wTuV623QarBvn7tRddYiD66vAEP2zrIfRYs9R1
 xY0JoH39tZwojD0ha6gmjel73T5ft+ZWYUML0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436727; x=1723041527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pkLh5oadxtR3ODYxhFgf6dwOUwbCNANESwF1Y0xyrsA=;
 b=MD5XbWimn6afGO60PpYE3/fr0K447Kfnhgt5vMiqRdJvHKbOTsv6+jzMwgJEOz0TyC
 98pv0pqYEkEm/XWxnB91uWxmW/R7RYhdKg3oFPyTESDH+oe45+Ol5J7s0Pa+5yugnHYZ
 f5aivU0fuohFLhAnSdQxYCD0FOB8+IRjAFa+XCZYYptbv3PMOS8WYs3jckxyRgImguoz
 R7eRDyt7Q4JCDtz/hcFOYCHEidPJlnHOZ1Tx/xDoownNmSRLaqIapB4/l/2cYTUNjp92
 RiD6LANW2jHI7p9rreCn2o3WWX6FzdP3qqH3R3xSmawiplSoOkLX0+FN0IN8OSOO4Xe9
 xGeg==
X-Gm-Message-State: AOJu0YxEqfr38KMoeReFgRICUFAfxbVrGXP8aBOBUzI++6JabnfyU62r
 JreD5nKj1U/RvffsViUWpzYVDOVswvrrmEV2ktX9/0SKKXDLjQKH7yQmqX1u0L0wWkmPdI0GlS5
 mIUzt/e2OU1/2gPWnDYq4sHRrsQ5r5c9VvcOk
X-Google-Smtp-Source: AGHT+IEo28+rFouq+a7L0ruVGCsNrDv3YoWWHBWQeuiJhrgddtNAPNHXCYIvSCSY4st4Qthhujpp7JkWM8UoVzQ+ips=
X-Received: by 2002:ad4:5ce7:0:b0:6b5:684:2d5 with SMTP id
 6a1803df08f44-6bb77f5bd90mr113614136d6.4.1722436726878; 
 Wed, 31 Jul 2024 07:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240704074859.2956745-1-sjg@chromium.org>
 <20240731010407.0ff6a929@crub>
In-Reply-To: <20240731010407.0ff6a929@crub>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:35 -0600
Message-ID: <CAFLszTjr18h6oeFnNF6A5+D70LWLYXDDQLJ-5V6qO-pjW7qA9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] video: Improve syncing performance with cyclic
To: Anatolij Gustschin <agust@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Ondrej Jirman <megi@xff.cz>,
 Peter Robinson <pbrobinson@gmail.com>, Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>
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

Hi Anatolij,

On Tue, 30 Jul 2024 at 17:05, Anatolij Gustschin <agust@denx.de> wrote:
>
> Hi Simon,
>
> On Thu,  4 Jul 2024 08:48:54 +0100
> Simon Glass sjg@chromium.org wrote:
>
> > Now that U-Boot has a background-processing feature, it is possible to
> > reduce the amount of 'foreground' syncing of the display. At present
> > this happens quite often.
>
> This series breaks turris_1x_sdcard SPL build:
>
>  https://source.denx.de/u-boot/custodians/u-boot-video/-/jobs/878470#L646
>
> Should we enable CONFIG_SPL_CYCLIC for this board to fix this?

Oh, my passing run was from a month ago[1].

I think I need to change a Kconfig condition. Let me try that and resend.

Regards,
Simon

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/21437
