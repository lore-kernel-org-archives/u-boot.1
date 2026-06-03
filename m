Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD26CD6E69
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906088486B;
	Wed,  3 Jun 2026 19:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VJv2d5nF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0511E8486D; Wed,  3 Jun 2026 19:43:15 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF9B3844CF
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8cce20d2cbaso10020986d6.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508592; x=1781113392; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2RTcWeYKf2xqSQCgramjwKMV1Dd+OwK9QI+gC60KlY=;
 b=VJv2d5nFk2e/72b4J53+RlX2EnIUIErL60VszcBCnbMBz2AgxVbyIOtyEW7RuMYV2q
 kFIhVQf173OoRe7DHatDHZ7dzf8EHsQj6UmtUujWCl/09lhF/NttK8KPXcOjJ0ySCdEP
 gtR/sW0rw1ZdO0/AfOBXWa/B9c/CWcqGqtP4SXsfzk1xnqb5F1WWGhyuNweZ+/3/+baq
 5rrzi31C3a+ADUDgLSxnfxC8s3Od3Zl0Gv9EPcDv0LVShTYYiiIih4NOBJiZI5M7lRt2
 D72npVah//9lZCmkkNW7fhYd4Lpo4YEwV3tA9O4EilSOmlwfRf8EQdoVbDXGRM3bZ7dF
 Wfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508592; x=1781113392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2RTcWeYKf2xqSQCgramjwKMV1Dd+OwK9QI+gC60KlY=;
 b=d6QQ5mBoVPsZ8URxHfxMvjVCR8gJcsRmaH4XmdIFrgMJQ23WV29am102aKLqjqanFW
 wX1T/rdzEbZs/WCRMhu67OvXmXgGKoYNWp0kHM9kXUFdTMW1X+mCCP9+ze1094ebeTBN
 9UI7PItUmEAegOUqMVrB8RJ4gU8HKDcGhOdf4Rj9ea5XISsVXQRkWAF8OcehbX5btyqe
 jEzDcs79G2wvJlS7Ru/4WNW3JK4ul6QmvjDrPJyCoy0fOU5Wd2umxP8ri1RD8GWxm+ja
 FeHe7qWilv3JP/KVnf5RK0lLwq0ocNQWdU6K5nnTa5w6HPruUiQuwOI/PnoDKo14Do+W
 xjNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+C7tgVYxp1ysicJS0nhXQb8g8ZYdsqLwJaQU/+4YlsSPUboqJQRQmNPUmxQg2djTmE/OMylpo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8rz0Ytb+8xnTI5hpicJaiqQeywtd68kMa4xaRRxNennG5yVBI
 ULuHNoa0DwYz3Kfgwmz6Ql0u4/GxjEKwJB3e1JBLjh+5++eqSPAxlANL
X-Gm-Gg: Acq92OH3BI+DrVBGj9+PYvwbF2Czg9HE6d5cABSL7n8Q84tzRBbj7Ji3+YQaYjRcbss
 d5Udjuoi1FTtTODmIH73zWQ+WCVyy5cRxI85t07C3+612+yuQ2em0NbIfK7olLbFxgsblFMdHqa
 TI1uynELYN0/i6aaa00vLlrrzDz3A5gbj95QAsbFHssZ5Wgne27S4TfZ46uNGwzUaSILLIvRL/S
 Nna/f+jh8YngxE4sMy4NN2KLkW+Eix9xZSIGZqtGGE41Hh+Y/jAQrjBqlFCbq71RWk2ZMvA6Wge
 Vi68Ueu2FCE4Bvv0XYMYDu8iSlDUB99+UTEIkCTT23ZDeS0qf4ipggBJ9QX/vMzFRY6oRlahSHy
 ZsP4sAR/rvReqjwcgxmIQjTmTs3PGjna+xvPEu2XaOreomhvO3Vl55ql6oAXhU23hMUHXA3RiOV
 3ryVrpwAKVudAMvFb7/l1IBJRmKqaHqE8LTdk7JjnRcsQoNB0ojmkAqvP+Sf8TKQOlxjMoxrAuL
 9ju71b1sA==
X-Received: by 2002:a05:6214:410:b0:89c:5fbe:cc5b with SMTP id
 6a1803df08f44-8cecb031d6dmr53433186d6.0.1780508591576; 
 Wed, 03 Jun 2026 10:43:11 -0700 (PDT)
Received: from [192.168.1.143] (pool-173-66-184-60.washdc.fios.verizon.net.
 [173.66.184.60]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdb9fc0sm26354576d6.17.2026.06.03.10.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:43:11 -0700 (PDT)
Message-ID: <757cf33e-0a87-45d1-29f5-aac6fd5282c3@gmail.com>
Date: Wed, 3 Jun 2026 13:43:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/6] cmd: Add flush support for all blk devices
Content-Language: en-US
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-5-dmukhin@ford.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260529034441.2075305-5-dmukhin@ford.com>
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

On 5/28/26 23:44, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Introduce `flush` subcommand for all blk devices to allow committing
> dirty data explicitly to the given block device.

Shouldn't this be done automatically as part of blk_write? Similar to
how all FS operations in U-Boot look like

- Mount FS
- Perform operation
- Unmount FS

so the FS is never in an inconsistent state once an operation completes.

Is the performance impact too much? I'm just concerned that a lot of
existing code assumes that blk_write is persistent and that it's OK
to e.g. immediately reset after blk_write returns.

--Sean
