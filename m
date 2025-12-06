Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5F8D3B7D2
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9723C83A47;
	Sat,  6 Dec 2025 15:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZtZ5fElc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001FC83979; Sat,  6 Dec 2025 15:11:06 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F0ED839E4
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45085a4ab72so1613185b6e.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030261; x=1765635061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulEn4rkA0yBsKZahja94rZxw1VGCqIvh/eAB17eJGEM=;
 b=ZtZ5fElcG5AYlvfZ9uX+hLLOdJDEQ1NWlkZioCToClT5Kb3MuJ62DS0CZ8sPPHB/ur
 Pv7E+/4AiJrG28wIVPj1Ke/gYd2JAXCQ71PuY9GDCIbsZZpSJe+p1txn7jeaA2x7AfeQ
 DEu3rnf/RnLjT6e7Md8cBj8o5Aid7+ON7IXXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030261; x=1765635061;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulEn4rkA0yBsKZahja94rZxw1VGCqIvh/eAB17eJGEM=;
 b=TxUMZ47mS82+iEl2CyKV+l2f8DWtmpeWSiFCvwGeCrDXZufV/ItXl1OIfLZj/kylN8
 ciofXNyV8I2F952tLWd5IPWJIbb93J66nqGfAVxr4uWYSXyHbzAbJIcMAtzcs9VkADy2
 psdl5Lt/eWpbpK9ToZSgOHSGcwU6xA4DGPTOIU0hGCmmthQSMsJkWicVSABLduPV1EzH
 EAZNYsaIGfmDCrWFU0ojmUFl+Y7UobE4FeMEWbFfHpS+zntXCLIwtWnMBD5nL9Pv6AZ/
 f7q6C8C/eC8sYhC8xbhk/RMZanEt0ubuYy4I3u/M6NJ8JtOZ3xcfb7fKFQRiBAosalrz
 rS8Q==
X-Gm-Message-State: AOJu0YwpMRWzRjkSij2Y7tYeeX1JoLpkoc4A5fvWPwGk4x2NngIhciKc
 B2u04ay/Kb1MuA0ejs5o3LWeLj7kxIpbgGd+nd1DB9GJewo8D2gpK4TM0FIdk0PQkUk=
X-Gm-Gg: ASbGnctUHPqDn530i9H3sLmOwQbelN4mx9uJFrd7lI1+wVGiaOU5P7rGJ5mFWNjvsAi
 kU8ez+Tqi/sgbOq+Rr56ynwE5Zzh+oPIURjEMeH/iSRv+2+NVmaDkR3tFYGeXQe+Mxu9t+1JVX/
 GkkP4Ar6k1PuJIih+JwWa//VMYmWTdS9Ay1J1Mn2ebN3GtyDhLlTkxRK/uvxs1K36AIT8gEI8oz
 pFRPN9phnxEMRfRO6FcvNo8CoDeyvJ+cjRZMIAP+CW2ai+Qfb33B3wQL+qBC6zyOW7ynhVdAdW0
 EHtcW3aJorDFDXrHsoVlF9kI2DQyg7R+8EqE9g7OStpbO28W4tJjnlm6SpZ+s3T+kZCIQSnd6eL
 7TiYvulipbPwBzMDHfEoXrZT9+tbSMUKb1Goxe+y1W/XaUPOj1G/hX5zoCEOA+iKslqyNQSZlEw
 rDQ4ThHm2kCEybW1OATLKjohyCZ/bjYZRWcF5VWSWmqUXriBkC
X-Google-Smtp-Source: AGHT+IHKLq7BMxp8A1OcxjYG7a1hCO5TgJcGFHg2f+JBwftojOyUBG+krbbNMTrOY6ggDKsw2YVZpA==
X-Received: by 2002:a05:6808:189c:b0:450:abd0:d815 with SMTP id
 5614622812f47-4539df71158mr1136193b6e.28.1765030261077; 
 Sat, 06 Dec 2025 06:11:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:11:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-Id: <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:59 -0600
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

On Fri, 21 Nov 2025 17:34:30 +0000, Andrew Goodbody wrote:

> Smatch reported an error where a value calculated by ERR_PTR was not
> used. Fixing this to return the generated value led to a test failure
> which meant updating the sandbox clock code so that it would still cause
> the tests to pass with the above correction.
> Debugging this problem led to a SIGSEGV which is addressed in 1/3.
> Possible memory leaks noticed are addressed in 3/3.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] clk: Prevent SIGSEGV on debug
      commit: 1c0a46e2918a1ddf42f51449e45077513dd52417
[2/3] clk: Return value calculated by ERR_PTR
      commit: fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
[3/3] clk: Prevent memory leak on error
      commit: 33285945518731ed459680ffb01891c4804fb6c9
-- 
Tom


