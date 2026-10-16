Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9DACCF2C6
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1804B40A6B;
	Fri, 16 Oct 2026 21:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7pVKQ6eCMvb; Fri, 16 Oct 2026 21:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 508BE40A31
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184502;
	b=R9Li4zz0HUUWHOvkm4I0EiJrLrclkKzuQarr4wmScDh1Ylq0tqwJlgreeLatCSMs5pfm
	 LRtH2jWw/uITjjdqVAHJngv04fI4gcFXoFjYz8GRVUrJCMGPjHyIik1EAC4goXputAIii
	 gvJxh12iqD3MiyCiiSbqMyAA+/to8p1CPV8uye35K//4SA81yq7WLaKGPw6LcXdlrjqY+
	 OFB0E5S39mU7oziDWVRrxzBlvCMCEKOebBi8opLvrTHDjXMe0Ql9xWfjYNRpXXvwbW5n7
	 DU8/uZMpVZfykvjS5lKfdBuQiyaCkSntBg4GXL0dZZQQnUMlswCFJKsIo949NTWiQfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JHGxgxJEpfXmybs5bip0cskKfQ/0wQsYUEp9f8Mkfiw=;
	b=nZVjXZMHNwajZip4rtIGzoUJixj76jEV6SK5k0CD+nHhUfmxzdMczOcDsqOv4r4GfoVS
	 iJYwGKqOYHC8ywKnn3+4NpqfhBTonQRLgoMmS1SAsR2hvuVqK9gZH9XffleexKXlZPwhD
	 dtpjFDAU++Ty3wx/sqpsOXZjrY93r+LgHkPkjWDhoMmGs+pm5ylzbNTUrHe5zdcCx62wh
	 2nQIzZrAbNFOTI0fmq9V1fvcy9bRrKjl/XUOrDu9fYM9uHE9Prg6j3/iCO+TWI+9aXBkY
	 kfMd1zKkA8q11kaXwZSJYkXXtruqO6uo57y5d8W8iK+rmM6NMervzMGf7TPqgtK5vCg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aCfszoTB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184502;
	bh=JHGxgxJEpfXmybs5bip0cskKfQ/0wQsYUEp9f8Mkfiw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DTnuCucSpIXjKu7uP5zVA4qjlHJTGAfXFOL7pa4GRYujKPHup0Z8Y1X5BFW+UBreY
	 5ikAQW00rEJJ2dy8xHukb1/uredwpN/QtM5kN3ekplPjuBwq7Xb91Iq6F4iHvHuj9W
	 6F4cRV6u/sD+Gdx7vxZy3JdkfCX8bLef7YUUZVlz5oolw4kehNBqyGn+HkH+swg6wz
	 3Z5F1srmAwO4Nq6Uuf0bWlAbu16Uix4F6EcyLBYXCtLdSinuW4+axlRaXIVt0W7OJ7
	 bbTWGmwZpwbkLapZVCkD2PRSZuarlmuHmF21B0elLn6NSo1oN4vZbbeQLwHVXMQah2
	 ubd3WpjgjSl9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 508BE40A31;
	Fri, 16 Oct 2026 21:01:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E0A975
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0416C40C13
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SsV_9lxo1gMg for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2026A40B86
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792180370;
 b=ASGGXs+u2DSebbe+hTtxJqWmOXs294wrxzrkA0khHZwUUsBB3l8HmYsmukmQilw8bTas
 OjFWukJYF/zhbOpgeWcx8DuiyqBbDUgBOLWzzHWVMofZGYRAnz4tmEsElKO37s21psATA
 +pjlxiekIFQX3SQpXhOS06mm59xkrhamcx6WgOea4F7s9TNCfSCx4W4yK/ruNvufC+f6e
 q/LY56Rzj50LXksugIM/eFJZUlSai/HnZeWcdoquPCWRR0JlJGYxdOHAs7QUbLalOKUnA
 hXsMpgw2KMjbcXkfenfaH+f9znH2xL5vtUCynGqB51AY6JnqRrfB0vaOcKXEzDGJsgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792180370;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=JHGxgxJEpfXmybs5bip0cskKfQ/0wQsYUEp9f8Mkfiw=;
 b=TN10zzDpH/9LNOBCs1U169YioUWN9wew72hEdz+gLYcpV9JJTd248FaZVgRnl6OH5Bs9
 KLNaxn+SAg5JkaVNea/RnWpIfDYFlFwib0qY06Gu+UasioJ41ov37U9CuxbhIAtj/hJRm
 kR/7AfQPlAt3S2qXtaC9tM7fX0RoNGvTzdXhuzmprpW+aETiG3MytbfAHJXR9OdemZEBH
 D1yQVEhQ/z4VdDaBtx3wRSQTOrvsKB38A+ZBektMxJi8CKwubvi5mflckFn5HrOIEwWUC
 QceE+EFBcDWr6PRscMkV1/He7eZZbFTGdm339XhRqjbMb8OM46IRDi4k7jFyBQXHoPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aCfszoTB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a33; helo=mail-vk1-xa33.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aCfszoTB
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2026A40B86
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:52:49 +0000 (UTC)
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5e941201909so79145e0c.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792180368; x=1792785168;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JHGxgxJEpfXmybs5bip0cskKfQ/0wQsYUEp9f8Mkfiw=;
 b=aCfszoTB6rHYAd7cuHmAW53cRhqHxHguo8Zg8V32I400tRHKbtR0tobITTtvPSV16l
 O1F6LR7sRKTMyG+7fcpVxzw9mcFHa6ex2/rkU51Hlvo3cilMU6CCBJ6O9nRxCiAoxl8X
 mYnNij00RR5qBU5lpA/D/l8VGxgU3K0fnvvKu2fyLb7rP6eHbo6onaPFetAqLC7mmuL1
 PdDNgJOONQntJNOY6C91Wq0RB3fI45aKR5WA2oomUj53qw7BCsoqgOaJYFGUgcCDXQNP
 33GK4S7BUXr5znVskXQonNwNhdc5ZGJ6euQSc1BcXnZ9hMcCsXf4PBazrThOmSH2E20O
 HNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792180368; x=1792785168;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JHGxgxJEpfXmybs5bip0cskKfQ/0wQsYUEp9f8Mkfiw=;
 b=gtxZhnfDTAma2lq+oqblYNkgPvQbL3wTBWeOaOSjKwy5ec5AXrYoW0GHYcjz2dSd/q
 GARDIb7odFma7uXZnDQDOQ4+6EbkZS9BOPTf4w2Ykz/S8llWMDQUhy81GfefTp9fs3RJ
 VGnAfA4fx+WnefqOknVCINOCzw8aZlYSqqaw28sIOqg1KSxJvwgtvWI/ifGYWsJZUwfZ
 xr25MhjE0b9zd8/vzTfOCOVqr6btfbyH3bnkDlWIQ67pe1OKfa8/kDhSq7iqD1mR+Btn
 +sxBG2Ptull+we/lXfKKKk9hq7a2Pp+5r4yFq37H/Wmgw9t/3evokJctoUmIfgFS94fl
 Uxpg==
