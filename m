Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D29CD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 23:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF62849B7;
	Fri,  5 Jun 2026 01:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jTKNMKxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BEE3848BC; Fri,  5 Jun 2026 01:05:07 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3938493A
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 01:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6e41cf7aeso690971a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780614303; x=1781219103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7A/WgqZmdb4jwTEYGYuNFyqz1+o78LrXMC22u4rQWo=;
 b=jTKNMKxLePWLiykxEWDstE16f3AXjEIU2W+Ei2BIW9RatnSK8kee0/OPzK8n4u8L5v
 Zg9onlqOgHO8TlMuGZqj6bSIfDx0ZgEy7FFqfKT5T/uD3lo+x/C0U3bcsxAp6LM6i65l
 1vIO42srPy6uJZU9zhvzxTH50Mfvs3LB2r7B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614303; x=1781219103;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g7A/WgqZmdb4jwTEYGYuNFyqz1+o78LrXMC22u4rQWo=;
 b=puRdrbSEFkPgtYQfUeauGvniieHMZLkWKn+OyMghhmgwnjviU4YDhWB03CGAiu/Yk9
 BCTv4ADSJW1YiT9VRv9M7CJr5u98qtiuymbOsWBpTKsNo08lIu4PFaJAKodXIoBU7Hlm
 h4TWmQMf17GX2+6DXrYdjv6eceQxXZ6/whgQ8OGFIuVdGwtYVA8PYzSpni+B8yO+Op/e
 J7Dzp0ZArS+tCVvRJdQeQZE9iUaLlx4Vqnush7COlOtL1KQEPOs5HLgj6Pn9402BggRP
 6MjyweRf4WWhIWViabSsiPa9HgKTmOgsUEgZD9ZVZ2JrKlpizNkZmRC279aykFdCDHYx
 DPYQ==
X-Gm-Message-State: AOJu0Yyh4/P107iWe9mGsmJRW1Z/sasubn9elRTxH8peResb78gyUL8w
 PtKbi5QfJ80KUe+nKDjaA0JLaJ9l5RdAQGPbWoHjoxtXCFgx0Thj7uW6YWxzDb2dvWQ=
X-Gm-Gg: Acq92OF3lhelDFcqDoKgGnNj0zj4SvGlcf5wKoZxt4Z6H6PXj8ZYTkHVVBT9cAlUn9I
 85ljKV+BVzKGbDelpr0vGIjZTN778gwS3R2irAztIIdAQEt3nYJZHYbj+lGpVYugJZJYf9NAIgn
 uPD7SqNJfOMYWQJNHlD3tqI3vJjziaRYAPOVp4FttoXDXXqdF0m44XWPq5Wkt0M5ryNZRqTMWmy
 IM/h8FB+EGdE8hY8+ED27dntz+0rR/9kRmFXi6Qz0qsTQpCQzrx0W/jCNZF3t9I1FM2Qm3jrnro
 VFHusRo017YuBKvP9prPbwo34LSp9fqknTQzdYVrWE7U59lw6oZ3uLU/6ogInKp5KdmkanndSDE
 bNz7RTTRCrC2iZ6GUqBojkxXtxI0rASzLbHg+Tfi2i1phDhB67njfLzL6aZfhhoBMDr272Nd00F
 cPagoH8/cwh29awhvDfPZxboMRgrGVweJdv2016TRX5y8Y9Id5EhrzAujPwZO8Bd5hxndgRvDWo
 EJlp0tjSPiyRGfjZCNI+Zc3kcyjGJhu9rR9vJGiZEfdaFmhnlb53Lsmy0RB
X-Received: by 2002:a05:6820:168b:b0:69b:93ef:f457 with SMTP id
 006d021491bc7-69e6860977emr669215eaf.0.1780614303610; 
 Thu, 04 Jun 2026 16:05:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46298798sm4167477eaf.8.2026.06.04.16.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:05:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Caleb Ethridge <caleb.ethridge@analog.com>
Cc: malysagreg@gmail.com, philip@philipmolloy.com, sjg@chromium.org, 
 linux@analog.com, jcethrid@gmail.com
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
Subject: Re: [PATCH v6 00/16] sc5xx Environment Cleanup and Fixes
Message-Id: <178061430237.146358.17618976466469044387.b4-ty@konsulko.com>
Date: Thu, 04 Jun 2026 17:05:02 -0600
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

On Thu, 21 May 2026 09:53:11 -0400, Caleb Ethridge wrote:

> This series performs a general cleanup of the default U-boot environment
> for sc5xx boards, stemming from the decision to no longer store the
> environment in the SPI flash. The environments for each board have been
> edited to contain the minimum number of commands needed for all supported
> boot modes to avoid confusion, and the default boot command synced to spi
> for all boards that support it. The filesystem for the SPI flash has also
> been changed from jffs2 to ubifs.
> 
> [...]

Applied to u-boot/next, thanks!

[01/16] configs: sc5xx: Do not store environment in SPI flash
        commit: 5a21396c9745f2aefbbc5adc0867e3ac29c85edc
[02/16] mach-sc5xx: Remove update commands from default environment
        commit: 77c79a2c60fddb0a394289d436e21148371260b4
[03/16] mach-sc59x: Add CONFIG_SC5XX_LOADADDR
        commit: e4b04e491fe7d78ed1e64974832bb79d2d91a7a8
[04/16] mach-sc5xx: Update boot commands
        commit: c1fcf76863700270ce10dceefeb72017e991d627
[05/16] mach-sc5xx: Switch from tftp to wget
        commit: 3b9b94ef68c6f3a1466a49ff4c482060923aea1b
[06/16] mach-sc5xx: Add USB boot command
        commit: a29a895bdce9e64f4e0b68ecad44b48927c5ca86
[07/16] mach-sc5xx: Remove preliminary binman support
        commit: 78e5581f0bc21b916763892cbfd89aedac356459
[08/16] dts: sc594: Fix gige-reset line on EZKIT
        commit: ad72a93757d3eefcfe9fecf27b1d8f000be49f2f
[09/16] mach-sc5xx: sc573: Rename EZKIT board to EZLITE
        commit: 87ea6e67959099804faf4eb85d93a41f18db71c9
[10/16] mach-sc5xx: Update image load address
        commit: 4088df81f10c43f5585516342f5963d19cdaf3d1
[11/16] mach-sc5xx: Update SPI bootargs for ubifs
        commit: a6438a10267e52898448711281ae631945b87e84
[12/16] configs: sc5xx: Set default bootcmd to SPI boot
        commit: 21eeb0176bbc009aabc629e89c6c0d42266e8430
[13/16] arm: sc5xx: Remove SC5XX_LOADADDR
        commit: c6796425da45f63661459e31cb7809f517080417
[14/16] arm: sc5xx: add missing boot env selectors
        commit: 03398e94314734f9f095b14fa84893e35365d41e
[15/16] arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r
        commit: 54026efab1070f6077828a96ee99fcaf778a0988
[16/16] mach-sc5xx: Remove unused image offset Kconfig options
        commit: e8c00a5e2834b5c80930b1f3dc0d65380b927ec2
-- 
Tom


