Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7532FEE0AF9
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 00:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E64783C61;
	Sun,  8 Feb 2026 01:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pZJLi6S7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F51B838FA; Sun,  8 Feb 2026 01:27:54 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCD983642
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 01:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7cfd9b898cdso1941670a34.2
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 16:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770510470; x=1771115270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7+mqejRjV6GY5IG06Pi2g9A0EWHHlINkqRV0HCJ9+4=;
 b=pZJLi6S7c2HpaoazPrA18rS7+XqaXo/dNyWlUesk1DyjpDB9kTv5bKOUgXG7QALdQO
 +KTLzOwb4l4coBHM78fdMBCVdO37XvLr+zF0h9XVIy0Z0We0XQl/D+jUVzdabheHWJpo
 zRHwW32vsjAash/IXx2a/6/W2EewrA9B5bFfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770510470; x=1771115270;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7+mqejRjV6GY5IG06Pi2g9A0EWHHlINkqRV0HCJ9+4=;
 b=Lul0CW+1iZeXw0IGnbEZSRlrB8hrevZsU9mavMT5yDAGAVkLM9qhThNQHWRgJRpG7+
 pJJ7w51ZFZDZFvp5dO4y9wy8gyBfcOqBwCZmd19QzyeMABjvdvd1+07Or7IOluUqp3Jn
 HmgCks3WGxN4Rgo3jnxXjstEUEMFIfrH+8J/FMky839gSpQPr4JShExmLfTsKSPDe85N
 ZfPEM+MxTTURkH8ROvgwWR5eWVZIooRejeyOexd6BPp8sKNAFjwpWG+2BKpFjiG1ZS3l
 w0YKfvKanE4McdVcZiSmLRbcpqQ8W7TZVX6SrVAum9AB1VpEhtVmAEvdm2m9p/PnKDnX
 eb5w==
X-Gm-Message-State: AOJu0YzGMn/qJrHn0jS5yVuM0HteHvIxPbW+grRRJWeakaZ3Uvyux4um
 tTe1CVSS8LFgL/JhiC2oVNsMKje08yHRPRqFeNUHwKdW+DEvB6F7lEYSSUwDwyrzBbU=
X-Gm-Gg: AZuq6aKKbb53NCOi0VbZN//TGaJcCtfXYoNvrTZKVnD4HqdMbJ1IR2VcM8cvJ+OMoKU
 jrcKYCxe3zJgEfS3pX0Te1AeaB0BYhzPLphH3W+BblWhNwokcf22eD1IIYpWwz/Op/eFNmzfoii
 XcfTnKXjQxui/BnBaFeAo0qrLRNC5hcnb82BlvfU9kxwa7gaBAS0Onb+YWZ8UBTuiVDH5WgXdjO
 58/HE9W16MRxjjZHY5Z/YlTjmOjupjVDe/MKGw/rxxK4H1jIyqDZhknfz7qJ4adPYW/R4nU/1lC
 DlpGzgtzNLB9M4mvbIlm8SUbuxRPOE/i35iurUBRGF4J6mFqnGOFY6cz37AyWGHKn6rUQqK6jWt
 dICscv9yvXnxg5J4oEfGv0keoKc6eyIOdKIzvPuAJ8Thh9aVbthmfLD0HSsnjutI/SJhCwGouOc
 ejzQgffKzqU8jMZ+P+Y/TuNbZFuhZ4iYA1M2NbZYqjGvSavu5jrmS/6mJFI1wI+0ZWkSUGHXRZW
 H0mdtodYPuw7gCKLfrakdGAoOxDeKKyilZ1TQ==
X-Received: by 2002:a05:6820:1c98:b0:662:f746:5728 with SMTP id
 006d021491bc7-66d0c6666aamr3095181eaf.60.1770510470415; 
 Sat, 07 Feb 2026 16:27:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d3b2a6c16sm3552448eaf.16.2026.02.07.16.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 16:27:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paresh Bhagat <p-bhagat@ti.com>
Cc: praneeth@ti.com, vigneshr@ti.com, bb@ti.com, afd@ti.com, 
 m-chawdhry@ti.com, t-pratham@ti.com, nm@ti.com, v-singh1@ti.com
In-Reply-To: <20260128005453.1387483-1-p-bhagat@ti.com>
References: <20260128005453.1387483-1-p-bhagat@ti.com>
Subject: Re: [PATCH v2 0/1] arm: dts: k3-am62d-evm-binman updates
Message-Id: <177051046902.295305.6059020547616516061.b4-ty@konsulko.com>
Date: Sat, 07 Feb 2026 18:27:49 -0600
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

On Wed, 28 Jan 2026 06:24:52 +0530, Paresh Bhagat wrote:

> This patch series updates the AM62D EVM binman device tree configuration
> by fixing references.
> 
> The series does the following:
> - Corrects device tree reference to use AM62D-specific DTB instead of
>   AM62A.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3-am62d-evm-binman: Fix device tree reference
      commit: c7fbe028ee5bc83df833a73e1491f1a483b65d98
-- 
Tom


