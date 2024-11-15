Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76E2D6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39984896CF;
	Fri, 15 Nov 2024 05:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mr2VTsTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC1989689; Fri, 15 Nov 2024 05:28:13 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E2CD896C2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-460ad98b043so10859071cf.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644890; x=1732249690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l93RWZDhHqK1hHLbX7hZWJUnj9zJTwhG2C3pmhWMVLQ=;
 b=mr2VTsTozntR4G8KZmTwPz9eEp8tSwglVe4pJ73fe0TM8bF0PQHZs36Pwrgr5481X/
 irNKz69qEsHzTW2neIbEFaJ89mfz3q2P6GbnFfXB+SCyQs7bxYawr2I/QbSqczo9BQjV
 Sjb4NCy03Qh2ZAy+XE64/iisvosWO/U9B7ioQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644890; x=1732249690;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l93RWZDhHqK1hHLbX7hZWJUnj9zJTwhG2C3pmhWMVLQ=;
 b=d8kVqQFygSz+hDvx5NJhBbcRZuqzRViTq97iA3UfdNfgT4HzQdmyLsjBd4k4fHd23Y
 L9hlbEXI77f2SPp/OsRy5lKhnWZFkFzfZVsBhQh4sRPEtHfRok4dG3Qhyf8/s7is6pFi
 ct3/3pI+cfh8EmUTQtdNeSNsGPzJ3H1P8uqlHy3GoU8QlziimCmQfNlpFzztmsA1BCyQ
 cS1Yry2pcHrItbjjJIVqUsvpb0/tjLRUSKaq9w1CRsH3HcOE9VADSGStwtkM4ThPVXyv
 cc8nDfWSMYWm2sSydk9ZlJ8T6P0uDgNKaF4XJu+46e8AozgHI/QOhKWddzREKEhDs4nt
 ylNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWam6cXZ2NZD65iUavI0Rt4vbN2EboMG42dkNzcL4bzN3CxIUZkGFzlvvIHqogeBvUkEnNukXc=@lists.denx.de
X-Gm-Message-State: AOJu0YyefSLlplVAJs9A+mS/EIvOrGyMdNZYUHGnLMh+k2HxOWpscORL
 l9sqP4iOR5aFDPrsVvme9nc6fZeAuDVjSFqQtR72LYNUj67E6YbFFMVKRX41wZZAHsBQFHWC0se
 TdIQ=
X-Google-Smtp-Source: AGHT+IFy16zKSBNmHkv3UKf4Bhy1QNHo3rYpa++TjVR3u0afI3+lPQs1Xbs05439y2lg6K1QAFLaDg==
X-Received: by 2002:a05:622a:4e0b:b0:460:b18c:ace8 with SMTP id
 d75a77b69052e-463635aaf99mr24930591cf.21.1731644890447; 
 Thu, 14 Nov 2024 20:28:10 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:28:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Andrea Calabrese <andrea.calabrese@amarulasolutions.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20241109174845.9227-1-ansuelsmth@gmail.com>
References: <20241109174845.9227-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] .gitignore: add test overlay .S and u_boot_logo files
Message-Id: <173164488836.1205089.14995372147543745894.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:28:08 -0600
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

On Sat, 09 Nov 2024 18:48:44 +0100, Christian Marangi wrote:

> Add test overlay .S and u_boot_logo file to gitignore as these files are
> generated and should not be committed but ignored.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


