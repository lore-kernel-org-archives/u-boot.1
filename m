Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48004C07C79
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 20:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC749889E9;
	Mon, 22 Apr 2024 22:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="b4lk4QDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9A31889C9; Mon, 22 Apr 2024 21:44:05 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F04A889B5
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 21:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dbarboza@ventanamicro.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f26588dd5eso1887194b3a.0
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713815042; x=1714419842; darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:content-language:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5kOw1Jx+Ez1acgV90ifnmZkZPPUCcADTMhG8thU4QM=;
 b=b4lk4QDeY3A7mOYnV+FaXN60xIQ1ob5KqvJg4u43n4VRMhYCDqA/uKnG2Ay0IZ94vT
 vhJNVvbW4Dnow53ZXMjAwz3BxoIYrq4DHDa7zt9XykL49DeRSYS07F915yPQrh7ZaCu9
 MUxtprQOrQYvcItZM7iGCPUiqbbM2Qv5opQ78eq4YlpC7cST/Ip+Ti2p0YZ8k4poztCH
 06ZKsVW+PTseaoJqoWA2Q3w2J/N77vpIXPR3ZPDtinGssZBtJe4nDLLBtBP22tMT8Of5
 9GLoHND8TSEk1Y/pbk4fYjwN7iDmEDM58gqPMJB9OXBQL3RbB7r/gcZqDRx2QhygKgpR
 cKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713815042; x=1714419842;
 h=content-transfer-encoding:subject:from:cc:content-language:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f5kOw1Jx+Ez1acgV90ifnmZkZPPUCcADTMhG8thU4QM=;
 b=e/7bWwjsrcsBd81ev+TZ5oYqZs751jP/p1Wsx54OiwuluTGNamx+JZ1P4gKni0ZLSE
 rnJJ03ZZqX5Y0UDv8x8oKPKRovpbmE305dtNfCKSGqIaUWcteFSCuvuUhrgMVl1gKzQR
 UxgDb9WYjL3juN7JWGPrWzPaiWf5XFoeS/fCic84CbOWOXr/ymewW1fNu8xZixhetmVh
 N0v+xNLVyGlVfoP7+Xrv6ERucuf31+S9oBz5I6FWYbpBX4BzNFIe/MDIu6GqBvsBsYUB
 IQ43eRe+U12fvGNGnsh0oOEJ01D0AD0rN9rFL15llnhDlkvTxedHT6dzC29E7TiUm9mB
 8DiA==
X-Gm-Message-State: AOJu0YzfC0+4mg5IM0pDXmvUlvkywxPwm2Y9q5wLWoe8gZu6luKzKzd3
 /mF6QaoRmCs4U2cv5xEF3wRiqfJQfII//yMDNxTAeg6HL959Q+ZvsC1ccqJxVEmP+X+bqdH+0kU
 I
X-Google-Smtp-Source: AGHT+IFHkJ9uXe15XsIqvnERnVs1AsMhRNQhRjydGquoAJd4kZ7Rmv2IdgL4h/+lGQwh3TyShE7b7Q==
X-Received: by 2002:a05:6a20:9c9a:b0:1ad:6e4:db70 with SMTP id
 mj26-20020a056a209c9a00b001ad06e4db70mr6471366pzb.29.1713815041626; 
 Mon, 22 Apr 2024 12:44:01 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:4196:f8dc:1a46:f594:fa63?
 ([2804:7f0:bcc0:4196:f8dc:1a46:f594:fa63])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00218300b006ed4aa9d48esm8161306pfi.212.2024.04.22.12.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 12:44:01 -0700 (PDT)
Message-ID: <bed7e137-4613-4153-babc-3b8b7c911151@ventanamicro.com>
Date: Mon, 22 Apr 2024 16:43:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
Cc: Andrew Jones <ajones@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: RISC-V u-boot unable to boot QEMU using '-cpu max'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 22 Apr 2024 22:02:30 +0200
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

Hi,

In QEMU we have a 'max' type CPU that implements (almost) all extensions that QEMU
is able to emulate. Recently, in QEMU commit 249e0905d05, we bumped the extensions
for this CPU.

And after this commit this CPU is now unable to boot a guest using upstream
u-boot. Here's the error being thrown:

qemu-system-riscv64 \
         -machine virt -nographic -m 8G -smp 8 \
         -cpu max -kernel uboot.elf (...)
(...)

initcall sequence 000000008027c3e8 failed at call 000000008021259e (err=-28)
### ERROR ### Please RESET the board ###


I can get the guest to boot if I disable the following extensions from the 'max' CPU:

  -cpu max,zfbfmin=false,zvfbfmin=false,zvfbfwma=false

Due to QEMU extension dependencies I'm not able to disable these individually. What I can
say is that u-boot isn't playing ball to at least one of them.

Is this an u-boot bug? Up to this point I was assuming that u-boot would silently ignore
hart extensions that it doesn't support.


Thanks,


Daniel
