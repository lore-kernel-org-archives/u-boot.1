Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67432CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 18:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA9683621;
	Wed, 24 Sep 2025 20:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V24WzsDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1ECF83621; Wed, 24 Sep 2025 20:16:39 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EFF835CD
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 20:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-42571642aa7so628285ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758737796; x=1759342596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2ypg46ldueOtaG6BlOOZ8aHhcuvOlUfjKL02feHSTk=;
 b=V24WzsDPqkt8+4BTJR3zG7Zqg4HP+oyRPqCfMF9h8xk3GzI0zli8HrUk/HM0Wkw1c/
 suj7/ZHbf2UGBx8WQCbDbvUuggp1iZ/d4fJBVxRQavoTnLOk9OXPoFBv5E9vgK5fA9LT
 74vrsAcEIVKriPpfN3I3S567DztFkBdvFR804=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737796; x=1759342596;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2ypg46ldueOtaG6BlOOZ8aHhcuvOlUfjKL02feHSTk=;
 b=TNXB59Egj4JyPkzog2LtMMbyNCSl34ffX7OpxYGDmkNo+tpd9KvKHpZUqR98pvXd2g
 nbGXH2EdopX/sJU20fDXsQ27Iblj9/lw8talkeWfhMdnwGbCLtzReYBawv7wzh1yvl9L
 3sKFB8oiV22kXfDC+rf/Wx6Xbbl0S3a2vVJFtI0HnLvpB0OUdHXce8pDzfye8cN9o+FP
 3afYKpSImi1oISvmiqFGGoGIAUxDw/04xwSRLndD87o57PjwQLKkhOYNVb0sAloEwb5b
 V3W4sVWbbfPnY2Qcp5Bhrt+gFSRt9EWk9aVj5328Kl5NkJg+mH687IPSD85WLBtPcTpm
 x/2Q==
X-Gm-Message-State: AOJu0Yz33p7tZqHmklqde7fi/u2xkCxqvIgSB92xsUQpxQSAa7HqCoPk
 s5amzmdHN2akjM4OLr2zuuOSVV5C7mRliDDDi335o5Rh8YDQdjfm6CEFetviBzGDBsg8HBX3C8U
 loGxqEzQ=
X-Gm-Gg: ASbGncvL6MuWIfqH3Vuwv1zkObfujhRkWXbA4V6t9Al3AjgsdCFiG/3GcGGrRtaUGOd
 jxoiw1vLF4IfTEyl4AQ9nRztL82pNueD9vzDyzO+dza8TMdSXJqqSDWx7ymFjidWTvaPMv7tgCu
 ctlHf922Todq76VMQ7GAj5V2j/ltgy+uAV0naLI7KSQqAzT/N9YPesFk7wZJNOx9+kxWr4YnEoQ
 V2VKARQVNFtKAl6LcoI4wJCB0/VnaTD9YB6Sle6v8ccNE41ay/XdQDfcqUyJK8eqeD25Zqal5f8
 yC/HWKJLeWYuj9EWIyhj4pz+Ffao7z80FPIv2GPr00nvY9lso+vTaB+Qg3znZW2RlrTgeXVftT3
 Ut08iqilubeic4KJqK1b4y8ee0EMcHlmi0Lr3u99tnkCefArmWS6S4FU=
X-Google-Smtp-Source: AGHT+IGs4usRjairqhPqMuxpFuP1aTHy+8WM/tOTs9Pq+gfHO2vNhP/yI9est98vjXz/aItuyn99+Q==
X-Received: by 2002:a05:6e02:1aa3:b0:424:553b:f2f4 with SMTP id
 e9e14a558f8ab-425955c97f1mr8901125ab.9.1758737796404; 
 Wed, 24 Sep 2025 11:16:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a493b40sm84122645ab.12.2025.09.24.11.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 11:16:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250914152751.784312-1-osama.abdelkader@gmail.com>
References: <20250914152751.784312-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH] imls: remove return parentheses
Message-Id: <175873779562.361751.8969082830572802409.b4-ty@konsulko.com>
Date: Wed, 24 Sep 2025 12:16:35 -0600
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

On Sun, 14 Sep 2025 17:27:51 +0200, Osama Abdelkader wrote:

> return is not a function, parentheses are not required
> 
> 

Applied to u-boot/next, thanks!

[1/1] imls: remove return parentheses
      commit: 5d0b813d6e4749da2cc8672216ea0f5b9b1b350f
-- 
Tom


