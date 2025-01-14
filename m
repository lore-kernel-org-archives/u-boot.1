Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7273EC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 21:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B9C8060C;
	Tue, 14 Jan 2025 22:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hwn2J7qv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0827806E8; Tue, 14 Jan 2025 22:29:13 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917A88022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 22:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b700c13edaso332512885a.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736890150; x=1737494950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TTQrIY0ojZwiVnvrPn9SJEoFyG3W4y35KluO3+BVOU=;
 b=hwn2J7qvQjNOOY5FZ7iWoBGEuOK62mgwtpJt/UsmoZ1doki1L83oJK4pohqsYaKYIF
 vZXoODdLbSuy9sPuLso8RG2aKF6Z3x0OHay0iruGgzMVtGTvepKol/bdzIo8l8SyDI22
 ueTp3aUvzh7IJJw51OgcrYmN30RWKrqVR8ORE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736890150; x=1737494950;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TTQrIY0ojZwiVnvrPn9SJEoFyG3W4y35KluO3+BVOU=;
 b=S9SiNNbLLoWIZJ2CVnl5DszmmjvrGZP+znjKFHsDKYKvXsER33+Jx4jr3r3sYu1mfh
 F1yC70G9rT2iev0SYkOrpaVICFmyPHuirjTCVxwBcPSlWHwDmH98R/fzBfDfNaMsqGTp
 MPgXc8Mlc7+gBdMxMrfsnnF5kFC/Rr7PXyQ9OfH5ZrO46cw9PTOvMV0SM1UnT/r42KQz
 jStv5+EYdWuGOqUpqCS08R35dJ1ZFQD/Z5y0thrKc41KnYPZJVN3YIRI45atngAr5DAh
 o2xmxgPUtywq2yw/rzHUvCcxW+iJRke1NhULhv2DMZHNmtKQkJOIa4upD1tDWmLRPw0j
 sn/Q==
X-Gm-Message-State: AOJu0Yy26wsMjAlSDtkokk8Nhp6QJDhnurFdlOTyWlhSwYVUyJQRfESq
 06wIihmWS1XlqwBb47s2H9QP2vYtpcNgE/Hv5XJecJIORUogsWcgAw2wmBkgs5o=
X-Gm-Gg: ASbGncvO/YZAZLePgPu0wOgs2a0/sTKOdI7XEXD+WmMrhavvNveTH58dvlBOGGbrqMm
 3ZlUd2eug+Uq8Pk4L7wcHim6sjH3mOCPXbB65qgRAk2P9affLFqbi8jBtqP9/pEo+Lao4IUrTwM
 v57NbPp8uEcdbf7oF1IDMCyaeceiXdFIZDmgC1wpOUGTnPZlGII90nW7rZzV5dNf8zPziGVq3+k
 E4f44keZl8T37SWgshcKjLDBN1Gdx6Hq2LEy7A2POZY37OolXQc
X-Google-Smtp-Source: AGHT+IFFx3nlxRI/QRrZcZzRjQAwLQPYUDAEh+IWYwT/yl0bbFqISFioCSrHMIxxs0zkdX3PgDAP9A==
X-Received: by 2002:a05:620a:2416:b0:7b6:e697:2090 with SMTP id
 af79cd13be357-7bcd96ed1d2mr3769522085a.2.1736890150499; 
 Tue, 14 Jan 2025 13:29:10 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce324826esm642891285a.41.2025.01.14.13.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 13:29:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
References: <20241206225438.13866-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v3 00/10] SMBIOS improvements
Message-Id: <173689014760.93138.7098054700427646114.b4-ty@konsulko.com>
Date: Tue, 14 Jan 2025 15:29:07 -0600
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

On Fri, 06 Dec 2024 14:54:17 -0800, Raymond Mao wrote:

> Motivations for changes:
> Current SMBIOS library and command-line tool is not fully matching with
> the requirements:
> 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> 2. Only a few platforms support SMBIOS node from the device tree.
> 3. Values of some fields are hardcoded in the library other than fetching
>    from the device hardware.
> 4. Embedded data with dynamic length is not supported (E.g. Contained
>    Object Handles in Type #2 and Contained Elements in Type #3)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


