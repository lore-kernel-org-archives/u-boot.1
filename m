Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5F6C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 19:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE51F8310F;
	Thu, 22 May 2025 21:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N5WSYwrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ACAF83082; Thu, 22 May 2025 21:36:33 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C85483082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 21:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f94b7bd964so6457344b6e.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 12:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747942590; x=1748547390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xcMxekAyNWc3aHdiMft5BJGwBA4zyVodXSVaHBU3BU0=;
 b=N5WSYwrdnVvMICap29N4A8rLEw+xTQrciFyFIHoiWJK/1DuoTrnByOyF2Ao/gDY/iX
 OcJvLO4U88dNd+NdAVhDVNyu4/kq3yilKRcTzufrUf6s3ELPE/mm3ZlXJVJjQaJZi9SY
 zIUp3xCgZKMfLqUsOyTlobmjj9bQ4iZWTj33M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747942590; x=1748547390;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcMxekAyNWc3aHdiMft5BJGwBA4zyVodXSVaHBU3BU0=;
 b=n40F004rytlO3NzFua55+7ZKpCmkvGsTvbdJFneH21rqEy3NQlZS3AJYdzwknLdiTk
 dHM5h6wcHpfJjvn2gh4LNuAcAI7AmUyrL3POuEeiMOYTgZF1HA0TJuF95RgQuS/pdUNs
 BKwHWzvBdw4zQxCXNUn47c31NtG8PJ9LMAxeZpMKGWXO9chHuRSm6FQOGcda2SPpeF+7
 pM4X0nWfjJZgKNw9b8xKXxxug+t3iUy4ezFEDvoPUbK7KIJ786A1BwwAOV+m5neLixzC
 2udIXie/5qCEAPg4plTZHTW4tYu7lngJEo8vJWlJZsi0npkUIWbwVCxKd6/USf+i/at+
 df4g==
X-Gm-Message-State: AOJu0YwD6o9qda4ONcHvGp4hPbddAtVWuuvaG5GbOYmktrDY4TLwU/QG
 v57uOGmI/fMVSUDlkAT2dtBRs5UtDXlvwlO3QCn7ukm2//X5ZuerNbjfctnnI+Hli9w6NvWt0PN
 jIMYIt6o=
X-Gm-Gg: ASbGncuovsgzmulDpSXrgtc4flh9ZAx33whHhIOcg5boKVYuQGm9xMf76GEdi99PWkc
 TlfvrvzixTi78pGj8vq6rUfPXYmoss1qQVxxH3xuDVVg/xfv8wdwF2hrhF/WEESiXcR84K5XRss
 y+9niWT7ZTbdnUsrlMJIUfgE+F/3/UNASLzM3M60xw/g8xM6VO7ZL6ENJMRIAwY/51a32tUQsV9
 2z/6Z20Cw21HcBveRNabC2tdP9aAXJ+/dIGKkuAMuzsokpKCufSPfKALpGZigTVGiI/MVef51U+
 +fGE8JFxgmTMf1RcQmyZInYzYyUY7i2+JuBjzeJaaFSp6Du9A71jgEd32mlCCSCGxhXOEhhPeON
 2VgG0ouT6O0A=
X-Google-Smtp-Source: AGHT+IEXW/lo40+mFGGVXRS2s4CDCXTwG+4RzYEb5+O2htAp7g+I1nzvp5hys2uGwXGL1kxk4oZCdQ==
X-Received: by 2002:a05:6808:6b97:b0:3f8:d2f8:d735 with SMTP id
 5614622812f47-4063dadd666mr373229b6e.33.1747942589995; 
 Thu, 22 May 2025 12:36:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98cef4esm2587795b6e.45.2025.05.22.12.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:36:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Johannes Krottmayer <johannes@krotti42.com>
In-Reply-To: <20250508185943.628503-1-johannes@krotti42.com>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
 <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
 <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
 <20250507225123.GR5430@bill-the-cat>
 <20250508185943.628503-1-johannes@krotti42.com>
Subject: Re: [PATCH v2 1/1] arm: cpu: armv7m: add ENTRY/ENDPROC macros
Message-Id: <174794258870.2192967.1935908283399261068.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 13:36:28 -0600
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

On Thu, 08 May 2025 19:00:28 +0000, Johannes Krottmayer wrote:

> Since GNU binutils version 2.44, assembly functions must include
> the assembler directive .type name, %function. If not a call to
> these functions fails with the error message 'Unknown destination
> type (ARM/Thumb)' and the error message 'dangerous relocation:
> unsupported relocation' at linking.
> 
> The macros ENTRY/ENDPROC includes this directive and should be
> used for all assembly functions.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: cpu: armv7m: add ENTRY/ENDPROC macros
      commit: 0a006371578a8f098c1850b0097c1af68c018165
-- 
Tom


