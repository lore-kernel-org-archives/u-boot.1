Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5088CE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A9B8974E;
	Fri,  6 Dec 2024 19:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RZU5nBe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA748962F; Fri,  6 Dec 2024 19:58:56 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA2A896EE
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8d44e177cso24814716d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511533; x=1734116333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gANgcc+563yfgU7r/DCG/6DMi2NKvRv/7zAPkgmq58E=;
 b=RZU5nBe1VvpfCmBPShOTJe5ypKN3yy6AOcBEDr7jjkPQwpfjKfNDPQqIjlhlC6uPya
 Q5nwgiEpsrDmnTM+GeaW1Qj0pIyUr5EjslLXpKfE9gcLEfaeAgCxF6O4n+CrYbo/gvHt
 uH7VmnWiwmcMhbkWNxCFqFD9zDfjvwdl7MC5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511533; x=1734116333;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gANgcc+563yfgU7r/DCG/6DMi2NKvRv/7zAPkgmq58E=;
 b=tF0fh/3zy2RhnsrQZ1dPq9Dir/xvZDn42KTl6aBrK+rf+Gsiq26lRGvyQh0hUHOHxR
 JPly9+BsP5rG8WP1oOYnqb+Tyxy0lJ8TDel+sY7j44oxqeDCfrfS4feXctzhgvU4ziJP
 l0K30xRhjpPkfBeaMCQKEG3vHeyNJX5DAyUgnbIS6lrjrj2I9gPEh7TF4I2IXiY5iOtd
 fuidKPGsORXH4P56aDtRZkzCZnjatEmp2gDtNj9GzkE9gNZnxXed21fFaAH6b1JFD/0a
 /LOYqZIryem+DDfUSLwCXLJWkwKk+xqvL2wlVR6V5LYtmjMhb5Hq5BPi/vU59jAu01cj
 RaSw==
X-Gm-Message-State: AOJu0YynCewMbLRp4b7os5n3pYGblhsCxYiwGJtEVHEqmmRHtEquTEzW
 gc0Aj4aoOJtYwXX8iMsyt8ARyMZ+18Z6j7jvujn+c0p7r3nPeelS3I4U1kkLtBDlZYmxfpFnztL
 5EHM=
X-Gm-Gg: ASbGncv3qgOyn1Rwn/hfEm36w0T9j3RfCOQMixAR1bi7ShFv7JiZTPS+NYUHCnVHU//
 crOJQ+rQpjMCOY6/32HGXfKAS/nHWLPAB84YFJJGrTrl4XfJFj4aHR8gcoWkpBy/YHS15kw0/9a
 x4YgxPYhfJGyPmd7+W9Ud7LNPwi5p+4DSCZiAOtTJ3k3ZhvaVRNbYrLP6adYeRHFyzHzxaaS7W/
 /d7yz+vvpxyUy2/M+FzxOyU8CROBs8wUeot6IlcwtJOL8ZP
X-Google-Smtp-Source: AGHT+IHb3Cr7whAVICacd6h5OP0PmXSOeLupZBTj436Gx/09+psiu1qxygcggsve4Yn9hK7Hriq1fA==
X-Received: by 2002:a05:6214:c82:b0:6d8:94f4:d2a8 with SMTP id
 6a1803df08f44-6d8e64b4baemr67396526d6.9.1733511531568; 
 Fri, 06 Dec 2024 10:58:51 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: afd@ti.com, d-gole@ti.com, marcel.ziswiler@toradex.com, 
 sumit.garg@linaro.org, nm@ti.com, d.schultz@phytec.de, w.egorov@phytec.de, 
 Garrett Giordano <ggiordano@phytec.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20241112204023.3619557-1-ggiordano@phytec.com>
References: <20241112204023.3619557-1-ggiordano@phytec.com>
Subject: Re: [PATCH] board: phytec: common: Introduce
 CONFIG_PHYTEC_K3_DDR_PATCH
Message-Id: <173351152978.2516797.11588820383647023547.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:49 -0600
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

On Tue, 12 Nov 2024 12:40:23 -0800, Garrett Giordano wrote:

> Introduce CONFIG_PHYTEC_K3_DDR_PATCH to make DDR timing patch code
> optional for PHYTEC K3 boards. This allows better control over which
> boards receive DDR timing patches, rather than compiling the code for
> all boards with K3_DDRSS enabled.
> 
> Also enable the feature by default for PHYCORE_AM62X_R5.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


