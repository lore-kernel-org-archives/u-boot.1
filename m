Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC59CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 04:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73E7183979;
	Wed,  8 Oct 2025 06:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NnFYvwsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2718E839F3; Wed,  8 Oct 2025 06:22:10 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F74D838F8
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 06:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7a9c15464f7so2213948a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759897325; x=1760502125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53j14+0WYsUnbtcrq2i67RTA2I3+ssq0ddQg5pFxTz8=;
 b=NnFYvwsf45v90/hAPeVEnrr6+ST+Htty/U8AQjprMp/RnxY2X4lW4k9/4e0MqzJnL7
 d4GL0M6bF3Tw+6NPrxg8/cmSvEiLFUuGEDRlJskpnSgveLevsU47234g8zDyXdcDAhWR
 1BoOuzl1j9TY4OnOpNf0FQ4NDZrPrkDt+4Ca8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759897325; x=1760502125;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53j14+0WYsUnbtcrq2i67RTA2I3+ssq0ddQg5pFxTz8=;
 b=Dz8iD7HfxRPFa1CCJlmLmoPREmBMsYrN3nhDYOuI4qDC0Kmv3UDKH/q6Xso2Wu+h1b
 a7z74kOZiVz8vecTQjLnvy3I8yiFXbvNWrlNs+rLUfV7y2dcF4+Ev+Tm92OUBcGEghsZ
 WpNrxR4e9vn2HelYeXuNrLGuqfLYQSzmHmKviOTIANue++xoftLEzWJa5eNHl094x2sG
 AKPum9JWFmvnk/tDh7R1Y6RWwRYbrEAtUlPD5dnKQ6gKuwnYnOJVZm7GTDCvz/jcThA4
 TPPqyLJS6ODGvWUrgXEvtl7ccm/hDcA+JnkWH2OzhRQ/DDtwUG6WxyB3BrgqtWTRI/Rz
 aoig==
X-Gm-Message-State: AOJu0Yxx2+p60TqpdkC0V/shbgeBmBLOxZn6009sbhrVQJUKl3Qx1pmC
 t6LYimXrkFxxnSTwYLW1y+5zz9zhtH+sD0ddMPeMrBEwaKwWkggcxxY+k4xzEIrvLu5pPDL6tZH
 os1HBGtg=
X-Gm-Gg: ASbGncsBCnyCZmaDPkOEg7rwCxLGzH2SM/cJe6ToiV/jiMylXySuo36cErOjcNdARYV
 s64HD84UQMgOLx4Uhn6e8daxcquZr1wmlckLU4LlxOx/FNvERnS6/SaYLqOPFPbv8WOCBaxipdg
 FFXPKCvsRNMVzCBvsPfn5ZP1/yhe0B2kpMWNWVGkWJB35ylomn8CkG4PeOCdaXxALKuXb2fy9YI
 KH1vOzjY7Gqgob3rjVNwiLQo5PCg9CG1Gqajp0rVTU+UFliftED6ZxgkytWNyFpDwLWC3hH9xuh
 McQFqR9rSFVmncFZaJq+10EIQF6qXKHezeMKh4g5t+CmjXKgRIy0N0oWzVjJfJlt5ggIGbw/yba
 Jkr4HZNGGrNuRRFIhcGHbclJIon1opRMaPXnf/MY083/QEPwoE5qTd0Fo2x4JhAn2JuRPMiKqMm
 Vn5DZFXvUO
X-Google-Smtp-Source: AGHT+IGE99aTg3EexEKPHBhhkO/2SVql7qvoQE+97DmFmTBapXaa5Hyrf6sTbp7GR5iACWLQKRm/bQ==
X-Received: by 2002:a05:6830:621c:b0:746:dbc7:e3ee with SMTP id
 46e09a7af769-7c0df715858mr1125090a34.4.1759897325409; 
 Tue, 07 Oct 2025 21:22:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1bc7f424sm3818016eaf.17.2025.10.07.21.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 21:22:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maarten Brock <Maarten.Brock@sttls.nl>
Cc: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org, 
 Kory Maincent <kory.maincent@bootlin.com>, sjg@chromium.org
In-Reply-To: <DB6PR05MB45511C9367B93E1E788A543F8312A@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919001117.GA974973@bill-the-cat>
 <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919141058.GT124814@bill-the-cat>
 <DB6PR05MB4551C51511978A6DF29228188311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <DB6PR05MB45511C9367B93E1E788A543F8312A@DB6PR05MB4551.eurprd05.prod.outlook.com>
Subject: Re: [PATCH v2] board: ti: am335x: Do not call disabled PMIC functions
Message-Id: <175989732415.1794629.1852682825507307187.b4-ty@konsulko.com>
Date: Tue, 07 Oct 2025 22:22:04 -0600
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

On Mon, 22 Sep 2025 09:22:48 +0000, Maarten Brock wrote:

> When PMIC drivers are disabled their undefined functions cannot be called.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: ti: am335x: Do not call disabled PMIC functions
      commit: 0b9ff08515927e82306bacbe7f27bb74119113ff
-- 
Tom


