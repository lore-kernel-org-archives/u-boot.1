Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CACFF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A36841C8;
	Tue,  7 Apr 2026 21:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hEQyy29N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F81484199; Tue,  7 Apr 2026 21:50:19 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ACBA83936
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-409de4132b5so3539714fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591416; x=1776196216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OI455q9o1D1+aRtz1SWJeE1iQiCtzm9N2QAY/BRakTQ=;
 b=hEQyy29NxW6LmEKJFvNx9KlvkDKEQEhUa6WXDZu2HfuDgtLrlIx3UfvHj4zb9Np2JI
 PBvMq1p7v9NJAZyap7Bij2NNOVVCndBuTCToyzLXuB4YsPrQEhwCWL6qwC+xHzBEHV2P
 2b0RWJrOhjKar9VaJ23jMegWuRN0VQBNCVpQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591416; x=1776196216;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OI455q9o1D1+aRtz1SWJeE1iQiCtzm9N2QAY/BRakTQ=;
 b=pPqVng9vceXgkRj5JyaRvfAw7Sjta3kTapCZWGIr5DlQR44Dxo+94ow5FiivEHEm+7
 dabyYxmtA6s3Xwq8keKKguip03ep/x6WqaypEWCcsl5oPunhWT+Tn1UCFonhkQz6UNYE
 8JemGOBOnQP2mjbkUS4+HaPShZUjzaHZpef+Y+BK/WZdaYYBjYGwJu+7wJbSaKFUrIh4
 2M5yPdnnwlnRvts9MHatwV0qoIPE1IW4BK4rrCzo8oszexTLdhH06mizbxFAM6thNPAX
 ljThJg1DMCcNEI1wG2yIc+m7bF7u2KT1GUi3hAVuBGHgIV2ZQV2+xtq31s1ZUqWQ790w
 7n7Q==
X-Gm-Message-State: AOJu0YwQ4a7xDEbUQAUMc9mVNOvzvIOGEPuRGcU3x/GhE+9HoCLQyGj9
 R4ybu39SeKqx50UzWO1npu25df1/drBkBjvOaZFTfNEjk1OqYaaAgP62JcfsmaY3zE71RK109Wx
 n6etUdF0=
X-Gm-Gg: AeBDies5GCb+SOZHwA9H29IFTBfubdvtz3LyLYC0SaR8rnNmxuNE1pEqSe5/D63Z/ak
 ewXwYGexacrzBB7IiROH4eI7GDRGRKF3HbpmryeIAN/3XgWiNzomGq2QAR6Fm5hqrmqkfRegIjn
 qX11vz83gP5f12SxjEljxnNpBl5wFkzWilv6TApEvt/Jvyg34O7pmFqKMVLDS8r+DmkQS+xPD7Z
 4NR9tWDiYKe07KwArDk+g/VA9kaHIsbuDqgn15RwKpj8xFXcVKNv5+7C5zjJLPFcsv1RJzE8WfR
 HD76HSMxPknDMl90Eg5vGxSdxbPGnXR4JRxqSr86fkWneDwkcJmzXfNYBHaKkfavRrgx+QT3LSG
 pHPy9xkK5RMe/y8wfdrHnbzpEooxYrsEOVP9CCkMwlSuvUBXaORtMhihcgLg8jP9PzAOEL5hcmg
 VWj+CZ/R/B2mkEe6Ve+R4JL3trmhN4KIfz3QtQ3XGXm7f9BduALiF+GV301VVJw49iZGVqDui9i
 EIH11aajUSVTen88Lf5CSsaFRXBDUnVHGclvxpP0sTDhRk=
X-Received: by 2002:a05:6870:9f0c:b0:417:2156:ffea with SMTP id
 586e51a60fabf-4230fcc4a75mr10729379fac.13.1775591415937; 
 Tue, 07 Apr 2026 12:50:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195256.2363513-1-trini@konsulko.com>
References: <20260323195256.2363513-1-trini@konsulko.com>
Subject: Re: [PATCH] input: Correct dependencies for CROS_EC_KEYB
Message-Id: <177559141537.2108693.10221554565825747619.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:15 -0600
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

On Mon, 23 Mar 2026 13:52:56 -0600, Tom Rini wrote:

> The CROS_EC_KEYB functionality can only work with CROS_EC enabled, so
> express this dependency in Kconfig, for all build phases.
> 
> 

Applied to u-boot/master, thanks!

[1/1] input: Correct dependencies for CROS_EC_KEYB
      commit: ff031c34210f3c573dbb84196dadf0c4f2017aca
-- 
Tom


