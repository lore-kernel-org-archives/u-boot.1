Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB1ED339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516DF89100;
	Mon, 28 Oct 2024 18:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fsyGGSGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C70EE89100; Mon, 28 Oct 2024 18:04:53 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C552389100
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a99f629a7aaso724573166b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135090; x=1730739890; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kfI43omiJ8cA4sJOpq1TgON7314CQ1hlm/xF0K2m4ow=;
 b=fsyGGSGq7rhb9ZDLcEqPQ7BlUkLjVcGGpqaJ6Usaa0EUl1zdPlWj035iRJymb6KJT1
 cq9VG09hWbpyKlZoBlw4E3onmp13nU61INBVNgScwUplA46N4oGHBq+uDAmEbxMTBMZT
 beb6mbuD6mR5QqV4ZinzQaDklaqx2GWDW1600=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135090; x=1730739890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kfI43omiJ8cA4sJOpq1TgON7314CQ1hlm/xF0K2m4ow=;
 b=Yq2aG++HSaHj9UUL2zdQ7DgLaflDmLdGPYSOsZW90IKVAeuLxH0XQxf+qmzSf7/1h/
 ubDhakrnoqObvcmnsTBqUlYxhdGYnztRbSRSa8zt8QzsWcWIvcNO94p8yAJ1eZWlGjIa
 fq81W50QCQk0CIR9iwQdORfpFNfESv0QgjgUaLzTei2eRM5q6Cv3mknYIIyigp3zv55R
 J2k+Qeqz3h8YrJozkxxI0Ezr8WYxjlswpfcIl7Z3agYzbi6oY9zAhCwertCcJMPanD1P
 MUNn9SgOOHZrhzwFMb6DgZ0RpjtrfBLCIqWRu02CgweyeiSsSdh7GSfa6w5E+7XQ01Po
 fI6g==
X-Gm-Message-State: AOJu0Yz6J53jlZzDbbqzAjaDqUCljNq4YVsto7k86Xoc8vndopoRur2l
 2VNMKlRr7C/+xpy97VUtccxmL8qthmWo24qCHxS4PNqK2zaM3Fi0fZX3dOiwZ4rcTk3y+Nz3ero
 JU8pejzLNFuFP5i/Tp8ZREYzwpAHWlYqB2zD3
X-Google-Smtp-Source: AGHT+IE6agZLlrXlE5cUtchN6nB9O3HaWfUoPxuo2dlS+z8UqnNW6i4XB3IO57D0JF4Rj6Ocm+eu42pmWmwK+ap9pgo=
X-Received: by 2002:a17:907:ea3:b0:a99:f9fa:5c01 with SMTP id
 a640c23a62f3a-a9e22b3b53amr26640166b.32.1730135090307; Mon, 28 Oct 2024
 10:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-6-raymond.mao@linaro.org>
In-Reply-To: <20241022200543.116343-6-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:04:34 +0100
Message-ID: <CAFLszTjPh34RrHQjnD5mFk-fG4GGHAZjsTmskrTqPHdaQrvfZQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] armv8: Add arch-specific sysinfo platform driver
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Michal Simek <michal.simek@amd.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexander Gendin <agendin@matrox.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
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

Hi Raymond,

On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add sysinfo platform driver for all armv8 platforms to retrieve
> hardware information on processor and cache.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Combine with #8(v1) patch.
> - Remove the handling of the common strings and values.
>
>  arch/arm/cpu/armv8/Makefile  |   2 +
>  arch/arm/cpu/armv8/sysinfo.c | 292 +++++++++++++++++++++++++++++++++++
>  2 files changed, 294 insertions(+)
>  create mode 100644 arch/arm/cpu/armv8/sysinfo.c

Reviewed-by: Simon Glass <sjg@chromium.org>

I have to wonder who wants this information. Doesn't Linux know it already,
based on the compatible string?

Regards,
Simon
