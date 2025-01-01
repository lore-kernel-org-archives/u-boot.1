Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802E5E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958C7803F5;
	Wed,  1 Jan 2025 21:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WwlQErZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD5780107; Wed,  1 Jan 2025 21:41:49 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D1380317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so78292616d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764106; x=1736368906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPivW/GTdS8EuNvDQNEGkQfq+jVuS5DL1cvlnSov36Q=;
 b=WwlQErZPOamlisgkcbqibqE6iPlo8IIu06AfJZgdHjBeWNZiupAqT5MDitrKn6VMRL
 5QlS6stw9jiXGWkMT7kZ+AfOOcIIznPMLYr1TYHXmok8vFiescU4TNKGKCNjDk8YnXtX
 M/hOSTmV7F4w2CiwxXXVAYqpjay/ECaAtJ2hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764106; x=1736368906;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPivW/GTdS8EuNvDQNEGkQfq+jVuS5DL1cvlnSov36Q=;
 b=nKLEgtIilTzYRnFZvokW5kZcpxbnjnUf3pOsyOfu22psNOKuG2112kfOEm+Tuk9o4c
 befGCo3v9OnV8EdpXhWfdRM8a2WnWd724ts9/EMncnjTwfH2P9B8MMIq8+iC9cTaNqef
 otsFsdjhFqkt9yvoCICabBkS3le1ATaIIv/NM6cdhcFPubbt6chn1Rq56Zbv4mZ0+2jr
 JFk/XtCBIJSDRgdGIfM5oxryBHjWvOXI3Mvka5T4QRxOohYe48kh/y07e0VJYDM8KcE3
 eBd3MsO0vQ91MXwIqbsB08xxSnz5eqD+WlBy9j1JgQ/rgiiCipV1I8LSqvc2NTWm6Nk9
 XxdQ==
X-Gm-Message-State: AOJu0YxFfEgvxXJW6ySh9HL/O6z3C4Ea/OycC8Bpt8VOEys+znRpLyVT
 wtO1yXPyIr7hfVDrKsxpKua54B2XBohMq9upzWSckrmkZLQoF+jBHKkyqR0FwHg=
X-Gm-Gg: ASbGncs5oZ2sh73khmgvqRliXlk3FNGZaolth/s+k+9FpxaISPvEEeTCtA1AEiNciKp
 9mWxSk7ml/qszuuUR+t93IsBUD5O7i/io4rn+ZTkisNKU2eRJTV0ca2h1ZJLmTyMUuz9nAnjE7Y
 q3+QMvVnWdRL82DdmNnAKUeSdOGRFnEAYaS9Dz3EhpL12YSHpQfRQVJLTsQCQgaoM+DdOckj38B
 S441us3sLt8uPjO85j8gQuC+ZbiujcSw/YEiz4L211G3pRS44e+vE6A
X-Google-Smtp-Source: AGHT+IHiKIMqU2b8+UD6Av84I8BVGk/Ir0ugrEy1o/Gao+bYt7gkQap+JJDRG7if9MT0IzWo1CeWnQ==
X-Received: by 2002:a05:6214:623:b0:6d4:1bad:740c with SMTP id
 6a1803df08f44-6dd23307cc2mr687856636d6.4.1735764106341; 
 Wed, 01 Jan 2025 12:41:46 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182070ecsm124054636d6.124.2025.01.01.12.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241129144733.779043-1-jerome.forissier@linaro.org>
References: <20241129144733.779043-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] net: tftpput: reset timeout_count when an ACK is received
Message-Id: <173576410457.1694690.18125962298975137287.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 14:41:44 -0600
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

On Fri, 29 Nov 2024 15:47:32 +0100, Jerome Forissier wrote:

> timeout_count is never reset once a tftpput transfer has started. If for
> whatever reason timeouts occur frequently, but the server keeps replying
> nonetheless, the transfer may be needlessly aborted.
> 
> Reset timer_count on reception of an ACK to avoid this situation.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


