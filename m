Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E82E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 18:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602C5805ED;
	Mon, 30 Dec 2024 19:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mjfc5m1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D57680600; Mon, 30 Dec 2024 19:53:43 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D9480431
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 19:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6f1be1daeso880388985a.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 10:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735584820; x=1736189620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SCoFU6Xh/ul9wh1e19tulQdLtUDkSezrMnayyrjkbic=;
 b=Mjfc5m1sV2gzB/GOrDYwVvwDH0DsS7fGVaCfCgKtWRIyWyfZcrBxeb0psWdLdnUFvm
 WmknqxAFeVz6xy67sZsU5lvCJszkpbDUtsbTzq94fuakILbIb4xJnfqfNkgoCX6YALCz
 3hbK3g0dyTBS7mzb1Xbs4REZeFEkkL9a4qr20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735584820; x=1736189620;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCoFU6Xh/ul9wh1e19tulQdLtUDkSezrMnayyrjkbic=;
 b=A++HMKLnzcETdK5Yfxxv76/aHnToGZxZzJ6S/1F2g0sZJyS8XDqoP9CctNu9Acc2wb
 EtJ3HmvuW75Y5hu3NtLCi6aDL4JKrmb1eO0JpeOtxpVU16m8DN+/5H63YtYyj1ckra4a
 SoyDM1ILEkXFAxn2thR/v5vETk7MAiiaTproMnyjiTokrGaibpvUzqKSz3NDrRY96Gwn
 WczRGvyGvhDUKb++5belAZZljP0uR6uOl/q2hCje/hiZedaEPq2VcBgeE99HrWGbM7Pb
 4cvTKF9dtozwX9sfdM2EUhrAbNkVfermsI6rSYLjOgbNSAIu+XcN/wpf0fQxEgqG1x97
 NJ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPlJ/Xd8g48S4b3M1PKKwFAOYq26GrhgwUDX6TkHE0T8DRBoVwIrTtf5g8/wXLbUO2vmChLq0=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ/ODd1kpUOb0HYF5Y0fDFoGT2fN03wRi32+tVyvKPX5uVDNY3
 oiAdzEY07lAMHYCbOEhrLYiqvaWjGEyfjgFP5Gp7FdaOPPKzzMC69+yzhy1rBOg=
X-Gm-Gg: ASbGncthJfGgM3LbofDvXwnONuq3mhKuXjSpDnt7rwsZ6hLvt9XorTQkhNlbLW9cS0v
 LKTVI8YqfQOD8wYpDwZtVsq3+l79nhAKujK45Ac5nAKrFSgE7bDatgw4X9/7n8NyVxkLheIF2Fy
 dZHg7VedcxQuLaM1NC8ypa2JwotVkKAkD+fbsX37VXz4GRjjjraJS7SCz4zCKp8n8Gu4J3jVaev
 nNOI7UOeyxEPov16G564ohGq8jHGx3ijxZRSozzx6p2TQnmF2Ij1Avh
X-Google-Smtp-Source: AGHT+IHPe3RptS6qPrJnlPLoQ/y7P0gjXhUuJBb8/JOkGhGlXFYHAEEUjhlBcwLHsPS00bf4l+sAlA==
X-Received: by 2002:a05:620a:3181:b0:7b6:d643:599c with SMTP id
 af79cd13be357-7b9ba7f68b5mr5614184985a.43.1735584820027; 
 Mon, 30 Dec 2024 10:53:40 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478e33sm938036285a.76.2024.12.30.10.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 10:53:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v16 00/11] net: tcp: improve tcp support in legacy
 stack
Message-Id: <173558481700.206594.8606635841446557941.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 12:53:37 -0600
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

On Sat, 28 Dec 2024 13:46:26 +0300, Mikhail Kshevetskiy wrote:

> Legacy TCP stack is bad. Here are some of the known issues:
>  * tcp packet from other connection can break a current one
>  * tcp send sequence always starts from zero
>  * bad tcp options processing
>  * strange assumptions on packet size for selective acknowledge
>  * tcp interface assumes one of the two scenarios:
>      - data downloading from remote host to a board
>      - request-response exchange with a small packets
>    so it's not possible to upload large amount of data from the
>    board to remote host.
>  * wget test generate bad tcp stream, test should fail but it passes instead
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


