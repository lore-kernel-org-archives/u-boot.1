Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F751C83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 23:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF56C83641;
	Thu, 10 Jul 2025 01:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iCB/C0Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC7483621; Thu, 10 Jul 2025 01:19:03 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44B0835CB
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73cdce0d62fso206337a34.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752103140; x=1752707940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9FtDJ7r+l21DZaD7QwEiSUPZGi9IRuXvItRJhqsP62w=;
 b=iCB/C0Yc5wt6f8Jfib693cSELDE3jq79D78z1BHyne9P+Uzpy7qy3MLoEfB7qifImh
 LSicoz5rL79Q7r5iLIhYT6FbkaP3vHePzbHaHB4x4IojlL+oqAtWuRKJQ5Y5JvNjAAw7
 1XKCq2RivNiJqd6BVLNFKxCXpX0GEoAg+7TKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752103140; x=1752707940;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FtDJ7r+l21DZaD7QwEiSUPZGi9IRuXvItRJhqsP62w=;
 b=bR5Qaxe4BEG47v9yfAaMBncMZq4dceE6PiY2Gv65tEakTYlDlV2x83QIibOaO1OGPA
 0S7hKgpIa8/Vr3ni+vRfSjJYriXrXDXTxuCFS4p96U8ppyRfyivNvsS2qs+hG2Y+RSEF
 a8QnPw9URxMLtz3pZmOy7xD2xsrv5n6BBhedI5OCxTk+oH4Bu7/nNFAhlw0E3lh5gUo2
 WbI5gHnFeKeUNTJ4WZxL2adcUr9DtBYinmfT1y4XrDc38FblXsKrfd1NHICfi668EsRZ
 S5uW9GO+RB0F9z3qgkjjavCO/mHfQK61PD6WCalYNbXuyndCi3cq6bnR4VqynaBSWphS
 bX6A==
X-Gm-Message-State: AOJu0Ywqqv5/SWrdOYBf0B4wFCSi067oGl7F9tZHlUBMJya64UvkuvtN
 KWkX/kfEDrEWsZSs804djF/t/mrd3nxlG1T04Iit9x4MRROvQKrkK8Skv5LBf/ckMTCQTa/s+BI
 YHaquEx8=
X-Gm-Gg: ASbGncv07//ZZtWXNimVbn1ALooKCQKgA+/SxX6YTsIlpJsVxCHKUtrxABy+Jl5zdPK
 JbY/dlkKK89SE4OxL4EkkbEgYqamoZmce/rDCY8m7FOStzarT8B0FLsxqOMGMcpunU2Q7j3Uq5X
 7qdTW4Dgemju+WURb13tuEeETfkZPuw1ArAbl3O8xwlx+ommaZ+SXWE+9PnXqC0+eE7pxvv/aXi
 Z6y9HvdlrrR9qPOm73DqI+6k0WV6nZpZHgOXML2oukWHweqT7zC7NPgzGvFnPC9k5+h47lqj80y
 wZx1eDm4w1Ysoe3Uhho2AWYAE8VttjAfkvZCwQ6cePupAa2QBIHtzsylIflILdx1mM55okTuwP+
 Cbjjk+BW4Z9JWUk9QIm4=
X-Google-Smtp-Source: AGHT+IFib8RQVwvriZpt+1YZokW0NhbfeVOcinCMWnaF+tobvqDaRXzT9qb+Sjbk+2wqAIk2c83hig==
X-Received: by 2002:a05:6830:7010:b0:73c:8758:bf62 with SMTP id
 46e09a7af769-73cf0659953mr364116a34.13.1752103140434; 
 Wed, 09 Jul 2025 16:19:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm33211a34.34.2025.07.09.16.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 16:18:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250701184237.3191452-1-trini@konsulko.com>
References: <20250701184237.3191452-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Remove "universe" command.
Message-Id: <175210313910.1870480.10288142268351795720.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 17:18:59 -0600
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

On Tue, 01 Jul 2025 12:42:37 -0600, Tom Rini wrote:

> We have had no platforms that make use of this since 2015, so drop it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: Remove "universe" command.
      commit: a517081af9d90a2c6c14b5c5d2633de2bed6324f
-- 
Tom


