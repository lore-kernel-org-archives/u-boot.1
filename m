Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E998BC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24BE82E27;
	Mon,  7 Apr 2025 11:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kR3WrNhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E30A82D5E; Mon,  7 Apr 2025 11:54:43 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F89B82D88
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so980432466b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019681; x=1744624481; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3kF6MI6XWbYBFZr3464ivPApnNY/e4yYJGw7bHMLk1Y=;
 b=kR3WrNhM6yBags/p5yo5IbGvl9DojgppNAjaWB8T2JhYjAPRYBw2VH8a9r+y2xwaVI
 OgktPWQNPjhyZeTi2gyfm9xjf+YVmQQUlUYrfktRffBx5nrDXLVc9Xe7gKDYSojNIsiE
 sW7gYfgnphfNsnoiKqWjQw1iHSMYvDCueUPPJhtRfSs7Ir8XbJv/AADLkYXGN4svIGXC
 qYzKH4RuS/NeRwsjXiOfT4ywtt5SM6HtzdYV3jT3iszDaO9LlUbhCzqyDDr8EcMhLyLa
 AjC2+6uCbYfq+Nrdx73OdKZ91EVjizlSz7ZGMPCFujKRA+HSE7obmGg/26MJDsnNi8cs
 c8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019681; x=1744624481;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kF6MI6XWbYBFZr3464ivPApnNY/e4yYJGw7bHMLk1Y=;
 b=qz/O/dVfQWzwfDVdJvmYAq2LCjdeT2kjTrfRx+2FUzpneVhU0ggcIeUpVnM31bL7f2
 aeQu27u1PT//mISVhaonL3SkhDLWIbH1tofAZwCaiNl02OktSRbyj+T3MG2GAHm0VHKh
 eLFyK60sAWR434rJTUttbhPRsY1LEp0nWfjLyGe908qP26yaofgCo3zrk5HOFnuucrUl
 +3peXAMiYpPWg3qNRELCzJhGzNxS0SkOPXQmc7o7YpWhvg45uYqhLlQl30fHK18o3TuG
 Mi6plTuqsjhq5E5tsryCOgsGknXBJPHl+HhrprsLddhnhGhJM6t5rPIpCIMhS1pILxU8
 bO/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjMP4FFrmWrYDRhHO6T0s3er6PLcHDPXeF+UhxSYUraSiVEgc/Ja8JsqNOP+2xukhL8mYlA48=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0/y2Tp8idYdtusiiKd9fh2NLUCSyGrzqRWqgkmnFjit5iDbnV
 3b+1kh0JMCE86tbPjfAWQIu+iHdgsrg1543CX/KMhRKQRCcPsgy096tvjVZWIMs=
X-Gm-Gg: ASbGncvc/bc6o1gaysI//99v4QhIgKbncCvQk1JSTQJ/4X/+fBx7UZaqtt9NBBoto8R
 +e0Uy5YAybUvKVqGhEK8hpQvvGwMLmIn1YospWEU6d0vkBJUhkduZKxdbwj6LvM7fVvqYVGLCJg
 JnLVgfiDnJOBwf8VmX3TOL6zZfR+0NZ0VX9ASiv+qSWgJ1i0Gbre+qqe/btX+EBUrsBHPFSl2Bq
 hjyF5eJVbcGcYyD/BYDQt0MVV/DtPbGiNCjmVUKIlyyPe1cbHfpPfvwAoBLjNj77vdJ571e735S
 0+LI9SB+P74JIR0HlP/UvWC6lZV4Le373aIYWWs0he7p0naREdzJPnHtWbUB3c1mHFSi
X-Google-Smtp-Source: AGHT+IEmKB1itH7jzRraUFixMN5fOAVp1ITjYgEH6yWJ0pxBeF3I3S9rLfovTJKII5VKK2ky+wn53A==
X-Received: by 2002:a17:907:9713:b0:ac2:4f30:5033 with SMTP id
 a640c23a62f3a-ac7d2e96df8mr1198509866b.15.1744019680680; 
 Mon, 07 Apr 2025 02:54:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:7d3f:b102:5311:c65b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f6b5sm735733766b.109.2025.04.07.02.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:54:40 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 11:54:23 +0200
Subject: [PATCH 3/6] usb: host: ehci-msm: Disable clocks after all register
 accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ehci-msm-fixes-v1-3-f8b30eb05d07@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

We need the USB clocks to do accesses like
  wait_for_bit_le32(&ehci->usbcmd, CMD_RESET, ...)
so we should disable them only after all of them are done.

At the moment this works only because the clock driver doesn't actually
disabling these clocks in U-Boot.

Fixes: 9b3a9f896e66 ("ehci: msm: bring up iface + core clocks")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/host/ehci-msm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 60b2dc44d3d35ddc5b8cf37f70bbccd91c5e962c..bf46e89104ecd594587eb9132b8d10d566feb766 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -110,9 +110,6 @@ static int ehci_usb_remove(struct udevice *dev)
 	/* Stop controller. */
 	clrbits_le32(&ehci->usbcmd, CMD_RUN);
 
-	clk_disable_unprepare(&p->iface_clk);
-	clk_disable_unprepare(&p->core_clk);
-
 	ret = generic_shutdown_phy(&p->phy);
 	if (ret)
 		return ret;
@@ -130,6 +127,8 @@ static int ehci_usb_remove(struct udevice *dev)
 		return -ETIMEDOUT;
 	}
 
+	clk_disable_unprepare(&p->iface_clk);
+	clk_disable_unprepare(&p->core_clk);
 	return 0;
 }
 

-- 
2.47.2

