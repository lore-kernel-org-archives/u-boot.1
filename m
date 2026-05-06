Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784AECD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CDB849F0;
	Wed,  6 May 2026 19:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hasNED+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA81849EF; Wed,  6 May 2026 19:17:32 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B480849DF
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 19:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso5827238a34.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778087848; x=1778692648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgyyMiLRokAn2WxYC8PyIEqTUMmgS/ShAzMO9Q++/hc=;
 b=hasNED+JH994zllcliCxUp7T9HV1e5JUs9no6zkKl1GXCUvVitYvuo2Kb/2NH+HSgX
 MZLNXFYtyR6y+mkA/IdEU8cDorWjfJx7gnBrYaZDHXYJc//Lp7qZjyA5FzDNm9JOXwag
 aEDIexiSg39ftqIeekbc/mSnE83YWQjTTJq40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087848; x=1778692648;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PgyyMiLRokAn2WxYC8PyIEqTUMmgS/ShAzMO9Q++/hc=;
 b=QHVdpxMRCwgMlLft/pryFRxeZiOjjC2OXCsOYh47epa9OEF4dSIA1bQYelxvyb2FHO
 zcOSQzUxXfI1g1eTa5DwGkFEbSh9aow3sfxfbPriHjtOWVZg1bucWGKIDEaqTscY5u6h
 zuxbhsa/9nZl1GaP6ObdY3pw6gI2b6P5OMIEs8978Y0F1LghnH9oEkPjTq5q5bq0Qy+C
 miD/lIvRngNbSiMT6VnaY0JDHc2ChudjMCR2IxZEFnXSAES6R7O5h2leLjeV+lWwjbk5
 ICyzZvnFOKh6ply6+b3Iog+YXQCU/aupD3szqClpUmlq1A84tROgqV2XC9k4U34NR+qs
 CGJg==
X-Gm-Message-State: AOJu0YykwZTkQ61tV52BCfJRpfJPzRvCp9Gb2tR+zubqU+nFBCjzEw/J
 7+kbAqtBE6uJqQJ93uyWkHd2GA+DI25uBb8X1Fc8NBW9S/be8xiTxJ5iwfkeoqgM3Tc=
X-Gm-Gg: AeBDievITlfqxLmbB329vXbeVb/ujXFzxzr8BPyPFjIajInj9TuSZYfJQ0pZx6PocHm
 VfRq8HeG30sLo05teKfTFTbBVBaZb5cdKOIO/irIqoFVaDBeVfCGHFEvmJ5vqcXOxNUkGbN43/6
 2dhc1NxEgO3SDnADenSmjbiy9EbALDo9uYsrVqWpRlHIVDDRjtIlCfVmwL2ivMpfLHJM6DV3/Q9
 jNEk5LYLxNMUwnY1gIPH9Pws3E8fstwvXmiZHckJ7mJTAIY4v/HWQH/mQDor8h6a0SZttrCKATp
 Pzz1iNDmams7k03+TaYxRsqASlQY60m5LRF7q+mxUrpBerYvkPEJts1wPjfX3IxuBCgv4L93FJr
 09JIcC+R9+E3JTPAZ9qGjr6QwAdRoIdg0NbuFiPFqoI6r/SQmbqn1yM8yc8nTRIdgDUHxXSbz6Q
 TnyJXCfnluLqw1Vfu2W1ezjpHnbUg3W1oQ7SJovf7zSag3jZ7+tO5wlYYoicA4+Km9pqeBDdJ8h
 1OV8KXr42j/IhjF/RvPuAHU0FUd+HWg1SloZINTqxWfLVGiPr+KVjvWSIAn
X-Received: by 2002:a05:6830:67e3:b0:7dc:cd0b:58be with SMTP id
 46e09a7af769-7e1deef5890mr2397894a34.8.1778087848358; 
 Wed, 06 May 2026 10:17:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca80d5b7sm12380327a34.9.2026.05.06.10.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:17:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com
In-Reply-To: <bc4236ee-057c-4fd3-930e-3c613e55ef19@arm.com>
References: <bc4236ee-057c-4fd3-930e-3c613e55ef19@arm.com>
Subject: Re: Please pull net-20260506
Message-Id: <177808784766.2488.15075724300816880740.b4-ty@konsulko.com>
Date: Wed, 06 May 2026 11:17:27 -0600
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

On Wed, 6 May 2026 11:58:13 +0200, Jerome Forissier wrote:

> The following changes since commit ae8987f4e690f397f507c4b1efabd68b3ed08db6:
> 
>   Merge patch series "binman: Fix preload signing with encrypted FIT" (2026-05-05 10:37:16 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260506
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


