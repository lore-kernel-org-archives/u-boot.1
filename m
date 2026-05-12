Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49CBCD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC8484676;
	Tue, 12 May 2026 21:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iSlBAFas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FB983E76; Tue, 12 May 2026 21:31:56 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05959845C8
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de7c57b52cso4752150a34.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614313; x=1779219113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsmQuW2W/Kz/vPKNYOzKDEtqB7+PCLNfYoVbqgatGeY=;
 b=iSlBAFass+sClgEQ9luiEq31EQaIOQy65ACkp6DGWghZib78MrH4O94MjGTGIWO8dn
 jnRfBKhuA89Mu/qpmfWnRuLo6VQBs41+6bJ8Z8UYPiFPuMORL6YRDREllmzwP9h1Ll1i
 WgEieb8gzuEq5Xf4/vW4hf9iBU+/kovS6QrLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614313; x=1779219113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jsmQuW2W/Kz/vPKNYOzKDEtqB7+PCLNfYoVbqgatGeY=;
 b=ofsWp2jvmRnMsqFdoenycEC5vH7DJZBHi0UO+LjMLXDUXj+NsCv6SJLW4K6ttcOnZJ
 eUHHWzoig0EQg3bZXJQqiOBU9oTBIWD8F6G8TxkuWozPzlpLLiWfEcp62Q/2xMOg/c/J
 pgCyEbJFKj0cXh/K1SDsmuu90zrXleapOhcLX8gyrGKHcpLRaFIL8krS4Hxz4ztiHPGz
 A1igSB1SZSJunJzwpAcf+xjGoB9PhO/HR2qvKKogUAVBry2w8nhKJmv8+uggvYNSdX/c
 ZPzG7oslRhkSDmjXeNOnka1NvmTISPuRoBwVtmMeRrj0KUIrHrZoW/4lTZUuVu0FhTWo
 IA0Q==
X-Gm-Message-State: AOJu0YxJGMUurjmjNviN7fPpNfrBilIy/RzpYt3BRet5W5UT2IhKegfx
 FJjFyqR514faxFC8A9CzUaTcdmeXef46K8hdcA1cTodRCUyjVQmxE6f4WPnyAtBVsF8=
X-Gm-Gg: Acq92OFrwObHupa/92ngX2B8T2mfvuM85Q4O0y33NTxbkfGuNI1KujTaHONG/iMQq+b
 hlrkbhn8xyHHimSntniDYJT6mARD8POi95ccK3GLuZm6SefBq2cUr4Fvgf4cwAadWlnvcy2CXw0
 tfDvtmnba1M+fFgfmT7jLztFbOHfQ+b5fzC8m1zzrJOi+SSderVN3kdcvEpKA3ZPCZpioplKu9A
 neVDICdxcxcvaoiCHw0r6SIohmpiDFHecS48opVc+Uy1DuTGbxcmIkMKS3C36NhL9XNBeScaNZR
 de2SjBfw3TTFBd06MD3IWLndihH+cqJhNeqwXpkQRBbqQM+YGL3nmOuLyeuwKPbEr2mm8GU4SSr
 A8W7Kotvq/4/k9INJvybdQrk0cvi9Ilboxu/5S9M13Sksj6FoK9dWKGTxqG4GNTMkHFhjtyXp5W
 IcOcEquWO8uHKst7t9dAM6pOk6HqvnPW4/f/ZiYsMRHKSgjeaWs4g7efa6MmpvZh4B4iuG/D5F8
 cVZOttkcUkqAsLjlV4ud+Sx8MDilmU6dRca+C6s9gP/KpUX2Q==
X-Received: by 2002:a05:6830:61ca:b0:7de:5612:d420 with SMTP id
 46e09a7af769-7e3da427579mr39297a34.18.1778614312646; 
 Tue, 12 May 2026 12:31:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260507-apple-m3-support-v2-1-ce3db1c9e3ec@jannau.net>
References: <20260507-apple-m3-support-v2-1-ce3db1c9e3ec@jannau.net>
Subject: Re: [PATCH v2] arm: apple: Add Apple M3 (t8122) support
Message-Id: <177861431180.3279584.15928199975532924854.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:51 -0600
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

On Thu, 07 May 2026 10:41:40 +0200, Janne Grunau wrote:

> Apple's M3 SoC is similar to M1 and M2 but uses a different memory map.
> The main difference is that RAM starts at 0x100_0000_0000 like on t600x
> and t602x (M1 and M2 Pro/Max/Ultra). Otherwise IO blocks have been
> rearranged.
> U-boot's existing drivers are compatible with the hardware and M3 device
> trees will carry "apple,t8103-*" compatible strings. Only
> apple-atcphy-reset might need a new compatible due to USB4 / DisplayPort
> changes the Linux driver has to deal with.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: apple: Add Apple M3 (t8122) support
      commit: a1a47eee6763e61e184d4d0cda0a3cf0922a800d
-- 
Tom