X-Gm-Message-State: AFq9FYLmhjKou58uVdzzbq/DUFfOXV8s7X8iXZ75fkI4BBUQwMcIFkaM
 x+4UicD8J0a7CnyaeI3BxFMJ/u0xCl+OKyfXmVPY4ey/rtWUcHOcY2LE
X-Gm-Gg: AYBFou3NHACe8N4AfAH3Cp8KpGKi+cRrIlnukkTVIXA4/ThePhxi2251sOzWCEiCu6M
 jBJ3NUTrFmFJQhBNUqYF4VE0a2ml5L6rIItR9KAwQ8hjmgE7KX0V9/qSfa6PhUnY/Whsb9PCs4G
 YvhuXFFwdrRza6MvOGgVnv7oiB6MgZGp8VLufwy9yB0oj/fyZAOq6Hg/AOjfQVpTmnuIvO15Os2
 Y86pYiarpwrz5L/6GnOfIF2Amb8vTU9Sryn2N8KYXZE7QdgJq8iGBNrLNefXgxjd9sOESa+j/EH
 VIeC+ZTs2mwG51Fqpmgx+OK9U9KeL6UuJH025bbXalnnLekROy9eYcv1OXKE6gnLw/VjMULmgpg
 FepJPYm9VugB+nSNy2fswxyHJnrD+WvFZYHP0suC0jUSyU0k10QUzaQl4pQ42Y4YqYfwkgcRKdX
 1+AxRRbOqw7jDrH/oN/qJ1DoLRaTdRit8OGFdS0gFaMz4AMu5viaJunTDR8mRQq6Px9Csy3vgpd
 8R789wS4QBJTtymlh171FkSow==
