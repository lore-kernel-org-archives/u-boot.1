Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B3F8809D
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAC483EEF;
	Thu, 16 Apr 2026 09:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BLYxsXgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E22A841C2; Thu, 16 Apr 2026 09:19:50 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 332B183C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8296d553142so3964775b3a.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776323985; x=1776928785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NRA6CrtXTs/FtIa+J+p0g51fbsQ/SqYFnphwon0bttI=;
 b=BLYxsXgKzkfv+4CZHfCBvFuXiSs0PJjN98lNOmsjbZT7eYN6Vnp1gyNbwnvksm3y4p
 u926Nip6fC4/qBbsj4d0HNqbkiuYdPgIoK36NSdNhbyCT+MfI2IAY3I+SX1peny8VR44
 QLJ5k2BAf4iGvhjSX9n5IkVdDCPAcNThPm+kyjFnPcOOzmqtmGrSQMHxr72yol4i4VSt
 PuSNJCcKM2mPsz55yxo37YyxoYXfLKH2G5qAhTOdAN/c/oFxVAJDThDaJK6ZP9x4Akdc
 QZlY+9SuRDXq+pwcajX/8x+DRKJTCuwIfsmlFHFoM+Gl4FZHC2Oqr9UQoVEcYapIDYqE
 hOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323985; x=1776928785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRA6CrtXTs/FtIa+J+p0g51fbsQ/SqYFnphwon0bttI=;
 b=oXf0C18Eqc0YVqXjaReNHpcTOMRoVxZL6QpklJFVNt4FxrEXCAOjosKQK7HpEm028Z
 3FYv5yBXPTPELeofVfu+Wfe/RcP0C1CEMXBxQpuATUkJhACL/JwubrUv3SxucFAoM2gC
 dAN70E4UTMk1wrczQbJZpS7BgajG00DqjbNzgcwpWe5khzMNZNnj3VqLv2PtoYGGipLV
 nIlWiERjBBqlTf30GNdLy0ufrj4HQx0ZHy08+yachKKWkxF3dlMlRAqfHY4/8n7cdTK1
 rcdFmneeuWfg/h5V8wDBFuTt7dQrTAorqd2zQyFSwWFkiq3B96+cxNmHnE37yAfSkeaH
 1Tig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tEEkUFmju9NpEJ5OOYjbAUIukjJMSfO9GN8NKeZSbluSj+2DWOXEyMrEWlhFIYjRSEKjcI5Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yxpzz3nVJgTEhehrD7/edPZYCp8KCmbzfoWsb0ycfgVk8Ddhb4u
 7EXwrisNVlU11SeII9j6x9ReKq9PNAXh3oucY57WikNIK1492oB0NruS
X-Gm-Gg: AeBDievMURPBNJMcYgPqCrw0H4a9wAMc4AYOgeRZabfeZwtTd9wYSTA8n2B69k27EEh
 Mi15Nlzl3Qsv0Hfb2PSGuaEIQzBSz6QI4W69gw2AH71IFJG6l3aapbgj77y37dAGuolt2BRI6+S
 v+5fgFfYbPgdrSQ0mq95GCBSkYoWCub7FSgGw4jRXLYFCFbaGZUMrmrXUPSKMOnoroQvG6sXmlT
 vv49Tgr1+8zFnco90lAfm5gt2iCIHGB7NZlWZNV0CVkbZumYG/2h0YNHTAaUbeMA7iRQWmZjxkw
 bhheClpLtllX4ktF2zf59Zk37F110/l3vfA6A4SSMqPohExRbNJZ72y56QHRo3vrX8IXAAXmXg+
 AfcYxp2wTW9vmiZe1OipPUjHNtE4Ysw4gLu0qdAJYWtOYqf9fTh6gTKWHKGLvlg968StvPfmGXX
 kYWh4/Lbfz7hfzaQ/qEa8rRrkZ8j34NZ0=
X-Received: by 2002:a05:6a00:bd91:b0:829:73f4:6ff with SMTP id
 d2e1a72fcca58-82f0c2b44a4mr24791254b3a.37.1776323985469; 
 Thu, 16 Apr 2026 00:19:45 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:6c74:6a92:c2eb:e814])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f6e46ecd5sm3167444b3a.23.2026.04.16.00.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:19:44 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:19:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/6] Add virtio-mmio support to m68k virt machine
