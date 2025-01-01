Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CBFE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 17:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B73280379;
	Wed,  1 Jan 2025 18:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TBdUH7/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D50280391; Wed,  1 Jan 2025 18:54:25 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F0C58031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 18:54:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dd1962a75bso79646036d6.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 09:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735754062; x=1736358862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lb98DcXIv64qrq7thkAdYm6TTm7gpESqvBToa6T3WQc=;
 b=TBdUH7/uTVXzdYUp52cvuhv1ewy+nT376rIh302Dj9cfAAQOLqsHZoAhhavUUDkMjI
 5Na/JdyoGzG3s9i4+g3JyEYX9D//aU4bMqMgqfkuWwlyqmbkTp0FjIiDNEWGJLkVpQSK
 UxAbe3ZFfcdjDK4hWFsA1VscBpb89Xm3myuAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735754062; x=1736358862;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lb98DcXIv64qrq7thkAdYm6TTm7gpESqvBToa6T3WQc=;
 b=Rkbvd2kB0lENyqhtLigM+FKI2xB5l4tcSqn3jvu5j2cHz0pHnGpl0EaRUJPLaDLDyN
 490C1ZVx4NR82meoq0DnifZ6jHnKgpIDA2IsIdHT5XrfxohZ8QV3nb6KenhZJ9JaUhV5
 g4c+IZGH5K1QjqSiqKTPdfNPh7ePE+wv9wHBkX44CWBUciegsCe3hiV9omfPjrgaVE8G
 teDewe6jBudVxfQH55YdU7SXid99vbVCoTMMztfqjsFqRqYKEDaN2DyZ4kuEVBIQP0G3
 VSU/dr5kSJtB5Uc1qcINLgUtZmNE2S7LO9RdDJNtBJD1xWSsxVw+deccks01ymZVEEd3
 P36w==
X-Gm-Message-State: AOJu0YyeUaEL09UQLU4pxyafp006crWTYRhM6lXUVmRGCEPBZ3x3iPRV
 P906IatczT9RNuv6Asc44IeXH4lLKy3bMWQNEPgYjxPLzVUXVQo6Zrq1KiCL3qY=
X-Gm-Gg: ASbGnctxwdVXPjs50EWkm7MRHsXiocNYWWsRRm2X4ASkS999JlxSNsXtlGqX3YB73lm
 QFbXw3WLf+Pl51EwJDXeEpnhK8Bt6jlDD46O4wYGXl21nlHEq9hyrq/L+pxDuEuh5/1huNR1CnX
 QDSrVTA1g0XUUSK7rHBMdd1KTVvrmyyObX0bE0YSYY30xn+ym5Mil8zivk02Y18BXXEV/HJt8YM
 C/8D6jsE7h+5zHiDGuejZf1o8qU6+kdCIIkKEtka3BruxG1VpLu15xt
X-Google-Smtp-Source: AGHT+IEl1qbvRNgwZzeL0o56XHiwqGrEVN2QqIfKPGgJqb2Jk4UwVqdx8j+H526zwGhaOKAjLzAc8w==
X-Received: by 2002:a05:6214:5186:b0:6d8:7ccf:b692 with SMTP id
 6a1803df08f44-6dd2333a8camr623955016d6.11.1735754061979; 
 Wed, 01 Jan 2025 09:54:21 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb525sm123411896d6.97.2025.01.01.09.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 09:54:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <20241206101132.1094545-1-jerome.forissier@linaro.org>
References: <20241206101132.1094545-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] trace: proftool: dump-ftrace should write funcgraph
 times in ns not us
Message-Id: <173575405977.1681845.16936003240407202441.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 11:54:19 -0600
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

On Fri, 06 Dec 2024 11:11:31 +0100, Jerome Forissier wrote:

> When converting a U-Boot trace records file to ftrace function graph
> format for use by trace-cmd ('proftool -f funcgraph dump-ftrace'), the
> time associated to each function is incorrectly saved in microseconds
> instead of nanoseconds. Multuply the value by 1000 to fix the issue.
> 
> With this change, the trace-cmd output looks consistent. Here is an
> example with udelay(25) added to mem_malloc_init() as a test case:
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


