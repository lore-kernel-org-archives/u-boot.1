Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD14E7FDF3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 23:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532F783F59;
	Tue,  3 Feb 2026 00:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bdaNJ7TM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A6583F7D; Tue,  3 Feb 2026 00:58:48 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E4583F54
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 00:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45efe81556fso3409610b6e.2
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 15:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770076725; x=1770681525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftiwpZmzZGZXU4k6lLqeECUO1ob62SbsnGSkSe8PBIQ=;
 b=bdaNJ7TMWjD9LffWCJEnGsgEYVjxvkApGaMWKc37wnik//vzRu6JOJ9JWliHJGjviJ
 ru6kyvNw+fReeyIuyZ7QFRtnVGXK9eXLvTg8/06pr2toA+Lw2sfu+1Ov9sXeAIJ415Pt
 QYN6rw2qY2NUdMQmWYtUDOcM/8YjOidkcXSqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770076725; x=1770681525;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ftiwpZmzZGZXU4k6lLqeECUO1ob62SbsnGSkSe8PBIQ=;
 b=fE3khvPkM0gPbOUfino8/smIfhhWfTWmhDyzszqgrFY+n8A1D0ZRyhqb/4ULavIn4h
 F3vwKqtpz/BiJPPimPNGHHbqbk+LnQv4aHwILO/iHwqQYDxOvpZRfmdldvlUDvgEgPUY
 OseqRTplHyyzFInTrt5xKR8KuL63STgeO8dM0BS+cOTXqs4WwIoPfGR29fQ0U3/YXC95
 7ifX/pWwGY7E8QAuOOjjYk1isxOS8JWh/ADumDiw5dPkyTDpsWZWTG9Nz1qfhHvjcRAc
 8B9V5xAAVz/mCjY5t1zuMiF5KQwMwSl7+scal/5f559yjKF1waHpILOXZoFSHGyWrW4J
 bwzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX65sYk+YCubYkMrp4Kpi0VMxLX3TUzWT62pR8BmRo+YcJhqh3AS7aiy85eVlsgeJo7Eg4eZqA=@lists.denx.de
X-Gm-Message-State: AOJu0YyjsL7nayk3qzB3WToC4qrhDPdiewoTy9+GoDC0tyflimyWQ+Ur
 H3wkwquh+bXGJJ7f60HQ0ATp9PbAQjQ530M6mKb/YTrOZETje4MfqpR8kL/TIOgqN8iR9gSmVj7
 jYfKvsmo=
X-Gm-Gg: AZuq6aLIz2+oWVPnfNW6M7fZWyadtj/Dl7A1kaODkgX+zqWoDVSLdhyzBUv4WjToz6E
 ZgLao8VEiWIsitHZbHG7GbEAcZJlifcQTsv/BZ00RULA9pgu/iCDCoK23NuWs/FqyXvHJdyvkA+
 rjZVpr8WWclQTUZOcm4UAq6OtSwrqhc+2yQRS4rPfUAL5taRvhHHi+v9XUO+Iu0JYEdAlvyKQwc
 faiyEqUC7t3rEtJnMRugTmaDlPUokSkh96hVuxANbd+B5wuzI2ZFx5xkg/VVB5XdHXpKGHZsVYS
 gjzw/MHTy01GyZ3MbkHcadPzPgIF/4QVj9U9QhdjLyGhklfJAq2pPVVaTj2JTJiJf99x/c/UIqk
 iDyoFVXv2QgiFHjy3IeVuSf3i7lW1lPzWpdA+AmH5o3jGooL9yNnAyer1Sh9zR9Eh8mw2vXAEGf
 6rCEiNnryVYh2TV1oiXmlWPm2kg1FKroRqUmIc4ax7olIyy7JgPsdZdafWDC+md9Ilc4xhxMP9L
 B8VJQth3k1IJ5IzgiMbD1E23iG1Xc4yhHYkUQ==
X-Received: by 2002:a05:6808:3846:b0:45e:84be:b3a4 with SMTP id
 5614622812f47-45f34bad9f5mr6530160b6e.17.1770076724881; 
 Mon, 02 Feb 2026 15:58:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08fb635csm10081404b6e.21.2026.02.02.15.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:58:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: alison.wang@nxp.com, angelo@kernel-space.org, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, sjg@chromium.org, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260107201838.3448806-1-visitorckw@gmail.com>
References: <20260107201838.3448806-1-visitorckw@gmail.com>
Subject: Re: [PATCH v6 0/8] m68k: Add support for QEMU virt machine
Message-Id: <177007672356.4123720.10843284111217950440.b4-ty@konsulko.com>
Date: Mon, 02 Feb 2026 17:58:43 -0600
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

On Wed, 07 Jan 2026 20:18:29 +0000, Kuan-Wei Chiu wrote:

> Add support for the QEMU 'virt' machine on the m68k architecture. The
> QEMU virt machine models a generic system utilizing Goldfish virtual
> peripherals and is capable of emulating various classic 68k CPUs.
> 
> Currently, U-Boot's m68k architecture support focuses on ColdFire
> variants. This series expands support to include the classic M680x0
> architecture, implementing the necessary exception vectors, startup
> code, and a bootinfo parser compatible with the QEMU interface.
> 
> [...]

Applied to u-boot/master, thanks!

[1/8] serial: Add Goldfish TTY driver
      commit: bf55b84736d6b220dae11e3b1e7a670918d9daee
[2/8] timer: Add Goldfish timer driver
      commit: 909f717eaf299a97fb87307e8606f3fdc6cb0c14
[3/8] rtc: goldfish: Support platform data for non-DT probing
      commit: b41c54488f6f8263c8b38a6cf97d106c3f9a65bb
[4/8] sysreset: Add QEMU virtual system controller driver
      commit: 0429298a1a76b971c0b0156918f927d6329e53bc
[5/8] m68k: Add support for M68040 CPU
      commit: c69b6aeaa35550d386c142302b852d6b72aea76f
[6/8] board: Add QEMU m68k virt board support
      commit: 516afc8f76268fceb98f6b891a653484e931b26a
[7/8] CI: Add test jobs for QEMU m68k virt machine
      commit: b21d9acdff871d9113ec8b70d9b12e6dbc4bd0c5
[8/8] MAINTAINERS: Update m68k entry
      commit: 838e3be9e1d39e38661a788ae3bcfb9f989450a8
-- 
Tom


