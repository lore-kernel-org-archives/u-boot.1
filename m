Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B57D74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653B4891B4;
	Tue, 29 Oct 2024 23:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DRSyVcOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028E3891AB; Tue, 29 Oct 2024 23:28:22 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F55891A8
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b154f71885so549358385a.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240899; x=1730845699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UiLTpv6viTe5V9+duC6UsbUyRvYMKx0f/Ia3TZyDvdg=;
 b=DRSyVcOtomXbrwHp3Sccm2ep6zQh/n3APku2GFfFzhxNx2fKDFHxShRlcuRxl4giTo
 16pHP13GjN7rq+OJWcnQwvsQfhBaOQeA8bciheGTIue0CR8aYsCxaCmLNetwe6I0IUTM
 GrWbKI3KQV++0QVruILVUXDnW5dOQ9VULN6es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240899; x=1730845699;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiLTpv6viTe5V9+duC6UsbUyRvYMKx0f/Ia3TZyDvdg=;
 b=K5EuI86syGSsoZoHHrB3eBnBFny/aN5wNH6uEq0K5zNY740nZmMX1z+CyAmZ7mCUNV
 MOrjkjUhAnLAoyRu2yq9JrHaw8QM/AGCk51K0Wud2m95Fb696YHABXQ0d1Ynpwm/PL+Z
 BeVu1UGv2D+CeJQYkAQJGKrG2+zlW2Sy4ZD7JQhfLiduYlNDsqSIPPduU23xmVITSDCu
 ApmuPoJHA9AiLiGD6UkjdJMDs9+FRD684ccOiBgBF63lhM9r4Wy7dtOpEDszMY4Obey0
 IroUoE6xAFUGxh+tb2dS3IcrLMG+1uru+S6GmnqP1/t0YRUKrCN7awp/1UcQJidzOFyA
 5/EQ==
X-Gm-Message-State: AOJu0YzfmwrixS2iRNjU9cOPNrYNuHDr+ehiWOwQRz00vHPu3KHxOYWb
 vKWvp7pudP6Z/IKMubAePKWdOU+5KeyctgYJNg+Zv8iWWtNsKsQGG+hIFmTewFe8rkZB5yyvlnn
 eAIo=
X-Google-Smtp-Source: AGHT+IFycceuSyzez+jr6qNNOSv/hTewffysNgRmUdckdKPjGTO76n9I0hu6H9UFCIXgqT7ni/jJPg==
X-Received: by 2002:a05:620a:1792:b0:7b1:522a:afe with SMTP id
 af79cd13be357-7b193eff83fmr2159139385a.36.1730240898877; 
 Tue, 29 Oct 2024 15:28:18 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20241021171820.625003-1-sughosh.ganu@linaro.org>
References: <20241021171820.625003-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH] lmb: add a check to prevent memory overrun
Message-Id: <173024089722.2563570.8080852706972900405.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:17 -0600
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

On Mon, 21 Oct 2024 22:48:20 +0530, Sughosh Ganu wrote:

> When printing the LMB flags for a memory region, there is a need to
> check that the array index that is computed is a sane value. Put a
> noisy assert in case this check fails, as that implies something with
> the LMB code is not working as expected.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


