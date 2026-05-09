Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EF2CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A9A84D9A;
	Sat,  9 May 2026 17:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ux0LM3tA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918E684DD1; Sat,  9 May 2026 17:35:11 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 435DA84D3A
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7de7c57b52cso2361234a34.3
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778340908; x=1778945708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vL//fJB7ji/F1SROTVPXIuZim3yYyr3aCzhlE+c+bdw=;
 b=Ux0LM3tA1txo7XCccUdRw6ZHJKbuXJqm/qvKv/hVwChRf/+sJ2di6A4/C/zlWvAxB3
 b4fJEsWeORvnAEB2jMW89f7jygdGiyEK2hreKiFhYuj+wEzIuudcnCUMFBWAsdqjJYC4
 N6Iv8EYhFG9f6Eqygn0QLe93adwP3hfYfEvC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778340908; x=1778945708;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vL//fJB7ji/F1SROTVPXIuZim3yYyr3aCzhlE+c+bdw=;
 b=Tik7VhKaVpGWnDQ+UYTXsQk54EyX3tyQIrUS+1BTmwRKTDgH6e3kStO4kta0ZOXafA
 L2quOMVSmN3oiNZJ+hI2hLcAkWGVXe8ChEOXCTtlVZvEqN2Ey038lkdY225IWTSWbzMP
 0iUlRMkDfr3JUAVta6Ea2CHxVUyRiB4Sm9yKyzT53BqO0OZzHnsihraU/21W1F6JFs9k
 LX4e8pSI7SarxiMPIGmzXGD5PA4EYtMM+WIfhzVXsApDUK6CyfMXe89KkWPYvor1Y1MQ
 NYjKJ8pNk71FE8QV/XFmIlNYf1R0Hy0MG95sU3IMGEhKFcxKh8Fz40VuHhAmdX0FxTqE
 mXXQ==
X-Gm-Message-State: AOJu0YwPGueEWtY04E+kYf6bRlut5fCvrw70aw7xtTjD7Ovf2OmDvNvY
 8VTYUOCNuqz0OFwQ944+Gool3txMmMDVlwMJEYZIhkRwN5zVmJbuPZAKOf9q+16fbHM=
X-Gm-Gg: Acq92OHv5h66NQ5FJHswwXXrnox3e6jG8NZqPp+/q6ZrY3BypG4ny9yTVBlC98t0hOj
 /joW/o1fwpQpmBf4z44iPGn7xPEVwr9QlFTbQTmZn9/B+5HLkmQo7XKRsQmYPziZ7jpdchZRfmT
 E7hOByx4RHmRvtTNdbDUThzQBTj1I6zWPZtuP+biG6/LqiXTKd5qVrs8+fegyWkyif9shuoJND8
 lhYBB9ITYO+2xMsp1I0LVLUHnLrCWlzMFU+ttFzzaG+pW5NiP2VIdGg0WEDEY0u0vb/hr7ZIVXs
 6ZmnoKdj95cJSXlyCcpE1CXm/HDXbCR4OnFnIimvdSpn0XdpjAQieC+B9Ybh6pfXCOWEn4FaRq9
 qUx2r1rkNU7DDBe4IZZa2WeKwig88qV53+ZnNYnsnPZT32VZMyy9+VjRB2FghNAYpg3pebjl7vi
 oqe0ub5/zc79kF/SnMGBSNF/L2V0GI8lOkol8gjJGa3U5niI7oGJm9Ma/yIW8/oKMcSBrJpLkBG
 f13tniQPIO66XEu/h2v5/XKl3mKDwWrTunpSbWLHB7AO4mrgw==
X-Received: by 2002:a05:6830:83b1:b0:7d7:ccc7:c546 with SMTP id
 46e09a7af769-7e1df1bb37emr11067114a34.23.1778340907964; 
 Sat, 09 May 2026 08:35:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d5061csm3245952a34.15.2026.05.09.08.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 08:35:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260509022931.898897-1-marek.vasut+usb@mailbox.org>
References: <20260509022931.898897-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <177834090714.3582249.798011562290107525.b4-ty@konsulko.com>
Date: Sat, 09 May 2026 09:35:07 -0600
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

On Sat, 9 May 2026 04:28:58 +0200, Marek Vasut wrote:

> The following changes since commit 3cdd19089f1b1b7cd08530f33ff4708abcfd426c:
> 
>   Merge tag 'mmc-for-2026.07-rc2' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2026-05-06 20:13:39 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


