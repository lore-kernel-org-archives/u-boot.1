Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1C0CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809B2849C5;
	Wed, 10 Jun 2026 00:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nci+J7X7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AF4849B8; Wed, 10 Jun 2026 00:28:26 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21982849B8
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-486560db92cso4598895b6e.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044103; x=1781648903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCWWcT68fDp3vnVBnYEtTkRLUsplF/W26aWbRONvqCQ=;
 b=nci+J7X7YjxykjT0PlzVf0x7aXRty8jpEmhCNbtmW/RKHWF8b53WiL7W7i5a1hf+lt
 COSCvdRLXVPgVSfmOa1T8s2isQP2UTwLL/RYWJcpOJGa32V9Pumede3pxJgW0NrGmdPo
 Ln/HwPXVcBQrkfTwh5UZK+sqxLndil4FzF2XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044103; x=1781648903;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QCWWcT68fDp3vnVBnYEtTkRLUsplF/W26aWbRONvqCQ=;
 b=JxO+edahtmhJeLhiGHDK3vFA8S7v0Bb/3OMMj4YqURcT24shmqvIUr1Ghk+KhWq7RW
 pL/WyQCqXGePErqi1TqWBaLNot/+AsZqtAyhz9vK/aS88c5cmibojLbN8WoUI23locQk
 p0s0Jp5qrb76Nq+RmA5vf55dzUARS2lomp3+49IC9kzdvI7xtA4663aNcYdfiO1v/7WS
 S+o8wgoUEACOp0fzBvw0Yig6gnjOQapZH1sKEVHE4J8LZNCXATiYc6XztF+shgbODlho
 ZfoyrOznzVNbWwgSogfgIgKBWHHtfIxZOT/i6TZajMYRzhMgk0TXpyYqMiyfsLqNiby8
 Vurw==
X-Gm-Message-State: AOJu0Yw4ozCxqv/Lifum3NXmzF0mM3Y9U2w6e7/AGacdn0IuPsilyiJh
 bvYpcYP9wu1wugmoEXOjWBA0RMOalZ2b1NzBJanPN9Fz8hVlqQF8w9pHOobVUfe448M=
X-Gm-Gg: Acq92OHVS3PmzEHV8mkL8FXNn4ecA7TFmwV0g1R3JccSRVM9xS948gZYQ0+rUq3Zmk2
 Vq8MHcCbdas0sQ0tC0VZjyr2bK8TN1AnFoe8ZUkjFWZyT4avulJodStASUYe0F/BquAa3HdXSdd
 /AzXML5EY0iKwcBx+9g14s6fVJ0p4UO4q3sskQv6LIxMoPXYdz+dO3mGtGAfc2LLGnVX7Il5nwG
 IGvBnd3bNLieL4xq++4piAJ9G/KTZSFmpA9Z2jEJyGF8FSQzmsxnIpF7FYJ7dM2268b1X9Bj7nE
 /TxeIADhPGS14mnjDYOow94sTEV9GbZAlxewRxNlOqbXjS75AKtJmjk4DnAwbcmoeq9lVYw9E5O
 S8AnSxPnQ8cOomwKSuyN9N/oEkNiho09yGQEPh4Mj6ocTLLDTFj/0LQP0Dw7gfftr2UWUIgtJZg
 sJgab/c8E5cQuKtNv49eC6HOjttE/uqQ/o5BA7HZM10/VS4FJqitw11338Y5rYnpOdiuk/1aUCx
 ksk5Avf4w7vXpHW3UYJDc4OK3dDy0a/JX6ROQLQzWkjsbkFnCEyaVmDzDeP
X-Received: by 2002:a05:6808:2223:b0:486:89d8:6d50 with SMTP id
 5614622812f47-4868dddaf14mr11884528b6e.4.1781044102911; 
 Tue, 09 Jun 2026 15:28:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 BMC-SW@aspeedtech.com, joel@jms.id.au, peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260525040741.2369146-1-peng.fan@nxp.com>
References: <20260525040741.2369146-1-peng.fan@nxp.com>
Subject: Re: [PATCH] ram: aspeed: Use dev_read_addr_x() API
Message-Id: <178104410159.79918.1728101823974114952.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:21 -0600
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

On Mon, 25 May 2026 12:07:41 +0800, peng.fan@nxp.com wrote:

> Use dev_read_addr_ptr() and dev_read_addr_index_ptr() which support both
> live device tree and flat DT backends, avoiding direct dependency on
> devfdt_* helpers.
> 
> While at here, also use ofnode_read_s32_default() to replace
> fdtdec_get_int().
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] ram: aspeed: Use dev_read_addr_x() API
      commit: d26cbf4667c9b8193b06c6f8e9fa7334866c94ac
-- 
Tom


