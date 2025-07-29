Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA5BC87FCA
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 21:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C630B82F00;
	Tue, 29 Jul 2025 23:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qe1aSMwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1997882B07; Tue, 29 Jul 2025 23:13:37 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3FE382BA1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 23:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73ff32d8b87so197397a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753823613; x=1754428413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7w6spv82Kn8oSRiz9/6lswb0s+3wGZF7OR3hgq7UxA8=;
 b=qe1aSMwDGaLLcRzh1dTEi8K0ykQUbceWQoyQ4cLjgsHWKhuBiMYH6r9ML47wwSDBaG
 fCw69sRqIS7yJqgpkKPJ9bpybpSGWHi6NI2xM/8MlsFhOGvCeiNDGpTXAHJUs+pD56vq
 t5+QS7q+Ndn/JQK0TFdpJNF5GowfqI4AyB9SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753823613; x=1754428413;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7w6spv82Kn8oSRiz9/6lswb0s+3wGZF7OR3hgq7UxA8=;
 b=SsRj8TahJavsphMvqk6j+VEZ6qkMqktsE/mE5cjwDhSBFua3gHqVhaBbdsCuYhHU33
 hvWAXK6PnyRFFcYtbbZN8Wk/MKBqQKTmzyvQ73TCXKVgTNzULZBYhER+d5BsqjQ7CVb0
 2lqIIKTn+YRS0mxI5PEhGNE/fkM3+G9z7CMi5kBmCpotSrubkA81m4vgPY348OA7iPk/
 j3ky5SsiG8kWE2LphsXF5Fc5okotz7G5CkoRJ/XcKaVNyCjm4OrbZm4bf6lnBp/S6HUh
 t8tG+nVBB8ziOnFIrK1p9mpDNuNp6/PP8XI33nMvAILFbSaGIJuvL5c6rG7Pv9eN3gv/
 iR4g==
X-Gm-Message-State: AOJu0YyB1NJZZBS24pCeyiy+RItoARptfApF0hbUMm20fqw2bDZ7Roqr
 KgDIB6cxK9FeUmoBMcNeIcummTWlkihG7KulTP0n0ZZs7dGWqVNi2kD4NH9G6osmkjw=
X-Gm-Gg: ASbGncvyVGJaOO0FHX7yG9qJt72xMtcGB0GH3PbCcodb8zwIh5cWhkYILajfU5NaSEp
 /C2jJYzQYHRaFfdbytnOkA79wBXOl8bYVnBEuM/D08ADSZPxz4wBXLCL4kYeJzyMWfCQ5CC7aQp
 DJsIodNDvuotdtxAhn8IB8pahejnNDHKGHdbH3pj84W+oSGRLY9QsRzxJ83OSC6i+U5hz/U4u+c
 ZK2AJKR3mlHghA7+nd4nnlUvrvalIVueERa9wAJKTNUY8VM7TeAJxteXuqXQxjqY0cNiJms+ZcJ
 61smQeBRaMnzKjIBlHa7oQgnCNZYYKgEAkXsK6ERt9qJezp8Q8a0vBNLGOb+rg99F5k106OygzO
 iQvkpKmgnpVQ6Zh5OXgyQZU5qPOCYEYy+6bc4CWT5SnBsqmbj4OpdQa4=
X-Google-Smtp-Source: AGHT+IHR7smqxIqtIlaX2Lk9JOPbbWPlhXfz6ze3GNhP+B9T1JTdQfBVVaCiPi+kAfec7mdqZ4Lseg==
X-Received: by 2002:a05:6830:380e:b0:73a:8d4d:426f with SMTP id
 46e09a7af769-74178d7553dmr791566a34.2.1753823613558; 
 Tue, 29 Jul 2025 14:13:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7416dce11ffsm404756a34.57.2025.07.29.14.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 14:13:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250723-bios_emulator-v1-0-78b9ef7b9b4a@linaro.org>
References: <20250723-bios_emulator-v1-0-78b9ef7b9b4a@linaro.org>
Subject: Re: [PATCH 0/2] bios_emulator: Fix two issues found by Smatch
Message-Id: <175382361283.2002397.4559428106232990250.b4-ty@konsulko.com>
Date: Tue, 29 Jul 2025 15:13:32 -0600
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

On Wed, 23 Jul 2025 11:34:34 +0100, Andrew Goodbody wrote:

> Smatch found two issues in bios_emulator, a buffer overflow and missing
> parens for a macro. Fix them both.
> 
> 

Applied to u-boot/master, thanks!

[1/2] bios_emulator: Fix buffer overflow
      commit: 4b8aba93bdba168f284036cd7f8cb0e988bf3f92
[2/2] bios_emulator: Add parens to xorl macro
      commit: 0fdcca86d87b3b723cdfc9901f02f14adba9df60
-- 
Tom


