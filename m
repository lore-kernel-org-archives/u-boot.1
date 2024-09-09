Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4B5ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 13:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F1088DC6;
	Mon,  9 Sep 2024 15:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NgRXsuiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A889388D83; Mon,  9 Sep 2024 15:37:51 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313BC88DC6
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 15:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-718e285544fso1452556b3a.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725889066; x=1726493866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bKTfB+KRMtJiEKt1TbpZFagGrTt37Ehia305pP5y/pY=;
 b=NgRXsuiVpaa2B40Jtwnz3if/oRIPY5gmn9Pv0jNfAJhLSQlIE7Q/ml0XRyAGPbhwmt
 4YKCHyR5DEkIT+BBacCaO8kIAPpNiu9ZYFlsG3EMpMoz7LJHXdzx834/+6jT9A5ZXcnL
 jDfLAKKFPqr0d/YQ6GaR2g7Ps6yf4pHkQr/OijDfMCoeDczfTlNck2OyhvllIn+v9/0L
 u0nYBOxhHpji3giMj5CUWlmmeImsDXKD46tD/l0NgS1eUqmI8x9lZ6MphMVFVLSkozJb
 31fl85+fXg9Ha6+85ED0d/GLK2/puh4/aJ+el/bmKn4BB/BX1n780XuklyB8/xliz2DX
 RRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889066; x=1726493866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKTfB+KRMtJiEKt1TbpZFagGrTt37Ehia305pP5y/pY=;
 b=e+FzGm5LSCvdfMeqmqQbVHJ09BpSiia+6uG2KWkDh4OTjKmSllJqr6y+I3n6uz6e0k
 TLPb+cfBVE8ly7b322WYNr5GOvJgFpeyl1c9tgpGrR+A3Led/mXEdUMhCgk0WXxHblWs
 6Z9FmxUSu3tRmOpDwtukrcTe6HskWv4HGwc5Wvrq9Jk0pClbRbBXVA/Lvt1sNJUJFY0a
 WQNbphtfmGNbOWhEEESX5tUC+1YCSdbRSDjiMe/dPy7d1qrSIZbb9YFhosomYj0n3ryI
 s9N0YUZ+TKu65ftwlmjFFHX80K4Scfgn0xfD9HuJ/QwpfF/bXxAgDB6PP9VfvKcMe05+
 01og==
X-Gm-Message-State: AOJu0YzL7m93KTEsi0Z12nvm/e4ZEOupWIRWkH0v8phYJGF1WjG6+7OJ
 kBAseav0fy+P/jUtbXFqSc5CqeQB7rviXuxus8lvtZq9t8bRXQjVxZDfECcu1+yMObHGkYvbZcj
 whI/8EYq3H/4A425pI7q4JLHc7eINJPETtb1PYQ==
X-Google-Smtp-Source: AGHT+IGaD/A2SjeyCuWIXxrUHNTpx+6WYTAtRzPQuaQuJr2monLTAAJKAQRPou6pAL22B7rEb3uThWeSWpmo4BH+Qew=
X-Received: by 2002:a05:6a21:3994:b0:1cf:47ef:190f with SMTP id
 adf61e73a8af0-1cf47ef1af2mr1784288637.1.1725889066596; Mon, 09 Sep 2024
 06:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <b692118e-7a53-438d-afa6-7109d4d61167@linaro.org>
In-Reply-To: <b692118e-7a53-438d-afa6-7109d4d61167@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 9 Sep 2024 09:37:36 -0400
Message-ID: <CAEfUkULS3VG+jccC+XkmkAb2QPJ2-VRZmmQ4X+D9MuWsPAeyZg@mail.gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>, 
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Caleb,

On Mon, 19 Aug 2024 at 07:56, Caleb Connolly <caleb.connolly@linaro.org>
wrote:

> Hi Raymond,
>
> I haven't managed to root cause it yet, but this series seems to make
> the RB3 Gen 2 Qualcomm board hang during relocation.
>
> How early post-relocation does any code here get called?
>
> Does it have permission to access MIDR_EL1, MPIDR_EL1 or CLIDR_EL1?
I don't have a Qualcomm board in hand but can you try if the hang still
appears if we comment out the reg access lines in patch #5 and #8?
I guess just about 3 lines.

[snip]

Regards,
Raymond
