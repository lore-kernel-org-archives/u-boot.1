Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCF7C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 19:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D62487819;
	Mon, 23 Oct 2023 21:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pkbFlwv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDF886F97; Mon, 23 Oct 2023 21:09:13 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7045587741
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 21:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7c011e113so40096247b3.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698088140; x=1698692940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+zG5YBB+4InhGw8JiDqotiv0X7/qTTv3J0VXMhOO3c=;
 b=pkbFlwv/YPHKUvxCPxXU3jr9v9LD2QTpO37sS/lvJZJhWX2VpjKLdAMrXVFg6OsHcq
 gjH/K2nyo01OrNmGWXPycVDjNX/NgOuYYbf5i1EKGaUqRbA5PwyUig9DCThlbkN7qg+E
 Y5AeoZuklGYX3eVPhq28bDZba1fSMmKZT1gLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698088140; x=1698692940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+zG5YBB+4InhGw8JiDqotiv0X7/qTTv3J0VXMhOO3c=;
 b=lIcDBWP2N+BTFI47wAk6P7KtJMZOaROA5iPBr4iMXHtEt7oHRZ2HrAAvha4yL/keJ4
 Myq6OIn2zZ4li8ylbWjbMLvbA0wq2QzGH95aHcThPGGLbClDbBkyaOCIRbZAvyuvHbdn
 Jl3RHpgvTDTEdhwiQ4Ezf9V0OXd7dhLuBJ3IC1ilorWIl7nnI0XXimj9qXv4iy91bwqo
 mIjL3xTlMDPycQ2+8s+o6OoACAq3d+0WB2WipEosM6NQM1Pu73Ey6pJ/NQr1Mf9Fc+EC
 wyj3ColbeDVvnrZK4rA3aFxtT/SZfSldxxrA1WRpK3cnSTljKlgwwJ5PEz2j9AuLKMFY
 P5Hw==
X-Gm-Message-State: AOJu0YyRe0JQh519UnVC6fB7I+7MdfFNT0+60pbIoO7xw+MX0hZAVqIU
 9BblUw/tDqgwE6lbtDfYaTTBuLroz3N9Pqx3dygsaA==
X-Google-Smtp-Source: AGHT+IES46zv4W/uJ9fY7TStjMjSsgFgIHfiiN/4HyZkye7O5/U06Hgtz9t7AnzpabcgbR5z4FaaZw==
X-Received: by 2002:a81:4f08:0:b0:5a7:b8de:390d with SMTP id
 d8-20020a814f08000000b005a7b8de390dmr10936498ywb.13.1698088140007; 
 Mon, 23 Oct 2023 12:09:00 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-c6de-498a-c903-1c13.res6.spectrum.com.
 [2603:6081:7b00:6400:c6de:498a:c903:1c13])
 by smtp.gmail.com with ESMTPSA id
 l67-20020a0dfb46000000b00598d67585d7sm3353566ywf.117.2023.10.23.12.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 12:08:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>
Subject: Re: [RESEND PATCH] bootstd: sata: bootdev scanning for ahci sata with
 no drive attached
Date: Mon, 23 Oct 2023 15:08:56 -0400
Message-Id: <169808766154.2558485.18193440583898444935.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007033429.25109-1-mibodhi@gmail.com>
References: <20231007033429.25109-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 06 Oct 2023 20:34:28 -0700, Tony Dinh wrote:

> It's normal to have no SATA drive attached to the controller, so return a
> successful status when there is no block device found after probing.
> 
> Note: this patch depends on the previous patch
> https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/
> 
> Resend the right patch.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom

