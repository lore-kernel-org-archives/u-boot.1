Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7970CD74945
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293A6891F9;
	Tue, 29 Oct 2024 23:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dg5m7u7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620E3891E7; Tue, 29 Oct 2024 23:28:33 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F6F891A8
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b1488fde46so462737785a.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240910; x=1730845710; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kobsk6uDh8spw2KJW9ZGW6pV437dImNAfPMf9kCRaMY=;
 b=dg5m7u7nGCITmsUAysXMNHS5lHNlRH9/emaZTpKJO0ahbgP1zKbg9PCZ/NAbYpG5F4
 qVX1moOGBKEpyegnUbADdzioVaWBNc7+0IO0a4nczTbSGJBGYHd5HPc5VrNke6VDVWL4
 0HxoAK27igDDCQpSQ9bcKZsHyWkmE3pLFkNp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240910; x=1730845710;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kobsk6uDh8spw2KJW9ZGW6pV437dImNAfPMf9kCRaMY=;
 b=rqTk7ENdVNFMi8fmegTDk6dX3MXboId9ykP8jsMsNmY821ndg2yq/TcGUR40DJe9uB
 uFXUdy2pniyLPFwf50dqmpvFnFqcaHOXWYeXzmdw+br1DcvEhp98e07SgpF6/hW3yPZL
 0TURWirGxTRh2G3K/ulPeP3vLVT5Shb03cUq+nb6fQXhqdMHlS9zwxfP+CwpfyvurwDI
 43VuDLGqXIy/yvkYWvW+vk62HtY7kyBclh4voggO17NP0zWB+C6jQ2zKnfrkJobE+ZER
 v+KwVSbw027Zf2Xx7yT2Caj0d8eiHwK3f30iPw+5nqRcLAFkijeD8cKHKsiVucsZ3w/S
 bhbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzieUmOAtHHTQdTeORMx5hYHnnlo1+Q9ul1dElsINHxM7dViNNGxAxFZHVmIilwWdd2bgYv3E=@lists.denx.de
X-Gm-Message-State: AOJu0YyawEJ8jFpmK4Y2NN6pR5a/VSzAPD3tgscWXO93Pa3LnTOTFRs4
 EeqJdk/0QL6q6JzO5cig2A1FUQXWqPtuIpqKRdpLxuqYSNRdcfIdJf5oFXUZMS0=
X-Google-Smtp-Source: AGHT+IEz3TntV6etCYFYnVnN5+Q18NAWE0kRDkEmmkTiSUqRW/799OdL3kF/de9F/GTNymv/w8PxzQ==
X-Received: by 2002:a05:620a:450b:b0:7b1:448d:ea8a with SMTP id
 af79cd13be357-7b193efa04dmr1953194885a.16.1730240910371; 
 Tue, 29 Oct 2024 15:28:30 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20241026080555.135472-1-ilias.apalodimas@linaro.org>
References: <20241026080555.135472-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] disk: Mark static functions in part_efi.c
Message-Id: <173024090882.2563570.16499100087203568161.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:28 -0600
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

On Sat, 26 Oct 2024 11:05:53 +0300, Ilias Apalodimas wrote:

> Mark all the functions that are only defined locally as static and
> quiesce W=1 warnings
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


