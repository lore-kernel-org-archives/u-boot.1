Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84680E63F3F
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 17:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216D98063E;
	Mon, 16 Feb 2026 18:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jFwJygKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBD983B8A; Mon, 16 Feb 2026 18:18:16 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E1480325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 18:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40f20af93aaso674459fac.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771262293; x=1771867093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXu4BwBUjoDD3b/GzCjR/jDnc5g13vS2EpoX+jV+bFI=;
 b=jFwJygKTXd/twsngx3wfNlgK/ecKj6YngkJRQLml/TQJaVnJ38vA6ynbUcxzA702tU
 cXPECWV8YFlh6C8feOYt51eGQbPHXDJCG+ajpJndO0Mfk8AfJ/f3FWSJXY5CTMs684bL
 cZfUOMLex1ptuIVgbBTpL8bFDwuYP4uxk/AfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262293; x=1771867093;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rXu4BwBUjoDD3b/GzCjR/jDnc5g13vS2EpoX+jV+bFI=;
 b=Cv6itpRk3RQfs426NMlcjj3uy9aCQbJ0wJvDc6QcL3NkqliNQlg9GHjIS5Q5Gbme8/
 54bZZXPw0hFbYn6Of+eMqEnmEM5oslmEXHOpJMVzPb+RzlAD0OKG9m7XyYfqPiUCaqkl
 Tg9HpGpfrb1TVM3si/EhZAdRDcJh5YlzSV6/65ubTkGbj3Ukh5jGkm2j0loi4f92rLl/
 QWXoAQhHydJqxSEo6tlzZIgU31NvIJ4uGA5Y1ByN92qpr7PSYeKxunOhDHqX6QQkASxe
 apb1XHv8vy2hqDdoAdPT/ORT/3ty4XvBpw+y2NYvsn5d+he72V3tcnOexeN19IjLLquO
 IStw==
X-Gm-Message-State: AOJu0YxHMP5LJEMb7523UuJEUmEmRl+xZtHiB9FWFYsJ/ro+JHfU2+Kk
 2FJlKgCJVI4EprBg6uLKcMdIjiw3xcE1b9RtbJGF/nNb2D020zDR6VuP8R2PEnxlqWyOpk5LxOX
 AEbfRsqY=
X-Gm-Gg: AZuq6aJLQTewMRt4rSTj4CnacqDSONGgqwLvGncL+G5iqA769Ycf7sRQNO38nw7H+y+
 jT7tB8AJS42wig15lDvDc5oK0KAVUMDDgYKQzGlTpaRYyCvgdjNl7bBaKWgiIwb9Dm01KvRcuNw
 qtkU4YAo4yBFcPUlWplP4VuxjiCCWd/NLvkyT0vfJLtSFwQxRzfRr61iPbiTLjUiyrWlqFcXZwM
 W5xVchaI6XvbER3bRp2gJwc0M0g93fRPuvZYNU7cuo4pe5d48yrJWJOhXukIE9T9RhU8ChPFAWX
 pd/J9OCZ3e+wbWLhK99TF8EZM3/tflEJJnOeQf4TI2daUZZemjhVNOYi2zaajNZtfQmAGt6TXGZ
 s3ksgMiMIvBVhurpE66O0i8YePGRu33iAZEf1oLDkCzJw6ndHl3q6oyWPJgrMmGF7MAAkrxeh2n
 4kC87JoCYK9Aze6LhRVb2y0oW/oCQ1lW75GNyDQuc0p6dcGssHhlhJlKtkBmQnP9OEwrzRwKeQW
 a53Jw6E3EBdEw6d+QnHmKjmlhH7keyW50M1k/lvr/JG/7wbhQ==
X-Received: by 2002:a05:6820:138a:b0:662:c5b6:8e9b with SMTP id
 006d021491bc7-67767484be9mr5150074eaf.27.1771262292820; 
 Mon, 16 Feb 2026 09:18:12 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-676f444f315sm7276998eaf.1.2026.02.16.09.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 09:18:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: kory.maincent@bootlin.com
In-Reply-To: <20260216071056.3108298-1-ilias.apalodimas@linaro.org>
References: <20260216071056.3108298-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for ab-next-13022026
Message-Id: <177126229196.2533124.17378144777995088118.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 11:18:11 -0600
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

On Mon, 16 Feb 2026 09:10:56 +0200, Ilias Apalodimas wrote:

> The following changes since commit 9e6b66409a3235ae73f1937929fe025911165bbb:
> 
>   Merge tag 'ab-next-11022026' of https://source.denx.de/u-boot/custodians/u-boot-tpm into next (2026-02-11 10:42:18 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/ab-next-13022026
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


