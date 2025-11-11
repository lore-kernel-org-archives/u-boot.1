Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F51CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8153B83923;
	Tue, 11 Nov 2025 14:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RizznfLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6576C83B4F; Tue, 11 Nov 2025 14:14:48 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE23833C6
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5943f39bf9dso755205e87.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762866886; x=1763471686; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYy9PaGZ3U8fPBbTbkGGUtnxKrGuRHCZQZuK/y92e90=;
 b=RizznfLEEwU30rge0F8yIs01YHTC5kCWe87EfD3CrO5eqrHKr6LFOUv6WTSe3ro4ho
 lmyl49RNSuM0Vr3N94p7vBsTzCXgw4n7dMTcgJVG9qnKqJAuDofQFwxRSlwatSTqJ/uS
 LSkqWec/ejC0O0KvJ6+dwlZS4A9ix/WrGrsZYxiC9YGcQVAW52W9TYUz9frZbnGEdvnJ
 kPywNKqqi0SzTEmIYMatmv8TwzsQmwbIxlGzG+Dk6eq3gxZT+O3UJOCaq2fzkSxdyTIA
 Xf5TkuLh9lCVLVBON5wwFdSxA/JFnVDXR2A+4l9w5ttIA6b0hkYXwJPnI3L6VGIuahre
 sg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762866886; x=1763471686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CYy9PaGZ3U8fPBbTbkGGUtnxKrGuRHCZQZuK/y92e90=;
 b=LVYfF9vPI73MgM+Zeq03ZSPu4jsVcGapI5Gugsp3cGKwlbXbANNMNOJ/HE1nDy2oIi
 AGZ8Z/IpgL7iSC+DQ1ZItqavdv97D4uQBWIrIfuTbNePlp6w6DQ04y4e86gGY/6nAsAJ
 wQPN7H1WyV8GyO7mSfmPxQEzAZupAW0z9pG/zBBnhSRe/r0K+3D207AH/KuZlIGEj+je
 vuh3H0/GVa/pM7vMkIrsuNFZu38+xYY63BI/hiZju9rZiyghCtygDTD3U+lhN9x6frLH
 wCZ18wDTWXOaLBqKfUvGg79ySXsS6ByaY7soKkx5RQ4VgkPmaYYpj13LLsxbSuXU+Wxj
 F1Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrpIxUWgGqi1jOsc+mg0sPGyyfQLt290HMFyWSTfL6v8CjHDr0+zC13eprX8IMO0XZCLXcLVM=@lists.denx.de
X-Gm-Message-State: AOJu0YxB0dSJMIaQuWEt+6juVmfk4K3px8TOJFltNl2HdIx1Zz2zOaWL
 qOeXntNl2rsMvsLOjodbl3F0XmaX8GYqLQFNf/1Ba2067TnlVhZ0x37bZQbSab38pngOblLVSP3
 AWnPYQLEogGlVqpTqPGAokN52ShrCfwA=
X-Gm-Gg: ASbGncuX9yKbX0ekzj5VOmjXcYw1DYHAOxKLWXHkc6JqPkyDdAbed7d/KEB4V/i/0HN
 RAX8qCh0diQTLGAxCVRwjXRzt1CpneElrZaDxu32DGJTpLBgy7BTKWbJGFynuunYoxU/tDSs9Xc
 ebp5EOLsB815C9pMtFlqXdlaDXcres+hfewg3YAJk1HEfcVq+J2Ln4JS5lQmVPadVPu5uICV38U
 TYqMORYE8rIsKZF9Xi3kQLZp8uFYPrzyYztlGbe/dgWTRda55wtZFH0RpZ4dk0VCDZ369qj8Kt4
 wAWsG4P8XkoejVjtR3bfoggETXOonsWizeuXog==
X-Google-Smtp-Source: AGHT+IHAi2fP91qihbnlYzZHce1+FoB7w2tw3CGcYQqv9iaakeUM/IysNLwXApFp1qg3Bnq6YbmOjzR57mIycBGE7MI=
X-Received: by 2002:a05:6512:3d23:b0:594:2a5c:78f0 with SMTP id
 2adb3069b0e04-594745f7ba1mr879606e87.23.1762866885451; Tue, 11 Nov 2025
 05:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20251111102904.157931-1-frieder@fris.de>
 <20251111102904.157931-3-frieder@fris.de>
 <CAOMZO5Do9AdqZ+j4Kpp8qU21mQ6yBNuvi614n_Q4-Uzebf16eg@mail.gmail.com>
 <ae7084f3-9df8-4e69-ad6f-5e80df9e4237@kontron.de>
In-Reply-To: <ae7084f3-9df8-4e69-ad6f-5e80df9e4237@kontron.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Nov 2025 10:14:33 -0300
X-Gm-Features: AWmQ_bnh8BbB3nhGGbWeJOE7-LQlAned5LbsoEist3dwgbT-EanSk8dZMjBfmHI
Message-ID: <CAOMZO5Dz0UjTrQv+kWeputL6haSMHQ+eNzYp-5F6mKS4DeJiEA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: imx8mp-kontron: Fix USB OTG role switching
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 11, 2025 at 9:38=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:

> Both would be fine for me. If applying to dts/upstream/src is not
> desired, even dropping this for now and waiting for the next sync would
> be okay, I think.

Please send a v2 that puts this change into -u-boot.dtsi and mention
the linux-nex commit ID.

Thanks
