Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140D4C83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA9D830B6;
	Tue, 15 Jul 2025 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hordy4wa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 315A0830B6; Tue, 15 Jul 2025 01:12:09 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0515C83015
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73cddf31d10so2194345a34.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534726; x=1753139526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clow0zvZC+LKMTW/4XlA5ulLh6cHbY0iMbI4Nzim/6M=;
 b=hordy4wacULnHEBQ1O1RCIV3GyiGkWthoAcueQbVkc0M4uqz0wSJqo4A/NrcOL54+9
 709dM115nPaUnGvJu+ZD8yThzvecI1jFfZgax/DuR67p4AjtSvqd4w3yGKoggGe5XBVo
 UDWgB2BRmvYMbVV9VXYzeeJm6Ex5SLyBomMwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534726; x=1753139526;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clow0zvZC+LKMTW/4XlA5ulLh6cHbY0iMbI4Nzim/6M=;
 b=ZxlGf537HK+OgUivspu1QvAMK0ZbLrCXUVw9JsocqZVIchxLM2oE6pVGMMxN2ka8tM
 u4vbhmoYsowkQkj0fTDV8qsvhXmCHzheLh1SCiO7tl8P21NGOQIAoRfWdZru/wrOnNxS
 U1DbHlv1vBxKHE/mgBJ+RlkdRtFclAMgYuSVzIwBMELgqRLvAW0zxVLkKPNsmlw4wG13
 MC6nscl5t8wgLwfq7T2eoMU5CuSV3WXhsCCNsRHbXdxMfx0RGE/oJpuWsuphgh3m351G
 a+jeoXAhICGW0S6Za43zDRzAcadaxjn8kcDihK5wjbr0kUJWIwmOAXuEKvhqCLA+MGi7
 1/Dg==
X-Gm-Message-State: AOJu0YxG4kVx0cMqAz3dX+dt+ghonG8PyM4B3HE7AbTSFZA0atGAbeVk
 shWmsF6lJMMQ2ff+UroNLnKrJEQnQwz/lb3ORkQJr0hQyBiHqmDCGdrwzes6VT4oW6GvC0Cy/2i
 2Y2ZR/hk=
X-Gm-Gg: ASbGncsZBHMN3mWW9qkEcRCyyJyjhkng3/AmiY8UpMyzBGRDlY0nckE/Bbu6SQpIgcm
 UMkeS+SPC5R33Sjeq8WXnF9kbFix8w/2C2LyA+iqaRzuyTKa43+G/GE5lcZ88VFSlYyMj+Bq0zo
 r1cH01bs37auBgewRdTDRErtmR6BGLkTt2UnDgd9c20W18r5gsVXn/9pv/XJFbVsJRmcrDUsqE1
 DawrzqGDUw/1GlAVVF7XZ7vyqBcouJSTD3ZXncyfOmuLbDonGCoweb9AGdR9YX2l5iX+el9Opdf
 6UVkP/VnbJIdrUE74E5Ne/QJlD65dd/MkxtOK9VHED6O5ZekFH/ooXJxnvm5DclgsCoZTag/70K
 7BJEd/IZXjIR9PrDlpNQhZ/pTiQYGb1CbemrK4Xcrp7P4B7JErOI9V0w=
X-Google-Smtp-Source: AGHT+IH1tOiRlEVNo6hjPs9xiXNNeOIuvsEJDqe8SLGvGxdQMq7A+pRD4kfk0zE/9ci2QRjlFfqm4Q==
X-Received: by 2002:a05:6830:4d95:b0:73c:e9dd:ccae with SMTP id
 46e09a7af769-73cfb0fc430mr9059833a34.5.1752534725799; 
 Mon, 14 Jul 2025 16:12:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250707113726.118630-1-ilias.apalodimas@linaro.org>
References: <20250707113726.118630-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tools: gen_ethaddr_crc: Make functions static
Message-Id: <175253472510.280771.18182913698217806347.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:05 -0600
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

On Mon, 07 Jul 2025 14:37:25 +0300, Ilias Apalodimas wrote:

> These functions are only used locally. Enabling -Wmissing-prototypes
> triggers a warning. Mark them as static.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tools: gen_ethaddr_crc: Make functions static
      commit: c28ff2112aa7a7d8a4f4d53e3b39ed9bb03e7f8d
-- 
Tom


