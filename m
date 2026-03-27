Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5908D10F2875
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 23:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7169583FE9;
	Sat, 28 Mar 2026 00:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jVnacLAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0433E83FAF; Sat, 28 Mar 2026 00:06:32 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A83583EB3
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 00:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso1697072fac.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774652788; x=1775257588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzd24Q/lZe+/0NjKMtTPEXdQ6y8R4gwEKvVoiIuwCDg=;
 b=jVnacLATfKPOS/bCAlBtNWc61k4vUzO6Y5RtDNKo1bv3e+AA+XN4wlM92JnArEkAyV
 Fpwn2czq2rMKywnyN/sItg1fDbROIj4GfKAL4QWIAbRCxbGuBeQPvOroK4jcQwdZN+jn
 x7TXHq+NbNNwbzMSOQ0EqJvevkJxt8DAc3yMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652788; x=1775257588;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lzd24Q/lZe+/0NjKMtTPEXdQ6y8R4gwEKvVoiIuwCDg=;
 b=oGx3fd6sutkbTBoxPJmXqARQ5xjR8J7poKWzHOHz5V0P0voST7L5Yv+CjvVa3XPhrV
 Ma57iPu1N7G/htfzXZxlieskOqABnXmSGh1xIXCMeoq3yLdnmDFXpKz2v7e6A3QXWk6z
 M1AE3Gj01TWUOJ6mIJmk/55eVCCi2HDW/TLM+xThjCvDN9aJqI/+DYtR0a3H2lAk45qC
 +fcZSzCIZVqDsv+fARv5pOUurH/UtYWnBQzDj+0YCthVhc1rcBpe10u33A6kddwqV7vG
 eSvV2EdmDr5ubRQK3gLh/QNA5qUzIukZCiq4gX1zaA7zbAXEzti1b6oHo045R+OwMFwV
 cUzw==
X-Gm-Message-State: AOJu0YyA7bLyGQO6es95dRY7WKZXf6aZCmsQSpZ+kMpKNSLIb2zyVimR
 lekf0etTv0mlDwvTMB7H/vasxAtE1WXFC7MygGA/HUTAnDpccfGIA+orT9XmylO2kddpakGHuoE
 hDCwCNR4=
X-Gm-Gg: ATEYQzwANPzTBHrBut3igP365GepRxGCzZL/7A2TH2DcKqkXLxEw196M0txl+omgSPd
 yAKrlSe4nE9AlPuLS7dR7F7KqzHhgdsAqXJ5ADfKWvXVO0w/aI6QWxd737V9vQJX8VBzVQmFpmB
 JlaqtqmDe2UL6owU8K3/WDuTswaQi4gOFfWIEmC/XC5cJNiUknCaYmn1jc6SfAmwMwR36fNxsua
 nBCqKB6UXwQZJdawV2njk4b9oholieu2nFHjBoXPOQtMK6kN8Tk896KfBxFJovVfwHj/D41pv+U
 1cH9UHgmOjVN6TLpgR629b2s7PY45FIuMr26UDvhoLEKPZrNP6Gbm8W4y6k6hYR5nf592wNTwOd
 pzh3cVIgtK6rvfD5n8SQuWoYB+ct3z9WfLTgLviM2uUlZnZ3GtqSYOANn/7OHl2WItGvPfJKDxO
 yQev0opFBtJ25ncnypp7+xOinOWJnxPtmkZRHTmoLL487lBRkf+MthjZ7xWIvYSE/pewedevBPB
 kpcVRhhMP3LCf3uCtk9iE8vxsQn3xtB7TxloHT70d2wtRk=
X-Received: by 2002:a05:6870:c0cf:b0:417:d068:6029 with SMTP id
 586e51a60fabf-41cec412c03mr2168023fac.36.1774652787910; 
 Fri, 27 Mar 2026 16:06:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04cf9e03sm421650fac.14.2026.03.27.16.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 16:06:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260315235046.304489-1-marek.vasut+renesas@mailbox.org>
References: <20260315235046.304489-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm: Introduce current_pl() on ARM32 and compatibility
 current_el()
Message-Id: <177465278690.41705.9237547000671847093.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 17:06:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Mar 2026 00:50:33 +0100, Marek Vasut wrote:

> The ARM32 has PLx Privilege Levels instead of Exception Levels present
> on ARM64. Introduce current_pl() function which reports the current PL
> on ARM32.
> 
> Introduce current_el() for ARM32 as well and current_pl() for ARM64
> which each call the other matching function. This is mainly mean to
> allow code like this to compile and retain compile time code coverage:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: Introduce current_pl() on ARM32 and compatibility current_el()
      commit: c3c082aa437d077ab103a8f841137ac3a6fa57e2
-- 
Tom


