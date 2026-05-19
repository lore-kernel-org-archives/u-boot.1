Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A86CCD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9889E84841;
	Tue, 19 May 2026 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NPr1N4Gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67FEA8484A; Tue, 19 May 2026 15:35:17 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B92846EB
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbe437b072so1775603a34.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197714; x=1779802514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9g3H4pN7tS8kCMXzqvXpZm2sUhoI1AY/jGX7jvk9RN0=;
 b=NPr1N4Gu+0DCli860sxdJtWagPXXGGMFlzDUuBH6OVQbRYBDZSnVBu30YzMCh80DFp
 kLe9tg5GoEifarW9dWa1/UZVgQSEprpKQm439f1Ei5O06qFyEQi2sPZi7rev6EKhp2RD
 MPGn/Qklih+JgZbtmY6ybDGiiFYz2iaqns4Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197714; x=1779802514;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9g3H4pN7tS8kCMXzqvXpZm2sUhoI1AY/jGX7jvk9RN0=;
 b=kNMFe/R7kl1aUp5F0GLKvPyH3AL/x7uZdHr5VAGmvGTJ93LEeE10bpcBOX4Vg8Wzwn
 onOgLA5IY4hNHyGyT4NxXs+TktY45hKL4T1pgWqKmr4RzJbjs58FGvCE4CsDTGK1G3Vg
 PEDAJHktu0TYZmutatDocl/aWuJifryldNrSLJZuzJKiuLBCaz4SRj9iES90/NaojOYj
 KPmLSoHl0lbvPhRldiEFkI3rZXgsELkUZWlv3Dcxdfv9DkLcrF7KijsLZy1DIDfqI6w/
 rn8sihgLmJSnHUFRPP86qABhttNUG54eeDvH33NWM2zdytIoQ5AxSYN3hSzwuBOnO+N+
 gWXA==
X-Gm-Message-State: AOJu0YyF5DKI77o8hy2DuYBgsG553pcE+Cl7DMkgrB1vLCFvwlmi4sPo
 /TuEEPhumarNx4WDL7C47ARW8GHbP6CWNTu55yztHAsR+XwX6LxHhq6RH1BT/CuDDYvf1tjilyF
 VjcxLgI3vJcgs
X-Gm-Gg: Acq92OHhLRoTLp81+AmSoJpfcrCmG+fg/0vxJG7vlow7I/RHhB1oKWH1rZZoN4aP62q
 hWAg3z33ZaIox09eRqyjjD2YSz0nhgC/ZotxjkehqH4ey6SuiPv7UezScU7eZ1YkGSuArJ1go1C
 JvApXsT5QeLxr9KId1NV8lpQLCRtTlxL8Azg8WfwRh5YE5QC6isUVx+LcYBKW+lL3AVuUy9G5ro
 9wyehat4dhAXLTGWEBcH2F/3eZLC+6uezKiC3pi32rP4NzjxkLB83I/6hmd0MkOJibbJIaRqNLe
 9BdCSvnXLJs6HLOcR9ZG7xubUV8RV2wrdiD2A3w67p7I/Mw+YiGENCB6YPqkoISThBKvBCiSGsI
 ztoBzTaL4Eb3F5f+PWNE/fuJbly1aSPZke3DadZ0Bw43uH2Kppg1We9r3FyeUmxjqKfWRM2wK+5
 Gaajxn9ACFOAyiHAOOXQmTxGHyOUmFMi6Pg3oZqKJtM+2xgp/pgzTGMZ5yC3l+FvMmXtk89XdK1
 ZczpSGMj8+PlJy9684b1PbYhgiT+XwvWvfdQxFqLMHRtWTwntyiGl1KVOp1
X-Received: by 2002:a05:6830:3983:b0:7de:44a5:51ea with SMTP id
 46e09a7af769-7e4ea07a522mr11865568a34.6.1779197714017; 
 Tue, 19 May 2026 06:35:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
References: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
Subject: Re: (subset) [PATCH 1/3] ata: fsl_sata: Staticize and constify
 driver ops
Message-Id: <177919771344.672258.1061219116435922662.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:13 -0600
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

On Thu, 07 May 2026 18:42:06 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[1/3] ata: fsl_sata: Staticize and constify driver ops
      commit: 06bf459570bad2dcdbd944c70e08084a815c00df
[3/3] ata: sata_mv: Staticize and constify driver ops
      commit: 2908a3f35b087d754dad04f746b45a5ed2c40972
-- 
Tom


