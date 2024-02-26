Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76423C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 09:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BBD87E98;
	Mon, 26 Feb 2024 10:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fCkZWQE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E16D587E9B; Mon, 26 Feb 2024 10:23:42 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D8D87E47
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 10:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-47064e95199so340790137.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 01:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708939417; x=1709544217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=myU7kBnfAvxnR1VY7ZGtrz1Rmsl8TjZp+rcGH1kzac4=;
 b=fCkZWQE5VK7E7ZWwtuP69SjTWbVs1XH1D+5S3DY9MXAZjaR3jx4cKNFv4KIrId1JOs
 HbBC4FJu/yVYDXmavkEWxxchbfq7WKfyA7jGFHQhtIAyWqWE8CDaMYuai4SzeUoUmu+M
 A6BCY8ETZimDzbjpNh/sYAZTh2VAssdYSL/pCrz20VNhq6ZYZRPMvpbzESZs/15/SmcK
 qbPCIiOCIjEbovnmZ7TIPGFjtFLgHoijc2jXMFDQgza/FfRwOlTYxlk/qhGQ6squEKYA
 f417iLFso9prx4nrfWBCEg9r0ahM/bKw/OvbluSDL6mdoKqv0YvMrAjrmrn/jmWrKVkZ
 opXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708939417; x=1709544217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=myU7kBnfAvxnR1VY7ZGtrz1Rmsl8TjZp+rcGH1kzac4=;
 b=TJA+aKilmZtcsJmqcg9gTR6GwS5oFdLh9hrOQHjDJOHSMIEwY/4GHy+lWPBLf3Mces
 kEaxi8VOEq/+0Rw08OCdn93S3W/3ft1mKEKNCLokUpmT7zk1G3rAa73+Qg2mb9RqjUI9
 EwV3if1Kds8eXvhB9vG3jurP/QjBsr1qQ9RzKSXbvlrJr9kTl/eAnFDq6CeYGftZluHb
 WfzAI9ytCkumJf3zBRRin6wyimIVVIUpVdNZEiDcenmmgI9ej/vY//nZbcWr0YE3lV+1
 7A9jWNEvIGo9hq6Uv8lywjPUvLQSi7moAlwe+oSZjf7V4SgeBtb6BQMNxe+eDA4uvQYV
 XHUQ==
X-Gm-Message-State: AOJu0Ywk5NSr8sSL/znAFlU08y8/dfehfHBchc0PVjB9vh0qhttiWuw5
 u0lhLf6UenN+GMklgKkjMqJS4XDxTb6C9NsA2BGEyX7m8voG2w2G+k5dmh0xXom1BU8fGJuPZAE
 pVSwo9Fwy6RYc+bXZ8suddmnQUA7lmr4uN0GmKg==
X-Google-Smtp-Source: AGHT+IFwiX0nOYo3rpP8pHVfGR2QLba+uSnGx6M/MXvb82m4CItOvsqxO4Yv0N5NahQ4VNwAaLdVxRSJoYSj9/qLkRo=
X-Received: by 2002:a05:6102:18c4:b0:471:c414:83b5 with SMTP id
 jj4-20020a05610218c400b00471c41483b5mr4269638vsb.18.1708939417646; Mon, 26
 Feb 2024 01:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-2-sumit.garg@linaro.org>
 <266b30c1-6cfc-4a8a-adef-ec2fe7d9fa4c@denx.de>
In-Reply-To: <266b30c1-6cfc-4a8a-adef-ec2fe7d9fa4c@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 14:53:26 +0530
Message-ID: <CAFA6WYPu13cZW2fBOcfSKhxZAcdeZjHMqDz-Mkj5fnh=UiGoSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] clk: imx8mp: Add support for PCIe clocks
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 9:04 AM, Sumit Garg wrote:
> > Pre-requisite to enable PCIe support on iMX8MP SoC.
>
> Commit message needs fixing.

Ack, I missed this one.

-Sumit
