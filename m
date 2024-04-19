Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A508C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EC9886B5;
	Fri, 19 Apr 2024 03:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tY9+b81D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4168886B4; Fri, 19 Apr 2024 03:58:03 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29D788698
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-69b50b8239fso15733266d6.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491880; x=1714096680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2ALd1Ay3EYVrxJhOutoCPiXDcY6nJeSD0wzpam2zWg=;
 b=tY9+b81DMnc5x+VwYFi4N65QkXtyMljG+aqBzN3kmrccdKrCyvl2vl3zTNj2kxh7HP
 WBcVNSOTSdhaki0hd9QnU/DcTDMbih51hbTAaqzN76WZX+epdfg9YOUt7AlEX4SWh4Zi
 cQvnwTf3MZ6+Kw8HBN4N4KAoeVo72PZF8hcfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491880; x=1714096680;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2ALd1Ay3EYVrxJhOutoCPiXDcY6nJeSD0wzpam2zWg=;
 b=ayz3sUp4FM3AnD+pqlGKBKHydHbzLa+uA+MsEfNr1nKBMMCd6t2Vpgpaxv1crha4Ab
 K8tCyQtuByI954l/Qz9k3k9CD2DPxZU9txtpxIDMrvE7zcsGNYHY8ABzx0qUSXSLJJkD
 /ySWSDMmPiuZcnr7dOMIufQ2fc87vYxwnLAmDx0s4vUS9C2HdcO0krNKHVrCUHwDtqq8
 yfuA38IYW80Vhzsa2x/Zrle8WsO0PGpolWwTfUZrRQwuuZH3VK2mhCIna31kuZCVSQBv
 jGDVR+UJUfc8+KvSMSJxTdvYAmoTFTmtQBcKhzw1/GFlZkmwKfEVIbhdvZYfA/aUDmK/
 iSUg==
X-Gm-Message-State: AOJu0YzfWVlv6SxyzNRDbAaOhKw4O6NVYw2x9JCB7OUhjXNFWd4L3FMo
 OjV1OYLC8YYkk6okBREbD721v1w3BNgfSNZEfTqyYi/8kQhLe+/FA9WYCnYesz4=
X-Google-Smtp-Source: AGHT+IFUn+FVYq2cIVojdqZ2TDKcOsxvgFyrkAw8uZT5kFwdQTVTcqfpD3gqMFMY5cPe0dEHU786KQ==
X-Received: by 2002:ad4:4e67:0:b0:6a0:4d4f:9428 with SMTP id
 ec7-20020ad44e67000000b006a04d4f9428mr1392383qvb.32.1713491880707; 
 Thu, 18 Apr 2024 18:58:00 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:58:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20240414183759.146925-1-marex@denx.de>
References: <20240414183759.146925-1-marex@denx.de>
Subject: Re: [PATCH] boot: fdt: Turn all addresses and sizes into u64
Message-Id: <171349187971.1524174.2423013401610355489.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:57:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 14 Apr 2024 20:37:20 +0200, Marek Vasut wrote:

> In case of systems where DRAM bank ends at the edge of 32bit boundary,
> start + size calculations would overflow. This happens on STM32MP15xx
> with 1 DRAM bank starting at 0xc0000000 and 1 GiB of DRAM. This is a
> usual 32bit system DRAM size overflow, fix it by doing all DRAM size
> and offset calculations using u64 types. This also covers a case where
> a 32bit PAE system might be able to address up to 36bits of DRAM.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


