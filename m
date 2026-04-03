Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D9AE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5969884205;
	Fri,  3 Apr 2026 21:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YV8/m9fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CAE7841D5; Fri,  3 Apr 2026 21:47:28 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 074CA841D2
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d1872504cbso2105920a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245645; x=1775850445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cUOyEHv2I/uSP9Ni2BwCR5bHN+Bn2qGhwG2CB3ygjVI=;
 b=YV8/m9fzZFUMM6VgDho+TOpF6SokoPnZZL2dfaaDJdndZeb/t48y9tVxGe+bz53nma
 dL3CSH3hLK5JgqyQvaV5KG7Byc03lwSk8CmszGCaGfapZDBWLxlsf8WSr7+Z6zIMPXib
 LwTdLAuo+8xvPQo5EzI26/Oy4arQ8k2lXhkfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245645; x=1775850445;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cUOyEHv2I/uSP9Ni2BwCR5bHN+Bn2qGhwG2CB3ygjVI=;
 b=j+dRNLuNmmzVaYdJFE+ec3Dp4kzmnpHBrXS9LxjLMVspGewUuxLh8VS3GKqP8WOq0q
 XKkajgq8HsaUS9SynU5m8SDCLlHoliz60OpAWjgTRDKoWlTFDd5M4K39TljBAtmEfh+r
 nWuwtF4VXIOMc6FL9QtE/D2pbvpFOdQ4y6jVWc9W0LfGZIcquIOSdjL8xcWSjdrfplcB
 Gkoo/A+ktqZ3uZzY8JbTb+VSx/gLJDTnBArKKPO4TP2lls2jfFIv5hssn4PNezRTV9/j
 3uf21Vgaq1G9SC4snRwIuPrFxpTEtWSOhD8JvIEXjIqFhFcDYIKoXmt3jYpcCEk8IL9M
 XnmQ==
X-Gm-Message-State: AOJu0YzKJiBqpJwht0A+cuGD6Rn64eUzfDk1rKBKpg7g1wc5VB5uIker
 /NaYqJjapQY4gGjE3EyhStij/u85+8pTPgjk9whrgLYF9VsONImOyZHBdpU+qE7Pb2Q=
X-Gm-Gg: ATEYQzzYnpLQuzs67F2N8JOj2q9zAUayYlCpWkP9nuHYzFxDcRvZoC446v8KcYFstS3
 fyfPF+jeesfhyb43klM+hEgGAjDPLGNPSSAgFc97VIrFZNvk26lVLAFJaoixtSQyYXfgItlTR9N
 HCpYMu1+9SM2iaSm4iLYlFPJXxlomB8EfpQffa6EZvurT1TQFvph7Ju+NVqPsD7Kj7XEJzRzkrn
 j2Vcmp4X6/SJEdhrowDj4Paw6GcqPsOj989ub00T3jLZG4eYmD432UpHJqlrCt4CKX8T2NHBNCc
 hoB2QXOswFQZ36unk2XdL8hs8dCFeZJGTcolAc1JLhtWyeuyTbLYvH0Xlp6lSBxxZO3OaIzstU6
 dRWX/ZSuNgAHYrWokDL5YpKxrNcAKX55svFLhboFVYQkINqnilANKWoou3TuopKqhFZeLwp2p9O
 WVcsrumrl7vG+hT5zcJ9oAHgnybSBS/AKXj2dkM0V+6hrSB+WDsxJzgesktzgul3muaaMlSEzx8
 l0fD1uIaoFO1pOdDLSQRTBLvqfvosLdK9FmPG9Kg22kvKY=
X-Received: by 2002:a05:6830:621a:b0:7d7:e788:389 with SMTP id
 46e09a7af769-7dbb7b9288fmr2536123a34.15.1775245644768; 
 Fri, 03 Apr 2026 12:47:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205349.3789093-1-trini@konsulko.com>
References: <20260320205349.3789093-1-trini@konsulko.com>
Subject: Re: [PATCH] misc: Add missing dependency to CROS_EC_SANDBOX
Message-Id: <177524564414.2281750.9589169917360197654.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:24 -0600
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

On Fri, 20 Mar 2026 14:53:49 -0600, Tom Rini wrote:

> In order to build CROS_EC_SANDBOX we must also have the hashing API
> enabled, add that as a dependency.
> 
> 

Applied to u-boot/next, thanks!

[1/1] misc: Add missing dependency to CROS_EC_SANDBOX
      commit: a05d59a1cf7e08b3ebbd9a62d697ed7743740d62
-- 
Tom


