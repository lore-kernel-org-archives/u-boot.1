Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FF3CCFA02
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 22:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AC388BBE;
	Thu, 26 Sep 2024 00:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ujsYNfuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6ABC88906; Thu, 26 Sep 2024 00:17:46 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D6388A24
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 00:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a9aa913442so27935885a.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727302657; x=1727907457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACcOP8bAJA3BghOQB50la0BG/hh2B5n1SnvrSFI1/RE=;
 b=ujsYNfufgF6x9UA9N4zcOlW5HsyVJxKncyaCRjZAiPmCHJtBIVj5RBjcGxH3/d8x0t
 lCIZzZeDdizTnoPctbSyAU2Zb2PMBKfbW/JLtXmZ5c+xBnMoedrr9dYk25jtfPsJH4EW
 sGiPtw8o6oOXcV07MRHpaclqqFuwC1/hCAER8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727302657; x=1727907457;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ACcOP8bAJA3BghOQB50la0BG/hh2B5n1SnvrSFI1/RE=;
 b=YA1/pNs1D06KpaVI/D5KRA/6GTPLtBsllzO1TqcRQKRX+VWRDWCAiQcOjn6DDbD4z2
 QUCDD35nGTJbM1T/Zqw+LjlSU0FvnREwKkV3MfdN86CaNRcPDuNML4OfVoXByexSGiFg
 Ryh/NiF4PAZdz3C0oDw+VSvmxUOtlwaiMEVdwYkm6yRnZOCe3tX/n6BGSfMybDOafsRG
 fvLM7ojsReTswEPTDWTFPTM43t7oe+S5cc7hCu9MG7T1WmVIzaoDroNzw2DfszdOK0y/
 F1fhhtuGwOdKqQJtTry/Vtor7x1FwsiTLJhHj1swB37cLEyffBhyEeqm56HIiXKD5ru6
 beNg==
X-Gm-Message-State: AOJu0Yxh8AExtquwGj4dZQbGs0KvkekIAmrFvOMaNiMYT8GEO17636kM
 TUUdR1NYrf+u7EAMyDoi8oSY7qeoNf63Dfg+xUKGdJIqALl7IOhG0CHoqWZYYiM=
X-Google-Smtp-Source: AGHT+IHhXr+9tyFXMZ7JSo2oWQsD5riJ+B5G9UvY3+q3m6LT+GJwGxgtt3wkS03q9SYj1kP6KwPrJw==
X-Received: by 2002:a05:620a:1a21:b0:7a1:c40c:b1f1 with SMTP id
 af79cd13be357-7ace745d9c3mr550913585a.58.1727302656678; 
 Wed, 25 Sep 2024 15:17:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde5fcc4esm211806385a.112.2024.09.25.15.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 15:17:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Fabio Estevam <festevam@denx.de>, u-boot@dh-electronics.com
In-Reply-To: <20240924220905.514122-1-marex@denx.de>
References: <20240924220905.514122-1-marex@denx.de>
Subject: Re: [PATCH] arm: imx: Enable always-on regulators using board
 specific workaround on DHCOM SoM
Message-Id: <172730265333.324390.138101374116879908.b4-ty@konsulko.com>
Date: Wed, 25 Sep 2024 16:17:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 25 Sep 2024 00:08:23 +0200, Marek Vasut wrote:

> U-Boot is currently unable to automatically enable regulators which
> contain DT property regulator-always-on or regulator-boot-on. There
> is an ongoing work to add this functionality to regulator core code,
> but until the proper solution lands, add this awful workaround code
> to force these regulators on. This is specifically needed to assure
> the VIO regulator used to supply ethernet magnetics is enabled.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


