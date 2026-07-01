Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6627EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 19:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DAE884C40;
	Wed,  1 Jul 2026 21:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WPF6/IMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3368784BE5; Wed,  1 Jul 2026 21:32:14 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA5F84BE5
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 21:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4471b489240so336179fac.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782934330; x=1783539130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSOvWc/zIG5cP6a6vNjPZ2Z5nA2lsYUX0SEs6zZTLqg=;
 b=WPF6/IMO2fAzQbcXn2FDlPC0fmSYV6zJ03wcGcwA3pIhM8KGa7xqjQOLkgT879TidH
 uwyEEtFMmp3qLJuxs5ex+b0FW4ZtCy4L9YFmeS+rlEpccymHLMY8DrYbLCgEHFX2xLb2
 YO1R9moq7PlzZFm+rpU4jCPpz2p7yeIqp8qow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782934330; x=1783539130;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tSOvWc/zIG5cP6a6vNjPZ2Z5nA2lsYUX0SEs6zZTLqg=;
 b=SdmCEAi8oR2ciomf2E/2fUFSOdb4MgtmdNx0/2vybDxS46kJsgtadBmINk9czz0b2i
 AiZgKRMicVSqRBkYQ4sj78wMXv7JRwsXtTlCzR9paH1kkBMmcLw4ClAEK4TrbkXjyT8K
 oLe5fMsi4Q0js59MfjOqJkFN88k1h/fyIIMdi/0Jdl1achlrBFwrblizKl7mYiLoDKyV
 kmdSKlMXOvIBWTtiLKTGzT6hKgyHzL4dQjRDHLB+kJUTXq72613KVMgqhi7f5chucwif
 6PRHgUu5zZZj4f8SleTQBQBTm6SWQg0DotklMZSTmItR1/IBkZGA07zP9ooNArqtVtUb
 e7dQ==
X-Gm-Message-State: AOJu0Yz4kTxcMD8Cqp8BGt+RdWMHrFRoEbG04KV/QATMWCg5XkufI1tp
 87aCVNqPP5H3AbCbZXl32oKJEr5vUZi4trNXdEld5FWX0qYBewFzvpnirAg+DaMCOOSt+FAe7V/
 iDMLewnsQAA==
X-Gm-Gg: AfdE7cnw9o9QPD5tkOTwZwgfL0fPZ8l9IjEPzjT4UhbAxff5uizIBkFhy8NjMI/2USF
 0GuEUc+vhhhfig+puhWIR485FQFHHYURPzQMYVtlEL8JecyFQ3N4I8r6mpeulveUaBv37QpFrWF
 Ew4s0GERj8hD06iNKH9iwNisC/9GILCvx3XNGMaEzX6YaaxVq0jRSZkH7X1qBF8alJqFMWQ0nJ/
 YwjvrvTCeIdyR+j1NfFVOdpVF2fXBtihoSdIkrlpRXeoln7Sp+dV2C/v7dljC+cDH0NmuAmUABj
 D5p6lgPcg5JkiqcXeLkx2VaS4T7LjNgZ4FfY4ccxK5/cpnDZ1zQRWtiYHayWHTwDcH5+Ohj754O
 7MP4OiBi3a8v758lFyQj2DsoU+qLH3BQ0B2FkvhXN5prlGSwU7gwlm9V6KDByEggx9hXUGNuird
 5cJBzt8NvUJN/tubgJ3sn+ntid0GKQ/qo0GNKLf3yI8giKlr+mERKrxdk8FiARyFwGpPlOjjgG4
 dAvj34FKunmat0bcp670VsGo9XtH9MlEbx8
X-Received: by 2002:a05:6871:8306:b0:448:558c:d824 with SMTP id
 586e51a60fabf-44cab9c5c52mr1824855fac.39.1782934329954; 
 Wed, 01 Jul 2026 12:32:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbe84f609sm712763fac.1.2026.07.01.12.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:32:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <ffd467e0-491a-458c-91c7-7d2a6403083b@linaro.org>
References: <ffd467e0-491a-458c-91c7-7d2a6403083b@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-pci-next-20260701
Message-Id: <178293432921.2600701.5251130656918155416.b4-ty@konsulko.com>
Date: Wed, 01 Jul 2026 13:32:09 -0600
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

On Wed, 1 Jul 2026 11:54:11 +0200, Neil Armstrong wrote:

> This my first PCI next PR, updating MAINTAINERS and switching to dev_read/dev_remap APIs.
> 
> Thanks,
> Neil
> 
> The following changes since commit 5602e89a834ccbedc686053b14206c062a144107:
> 
>    rockchip: sdram: Fix initialization of DRAM banks (2026-06-30 13:38:12 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


