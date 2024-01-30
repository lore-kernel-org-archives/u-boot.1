Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20717C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF8987D18;
	Tue, 30 Jan 2024 13:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FH/2uwb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2458C871A7; Tue, 30 Jan 2024 10:43:33 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4231387C4C
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 10:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40ef3f351d2so11560205e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 01:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706607811; x=1707212611; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3W9avAebxFt3LTB7sGOWhFapOo7qPtS8PoGD6WvLeiA=;
 b=FH/2uwb7LVpziSnpMuM3EnpNYnBIspY8y4TAMeFdTi5JwaVYInerl3kWMhp8OKthB5
 Vq+Z6SxqDWjrWUspRjd+v5+omeldaBL42X9MdfjYc/Zh968EDcJAX2pJOcd6gSMpGqah
 h7hfFYoUk5a0kTWdY3wzoi+Z5uCztfB8FKc1xazwDV5WX0hEcAWvMiUX7y3P9vmtRhad
 pVaK3TC/pW9nVoECs7pzyPNAMgYKOrWCohq0kCbJ3/WCnV5L/RwfXVZgt9vLOFwRLXCn
 YDrmPRW02m5osvzBdVx7Zm+LvO5FGWa7pvKDCgV37bTrPcmM7g/RpdQNdHseB0yY7Wp7
 tFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706607811; x=1707212611;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3W9avAebxFt3LTB7sGOWhFapOo7qPtS8PoGD6WvLeiA=;
 b=hAA8itCi9V4YSXyFtW5FCkkNR9BeTvvjZ83fI61kbfWtkmg9vilXdjWgHqZzANg1F3
 gg1pnJbLEdNZohT8UdXspGYblOWPCzeTAmcasEqZxqxawVcIpBWd5ruu/hQpYSN8zBw1
 M/PhALje/t7kKJc95L/RWcryVTIdZ85JLlm7jFlDbs86PbWNGJD4Yvb389CiW5ENpAHK
 2ViAeo/CWpODBBE8T0f5uc21CqN6jXJBZjDv3825nNkWUdHX//UNkaueMNiYRNalRWI+
 WUXfR8/Z4iew/e39Qm7R1cj/CKW8OC31kVcJ/9Y5QJrdT1dmU+ta5b2ID5yKQtaRHhBw
 lQZA==
X-Gm-Message-State: AOJu0YwEQvBFpO9dZijRthxuOr+Ov08Bl6oalDvWuDgvhRvhHdP2c5s3
 rOxf8J/NCTvMLLs01Gs04wUme2VZ7X1+01hbwaQhjlEiUZdwpp4v
X-Google-Smtp-Source: AGHT+IHGZPCYnE4XKSDzEFJiZeglO0TLzoVglYTJ79XMTZxAEXRYpyNBrIOSuBPGwTSKk4rKlrORuA==
X-Received: by 2002:a5d:5002:0:b0:33a:ec95:3168 with SMTP id
 e2-20020a5d5002000000b0033aec953168mr998823wrt.13.1706607810409; 
 Tue, 30 Jan 2024 01:43:30 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:2d72:bfc1:4136:432c])
 by smtp.gmail.com with ESMTPSA id
 u17-20020adff891000000b0033ae55db108sm7674539wrp.20.2024.01.30.01.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 01:43:29 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  "NXP i . MX
 U-Boot Team" <uboot-imx@nxp.com>,  Christoph Stoidner
 <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,  Yannic Moog
 <Y.Moog@phytec.de>,  u-boot@lists.denx.de,  upstream@lists.phytec.de
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
In-Reply-To: <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com> (Primoz Fiser's
 message of "Mon, 29 Jan 2024 11:24:38 +0100")
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com>
Date: Tue, 30 Jan 2024 10:43:28 +0100
Message-ID: <878r472m2n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 30 Jan 2024 13:53:57 +0100
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


Hello,

> Please remove findfdt script.
>
> Not needed when you set fdt_file to CONFIG_DEFAULT_FDT_FILE above.

The reason I used findfdt is that CONFIG_DEFAULT_FDT_FILE is a string
so, we end up with:

--8<---------------cut here---------------start------------->8---
fdt_file="oftree"
--8<---------------cut here---------------end--------------->8---

which gives:

--8<---------------cut here---------------start------------->8---
u-boot=> run loadfdt
Failed to load '"oftree"'
--8<---------------cut here---------------end--------------->8---

whereas, if I set:

--8<---------------cut here---------------start------------->8---
u-boot=> setenv fdt_file oftree
u-boot=> run loadfdt           
24579 bytes read in 5 ms (4.7 MiB/s)
--8<---------------cut here---------------end--------------->8---

I then see three options: introduce an unstrigify macro, hardcode
fdt_file=oftree in the env file, or use the findfdt hack.

I'm not sure which one is the better?

I will fix all the other remarks in the v4.

Thanks,

Mathieu
