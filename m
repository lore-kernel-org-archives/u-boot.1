Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20440C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF5188476;
	Sat,  8 Jun 2024 00:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KpiAC749";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12411884A7; Sat,  8 Jun 2024 00:03:43 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF3688445
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-25111b428adso1455226fac.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797819; x=1718402619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6+q4N5nAYwhciiNRtRSj50s1MNZD6Qez4d7p6kSlF8=;
 b=KpiAC749zdnxR+nSCRw07iams2vbIJ60+z8A+1yU4T5Elh5KF99OL3RzgxDMau6yiP
 1h18tkPUB9rMwjLNtLT60uMt/7iw5sjsUJT8R/ec9bPwXz2S4vJdAr+UtMhezI1okcr8
 omlCthCfLIdtr/TUClBN5nqa2j7g79uAAQeYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797819; x=1718402619;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6+q4N5nAYwhciiNRtRSj50s1MNZD6Qez4d7p6kSlF8=;
 b=cMmfgHHMzJYl+B+IprTB1QHSFnLOKosLRvqWC5cHzNvyDGNv6CDbAF1zbY1xSKjDdj
 K8DUVW2htp5mGwlLLaubQr5zHlF5vsm7pbg0VGPo5aSD83yAok8V75lAqV+ZsZZUUt0D
 XKEVR1qHNZ+vZvF5vtu4+2WgvFKlWAULN4uWb29wCCbP5ZS42W7O8wabm4snfW4FiIoM
 j6MiWJMU2yDb6cIQkLrvoBXEaMrfnJTtQOketfuKNbs+p2naff3SgKHcwwCuh20myRgi
 nBEYUzeQSs50brrUkX9qDs4n/qBNk6cf2QohEhfiaAeY/HPdkQnC4rr2ZgDZWmBPAYjH
 VxOA==
X-Gm-Message-State: AOJu0Ywro18oaSz+CL4WZkWhaQIWMOcF5LLxPqxJAVn1Usx0berFvnBw
 GuqWNSNbLUG9e5W1QicyqI9OoNapxtUhxJRR971EiPlppUymn4iouvp0QaX1kNg=
X-Google-Smtp-Source: AGHT+IHxk6bK/vI2wC8Jp9dCT/w/pswOLO67RlKqS6pB34YxSpVDqRC7D3mYM0xNyUO7oir2tJrT6Q==
X-Received: by 2002:a05:6870:9a0c:b0:24f:bd2e:9c46 with SMTP id
 586e51a60fabf-254644562eemr4215531fac.4.1717797819358; 
 Fri, 07 Jun 2024 15:03:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20240515080058.1530985-1-ghidoliemanuele@gmail.com>
References: <20240515080058.1530985-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1 0/2] arm: dts: k3-am625-verdin: Enable LPDDR4 WDQS
 control
Message-Id: <171779781826.4156831.3025604617277526759.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 15 May 2024 10:00:56 +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Manually, since SysConfig tool do not have the relevant option,
> set PHY_LP4_WDQS_OE_EXTEND to 1.
> Since WDQS control mode is required on our modules LPDDR4,
> this enables WDQS control mode 1.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


