Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0EDCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 18:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF67281E13;
	Wed, 29 Oct 2025 19:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uCo0uzOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8820682E34; Wed, 29 Oct 2025 19:08:02 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235A58004F
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 19:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c681a8aecdso57893a34.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761761279; x=1762366079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3VOCuLlYMDJDnnqNYZpubEiYFQkR6iswXGo+k+Niblk=;
 b=uCo0uzORnS5LGUYJFK5J4FR6IlO/xwCnGCxH1n70IjpW33eSBuvAfutmtvJrq9KFih
 +uVVzxVXka7N4JyPwIu3vQ0+9SKcjZ92K5s+fIn3okIFlAxkHbaXcowubCpXnCwa+8rX
 Srddql5prZOIxH6sl5VLc0Bnki7kkkvBe5LXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761761279; x=1762366079;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VOCuLlYMDJDnnqNYZpubEiYFQkR6iswXGo+k+Niblk=;
 b=DC9WGZP2dBSe8JNQNeaQZ5K7Oair6Ufj4QTok8G/cYTAN2Tsbf/UlJTi0Gf6FwxHIv
 dsnmJfSsjsnHIWRQa+78fZCWEECwruMiMIkGL7039PUM+CDG6mtJlnc/558roR1B6af1
 nnZzxXIOd02WwZZkrP+TIRqFtw5Ci3e7Jq1TTpSFJYwmywx1pvfs5MeDQully+u8IynJ
 z/IK5exZefVDOeOTPtlZVl0hkq1cLBlT9scsFTWDIhyQ+3S/JysNVl44fTPXniTNWSt4
 JN+b/8pK+CfPZyV7JKMQdh45lDJpPgVkeVsxs+m75feHpLq//xVAqv92l5z02AjnQqhp
 Z+ZA==
X-Gm-Message-State: AOJu0YxHmCzFUd5AEbnz0pLr/yARuTcJ/F61mrqNo+VIXMiLJTnE0XqV
 /myELsMy7KqY4/QKBN3SjqYLJg0kt6+rzVYa8Q75Ib2yEuKRubP9H//K8h1KhTx+bNI=
X-Gm-Gg: ASbGncuavQPvCoUaqe40SBHniq/oi3SEv5vioo9LF/DO+V5bh2ICrt0gLic3degzSCW
 DH2wHaJ0L3bkM6WYINvxcpEHz/Yk+P9p33tGWkj3uEGfmM15SPPbGus5OkMLz4/FzatouzTGDBl
 qlDxKKESE0C6KXXW8+E+y76HgwIaJ32wwSqYjd4AqenSWXPgHMFQ40rZ+F+Mu6EpUhsQoXj9ykW
 s6Wz1MEz+4WEPdDzIwS4ZnTz0UVD/sq5BMHvjYVcEvaYxhrNooNfjRfyARHKqrqU4Py59sjlJaF
 WhMMvMO0OnqcUcGaXy1omvr69OejJrsNcqpzt/jXMoGwJt37+10hJoD0nBm4MrPn/UhXk7KM0ou
 wpN2e6GJbPnw5uB6EkpEElW6ZCwab7cM3+SrKmwr0iGr+i14q+iTsZLMinYop5FY1v6h7T6z8l9
 AizLqtsgq2fWS6t34B/WXNMVBvEXk7Og6jigSviw==
X-Google-Smtp-Source: AGHT+IGdFSc0ELwCWSEYicC2/gs4qFoQD/BC7nMA6f6/ZXR6+y0kXlshE4NUbGj97wywjHxt4d6ogw==
X-Received: by 2002:a05:6808:bc6:b0:44d:aa8b:58f6 with SMTP id
 5614622812f47-44f89d63922mr85575b6e.1.1761761278670; 
 Wed, 29 Oct 2025 11:07:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e93e0esm3555356b6e.17.2025.10.29.11.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 11:07:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251029013156.113902-1-marek.vasut+renesas@mailbox.org>
References: <20251029013156.113902-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176176127704.2497692.999349409338971294.b4-ty@konsulko.com>
Date: Wed, 29 Oct 2025 12:07:57 -0600
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

On Wed, 29 Oct 2025 02:31:40 +0100, Marek Vasut wrote:

> The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:
> 
>   Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


