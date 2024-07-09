Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613A3C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 19:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6B48864A;
	Tue,  9 Jul 2024 21:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tjmJz7zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B94D885E4; Tue,  9 Jul 2024 21:27:15 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC4568780E
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 21:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-78135be2d46so502978a12.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720553231; x=1721158031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t9qbTXKiqe1ADbsujjo5THJt9GhUU8AISLWn1U9j/5c=;
 b=tjmJz7zOWB2PassOXfp7oJ/LZ4JrMZrEeFUUVARfIaafnUNK6tboj82bNKKmN5acMi
 VDzj22bR5+UXLrA4afZnmFekourmYffHVx5zn/x+RGjpn5aMGFBKErRe8JdYUqWbWoi4
 s8zmQuMJxDtWlQU/z3m4ZxKqrvj+0eVUxC1WJ6Floj0+LRd1xCDX5pTFNjPl0hvQPRCR
 2nTLLx1yEUeNtHnXSXmMGUi3Be4hKiEy+BLlIbNDeaNmosSATntBcgcauJeqRqSJsOzV
 9y9Oz/7NRV6KHUWoz0dDCnhkyo7L/6jsNu3OHFBJ61DDp5817clLVwI9IIfJiRJFcGJs
 5LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720553231; x=1721158031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t9qbTXKiqe1ADbsujjo5THJt9GhUU8AISLWn1U9j/5c=;
 b=mpyhOgwhxAj890VDlH0kET5VOJMpt50Ke2ExN3kgPNC8GHdonZdHzFjjyNMs7qH263
 3sPhLnX+sNzpm/WbylrF2mk6w9y1hFuTZTMnpDSeKDGKwacJR+CCdv6thKk64EeWeeiL
 FCOyweKV07Ec3N6hPuV2dB5WI+coccMWz5Ng/WZcnjU9hrOUpw0xShJUqHmbWXR2I3NT
 hl4xh1QAOtXqi8iRMeOWFEPj5EoL1eSjCGdbKTqCGSL7G+dBXCyElx4xbqBQyBea5wDs
 n8JjDQSC0zJZD+i0VUeid2PjUAvPipov8nQnsMFYxAod9oR7hC4ZpxFLuuUM9vsuHy17
 ISQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUP+Oh4Ykw52pVOH0baRaCqUtBPi+gh3B/vjSxEbune9NvVoC+rbtmfne5hA2MThlmoH9nqWiVVEOf6VWNc0lVocsJHQ==
X-Gm-Message-State: AOJu0YwbtSIxNtOQmypbxhKK7XAz3YySxIKF6epjtw4qmPepYbSqTOQQ
 geNF8GjchMyKi6kBNX7mgYcB7UyfDkKa7FEuKewXTaCfF0cGr95GPdzUWPeI5AtKwr0sCI6pi9P
 mqG5rark33uLV7F25No6xPwTrY1nhIgjojSiIiw==
X-Google-Smtp-Source: AGHT+IGYzLSAYdi+bMqh8fiUTyiegG/RZS+1porlkdMrMior3j0Dw/zf12ZBE95uyaZ7MZTOLy9RqBKx7+KwpCz5o3s=
X-Received: by 2002:a05:6a20:914a:b0:1c2:9554:fd07 with SMTP id
 adf61e73a8af0-1c2980f94c4mr3947616637.1.1720553231262; Tue, 09 Jul 2024
 12:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240709132516.2427654-1-yeoreum.yun@arm.com>
 <CAEfUkUKQGN3NBomwAkyP2fD6e6MoCrsiav3cS39gVxM43JHrXg@mail.gmail.com>
 <AM0PR08MB4289A2EDE199614C04D77FC7FBDB2@AM0PR08MB4289.eurprd08.prod.outlook.com>
In-Reply-To: <AM0PR08MB4289A2EDE199614C04D77FC7FBDB2@AM0PR08MB4289.eurprd08.prod.outlook.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 9 Jul 2024 15:26:59 -0400
Message-ID: <CAEfUkULxHy+4THehXON9tu0H-y93LhTkMrAyPBN3R9A=j3zLaA@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Fix bloblist convention checking.
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "ilias.apalodimas" <ilias.apalodimas@linaro.org>,
 "n-jain1@ti.com" <n-jain1@ti.com>, 
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Levi,

On Tue, 9 Jul 2024 at 13:16, Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:

> Hi Raymond!
>
>
> > The handoff of armv7 will break if you swap arg[0] and arg[2] here.
> > The args are already aligned in the correct order via the assembly code.
> > Please see the 'save_boot_params' function in start.S of armv7.
>
> Thanks to let me know. I couldn't see that code.
> But I think before checking transfer_list, It would be good to check
> convention first.
>
> So, I'll change order only.
>
> I think you don't even need to change the order.
The FW handoff must fulfill two conditions at the same time (A valid TL
plus and proper register
conventions).
Both conditions are essential with the same priority and which one should
be proceeded first
is fully arbitrary.

Regards,
Raymond
