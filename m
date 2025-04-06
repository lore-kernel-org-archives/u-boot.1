Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD471C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CE282C55;
	Sun,  6 Apr 2025 17:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S5eXHTBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B5082B9D; Sun,  6 Apr 2025 17:38:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F38C82BF2
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bccda48cbso2159725a34.1
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743953889; x=1744558689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rf4DfcNgDV1KrcqXiv0k3QYVzn0grAVwPc9xTWaE1sU=;
 b=S5eXHTBVVBgNPBH2bNKO8jMyk82Gd9y5YkN+aP4SlnhdxW6amWhH3k1kXAXChsPL2o
 Xnnu55z7S/c5dCxFiu+QNM9H8M+yF0sd0nEm7IOFJypvKp/AlK64rqWtmF59PZtyROZG
 HY+GfL57aOm6dNBpQlk8IzA5TW/8U7ZFddDPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743953889; x=1744558689;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rf4DfcNgDV1KrcqXiv0k3QYVzn0grAVwPc9xTWaE1sU=;
 b=PUYWFJyrtQTHmYmuI7lpj6QoUv7QWKKB9bgs2wAPWKW6hQnq6tkVctETOjh/A5R6nq
 h6fuMuGl7faVTGiORr9/zpXHe1J6Y85iIK8UucKvvno3ce75EmpY7l+NxjBP4D8IZ6G6
 2PagwgLsN6K/jwaLDgwrrKyZ6Rviib+HXRSKi8jxuEkEuMgvpa5DxuaaeSXs7b2IkqXn
 h2GNZ71ubi0iPyvgCFw5sobHFSvCA/dOCYuQH8Fdrjk1QEZnRspQOYCD9HCetIwotlBt
 fc8LlsPLt0q9n0kFjlahIRE3vKRJW1rgag9gTn1/lrgOo6urGtoV3kKAO90i7dLD/JHf
 GbnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZiXCQgckD3zLc4PpBFwLkiyyEDMkbisWOwR+//yp5mrYHOcoA0urm8VtuUzPYFPQgHD3RnBA=@lists.denx.de
X-Gm-Message-State: AOJu0YzcNRZ/z2VXpgqesvlVbu3QKRcDuOlXl+3Z8sEZDeWV7YADImOK
 6jpZcbNDCFC8iUrqMj3gga/ikaob+/Wtcea8tYdlnNEV6t6uyEuKwJxBircjmXKK4lx4QyDRQGg
 O
X-Gm-Gg: ASbGncvb1H+WbQwnHrLYsLkrbp+c9j61lxZyEUlR99DAopt0/8DbkTgP/Sy0mYhu+kR
 1OTLi6BuKHiF+euIqeR3PMoxTqW2fHP/xWFDJtsc6CMH3eLzfKQa7CnlyhusCqGCsnIL5fXOWNp
 2BmH4p+ZBqJRpozFQr30NxGJCn77xxqQ9fovVhYS4VxPLQ0ThGhHsgMXO9Mm+iEjQ68qJeCAp0z
 LV0D3BQeu1XbqXrgk/b1OAd20ADnWgu+XUV6/6rxWt63ooCsduRjSyCniZhDN+URJrlCPGO7Jt+
 ZvECajUDkec78V96FwBViYORXBgDWmXRbl1YLuTg906kdSEmIu/jcGgPMHuSCQcRPTQ3kNddGa1
 bInwO
X-Google-Smtp-Source: AGHT+IHeQCOXpOWrChi+LLovxe0c1kALSH++MDEwDTNGunDzOk4pVd7u/OIZDgbEfoPmImByRAX4xw==
X-Received: by 2002:a05:6830:4195:b0:72a:ec6:7fc1 with SMTP id
 46e09a7af769-72e40e53d85mr3342628a34.14.1743953888763; 
 Sun, 06 Apr 2025 08:38:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4cddd6sm1447384eaf.15.2025.04.06.08.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 08:38:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: s-k6@ti.com, w.egorov@phytec.de, u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250320062733.917277-1-n-francis@ti.com>
References: <20250320062733.917277-1-n-francis@ti.com>
Subject: Re: [PATCH] arm: mach-k3: k3-ddr.h: Include spl.h
Message-Id: <174395388770.154794.13265019131169814302.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 09:38:07 -0600
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

On Thu, 20 Mar 2025 11:57:33 +0530, Neha Malcom Francis wrote:

> Include spl.h to avoid definition errors in custom builds.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: mach-k3: k3-ddr.h: Include spl.h
      commit: 4ee0d2ecf4e356d9d46a8880f4ce45ead4ce2d4b
-- 
Tom


