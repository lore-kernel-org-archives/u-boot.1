Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE86FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5DD884255;
	Tue, 28 Apr 2026 10:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dr0Q3ZsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A308426E; Tue, 28 Apr 2026 10:25:21 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A60E484150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so136786805e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777364717; x=1777969517; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AyhusmcPyD2ck1APkpL5Ur9ezMHVzv6WNPt/0VoXHrU=;
 b=dr0Q3ZsLBBsoNfAuCC2Cj6Kt6bxrAPQl4Uc4OvfG48TTUhAgDJXq+CHWImrLlOqm9Z
 GMJCGeCptWrW+olDcRNUoHcuO8uorQzNgt0uulm1kkHZkUkjY/6KQC1882LlK3TourVN
 Jh/1w3j8EOKiKF/5va4Eg3cOlDl/2f5VpXguM+kLG0+xkx7Xfav9t7s0q1bVIBzdQbxO
 IXVT25VZaBLNKpSTCwk3HLq24sOqg41IGmwKzufM0+7Ee1mspjAYn4n4sOy5luWMCEXI
 mpsXKTAn7yqfhezcbAQxW3RDRBLq/ynR1fENZTgM+0QssqllDHNN5kdS7nqfaySc4wNH
 XZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777364717; x=1777969517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyhusmcPyD2ck1APkpL5Ur9ezMHVzv6WNPt/0VoXHrU=;
 b=HpxJ/NSz3q7e5XvDgcxsB1UzTxi8nWnGlR2eNhPkWTcwtrDUp8eNMf5jH34Pn0syRH
 nETNKLE8LCB6UDkYRj7OpUqUFR873SkQoibZTkI9j0t0LVCKtx6W06MXdZCBY9cLPL0b
 p2FoWPAtdEjN4Osi6G8WyeP9RLJAX1UprQPUKScFWWPM3YU4FSVNxbXU7OZDcaw042Pd
 YK7vw0GhojjaGszfhbYBF4E3fRog/lA6YOP0nDamRQErUl9vdUrbu2drrIWWO7IHsXh9
 9zULp62tFODdrrxKI02jsCsWz33Lbjv+EkhtUkWuboO+NUbHR6B0iV1JqjBsrQoEAgo5
 56Jw==
X-Gm-Message-State: AOJu0YxZibW1jniKB4SRJUMGibm76DTEQJA5y0sDMgYdvtHKET8Uonhy
 Cls0lrmiLoZUDcZhCXj3+gr2I0K2RDUnFLL5r+aeQiBOYqCpczFkh1ylPXoL4oePh/NGXX7BI5m
 lExfx
X-Gm-Gg: AeBDieuo3Sfe36DwVrZTW5YEqkOtDY3Wg4nxs5QL14OKfhJNgNu6DpPCrE2aPqssJJ8
 zYUyQMhG81PXJXghSAjVlO06Ci/JpvkLywhd+BrSwQPKAuvclo0E+bIK/88jc8cBj7TbcRmkfd+
 /ik1h6K2gYuMMXIW7Gh82JsWmSlskoAYhdCxEuOrQvzp5EivUYTw47ayEAt7PdrtriUuvveYKdz
 T5DLMxCjSe6lP5ia/Eye3N+whjSRZCrfXF6HFk0gIxClPlIdM+2LqGtEQAg6ISuBuqJdYZCay4t
 vN3zkNJ6RA/j/P0Kll3ZHsxnwGAoJVUkFF2aMszweu3YECZFTADO2qf1B3GW9/jGBXtgETI12ED
 acLWkh5YCTEsMGJoryWnvlh5TULB3TJ1Le4SZfdu+zQexmXTxwGh/9As6REc5Pq9USBnAX4ZgWM
 7kOBllOgEsP9AjYPDho8+EW6eD19sGwWoglXqOdlyHTGHz9U59y7zfPXEpcPYaMsev+qO4Du2Xt
 14S3Uaooa0ahhho
X-Received: by 2002:a05:600c:1d20:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-48a77b0a3d6mr36622865e9.14.1777364717055; 
 Tue, 28 Apr 2026 01:25:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eeb:3801:52a1:173d:c800:ab81?
 ([2a0a:ef40:eeb:3801:52a1:173d:c800:ab81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77afabcdsm57061035e9.8.2026.04.28.01.25.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 01:25:16 -0700 (PDT)
Message-ID: <82e09819-f796-46cc-8911-a3231d5f9d54@linaro.org>
Date: Tue, 28 Apr 2026 09:25:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2026.07-rc1 released
To: u-boot@lists.denx.de
References: <20260427230522.GP41863@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20260427230522.GP41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 28/04/2026 00:05, Tom Rini wrote:
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MHYzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com&scp=ALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/yyx-dsaj-iwr
> April 28th, 2025. 9am (GMT -06:00)
> 
> To join by phone:
> https://meet.google.com/tel/yyx-dsaj-iwr?pin=7760044274127&hs=1
The calendar link ended on 20th April 2026 and refers to a different 
Google Meet so probably needs updating. I predict some level of 
confusion over which meeting link to use.

Andrew
