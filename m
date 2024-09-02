Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6E8CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 16:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55CC88498;
	Mon,  2 Sep 2024 18:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uRzj28YO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E9C88860; Mon,  2 Sep 2024 18:18:56 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C019588363
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 18:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a7ff6c4fd0so275172385a.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725293933; x=1725898733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXR6z2prSnNqwqQFYESP1+NfDTGW9iJmhuY4WDL5ljQ=;
 b=uRzj28YOMwvjxwF2lNAov4p7OH+8IA60bKKGeKLjfo2RCXvzdyWpZ+Mp6VKpF+TA7s
 tW7Gsuy2RtjRO05E0x09bdVg80b0WnF1B5Kf8ZuCMjbzSGqrRK8NkaI/E959zQ5frxT+
 3ze/9lJPemlYXWx8+qkjknWjmMnlM9+1keA1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725293933; x=1725898733;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXR6z2prSnNqwqQFYESP1+NfDTGW9iJmhuY4WDL5ljQ=;
 b=FreTOklpZvA/O1f/4qGskOk2u70QEYVbwa+DFbDGQapjtLzdE+BIfWiSV6i/k4ERDZ
 uhbF6D/M/3af1A5LU1GWyKasL5kBOIuwTnc8An/rrOSVPFhOBfD173JpANYNNX5MjwF+
 74wbqcjLYUUHFHZbNgGhRUE9428RbyRJ8w59xd0cxTOIabICyTZfTegLuvNSVt2gcyYm
 EsNpOg9opYI+gPY8uG4SVg6HCjpAeZMZ3Ub2xVYvSjgnTiFwTMhqBI1NfRIdLK8n8Gil
 zPPPHe1YDvj9oYsi/xJpmyl/5YZRjxUumZXIYNa7iXwqaHmWNaZsBBBeN98rwk89M+cI
 ArAQ==
X-Gm-Message-State: AOJu0Yzg7CZcaL/AgY7A0m19TWXrv04PD9FbdZ9u0qCOhDAg5ZYCiRg2
 KsklrE0CEt8hhW5dsT5n+9mk4gMKyjW4p1w7gpbcIjzT94R7gxofFL3p750ccNg=
X-Google-Smtp-Source: AGHT+IFTGdCkM0siJnIXjS40wFjo/umNnTzpQh8FfmJykQy2Olg+ABLmWTgS3NfxmT1uqt8AyM1RgA==
X-Received: by 2002:a05:620a:1a21:b0:79d:7ae0:ffd2 with SMTP id
 af79cd13be357-7a89ac15371mr883373785a.49.1725293933373; 
 Mon, 02 Sep 2024 09:18:53 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806bfc86csm433632685a.1.2024.09.02.09.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 09:18:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, git@amd.com
In-Reply-To: <20240902095357.311-1-venkatesh.abbarapu@amd.com>
References: <20240902095357.311-1-venkatesh.abbarapu@amd.com>
Subject: Re: [u-boot-test-hooks][PATCH] travis-ci: Skip the saveenv and
 reset test cases on xilinx zynq qemu
Message-Id: <172529393203.1461948.1630194782950346662.b4-ty@konsulko.com>
Date: Mon, 02 Sep 2024 10:18:52 -0600
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

On Mon, 02 Sep 2024 15:23:57 +0530, Venkatesh Yadav Abbarapu wrote:

> There is an issue with the xilinx zynq qemu qspi driver during the erase
> operation in dual parallel configuration, so skip these
> tests for now.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


