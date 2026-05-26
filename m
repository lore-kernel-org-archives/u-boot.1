Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61773CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C933E846A5;
	Tue, 26 May 2026 07:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=vsit.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vsit-ai.20200927.dkim.feishu.cn header.i=@vsit-ai.20200927.dkim.feishu.cn header.b="iwJwsIHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54369844CF; Tue, 26 May 2026 07:12:08 +0200 (CEST)
Received: from lf-2-19.ptr.blmpb.com (lf-2-19.ptr.blmpb.com [101.36.218.19])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CF88404D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=vsit.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sszhang@vsit.ai
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=vsit-ai.20200927.dkim.feishu.cn; t=1779772315;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=5Wjw8kyWhHXFp8CjHAX/LdrXFyzoi23eM3R5Ec19ap0=;
 b=iwJwsIHkZdP6Z7KhGSxRFJ1Gl5ErOh8ptockLCGjfiv5PNikdOsnuxIh2H/hVw1oiHDDZa
 iJ+NWJKyXl86hLWFYSgleoytn4NRNyNomsUQ/wiWbyRhU5zNXiTJNbb1Su4KaRllofHuyq
 EFCiKdB/dXyXt055PLc03V6i5NmH8kDmaBBmn+fSZqCh5in8BnS0RTjsEfhiCxC8wteSEI
 Q0pgQ4Meln6kwObVQWMggHc8SZeD6swuROTLJ2SKeE5kumgO51Yp7+2Ybk6Kk+XTwnCnOB
 icebQB0qgUcKGMHDBQUz0NvFafSniQJs3tHRSS3aJQPM0i0ahNV3zKP3S8QH0A==
From: "Songsong Zhang" <sszhang@vsit.ai>
Date: Tue, 26 May 2026 13:11:25 +0800
Message-Id: <20260526051127.2691-1-sszhang@vsit.ai>
Cc: "Tom Rini" <trini@konsulko.com>, "Lukasz Majewski" <lukma@denx.de>, 
 "Patrice Chotard" <patrice.chotard@foss.st.com>, 
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, 
 "Michal Simek" <michal.simek@amd.com>, 
 "Quentin Schulz" <quentin.schulz@cherry.de>, "Yao Zi" <me@ziyao.cc>, 
 "Junhui Liu" <junhui.liu@pigmoral.tech>, 
 "Peter Korsgaard" <peter@korsgaard.com>, 
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, 
 "Raymond Mao" <raymond.mao@riscstar.com>, 
 "Gabriel Fernandez" <gabriel.fernandez@foss.st.com>, 
 "Kever Yang" <kever.yang@rock-chips.com>, 
 "Finley Xiao" <finley.xiao@rock-chips.com>, 
 "Rick Chen" <rick@andestech.com>, 
 "Conor Dooley" <conor.dooley@microchip.com>, <u-boot-spacemit@groups.io>, 
 "Vincent Legoll" <legoll@online.fr>, 
 "Huan Zhou" <pericycle.cc@gmail.com>, 
 "Jamie Gibbons" <jamie.gibbons@microchip.com>, 
 "Randolph Sheng-Kai Lin" <randolph@andestech.com>, 
 "Sam Protsenko" <semen.protsenko@linaro.org>, 
 "Peng Fan" <peng.fan@nxp.com>, "Heiko Schocher" <hs@nabladev.com>, 
 "Casey Connolly" <casey.connolly@linaro.org>, 
 "Justin Swartz" <justin.swartz@risingedge.co.za>, 
 "Jaehoon Chung" <jh80.chung@samsung.com>, 
 "David Lechner" <dlechner@baylibre.com>, 
 "Julien Masson" <jmasson@baylibre.com>, 
 "Macpaul Lin" <macpaul.lin@mediatek.com>, 
 "Henrik Grimler" <henrik@grimler.se>, 
 "Kory Maincent" <kory.maincent@bootlin.com>, 
 "Anshul Dalal" <anshuld@ti.com>, 
 "Bo-Chen Chen" <rex-bc.chen@mediatek.com>, 
 "Justin Klaassen" <justin@tidylabs.net>, 
 "Guodong Xu" <guodong.xu@riscstar.com>, 
 "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, 
 "Songsong Zhang" <sszhang@vsit.ai>
Content-Transfer-Encoding: 7bit
X-Original-From: Songsong Zhang <sszhang@vsit.ai>
Received: from DESKTOP-2PEIDHK.lan ([182.120.119.38]) by smtp.feishu.cn with
 ESMTPS; Tue, 26 May 2026 13:11:52 +0800
Mime-Version: 1.0
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
Content-Type: text/plain; charset=UTF-8
To: "Guodong Xu" <guodong@riscstar.com>, <u-boot@lists.denx.de>, 
 "Kongyang Liu" <seashell11234455@gmail.com>, "Yixun Lan" <dlan@gentoo.org>
Subject: Re: [PATCH v4 00/14] riscv: spacemit: k1: add SPL support
X-Lms-Return-Path: <lba+26a152b99+b59d7b+lists.denx.de+sszhang@vsit.ai>
X-Mailer: git-send-email 2.54.0
X-Mailman-Approved-At: Tue, 26 May 2026 07:40:42 +0200
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

On Tue, 19 May 2026 06:26:18 -0400, Guodong Xu wrote:

> This series adds SPL support for the SpacemiT K1 SoC, enabling boot

> on K1-based boards such as the BananaPi F3.



I followed the steps in doc/board/spacemit/k1-spl.rst to build and run

the SPL on a BananaPi F3 (K1 SoC). SPL comes up over the debug UART and

initializes DDR ("DDR is ready").



Tested-by: Songsong Zhang <sszhang@vsit.ai>
