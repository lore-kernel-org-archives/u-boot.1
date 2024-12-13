Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40DBE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 23:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E9F800D2;
	Sat, 14 Dec 2024 00:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g1s3rKaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D86801A0; Sat, 14 Dec 2024 00:16:50 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096F5800C8
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 00:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-467a17055e6so19851321cf.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734131807; x=1734736607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqN8Zt0ee+fXr482dlAlb4jDE1cARKDe1STK/23LY8I=;
 b=g1s3rKaHshwb0m9RMVOssnA4YkyoAv+w/5tx4GnhVsjB2vjEVslc2IOKxRLIh5b29W
 8vVf3RoO6S8V/LC8SCAuMHzNbBydezXKeZiFvUn0NH1lEeRCDqe8fwzw+MHk2W1dP82j
 rZ+6n/lE/ecvKMx3F2T00+MI5o0M5hV4YpFCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734131807; x=1734736607;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqN8Zt0ee+fXr482dlAlb4jDE1cARKDe1STK/23LY8I=;
 b=Xs9S3lQ7W5noZz2x0kQoaHO238kia7LdMJWAFsVeSByjLJhhRvoNNZ2l4mHzJO4euv
 vkW94qqsLG8zcdhmaxDpk3T8v9Hq04TF2UbmQGCVJyevjvixjVqVNUsi5vXfeG9ozWHd
 oqKzi3ldJyowzNYnVY0i7G+iDbSu3zbwJnV5P4KYke4HLp6BkosCW48QNmSiDWlg05P3
 NEzkkvzef+Be9UQaw25pdUHIRIIGDNxt9a+sIiaVEHsxPUolos6HXyL6oyDyuOUI17db
 SGlQjGkYmOnd4uxYdUXUeSediO8YLPbZt9QcRzNMPLh0tqCPK6upoQKiVUPVc0CQzY1C
 YNgQ==
X-Gm-Message-State: AOJu0YyQyRcBuPx3MXAuPKcfUZE3ZC8qX7QQjQMxiB7wyN4VK4jKPtQ2
 V0b+1+nj+o1HwRiw5caunD56oWkaGx3HFAhf5wTuUZk77WI2eLq8WYxeEq6zKIU=
X-Gm-Gg: ASbGncs2zj6pytxteK0rruVqQQ7elVw7apNZvpeTRu1qwwy/+qsMWrPWn1nBL47Bpd4
 9TY352Q509odsN0m8joshOf3pAiaEjlEUNfqC2Mhv8NVXWKwniBWzgFMg3yGkA0ZoKFZKcNJoEX
 i4fcwGtHwjE+EqaZ5sH+UjGDFvDjrQvV8DISf/cugDwfMoPi7XIoulgjKlH0APA27Pw8TGpt/ht
 2fls8fx81GDl4gFcrJzBHLNsUFnUmo2zfRY5EMZ2jPfSVYK8qiJs1Q=
X-Google-Smtp-Source: AGHT+IE6L9ec4jxEu+dXvmXfkrfWmCp/J6OXCbuAvoKVdq55BrRB8i39Uz1oMDrPiYByeB/avJg8zw==
X-Received: by 2002:ac8:7c48:0:b0:467:5f17:94d with SMTP id
 d75a77b69052e-467a584d2admr70502881cf.52.1734131806920; 
 Fri, 13 Dec 2024 15:16:46 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2cbb69asm2690171cf.39.2024.12.13.15.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 15:16:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, vigneshr@ti.com, bb@ti.com, 
 Jayesh Choudhary <j-choudhary@ti.com>
Cc: vaishnav.a@ti.com, afd@ti.com, n-francis@ti.com, seanga2@gmail.com, 
 francesco.dolcini@toradex.com, sjg@chromium.org, w.egorov@phytec.de, 
 devarsht@ti.com
In-Reply-To: <20241126070614.47136-1-j-choudhary@ti.com>
References: <20241126070614.47136-1-j-choudhary@ti.com>
Subject: Re: [PATCH v2 0/4] Add QOS support for J722S and AM62P
Message-Id: <173413180427.1760624.506383810694444636.b4-ty@konsulko.com>
Date: Fri, 13 Dec 2024 17:16:44 -0600
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

On Tue, 26 Nov 2024 12:36:10 +0530, Jayesh Choudhary wrote:

> Add QOS support for DSS in TI K3 SoC to route the DSS traffic through
> RT queue by setting orderID as 15:
> - J722S
> - AM62P
> 
> Changelog v1->v2:
> - Rebased on the tip of next branch
> - Corrected the commit message in patch 2/4
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


