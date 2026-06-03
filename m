Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8567ACD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5B6783EF9;
	Wed,  3 Jun 2026 17:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EBGQyuC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DF58467E; Wed,  3 Jun 2026 17:55:36 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36D98005D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 17:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-8cce20d2cbaso9833136d6.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780502132; x=1781106932; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ltlnn6/oGagGwUGeQMY0Tp6cEihIrUsJW0zVd3NHyk=;
 b=EBGQyuC6RYDTuSjBTd2rB9lu7jLoXO0qzvloHWcuxblsASg4cDDionJy9jqOKG3mpX
 PEDWeqVjWOArnzaVycjV9VMD6a3e43S9KHwWZIe2x7kldY4M+Fb9CDhRvZLuK8JCb2eq
 eHu3qZZZjRClKVu2+JL6kQ4+FbwYo+iqm5NuTfmfV72K0OjxzoHBI4Q8mNvAuiWhqumt
 zAMZPN4oyKqP4fITEyGHy/iNaKdFZ+Sxa3K0MR6EQF/CghH7z/TvDvizLf85cMCrYQGY
 yJf6VCBowAf6s5Oz3IxLeOWt6/1iTfg78YpemoVgUuLNOZ+vi0vpdcB3PbhHWwSm67NW
 72Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502132; x=1781106932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ltlnn6/oGagGwUGeQMY0Tp6cEihIrUsJW0zVd3NHyk=;
 b=oS/5kRiDSKGCebKFF1bMPXzeSuK+vk9f99k07jBfJ6W08I8iAwHbL4S1xlpHFxYHJb
 4p/ypmvjgN7obTff7kJ9w8OBO0IcyAO7KZzlLh473lnhaCDiIv1/p2u8liJwe1dF0UgM
 GB52ya0vKNtzL+cLqS5QIyrwdcOzYulmg3xP+JLsUY/Kwx/yMYSx6AZVOFhoxo07DCoB
 9UKeuIIdO55KR1Gt49yrqZ5SzKMERwLFy4d7jlYDFfvzqo7Wm/qX0KWs9qw9iB1wYyR6
 EaPiu5lmXzPAyuUzH7bMLfSr858hSYFD3s59Y+y0ArfgsSOR3lJvr+hycY5l4H0OD7if
 OVZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ApnRkx9Dt6SWr/BtQOyN13RS8s26TNhS7QzD3Vs9skj7nRsYNDRzKU+Gi2S+XeK9c/uy+5fg=@lists.denx.de
X-Gm-Message-State: AOJu0YxCS81y8YvebQaw8H0VzRUNbLFdiVozpeaPZG3AO/W9Z1agn0GA
 JUVpF3qQw9vkQ0z7laNKMOKk0I8Mm1PxhGAmCeyDXb0cDUwMLTE1q2iI
X-Gm-Gg: Acq92OEnWN8yjUCHQi3rIkwoFlD9GFv1XqTqFWtxBrZk6jZ4R+L4ldRaOEd7RS6b9ZU
 Ooz/Tf54zqEv6jYHTgkppgLu7wpNg62dVTp5BKBfn7nuHoHs0Ms2jimDIUtof5S7zGlsb13P2O0
 XJt1sgiJyfZVoOHuEWXl8Qj+HM2kuhlbE8JR71ebPZ9zStt9u7BG+INKqtZjTT7tixLpAuvkXMu
 7I/HFlU744YAUq0HH/Go+qDjU9MtfndNV3sp+5TK4gm5QFHrEI2OehkWDYfmxaRoEkSzoWUPkfN
 os1PIsKxQrZZbfdnZznnodmbqSVLP2/Ed77Y38dlmFh7l3+1OdoZXIrjsHwguuMD7eG0DlDBVcY
 WMhHY13hFzRqpR3hhGuRBmaCMCGkAu9oReGP1UxgOONCA/6z7IqRkfVouZ2DJn6cQT3kAzFJTAB
 iIH63avizrloNDS+NgMNSSy7ktQ0ZUK6m/HR4rOCFz5fORWS6V0JdLP83w6JOarCS5dl4hSlbkm
 MRtt8oErQ==
X-Received: by 2002:ad4:55e5:0:b0:8cc:d6a1:e1b5 with SMTP id
 6a1803df08f44-8cecb2d0bafmr36351246d6.8.1780502131691; 
 Wed, 03 Jun 2026 08:55:31 -0700 (PDT)
Received: from [192.168.1.143] (pool-173-66-184-60.washdc.fios.verizon.net.
 [173.66.184.60]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccd9dfc1sm23697586d6.4.2026.06.03.08.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 08:55:31 -0700 (PDT)
Message-ID: <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
Date: Wed, 3 Jun 2026 11:55:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: mkimage: allow zynqmp to use a register initialization file
Content-Language: en-US
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>, u-boot@lists.denx.de
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260602210141.62966-1-erich.e.hoover@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/2/26 17:01, Erich E. Hoover wrote:
> Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>

Please add a commit message.

And isn't this already possible with -R ?
