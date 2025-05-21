Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A33BC2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 18:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EC982E7D;
	Wed, 21 May 2025 20:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L7Iiv11O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D03C82E08; Wed, 21 May 2025 20:39:55 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C235D82E28
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 20:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c173211feso2214211a34.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747852791; x=1748457591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbQnBt3x0mf1OjH/uSTcvRtebeDpD0ZkvF/y+qmNjSg=;
 b=L7Iiv11Ov1KFSIvIObB+0k93HnCPf7U87Ul59HHKCl88xiNLVCXQbTpk5FTsAXDANx
 ZhOg3mQZG3kyQksSwYFzvKQLhXRckd4VLx37YIoox7yntGILEfiAikQqQTMO8l4CbntA
 yItQ9moi5rI24FU84wTxYVU/jP91Q5C46irRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747852791; x=1748457591;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbQnBt3x0mf1OjH/uSTcvRtebeDpD0ZkvF/y+qmNjSg=;
 b=mruAZ1v+g3cr+7k4zlMNwyCKtFi5uAqTt+3OnVXzhUeTbuUotOezQ/UiYUbTv7M5gd
 SiuWdLA2X/2lGobrsH5yzy3WFYH0OttT6sPGV1XWaMdyA+IcsivdrxP7GQPJXZNC+Bwx
 kbk0dcobjUGcNoUt3zU2Y51AEQWJmK0YnCW6vyVhLk16SqZrtavu5L/8OOzZWC9malKf
 uWE1WxZzkqwxSdUytVVpoqa5KmSDQ1lM/jk/ivWu15G61M6GO0c7aA5W2wpzjhmgtNwD
 wVVkA0eCDFS/a4MGOm5l57Os7wwQ5Bok5++GCdobMdR7oaKjfTn9Feu/QvyIg1YAEMfe
 HtFQ==
X-Gm-Message-State: AOJu0YzBCwHgBeGrn7HBY2hAbaMFN4XffUwe/zFdBaj0bdkX8PYSiCQv
 dWmyE1XSVNmEZy6Ik0FyHr6bN9DVHVQIrE/vIEebyEsySmkhcpUajwxmeGyEmrTyEL3rlKK11Rz
 2YbkLLnE=
X-Gm-Gg: ASbGnctLCHV2cZlimk1IYnHhC6hag+xbn+3ZdjGJ6WeCLV78+bU0EVBJ0FVEnJu+rlx
 YefFuA1J3sqjhNiSMjoSPaPsijl2ir1riruRUlL5i9eBsTZDwZfKGyDqEG463Ht8Z8CrJTQZcgZ
 0QcLlrEutdZZJB6BjkTXGXvgK+/800qgig5593+wlpkpdtCJmj9DjBlZ+iDxigTstQHnlvNkhI8
 RVLuUzGXpvBQugUcear5lG1W/VE5G5URcOXjLnEJYkoJkR9ldDWnzsYkkwbFRWHUMni5Tg/4dn7
 c2WQlah+F5ltczjlNdfjmTzwWqO3aoBWlvG8KCm6KD4McbLTpgtuMBgH8g6on3xLQ0L5J8L1HZp
 XjILJOLpJCTB30tKcrMYCQA==
X-Google-Smtp-Source: AGHT+IFnSTqNuQgy+VlyfYlIeCAnXTnKPO3VWoPn1Ft6TOZWi+vmpciBYiQOMhMQsORc7Z8JMxqmqQ==
X-Received: by 2002:a05:6830:6805:b0:731:e808:be5f with SMTP id
 46e09a7af769-734f998f112mr14110810a34.28.1747852791473; 
 Wed, 21 May 2025 11:39:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b5f5e7sm2233454a34.65.2025.05.21.11.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 11:39:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
In-Reply-To: <aC2hyzxwKzO4k1im@swlinux02>
References: <aC2hyzxwKzO4k1im@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-Id: <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
Date: Wed, 21 May 2025 12:39:50 -0600
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

On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:

> The following changes since commit a3e09b24ffd4429909604f1b28455b44306edbaa:
> 
>   Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2025-05-20 08:35:31 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


