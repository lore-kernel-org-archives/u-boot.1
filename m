Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B0CC79FA3
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A06183EC6;
	Mon,  5 Jan 2026 17:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uhYSY31s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A75A83EC6; Mon,  5 Jan 2026 17:43:49 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D6383E60
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7cdd651c884so70366a34.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767631421; x=1768236221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cr6z68H7jTXzLL/O6N2HjgneQU3xHaTPuAi93W6gFZI=;
 b=uhYSY31sk28gTyPsX8iSTYbHvUR9bwZW9Oa9y9re2x/Z8ssGqpuyLGcb7WbHq46Wri
 vvKWmx5o+1nfYtHrIBHDPlfy4lzctumMN8prjqvwCDHp/qzEshEzsNW8tQa1JVsaZykC
 5NL5hqxZoDKHPpgGkWQbg19FRhqXDuH8mHhMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631421; x=1768236221;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cr6z68H7jTXzLL/O6N2HjgneQU3xHaTPuAi93W6gFZI=;
 b=mxUIU2jfNY6na4if5m7XpwiyKM04/uJ2Lg1uhyQFNm1oktwZ1RzTBfX+hO1dq4Co53
 Qu0+2Taa+oaeFBJqHx0KRSjd99jaA+6OktcqHpgl29FpahE+og3ilSpHr9Uw8wYjaoAX
 jnKbKi3V/NQ0EB0lwP8cGmvybTb6+ORP5ZUr6PP828i8ooLKdiSiDjEVXaIbkg/ZldEG
 MIkrQO9UkUtUKHwih8dxyh9ea12AhHbBbcWekXSD7zShtkpLeabBREhtNVMLIMWwgvIF
 TWmvz37VIeIOHK5cwnZ7Qz1kEVMwjBjDjkszdDHSy6tgJfoqtJ01rJwRSrrhz0b+1lBP
 Ph7A==
X-Gm-Message-State: AOJu0YwjtmSZCY599+7M1DWQRvecnX7zoQkjAfuWDD7s8hlqIqTBqckY
 krbUOPU8SZBLlTTRHmfyKquf9UHIEQvxnRt5GRx0YiKcHgyItriA2e2x7eJ2nsSG/70=
X-Gm-Gg: AY/fxX5ZYSjp6kxX74d4xZT1JCnkIZQZ7gTUK1LCMm2SJNzJ32tdV/VZeryEP7h9bWB
 4fJ0+22Pj0w5/Qs2f125my2fCYM+Riokp43vSxOUljpKae3fLMPAaHZNB36chJCslQCXy5fwG3j
 dtgQ44OLVqS8MQ8hcGFSoY36jT+JE0aA+ZJiGpO9GzG4ev7zLmcgO+62xnAEB5+NSCfEQAQIgOo
 z8CYUPMNGJEPTE8gc85EE3w37U2lQtUxeMXCXYV22W14DLq04a1jCwKiPnw+EkI84elAQyGpzz7
 yLsACKh0XEIlMsC9xM7hB+ZL0n8HqSXnmhUN5gF3wC5yT/cv2sGAokXMRSggkwDc38cSlQ8ZD80
 Kg9cn/+vtHAxfLO/Q7Gm7xkMBnMgcUbFe/ab+bCvG1yy4iqxsUppgGdmOpW2W9ok4KjymxRCZbs
 fvlX97wbRgXy4SGXgtTdZaHDx4MkbapKZMRTFjqIbd8DvSNZ6StJqSjfS/AR5ZdvpmpTa1BLupQ
 XhoLa3JElZ9TPQhT15qy2SNUonPFQxoDzg6SQ==
X-Google-Smtp-Source: AGHT+IFvDmQ5d0ePAE9L0wdY+1TPu/9dWmwBDCCykJwluEkdmOLMxFPLn0UJt+Alb0/yndPi47Re0g==
X-Received: by 2002:a05:6830:3107:b0:7c7:e3b:4860 with SMTP id
 46e09a7af769-7ce2bfd8e5emr5062981a34.10.1767631421011; 
 Mon, 05 Jan 2026 08:43:41 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce45ffbfd6sm159258a34.21.2026.01.05.08.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:43:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20251219024102.145220-1-marek.vasut+renesas@mailbox.org>
References: <20251219024102.145220-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
Message-Id: <176763142018.3271216.14436232100650660543.b4-ty@konsulko.com>
Date: Mon, 05 Jan 2026 10:43:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 19 Dec 2025 03:40:44 +0100, Marek Vasut wrote:

> In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
> DT with U-Boot extras, to show how much does the U-Boot DT differ from
> the base DT. This is particularly useful together with OF_UPSTREAM, to
> minimize the diff between upstream DTs and U-Boot DTs.
> 
> This requires DTC 1.7.2 which does not resolve phandles when used in
> the 'dtc -I dts -O dts ...' mode. With older DTC, the diff is full of
> churn due to the resolved phandles.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] kbuild: Produce diff between base DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1
      commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
-- 
Tom


