Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB5FF41808
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A693E83F53;
	Mon,  9 Mar 2026 16:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fhGg6UET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE4383F98; Mon,  9 Mar 2026 16:10:49 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6095A83F20
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-404254ffe8aso4435217fac.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773069045; x=1773673845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEGyNcZFaoWzYbjYPwj5C11I+8TBOjapJWXP4B7IKxM=;
 b=fhGg6UETaFHx0oop8LluDMzUw21xyS8wFSQfPkPsLESTyGJgICG1vdzNB4m7NPT0o3
 L/l23fpbxOwL/fhDXEC9PXg/gO83+Ptttjq+1Miii7O4+ogrQwis6BhL+JAzcd21yYt+
 6v9lrOqVfef/8gg41DEFTEpMyHpZEVcWjdCPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069045; x=1773673845;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QEGyNcZFaoWzYbjYPwj5C11I+8TBOjapJWXP4B7IKxM=;
 b=vmpr8zwYnEN/uvU0xTVvy+xo9E49Yef+y/Qo4bdJe4CEb7eiuDpJ3e4nt75mmml9jq
 Po+sy6kYxbyYXAxh1DAdxX8tHopDkTFuWwkZZ6N2GgrbUs4Unti3vRFOtbW/XESSoqQG
 +GpG+k+ua+KUjiCmod3W1cZejL97c0BOLUpHr5X1kYcfXvk7gBQmWg5TTCGj5U9sPhna
 rK6xUAJuAbIJqkN36Fy+RjlIR9rFOgP8VhZWL8x3lL7GIyXlPaRg3VO29JMibqQJAeNT
 R5z3uZ+zNQUnOBdzGQUllUcKKRvjTO8/MqPAawGorMbQ/rwe8/G1Kj3QlYkcSoIl+XEM
 IXyQ==
X-Gm-Message-State: AOJu0YzD3bt9vU0OIgKRRp2ataifcAnTVHB1uRWFqG8rMDeuJWr1E1u+
 467TSLvsoQcGo4D/z1z67gq52gxyNkVVHxk9sEKWllOGGD0qTwUfFhtvgP2Yrbnr1SwNryQYnCn
 V8BlRLy4=
X-Gm-Gg: ATEYQzxCL7dqGuUCgQUu0RgkUS1K1vZqWztMpW/3tdqNsmgz7HQwWzV+9VrhBHOmyDT
 PtH3Xl4m/PSAmPTZb+yqElXKOLjQFGzpvAHmaZq05NwThw6wYiy/Qg4dJF6lxeNSD/gf41NbcXd
 jmtYoEXpsd1wbQodTWV+Gd3/NSYv7GhkXeT12uj9POBAUtSHT5/XL+JZAMKNIQ1gZ7mDxPUDMNL
 vCUN2kHuaMuNHav7suOTI6DWt/fHsLnqlglWD5A0GvduGlsmIlpb/PdbwHcE/LIK+7zEfp6jCH/
 bbzaZGI5tbfFi1xTUNS/2kXIwuaroMAcpj3SvLCP4IdWgJSyZzF2i0H4p+Yd+fFoHcF1PYJRsr1
 v/O6AY7VSLQzOvvypkNu80ClaTo1CjUJBa4Rc1RVpurXMToxFFYP3ZH6b9SZKzE54xpPcQ4botT
 xj5uWphJpJ16YxSgJO/SOUuYGYWCB2ulpJZjJ5ZsVrogkCApIo0pkj1lXubvAx07+yY2MjQtLnz
 wPDCXU2XgLu1EJOGtPUa3+xQprNM8sN8GHxi7FmbFeZet4tyiRwKZ4=
X-Received: by 2002:a05:6870:210c:b0:417:28be:32a7 with SMTP id
 586e51a60fabf-41728be436cmr2665186fac.4.1773069044899; 
 Mon, 09 Mar 2026 08:10:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e65b1cacsm9376128fac.8.2026.03.09.08.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:10:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20260221100011.29049-1-zajec5@gmail.com>
References: <20260221100011.29049-1-zajec5@gmail.com>
Subject: Re: [PATCH 0/6] fw_env: cleanup flash_write_buf()
Message-Id: <177306904416.2117441.5373411047335015619.b4-ty@konsulko.com>
Date: Mon, 09 Mar 2026 09:10:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 21 Feb 2026 11:00:05 +0100, Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> I found flash_write_buf() somehow more difficult to follow than needed.
> Some code turned out to be inconsistent and some not really needed.
> 
> There is a set of 6 patches that should be small enough to make them easy
> to review. I was wondering if I should squash patches 5 and 6 but ended up
> with sending two smaller diffs.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] fw_env: use "erasesize" variable in writing loop
      commit: 1197954d5896f431716a61b4242c98c336753948
[2/6] fw_env: allocate buffer of proper size in flash_write_buf()
      commit: d80d88cb87d7f291c7abc9168d69f30f994b852f
[3/6] fw_env: add ROUND_UP() helper
      commit: 2f28f4116a173891f5c88e1ae3de374241bb1121
[4/6] fw_env: unify calculation of "blockstart" in flash_write_buf()
      commit: 1d175b2108d7e0aa74a182ac1ebde58a4f129371
[5/6] fw_env: move "erasesize" calculation up in a code
      commit: ffd8024efcb9868b654b319b29949347e6fe92ef
[6/6] fw_env: drop unneeded variables from flash_write_buf()
      commit: 667fa1a1cd52abe8f96ce903d58322b7b126d9ea
-- 
Tom


