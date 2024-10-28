Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B18D13592
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5940888FEA;
	Mon, 28 Oct 2024 03:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bCQfGxYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215958901D; Mon, 28 Oct 2024 03:53:27 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BFAF88F2A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 03:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cc250bbc9eso29544556d6.2
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730083990; x=1730688790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYUIuVrYyPI0TAOgNjXrWcsSCp1hzojpWkeVxsye10Y=;
 b=bCQfGxYeoPeBwxcfmPWGH3Eu5ymjnLXofO+XhxCYeek0EPuRCt43bJcboChZGw29Ze
 qTWnMBVjOR7loff2WTnSGgo3aGITAmP1lXb0BpoXR+C/5J1kg49vPrji6C/vcV7p6hyr
 /4jdSz4Y+OLYbwU6bRT1wji1BWtWpmKDzUOoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730083990; x=1730688790;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYUIuVrYyPI0TAOgNjXrWcsSCp1hzojpWkeVxsye10Y=;
 b=pI5dYNEdYh7qbsTsedJz+YndvWI+wW3y59lYVlxzq5jSxii3glY92RTVtnGDPZFAHJ
 FEVcQPVhPVkCY64l+FxVKi0pFnzcvKQqfNQ8xlWQnZ7LDR6GYLVSBYuoVzffPZbAu00E
 4IVuB1KmoQDHJMekG305+LD5RM0cbNy80a+ZSTQ2oY7O60jdo1jahDMQZWRzi9dojLQl
 9t3zEb/aEdd6ggq6WIMbP3hSHMTqaoCOHf+31aLADGFPnpP3WyEMtjkdAvQ+FLZVX+YG
 wzFG9i3ypSiBNZE6PKAFBAe7zlVWVpEiIygZXttlHm0wW0W3eYqv73A4DlQtY+60QKIm
 OomQ==
X-Gm-Message-State: AOJu0YzZv7FICYhZcxe09MMJ8tHrn+ol3lYIZlG9ao8KbCNTdJydeAY1
 UBQvw+zAevJQTOUwtVr+knFXlHBQOajVY+ASLBEwlJG+6iQSNsB99Y7kwTP3O40=
X-Google-Smtp-Source: AGHT+IF2N7yHRZNaioQTeIWF96NX4vCoF4ydOJJk+anrn45si9sXTXJKgKC9Rn+w+DiMhiBXHQk7Pg==
X-Received: by 2002:a05:6214:419e:b0:6cb:c0cb:c07d with SMTP id
 6a1803df08f44-6d18569478dmr97052706d6.12.1730083990478; 
 Sun, 27 Oct 2024 19:53:10 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1799fd4fcsm28497146d6.92.2024.10.27.19.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 19:53:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Angelo Dureghello <angelo@kernel-space.org>, 
 Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20241025170700.74440-1-andrew.goodbody@linaro.org>
References: <20241025170700.74440-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] x86: Missed removal of CMD_BOOTEFI_HELLO_COMPILE
Message-Id: <173008398854.2202883.451613261072776585.b4-ty@konsulko.com>
Date: Sun, 27 Oct 2024 20:53:08 -0600
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

On Fri, 25 Oct 2024 18:07:00 +0100, Andrew Goodbody wrote:

> The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
> of BOOTEFI_HELLO_COMPILE but the usage in this Makefile was not
> updated. Fix it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


