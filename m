Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648CCCAC5B8
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 14:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A9D83192;
	Sat, 27 Sep 2025 16:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eFx7FHVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD7083192; Sat, 27 Sep 2025 16:04:56 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B40780819
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 16:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-74382048b8cso2497234a34.3
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758981893; x=1759586693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KfB0BbVlGpgtxTJOPca17KMLnN8tagpkU2iqZ6bc2GE=;
 b=eFx7FHVNsAG5ZLXUf1cq7Kx63UhomCHocdg0USRunyzGpfwiXpoMSab3KCZLc2grnC
 73JzhmxSHWQDupKY/qF4tFi1NLHFX93Vqo8z3RZIcZgPdIGLuhu5IUBImV1QUkUYhlih
 IdZQepmjFK9h3MP/j9vkd5czZTNEQTA11+OCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758981893; x=1759586693;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfB0BbVlGpgtxTJOPca17KMLnN8tagpkU2iqZ6bc2GE=;
 b=mUS3+R9/OhUArA7cUFYw7e4WvQ/yVzHyImDCixOKXXC7sS7uT/XE0yTtc1hg4mPu65
 auhNTIYMpmwDGAyWR0M0tbF1Xf9uPh2h1lWzwTG4aT5xDZHKPcqR36uHVH0ybMO8J1Ms
 Oaw/o9YiQT+O5H6y6jzk1OGQMu+x5+H+WErZoOQXr5XmgCR+v/YvZBYyU6EhI5IAIxUd
 9WTCDfGsXU0QZ6IJZeKEePr1ca2IJlGAfbCcwTae47L7ZAy22/WmdPTgsoMULfIucNvx
 dC2qrbyzisHQ4/xpAud407ScMFpo9iZWZfK9nyM0FOB0g296IquXP4MIWPJu+9hYWeMx
 ud+A==
X-Gm-Message-State: AOJu0YwwsXKY4dU2ki12VKhIzbumv41c2eAlM6Fc8ffoJUQguDRR7HlZ
 sJdCrpu/BGlB+eGpa9BvUwV5Pp3n0GvfDgBzrGjzW7h6IWMZoydC0Nly3XEMSGTgVcE=
X-Gm-Gg: ASbGnct0VsPp6R1MqnZsrZykoY79OjNnQKEhXqswPx6NLzPmA+AUjkvgOLPZk4/MwC6
 qhCv09m5gmCU+HQAjp4GIObFC4eNd7a86NgTpU1iD7wmARzNCIcRUpVNPGUsoJK9aowis8hMyvO
 xG/aQ+InOx6/U5nmgTwFdyShjZCE1bNsxBOMdhQzz2AtwvkUY6TucfB7R/ZyKrMhZGXYni48r2i
 W0YrMDH3wXlQCZBleh6UlviyQiXpMa2YKj/yKcIFfw76ckB+YLNQQz7uZsiQXXyfTH6tPLbcLMa
 SKquiC9f2+d6Vcg+Kq+ajdF3ZOdPACeSUAI0mKtxgj4F7ud1t6KI9xt0+b9RUrUVX83Wadgi9hF
 B/as/I/EbypQcRerQUi/0NJq5I2vWYx/uLl3IZGOiyzeMiXPxk+KRl6ikKgbqrtxUTw==
X-Google-Smtp-Source: AGHT+IE304Tf6QP6byWHtHOPeG3TLkoeNDmDp2jURWFxG20g8GQjcEHw2QiDaxlfVggXSjTrGLCdiw==
X-Received: by 2002:a05:6830:2d8d:b0:790:710f:60e3 with SMTP id
 46e09a7af769-7a7ff0cf1c5mr2884903a34.23.1758981892870; 
 Sat, 27 Sep 2025 07:04:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7b4c0e92da9sm20077a34.26.2025.09.27.07.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 07:04:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250916161445.582540-1-trini@konsulko.com>
References: <20250916161445.582540-1-trini@konsulko.com>
Subject: Re: [PATCH] scripts: checkpatch.pl: Extend some checks to "env" files
Message-Id: <175898189159.3905802.5126130292516092830.b4-ty@konsulko.com>
Date: Sat, 27 Sep 2025 08:04:51 -0600
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

On Tue, 16 Sep 2025 10:14:45 -0600, Tom Rini wrote:

> In order for the U-Boot specific tests we've added (along with the long
> line test) to be run on ".env" files as well, we need to update the line
> in the process function that starts to limit the file extensions that we
> test on.
> 
> 

Applied to u-boot/next, thanks!

[1/1] scripts: checkpatch.pl: Extend some checks to "env" files
      commit: 40888b1e4cc81404493a2df263af1ca20ccd08d6
-- 
Tom


