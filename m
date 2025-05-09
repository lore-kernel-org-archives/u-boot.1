Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D12DC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 18:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018E082A2F;
	Fri,  9 May 2025 20:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XcNQCGlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137F8829CD; Fri,  9 May 2025 20:57:52 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FA18211F
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 20:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c2504fa876so1012622fac.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746817069; x=1747421869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRmGuiuPAvsA/PFsF1v3bT78U/htaChKf+0t+WUDpK0=;
 b=XcNQCGlN1T1zd2raOxPQFqI6eAclNWZsC5vVOPIVnCJGMixKWJJCsYLgLKtcv4WEI1
 DjnBbL8prcVVOwRzGYRiPUa3QtlwLXS3/7L956+gdcidyly4Uy7ToN1tDefTUZWWS5KH
 7i1bcDC50ZIe+gqRdO2opnkthEtTctFq6XcZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746817069; x=1747421869;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRmGuiuPAvsA/PFsF1v3bT78U/htaChKf+0t+WUDpK0=;
 b=nh4tlFD4YDlP2wc2m/thz6ZhPtJHJL5VlFcvD1E0DxlDxITxQsWqhOrA4boJ7TWKyT
 wY7GZPb/taBcdMnA4jGC8VG7H/okOHylwhr/ajf5c97ppND0X+cuJsNtlZrDapo+2gDa
 sPUkZ/HWhZsTthzkrK5Aj5ZB55Qh+PH+Yw32N7JsqC3eB7B3zCBW5h2fqreax6PSe2K9
 i732ti+GqHx2urOGH0g6S/8ExmxsNspTc4oNnv/vncjgP7PzoAVq3OTfls0V0CPWpGEQ
 0qyv1Ho8fKPy6oZPikxqEgBSjCjoVv7MHn+toGMTOFI1/RjDQKRo+z+kX6KmmUWGi2Hq
 Xflg==
X-Gm-Message-State: AOJu0YyvVwG9aSOf/iRVn0Vye5KHhCLkFfBNBRBh3nhkRX63QJmJ80mL
 eE17FjSCnwqbobOdwxU0ek6rm1wjGUm0AG2RqyKXl716qfiqpyKmqsOiHGyN038=
X-Gm-Gg: ASbGncvN1661DtlKAWc6z+QPr/BkfGHGgUQvnLc++XAGX2ejExxfuDp5R+8HtZ9eKb2
 5GSG6I4J4reebKTReM3njl7TxMNqEmlxB7EdfmGaLwDd4dvhqIPdHbjFpwJQcNMdurvWv8T3gUm
 b6z6StgSlb/GYUtK1DFNP8iMkBKV6LYUoP6SQq4cFOgxbN61/R9tdBYZKJeEEZxlzL/Iju1fXyr
 2T4XRQeQAeMr7TuhRPY2lnGFEFDOYuZ4Sri1WtHf3RdbpmjeWJjNG2po4uwDcS1892XsTPjmOY3
 ffgMs6derzn9p9zaHRujiTP/08FQDzkPL6YtYy7TkyAO/mdGRqjoDxC6d/9KHkhIs2RwkT8k/sK
 8AECA/1PzS6I=
X-Google-Smtp-Source: AGHT+IHDLZ9yfbd5Ee5F44ulLydInNrUpO2/hTWVfzbLdMtVVCyYIfrb7qHrx8KruE4FdovGvc0Ddw==
X-Received: by 2002:a05:6870:a550:b0:2d4:ce45:6993 with SMTP id
 586e51a60fabf-2dba44c5d0dmr3118111fac.30.1746817068671; 
 Fri, 09 May 2025 11:57:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06e7a10sm721707fac.18.2025.05.09.11.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 11:57:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20250226203132.3832001-1-trini@konsulko.com>
References: <20250226203132.3832001-1-trini@konsulko.com>
Subject: Re: [PATCH] gpio: x86: Correct usage of IS_ENABLED() macro in
 intel_pinctrl_defs.h
Message-Id: <174681706738.750074.3379527186845227550.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 12:57:47 -0600
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

On Wed, 26 Feb 2025 14:31:32 -0600, Tom Rini wrote:

> This file was using IS_ENABLED() to test for CONFIG flags but omitted
> the CONFIG_ prefix and so did not work as expected.
> 
> 

Applied to u-boot/master, thanks!

[1/1] gpio: x86: Correct usage of IS_ENABLED() macro in intel_pinctrl_defs.h
      commit: c5f57de37c74b96514723f92cbb656d26fb3385c
-- 
Tom


