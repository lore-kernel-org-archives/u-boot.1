Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E19FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 14:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E74D841DF;
	Mon, 27 Apr 2026 16:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JnFHg1mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B426A8419E; Mon, 27 Apr 2026 16:04:05 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B26483AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dcd89701acso5301184a34.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777298639; x=1777903439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LmA3qMSHojnb2NOxQRmUNfam8A3MjcIkfTQDmlNO20=;
 b=JnFHg1mzLXeE0TB+NhCWBew4S6WVZ7tioeuoJNxd1/pZhDBBSjjjrIZPSulVgtgtB4
 rEL8s+sd7JpSaXg/3VAUXqah/TEgcFr4ANIP/eSYbUlIFUjYbLpQbFBOCq6QTnUeShcA
 2MRAw5O4CQdLpd1BuetJVkljFoH4zLlNSfXkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777298639; x=1777903439;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1LmA3qMSHojnb2NOxQRmUNfam8A3MjcIkfTQDmlNO20=;
 b=YZ+FEtaGxKNl8djIXa9D3UZfuqTxscumREJ56gkbJ2lN4JsBdDf0kjZ5YFSzCaSgt7
 0nZxeGZRGiRj6MfOCsaKp9FXbXu7422QVEKO6d+dsJKe86PYvBdJAnMiTyGoEeAwIaZQ
 n8b1Fm4MGhr2jb8fScZrdS/qBQNjk7cSLVdz7j/XL03Whbwi+BofjcpQOvrrvQGDniH2
 xkoB+BL9Gsl2ObLIpYFDWq8/PmHRxQoJ4akHX3qmDqtXMEXkTU8ha7dPCcvJ9mpku06T
 TgOAB12Y/5NEVhqzvM4xTNH6Wl3dQKo7Rs9h8Vy1Ynrb4yMxS5zgMqAbi8qbZYg/TTNH
 /1tQ==
X-Gm-Message-State: AOJu0YwTPlJo9rSGyDi9FVXft3P+r2V5/e41Nm7Y1yfNZB840QYuI9qu
 YPIpvTr91NGx8GDW4Xvy4ml27BctxyMufgbbAl6HJMBwoe+5GUClK1Y0iTgsF5OP4XI=
X-Gm-Gg: AeBDieu6Vj21bYCzGrH45AzYqSV4C2Dk1KNX1wBTFJzCmVBH9ye2NDG3kBzeQjItBX0
 2GMtJsSuqEXeblMgTzCOw541pfZZf7B/di6A5Fu8MYZkDecdmqA/vVupSHOljjInyQjgsf+dqJY
 rYuccv9u1GfNdwq/dUkD0zZ8tVKAD5OxHdvfhvit8abadDWMLumsMgBxgoEYS5tS8wPwaJ6z7CF
 +JANh3Fa9sKC/M41c1EUWg592R2+SNEJVXstlzFv3hOdS5KdG/+cJYGvNvxMJsD/GC9acfbyFDa
 qgEABXbthEAwjTzDELiQOnhTUnziMoFUjC7hseiDL8ypxguZeQq+I3qv42BusH4TKhVH/zYW7jE
 Dl1D4tMtQiGiytYIWStDYIICCA4QQg3PnlRyXRaDE/XAEvWz9efl5mxiqsKhs9DiC/GMLO45M1R
 loYzL9GRdScLgWSeB7mbpXJcXEu3YBzQ7NWR9zkS1g5SvOgqMY1abuzgR+mx6VuKjgE2cuUQg0W
 uOCaGFRjrvNE/STs9KFWtL2IzPxuUxen3FAXjT+8ZDNgvBlSiipjXg250QC
X-Received: by 2002:a05:6830:81ed:b0:7d9:b58e:55ed with SMTP id
 46e09a7af769-7dc9522b228mr26536922a34.25.1777298639190; 
 Mon, 27 Apr 2026 07:03:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de72a3c2aasm5616216a34.12.2026.04.27.07.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 07:03:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Michele Bisogno <micbis.openwrt@gmail.com>
In-Reply-To: <20260426194506.220004-1-marek.vasut+usb@mailbox.org>
References: <20260426194506.220004-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <177729863823.3442985.3945508998867146800.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 08:03:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 26 Apr 2026 21:44:51 +0200, Marek Vasut wrote:

> The following changes since commit 9f61fd5b80a43ae20ba115e3a2933d47d720ab82:
> 
>   Makefile: fix host CPP pollution in cmd_gen_envp (2026-04-24 12:49:27 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


