Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E29CFF8864
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B0D83BC4;
	Tue, 28 Apr 2026 05:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hm2aWopy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F280083BC4; Tue, 28 Apr 2026 05:14:31 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B522A83693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so1384343285a.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777346067; x=1777950867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lg9A8oCR2q9Epi+FWq95AtFQ62uBBOVaNBPnnu/9KdA=;
 b=hm2aWopyJuYQs4DxmHozyq1MWRYlLQxCimYz/CpNSSNsrr3kuNADPf9xsbamZJR5NT
 ejDHkE2RspgSUhz5J3qN2x7fVSsw80TcfRiDWDh9iabIr46e9+rgWP9k2sD+af1zR5Wt
 y+ELHNq+RV70JkkfQ5lrltMOCK5JAi8SMp1uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777346067; x=1777950867;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lg9A8oCR2q9Epi+FWq95AtFQ62uBBOVaNBPnnu/9KdA=;
 b=ALI2fBFWdpCwXiQNpTF641h+9lUzRqwaVD6Ncan1fencKF/aI3kyimsoxcea221Bpb
 DoEus/p6p9B946SXvmN6Jbenz++0MOR5O89uML0/eC0bFsWfa9mVr3Xk3YCuK4kYPe9E
 hY35jjQ7nns1yXXCE8Q6df7bqalZ/MfWFbOkZJmQzXxJ+R9d66cP0APyOmUEAXltCZDy
 haWKCZvdnOv/aHUAKLTAW/ys348jj4GsiFsAVuLM5ZlIvmIL47RBbsUdhSeIQgmwk843
 Siz+0MqjJAccmQKKHZadQOgGZabrku2fc5aAU6XQI+D9tPocdLBEKVnPe1Xix5YRQQiS
 LM8Q==
X-Gm-Message-State: AOJu0YyktShIDphNYJubbRMSbww8DRHuxYqxprlbByVj57N580i91Hgm
 Cor0aPjMgGv2EmXG7D+6IqOxB7jBntphpBmAQLv3anIiRgQxr2CZVftyk85eiODpns3Spnd8UtU
 /HYhAAF9mIQ==
X-Gm-Gg: AeBDieup9E0u6+2xztLA1loKsEfEC6fsUrhPdlLc3+lN1hMrHcMm2eH5TIpgb8PfCK5
 rS/PeO57au3bRVsx175HCFR7VNYE+ugDq7pp3WdfSoAvunlZLjkaW7m+642tLAg2G0iTDLD2YkW
 SGqYb9aSiiJXIHGsUtV/+ktzVUx6fBuddY+x0VMcIdpRE6nEeHF9l/65G3yV5exB/dodGXe8pVS
 VFd7D37bmjumSNJJJOCUfmMZn6dx4k0cKZLe0kK0sNPBV9uX3gEoKllkC/8uTAX6u69k1usmCUb
 xMyPOfL5YMWdGRUhGu8SU9SayFnIzVOtkos0toyNAxq8iMIRRj6UyCJySrLY6cBd0tVuQFJSXJT
 JvKOeGu88M9sYuGpgVOJ7KX2ysgcLpCdgmQgpp79ge7B8GtpzBmTQQD9zV94YCfFOCY9w751aSE
 lq/ED9lPkH8RIxx+dMawFxW4ND2tFmo9i6maXPlXBCbbcPV6RHrnZ6+MOiBUJ0kxw0Vt+w0D7sP
 qVbVohAckpculLUAIun/SBifoPJwFDyj6H/zPKLP6mcy/xRd3kHy7KjiKUq
X-Received: by 2002:a05:6808:6f90:b0:467:153a:2d9c with SMTP id
 5614622812f47-47c28cc67e3mr227883b6e.15.1777323378558; 
 Mon, 27 Apr 2026 13:56:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-433efed57fcsm332624fac.9.2026.04.27.13.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 13:56:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
References: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] scsi: Replace SYNC_CACHE with FUA for scsi
 write
Message-Id: <177732337764.3545414.6162288648803311424.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 14:56:17 -0600
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

On Thu, 16 Apr 2026 14:40:45 +0530, Balaji Selvanathan wrote:

> This series replaces the SYNC_CACHE approach with FUA (Force Unit
> Access) to prevent data loss during board resets while avoiding
> system hangs during large sparse image flashing operations.
> 
> The previous SYNC_CACHE implementation caused timeouts and hangs
> when flashing large sparse images because it issued cache sync
> commands after every write operation. The FUA approach achieves
> the same data integrity goal by setting the FUA bit in
> WRITE10 commands.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] Revert "scsi: sync cache on write"
      commit: 34a44dad743b557542edf5b48f789e6bb6442628
[2/2] scsi: Enable FUA bit in WRITE10 commands
      commit: 4b42c59a34bb9364bd2228fd2fead0c5750e7abf
-- 
Tom


