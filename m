Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F48E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 14:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E76C80083;
	Sun, 15 Dec 2024 15:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="huRTxkSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA67800B6; Sun, 15 Dec 2024 15:03:58 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410C080040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 15:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so345758285a.1
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734271435; x=1734876235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZB3T7eVhiDTCbOBPPg9C08dF1b77YrF3Ecst7uIkaOU=;
 b=huRTxkSls/bcRqQkq2Sci6Yo58DO5fCcSaW5UbyLlmWRkF7QweMWjkgz7fXRSZ/kmG
 I6+xXdqsl5So+2e8IQa8FjPPyy1JbL5Tq/n9hb290zX+1HtL4p6YawC4VlhPXwURRuhj
 0w5UBSVnkQo/H54zP+k7hRub6bsODM1lgjzDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734271435; x=1734876235;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZB3T7eVhiDTCbOBPPg9C08dF1b77YrF3Ecst7uIkaOU=;
 b=By1Hx4iikmAv2RkQaYnFBI7tD0Dh02eCjIZu5PeC0clW9blEiHT5PlViJeS4sfIbJS
 0r33i12pzyJqcQjSDbbptr6KsfgGIB65ahHfPKkDlBYDEVV8cUulmGAECx1/LLGSYznv
 /5/v8okQQEVN/r7eVjMRU5fSRzZV72Ajdk1egSvd+MWra6Dv031tYqPTho7E/h66L/YB
 A9u+lbKuU6IbLlm70QEtk6gu0ymUp8SCsuJHrmsIJWhmK2RjDYXzOgh3kB4P+ZMl5e2B
 xepou64UImp5coo1FLpqbYDBD3/cdfwEMaPr0GdejUy087k3c4TJw1SukVdvLrdrH52K
 /66Q==
X-Gm-Message-State: AOJu0Yyy+aSrL9nw7DYZzq2Fr2QMEp/h3+NK128pwJZLGbvpDU3wIo5Y
 dEiQlwaC9Vy32kf7YxDr7W9CyEzGe2riiDtbq8f4kpkJz8vSbxxTPxzIn/Wvzo9FqnDI46SlBmI
 I
X-Gm-Gg: ASbGncukc3yr38OpnI5yFIH8heMn3Lo2HXeY3Y6iTypDUjcjghrvFnG/fvJT4q0lt8K
 5hiPEAfAjfrLIBuWzu1MW/YLzswz9SFaAVqATXjwnodRFYHBdLr4Di/pdqjY0Nx8XBZYL1VMINO
 TscbUciVnCJ4gGdO8IZQ+KQ9NksbuOmxeeefKL46a9Dvjd2R0wszlBZWwSSAm0ysra1O5xSLJyL
 y4AkkxhTC7Y25l3tSyeBEnJK+P4SJV4SRl3dzFOxJjsnhhJ4lgiZJE=
X-Google-Smtp-Source: AGHT+IG7ZgaPeiDz7FQUZZCTbKLcuWs2Ht40njyyDpNyZBlmateZk26INaFgdtlp714zZr+mfE1e2w==
X-Received: by 2002:a05:620a:4549:b0:7b6:dd9c:fabe with SMTP id
 af79cd13be357-7b6fbee8879mr1302674485a.19.1734271435191; 
 Sun, 15 Dec 2024 06:03:55 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bd82asm139942785a.82.2024.12.15.06.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 06:03:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, marex@denx.de, jonas@kwiboo.se, 
 kever.yang@rock-chips.com, william.zhang@broadcom.com, a-limaye@ti.com, 
 u-kumar1@ti.com, vaishnav.a@ti.com, sumit.garg@linaro.org, 
 quentin.schulz@cherry.de, p-mantena@ti.com, ilias.apalodimas@linaro.org, 
 afd@ti.com, nm@ti.com, avromanov@salutedevices.com, 
 michael@amarulasolutions.com, Anurag Dutta <a-dutta@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241129113136.383277-1-a-dutta@ti.com>
References: <20241129113136.383277-1-a-dutta@ti.com>
Subject: Re: [PATCH 0/8] Hyperflash Boot fixes for J7200/J721E
Message-Id: <173427143246.1931614.18199665792925073915.b4-ty@konsulko.com>
Date: Sun, 15 Dec 2024 08:03:52 -0600
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

On Fri, 29 Nov 2024 17:01:28 +0530, Anurag Dutta wrote:

> In u-boot, hbmc is broken and has been removed from j7200
> configs. This series re-enables the hbmc driver and introduces a series
> of hyperflash boot fixes. At present, in u-boot, the parent device (fss)
> gets registered as a syscon device. This is done because the MMIO
> mux driver in u-boot did not support the mux functionality when the
> parent device is not a syscon. In this series, we make relevant changes
> in the hbmc driver as well as dts' so that we can use the reg-mux driver for
> selecting the appropriate state of the mux.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


