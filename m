Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB91C636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8825088A5A;
	Wed, 28 Aug 2024 20:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rwf2WJxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCA688A5A; Wed, 28 Aug 2024 20:27:04 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B3188ADB
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf6606363fso38546546d6.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724869620; x=1725474420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORyPq6izAADr+TyJRxvtTlWNJTy3veNN6/XbAO++cj0=;
 b=Rwf2WJxZdYSkgHz3N/j8W1kOSww1CeiHgRIdvkDT6TzVyokl9BC5xSJXExVqFJfADq
 dkzmKx78sCJFumLgURIw/3Q8upNwPseIMON3MjdGvDBI1IuNuHNrqzmwxMiWoVMBtxoG
 6/BaxXXc4v4WmD1lcxQJOalWyfsBTq9SESZz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724869620; x=1725474420;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORyPq6izAADr+TyJRxvtTlWNJTy3veNN6/XbAO++cj0=;
 b=dsQqys7B17jfYIoYdU7Dm1NsVL4hCrJmjZ+7FR2ZOqbyfIYZtb3BqZVBXqO7QqwqP9
 /9iNXze5bsOnXylOYwdvyqGKBhCJ8FirD/nvofkYX9uLYB+OQ7sffja3V+3EHNy5Tq24
 cAgeRFxy9BGUeAKk9ux9djaOcgXmK4I/5xb03T/xzwz2b8ZBjD1INrFUpuBT5vAbuzWT
 KgcZcp8KFlqq3EalB1HIKwCvZtFb1k6gF1fyWd4kW7j9gj54o/6t/kg/zDNMGEd0K96q
 3pTX8HYYYC9/d8RmDRc9ffmV8pWdJXPAXqLe7wrPDbpMi5lHeTBAUG7ubjolpZr3c+uM
 mQTw==
X-Gm-Message-State: AOJu0YzjT1nz7sKpeNVnSfqa7/GCDNxTZcbPDbhFi5vnolsTbjHW/cnC
 B6oJvOnFITNKnaBCvvok42CiMI1zAKMjWLBmx4ITzwGtarRRPzXI4FS69kwIYb8=
X-Google-Smtp-Source: AGHT+IGwcNnYGtQ/C1ROTXKcnTCvdv2IXEhJhzQLbgjYxcr5lArb5Jg1ye/VblmNPQL369P29bi2BA==
X-Received: by 2002:a05:6214:598a:b0:6c1:6aa0:1d9 with SMTP id
 6a1803df08f44-6c33e671566mr5280366d6.37.1724869619862; 
 Wed, 28 Aug 2024 11:26:59 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm67835536d6.121.2024.08.28.11.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:26:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240803124149.2916030-2-jonas@kwiboo.se>
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-2-jonas@kwiboo.se>
Subject: Re: [PATCH 1/2] bootstage: Fix unstash of records from SPL
Message-Id: <172486961888.3064792.636174658599384187.b4-ty@konsulko.com>
Date: Wed, 28 Aug 2024 12:26:58 -0600
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

On Sat, 03 Aug 2024 12:41:44 +0000, Jonas Karlman wrote:

> The commit b81e31a1e6c5 ("bootstash: Do not provide a default address
> for all") changed a bootstage unstash call to bootstage stash, this
> has resulted in bootstage records stashed in SPL no longer get unstaged
> in U-Boot proper. Fix this by changing back to a unstage call.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


