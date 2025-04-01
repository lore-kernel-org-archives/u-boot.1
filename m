Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FB7C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 20:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E0D481FBC;
	Tue,  1 Apr 2025 22:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FmcDlC1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BB381F7E; Tue,  1 Apr 2025 22:36:30 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237D8817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 22:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5fcd61e9bcdso2647643eaf.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743539787; x=1744144587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xv1GzSpuVbj60FT3qUwiyHcLRVqJM11kjOQ7xoUGSj8=;
 b=FmcDlC1pHk2ZmjrOuL95ymkG1XHrqtGco4FD8BpoHsYbvX98eNvUIrydKf3v/GTKPA
 vzgND+YZDj0Ykcjx19fLKmrtC5YFHw3GAV8cC4UnKzie8f95Tmmz+LoeCd03UOWvZZ6g
 BCNeJ0RdQmNOBpUDZPq0fcbvsP8aLeyV1RBnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743539787; x=1744144587;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xv1GzSpuVbj60FT3qUwiyHcLRVqJM11kjOQ7xoUGSj8=;
 b=upQosfdHT8DMLqIH4rFLkDRjD2aE2C4SNH/n31er5UYu8DcN427oGBPd+n5hjtmlyh
 rY9yzII3d5sfUb9ODYQOu8eNSCfYomLDQsx52pIH477cLw9skV04ZLXHhjxfjX2Sijrl
 D2ohVrhVq3tk0oicahPYjUagP5d9TSIjZv4OiOwChoAk+d1LYsMUfW1vwZXIrMz/9pay
 cdSnaZ+1liF44xFKXOhqtB6H+1xZRyScYj23QwMX7twN4p1KY3exPasKYOXvj3O+BgVN
 CPKZ9bR0hh/gJpNkzXprpE8iZJAYRIKHWJKijT6Wwsv/xdZZ5tqcw55P42764VNBIUqU
 VUow==
X-Gm-Message-State: AOJu0Yz3oHUUbZCG+9HVHqwvdIz5CgjaD3GFmpim/UoFoD2ahrJbj9G7
 AH66a+Y+Q4F7VoQNwFctdc5VmqCmVTRnW6OEzCfIeIme7g3DOu6cMaGrUfFUINuT/S6OK9gH+/6
 U
X-Gm-Gg: ASbGncufVO45KxEnZrc74pROoF6BBPjvWlKijratiBjaq4ssBmD/vnB978NebI8wyR5
 a/jev5YjvPwU89MWsTZxotRObq/IKbdRw1tX7pyjENjS47yFi1VZRCAFKC1gSXkE41wvg1R7PvE
 QVgCmL/+EIp7Jroo5C0+H+gGMLrNXFG0C5KjknocpeTjaqw00nIkvj2sBHXw0GHZLskqRTOIFZ2
 y68xLGX8pT95aN/+05Dxan+JHnNMAUiLNAfIlAwLaY3AGuXpvNfl+8M6kH0L9rJj7WYMVuApyRh
 9SZjAYIBVPjk6uQ2fElv24R4DswVlnSwoLQwDOykBK3az7txv+tZcbQL7Bkn1woTJso1/veI4eB
 OoHZq
X-Google-Smtp-Source: AGHT+IHFO2BEL7ia+QHnuwyb8nf2i3Ji99QR8Fx15rCVFYRUGRgW1u4xlE0G6EePSM7yawb56tmIsA==
X-Received: by 2002:a05:6871:724:b0:29e:24c7:2861 with SMTP id
 586e51a60fabf-2cbcf50b8d3mr7276800fac.13.1743539786754; 
 Tue, 01 Apr 2025 13:36:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58266eb4sm1956027a34.51.2025.04.01.13.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 13:36:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Brandon Maier <brandon.maier@collins.com>
In-Reply-To: <20250316080027.2896821-1-sjg@chromium.org>
References: <20250316080027.2896821-1-sjg@chromium.org>
Subject: Re: [PATCH v2] u_boot_pylib: Clean up pylint warnings in
 gitutil.py
Message-Id: <174353978597.1112159.17116080556778263640.b4-ty@konsulko.com>
Date: Tue, 01 Apr 2025 14:36:25 -0600
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

On Sun, 16 Mar 2025 08:00:18 +0000, Simon Glass wrote:

> This file has about 40 pylint warnings, but no errors.
> 
> Quite a few of these warnings have been there for a while, but most are
> coming from newer versions of pylint, where people come up with new
> warnings.
> 
> The f-string warning is the most common one:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] u_boot_pylib: Clean up pylint warnings in gitutil.py
      commit: 3703298e57c8d749b3c06798f5873562754fb84c
-- 
Tom


