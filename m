Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBAAC369D3
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 17:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AB08197F;
	Mon, 21 Apr 2025 19:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TEmlOlqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB1481026; Mon, 21 Apr 2025 19:42:11 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255E88144A
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 19:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3fb3f4bf97aso1323433b6e.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745257328; x=1745862128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWMnSd04cQRIXchEV9kFNyEE6SbE+lNlln6flutPg1I=;
 b=TEmlOlqCkLRYGT3/iM0jwmCB1GlzLjAyo536VwASKDspe0+g9LFQ48aqoCnUcBUYBC
 2UfDlbeDOzRrlKvaydV++cceedC9hYMHV0OOIdnq5+6bnSplfhJFB1JGXLEYLmuX52YL
 gaRqfDf1ei7X72N3DR/SJgJeHjhs+fWpHssR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745257328; x=1745862128;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWMnSd04cQRIXchEV9kFNyEE6SbE+lNlln6flutPg1I=;
 b=KlWS54JXjJ9ck+8CpoS24IkjI6teNF1xOetrG/Sub04tlIfyCd3uS5gU52IvcmNC/e
 6S1cmyMQ+EnVUQv4cXWZRizeFFY0X1Y2n2rKLwqcc0Y7BRSzBF+r/uYmSimVRRX/oh9O
 YUzUPGC52pPqOXBaGIGdv41zabps4t0pS1bgKkqjiGpWZenbhETL4vKXWHVjNDE7iTI1
 550Kzgb/347YprlFomV6b41xbpT5+6hIoMigoAFedeCbJURFHVhjYc8sUr2KbIFpYwgM
 49cTyJDIKIoMLl00VQ93uG1J3t+2IyFquFGJ8GRvnl0wUQrps0YGoZVT9RQ10O3sRrQv
 grXw==
X-Gm-Message-State: AOJu0YxuSZUzu8alYi5UocgQTQrPyCFN1SMvGFvYTgNo6Lq/4Jm5SbEC
 2LYkpww0zIquWfzS/7fEpBUmbQQ8nGjtAGzXduTwrxY4qP3KoSlcA0DnqivmPoA=
X-Gm-Gg: ASbGncu1waK6cATLmnWbEy10hmh/nvYKeJe+1U7KnMiPCOI0I3BlgIx25lFcKTRBBLp
 30VbhH9yiFd/CpDq55h75ed8rtbyF/bVeVba03Mv7udPRYInaGf44YSmFnevS+brxWZ+4FCy22j
 6MhtZm9/wGYoWO1D6EbhtegqyrYhQB+GFIPCLlMTOOWfBkTVL61Jc8RNJ8U3lgfQtT6TpWTZB8O
 yH/bX7WRd89kXpOCfag+roY/y8GMLSKf+M/jZhPBTFk9urIExFk2XXCzdofQaZEAC0iiBFxD65P
 WiTXqwIiynA7k+NRUBnf7H/bFGLKa268DlwOUTch3gaXdg+fr+k1t1QhXDZBfceDhOhKXyQxwbR
 rh8Uv727RxTQ=
X-Google-Smtp-Source: AGHT+IFE9z0dKyaqm3Ci6oH0CoJTmtx7iDFT8vPIprIujf7u6ORj27mSG6TYCp5joP0Ec2HrxdNLhA==
X-Received: by 2002:a05:6808:2b07:b0:401:cd6d:25de with SMTP id
 5614622812f47-401cd6d283emr3739684b6e.22.1745257327905; 
 Mon, 21 Apr 2025 10:42:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401bf09d018sm1611324b6e.43.2025.04.21.10.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 10:42:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <20250416233134.2528387-1-sjg@chromium.org>
References: <20250416233134.2528387-1-sjg@chromium.org>
Subject: Re: [u-boot-test-hooks PATCH 1/2] travis-ci: Add qemu_arm/64_spl board
Message-Id: <174525732716.3657668.11317766286557924623.b4-ty@konsulko.com>
Date: Mon, 21 Apr 2025 11:42:07 -0600
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

On Wed, 16 Apr 2025 17:31:31 -0600, Simon Glass wrote:

> These are similar to the existing qemu_arm/64 targets, except that the
> 'bios' is image.bin (containing both SPL and U-Boot) rather than in
> u-boot.bin
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/2] travis-ci: Add qemu_arm/64_spl board
      commit: 31e2cc963c5f50ab9d6c4029af9c8ca8bcb06b49
[2/2] ellemere: Add qemu_arm/64_spl board
      commit: f8132e1ce30a63533da7fbbb334095109293eb06
-- 
Tom


