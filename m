Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB6ED339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663BA8912B;
	Mon, 28 Oct 2024 18:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f5EzuHEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8568914F; Mon, 28 Oct 2024 18:04:34 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A5A8911E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso637842566b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730135072; x=1730739872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cIFP8V1UJ3DTpilY3klWtFjxEgJwV9mkIc3VRlPW4uM=;
 b=f5EzuHEVXotIwFCpGnUDC8wr7dOY8liEsTwAaZ0Pf8PItvHWbXOScF9ypOuRTXvCM/
 jZ8EpaMCEX/ejkMdRt2G2BEfmAzgSfrHlsnRK5n7PCxhGID1lNEG9PeB7BB1mz06d7bl
 WDeVkb5Qd1WPuOntEcx8YNCi6Unw76IMWupNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730135072; x=1730739872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cIFP8V1UJ3DTpilY3klWtFjxEgJwV9mkIc3VRlPW4uM=;
 b=edCT6gdKHF3XGSGWC9eiG1Nksr0axgMXc7N/e/C/Nyq0Dyghq3O4zcZPHpllbPR9r2
 DPKoMMbgROFvZ0nfINuVIVoaAlwQPxZhHP2z/er5ZoCRUhb2caZ20vGH+sOoBdSsWvF+
 EuYRF0HNazr4BkOXnaJlQYuMwVR770qFatlxfqsvHPUKSXIjCnwSNLuiRYqjZzi3vGZs
 1t1z780faIVrP1Vo7NVrzLcPsM9Ts7me+X/oKYwjueSAm8MuU/rVidfADS3AuB2puIqj
 csQ74C6+qnPPobFrQHfF524vpKLWGcpJMebx5We+zGFXYLciTBW1QEJhJhmdGIVft8CP
 ptFg==
X-Gm-Message-State: AOJu0YyyrgI//OHMPeaPqaUXjnm+/X934JOEvYIk22P1VwpALoPevRTx
 63px6GZpzLY/nNiF1uuXRdJ3XqDp7hZxXG3d5zAnCoWjXbp5W1Tu0K1tb3hXcq5c9YfGwwF81YX
 4csjMsAjLkQSMYW38d8I2QzZ/61lI9SSz5HCv
X-Google-Smtp-Source: AGHT+IG8q/bPorkr0YOuJeQ7FoZavncqeqUhOxWV2SnEQGnqbh3GlsJ/7G3Q25aKKaYlhSU/8p3L6dZSe0ocD7zpbNY=
X-Received: by 2002:a17:907:7215:b0:a9a:8028:45d8 with SMTP id
 a640c23a62f3a-a9de5d6f953mr896844466b.7.1730135071732; Mon, 28 Oct 2024
 10:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-3-raymond.mao@linaro.org>
In-Reply-To: <20241022200543.116343-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:04:19 +0100
Message-ID: <CAFLszTifHJsJjzBFUQ4vFYmCMt3UfNEoYBemTSXYD0wLzWq55g@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] sysinfo: Add sysinfo API for accessing data area
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Jonas Karlman <jonas@kwiboo.se>, Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
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

On Tue, 22 Oct 2024 at 22:06, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add interface for sysinfo to access a data area from the platform.
> This is useful to save/read a memory region of platform-specific
> data.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  drivers/sysinfo/sysinfo-uclass.c | 20 ++++++++++++++++++++
>  include/sysinfo.h                | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)

Please update the test for this.

Regards,
Simon
