Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CA9CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155198361E;
	Thu, 16 Oct 2025 00:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TKGpS2Jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9DF2835FE; Thu, 16 Oct 2025 00:57:31 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9529833F6
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7b7325d8fb5so81323a34.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760569048; x=1761173848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VHFHy/R9EOD+SHzY2b2XjavvcyF2pWPmRw6O7DwuyQ=;
 b=TKGpS2JoMIgtfju7ZLHbwS0r0LyW6ZCzUWCUlRAa2gGISvIPsPCJL3vDT5teUcK/0K
 ZhmNZthPauB0ug2/t7y89BvsVvqrp79JkzpuRCTJMjGp/t3GdCNQhfpMkMmD/YW4DByb
 GRfVUuZ/0Q8Rk6/xR25+LReD9wtFlfVtW2eWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569048; x=1761173848;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VHFHy/R9EOD+SHzY2b2XjavvcyF2pWPmRw6O7DwuyQ=;
 b=oTLMdiJuk+v0uLX9x2/y4kQOnpS5B5VOEGmA+LGBdMXdOjNQiLyqQEjzKrrhLOzmor
 hB8ydq1PQV+6KwseO+MsEkhECf+lam4U3WBSIgImiri4AcLR8TZdXJPr4HWD8RlETCp4
 HBpR6wEXgJOpIUgGybmDvn16VSf6m/8nAyoyEkdYgXAkkqhEWL9gDk9YbVGdJpR7SQYG
 T9AVhAiLqo59rEi5+l52mwCPCAkqhHUHeLnS8QS4JRvn3R/k8EUCIemYXvq5jQ9KSgY0
 YUeWSVX8cvvU5gFl8QES75cezYmiOe+PDQAn+ktJCPwTTkz4bjROR0dqIXPveKLyaDto
 0jpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuemghDPd0yNfjO8g14nbW1jVmDcvGn3WFRUvFSjaSAVoGXkRhTL9FSTZmfyHTCmU8F5TyMWg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi59aG8trYYOAC1/thtTDCrMV15Cv5/vP8kADDIsyhmuPLdZu+
 fdptZw3UHXzjY1qJiBCuhsisCpLF53vb1grblziYu0MHXWVHyYOGHTOrYjzyfuqbIu3lxHTzy8G
 FSBkjWuY=
X-Gm-Gg: ASbGncttQVU2O18nFS5zIozrn9mG0EjE7qv+ZQe2ImfxbOdzEDnHwQJ+X7gQ9XbAtnI
 FgBsqYbWOJSm7F7iaglpVW8teQYjrl14pzLEBxVal57OQu48UP3jvoIQhX16lK5IWXLH2OtErEA
 G27bDadi0B65RNOIxrIukCoq3oQJUnjEyBMpJVeaowsAtG5F5cZxx258cepOyD3w/J0LrNbkb6q
 pvpX9j4rDIpf0keXx3rsdK83ugw4qYheYNQkMEl79kU/df1hin2fH9EQF2pI2PcQdqk1bXBmue6
 BPjBsv2Mo20rHbcsqCjtBYrP7pgN33vb1DZE/cgmagaC1K/GQOiwzeKYwHV+OJqS2ipOu5CX6cv
 6M9fXG3ZktFXZa6vAca8lFXsDqCDzg65DmMPVEPhIl2YYEcBnod4YgsjCL0EGZt61V0gaNzEi7B
 4rCKNb/aT4ncIBFdW5teAs6qjsPoydwZJnhAiw3g==
X-Google-Smtp-Source: AGHT+IF7vNRNOPlPP8uAxzvIXi1A3hBReEw1hQ4yKFrApqj/LoQnZFbrOFWiyNV1vujIpO6krKRlBQ==
X-Received: by 2002:a05:6830:d8d:b0:7af:1d61:1055 with SMTP id
 46e09a7af769-7c0df784309mr19185845a34.21.1760569048583; 
 Wed, 15 Oct 2025 15:57:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911af78sm5774854a34.29.2025.10.15.15.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:57:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20251006154825.1557055-1-ernest.vanhoecke@toradex.com>
References: <20251006154825.1557055-1-ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH v1] arm: dts: k3-am62p-verdin: migrate to OF_UPSTREAM
Message-Id: <176056904717.760819.3985290306321734166.b4-ty@konsulko.com>
Date: Wed, 15 Oct 2025 16:57:27 -0600
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

On Mon, 06 Oct 2025 17:48:20 +0200, Ernest Van Hoecke wrote:

> Enable CONFIG_OF_UPSTREAM to receive automatic
> device tree updates for the Verdin AM62P.
> 
> Remove the now-obsolete device tree files:
> - k3-am62p-verdin.dtsi
> - k3-am62p-verdin-dev.dtsi
> - k3-am62p-verdin-wifi.dtsi
> - k3-am62p5-verdin-wifi-dev.dts
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3-am62p-verdin: migrate to OF_UPSTREAM
      commit: 77d11d2f7a374c23a0cbf81a98760c9e7613317e
-- 
Tom


