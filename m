Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C6EC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 23:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B6482CFA;
	Thu, 26 Jun 2025 01:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nV7QcY10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CD282E71; Thu, 26 Jun 2025 01:52:23 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17FD382D21
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40791b6969bso339668b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750895534; x=1751500334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMg4WJV4+694JEH6omQXxD2vugWfgBbAnCwLZYoAWe0=;
 b=nV7QcY10cF6LW8W9LcgQOGkmQr7Ihq1vkE7rV7ZAAEtRwny9aQ/w89VG6HJFwo6b55
 SbvQuhj89GCjMbqx8MbOIAFe51Kwy6RkVy00hsFFaqMbX7gRhAki1VCz/shQapjJb46y
 IokGML3SjnSMl9Kxes3iFHnkJ4QwAV/YYzWOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750895534; x=1751500334;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMg4WJV4+694JEH6omQXxD2vugWfgBbAnCwLZYoAWe0=;
 b=Y3yigdPZKC4+ag1iv7NWrw75j0ArhCJziaYiNE0I+Za8om9mUh+9VNBPgw8LegOTnG
 zkhaWuPzotQ/MbtE6dsj6dXZMknWd8EvjOgTWzfw/xK4akibFXYQchrmrr3hIFsgTQp3
 4lTjQbI7E4SpH+soM4ftYzblw83bChb0SYdfaewakQ06IbFpQe86LCzr/DrWbUaj1Z2r
 85PwtoLsMdqDbLFUna6lTkVz/Ks+Z0EW5OCNPDKwwlQ+wAtaO6MqPCNy+1lJ1GoXi9LI
 GzTIrykGoUXZaTk8WQFprdzYmH9mnFeJLgaCdgpyY3PPzpkchXnsldoc7mHv0EF+DUxS
 973Q==
X-Gm-Message-State: AOJu0YzvhaB9ST54ujR1W8PTpF7LtHm3uRc5kT42D583ytPDZbP7jAxe
 /kQmRSFII14pKRFjyow/a1NHU57nXx2nRF8ngQIMyhBw9qeeduynOEsmn5IvMUQv/4XGGqE+js1
 kP0uMWKc=
X-Gm-Gg: ASbGncszYodbG6MeU93q+BygR/zjmYQMyN2W0o1FdQa+hg33ZFnvgQUxcZTJ/fIAHqO
 5z6Px+T/pr46hHEX/e0GF9lEG4wfQAnfmbQn/9WOfuNikjCiAruVjvY4KLzJ1WeyA3VK+lAhCi4
 TvR3GxbYZNkGc4zKb649HyukRX47Cdbda4Qh04i1uAK588KrKzZn7pIcNhaVhRJ4xTGiv+6+QDt
 9CyD1hGP9Qb4BKZUtjTn0U70kDD2TECdLNi8SPCoVbxClOQ7WDsVdCb/OMVMi2qIxgZPxz5rG16
 GLgOn51K3MwgIdTzI1763yj3PRiNGhRRvivQ8MPPaOZbXIBx921uJvoYwzSk3aD1IJcbWF7esgU
 50J1MP1tO4RdKT0POPMQjcYZ8yKZOJ9nT
X-Google-Smtp-Source: AGHT+IGiJ3Tn2og2cHdQVp+G0LjNfzK7+bwgogeEJhDNgmtTh6O8bvKmzXHgmvmVK1n2uRmTYA70Qg==
X-Received: by 2002:a05:6808:509e:b0:409:f8e:72a8 with SMTP id
 5614622812f47-40b057c4125mr4307427b6e.23.1750895533799; 
 Wed, 25 Jun 2025 16:52:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6b3052sm1751134eaf.10.2025.06.25.16.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 16:52:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>
In-Reply-To: <20250602-am62xsip-v2-1-c652cab47d40@ti.com>
References: <20250602-am62xsip-v2-1-c652cab47d40@ti.com>
Subject: Re: [PATCH v2] binman: openssl: disable JTAG access by default
Message-Id: <175089553259.1525333.15725223730662221119.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 17:52:12 -0600
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

On Mon, 02 Jun 2025 16:56:52 -0500, Bryan Brattlof wrote:

> Typically boards operating in production environments will not be
> monitored and so will not need JTAG access unlocked. Disable the debug
> extension by default (set debugType = 0) unless we add the 'debug'
> property in the binman configs.
> 
> 

Applied to u-boot/next, thanks!

[1/1] binman: openssl: disable JTAG access by default
      commit: e18472f1dee609b2ee8a492985bf77a5012e4d01
-- 
Tom


