Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC728C3600C
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 16:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BC581E47;
	Sat, 29 Mar 2025 17:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OyM4/pRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A35F81951; Sat, 29 Mar 2025 17:37:05 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1912381E06
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 17:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2b8e26063e4so1672442fac.3
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743266222; x=1743871022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJG9acheZUAAO6mtfacXfKbQ+VsEQJkCn+u/ElezAl8=;
 b=OyM4/pRq4fVp+3PfGhaizOPv/1gtP4em1TodmTflgOaS7ZHvPUZix+hzgbMm/k1KMD
 hMA76RJ0zwiNvt4oS31OqNf07Mw3GtVHw/O4xEHtIuP7jWA/VNa73LPm+l2JjStqRSBP
 sU4T/87ZAVeSGcBm2OscC16EYstQI70qyInnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743266222; x=1743871022;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJG9acheZUAAO6mtfacXfKbQ+VsEQJkCn+u/ElezAl8=;
 b=tjS39UcPWr6KSVUrSv5TKUNmfDANpL5wcd6KrwMN1x3G9IoVBLiyHDSfdiN7zeWW4y
 jJi06ST//Mi0ekhItINbBNXfUxmfefao2kxXn/vLQewU+4YQAmHknCtVyd4DnD+ENbZf
 Qoen1NjjNwCTppgXXc2qaOlwqbZpCyyRUkYyYvfyHWgrZgZ5REUJpTPnVX224BWKqteN
 +Ufy/scw9S4+WWwgIc6oiUEQ4RQhmqwhgh1wOfboE4L4Gjx3IzvyBMYoDVv1MdmogiSJ
 aYfGi118JDy9yUBrIkfnMXETLQ6uZUczKfPzgNuhUFTSpigj8RlH5Bqe0/qvtNPc+IhX
 azfw==
X-Gm-Message-State: AOJu0YxZPJe+boCEvR6amuIGWlC57krvw2W1fNSF3OKEPRgTlRQ16f+t
 6EDVU24ywahbc7QfCkNn2ADMaBysZtU+UrUiA2nqKupb3Mg2dY3cD12PDML7TpD0BPt5IgA+stc
 w
X-Gm-Gg: ASbGnct7c6HDOEnTzn1gaSwQ6pqAJe15rPV3lZ2OEdZyr3UePcvHmlMVNFsWgJSFDNp
 ER10N+TRdYRggw3L5J1e4EXBK19qpHYC2+YmTaQwVdBD2MObaDdPt7V7nkfDNa1tRHBJgcSDD6/
 DN7hBxR7DvmsQfLUn2yeqC9CW25gblrwZFd1Ob5yLG0bo7X4bdyO7l0rdp3GM5p1JwLAS1jbU/R
 8Kg8SW71bZAUFYGZemNT2HKftLuQ/b1pogmoEPzHSlnXtBQs9YZp6Tfgd8zB6LxB0S2yGtjcBsS
 EZTWJn8P6ngQtyqmyzsGe3gvKZT7CknsZMSweTNzOmBU+d1psHpyWTcWI7uJwejYKYXXxruCs4s
 4NP5e
X-Google-Smtp-Source: AGHT+IH4jxcPktbPrzKvwd1EOgewjGgj4QwEO0uOaVQ9ILsxdZnxexyvFc68gjJQMBq3sqwTuHYUhA==
X-Received: by 2002:a05:6870:9a8d:b0:2ca:e0fe:acb9 with SMTP id
 586e51a60fabf-2cbcf593760mr1962269fac.18.1743266221872; 
 Sat, 29 Mar 2025 09:37:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a91391esm925094fac.46.2025.03.29.09.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 09:37:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250328-mattijs-korg-v1-1-e3f61c80d767@kernel.org>
References: <20250328-mattijs-korg-v1-1-e3f61c80d767@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update email of Mattijs Korpershoek
Message-Id: <174326622059.1009412.11099891194910266626.b4-ty@konsulko.com>
Date: Sat, 29 Mar 2025 10:37:00 -0600
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

On Fri, 28 Mar 2025 17:29:27 +0100, Mattijs Korpershoek wrote:

> My preferred email address is mkorpershoek@kernel.org now.
> 
> This updates the MAINTAINERS files and adds an entry in the
> .mailmap file.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Update email of Mattijs Korpershoek
      commit: 5e74863ad6613df9c69c576910b536e885083d65
-- 
Tom


