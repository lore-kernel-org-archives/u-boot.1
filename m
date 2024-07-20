Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB08C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9EF388914;
	Sat, 20 Jul 2024 19:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mzBSCJus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E60F8884F; Sat, 20 Jul 2024 19:10:27 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3164988892
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7044bda722fso1707920a34.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495424; x=1722100224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaNFEjwx8vzYuQDClLckpJk0PLBjWkcGZOvvboeL3mM=;
 b=mzBSCJusiwPqarKA/GBwXaz4wqOJWHvDVAJ8K8vVv6egCbP7fM7ieiPyRvWnIrXNHr
 yMvB7QALL2/dQlDSh/Jo81mA0KiFjeoEJHghzW9gWZFC2zHYFABx8W2Ye65PDy9mtt87
 +Mszn/sLGC8GQk2S3RBqq+iL4aTTKY8nhpxg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495424; x=1722100224;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaNFEjwx8vzYuQDClLckpJk0PLBjWkcGZOvvboeL3mM=;
 b=VQ23fh/zURNLe8HoBybNiJGArvnUOXFm0NqlHN/R8EHD5cSXQ6G/nlC0kpplQhuYK8
 JSbep8G7wEVTJyAuWK5x5LqJtvEVMbbbEu0qr9DaSvx4gts7a6hy/EGusOw5WGLuomjV
 51n4xs7Yv7nARbihCLvnbSRS1mzWh4V3lJyJ9ZEQI13MP1hlhgcH4Vyme4S2YsX0bglt
 VdvTxuJZLhn0xRi5c2+N8WpdZHzfodHbbtmLnywtAUYk8maNVd66jyL5RcITWXVj+WmQ
 91pcMquxYTbl8VhNgvc+/C6KtqoiWOgb57KPN2wlSFp4hR8nuR4ExiuHcekB9HOmN9lQ
 P4fw==
X-Gm-Message-State: AOJu0YxziiAKuGpXRKevxX5FifJEnEzSJ7BUWWwLKnumXeTKNmdMZLih
 ONKD6mQyrt0BsBZ7AdMsuSYk5Ra32r3/nKSXiV5aFOtE9YIiSXTlCT2Hx+pb5V4=
X-Google-Smtp-Source: AGHT+IFkejJsFvvK9w8zUjSkAzQJrFHyCZFhwyXQdNtXn7kIM3P7+fspHuvivad8C1MoXzTRMkoipw==
X-Received: by 2002:a05:6830:660a:b0:703:6d69:55b0 with SMTP id
 46e09a7af769-70900980004mr2968864a34.31.1721495423957; 
 Sat, 20 Jul 2024 10:10:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <20240717174118.845390-1-trini@konsulko.com>
References: <20240717174118.845390-1-trini@konsulko.com>
Subject: Re: [PATCH 1/1] test/py/requirements.txt: Bump setuptools to
 70.3.0
Message-Id: <172149542293.3268377.18272047172087227694.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:22 -0600
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

On Wed, 17 Jul 2024 11:41:18 -0600, Tom Rini wrote:

> There is some potential security issue resolved by upgrading to v70.0.0
> here and the latest is now v70.3.0.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


