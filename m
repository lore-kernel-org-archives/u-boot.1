Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9F4C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0581781E25;
	Thu, 24 Apr 2025 18:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/skAspy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E89481E72; Thu, 24 Apr 2025 18:43:47 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A597381F0D
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72bceb93f2fso1367393a34.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513023; x=1746117823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THMfupkigT8/iTIsVe9wJ9lDzhwFhaSNuFw2r/Iwqkg=;
 b=X/skAspyc+XRtR5welyZWX5Cj8+HAS1sshCw2ilAEKS3EnjCYsE3URkkZ3ar4/Flzu
 eYf+IqnspcF52f6DbxJ0NkHcjvakKcBsFur3GSFpl2jtLhdlNNoaBNGA6eotZHC53mle
 ZPdIQCESPijFcuoEwVJSSfLG1ucQPIyIUP1No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513023; x=1746117823;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THMfupkigT8/iTIsVe9wJ9lDzhwFhaSNuFw2r/Iwqkg=;
 b=lWBjAonua1S2i/E3YjRKjrGZRb5/OlNbwaLV0x1jHgJuZ4N6Es29VCY69WJtLUvgtw
 2gCTotwHTXe4bRjRPf5mazFORJW25I9SytNgob1zm6wSRq81xzTENdLaflnEMfdqsg1C
 cai9tpOzN+u3xll/7kUWxCGuvvSPFRwSkuPtKcknXL7ggig66B9aqAD3Oe3CT9plNVet
 QeqVRHzqZt6h21FSHfIxyamaHPsgLvBeoQq+UkjcXzf92trl7pFPavt3RrAzdoBjM7Ak
 wxly3kHSc5wh/pCxWeFwJuWVMf5Xq8upb3ZJMfxBSs9r/u4I1gXelfz5qaDDJg8rdZrn
 fxEw==
X-Gm-Message-State: AOJu0YzABfN3Y15MpGmvbMH5J2wP2P6VEcbBT1gcM0JVNhTHbKMnsWIn
 H1hlrSCCNC9pISzUcWrZQ1v1zvqg2V89k9b7ZK9oNAl0YNEQRnmOxKWa3LUXkYo=
X-Gm-Gg: ASbGncsBHDX7wVSTNtd0Xt2CvUtaJ5aF1f0wNtj6swm1aMaO2ohG+4b0ooieje1MB1w
 dFZE+SFLPTbTVC6efijhQjsbj8IKewmsag2OfCQtoPRmJLozZFPlt8c3Ya0ibXwxp4+3qk7g8AH
 n4iVZuw63CaCa3EUTjmC9ciTzY5at1RX94XmGJ0AY7q6my3uPmFT4XZf3+ZwbOKLMStY0z/HVtT
 i4hdMJQwJOB4oEXejwbLQRKqz9jIHqYpT8XmiGYJ7KZONvJo5vzXYZDUl6pTtNcblihAfCueHi3
 nAihCEljBBecxP5+Q37FlmqwXokYBuwjKazoH952d98Cv3c/SIGFCN8alx5MONwYcnOmOVF6Wge
 XSrbBs/i6k+Q=
X-Google-Smtp-Source: AGHT+IEnpE+03/64UMVkWGbnmGgQB5Qcy7kHxcG2tXH/zWh4xD+xbTvVNdz4Dwts8LpJbTs4MwT8UA==
X-Received: by 2002:a05:6830:3893:b0:72b:9422:aec with SMTP id
 46e09a7af769-7304faa2d72mr1991037a34.8.1745513023456; 
 Thu, 24 Apr 2025 09:43:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250415095138.447390-1-anshuld@ti.com>
References: <20250415095138.447390-1-anshuld@ti.com>
Subject: Re: [PATCH v1] arm: dts: am62a: allow booting from eMMC
Message-Id: <174551302278.4069373.13860165233240279516.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:42 -0600
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

On Tue, 15 Apr 2025 15:21:36 +0530, Anshul Dalal wrote:

> The bootph-all property in u-boot enables driver initialization prior to
> relocation, this is necessary to use the device as boot media.
> 
> sdhci0 is the phandle for eMMC on am62a, so this change allows us to use
> eMMC as a boot media.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: am62a: allow booting from eMMC
      commit: 243a6dbfb680f9773e3c2a1e2e17e69068830666
-- 
Tom


