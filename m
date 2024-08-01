Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2820C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E87F884BE;
	Thu,  1 Aug 2024 16:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dFIhKg0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E52C88ADF; Thu,  1 Aug 2024 16:21:37 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C539884A9
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5d5f24d9df8so2294829eaf.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722522094; x=1723126894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c03Hj+/7LxugyyIkzLG5SOvAJBTrzHd7EoqPZQRdGn0=;
 b=dFIhKg0uPcbv2KUDqYvU2xOMvgvveZMHm/qnEThjAnVaSRORu8/nBK0JTDbV3YBJbc
 ygSnn0A87+onKCYUZdVTVslxzNckiQolmp/E4wkUOxMCc1dWvkk4Qh/E9FLzizBjQTbk
 x8eML7u75qFDgQmjgDhOyWKKNvWDEwLCc3iHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522094; x=1723126894;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c03Hj+/7LxugyyIkzLG5SOvAJBTrzHd7EoqPZQRdGn0=;
 b=kY5Lu6m5KD3nSZGi7OxARFcXOHtODfrjaPP3qLU7+FbrDhDUDxQHPnxraMCRQN26i+
 Yu1A+GABctdGDI4sJyi74/MdzFMmkaSv3b6Dbhyi7jC0dHD7WRG5Q0539nV1XSZdzpdp
 YcLLan1TrL+6j/ykcFtvpBLLueFwux7AwUuVw3qSY0Ivcf0a7VY2XG687+m/8JP/aQGi
 MJ4uQiqcVcwIgoZrIkFNordZ8y3T6KtARnxIubE3MH7y5gTNeWDRpmRBEOBt5SaN7UQW
 hZo7BLOX0VJlc4PKfoZ4Vtuvv9WZosWs1xs3Vhq3PyFuDUPKyb8hKrcVxsdd2EpLrDvW
 6ZHA==
X-Gm-Message-State: AOJu0YxQtQhfqaWDCOJitcJ04PowTEcvnwiKCB6d3c+m6+bi5zBNXZJV
 fPyTIH+1879UmKbiKqRNFcfv32d7QJiwfp1uq6Klr9Hicj9pU4xxnlXvYnu00Jk=
X-Google-Smtp-Source: AGHT+IEgfNooDIp0u9LTq5D8Zsles/O8RWapTVjCPrtllzMKEsDmJfokm6K+cJ61CuRrVJCu6fW5YA==
X-Received: by 2002:a05:6870:d8ca:b0:260:ffcd:21fe with SMTP id
 586e51a60fabf-26891d3dc41mr281280fac.23.1722522093739; 
 Thu, 01 Aug 2024 07:21:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e63f463sm3087486fac.18.2024.08.01.07.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:21:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240708091002.2585902-1-alexander.sverdlin@siemens.com>
References: <20240708091002.2585902-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH] net: remove duplicate eth_env_set_enetaddr_by_index()
 declaration
Message-Id: <172252209245.4049041.5722437738397875513.b4-ty@konsulko.com>
Date: Thu, 01 Aug 2024 08:21:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 08 Jul 2024 11:09:58 +0200, A. Sverdlin wrote:

> eth_env_set_enetaddr_by_index() declaration is duplicated in eth_internal.h
> and net.h, but all units including eth_internal.h already include net.h.
> Remove the superfluous declaration.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


