Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FA4C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF54D80EC0;
	Mon, 10 Feb 2025 21:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BNAyM9mL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E7C80EB7; Mon, 10 Feb 2025 21:38:57 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AA580AE1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f666c94285so42804787b3.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219934; x=1739824734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORceNsUG0WcERo05lOhGPCTn1FUqHEbMPT3zqsb1bAA=;
 b=BNAyM9mL9Rf+t5KVj0EpX0o2yiZwjcdSslhW4bgeshufG+v0o8DwVPdnW2aqq+BlVc
 vXq8EL5QB8BqkngHirH1ciCyxgZbmIgzViOwpldr2ZHj4iG+eA+OktqSAJ4TEFM447UP
 lXHL7SIrK4dhSoMvzheFGs+eG5OqP/TV+NoqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219934; x=1739824734;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORceNsUG0WcERo05lOhGPCTn1FUqHEbMPT3zqsb1bAA=;
 b=M7zLjsKWHEDlUC9+KpqHusdpcaS7w8lFPW1OMx16zIboW/jslFx1dDUVXXS427rlEq
 fMLXG3aR5g2N41bLj/I6XizYjA+ODPhABVhLLAF4Hz0HlOpBzQVZiUwCgwNlpjs507hW
 +7Qi+k0kGYIPsIBSDZjtWp4h4DyQS6LjqZLTBlR5rI8nf+NT7+oomoi/6totKpd1JQkY
 pRefR8dHu+ytX0E+8H2ux6kuPMd2dZNvTU1K6d23ruVqjf3eYxK6GWhjtX/hFDWJCY2d
 6eFSXz7tIKSKtrI7S3iwWV3r3IFaUVf1kJ6KIxbkwMnoMx8RCGJGDreF+OOdqYj7OzcA
 suAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaRcVHSoyzgi5taweAFcVwOXwJ/2beppielSwV7H9+gxZkSWBxXcL3+kTe0wiwzkCXOyVrbW4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7kfBtrfHwfxzH6P43uEqAf9GMi4761btW6qx48ssFNzB2W7oE
 yy6dIqeaKw94DhCOHz75GfwPqcFIhl8nEZNvPfZQUJGsmnEFkSlkw5WWksCrRuE=
X-Gm-Gg: ASbGncsc/Nb7AbVrx+096Az1P4RctfBjTXw1ZS2hIg9ka1bdAAco2bLmvLdtWZLJ9eP
 IDZhibrz3VCPn7LOEhw/gP3Y8i4P8DRQCVsR4yJZZhdzbQfUMlY1gENlOleZ0zbC16viznhv0cv
 2xchrtY8NYcmb16uqcHJfhaQ7MMpfAV9CFAXbQnj7BSlCo6Qs7+UdOgoHrYo4ghKIwooUgrWXpE
 2Lynawvm0McVTutyDlUUga0MJ/5hjImQTHQl6537KJqvEAptn8KZ2KqUIqSZFwExtiNV7tGiKwD
 TDxqas8NDg1eIg==
X-Google-Smtp-Source: AGHT+IFHXUibpXXvsvXA1Q+nkqXZ8gUwBfabSpYgg1FnQmVkidzNoYFTFFdI7bNlFZmvAGB8mksY8Q==
X-Received: by 2002:a05:690c:4a0a:b0:6ef:8dd0:fff9 with SMTP id
 00721157ae682-6f9b280fadamr129317607b3.8.1739219934304; 
 Mon, 10 Feb 2025 12:38:54 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: w.egorov@phytec.de, nmorrisson@phytec.com, upstream@lists.phytec.de
In-Reply-To: <20250129103444.3463044-1-d.schultz@phytec.de>
References: <20250129103444.3463044-1-d.schultz@phytec.de>
Subject: Re: [PATCH] include: env: phytec: Add optargs to K3 files
Message-Id: <173921993333.2921783.13587832287302387057.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:53 -0600
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

On Wed, 29 Jan 2025 02:34:44 -0800, Daniel Schultz wrote:

> Add the optargs variable so that we can set optional arguments while
> booting.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


