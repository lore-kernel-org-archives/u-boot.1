Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D108C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 20:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F9383B24;
	Thu, 10 Apr 2025 22:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NsGKUm3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9423283B1E; Thu, 10 Apr 2025 22:14:19 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EABC83A8E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 22:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72bc3987a05so669788a34.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744316056; x=1744920856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXUFnovTalVLLXS5I0nk9YxVZoK2FdcJirbEv84nFz8=;
 b=NsGKUm3bjX1O9aE3WuQWwTQTb/OTH5aysFMWBJL46/DyxFttVGRzepty+xYctIGdAW
 UceBNjAVI9SdTz0DC7VvN5+vDNh5X0gU+wzXH1hvyIhWOUWy70PUSEz1R0bjeNlAcfsW
 gAJMXQMQmdg/HyXyHwQm45vrwnwwASC1EPo/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744316056; x=1744920856;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXUFnovTalVLLXS5I0nk9YxVZoK2FdcJirbEv84nFz8=;
 b=Q4LCSkK0SKaDGEZtr7TUJCOtdh/QEeIuD5VBpnHC4lXgX3lw+yOlAl5Go2+w3E1IBY
 qQ7/1YjXlPCz+95mxod7OzrmvQs13RzWdGqmSQQQJwqElhvBqJThxBF7tmtC+8niTXjI
 CdagGRCurrHLaMSa6V6IxKc6drmnpLkGF6yQzfZhompdS4pqjGtwcsQrZZFHfgfhBtdj
 pIa4Ciegje5sjGdzB+tT/8DDAnW91em3JKWi3VJ10WQ2mQNkZlXMShatAAk+kTqdSLt6
 Na5mDuJvzxKdOn7LWQNX8Mh6TVrl9NmI1+N+CYc+H3L8007aoaJqLnwZEhMAcdANupyV
 ihkw==
X-Gm-Message-State: AOJu0YyismmiF641ovaAor+KV5R9RgHlicLlogIGHkmxsQqQV+DJSU1u
 MK+DdUNSapa1nryLTK6hL2OU4mAnrdURnbwakrXGbQa4J+58oLBISFofPCbrQ69Hy1cJ3e8SQeh
 vhtY=
X-Gm-Gg: ASbGncsN/Y60VymJGiKxtxo72OgLomH+0v2pRo0g3I6gjniu6zWwJqFQF2guOq74XfF
 6vKDm4kVTgNe5SlWa9DJnZLU0EYYRk4/11KVdOe4DhOToRk6mpw0SmV9bDDfoUM4l+FxQFjCEdI
 Lu5283Sav/0MlPU/q3/xw+hPpapxMJh36xpplQDj6C+bdN+6k2tGHdf5ilUttCCDT3czQgkCXPd
 RtKVr/nVUXUAxwNjvBV16zP6YKi3382ONkVFa040DVqXFulOhHS8f0E6+eltcfULJ6AUzdKEzgz
 aXDwC/j1Lf4dZY3mV5s/JqjJMseo4YJiIqEscHH2PpBvI12fRJYFaAM79A6BEP4bCD2OlgbFQQ4
 PYso8g3eQCfA=
X-Google-Smtp-Source: AGHT+IGOrx6D2TQXSEHpvgxH29c+PG0x39zz+JI/G2l0bOxIFXFxO1HM8/CHJ5vO9PR9XYApdldl5A==
X-Received: by 2002:a05:6830:3a95:b0:72a:48d1:7fca with SMTP id
 46e09a7af769-72e7c0fc2a6mr2190762a34.4.1744316056190; 
 Thu, 10 Apr 2025 13:14:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8fcaasm685741a34.38.2025.04.10.13.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 13:14:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Brian Norris <computersforpeace@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250227192735.406389-1-sjg@chromium.org>
References: <20250227192735.406389-1-sjg@chromium.org>
Subject: Re: [PATCH] patman: Show the base commit and branch
Message-Id: <174431605513.2981499.5744559721693306570.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 14:14:15 -0600
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

On Thu, 27 Feb 2025 12:27:30 -0700, Simon Glass wrote:

> It is helpful to know which commit patches are based on, even if that
> commit might not be available to readers. Add a tag for this in the
> cover letter.
> 
> Also add the local-branch name since that may be useful to the writer.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] patman: Show the base commit and branch
      commit: 774e966f293c552f29a57d9ad7b620e6f334aad9
-- 
Tom


