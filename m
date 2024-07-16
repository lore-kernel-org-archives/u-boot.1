Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03174C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 23:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324818875B;
	Wed, 17 Jul 2024 01:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xo7hrnPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04E988A12; Wed, 17 Jul 2024 01:00:56 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B403887D4
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7035b2947a4so3493205a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721170853; x=1721775653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0vE+iZmvMVEb/NOBKKMJqu/7dXpPpsH80cjAy2m6jg=;
 b=Xo7hrnPWHBX6hcMcMxxysbOivAM0fUmXKTFUF/OeenYOzgcPLqwZcBlJK3/LFlSZ6z
 tN4Yzn4keifM8QR2BqceGsE/Ms7fsyRDAswQajxbXdCO5SNImKttRSAvvd30OSCn2MWM
 u+vbZWFxWZjI/EePPuqkGQcScIaR9KPYmONRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721170853; x=1721775653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U0vE+iZmvMVEb/NOBKKMJqu/7dXpPpsH80cjAy2m6jg=;
 b=FYe6m3e0CSKzyy4ybLcT4b9zcQ8FiCE0AOHZKFCyn+EjN6g4GRHqoMye3AnreohZB9
 jSbjqTxjKH97dZ3IWhDuuToREOpzckqqK72v+MJSNuvKjdZgRRXEZGfa28VmPTWcOPM3
 85C9CFeypQS5ZcxKW4QgycuhfKYmS2MZ2Yw0/ghUeCVi+RAXVVSAtKqxVFOjsi2HPpJu
 rSa1WCuyDERlCdSYpqTuZMlDsqtqqmTqbgz059/Q7DRlhWIsviwX9aQ7Eq9wAKvTGneO
 9bbsaY4ziqn/oJn4XQH3HXRIUKsPGalIiyAGqAVilxChw/g88ZFJwApamKPIqhV/Yeff
 BGSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqM4gUsasTxZhKYdYPh3Xu03sTSD/Hg8Vt7hJEOb+17gXJPF8mzxaPrjobr7CPOUwnT3Udcxkl8C2QmSI+he/DaR/1dA==
X-Gm-Message-State: AOJu0YxIUZWNSXwVxeJiDRpD7ldfz07IpIbruYM9FWMPEricWswG3BJT
 iESo7zbq55aloTgurlEzwE5qWMTb/d87nqiU+/QVZW/l29dR4fsmEHAo+c+OaK8=
X-Google-Smtp-Source: AGHT+IG961zu8bUbNvmwyoDjIjJdwTZ2LEY3fSwUrFG3KpvIpP9AJL5koWJfdvQMe+Wd5eqzEcMQ3w==
X-Received: by 2002:a05:6830:dc3:b0:703:78b3:841 with SMTP id
 46e09a7af769-708d9965b74mr4946250a34.13.1721170852933; 
 Tue, 16 Jul 2024 16:00:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d2fcc2sm1510063a34.77.2024.07.16.16.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 16:00:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: hs@denx.de, pro@denx.de, Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de
In-Reply-To: <20240628173543.129207-1-vassilisamir@gmail.com>
References: <20240628173543.129207-1-vassilisamir@gmail.com>
Subject: Re: [PATCH v4 0/3] drivers: bootcount: Add support for ANY filesystem
Message-Id: <172117085188.763145.4197913169835738060.b4-ty@konsulko.com>
Date: Tue, 16 Jul 2024 17:00:51 -0600
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

On Fri, 28 Jun 2024 19:35:40 +0200, Vasileios Amoiridis wrote:

> Changes in v4:
> 	- Add bootcount.rst in doc/api/index.rst
> 	- Fix typo in documentation
> 
> Changes in v3:
> 	- Remove specific CONFIGs for filesystems
> 	- Add message to prompt user to enable required write function
> 	- Use tags from previous rounds
> 	- Move documentation to rST
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


