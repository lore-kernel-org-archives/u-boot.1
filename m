Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF46E92FE3
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 01:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083AB83EAF;
	Tue, 30 Dec 2025 02:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQsTKo28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1396683EC8; Tue, 30 Dec 2025 02:59:31 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8489A83EA6
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 02:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c76f65feb5so7154790a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 17:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767059967; x=1767664767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dy2hCYfBALVb55CokZLnpsPd6LTOOCNtZjB3BdH+6Bk=;
 b=aQsTKo28VBqH30+iy+LdNUydM4SRhkPA2f6QiysYPwOmbeoU3qMDTT6xJ1TzwPwoJ3
 YO2ghrKUklO57axpMvof6AUfmGOYJ10VR9P001js+xEj1VCVycUMQAs7Q6BSYHkkCpFv
 XsvDHWWoEpolgtLbWg65HkQrS+aPygRp3/NaQdSZkbIAL9V8rRy3l35PXMtw681rGYVj
 BpCQQCGuZEJNTNCqetSjKWAlZf5k1ORfG1JHgkTy1VwQ2ruAVmwG0IPzF0NaSjPjGexV
 rc9e2mirLXQyOkxflTv53QUTEtriBlUTLBaH3LyEwMrXPlo3ZPLCdltLVjEoTx/T1AFX
 c7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767059967; x=1767664767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dy2hCYfBALVb55CokZLnpsPd6LTOOCNtZjB3BdH+6Bk=;
 b=TXuk1ZH4kAcReo2eDUp6X1oStIuC77ryyQqxp+AKcvuIufu4VMr10qBg1wjjq14lzI
 QMK7LC8w1tVNyRuuZoHI231W2VbG2+09OU7RlRtjtfDhHY4DUkLvd1hESPiWO7fy3Wcx
 XVLDb7givIV7unOKNcfDBQyNz+gBaMj9bN/gSc68J2me66R//V02tQihmAHHxCjA0s/l
 GKE72RgUom0NMxxnCms0Si4eRXqTOQbCFtAPZUtuA563TAWn02prX27jo1A0h1sX4pqm
 WO965JYrdopzgRvp4CkA+PbXkogi0EIAsQdozsNp0wrxttE6BKlj3MAo4bbo5y52zMAg
 Kd8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6U+7nu7AIMhVTJgHnje+9+hyFU4Gn+4y+XLlr1PXbOZ4OXN0g240aZAP2bpTBJbxa+Sr+H2M=@lists.denx.de
X-Gm-Message-State: AOJu0YwZNObDyJtQ5+xRxLbBXP8VHzS35142CmTaCiIulxw/xXFQ5JVH
 GsMpmGun1gD5RjjeL5S7hEBSI5BTVefbEibcy+7AH+9MiO12/SLSZhvd
X-Gm-Gg: AY/fxX6G8YfdNI8sL6WCbyoGlqhGwlJq6857uyo3G9ErWL53IBGZvhQOA3Hs2osmljZ
 uLAiwifvqW5csm4kHR/7wyaiIZKNN8StfBf/ScvZqH6NnotBc6hOq5zX+4g5PlIgiNQsiI1GLFm
 RjRLIDTEQVW9tKOoK2QXvha2rmo7KmaW5iT+sBBIl5BgWIYDMkMeVeTLpByo2F/5ix93mE/qcR9
 fnfXpWUqCHkS/ZRWbDKo/QwmpHhQa9UwLjh5rWwYJEOHmtQ58cv4RqsRulfl7IwBJEvZTkz7RMR
 ICGWmjIAFwZj8TUi8SOtr6uMbsiGqk4jS5EV3dpN71yflQrQ/5GKPixdGAIbhlnEOVe/YZ3ZE9G
 OtSGUWVKOeDRX8AieCAJUbLZp10Fl/ltoRf5olcZxXLumT86DxohSqVzURJoUW8iAqZjVkrPtoy
 zBb++FlmsfBr7onXOYmqoAMS1/SlNwt2zEC0qBzNpWMjU5+OE=
X-Google-Smtp-Source: AGHT+IHrVVrPqTi88ZdNv3+/evQJZzck/116TiwYL/07pPmzRF9UEgD68In10ANabaPXiJaV+dYg6A==
X-Received: by 2002:a05:6820:1691:b0:65c:fe1b:44c8 with SMTP id
 006d021491bc7-65d0e94d450mr13065800eaf.10.1767059967180; 
 Mon, 29 Dec 2025 17:59:27 -0800 (PST)
Received: from nara (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaac0273bsm19688413fac.20.2025.12.29.17.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 17:59:25 -0800 (PST)
Date: Mon, 29 Dec 2025 20:59:22 -0500
From: Aaron Griffith <aargri@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Chris Morgan <macromorgan@hotmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/5] rockchip: sdram: allow reading memory info from TPL
 on non-ARM64
Message-ID: <aVMx-l5JHxxKFluq@nara>
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
 <dc6ddbfe-df79-4dcf-90e3-76068e5a5e40@kwiboo.se>
 <CAPcvo0S-ft94KFN6f2ZPr5KEMoEmATcFkTQk8O6PjFkJn3Ak0g@mail.gmail.com>
 <d63bc142-91a0-459d-8ccf-ad373fb0ca41@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63bc142-91a0-459d-8ccf-ad373fb0ca41@kwiboo.se>
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

Hello Jonas,

On Mon, Dec 29, 2025 at 08:15:29PM +0100, Jonas Karlman wrote:
> I do not think we want to extend the use of the RK ATAGS, at least not
> unless it is absolutely needed.

Understood, please ignore these patches then.

> The memory size info is also encoded in PMUGRF os_reg2 reg, a simple
> call to rockchip_sdram_size(PMUGRF_BASE + OS_REG2_REG) should be enough
> to get the memory size info typically needed by U-Boot.

I got this working, but I got stuck on the code in
`dram_init_banksize` that tries to read reserved memory from
OP-TEE. When left unmodified it mangles the ram banks and tells Linux
it has 4GB+ of memory. So, I was looking for a way around that.

I was also not aware that it's possible to tell the Rockchip TPL where
to load the SPL. OP-TEE at 0x1000 was giving me a lot of grief.

Besides these two issues, I'm actually quite happy to see that my
branch matches yours pretty well, for my first attempt.

> I have now pushed an updated rk3506 branch to GitHub [1], the old branch
> last rebased in September is located at [2].

Thanks! I'm watching this and the kernel developments closely.

FWIW, I have some Debian images for the Lyra boards [1]. Not very
complicated, but I didn't see any options for Lyra besides the
vendor's SDK. I plan on swapping in upstream sources as they become
ready.

 [1]: https://github.com/agrif/debian-lyra

Thanks,
 -Aaron
