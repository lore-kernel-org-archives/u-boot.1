Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D764CC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D5C788A0A;
	Fri, 14 Jun 2024 16:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PdYGIURV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F7B88A0D; Fri, 14 Jun 2024 16:54:28 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF35F88256
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f9bcb57482so1117552a34.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376863; x=1718981663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8SLFQ2b2tm/1xH8kd4MetNwGRmaJhr/mT0J1Z1+i58=;
 b=PdYGIURVo0AsGw6brqo6IkVy9sc+vCW6YsrXKjlSPECOgwFJ3kBdGzG1QTW/vADNx4
 90iQmnEa/h0rPIyovF01gOw9ilcOrGTNFLyRzIozJx18Hg56GpQWIJjuojVvbvVUNdo/
 3vHt1kFsjTdODNnqHeLaiMBFYoD80QomxZLwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376863; x=1718981663;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8SLFQ2b2tm/1xH8kd4MetNwGRmaJhr/mT0J1Z1+i58=;
 b=uhjkoDGQo43FkZDw9Eoax0T2wJAcsVLm99qMgKT19bn5METDawywo0ynD54L01cbAr
 gXZkAkFGby+wpvSe8SUpAex0d7Y8VBioeMZ4qrM2Trirjc1LHMZdwPD8P2OvJ9Q45ciR
 gDhND+J1ijcT/VHp5ERIeJicYH7Ma059ciKnwgyfwOHdR3yeF/hL23BvjmdCe4j27kW8
 C80suuvbi/pXlvMY6AWXfuopmTXqu7aunwA9/ubkIdnV0XSD7am2ua9aDKlVFgGbOc+P
 zbaakPW/kcN+vvJc4XSJjH9y76K0d1TpcwUJ1KKfG7HYW1E/jEg3Zmy85zzlAcf5FfM+
 vt6g==
X-Gm-Message-State: AOJu0YyhjvPQ0M8BIuSvagKcM5Prs+1TDO1BjsXNUe7eEa6yxd0n3bKP
 MRkBOottVxMujwGhaZ/OF/XUNMZFlT2AM7M2CZn5ErboEd8B8fbj9jT4Pbo5EDE=
X-Google-Smtp-Source: AGHT+IE3zBCHfLb5RrBMWcLpwLH+BdKPkg/n/AAJYgMfXT4LZbH0Vw4Pg6DqFGjv07LJ41csJiQjRw==
X-Received: by 2002:a05:6870:c18a:b0:250:831b:49b1 with SMTP id
 586e51a60fabf-25842c15e8dmr2967131fac.56.1718376863588; 
 Fri, 14 Jun 2024 07:54:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa2fbe8sm986898fac.28.2024.06.14.07.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:54:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, 
 andriy.shevchenko@linux.intel.com, masami.hiramatsu@linaro.org, 
 sjg@chromium.org, u-kumar1@ti.com
In-Reply-To: <20240529060559.301132-1-n-francis@ti.com>
References: <20240529060559.301132-1-n-francis@ti.com>
Subject: Re: [PATCH] env: ti: k3_dfu: Drup mmcpart for rootfs
Message-Id: <171837686223.2655592.3663115016908920955.b4-ty@konsulko.com>
Date: Fri, 14 Jun 2024 08:54:22 -0600
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

On Wed, 29 May 2024 11:35:59 +0530, Neha Malcom Francis wrote:

> According to [0], raw access to mmc should not have mmcpart in the
> entry. This was fixed in k3_dfu_combined.env but k3_dfu.env had been
> overlooked.
> 
> [0] doc/usage/dfu.rst
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


