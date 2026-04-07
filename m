Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B698FF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516EC8418A;
	Tue,  7 Apr 2026 21:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V+3mUxlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234A284129; Tue,  7 Apr 2026 21:50:17 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F45283936
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so3603741fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591414; x=1776196214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wlbR7p3b8oCAIatyWQWXCtJW/Zy+UWFVDiWj8Bb4TUE=;
 b=V+3mUxlL97vkZY3xIxvLKteF4TXkqE7l0RR+7xHDebg4TcZJHxE0Jopl8ruuA/IZGJ
 Q34YhYJlm2e/KFpg2Joce1l9MSFHqMNYm+COLh6PAftmk50SMQzJ1Y9r50JV6kg3xro+
 b6qgvXtBXs4vkI3whayULop9i+V2EGZepyc0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591414; x=1776196214;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wlbR7p3b8oCAIatyWQWXCtJW/Zy+UWFVDiWj8Bb4TUE=;
 b=ID0fEI6iHKrZl02FQVc9q8RgufU9oAeDquXpctucy7MpXtpuIqzAqdazKt5isjzlZK
 /D1sDCAfW8px9u1WtZXqHUJbhuP/wiVywA+7DOtZv+yfX6HEfNO7PwxLQDeUO/iKtOLP
 td8YurzLi+8KyZ0PIZnF3uEt5zxEaxZNdwl5e/PL4CAlOYOc7vIVeNBiCiCZSF2o544a
 EU8PMfwTd6/lihes1KTDBbH3FhOPyb+jNsKnM8VqQS7PNHv8Vu4Ju9KLRoEWbpRaRHtj
 wcK2ZlitQRcasjgTmUiXBh3ubb8bOjpdQulMeLHPxMBkFuLoQAeohSGMuksZIqSI5nsI
 DAvg==
X-Gm-Message-State: AOJu0YzMfO0qYN8XWXoJEU6tcsTgTINaBKqxyaBjdupA3I0pqQHwFS45
 M4HfvxaSp5JmEceBwzcwTlSSsb1Xt/OKKglgl70rhjxajI/maBYb51xWOjiPHM27/WSz+FzXvIb
 VIJgHkzU=
X-Gm-Gg: AeBDies+deaIBdDpV9A9EwGXVT3wR3DNlLh6gi8UTZLlRjkPb5iw6+Q+eAjhhqLkpTd
 TeptnuTzo+GMIH8RKoIbDWy9hQsFoLSHKTU0BA0nK2lwlupUY4uZ42j4A01TS2+wsKYT0jQKcBs
 dW95cjPHhLOwnoLZiBnk2pO60h0SOFYcEvKvbuCvdBtCPIgTAA77vFIiyha/ul3ma1w3cvUiTEn
 E00AVCBjUgdDibjMW2mn48VgqsjjJFy4UFov7/IhmXQ3tfRjDTfSk7WBe+B+coddlrP59fZH/nl
 PXWGJngQMVVy8Grmu+3wh0iT43ZuZN/fm2ddnGHQ+wJzqQWruP8m5FAH2NIFCXr09quMWVcTEnF
 9TypXcBMwntrEwIXCSLa9QhIMfqyj1QpICUXkZQhNMYvep+HLehxuTOyRtw29bFqdYr15mXD/x8
 HnGVkcwh4eniuvti2XgKZ523QUz9kkGYYoIyrt8BDaLrMpFyqZoMfaPqojXj6wsBX8yzCy0cIXb
 WCmlVkU3jTg3rOI50YUdUBRPEe2w2FH2Zr8UC0kj4EtwPc=
X-Received: by 2002:a05:6870:d68c:b0:3fa:aa1:5b1c with SMTP id
 586e51a60fabf-4230ffc14a3mr9789628fac.30.1775591413727; 
 Tue, 07 Apr 2026 12:50:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195249.2363452-1-trini@konsulko.com>
References: <20260323195249.2363452-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Correct dependencies for CMD_BOOTD
Message-Id: <177559141309.2108693.1921398410657724091.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:13 -0600
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

On Mon, 23 Mar 2026 13:52:49 -0600, Tom Rini wrote:

> The CMD_BOOTD functionality can only work with CMD_BOOTM enabled, so
> express this dependency in Kconfig.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: Correct dependencies for CMD_BOOTD
      commit: 1fd04cf46baf108147c090e04d56ab84df2430a9
-- 
Tom


