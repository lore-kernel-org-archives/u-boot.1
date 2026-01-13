Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3884CD29DC2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 04:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEC383885;
	Tue, 13 Jan 2026 05:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191648393F; Tue, 13 Jan 2026 05:02:57 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 699F083885
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 05:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 6FD1D3415D3;
 Tue, 13 Jan 2026 04:02:47 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 13 Jan 2026 12:01:57 +0800
Subject: [PATCH v3 3/9] sunxi: a733: uart: setup serial console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-01-a733-soc-support-v3-3-f19dcd098f60@gentoo.org>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
In-Reply-To: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=QLpEveh1wTIRuz4ELTNPmJ95XgJw/T1JuXyoQqpBTPc=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpZcPHQzX7KHE72T3GfzJNKMJ7sofpQtTBxLdmk
 fUX6IxpAGKJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaWXDxxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3nFQ/+Nv5ZiEsIKaDZ/k9TI9UxSlqkytCApEdaF322oy0HjiUul35Ru3Prq
 0iydw3+cZi2piGYxJjnrjfRVnU3Lo7C4ekIeKjd/v8Ggp0bi/py5V79PuZ/gIEJWcHz//U8GiPR
 YbA+UfW2ep9pbFdmnlBrjYUGQH/LpCbw5/UcQcc4+DdoZ7Dxsq6E3mMYb3Llki71o7wckWONjgz
 PJ+TnNs2zsHOBkkSXz2iMHbVTn00SvTXMOz8hnRsrku8dsids7bZsR4yUA8fOQVdoHoDdqG4DiA
 /qbnckeiCLhm0HfU6pLZIpL2V292Xj4ZM6BEqq5cE8c1WLH4UaNfxGhC6VHpif/+WQV1RggvrpX
 dHeSxfXZiMz6BbMKZKgD7c/YhtInCsqwyTM+WoxMpMN/LweN5Bn/CIDDgx55oJmv+qelpFlgbz5
 fODTaGWBA6OpBwVSs9IbfMkDdMaC67t2FlgeEAmukXLgg9LJEQM6M2qcd1YLeXWxcZDgIru84t1
 NmTsQ7BHCo61vVZmeiaKwvTJxE1N7znanOjj2irNYD0N7OJDNe4qaq58AobznrTFNLG2cA1WJOV
 35LzkTqjdvVC5s5XPpxYg3xjMmM7vDaXpGsmu4vsJYmUTKE8JOViqrzMjtibCPaLRneu8bAWNW6
 WH91DG+OLez8rjxKSme67b5w62oyTs=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Setup correct UART base address for A733 SoC.

According to Allwinner's board design, A733 SoC use the UART0 port
for serial console, so config PB9-10 pins to setup pinmux.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm/mach-sunxi/board.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f92..72c9fc413cb 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -141,7 +141,8 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN55I_A523)
+#elif CONFIG_CONS_INDEX == 1 && (defined(CONFIG_MACH_SUN55I_A523) || \
+				defined(CONFIG_MACH_SUN60I_A733))
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), 2);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), 2);
 	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);

-- 
2.52.0

