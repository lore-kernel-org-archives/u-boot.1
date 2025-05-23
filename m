Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F41C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 783CF83264;
	Fri, 23 May 2025 15:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dko09efp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176CE8332E; Fri, 23 May 2025 15:18:47 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 307AB83264
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-600210e4219so1863716a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006325; x=1748611125; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Afo1WE2S3wYctU6s8fDBUUMl8Lh0SH+ALzx5rTA4erc=;
 b=Dko09efpv6lFxKfI9tVutNFF8CenpPkt9fwSF+SrFRVaLSGlMv87+biUP0wjHcWjTM
 Hqjgrep/wwQGe7KXE8FBSjKFK8YGKJAiSNBdpmcGwhMZWnS/QtDlCqevDNNVYGCu1o87
 k1br1xw6N54WmCaxpph9T0FRcGHfqZpOPBPTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006325; x=1748611125;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Afo1WE2S3wYctU6s8fDBUUMl8Lh0SH+ALzx5rTA4erc=;
 b=opQd1rLAnvh/DO+3zWVRWkzzSdk0t3oUPdPIchWWomx807L8XTlAZEH7BzBaq/P/OG
 MfA9CuThKG8+wWvhLqA6sdAlYPxgMlwI6ZaxTnEZpn95MmkgJGWIPNY+FtjlbLr+vROz
 kw6+BmUZn+Ofn9Mf592ph9vjQthXPlE3WttLs/kbHSac7dYlDpqjU76HF/qMeW6N/Yef
 GPR14Murkc8x0LoRCrbl2U6J/mXWBd4rUKNwdO9MxCkM4mm1IvaUaVQpWv9BKhiKKkDp
 CQT0imHR6CDDrSyqVppLQ6i/fYb03I6AS6EMTlxaykeBzKf67UFhg2B0F/5F4P8XrmSc
 wb/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrOtN7TkOh7NSgAThXHLpWOuxXKvAtrQ0MK2VJvop1vxHm6uydkQEHUkDUscNpVIp6v9xE4q8=@lists.denx.de
X-Gm-Message-State: AOJu0YzQJxTlvhM6kSYTL/t6Whgyd33mAX+ML+2VY9K86eCzu/B2WX7C
 YOn9G8vX0Ha0GSeAKbr9P3Iz57u7vzGcKPTP6LNgKMl9vO1VrvK1AX+WyEUYiuyWZDxfuxXIeS7
 IDUVgDFvIrKd1LKvbaLlib8/VMXLJuqM781UZ+f03
X-Gm-Gg: ASbGncspIQo7zlEKhyJEPUNW2vj1M/VuTqUPPCnkZbydBfTCym1ZvgzqQiIozuH9g9Z
 fDr56xqlnRi97VYOnampf+T21HwQ3klav785NhadGgmFPRGE145GSY6R5pfN7uSa931xwb3BJqp
 gY71eV8B0zg+ye8F0ulzpS/QxRMTPcGFxxqg==
X-Google-Smtp-Source: AGHT+IFmDp6WlYaJcN2m1/oIMloBCYkNJ7AjMwATZpsAwdqaEGrdgy1naZC0Tp57tcLaALfPl9yAaSqVM27e6USyU5E=
X-Received: by 2002:a17:906:2a4c:b0:ad8:5740:9932 with SMTP id
 a640c23a62f3a-ad857409bbcmr8242866b.26.1748006324686; Fri, 23 May 2025
 06:18:44 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:43 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:43 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-19-sjg@chromium.org>
References: <20250504132356.2317305-19-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:43 -0500
X-Google-Sender-Auth: Ws_bAr6pEwiI8HNyxJ9PsZdiewY
X-Gm-Features: AX0GCFvwr6NdSrgMVM8duCR_XXnjyiDr1tt9qBWsXiP-3isUuHajv2FdM0LdD1M
Message-ID: <CAFLszTi2iUxYhnC9Wf3o21w4tg3V7Oq8B7jMUu-FiSkd2CXy5A@mail.gmail.com>
Subject: Re: [PATCH v2 18/30] patman: Add reading of series and patch status
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Expand the patchwork module so that it can match the current
requirements of the 'patman status' command, i.e. reading the state of a
series and the patches associated with it.

Since the format of each patchwork response is a little tricky to
understand, add examples in comments at the top of each function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/patchwork.py | 218 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

Applied to sjg/master, thanks!
