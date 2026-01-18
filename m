Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2BD4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 16:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C7E98307F;
	Sun, 18 Jan 2026 17:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hbA+O6AE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079868397A; Sun, 18 Jan 2026 17:26:10 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A0438307F
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 17:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7cfcc131958so2350205a34.0
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 08:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768753566; x=1769358366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t636hJ9NHalISDE4Z5xPjy33G9+c1wkrMQzeWjRFAY=;
 b=hbA+O6AE1dCkhKJI3OhIkXC4KG+Z0QO47iTfMVJomUwg2K9UOrtJyJN1GWXs9R/+SJ
 hgm6jayrgiZGhzn9HcLvXiI4fnoIGQskU7GdyvDFcoJfHRLQKzyXAP16NcnvvDoRMCn4
 BTeILDbOAJgE3J/6awiLSnQ0u5KN0cFuE/IxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768753566; x=1769358366;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5t636hJ9NHalISDE4Z5xPjy33G9+c1wkrMQzeWjRFAY=;
 b=cO10F9V3fFqhRV1ZqLjTlwzs0gOIQBKQ70GUS/BR0YGTFWwNBPIXQLBkIyU1qcdQSf
 BycRzE4Aq7ISRW6Gzq0hOzvPiYF/SgMcB5AGLwycjTpTXgumUzbJ0hhX4jAAtCRhGoK9
 CggXLmcFH8RNiN3T3pgYTdsUtkZFnd304juOgFPDS5aR6JCV6/p9uwjDQVeV/01Gu6bk
 m8Vpx1KCAG8mLjIjtoJq1UFJRYZH8DxMkzi7CYzjrq1M4oj1hvu4pM4vZzFpZFMT6TKy
 /EMa8yKCbq1HaK5f0rScUgiMIJKJhSwh8PO3nNx0eTskdjaTP8GOp5GyHxZNkV4hJpiA
 dUnA==
X-Gm-Message-State: AOJu0YzG97b8PwagE4ZS83qL2vY1kDJVtgs9ggIRFiTluh5ypfhHKSY4
 bZE9+dulJwtsbLflof1HBZzzGuDO3b52mUudq0VuacZr8FzYQrrTYa1LdNM/WxNzVfU=
X-Gm-Gg: AY/fxX49Jfpf3kyMhCYUXD5Vb+iZgS/AG6MurhBsAaXxKN00kxx1J3a9NhDx6fdEVeb
 HvT94ud05pdNSBoH3/ckxQNuROI02pZXa2rTUfVgW5NIffz2yOLMlAwvsd4lX9k1IDDhhqVUWUV
 jnRwkbRuFZSEuOt+uiZ5upQusK2KqbwfT+v1CeM1t8hz6bXCUsFtZGUuL62EpgKsf7Erof/K2X8
 dPKr2N9tEiS3obceOo7MROFmY+6IOR7q6zAaMFB6TfYIe42HnuRdKkZQ6UqxjWm2/rkP6Q6g3us
 plfVzEO4GH/r4ynocV8BW0yXk8/GDnVichTErX+WTAkW7Vgi1LpNiDtIIM8brjxXobRrf3ACKjb
 HQlncvtGDY+L/jp/o10w72CJUEXOKcZr5Rm9MGn6e+AKAz1wXxRZM8TakwwiEBmpaIO6Q5IJ+GD
 jL9nVetmkCcw0R+3a+xB+AZkGNzdU77ghrO1qwVaTeirc2sAci/X8xgPiKUCI/PbR9pWYaanQYz
 Npme76FAEJkUXE1tl1lNlKHCTLquYGNVfRlYg==
X-Received: by 2002:a05:6830:dc3:b0:7c7:5f09:879c with SMTP id
 46e09a7af769-7cfdee52e12mr4222800a34.26.1768753566265; 
 Sun, 18 Jan 2026 08:26:06 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2a696esm5272134a34.21.2026.01.18.08.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:26:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Janne Grunau <j@jannau.net>
In-Reply-To: <20260117012404.187685-1-marek.vasut+usb@mailbox.org>
References: <20260117012404.187685-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <176875356550.59866.15448808545011526917.b4-ty@konsulko.com>
Date: Sun, 18 Jan 2026 10:26:05 -0600
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

On Sat, 17 Jan 2026 02:23:40 +0100, Marek Vasut wrote:

> The following changes since commit 5665d1f4e7cfd6895417d199dd7db73500c5d36c:
> 
>   Merge tag 'net-20260115' of https://source.denx.de/u-boot/custodians/u-boot-net (2026-01-15 08:50:53 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


