Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63808C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD27482063;
	Fri, 11 Jul 2025 17:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f8JjxZDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E265826AA; Fri, 11 Jul 2025 17:50:34 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38251800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso784128fac.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752249031; x=1752853831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULRE4w7+eAOAJE1VkuoLWM7Dnz+2v1tfXvk8PMCXaic=;
 b=f8JjxZDJLgo0z+Ryr5GdNRqOu3KIyh4OmYudMyqLF4mho+VC/Zy8zFHCKyDRN7VTi5
 U3kEWqYGDrcP7q72W9S6/use4CzIGdCpFB1XfVmiashlhn9g99PQF7qq9ngeWmL5rsd4
 RBR/kOvwRsKN+SgoHDl6EquTXjd2Ux463dy0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752249031; x=1752853831;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULRE4w7+eAOAJE1VkuoLWM7Dnz+2v1tfXvk8PMCXaic=;
 b=lpwqtuwFqhC69SLj3G2ZFbCbxceZ9n8k/ZopGXB/puTeXZZJIZvGSQsWjHex5EpLS1
 IFxMNnDMKIGqOx5crFEhzxqWIkJCINq+rUmq6GbYMvFD7MKZoHrzNfxdatUW6kSE7Nv3
 w8eiH2d/79Gm4RmeP1axr1NB8u0IhDUGd5FR8izZYEp3G5Ednpc8CVJ8RIei7IEPzubS
 bRUgRFn6lvftcn3eVCFpTLeetlo8Tgb1AVWCq8ZSmDOfh1Ib3Vklt6GGLx/godjbHcnm
 NkOnx0d0TVVKe/4K4VQa8WDIYAF/dpZuK12Ihh+G/Mv3bEG+REQBgloa6A2w3zBkSNi5
 epRw==
X-Gm-Message-State: AOJu0Yzj1RnLGQa/B53j2KepQLl26NCA6nmKxCmKI8561BvQldA/K4rX
 AQaKqCR+2NAxPs/CGnURzFROZpqVW3GBQO7t8EQe8d77tx+/OnWqSrXIyNoOw8fBeHUoxAjS86l
 YajQqlq4=
X-Gm-Gg: ASbGnctLzFhtUguPHn1LyJkG2QPlyrbTl0RajcKQ8NS5x/AXQfaTl/DnHXp3B8fNRp2
 6IYgS0SgFXNSgsUTlNpOM64h8Blj/OxHEd7+7NVBnkfyIgVnroz6sHCGI+FxgRH7LfySamF11jg
 EvjSzONmn7X+j7J3CecAriU51W8TSncc8p+5P82Kfnxr4r6XPMViRZUsjBhOo3QcRD7/Qek9I3o
 z5Lc/pWDN/CwlChQ1gHyzKeAeQ1CxfozK7Qb9AGmhfHp5ju+ChQbjZHbLIEIh+BHGQAaVNUDVeX
 GqD4JfbkWqWXuuyIp2WpL9NHI8KPTg68hXDBS1+5dOvDaPckDP+RZ2Wwn/WmajTYpl2mSDsy10c
 +AyyTOzkh/FPM60+4rBz7ifGIkI4+1XnUWax25ao6SGfmgYw0FKHul/E=
X-Google-Smtp-Source: AGHT+IFZ78EjiEVxozIV6u8s3ztgbiDPVUk7duA4YCiq8i55wo197UiVzLEJs5o7CZe9l5uvqsfYBQ==
X-Received: by 2002:a05:6870:592:b0:29e:43ce:a172 with SMTP id
 586e51a60fabf-2ff26a6e83cmr3247126fac.28.1752249030862; 
 Fri, 11 Jul 2025 08:50:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10648ccsm596663a34.13.2025.07.11.08.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:50:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250711022026.942001-1-festevam@gmail.com>
References: <20250711022026.942001-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250710
Message-Id: <175224902995.2228739.13333345523953190094.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 09:50:29 -0600
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

On Thu, 10 Jul 2025 23:20:26 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 344e1798059ba65769272be3145736685bb25a7e:
> 
>   lmb: add missing fallthrough in lmb_alloc_mem() (2025-07-09 10:39:37 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


