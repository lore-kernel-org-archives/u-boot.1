Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE8C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E830E606D0;
	Thu, 13 Aug 2026 20:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qsP6dwjo_guU; Thu, 13 Aug 2026 20:57:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C27A606D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786654663;
	bh=Jw7mm7hoaVXck2HcIUCvTswROQjnfwCyFtP1/t0B2EM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DWtDce1crflPgCMZ9bknEcHL03ajpjiv2jXO9xf7qCkH4IjpJQjPNFIB/PxSrSIGA
	 VlFkuOr0S/qvXCjGZI4UaibJe4d99PbBxG0w5B2H9ccpq+CcWdk7B5SJruHuV8ZM0i
	 T4a0oFjU4HG1KszLOYSOSNjcgy2JJpzHvRCJMG2NaBZgAicbhhzB21PoxkFVH6Sqt9
	 9Yu30nQN+Eo4U3DRpt2bdYNXwcZmNEGy5e2zt5+2fbUv9DqX3sJmXGqP+yrmpMFohK
	 IvJNBM9Zkbxv7OZ1svZ6biTlOjdCokoy7CpihI3tQcgKQTmtUf2zs/spD5OOKI/lSK
	 AzXIKfXVw8iSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C27A606D5;
	Thu, 13 Aug 2026 20:57:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC322139A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B27E06072F
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LCgveTz31Ucu for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 20:57:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D1673606D5
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1673606D5
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rLNQEH9J
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1673606D5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:57:40 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a10d6f455dso34159a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786654659; x=1787259459;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jw7mm7hoaVXck2HcIUCvTswROQjnfwCyFtP1/t0B2EM=;
 b=rLNQEH9Jha9cgqEw0YqhGLPgKhMbGlRxs4zEcPrCFKFkjCSJt7tm5eESFkO133FDiD
 LMQuMV9La7ChG+ajq0PNGvPefWWVnYt8MyJpOAyBDuXnYS+Vs1z2qkW6JUt9q+9pHv4e
 vBZq62f3iiaisgUHFNBou2QM+eOHMGZ4/otA5kr8NY6qLziJzjDoWqrtjGE6CiQRnsUN
 IKByxX6mTodeYZ1q//zofIQQdhR1KYWqRru+a6Y/W9K32MzgPySO1P+2qS79QGziovuk
 uUHgIkdeyBmUbcseXqMysdghGzE7BozKWyENDBGJh2Ryf+Q8fpVn5g4ySFILEJChWF6s
 krjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786654659; x=1787259459;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jw7mm7hoaVXck2HcIUCvTswROQjnfwCyFtP1/t0B2EM=;
 b=L57BzFiYSZBDYQ0yRYmGou3L6GkJ5vc7gAmQrrSWkOoLfgObNRpghev0IeKhsVRXEJ
 WqgppMpok9i3k3oxApnE4qNis0Y9aokGX4mcpCbrs93LG/lsduJQ9Xragh1gKpCf7Lvn
 yCykcb0icpVle+HUS2wqhR2dwTsUhB6S8W9ABc8RTlLUbj8wxWdaBAQDb5WUE9nxH1mA
 QAtETyPHwKszTHkw0ON/nE0MhavSjre2aqaa7sBesLYTxvSFrUklpv5VXftCNDwREuAX
 UMhEaorSCTeTAPIW5iUUZcJfVg8/APP5ga1SNMFGApdRIif26uLRhUUpEG2iaBLG3PE7
 xD9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAmwch42yi3rUumctj4szatBLr/LIzPB1+crgg9P2Tfemhzsee+c7ukXNuMs+GlA7CA0r+iyM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxsV/3e0noxgIG2lL7/02o0QVZeOn0KEJ47rYBxBIJPPf833+aQ
 5gkT+WNyxsmTKAJLRQ9M3svUPx9NIA8iRyahsgWwKYBoVMZZgL8514P3
X-Gm-Gg: AR+sD10PNMweJYmZu06xvoenmJFwgOC3z1kdj2yEuounR9bpk6K/mkSNP1tIem23rts
 eRZ/MClcU1I6MRdOmsXSQ1w1GPGKbWnt03DZRPNvYCbrkQN4wlVMzmagSxN4JbWpCgH4ySj3jJS
 rBG9jOL/sa53lxaz2UUwTlSJKX/vbmyqrIOLx8dC9G4J2pgsO8/BL6qUmeK4uMowNW54W3j3p/P
 8vtWfbhCO5TQS/jCJirjsMIUWx9SqCStl/B0AmaZ4SbJP7X1Oclyi3pp4afQiZ07ulE+mMTG7px
 wSG8DUPlWH0vOqA6bOK6JMgNp1wj9zscpt8pijfrxQeLYlLpKErJBsuWFca/3QjaWDp4Bpq1mSm
 zVEDCJNMtjuU13od/8Dk+ZNVQbezDIk+5X4eTrRIWri4IGI54NRierqJaTDQZBxszRISbbo0BNT
 RrUdjjVMY1eaxZAwy6BZyDsAZKVUZPr6mmjICkYr/Cjgu4udwZL8twoOJE+qLZc3P1JsB7bhb6u
 LHXrhIuiSEhOxZBvyPzUI1rQ6s=
X-Received: by 2002:a05:6402:1587:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6a38a930d5emr288362a12.2.1786654658350; 
 Thu, 13 Aug 2026 13:57:38 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f8cddf8sm1239634a12.28.2026.08.13.13.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 13:57:37 -0700 (PDT)
Message-ID: <b75fc0ca-b834-4b5c-85b5-0b556436b5b8@gmail.com>
Date: Thu, 13 Aug 2026 22:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 3/6] rockchip: doc: remove TODO
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Don't try to guess the future consensus. And don't add
a TODO if you don't have the intent to send an immediate
follow up. Remove the TODO in a constantly changing document.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/rockchip/rockchip.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 7c911662b840..5e16e860bfd5 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -559,13 +559,6 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
-TODO
-----
-
-- Add Rockchip idbloader image building
-- Add Rockchip TPL image building
-- Document SPI flash boot
-- Add missing SoC's with it boards list
 
 .. Jagan Teki <jagan@amarulasolutions.com>
 .. Wednesday 28 October 2020 06:47:26 PM IST
-- 
2.39.5

