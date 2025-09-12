Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF87CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 22:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A518346A;
	Sat, 13 Sep 2025 00:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4fj4pJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9BB833F9; Sat, 13 Sep 2025 00:16:35 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE598341A
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 00:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-753b6703f89so1104910a34.0
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757715391; x=1758320191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRq47cRsWuJ8Wwu9g+0nEmrOjmyRnGkd5PJo8bkYfgc=;
 b=N4fj4pJE3mguodyBvdE0bdiSTnPop/xrcGSAltdbhS2apCbFSustqEpFzzCsHN6VdH
 0eq9TSJlHkqPvt5B2lQ7UYp5lnpvhuUy35X4NF8vZhCuSMDARa4vDiCV/uaJ/V7Tk7q4
 hPdLC366o2fMaM1CDBqpXbkxpbN3Myq/BoH7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757715391; x=1758320191;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRq47cRsWuJ8Wwu9g+0nEmrOjmyRnGkd5PJo8bkYfgc=;
 b=D4DJyWv5yEfDhIGKFSpxbPcFmX7rnZ1B+bciF1wBpL9SIwLUvd31znCbVn7GDE9uWr
 KYRqr6tFfv3v86eH8ItUSytiEJwZxx37DHYeBWlT2ox/xuiB8/TwF2vR7o7LAk0itTRm
 njoQSg/wbmsiB/FycOdyIZETjKvNZ3AaLZh1VHxoTicU7SUhcWEh4qL0wfRCnkTEpt3r
 NXRP/rYokiF0e/FzHWtRdHwg1qyUpCQsNmrzUdfTDQ7n90FGd3uqEkaJu8Qbusn+JdoX
 oyE+z5UI2E7j7whUEI5hOSfrG13BySoGnKJhTKY0eSAeqDaMOBJDl4l8ndIN+0Ec2kwV
 yK7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVo/M9sthzLVOHk9vhJl4pcRoiHne9fIrkTubSM7QHhNiV2vKMGjGKKrxE8cgklz7N9vJ1mo4=@lists.denx.de
X-Gm-Message-State: AOJu0YzWfviG2MnfOST2+UbbEK902N1Jn7zPda/VrQSEPA7MNUjQkCxQ
 uDWRLCxU3aged3xMTf4PFDOuTGCMYKmSVNAD+8YeWClRyD8if+QX6Mzq4EVx6zxZO4o=
X-Gm-Gg: ASbGnctQg937qNHS7slL9arGIx04SQp5yS5TB1bya7ha+YASfvyG86MykaaDw9FrpC1
 OUeGI1GzNqnhCslGzOiUfNPeNkFyK6Y/ACNaaNW7vqnJRC2wLRFPu93+8ITIhn15s5NUkqjh+lV
 Ia3o3n4WWWcINIVvCcUmzYMLRjSq//F6kv3W3hFJNUXF6v03CFp4OtIhDnPj1BEvyyo9EsxjrOs
 x2lybwFiVkNTTpxVdyq5cMya3YVTq9+SmaTF62aQy2Hc1PX/Oi6UfVOhqKhnmzl+TNC0kWh9XoY
 chN/+OKOof1qNGY+e2y2deFPYxOJO6g2jb2538fJ2ckZpZTFYoe47Usyr/Ne3FabCQyEY6620Ot
 HOUbwSFqkG7WX61Jn8AeruW7rZzocOUitYeryNzXDC0HUvheaaZTblMo=
X-Google-Smtp-Source: AGHT+IGEI1fK0FFOTidW5rXftUqD8SUfmJLU1qkWBtXK6To5fDYIykxeQWGmrpG7kE91kmG70c9pTA==
X-Received: by 2002:a05:6830:2908:b0:746:3226:c68f with SMTP id
 46e09a7af769-75352994eedmr2263400a34.4.1757715391039; 
 Fri, 12 Sep 2025 15:16:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524b8a399fsm1268326a34.24.2025.09.12.15.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 15:16:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Harrison Mutai <harrison.mutai@arm.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de
In-Reply-To: <20250901151635.654928-1-heinrich.schuchardt@canonical.com>
References: <20250901151635.654928-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] bloblist: use correct types for physical addresses
Message-Id: <175771538959.4138777.630889634118292258.b4-ty@konsulko.com>
Date: Fri, 12 Sep 2025 16:16:29 -0600
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

On Mon, 01 Sep 2025 17:16:35 +0200, Heinrich Schuchardt wrote:

> It is expected that bloblists are stored in high memory beyond 2 GiB.
> We must not use int as data type for these addresses but phys_addr_t.
> 
> 

Applied to u-boot/next, thanks!

[1/1] bloblist: use correct types for physical addresses
      commit: 7e2c23eacd8e6fe76306ebf3cd6e31d52695b617
-- 
Tom


