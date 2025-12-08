Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F72D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 18:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B251483B1E;
	Mon,  8 Dec 2025 19:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zqm0y8Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1654F83AC5; Mon,  8 Dec 2025 19:54:57 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0553783990
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 19:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4507605e19aso2987118b6e.2
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 10:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765220094; x=1765824894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BxGaRo7UW/QeFbFmPgfe1h2iU1r5L0tN/BKMGsoNdE=;
 b=Zqm0y8Rxd3C0ixFyF4J6NrsDQaL9jRsh4pNiuw4u3axQbOuz5l+LHYKckKtXgM6bes
 WT8eMlAHQXR+HE3QIId/+JTBXIp+FXipV+HF399lNqG/t7qt3wExcj+7/LEkw/btjKcL
 2GAD5ZQkWqzFITI2s7zs4NLjdY9/xCE0YRPzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220094; x=1765824894;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1BxGaRo7UW/QeFbFmPgfe1h2iU1r5L0tN/BKMGsoNdE=;
 b=eJK93ajSxBPt0daKtOI1y3MiqUbzLV4wgKD9klI4YOjQyVAsgHaWemXZpV5rjGCyc6
 7896ci+xjBiMQQcb0LpzyT6y85/Km7rYaVxhuJlZb0Y2aZG/uqTahIyWt8NiE5k6hVwh
 SJjR5FtTioim+irAUTLPGxE5hOJgexrZfmLf++HWATid17YUI00QXrT/7fVrc4LIHDF7
 OxQxV0XFQ6jGFGk1qQMs7UxhOSn72BH4n09xdziUkl81ZGeTWvSphdLBVHYP2US/thfp
 mevYc6aPAR5yIb5COTSFNr/PYakDHVueRMhEqUZAcfNkqZGlDwjbeYHQRAYJmdHvVYG1
 3QxQ==
X-Gm-Message-State: AOJu0YzC8hwhBYzM8PFGwgPRFb4XIMfQcAc2qUftrR5Bzy0d85t+8AiG
 XkZCy6a1TkiIQK9r9y7/ZQqundqgAUANbu1ORws+MJlsuRBfeoOIHvYRH/GSO31uc2I=
X-Gm-Gg: ASbGncuTipcUClPD9B4+kbjtT3v/JiEbpb6waWPlB7E4s1BxnVtJf3Bl0bsHQJ05Qqt
 wcbQ9b0oW0sB91aARya9U9VLBpSAHzgQxg3y4C3xLMTOpyQSlZu6y2RnWQ6J1c1zdpxEUn34aW+
 vZufJr2aUKH9L68a8BynJGH0cEw+mb/xQQzkRFeVL1XBT9R2FoZrZsjaJtBEvW4X2huL5KYsOEb
 gGK8FwWPotwWiaKUFykBYkUtQKONBROjv3k6+PJPch+dPadqMNLRAWAYzt1BLC6eYa+73thDy4f
 i0YymJoMQYBtujNhUNXlDnsNnI4ucB3k97KXyCUE4PiOAsodMAcNy7wQ5yc0Sh4Hp8CcP6UFnmh
 +NWupO6CWSzxeWbF2s9rwTkmE+B14gu1b27fHSG1XfWFgdaEfcV4FrOkn/taN/ggHoSVou8jCTF
 B3NhNcbOEu9NS6dMkMQzen5BVxg7xyL+Bl6rnkbv9bd55XjkbX
X-Google-Smtp-Source: AGHT+IHP3bYJJXOGOv4KI9OqQ2zDeo3FnvIaMaex/MUq344j71ki16qF8cBeVnscV1s8d0q96EaVIA==
X-Received: by 2002:a05:6808:508a:b0:453:746a:1adf with SMTP id
 5614622812f47-4539df5ed6dmr3685846b6e.19.1765220093781; 
 Mon, 08 Dec 2025 10:54:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91eecbsm10890864a34.11.2025.12.08.10.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 10:54:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251206165034.2621363-1-trini@konsulko.com>
References: <20251206165034.2621363-1-trini@konsulko.com>
Subject: Re: [PATCH] doc: Update urllib3 version for building
Message-Id: <176522009276.376851.9808270097296014672.b4-ty@konsulko.com>
Date: Mon, 08 Dec 2025 12:54:52 -0600
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

On Sat, 06 Dec 2025 10:50:34 -0600, Tom Rini wrote:

> The GitHub dependabot tool has reported two "high" priority bugs with
> this package. Update to the patched version.
> 
> 

Applied to u-boot/master, thanks!

[1/1] doc: Update urllib3 version for building
      commit: 976c1cb85ffaf9d35d002d20c9afb585d8aebabd
-- 
Tom


