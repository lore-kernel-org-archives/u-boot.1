Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413C0E7DF0A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 16:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD3283EC8;
	Mon,  2 Feb 2026 17:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oloflQGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813A383F15; Mon,  2 Feb 2026 17:54:35 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6209B83EC8
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 17:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-662f9aeb782so2986742eaf.3
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 08:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770051272; x=1770656072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8S6tjzpXEIM+YM0T9MZW7+lzx/q0ltU4aC+WGjg4YMY=;
 b=oloflQGhMx8UROQC8izUlrAonsXcK71dqIh1l/sIYIsJr9YpDHb9bGaELW3TpDrIk5
 kVJnREzWs3WTrruqJ5q1QqW5WYh5+mqbtWHJZRdPhWQnLg8iCLiHf6S5Y2IeTDmUG7yp
 JD9YIwAivM42X8AmsDwX0WXYgevsPPYJFMD+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770051272; x=1770656072;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8S6tjzpXEIM+YM0T9MZW7+lzx/q0ltU4aC+WGjg4YMY=;
 b=PI3/W5VJ0cZ+Gg1I6HgC1+mA6fDpCH5pzvene3gtoObl7Bd0Wm3glLii53tzoyFoqH
 nyNmQXakXxzSt+u+nO9UfOIcjvibIWPcUtwaLlw0fcK9XiDCiGEyMjctaFo5zKqFIFKp
 +R6AyxykUhStqdwbN26dPUlSFcL6bfqsNi7eenx4BzJhn5ASt0ZTEaQ0XDNW6YTlkYeu
 FhhoaY7te7teLeApHACoNY5U8VrCT9jErtbN68Pni6n6Ia54f2B4IVid6cZhTQ8yps26
 nyBpbnEEoCqDE2UuzuFgyXtqTPR9BrAvyVs2GPRbLR7DWmE5q7TqE+rnFGOh4g76aUBI
 PTgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdunQf9Oxl+UYsGTQFsvi2wDvS5sGzqiLjdcWpV0I9kkqfR9NMXOdqrn04q6X6iqIb40sFkzU=@lists.denx.de
X-Gm-Message-State: AOJu0YwMJSLPn1iGwS6Nm5vRqrfxW06NuST7tub3gNFGlwW/QKrb04PW
 fInPIiZ7xk/+l93qNSG40MG3A/KagNjFeo0gkZvYAEnAnT7YMAzVXK6edkOK+9448cLwLrZ7k7I
 KQ2/OmqE=
X-Gm-Gg: AZuq6aLplYcw1SuFwMwJpQro/XLJwlGbjJoY+jfGCN/yONU9xsADhUVl0NBnZxDOhtV
 yDS0gaX6gKPazKga/ncKnZouRn27Nj8EZ5ZgvYlkNpQ4FYT3tI+aVakoqtf1npB/bwNhnSiJ61t
 emZ/tQz/ovT+K8PbhNQVMbTDJM2j67uEkl/p8Aan35W6cNp0GhHj+FHCJdBPoYXol0bV4tMlPIO
 oKImkGTdYDKmzSMT6td/85p6hc8Jt5dg9JnMK1+4uerywqflmNs4V//uTDZvESZUjK1MG7Blyet
 92vKEEJa6H/CwwFWghtylyqMLSMVEoPMgS9b8EkL5Rn8O5Nwswc4Lgaylyt5A0OkT/QgEqFs+7k
 TB3ZnJTYaBDcqxkoNSf1xUfdqvtppDg8g8oiS1b8ZpPFcM4PcXwmDMbw6XPkzMM2pQsaom6/3SH
 2o8NciEjApxHWfoxBqdcRsS3jQTjK7jTtlZ2bsJAYXqBNXr36bRP5MTdjZwuydAigflI2Pa858q
 FDxFCvZKNRx3D9I3AxJMFB59I9YkS/zDKf7/Q==
X-Received: by 2002:a05:6820:1689:b0:663:d1d:5fe6 with SMTP id
 006d021491bc7-6630f3a15a4mr5778345eaf.55.1770051271945; 
 Mon, 02 Feb 2026 08:54:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66311d7e446sm5964901eaf.1.2026.02.02.08.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 08:54:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260129-boot-image-fit-print-error-code-v1-1-20d8edfed856@baylibre.com>
References: <20260129-boot-image-fit-print-error-code-v1-1-20d8edfed856@baylibre.com>
Subject: Re: [PATCH] boot/fit: print error name in boot_get_fdt_fit()
Message-Id: <177005127113.4027196.17907235920694778110.b4-ty@konsulko.com>
Date: Mon, 02 Feb 2026 10:54:31 -0600
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

On Thu, 29 Jan 2026 14:03:41 -0600, David Lechner wrote:

> Print the actual error code in a couple of places in boot_get_fdt_fit().
> 
> These are FDT error codes, not errno, so printing the string is more
> helpful than printing the numeric value.
> 
> The only caller of boot_get_fdt_fit() unconditionally replaces the
> returned error code (fdt_noffset) with ENOENT so the actual error would
> otherwise be lost.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot/fit: print error name in boot_get_fdt_fit()
      commit: 8bca63d2ed9d73ec2ff83fa76510245e48e29730
-- 
Tom


