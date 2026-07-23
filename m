Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697EDC531D0
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 18:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43E8781145;
	Thu, 23 Jul 2026 18:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ikou6xh4oLB3; Thu, 23 Jul 2026 18:54:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 640EF8113F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784832847;
	bh=ZPIA7AIkH02R8JrdK+7QWr6mhcj6J4qE+pQnj58kjJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJgMDFxYeVSBImlSa4FyABbBK3dQMw4RMYjfumFStQbxRRJOqMM9pMD8rnm4LnGve
	 jLc3i2dfFnO+76ZBW+Gl9v/4E9hUI8zIYjMSUjCE8KPiDkqHMC/ZOoULbs5rKiVXJC
	 sKnOsJ9w7u+j70JDESw5PVNTPeuudaGGeFXw2d/NuTdOPNQ4BLTd/XjOmZN0Ujl0vD
	 b/1lechFR0f486CJKH37H6CYvAvK9uprNXE96UathM9dlbscD2wtrqEiq1QT3Qn/xW
	 gXG+x/h59t1e4a9lofcC+5q2zFwxfCS8Q+mSO7gr6l51T5Xvcr6P4+06Zd/eR9GEUC
	 giYDo+WNNM+8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 640EF8113F;
	Thu, 23 Jul 2026 18:54:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99A5942A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B34F40469
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGFayyAQbRY5 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 18:54:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A58D340162
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A58D340162
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A58D340162
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:54:04 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so639634a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832843; x=1785437643;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZPIA7AIkH02R8JrdK+7QWr6mhcj6J4qE+pQnj58kjJY=;
 b=IGv2J+5tM14ShzQByl3taaA3muFiaKulvbFHZzKr2ZlDGjKRyAmIxHf78qWA0b3J4V
 aLTPJ+2c0H061DQ8h552oGZBQPQuRLYv59edJcnMQufz01lZx+blYhM3VOKjBUSNlm7d
 5NUtpXC1r0WYqftmv1ltqBxKE1Z8hKmPCADr4tYkXgVhkqZpQya/lu8dOeYs+E3bc8mq
 lg/uZ3WOsP81RPcRHnGCiC6YG1Nz7sortAKMOwW/uXl02MNDcqlTRkz9XR+xDm1uwM5/
 pGtkdVY/dTHk+K3DBNmW1XspR7OYPiSlTT093foJW32gLIEizCkrI94+u6JQCMyz7NI1
 bLuw==
X-Gm-Message-State: AOJu0Yy1jzXFPhRoxXA95JY4A96mUAXwmGtJ7oBL/a5qloXOdx656qH3
 +Y0rdIkdkScYMk3B/2fR33y7CYgbKkegWFUKZNwUY2KhoqI9yjj6uFe40qlUuAJvTxA=
X-Gm-Gg: AR+sD13esWTHqwhfPyoe1OOKiDIas9xvQKclazMNmd28fb+ZLlmdG9s34iuFeZyLS7N
 8MB1MxVCL8WiyIZ2/aERNsMoJaamxsgLetPOQMaL5dK73FF7dt5kJ5emTAybueK+l4K6TAXWzOW
 o5Ux4gXT6zhwYkY0YdpQXW4rdlo0nhjdcbFx+bGALO44K6T03MqYYsdqCH1OpdBOuuvX8eKWh6X
 kYqwASPBm452rEk0WXzBKtsvKkwSHWVe+MBnFUAoKgMnlM8Se23GfXhzF51QEp99gcPcvEbdTiO
 7/co2cUcNth1g8tc79NkxvUClmfWBhMmXZoo3xGl1LK5m9ucwKQOm0cgtZ7VyZFwcy8loqSa43P
 UKkyWgZp5xem2oZ8bqD13+Zi1kvZJmhNuO4plnlhgOwMaBdeOCo5Uhg17uowQnKEozFpmYA8ng2
 WE7L2mpZYW4wabVxafajTPTYFiWY+v+4hIMWxigl/shkZlvUl2vRFyPFp5ZRamvygcLvIOC6wDg
 CfuleG0wjzR1UhlLYcS45wIKA==
X-Received: by 2002:a05:6830:608b:b0:7e9:e288:2b60 with SMTP id
 46e09a7af769-7ee43a46673mr2550317a34.1.1784832843464; 
 Thu, 23 Jul 2026 11:54:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a108679sm4217667a34.27.2026.07.23.11.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:54:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
In-Reply-To: <20260722194611.54206-1-marek.vasut+usb@mailbox.org>
References: <20260722194611.54206-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/main
Message-Id: <178483284277.3183172.6952716301648563589.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 12:54:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784832843; x=1785437643;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPIA7AIkH02R8JrdK+7QWr6mhcj6J4qE+pQnj58kjJY=;
 b=mwhnmcIrB94nbZhahC6PS8SBmixERcCLiIYTQL2LzGpLpZnQMtj3y4FZ+KCQ7B2qTl
 uxuzM/0AfVFzB1TrOwrYNvp5qKkWPKxVW6xBE79anAvZeO30Gq9FZb0nbsrWF6GMfUQx
 oEqEzpNToJEBAVV07lCiDzvUwUwtOueUHWtRk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mwhnmcIr
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 21:45:45 +0200, Marek Vasut wrote:

> The following changes since commit 042e45e026c77227319a426940577856ffe62e7b:
> 
>   global: Switch from source.denx.de to git.u-boot-project.org (2026-07-20 11:13:21 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


