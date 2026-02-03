Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EA7E8B366
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0462F83E3A;
	Tue,  3 Feb 2026 22:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d14mkwpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4460A83D9C; Tue,  3 Feb 2026 22:12:37 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C19383DA7
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-663170b9472so2520269eaf.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770153154; x=1770757954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QmY11hnhG/Ib4uvlSUu1gbiWdk0Gav6i9RqJomDTmk=;
 b=d14mkwpleSL9oiTeKjH21f53a7BELe1ltqAzKz4Dl+S1yoxm85JrMODbxlVZcFxa3y
 xheTZ/yo5+iaiwLkmdCi2snrk3oNKrf8mYwwg4q0GWFozs24xuL1gWiLO0hdqd5bKgvy
 Uo17UkdI34c6eDP3xgxY5yYiRs92hg9wgMRAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153154; x=1770757954;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9QmY11hnhG/Ib4uvlSUu1gbiWdk0Gav6i9RqJomDTmk=;
 b=oYom83PRxkdegFHBulLbjXYadqqMLwUJre8cWz9HVr2NPl58oUsQaYYDRoZm2QbY+a
 cEv/374DtcFDk82ygrpxpcrU9mXI7+Dn8n1gzl+c8Ik96eYZ7rIcgmonKTSQUR+B3fqN
 iC+5t36vSnEbSeZwpJz5zjKoR91AjHmzgeEMB6ldA2IoMJYuRljl7aifx5VO9CQ0hQW5
 g+yvWnv3oOPUopda5VKlzmD2OklARx5nAbOdEl6UbRllqF65RN873ZQws3Rl65xJoX/j
 aJhF2NgDYK6smYG3VQrTqWcFG945/p7Ct1Rl4zfmqncqqwC+4DsCPXrj8bwVMrgHMaeK
 4H6g==
X-Gm-Message-State: AOJu0YygS/6IKapBwmJ6FjjYj7WKIKXikpcshm7aoK2/uLD6VHSZ053H
 kx7TVzG3vyBrgbl0GJasJVZClZ7hY2e2lIHJIGIEMRKPVljmglpnmeK5d6RMQti2wBM=
X-Gm-Gg: AZuq6aLEEHDPRohmYSqG49sjRM91gPMFF3/pdb0jtB1go0e7hiyqWug+a3zHGHayTox
 Wt3Svu4+aNVwObPynhatQImkC6/mYiGV1fu6QoZhnWBuNAdPUSnmb/wi+ibi1pN9A/3DOe5l0KB
 UnqFcYnzNmjqCkw/+F3BEspjUKSv87k18bsXr6/j637utDaEJL9EDjpbWBXqsVYE+8EH4WCO4Op
 GYG8YfG2xfpiXKkBl1Ww8Aeq1yDpcSbD0iZq5S/WTk6wj+Vnc+OWF5esUJPghjvJqO2E35mtUk3
 u4a8o6SRIjIMMwyEcH85NPtR/Ya0NklLjbnDO6O88Ix6SQ+XPGqfPMp0lOpjQxcBI22pBHtEFAv
 9hcCLME2mwxjDr32zTiCZQHeX3mltyBbMqyKdtO2l6wNCsaEVRVshBXDp/vAIRRH3DTHxyDuVEd
 F6EbhqHJiHzamNLJsCjzX+KLL2W0Y0+jjxCjKtPUPBkkMFsB2U+dtN0cBUM/auPcv1YHLI7kOuO
 wUgvz+qw5mcziWfC/QiRALHfwF5iT6lqpmyow==
X-Received: by 2002:a05:6820:f027:b0:65b:24f6:be21 with SMTP id
 006d021491bc7-66a20592e79mr492476eaf.2.1770153153798; 
 Tue, 03 Feb 2026 13:12:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35f7a4besm324630eaf.17.2026.02.03.13.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:12:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251215081640.1827840-1-patrick.rudolph@9elements.com>
References: <20251215081640.1827840-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2] x86: cpu: Fix crash on FTRACE enabled builds
Message-Id: <177015315308.1503561.5332802023106536789.b4-ty@konsulko.com>
Date: Tue, 03 Feb 2026 15:12:33 -0600
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

On Mon, 15 Dec 2025 09:16:39 +0100, Patrick Rudolph wrote:

> When compiled with FTRACE=1 U-boot will crash as %rdi is clobbered
> in board_init_f_alloc_reserve() and board_init_f_init_reserve() will
> memset the .text segment instead of the global_data struct.
> 
> According to the System V AMD64 ABI %rdi is not preserved and the
> existing code only worked as board_init_f_alloc_reserve() was small
> enough to not use %rdi.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] x86: cpu: Fix crash on FTRACE enabled builds
      commit: a8d982e1f1726254ef27bbdf362f98954ee3feb7
-- 
Tom


