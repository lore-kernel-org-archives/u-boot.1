Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75410E63CBF
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 19:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5782683D3D;
	Sun, 25 Jan 2026 20:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FUHc3102";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EC383D2E; Sun, 25 Jan 2026 20:43:54 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D2183CF3
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 20:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40438380b88so980596fac.3
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 11:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769370231; x=1769975031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJCZDW9REDlM4yw8MmihmAediprn4MnBXOxNFu+D9dU=;
 b=FUHc3102cixSyUBvpaIcpl/FeVdxLfVS5C9oP44ukNVk3I4yt8XC6rEe4v2LUVzMMZ
 f+i2s2iCyWntXNAoFFKQPu5azdVY+YOJgahw6V/AEN2SFYJ6S5JhSHAlkSW1DW1qLU3R
 3fFs/3TvFJ/zWQrhvOAHaGllTJ4MfG3AMCO+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769370231; x=1769975031;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YJCZDW9REDlM4yw8MmihmAediprn4MnBXOxNFu+D9dU=;
 b=AOn408e6bb+qEW5f9Dsp0TarpZ//CNGJI9frNeJeYDnyx/CgYrsQlSFRcSnBtEGZkt
 m5lgpcjLX29S8isUspJS9h6m+0MJJsm1uA/RTbH8anMlCLi0oEGOuDx8o1rct4CN+pTi
 z082DCR5CbhbMk7ET8CWFH0v6KtWHXB2S9bQGtj39yKW8wmt1oHbNlQz7xF3opj/xnhW
 rmzEQdLhbwJM/kL421V1iBL8JNpvpGtcNtQ7XxDg1viOLAjRLnFjIv4hLjrhHDF93+Al
 pruw32sh9b+G23V13x3AqhdYyfLh4ULReRkq4Z4y8Xu4lM4cdsYfIVbnqG9vlZ/g2ov6
 EABw==
X-Gm-Message-State: AOJu0YxXnxgwsg6IAWo8a2SAKW81joRvCUG57CSOFbAeA7Y7ANgY0GNZ
 W/JBr3KC8fE41nsUSk8Oeeg2I7Vmd7LDRAZ/tO4sZCgirBXdwuSG8O8Ev19atq2z0B4=
X-Gm-Gg: AZuq6aK8p3ghrcTU8CqqIs+Ck3kPxhN6BfxoP9jKRlrB93niVP/ytMqH4EEFaX2oatJ
 StfGS8ZnNooW+H/hgf1hBXpkhnKtYex/C+yLu+JDWYDZ56xH48DQY0Te1aPBugkc0uNIur3Cpuw
 +LVM+CdGFPnvGpyiaWuevP6oqlZogh25E3JwZIB1ND1BpzuiVFOg31FbRceSt5OPCJzBx1jmLMo
 xofT+maxU+CA46sPDpT/J0rxVsDu3JtV62QSXR6RyxiRJni3+VvsMbTNAJJW4QaRnclIWSO5edh
 rdoaIku0XY5C0UOaavMQ6ekKdNqhc1Twrp+xscdLDKMIqfwr2f8vo9b1do7WYnoSv2sgzKnLrmU
 ACycLdRmWjhWTYV3FiNc5NssdrEzG3gQlmch2uxojmQwYXXqcS2YsVCoCykhZGNzMAX26dNOlp5
 T2rn0AzTrRkmf0QVw4fMi7549Cx8hFe4PiSgw9Y+UnKYORWXL4Gsuh+ZLNOKVCw1CQgtopvRYsf
 6QB2EI5uaQk6bddFSvFdCpER1RQciGF26as9iV/8JW16tHH
X-Received: by 2002:a05:6820:1519:b0:659:9a49:8efe with SMTP id
 006d021491bc7-662e02c5fcdmr1228013eaf.15.1769370231284; 
 Sun, 25 Jan 2026 11:43:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662cb4e5a33sm4100544eaf.2.2026.01.25.11.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:43:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
In-Reply-To: <20260125145333.527572-1-marek.vasut+usb@mailbox.org>
References: <20260125145333.527572-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <176937023034.3566385.12262158290999455259.b4-ty@konsulko.com>
Date: Sun, 25 Jan 2026 13:43:50 -0600
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

On Sun, 25 Jan 2026 15:53:09 +0100, Marek Vasut wrote:

> The following changes since commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec:
> 
>   Merge patch series "sc5xx: Add complete board support for all ADI SC5xx boards" (2026-01-23 14:55:32 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


