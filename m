Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF4BC2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 14:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A504A8753D;
	Mon, 20 Nov 2023 15:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j/Qrxt8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8D386FDD; Mon, 20 Nov 2023 15:04:34 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C22A8753D
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 15:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d0c777bf0so13268026d6.3
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 06:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700489071; x=1701093871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1meUJYIQSqoxEHM187wiBaGjKu8cMqa17nqCdiuCbI=;
 b=j/Qrxt8MySqVvlRN0rCQ9yAm5UPHs8ce1UlLBnHcAqIDxmHcj6ulOVXaRjnIDsXZnk
 +BalC6hT8jvh9tTpQIzzIhvzpF9VSLCHmhNT3KqE7gh84DFGFAsGoj5B3oDHnLwARILQ
 3K+EZiKHOcrePygUr/f7/wMzqVD5r83n8tyOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700489071; x=1701093871;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1meUJYIQSqoxEHM187wiBaGjKu8cMqa17nqCdiuCbI=;
 b=qYWBfE1rVwqqVhzK6TAjLshS23OAzD2mHVCnLBOuaRO9jzLLdJSfISlYjRJFLjczmn
 Qwih85v3IBaNkYefawZY/jhQwQSLyOPdL5Nvpd+5pujwnvPOnSRFFLaFyCRLMAx5sCIX
 6PFA06wmr5nALWZTqygLKgn10tGL0nZnTSop5kdWCI7DHYj7K0ndeKcBc0sAfpb2plT/
 k7/0ZkUF/s9ewjMVLeRCxbXgReksaFGlqrEJWrz2PbwyY9uopRq4jhIcq9a2nY/uMUqF
 dA9hw+4vOK/y3aon9xwsEsmYtufuObAVlnDdYT8yA8kqsb53N5+GfgLFW+r8Wr6dqzU2
 Ul9Q==
X-Gm-Message-State: AOJu0YyQO+nLT93lHIxjM05JnhXYGPZNPmnID4GD3CKRHXadSdVN2z75
 F3OG/kAq1YejtafjZuRUgj+6PA==
X-Google-Smtp-Source: AGHT+IEtlMhGa910ji81sOFFiGTg1/O9x9O317psrZuVSWmHY2CcXkvFskS8zM8b0yYEfvhJBspKmQ==
X-Received: by 2002:ad4:5ec5:0:b0:677:a9b6:fc89 with SMTP id
 jm5-20020ad45ec5000000b00677a9b6fc89mr10068873qvb.59.1700489068032; 
 Mon, 20 Nov 2023 06:04:28 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-6bdd-4a9c-acaa-1ce1.res6.spectrum.com.
 [2603:6081:7b00:6400:6bdd:4a9c:acaa:1ce1])
 by smtp.gmail.com with ESMTPSA id
 ct2-20020a056214178200b0065b0d9b4ee7sm2907484qvb.20.2023.11.20.06.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 06:04:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20231113055102.4041946-1-nikita.yoush@cogentembedded.com>
References: <20231113055102.4041946-1-nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH] scsi: set dma direction to NONE for TEST UNIT READY
Message-Id: <170048906731.4041938.12989779656591382177.b4-ty@konsulko.com>
Date: Mon, 20 Nov 2023 09:04:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
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

On Mon, 13 Nov 2023 11:51:02 +0600, Nikita Yushchenko wrote:

> SCSI device scan code was executing TEST UNIT READY command without
> explicitly setting dma direction in struct scsi_cmd to NONE, so command
> was passed to driver with dma direction set to DMA_FROM_DEVICE,
> inherited from older usage.
> 
> With WDC SDINDDH6-64G ufs device, that caused TEST UNIT READY to
> return error.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