X-Received: by 2002:ac5:c007:0:20b0:5c9:a60b:e5bd with SMTP id
 71dfb90a1353d-5eaaa61b5e1mr347229e0c.13.1792180368394; 
 Fri, 16 Oct 2026 12:52:48 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b2fef79sm2340305e0c.1.2026.10.16.12.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 12:52:47 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Subject: [PATCH 0/4] board: sophgo: Add support for Milk-V Duo S
Date: Fri, 16 Oct 2026 16:52:30 -0300
Message-Id: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MywqDMBCF4VeRWXfAxFiqr1JcSDJth9bbjBFBf
 PcGdfkdOP8GSsKkUGcbCC2sPPQJ5paB/7T9m5BDMtjc3k1uHMZRZ6G2w8Vgx78vhjigonfBVkX
 pna0ekM6j0IvXI/xsTgtNMfXna9z3P3q1Mwh9AAAA
X-Change-ID: 20261014-upstream-v1-milk-duo-s-c4d2935c4298
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds support for the Milk-V Duo S, a development board based
on the Sophgo SG2000 SoC with 512 MiB of RAM. The board uses the
upstream Linux devicetree via OF_UPSTREAM.

The first two patches cherry-pick the SG2000 dtsi and the Duo S
devicetree from upstream v7.3-rc1.

The Duo S gets its own board directory, based on the Milk-V Duo 256M
one. Apart from the devicetree, the two boards share almost all of their
configuration. However, they use different SoCs (SG2000 vs. SG2002), so
the Duo S is not treated as a variant of the Duo 256M.

Hiago and Andrei reviewed these patches internally before submission,
hence their Acked-by tags. Since they already work with these boards,
they have agreed to maintain the Duo S support.

Tested on a Milk-V Duo S.

---
Joshua Milas (2):
      riscv64: dts: sophgo: add SG2000 dtsi
      riscv64: dts: sophgo: add initial Milk-V Duo S board support

João Paulo Gonçalves (2):
      clk: sophgo: cv1800b: Add SG2000 compatible string
      board: sophgo: Add support for Milk-V Duo S

 arch/riscv/Kconfig                                 |   4 +
 board/sophgo/milkv_duo_s/Kconfig                   |  30 +++
 board/sophgo/milkv_duo_s/MAINTAINERS               |   8 +
 board/sophgo/milkv_duo_s/Makefile                  |   6 +
 board/sophgo/milkv_duo_s/milkv_duo_s.env           |   8 +
 configs/milkv_duo_s_defconfig                      |  43 ++++
 doc/board/sophgo/index.rst                         |   1 +
 doc/board/sophgo/milkv_duo_s.rst                   |  86 ++++++++
 drivers/clk/sophgo/clk-cv1800b.c                   |   1 +
 .../src/riscv/sophgo/sg2000-milkv-duo-s.dts        | 244 +++++++++++++++++++++
 dts/upstream/src/riscv/sophgo/sg2000.dtsi          |  53 +++++
 include/configs/milkv_duo_s.h                      |  12 +
 12 files changed, 496 insertions(+)
---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261014-upstream-v1-milk-duo-s-c4d2935c4298

Best regards,
--  
João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>

