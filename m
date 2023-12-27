Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA7EC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 09:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C331D8771E;
	Wed, 27 Dec 2023 10:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bnojz/ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E240C877CD; Wed, 27 Dec 2023 10:43:19 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E0487718
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 10:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e7c76897dso1587650e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 01:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703670197; x=1704274997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lnpG1EkLyR9g8kjXGobEPWfYNqMNDJdXfz00aCcqv0s=;
 b=bnojz/otcMvLTYdeIo9V07iPOtyFTrouxLA5eWYgd7OSoJ9BYakYcfbYysqhvYG7E4
 +QLOynNRSdYT90+62NPEAMvEPwCy+tmDPPxWG0TqvvMpw1TTTj+z8FvmdFPly557gEb2
 8zXaKYPHT7ATDtmUYhsLQc4IV6hAUUmiJbPnR1hb1racZTQkvLlc8ChcxiPmhj3h5Inv
 6cF31qJ7///J+0XqpdV1wH4wdHQoR5vYUyogAu45jD/obKvYDA/TpsGSrqjUzqHVfXdg
 Gw1V3WKWQmjoq66Ukz/A0Hbq6gCWRCRrND/bM7IZKc5rT0xSVDocS3rnGhfMsvuSrBLg
 dwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703670197; x=1704274997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnpG1EkLyR9g8kjXGobEPWfYNqMNDJdXfz00aCcqv0s=;
 b=U2Mm4LYOj4HZlTJ4yKDmO7rbKOqSZgDdYQFqJZl892bluMmvMvfRHJ4VQkA5c6lxCi
 Its7urwSAldKtxt1pGEIhm7Io9VuHegDnO3TBxrvChnltdOe54FAiOfxYl5M565Esj6P
 xj+eUsKzpB323h9yr6CHaaHfASBgs19jD7849UrUaZT+fDV+Jvc+eLVELv9YUP3FV21F
 ASP9djEA8mxILUsTKRd4SzNPT41X1ieDBVfesRtvASqGNRuOrYFkhCLRxBnbKwSISki+
 qoitm3y6tLSGEgRIa3tPuLqXXGZm92+jqCAmpmT6TP4QslZ6pUcyGgVk1mtQwXNikCqH
 4pXA==
X-Gm-Message-State: AOJu0Yxjtjan39ewH6IhYPMdB7magRs87GbSxwZiHIxROA5A1jGttpll
 xTdVrp/qLN0Eznf9JStnGNDMD1eaEE/7GTZgyUzBM+KgN2f+fQ==
X-Google-Smtp-Source: AGHT+IHhLLBoEGG799f0XQyLeLa2bQTDKRIjA6tZ5f6s09erecfgMPkY72LtpCHMJxHYy451aGidWZqWsNbwCUaLDs4=
X-Received: by 2002:a05:6512:ac7:b0:50e:7f67:b6a3 with SMTP id
 n7-20020a0565120ac700b0050e7f67b6a3mr809836lfu.214.1703670196806; Wed, 27 Dec
 2023 01:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-7-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-7-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 11:42:40 +0200
Message-ID: <CAC_iWjLs3Tj25hr7zD4cWCsRRWhB=DNerOr6CjH2PQeOfAaBGg@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] bloblist: Drop spare value from bloblist record
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Raymond,

On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Drop spare value from bloblist record header.
>
> For now it is still present in the header, with an underscore, so that
> tests continue to pass.

I am not sure I understand the commit message. Doesn't the spec define
this as 'reserved' now?
On top of that, it's a better idea to follow the spec naming. It's
easier to map the spec -> code for new readers. So I would rename

tag -> tag_id
size -> data_size and
flags -> reserved.

Can we at least do the flags -> reserved in this patch?

[...]

Thanks
/Ilias
