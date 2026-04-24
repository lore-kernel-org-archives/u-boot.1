Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C653FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7E48429E;
	Sat, 25 Apr 2026 18:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="StX6qscy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C694184374; Sat, 25 Apr 2026 18:57:30 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE25484314
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50e97863425so63931591cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777136247; x=1777741047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDRd+qTFLRGhXkTH28iWHhHhVabn9UtorVqI5VQ017A=;
 b=StX6qscyNjzZCVfs8xzNRbOXV8OfVyv+Zb80pCWcB8yUP3C/UkB3cLuZfaE++QlCvR
 v/C+ghdHml+21Ko5wbJdlcTSTciEVls+T/Vgq6y4Wme/7sXBM/LelVze1frvMNutRJxy
 o5cPJ1SYLzSYoqi4HC+exdXO8fHUE28ptLddg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136247; x=1777741047;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QDRd+qTFLRGhXkTH28iWHhHhVabn9UtorVqI5VQ017A=;
 b=Jlo3hyPBoXEOGvAtTrgUy3CFrkdSdZ81TJVEZ+ES+/jj7q4eB3VMe5gOu1tL2T+uCc
 n6vlUh8N0dhKks5opvzp5WqO9WFEzHTQFPKBij6y8TKjeyHSwW8mdOWOMlJto388SsmF
 Wx/LDB7ek958SFuamvD6bYJgKV5BOtEcTJgXnebpP3c7Mu2we31FL4z6hOpl07lzxn59
 Z96QZgbZZk1FNjw7TIcGrwWBWepf48CMeg8irSVhVAp0q1bvKnlI1gXUY4SC1ZMJC9Xs
 tOvk38bBDBDV50bAH657OGWR8XOWeIX/A/1/i0Uw2//P6IGXtx2KT9WXHGLezpGU/WP+
 J1Wg==
X-Gm-Message-State: AOJu0YwuZ8TznTbAVemFLoahfWWaW4CSbF0mdxFaSgQS3/wqlwcsDsEx
 wAvYYpYvv7XsCfe2hy0eRDH9ttzl1AV8ev9XghQP8lLa0GzWPKmP/6Bdr5FeGiEGJGIHK4G0Wig
 0J+BLduorDw==
X-Gm-Gg: AeBDieu52ElUyjQL5WmiVdtAK2/dB0QzbGoCRMTlKNDc6Y8JHPT/HMANKxlsfxoWGaM
 nJT3EJhUolav8HKRPP9QOTeaCOdsAaTNeFHXXVX6gtmZDPCyW4p13FXQx3syr23vL9pVxxrHwlk
 kIS/bASxBnI9eI0ywnaH9dFaK8yrBjGFbr6vAUw4Wpd6JvFvVdl91eG4NtUc9+/QE4oISftrCSR
 DCJzdOX9PRl8iUjGfoujPtH2bhDri2Ez0qVTpeY7sKMDv8/50j4ipLqq0G7dJzoWffQEbGozIhd
 SiqhjWfkJu3IZ0d8SIE3kpJ1TNlOEbkdZtTOPRHISPyHCBq1Mq3lcfyKa7pTAWEbLtvCCnE8LKo
 1nlDePbYP5Cqvdk+yWT/6I5EgJzVREVeuEFF38czBtCAoEy/pQiWBIvu7aTPBg3RGQKvLcSfJ2z
 XVeTQsKIMjCVW0EMR/6CpTr5Fvzd5/NUpzLyiDuTjqYTTEZccaK9igj2Gy7tTA+FGDSNCbrV9R0
 Q3CwOKDM/JfuJe0DoIEPcVv1ldMIB/s20HSVdzwnW2O3IGIjJVk+BzXOM6V
X-Received: by 2002:a05:6830:911:b0:7d7:e3b9:58d6 with SMTP id
 46e09a7af769-7dc9523a18dmr22246328a34.22.1777056653226; 
 Fri, 24 Apr 2026 11:50:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20260420012320.400472-1-marek.vasut+renesas@mailbox.org>
References: <20260420012320.400472-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] common: update: Fix TFTP return value handling
Message-Id: <177705665254.2527258.12510301140793779258.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:52 -0600
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

On Mon, 20 Apr 2026 03:23:07 +0200, Marek Vasut wrote:

> The net_loop() returns 1 on success, but update_load() returns 0 on
> success. Do not assign rv which is the return value of update_load()
> to net_loop(), instead assign net_loop() return value to a temporary
> variable and then update rv only if the temporary variable is negative.
> This way the update_load() now correctly returns 0 on tftp success and
> 1 only on failure.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] common: update: Fix TFTP return value handling
      commit: d64c4a69585aa096c693c0b7ec4e6e04333fc45f
-- 
Tom


