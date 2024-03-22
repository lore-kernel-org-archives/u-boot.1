Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E35C54E64
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 23:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75A587CB7;
	Sat, 23 Mar 2024 00:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ljEDjIfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0535D87CF8; Sat, 23 Mar 2024 00:15:55 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C9A487B30
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 00:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dcc84ae94c1so2631899276.1
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711149351; x=1711754151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GjVvSorGW2UmOeLZ99d5XA21oDLfIgnyo7WsiZUb+r0=;
 b=ljEDjIfOI+yDw+z19LESZ3oSLZRYWb1+aUxXAgrZwS9+x09SDiNMJ3IPIus57B+1wW
 vontVU3eXxhZxu3pLleT4EcPWGEYkcWJcWH4q2T5wU9OpfytbWWOBvLX5mubG22B7DCo
 HT0JC4ByfmKmiSK22R2wYBHl50i2FgE3XEJrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711149351; x=1711754151;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjVvSorGW2UmOeLZ99d5XA21oDLfIgnyo7WsiZUb+r0=;
 b=rUsO+UXNY/OMLSEYMGIf+4ZWsEVTUfO25HArGo+RCJ3a8WYgAjAnGe6IFlcYzHjJ1L
 ectWu9v2QjLychO5FfExz9BBdy79ZYdE7loiIwsm3J9zYf+ryjrBXNXVXpiWsksu989q
 RLEqIlTFkM4fAUhije68rDBnQM7hb7F4LSR2FKusH/3jzTnz274VQO5/77RpZBvdgvFt
 CagMpeAbPMewpumUj1kSqIcabJmksBfioNnZrsiaeMs/avnxYC5IW1PHh65jO0ywd+Is
 Ux59AbK7vtwDLDSQwuSX9WoiWR6tirOSuBZVGHE3jLxeQylcm7lBwgM3wA7nofAfoeli
 IC+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAbbjMUNZUoOl9qS4ulm7uVSepG4RFVwGoV8UzK/f+YkTzKRoBYsPWk3SL/YWy8ZI2ZLPiOThMzLs3anhQ3wEP1QKXBw==
X-Gm-Message-State: AOJu0Yxqeg9xGCFKTdf91BWufxIw8yB2X+GeecY5V7hPVYfF42oVYuE7
 R6HV416r07p526S4VgFOxfjYhocYhqvREVL3r1qYXcNLOxVCjMBFJBEbV3iNvRM=
X-Google-Smtp-Source: AGHT+IEgoh968vZ7EtspZOrboA+FPoaKEGrvGT5xc1Ipy+KeDLdlMuXQFkkz839JeGj8HTgFvk0v4Q==
X-Received: by 2002:a25:b296:0:b0:dd1:2a7f:acb6 with SMTP id
 k22-20020a25b296000000b00dd12a7facb6mr812731ybj.43.1711149351457; 
 Fri, 22 Mar 2024 16:15:51 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 jo10-20020a056214500a00b0069102f97e08sm1537500qvb.97.2024.03.22.16.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 16:15:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 u-boot@lists.denx.de, Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240312094436.2959542-1-a-nandan@ti.com>
References: <20240312094436.2959542-1-a-nandan@ti.com>
Subject: Re: [PATCH v3 0/2] Add remoteproc driver support for J721S2 SoC
Message-Id: <171114935056.2210431.8380414666595793407.b4-ty@konsulko.com>
Date: Fri, 22 Mar 2024 19:15:50 -0400
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

On Tue, 12 Mar 2024 15:14:34 +0530, Apurva Nandan wrote:

> This series adds relevant ip data in remoteproc driver for j721s2 compatible.
> 
> Logs: https://gist.githubusercontent.com/apurvanandan1997/276098af439e11105ab9f809159fcc98/raw/
> 
> Changes in v3:
> - Removed j721s2.env patch from the series
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