Message-ID: <aeCNjtGCY-mlBWwY@google.com>
References: <20260413092240.3719260-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413092240.3719260-1-daniel@thingy.jp>
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

Hi Daniel,

On Mon, Apr 13, 2026 at 06:22:34PM +0900, Daniel Palmer wrote:
> Lets start making the m68k virt machine support useful.
> 
> First we need to fix some m68k endian issues.
> 
> Then allow virtio mmio driver instances to be created with
> platform data and fix a minor endian issue.
> 
> Finally, add the code for the board to create the instances.
> 

While testing and playing around with it on the qemu m68k virt machine,
I noticed that the date and sleep commands are broken after applying
these changes.

We will need the following two fixes to address this issue by using
__raw_readl and __raw_writel in goldfish_rtc/timer driver.

Could you please include them in your patchset, placing them before the
io macro changes?

From ffe017353f91e2a068f3a900e815cc11f388163c Mon Sep 17 00:00:00 2001
From: Kuan-Wei Chiu <visitorckw@gmail.com>
Date: Thu, 16 Apr 2026 06:45:09 +0000
Subject: [PATCH 1/2] rtc: goldfish: Use __raw_readl() and __raw_writel()

In QEMU, the Goldfish RTC is explicitly instantiated as a big-endian
device on the m68k virt machine (via the 'big-endian=true' property).
Currently, this driver uses ioread32() and iowrite32(), which works
by luck because the underlying readl() and writel() are currently
broken on m68k.

Use __raw_readl() and __raw_writel() instead to avoid breaking this
driver when the endianness of readl() and writel() is fixed.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/rtc/goldfish_rtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index d2991ca6719..4892a63f8d8 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -40,8 +40,8 @@ static int goldfish_rtc_get(struct udevice *dev, struct rtc_time *time)
 	u64 time_low;
 	u64 now;

-	time_low = ioread32(base + GOLDFISH_TIME_LOW);
-	time_high = ioread32(base + GOLDFISH_TIME_HIGH);
+	time_low = __raw_readl(base + GOLDFISH_TIME_LOW);
+	time_high = __raw_readl(base + GOLDFISH_TIME_HIGH);
 	now = (time_high << 32) | time_low;

 	do_div(now, 1000000000U);
@@ -62,8 +62,8 @@ static int goldfish_rtc_set(struct udevice *dev, const struct rtc_time *time)
 		return -EINVAL;

 	now = rtc_mktime(time) * 1000000000ULL;
-	iowrite32(now >> 32, base + GOLDFISH_TIME_HIGH);
-	iowrite32(now, base + GOLDFISH_TIME_LOW);
+	__raw_writel(now >> 32, base + GOLDFISH_TIME_HIGH);
+	__raw_writel(now, base + GOLDFISH_TIME_LOW);

 	if (time->tm_isdst > 0)
 		priv->isdst = 1;
--
2.54.0.rc1.513.gad8abe7a5a-goog


From 42f0b7a003be36c633cfcf37a90ebdb28e1b377e Mon Sep 17 00:00:00 2001
From: Kuan-Wei Chiu <visitorckw@gmail.com>
Date: Thu, 16 Apr 2026 06:45:42 +0000
Subject: [PATCH 2/2] timer: goldfish: Use __raw_readl()

The Goldfish timer registers are native endian, so they act as
big-endian on the m68k virt machine. Currently, this driver uses
readl(), which works by luck because it's currently broken on m68k.

Use __raw_readl() instead to avoid breaking this driver when the
endianness of readl() is fixed.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/timer/goldfish_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/goldfish_timer.c b/drivers/timer/goldfish_timer.c
index 70673bbd93c..91277d7932a 100644
--- a/drivers/timer/goldfish_timer.c
+++ b/drivers/timer/goldfish_timer.c
@@ -31,8 +31,8 @@ static u64 goldfish_timer_get_count(struct udevice *dev)
 	 * We must read LOW before HIGH to latch the high 32-bit value
 	 * and ensure a consistent 64-bit timestamp.
 	 */
-	low = readl(priv->base + TIMER_TIME_LOW);
-	high = readl(priv->base + TIMER_TIME_HIGH);
+	low = __raw_readl(priv->base + TIMER_TIME_LOW);
+	high = __raw_readl(priv->base + TIMER_TIME_HIGH);

 	time = ((u64)high << 32) | low;

--
2.54.0.rc1.513.gad8abe7a5a-goog


