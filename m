Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18392C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 18:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BEF8807B3;
	Mon, 20 Jan 2025 19:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CWspNj3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00714800B6; Mon, 20 Jan 2025 19:07:34 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93BB80716
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 19:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-46df3fc7176so46344981cf.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737396450; x=1738001250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8zCQ8SBkGaTUHf2bAJ1o2v33oOy5seQ+8MOaBTpLeY=;
 b=CWspNj3fdbU6hz6XGSrw8vLk+7vH/umPv8PpWRivjvy9qafnfAYAsXvnk8zxIP6fcz
 gFwu2kK2Ss4kN/0MdlS5fXT/OANYP2UzyxeGuboErxZTuFM1s6Xk/3k8RJuJG8phvjOg
 NxmVKVW7pUfGW0lh/LSRNxfVk+NU0DupcLRQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737396450; x=1738001250;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8zCQ8SBkGaTUHf2bAJ1o2v33oOy5seQ+8MOaBTpLeY=;
 b=Ci0RW8j3wCmxz2qbpQ2Hae9tOcYefIMdvUpxzK4mb3L2jSj3aKXGV9iM3TW2ijY8Cg
 kqPthDtm5p+CTnOCrlHvgsHro1ytJ65+d62+CDfiHFceRUB9v9ori9937Etak+YVfuxm
 /kNL0QupXCHV2Kk8bcOAKN985kuE+Qh/NKO69T+UrP44eYCYD1ghvznwzqpNbdspVUX3
 g/6tZTKhGaYLmQ4M9Y4QR94Cp91ZqSCdPYOVr4aIY6fcrRd3JQ89PbhDYx1DcEiHDZdV
 H4TQdZ8DZK6bdPHMqlYeT15z0ubZRYgdKLKNT8DWCDYnbWBF4wfCwKW92oQuP0b/A2+n
 qcsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxwrAvxIOVjzGet0J20HUn3BoVAPTmLd4AgPRRckyEnA/nwEpIHabskO3FSs1V0vvrcDcwn6w=@lists.denx.de
X-Gm-Message-State: AOJu0YwvGd+LR2Uwqk5uj/MksCqW5CCm+6dFZdL7MKKmN/ilyUBMIXuj
 UWnSvz8Sk7nkivU1JyDnEjTuGeyFWWNdpzfsHQjp/gCNYXDH7Ej+aDaSikvSaOw=
X-Gm-Gg: ASbGncu9V/4x818+xxkdR02o4xoOwN49MBOHKccuxWjo0xPCgjlHJlVhdUaZjjLblCH
 gVWYQXV9i9XGdaqIS4nOgluT//Xx5r3ULG/rmCSBtq9T9ZkYKB9xF3Fq5jGd887w+ED2L249WRx
 HjO23bdHncMsBLzkhY51VhteymElAo/UAnE+5pqwoCfrcSEiQbG+Uyd6zIrx3ZAzfMpHbQ5w6K+
 N9tcM30ffLB+AeHwwR+CAJdYdzo0qom7WxIPDl+0eJIYntikwZTM/l28EUqW7c5Ew==
X-Google-Smtp-Source: AGHT+IEnXC1pi+PHPQM8ih7hqQhSxJR6m2tBdgwk/G1aK1etUZWWRcIlwNRgN9GV20zjzd4t7tSrkw==
X-Received: by 2002:ac8:5907:0:b0:467:5f8c:94b6 with SMTP id
 d75a77b69052e-46e12b57036mr216588341cf.35.1737396450666; 
 Mon, 20 Jan 2025 10:07:30 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc230a4sm43258946d6.50.2025.01.20.10.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 10:07:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: bb@ti.com, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, afd@ti.com, u-boot@lists.denx.de, vigneshr@ti.com, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250113042524.219522-1-u-kumar1@ti.com>
References: <20250113042524.219522-1-u-kumar1@ti.com>
Subject: Re: [PATCH] arch: arm: mach-k3: Delete tifs node in DT fixup
Message-Id: <173739644945.2747182.8237477287486673799.b4-ty@konsulko.com>
Date: Mon, 20 Jan 2025 12:07:29 -0600
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

On Mon, 13 Jan 2025 09:55:24 +0530, Udit Kumar wrote:

> Delete tifs DT node as part of fixup.
> 
> TISCI API reported msmc_size, does not include 64KB reserved size for
> tifs aka MSMC comms memory, see documentation[0].
> 
> As part of fixup, original code uses TISCI API reported msmc_size as
> size for SRAM DT node.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


