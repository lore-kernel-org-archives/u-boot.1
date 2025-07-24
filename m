Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AD2C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06D383929;
	Thu, 24 Jul 2025 23:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J+2limFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C71583927; Thu, 24 Jul 2025 23:30:36 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74834838F0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ff8d43619cso1082739fac.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753392633; x=1753997433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5MMo2uKHZoaYq+zg98GaeG+EyQd19UF/xTr2aXLKrI=;
 b=J+2limFux7V+b4oZYPsfl11kHpN9AFcazQLo84YWMMWaL00YrIjSf+7NXqLxUy5PsA
 rqYflud5vOf51wHRfkgnWc2ZXbr1Z7erNdkqfYy4mL22//Ou+DAaZ6gdtLULi8tuA1M6
 u2KNKAg5vXEFIGQl2tyaGYxePA4H0ETyIflCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753392633; x=1753997433;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z5MMo2uKHZoaYq+zg98GaeG+EyQd19UF/xTr2aXLKrI=;
 b=o0DVJa8SDzJwd5CK2qGm4TYot2na90+CT+zW3GwvgZ6PyHsSM+cgQb0uX+IOYEW3At
 ZKj5W1wCJDW6UyvPU/ZgYk+nTNshBjHntthf4yofv9WQcTJKF65DNAlh7nq2T68HqEVN
 UYMTJm3s8cizFHXElMO7DNXTGSu9lRPHHAGZCsL11Jr852TavGGOJR5rgyxCZaUDAUKX
 hTsIPdSibadAdwcANv+HInZbSokkeRp11gXHVzrhZ0g0/weCJZ1ODEQYmIJksKebozj9
 qaiCAh8A3wId7I83TzlvU3B1j/+EH+C5j4N7xu+2/LNtBG398apLGb9dDo2pjwnanXd4
 9vHA==
X-Gm-Message-State: AOJu0Yzu28WMWMMu2skdgsCdTeeiP2oEenuS6suph5vnMcvBGfr9XE0p
 ToaVOSOb44Js52EJ6yoCSrNmfo1GCH89aaIKSaxUYd7FeTl/12D83uCbRlepFSPd3ng=
X-Gm-Gg: ASbGncskOekWZLlocx788/Er1kKMAE//fKD0TFym99mevLVjr+Ui6Ihn5eKGIppocE/
 F7ntvlEjHmmuZK6Si6fEzMiGG1tUKUCfZeQ+Vh94aR39sXM2I22sqZnoLj/m3IvNkX+LBmhfyCF
 O2bbGI+ut+iCrt1WEPOtraCsxAzz3SuM0fsVag9YcTcbsyk1TkLdoPjVkb2wWup50CZXgUHPFjv
 M8ifGWu+6NjMuJq1O8lZ+kFzzRixHCoCesQUDR5NS2i4p97faAGCaO9AyC+6U6l18lu3PE6z8zb
 VeXk6Swiv0M0O2EOlu3QR/pirpzawbij/cBi7cPGhojg2i1yMdfUgNSoWQ6GTEMAfj2476LqmJv
 GwhLJeo4mBEjlq6jMngKZwHHy8z+4NZmcUTre2tG7FqPP1cbJeXxZs0jpclczj8bamQ==
X-Google-Smtp-Source: AGHT+IFC3Gk9d0adVgEE90UMNHKjXc+bopvtABpk5VD6vJ3+PcFd1bsK1tS+6CRId20wCkbfeIVnEA==
X-Received: by 2002:a05:6871:b28:b0:2bc:7d6f:fa85 with SMTP id
 586e51a60fabf-306c702783emr5274456fac.16.1753392633189; 
 Thu, 24 Jul 2025 14:30:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:30:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250717-sandbox-raw-v1-1-934ffc784d36@linaro.org>
References: <20250717-sandbox-raw-v1-1-934ffc784d36@linaro.org>
Subject: Re: [PATCH] sandbox: eth-raw: Prevent possible buffer overflow
Message-Id: <175339263239.1899261.14495207607284532963.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:32 -0600
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

On Thu, 17 Jul 2025 12:09:15 +0100, Andrew Goodbody wrote:

> Instead of strcpy which is unbounded use strlcpy to ensure that the
> receiving buffer cannot be overflowed.
> 
> This issue found by Smatch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] sandbox: eth-raw: Prevent possible buffer overflow
      commit: 5c0827eededc8392472823d8e3e50cd0f5fad47b
-- 
Tom


