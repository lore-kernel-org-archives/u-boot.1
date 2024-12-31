Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4D4E7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 21:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7578039B;
	Tue, 31 Dec 2024 22:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M0bnBdaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9FA8039B; Tue, 31 Dec 2024 22:17:40 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3A580383
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 22:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467a3f1e667so59194421cf.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 13:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735679857; x=1736284657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeK8MPIlEd69HtFXlZrTDnJs4RPOlTJuyYIGymIjz7M=;
 b=M0bnBdaTPS38SqJzbj5B31pkhkIKT2r7kOFF0Z2XCOA22wVEUJmfp4KxTnq48NDyAR
 MPwR29Ls6dFCexIcd4Qi5GRKvmySgbSCUH5KsBf9WJ9nQL+33g+bvzPW16du9RVGA+hN
 4v5iCx044eHZCM8cTDqlXWqZwdb3cmXaI9aVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735679857; x=1736284657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeK8MPIlEd69HtFXlZrTDnJs4RPOlTJuyYIGymIjz7M=;
 b=f3WOtwlq2/mQlXBN676xTHY7tmzTGYjt6Zlz+TBIIWACFYw+33Jut6LirSV/gminLZ
 Z+/MkMCzbh+krq9MEXiaN6UfYV9FKBu5Q0nxaFH4TlXbAvAI8wAYHXEm+j1iL2mSC7eF
 k/bMe8NWXhziwV7XCLev9BKbQvcAHMlJzy3ZBIDSZAV3BCFU56LbhIKXfKna0DNuHuS+
 lGIDW5ymfQeUlPw/vr96+INCAE8w++42D0ALohnxZICD8YogLcrAG74CnAPwlznuBWr1
 QbLjo+36W5PiO8WXNXtTxukJjUJAomxtaw2HjK/4a1rlj+zjNnj3Mi+dabqTKAnY5IFt
 ZyiQ==
X-Gm-Message-State: AOJu0YzoaiZ5U608lY4E/lzV4WqBx/5Q9cTUIuWeX+icXRCI778pbyfF
 /ymvKqMq+MVd5+M+dd7WkcRy6VsTpeupDFfFBrUdZgZYN87u32M4RtKXPrIQTCo=
X-Gm-Gg: ASbGnctTov4VlzrvzO9UldRt2HsD6Os8nnRy9hMq6ssFLHk1hW/Z1RdrNpAPnZEGDef
 aDay+N7aRZ0hpSNnVJ5qDX/9rKe7Hr39D+XyIo1P29nbU+MxT60jS+2pds4WQGMXRLeUI7vaiZL
 m8Kir7NLSjsm4oQSAuqD4OUCuf/0EBs19SaBSRU6x5tqsWBlvMs+//CYMWS47FMcd1CuPJXBPiH
 P9hHoHBCmrLqo6ZKeU0jAdia2zYTfjRv3Gr5c3dPhoe7WJogROOql1p
X-Google-Smtp-Source: AGHT+IEWpkQsB5yWabVgXUFUIgZlZOWeBDFdUKnv61Vuk9n3eostUqYnm+eNIeXQjg1Ke8cEjXzIWQ==
X-Received: by 2002:ac8:59d3:0:b0:467:6f59:e343 with SMTP id
 d75a77b69052e-46a4a8cc56dmr556229971cf.21.1735679857057; 
 Tue, 31 Dec 2024 13:17:37 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e67e280sm118864031cf.30.2024.12.31.13.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 13:17:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
References: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH v5 0/4] Select CONFIG_64BIT for sandbox64 and x86_64
Message-Id: <173567985335.373695.2537032004287225791.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 15:17:33 -0600
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

On Mon, 16 Dec 2024 18:07:32 +0000, Andrew Goodbody wrote:

> Picking up a series from Dan Carpenter and applying requested
> changes for v2.
> 
> I had previously set CONFIG_64BIT for arm64.  This patchset does the
> same thing for sandbox and x86_64.  (Mips and riscv were already
> doing it).  This CONFIG option is used in the Makefile to determine
> if it's a 32 or 64 bit system for the CHECKER.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


