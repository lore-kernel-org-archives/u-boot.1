Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817F8C3ABA9
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45FC8210D;
	Tue, 29 Apr 2025 14:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vxgmZPfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDFF782132; Tue, 29 Apr 2025 14:07:11 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE7880BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so4363549f8f.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745928427; x=1746533227; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9S33BIVEr4bCExCYzCDE0Te2RQqpyx+TAig9wFjlO+A=;
 b=vxgmZPfDSmTUptZM96FshVmw9/aud8IGgpdhAU6mg+VPAJHpo+Qc04Xg6d8UvJYG7R
 upCVyq8mx3x5T13PU6SoeUKtzE6Fwk83yTThLopuvkYcFI6GXusxuwy0WoKZQWr+1/WO
 G4oAxAAiVqSt9Osj+R+n4l6KycSpeVeI03uS2FkHT+SiMyRATYGSdl06MfOUk5whQRJL
 baSpKbBV5OuwNbO4hXyh46HylMw82nN9KGzAf+dogSF9eNV+Lr3DEpvJbmB+fvkwTvmK
 DPWnnwTGisEYVYtuJXgkQP2sTm/b0J2kKL+TMznpxko8nnymbEzqb8Hd3WbXNGe4ABu8
 nl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745928427; x=1746533227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9S33BIVEr4bCExCYzCDE0Te2RQqpyx+TAig9wFjlO+A=;
 b=mo+e5fhzHiVoUhwzRLWOfcNjxKL1crNIZ/4JCo3YFa1WBb0+2CV0TJ31hZ86I1168E
 nUeTn/wa0XLaYgdAN5v2GDQ4o2qg7BTSQXecJo+UNvlYpXV/j21GTdC9yMIe8Lxdc+Wx
 y3y9rPxIpJtl3SzIg+sUdqgeS9lhig8owhZRQWZjwLOrTpQnctxAynm07mRkrPShPF+u
 N5VO2wFoW7dLKcoO226ZqgHt3fTDyELvhco8x5CVQPm/UAQwotYMTiS9vP4602ac4NTo
 4ArLReGettbdxguVYLVjbhH0jLcUUoNeaigORY8psLVdHsvaQvO8+nFhwQaRXec8s1wx
 d4Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHXUUOrnRWC4QZkCif1gpBkJBj10epnh7pCzUqCrtGIMzZOWOJknkFwBRUDpf/lgnkXpEkdQM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9bdGMlBsWVhlk7IW5DAcTTzS4n4bdMWSyotPfdDI3v0lBiZ6g
 KYgyHMBf1eN+wzOeOD29ED/yfsXpLm+bV/bR1wG50O8d0ypll3cG9Hqd5764C0k=
X-Gm-Gg: ASbGncuyogILuIfnxarOdn3T0cI5p6FyDwAPx4EK9Pdjj5kVI5Tx4v2gRi/HC/8ZmdL
 1jEYputgM6e8Jkdwh+mJDR1ry27Fm4hqrMBiXcNZ/kpipluHGYEZMnFrFRHD01ulCeNtcI0Bdtg
 QZu+gP6p0G+hKe4ef1u4L8aYC6qd4tyBcxje/tEmawQXBKEgtkkAajrGxMdAu+52B5kfoqE0ttc
 l4xjPx6FznnGCpURiXjU9slLDbw3sdsUfpIai+ca5s5bH7Nzs73K2Ixb8qJTXgkIQx/xXwFwSzL
 zE/pqZY9uHnnWTNA7tCQLmKujaFFeD1q8Ywe4Kn5UGXNaOqN4S+9aRbw09CTNy5Q
X-Google-Smtp-Source: AGHT+IGjnPK4ZGHg31PnFkgfOroqx6n86/WB/qEpkTth3Q/EdMSKvJyQvNifIMjbpZgoHA3lIv7sJg==
X-Received: by 2002:adf:ffcb:0:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-3a08949fec5mr2859666f8f.46.1745928427067; 
 Tue, 29 Apr 2025 05:07:07 -0700 (PDT)
Received: from [192.168.7.92] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4698csm13868012f8f.62.2025.04.29.05.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 05:07:06 -0700 (PDT)
Message-ID: <c6ecbe47-9752-4d94-acea-64eae5d7a67f@linaro.org>
Date: Tue, 29 Apr 2025 14:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
References: <20250428215930.GI5495@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250428215930.GI5495@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Tom,

On 4/28/25 23:59, Tom Rini wrote:
> Hey all,
> 
> Here's the latest set of Coverity defects. Please let me know if some of
> these are false positives for example, thanks.
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Apr 28, 2025 at 3:52 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to Das U-Boot
> found with Coverity Scan.
> 
> 33 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 15 defect(s), reported by Coverity Scan earlier, were marked fixed in the
> recent build analyzed by Coverity Scan.
> 
> New defect(s) Reported-by: Coverity Scan
> Showing 20 of 33 defect(s)
> 

[...]
 
> ** CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
> /cmd/spawn.c: 174 in do_wait()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
> /cmd/spawn.c: 174 in do_wait()
> 168                                     ret = wait_job(i);
> 169             } else {
> 170                     for (i = 1; i < argc; i++) {
> 171                             id = dectoul(argv[i], NULL);
> 172                             if (id < 0 || id >
> CONFIG_CMD_SPAWN_NUM_JOBS)
> 173                                     return CMD_RET_USAGE;
>>>>     CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
>>>>     Expression "idx", where "(int)id - 1" is known to be equal to -1,
> overflows the type of "idx", which is type "unsigned int".
> 174                             idx = (int)id - 1;
> 175                             ret = wait_job(idx);
> 176                     }
> 177             }
> 178
> 179             return ret;
> 
> ** CID 550296:  Control flow issues  (NO_EFFECT)
> /cmd/spawn.c: 172 in do_wait()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 550296:  Control flow issues  (NO_EFFECT)
> /cmd/spawn.c: 172 in do_wait()
> 166                     for (i = 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++)
> 167                             if (job[i])
> 168                                     ret = wait_job(i);
> 169             } else {
> 170                     for (i = 1; i < argc; i++) {
> 171                             id = dectoul(argv[i], NULL);
>>>>     CID 550296:  Control flow issues  (NO_EFFECT)
>>>>     This less-than-zero comparison of an unsigned value is never true.
> "id < 0UL".
> 172                             if (id < 0 || id >
> CONFIG_CMD_SPAWN_NUM_JOBS)
> 173                                     return CMD_RET_USAGE;
> 174                             idx = (int)id - 1;
> 175                             ret = wait_job(idx);
> 176                     }
> 177             }


These two are real issues and should be fixed by [1].

[1] https://lists.denx.de/pipermail/u-boot/2025-April/588272.html

Thanks,
-- 
Jerome
