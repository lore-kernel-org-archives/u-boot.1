Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064D2EE6B43
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80E083B8F;
	Fri,  6 Feb 2026 19:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R+ZiRRip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FA483C54; Fri,  6 Feb 2026 19:15:30 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B9083B86
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45f09874c4cso1636418b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770401727; x=1771006527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJ+FyY+3dQ0yxhan7jE9RzMldixqoLQnYBM3UaRA5OM=;
 b=R+ZiRRipB5Vb9hHaPVFR3eiYg18AIgxvbQ3Ng4n1xcbkzwr85JgMPEOFmHKxmvGvgM
 MrM05pS8yNgBG5A4/SW2lYr7+4n7wKDU2gnjY36CpgBraBAO18Up+DFKHfpFnctBQkGN
 tsO1TXf8zK9UienqQFagcpne/v5TpzavgccdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401727; x=1771006527;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DJ+FyY+3dQ0yxhan7jE9RzMldixqoLQnYBM3UaRA5OM=;
 b=gwfpumTSzRznjY8ht5ehfvX0TcvxZQoiDIw4vnLP3gzfPuuhm25O4wH819AobwxXKO
 jHVyyBUo5nW/jwCKmaJydQe0nuri1NV2n/jxE9KIvjRe1og+mzEcUSVALEmyHGZxd8r4
 j+9mAmYLWITNNcJ7f4c+PMKGK+lw46umCkxKuRsEc1TH7XoMeHudAsbGFpWLLQ5q5TnM
 KJhEKZQxatZkatn/WO1KxHLnVZ98+gw1+rHWhX5cHnHLoqTWWJ2smAXCKtUOeL100NkM
 UeAEaTNu49gcPSnI9/4SxxwQV0f+iXNA+Vj90fhLFTq9fWTtKzCGhPrcORIpXg+32VgJ
 7D3w==
X-Gm-Message-State: AOJu0YyKVBTTLKm8k8PizOMiJ8WaoMnc+7VsgFeEjx8IpeNF9Qi5YxVq
 rYrDiC0rvIAMUIvbq9Uy170N9cuvH8VFVoPUCBgjsiGOn7elB+ejR/1pNbQN3WV67ls=
X-Gm-Gg: AZuq6aLkfhJ2HUDnO71+C3wpts7aZh5ktGDMy9C6Fzs3LW5b8t1MkG9lBMaV+hK4IU2
 9KFU2PfWMQw19sSCMmwTm7OAadXvfuOnM0V28NiddbkO0mrcQsqggXW8hC9oRJiKkxf2/Xe/h97
 O8zhACLk0YNEQL3e5CLZEWN7OgLigkp155sTfE1DBHWxjRVz7n/sY2rp5Q+26i7/1rw7qNU9cde
 K6sbALFkVJZpCEiX5JKw1yok234Mesy6UbgjHqM+7TUPqA0miAuv5e48twqpAxA28vDoOellQUG
 E2zJmPvGDeBW4Y9flH//OMZeV75Tr+wfbIsCcWOFWoOMFtTasIXVS3H9Byk4pEjNjmFHB8ozLkx
 0ZGyPt8+hM5Elsnu4sKdrRSCAWntGTlODRQ4QosstyGUhnL9+p4srbgPbZBX7L5cYUk/0DPacm2
 qTBQQ1GfcSSkb9GBs/ffEfI+ZUQ8CmssJIFCZaNsGOsGBBSgOd1Ip+cuZ6bgQt+PA0e61/212Rw
 in8sf8TXyYE88THAtnC1W8atzI4AgrE2i9DpDLrmlvZLQuk
X-Received: by 2002:a05:6808:1507:b0:450:6eb0:3481 with SMTP id
 5614622812f47-462fcad610fmr1483479b6e.43.1770401727214; 
 Fri, 06 Feb 2026 10:15:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d470914a1bsm97426a34.27.2026.02.06.10.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:15:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260128194226.278605-1-marek.vasut+renesas@mailbox.org>
References: <20260128194226.278605-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] cmd: zip: Add missing unmap_sysmem() for buffers in
 the unzip command
Message-Id: <177040172617.4023747.14247474898125493445.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 12:15:26 -0600
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

On Wed, 28 Jan 2026 20:42:03 +0100, Marek Vasut wrote:

> Unmap the sysmem that got mapped by this command.
> 
> Use symbolic return value for the command while updating
> the return value handling.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: zip: Add missing unmap_sysmem() for buffers in the unzip command
      commit: 109e378e9ba791b8dffaf86aa043f20d41d2adaf
-- 
Tom


