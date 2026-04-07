Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CA1FF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF837840B0;
	Tue,  7 Apr 2026 21:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mv4nArYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2818416F; Tue,  7 Apr 2026 21:50:15 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE0C840B0
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-685013eb58fso1422349eaf.3
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591412; x=1776196212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lkM5oIxZFG0/2+j/sCeC/oWITB4m+LpyjO7xOew0Kco=;
 b=mv4nArYnz+KsrDUU/jzR/qXZqmIz2q60s/groFqMUNLO+oouK+aotVU7XFL1OkWFmx
 wKyb3eLihM0wUhr3072BqnGlo4HlTNbeh9gg3mfox451XoGBLNM0BS1ocYEfsz/BpJj+
 WiHWy4bXdB8NyJBENVAQREVTgP558qtKdwFhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591412; x=1776196212;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lkM5oIxZFG0/2+j/sCeC/oWITB4m+LpyjO7xOew0Kco=;
 b=AAZUioOcySH49O1NI2SU6qNSve5GvGqIsxBc/B8XVSWjnRSscsnEak4EmVFS9Ilyv+
 uI7buKEEIIDiLJQkte8+HeGDXZO4AtReP5rak0mcKCCT3/ir/6KEJzBg6VvShWdNsvl3
 hf1Sv1zP/Y35tBoZcsahbxNJs4ROvIUe4eMs/vHqHiUnanLY5tocFx6NqcJm1DUyGWDq
 WnIRZ80S6gVDjMqIMOA4eguDVKnkqiFJR//Xn9eyZ9tOVV432lWElrubrrJszGX5bMXY
 D6V2ZPB7I2bSBShwlz9ElfC4Lxk71Ay9UZQiwljXe6fXfb3XH2Jht3FCmDPO3WjAljDc
 AH9g==
X-Gm-Message-State: AOJu0YylMJKEzk4Tl0CX5jHaZlchMNENdanf5qnvmfOp3s3QL6I7xuYy
 +hvFI7Qd9MNrOg5DV11yrBXNo+RxDCw/LNOnR1vqg5LDGoQyAA+xWhYpw6o5ohZcB6+IjQTICHI
 AK5W4/1g=
X-Gm-Gg: AeBDievMOShHCbRknJ9ZhLNcl8/UZKxf/U4svmLNETB6MyoSAop3iyqmTYg3oQNFou/
 wR9hIJrAHP+Ol0h6+QPNuaoabUuXc3td6klS9UQwg+hrwKdZYIj0wh37RkaeavjVH0dgwMaHTBz
 BHctTl2+T+78MtqlOn38oE4QfKZCFU7Of4DbIaIk60CqcNLeBaQzs3XTGbudwXV47Wc1Hjgg6Yl
 r6Ixav3sX/rVjLLAwyDU9e71aUPktNr5MlbnArAt+qKFCtjvUcvrWjFw0xJIAKjV4U58WNHk4v0
 0bc5ZqugPdG2dxrvK/L8n2qFfUChqEDbv2Nd5SNG2v/MeANRb7s+DaiuV+e0jbGKQVeZ0W40KNE
 8wowMUE7P49ToiBKKg373caU+ZQwfXE3Yz9Dmt9w+LIcOHNVCe+svtfwgVByiHI5gJ7stggtcB+
 i3ez9ITLbmf9xuE1J0v4OFxq/jyGjWZVc1EJGpTjgmvveHqeF1YpCJdeYBeoflhMNoE24FnlsK1
 wPSu48YnFfKd72Q5q4ivAi2hJFMUofQZLX5MbZ6Ca8pJjg=
X-Received: by 2002:a05:6820:1903:b0:67e:1a8d:8780 with SMTP id
 006d021491bc7-6821fb60cfamr10528800eaf.36.1775591412184; 
 Tue, 07 Apr 2026 12:50:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195245.2363420-1-trini@konsulko.com>
References: <20260323195245.2363420-1-trini@konsulko.com>
Subject: Re: [PATCH] lmb: Rework the LMB_ARCH_MEM_MAP symbol
Message-Id: <177559141140.2108693.3886262142385106157.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:11 -0600
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

On Mon, 23 Mar 2026 13:52:45 -0600, Tom Rini wrote:

> This symbol should not be enabled by the user directly but rather
> selected when implemented in a given platform. This converts all of the
> current users of this feature and hides the symbol.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lmb: Rework the LMB_ARCH_MEM_MAP symbol
      commit: 504c4cdabda5dd602dc91bed4982739ede55339c
-- 
Tom


