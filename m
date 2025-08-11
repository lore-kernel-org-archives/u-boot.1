Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02DACA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE23A8329F;
	Tue, 12 Aug 2025 00:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NjR3NuTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7923832BC; Tue, 12 Aug 2025 00:21:03 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50E1831C2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3e54f38a595so6210965ab.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950860; x=1755555660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DE3+jhv9oncRUvk6Dv5RQBMjltoTMs5RFgo3CAeTHjA=;
 b=NjR3NuTpeCm2SdOEF66H9jJ8zROZZejsIYRFStA9r+J9K5P2uDxDoE0133+0QVA+8/
 31zEZoBQKw8EZBN4tqrLSpGZ9QALa4isF4wGlGfqP9qzOuDEPQiCFe/jIcBJ9nLmAe8+
 M9v47WbHMqC4P71+p+UQlokVSNNU5FsVkRzHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950860; x=1755555660;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DE3+jhv9oncRUvk6Dv5RQBMjltoTMs5RFgo3CAeTHjA=;
 b=AdH1sEgWpTCbIEnaxB48ezspxqtVnHMh9HEZ9dUahqS3o5p99w+xRG9hySQhrTz16/
 nGOAZJ/CF3GL5JMDB1zdTvDIG8V5MMlLn1VqYdSjYP6OP6wi1Ry1uIiv7kJKqjFLepYZ
 HBmNIayq/9gwGvtGmN2zPhkD0NPfg8sDzO1UWc0ArQTppWn1UKcn+w9H9atKuXKJRws3
 7QSJ/j7PuHCPGu/aajFPs7V/+c0+/BsUHO/qQA6ir4YdkfSi0ui+rII4V2PNUATZoZhM
 GFggWHm3HvsuuZk+WaxPxxohw4oklFVLhIaDeL9OoAYRIuHq0/i72FGXglq75ivaTOun
 IO7w==
X-Gm-Message-State: AOJu0Yztj0uOtyG2UE8w6339z8F6VcxvWsu3XHDvb4LcfYcgG8Ux+Nn6
 kT6occ1yM5gIJ3ujoTlOrXgBxoBSjaF0Dj5Q1vqj4vGdHTvyVDlh9y9YOdmDnG01wnfcVKLjghH
 7aIruazg=
X-Gm-Gg: ASbGncuBMb5qpHP13A56YwvUtLUVAySMcL3m02w96+91Q6CZ4JVBoRgn0OposPR75cq
 zbub4EYKpK5HGLCw9pbpHfBRvhTFpsrJfsOoer2JXhse7yv2YXWe+HlVK1I2aTZCl+rjIHJbgUO
 YSih440R0zbf2OvIzlcWUyG3aOK7Ky0PnWxNzze9NspEHYPge4YBd7C7k6SeYTZ8YdMrhnKeoJt
 rBYdRvXQEYC9fvVxFIJ4Jlxl9D+9VNgLw1ulSmlzWeSIe6Sr8Q6GzTMdN11NuAhNyPqNjb1AmLF
 iiwtQp3VkCLo2kHsM9h1D7brxiuhM7ZS+/N685Nt2jcsRmImbsjhFniiyLwmFET2qsCIorccCyw
 HwpaRTu5tXjeouw3RXZKaEcVGgCBffNf+VvPG4yqduqCwPhF8HM+83Uk=
X-Google-Smtp-Source: AGHT+IFCG+C3rA+UAL854QMqL1TDSWbnh8BfaFCV///gL6S+GA61D1i1Olmt8AumaQxq9MxUAX2VOA==
X-Received: by 2002:a92:ca09:0:b0:3e5:5937:e54c with SMTP id
 e9e14a558f8ab-3e55af2ac30mr21329455ab.3.1754950860368; 
 Mon, 11 Aug 2025 15:21:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:20:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250718011552.1334023-1-trini@konsulko.com>
References: <20250718011552.1334023-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Add more dummy functions to mimic other
 architectures
Message-Id: <175495085958.1657597.3591473320262575007.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:20:59 -0600
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

On Thu, 17 Jul 2025 19:15:52 -0600, Tom Rini wrote:

> This adds more common functions found on other architectures that will
> allow for more compile-testing of drivers. These are either dummy
> functions as we do not need them or mappings to existing functions,
> similar to how other architectures handle it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sandbox: Add more dummy functions to mimic other architectures
      commit: 493c3da3ac530229ca4c4caadd5df041f6c25eb2
-- 
Tom


