Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39632C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E206F88906;
	Mon, 15 Jul 2024 15:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XrL0QTyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4B2888E7; Mon, 15 Jul 2024 15:31:42 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A2A888F6
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b5db7936b3so25982386d6.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050297; x=1721655097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LNlH8VSi9WL4di3pZibjbodtb+OWzJlXbb8hwTUmqWQ=;
 b=XrL0QTyuZfJfnbzyZABMnqbXK/gSYRsl1+LIKYp7b+aHFZnMVZlrYjvO8sw0WzeAOt
 at9WYGlh153WK8Jkj+Yn/PpuVu5INk6WKcd7Ziyqf1Z/WSJOn2OgX8zSAdLt0TWuUkKl
 vbyKCe5QrESSZO5z46PmRXdRxCtWEzjs2zDfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050297; x=1721655097;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNlH8VSi9WL4di3pZibjbodtb+OWzJlXbb8hwTUmqWQ=;
 b=pPERhJz6KK2+BTlmyJEu1CCMfvp2yia7smxvRkYYk42OddoGdIyDT2nzi/NH5Qi3HP
 /dLlfwacpPsLlwZGHG7I5Yy+WsPyxD4SQczgEsL7XY8LFnIy8EuSBoZ8ZeiuSZGJCGJZ
 Vqr1lDStqvOOA4eF0msXa0byXrQGjTyXizafFnqmLQKIOp2/4ZvpQ0t/m77sxw3eKx6v
 rvzhsw+9rCVJfmYNEy7LNRGTVupSIU65PjaJLFepaqCJObU3SrZX18ebuJd9/iy8wflA
 /mxL5qU1yaiOHHiWs5Jz7bFUKeo0JIKqeE0iN2j4C1ZELcEg4ji0O5wih8jYDMq5V3py
 tvaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUenpW7iZNEIlh8Jno36KKCZ7D3X+3Pa1QmA2Jab3wykEefrwSsX+uc5WvmLGqxGlj77oMJjSm9GBjaWeaKv9QrkLMeNA==
X-Gm-Message-State: AOJu0Yx9jiGYCVsOZ5l8gdI/UTSmUJZSjtlTMIBqzRN3RUsz+BcN1Qg5
 W8850zt6NbaEYQ/gK4V9Ti22rsLBUCCvI6GNkyKjIWpPffWMxE7xOGyJ1MkkSfiRvpuJOTAr9uA
 eMO9M52fQt+cBJLSW7nZ1CT71tkL4RtyMlxFh
X-Google-Smtp-Source: AGHT+IF9Eqx+o6ZrsMDsaZxmE1JsaIdrjsYudenSkGfNp76UJA8+yiYacnQGc++y6IYPPfskpTykPkGxBvMTTOrJquY=
X-Received: by 2002:a05:6214:240f:b0:6b5:e58a:6388 with SMTP id
 6a1803df08f44-6b61c1c50f0mr235908206d6.46.1721050297602; Mon, 15 Jul 2024
 06:31:37 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 09:31:37 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-5-sjg@chromium.org>
References: <20240623175515.1466908-5-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 09:31:37 -0400
X-Google-Sender-Auth: lzlwqE5IKFHHalK3uF32lXTZwK0
Message-ID: <CAFLszTgMbRCTfXw6ui2zh8LQEYpRPR4G=69jbYtufR9qa=Cp5A@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] binman: Update the entrydocs header
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Marek Vasut <marex@denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Reduce the length of the underline for this header, to match the
heading itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entry.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
