Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEBCCAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 19:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8749B828A2;
	Thu,  2 Oct 2025 21:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VtbDKhDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24CB834D4; Thu,  2 Oct 2025 21:30:20 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F3781D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 21:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8c3414ad279so50094539f.2
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759433417; x=1760038217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+jLoUl/XOOYykS+i55Qg8iMiAUpvuZ1Smox1+oQMgrc=;
 b=VtbDKhDLxh0GMK332FJg21h98Ok+XeGg9s9Nk0QUEd1HeIfOVRS8NvdiaREFHDzGz6
 XVKywSzm5UDyJ8ijKIs79l7L++2EQNmdjz/SJRV2BE2VcPQVb/hiDlIh86i6pBz1Pv9f
 9+PUGZ/S5abnbflgvITxQwQm5ZkEX3W5sn0rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759433417; x=1760038217;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jLoUl/XOOYykS+i55Qg8iMiAUpvuZ1Smox1+oQMgrc=;
 b=s1oJLTV4CyOeQyxGjrriIgtCdaDv3PUXYHxSW4Rd6hK2JwtBrJGE+/i1I05tlS7y2t
 PEXXTHYxgCXTAJn1aktQS2vOiJqWKHOoCV+ecXJ+rBddwTWmVOlE6B94wwy4dETpVGcB
 rCP5e0s93nH23jg7M14hTkW1J+IRi1lHOljSZTAGms7HjcaX4oJC1GyFCvqHIr5Q+r9P
 CavuCxQt0NgFeLfrfiyBjadLDw3c7x9KPe4xI6eCGK4ktVFAtNNs+f6V+Gvux1L5U9DW
 kNa2wdvewo/xhL+mwH0UcGzzJqpSuYdwM/rH7srX5HmwAaWmObsrxuuhI/hZdyfbvm2p
 pPPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu/5r2EJiWFSKNdhB+aZl5Ju+yAeiFQEAEqr99WuDo9zLF3p8RgQ4s0d/wDvzvj0A1PtLCXRU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw19sZS590uJYFT7fTVbx/qh7ovjsUnMDBx5HDgRNZiRI7cTFNX
 ZyLhxHycuXUypIeZAOMB4c6cftR+hZ3aL2sDiiDxsP4lPp96t9jpaxQD+koxh5zbfo0=
X-Gm-Gg: ASbGncvoEQz6/WxWRQwSHxh78C+W+MyOaLFmKROrdpMdfCQvl9f2jT68K0JLIqgYK56
 GiIcEOmreSeNnx9Q10gDRxT0evRYrrezYk33fJR3SmUIPDnDVJwDlZZpkEfJJ6hwLznfsl/90D6
 xm0aQpCJYmov+gHhprCe7fp2aMBNke6oF+7/2kDHeVX5teTsMTn3WX2MnKTdp4arGnHwFL70l8t
 pDvYExDH2lqw9Z6r+rtkBqwmK8qcbYTojmzxuQVVemxDUSmsaK0CB9jbp6RVIzHX5VmD6c0DEoZ
 pXTJ1/p8gAlX2KJbyuFXoOZ9HCz3UjQTnYvYiDW43miCa79+OwTd/NuzGVNo9CHdJmzs8zaSVbm
 0eUY5YyJlgndsAVkRQyhOBEoRYmqLUnNUzWnIJyC9XnE6WOZpChu/yN711xQtW+LZomL2AOnqPg
 4/NkcewmG6
X-Google-Smtp-Source: AGHT+IHGo50ttuRkq1LsHCag3SrZjfTId+/kcFqdcUawp7SbDIN24+XUF4sHlexLm6j8KIF6dnczbQ==
X-Received: by 2002:a05:6e02:1a41:b0:427:b642:235 with SMTP id
 e9e14a558f8ab-42e7ad2771fmr8211745ab.10.1759433416966; 
 Thu, 02 Oct 2025 12:30:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5e9ec3basm1116108173.13.2025.10.02.12.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 12:30:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
References: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
Subject: Re: [PATCH] b4-config: Improve b4 config for correct operation
Message-Id: <175943341605.3005048.14788976936333065602.b4-ty@konsulko.com>
Date: Thu, 02 Oct 2025 13:30:16 -0600
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

On Wed, 01 Oct 2025 10:28:37 +0100, Andrew Goodbody wrote:

> The recent change to .b4-config resulted in some expected recipients not
> being added to the address lists. Rework the commands so that all
> expected recipients are added while maintaining the ordering from the
> first change.
> 
> Fixes: 26efc940c86 ("b4-config: configure `b4` for U-Boot")
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] b4-config: Improve b4 config for correct operation
      commit: 72f72fab00773f7ee89c9635e490908c0a058162
-- 
Tom


