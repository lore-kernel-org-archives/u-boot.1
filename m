Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD32DCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB9D283A13;
	Sat, 11 Oct 2025 19:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jMeYBQOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71AA83965; Sat, 11 Oct 2025 19:07:28 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B0983927
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce872d9cso1974966fac.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202445; x=1760807245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uTzvXO5QEECa36wSGw0orz7TlkfUdT5NVmg0Zs6dpCQ=;
 b=jMeYBQOA/pNDwUn6yguybkwMAERH+cv0nWNkStONlCe+S1D+8pJfQzqhPwJVxwJIKt
 ZN2daiv9qUBOoWBquKtgT1cf0K08ZMT6I3keXar8HpStIp8H+omraLWEOKTI2L8Szow+
 2jACX24iWYTa6k9qKPSYxFatjN6U3YiEKrnDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202445; x=1760807245;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTzvXO5QEECa36wSGw0orz7TlkfUdT5NVmg0Zs6dpCQ=;
 b=cEYFycA8YpZf/fQHmHtK2UKW/RWGx1+v2cA0oijQaaSF2E24qGjmo4tki5EXHPExpF
 n4ackIIMg+9UviCYjeCvaYxBeRvVBovV91hDhRYviJ8QaL/bEBeAazUx7uQ9yJr/iuti
 As7LxuJtXqz7kk9caOA5Hjg433yFK/XuXEKbaiHzqD8laCoqWZ5dBOHgW4pzV7+NJ6z8
 t4PDyydiQRyO2eJyqPRmvDA6G3ciTtVjOEWkxmjOvLT31mlpFbGWO6GwHKdD2Hi0d6CK
 0yEHoSSksG4Rn4GktANNj50C45eKkNS8HSfOUiM0yxUvqzJ9bjbW+JtIkGcKyN105w21
 RUpg==
X-Gm-Message-State: AOJu0Yzy9PvElZQPEAoSOUXZREnTCYwbALPTeJ77QMYXzdKKtSI+aYHw
 kAUY6gyYqqFdQutkcIC7T6YrwPVbsX2bnVkUyYJIOyCf9n4fhWLMjrqzkSuHNE0FlCkER9AyGFb
 En3kfZJc=
X-Gm-Gg: ASbGncut2hAp3pI1iOmWFK/N7pzIlAeQ2DG0mJVEIrwzy683cab18vYOSfxAZRc+Wcr
 fqWs65+S686VbgvKQGgxaGFRv5kq9AlTaBXKx3fNgFwq1Z8BfIsNlb5VpZ2RplhIsp4LwliCJek
 YN4pDlEq6O6tne/ZUA0KqDkVKe5tXDYr71mDKejDZZWnDVXddHwxOzZDbqmp8VwpoGXgrVfAHIA
 AXAfWkPLzsK0L97Abq8wNSo7DLFE/twrK/1Y2Zo3q45jPIy4dduV58d8M9oUMNf4vW1iIQ4KFBk
 Ec+hndiRp8Ot1qF5PED27AQ7g1KfvUVqOiv53GJGKkxbJ+AyFKDxdMkqbLn03GQtF0h/lNIvv97
 7XsvOMX1rRrsiiCT+CqL4LWBbWgTpIyepfNAMMjQBai+tT21eeTcHctd6aczemOiEvLKU5r2ydL
 g1JA8=
X-Google-Smtp-Source: AGHT+IFpY6qxH2OzAI7hdKtn29BsGPqEfdDbeh1vfDsPxyOMz7Dg9WzKDTLkVC+WCyQuDgYiZTRMug==
X-Received: by 2002:a05:6870:c189:b0:315:a259:ca5a with SMTP id
 586e51a60fabf-3c0f0b2c436mr7965178fac.0.1760202445132; 
 Sat, 11 Oct 2025 10:07:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251001203035.2828243-1-trini@konsulko.com>
References: <20251001203035.2828243-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Rework readX/writeX macros to be more like
 ARM
Message-Id: <176020244444.1312138.3125914586368196466.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:24 -0600
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

On Wed, 01 Oct 2025 14:30:35 -0600, Tom Rini wrote:

> The way that the current readX/writeX macros are implemented on sandbox
> means that when IO_TRACE is not enabled some code will throw up
> incorrect warnings due to how sandbox_{read,write} is implemented. We
> instead need to do the "uX __v; __v = sandbox..(..v); __v;" trick that
> ARM does.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] sandbox: Rework readX/writeX macros to be more like ARM
      commit: b30155c08e95550296668766bfd7d3da27c970fe
-- 
Tom


