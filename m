Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5250EC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 17:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1497F605F3;
	Wed, 26 Aug 2026 17:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1OToVkjETz7v; Wed, 26 Aug 2026 17:22:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787764963;
	bh=ThH+q07QXAUg9m8aCPdLrvu6lBfE/sm0wpobQkYKbAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cPYyEucncnb9WqYeMqAM25ViTcY5Dq8SluRdqdJY1/VcDDz3XmXZ6sRiMT7PLWFeV
	 DDzY5lU7tJ0o5BpEmWIb0Vs/N5mPOsIuXbXpXRkBz/GwIxOn5y5bV9lUL0bMY3LiRr
	 FKx/L1axa/BEk3ORqF6u4WI0aUbhi2cOOMgCVDBDbgiBdZS+x8u1H31nwhv88H7D0x
	 N9KV/RoR9ghi51uHMtqRcxIqOm5/5uYExOtAzuhDHe5VUuUdWDpA10MdfrYnWekD3R
	 LYu8kdJjyq+A7aNjAH47FRdrOE8C8GIp2RY7f2XsTfHOgW1fU5kONs9vT3qzirT2UE
	 Y1jDuFL0m/HPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D64260758;
	Wed, 26 Aug 2026 17:22:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5EFE39E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A76C0403DE
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:22:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 08tJcgkz3QnL for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 17:22:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ddn+LV4k
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79D47403B5
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:22:39 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-448cf99c133so157509fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787764958; x=1788369758;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ThH+q07QXAUg9m8aCPdLrvu6lBfE/sm0wpobQkYKbAU=;
 b=ddn+LV4k4GZpL2iW+eKLML7hKWwJ60kQfzb/sB+QHZ4KHHDobx0JNmdApGKhXv7F40
 V+E1Vn9C7BzGn8NTntzCJkLu8NJkcacC5+ZaNIgfiWa0CaeSfzXv18ZY0wUFgIQP/D6/
 DNIo/jQ8Q/0hwBYpcjdxy2qEQK0Z2fRfYU3ALNsZKtHpisAQ+X2Z45FyXa5Z3xzaXNck
 izBSzrI2fEqSva9/fv1SFyducdySz3afMqC146SWo3lJxpAmkrxnq04mCkNx8/lH8XyZ
 wmvDNxHrqkXd8MdDxVwywkFm9/UtYJORfIxDoHRc9wABa9cvnO5fp4APSBLdcexPYWMl
 TkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764958; x=1788369758;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ThH+q07QXAUg9m8aCPdLrvu6lBfE/sm0wpobQkYKbAU=;
 b=Vwm1R/JcQB1HkTPnlJ8DnFrBdOkat0B1Sow7REM9WimMAluuICbE4roRfDskCSj7b1
 KTJq9DbowM6BB4T+dhXp3SNS+0VDq80WooloW9zImHJ5KKqESkJRze1NJIBy1REikgMJ
 i1lAWsBBBSXdpaXjfSX81so/a2qD8DiF7O5V/05vXeRkkeovpofSy2ePkPi0/FoO+ZnX
 n+wG373JJv4N5tiYm+P0NEZcMdikgupUfjQf0yE0jS8Oc2/+kdDH+lMRgj8y9QS0GMDx
 tar3tWCT5xBPQYZEVMDNOc//5e2uvSfXItCGwAK0dZTdaj6AMnQuezqPV3okmkgl9Mdm
 E5jw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXA4bqGj1y5MZnedevoLkB6JVkLZDfjoSbI8J0pJGwWlzGslHAfBmnhsQLJQcUzqWrRCeHT9w=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++klz1z87nawLDbbG/a4dCWZoz+L9IXKMJhLCXKXHHjupwLcjQt3
 Q599LQgs6etGvmhGgYTCaMUp5phzr7yL8xaUXsudLVVOnuuZbSJoHkGigzagXsjVAZg=
X-Gm-Gg: AR+sD11XXCaBHIfR1KokIE7adJGfZT/R7Cved+okxIXZ1jwWl/La4dADGP/q5RRPm7A
 l+WoPXDwO7O3mhULdDIAV6dIMUdHsYW+rcWGWy/Ic6jGWmIjKP3CzVoOjEQB2J505UMaSYkq5Dz
 RvKPxCXj/oXPeB102JfpT6WxhP0BY33Ul1tA8DzeuFw08GGnURpxr7Td8Im60uO7FwJsuzB0qMw
 HQghY3ZeCIieDOt8E57z1EqnwF/8btcCoND23cXhXCkEYoiwpHzNZD4J/V1xKuMsZ5n4aIh+/JZ
 Ic+9JqvkQXyln7c93qa+odSHdJUSLblXXY2jfWy9SE5c/CKq87Z6KCn3ksQh0rEqHoeHzcW44Kz
 clWJ1xlFiBO4BuTpj71oWpX3pZnvWcGzh39ms2xnAjNyAwROuCjs1UV5whzjnYk9fxjpp5rkCmd
 KIOTZVOQztJK5okyfB29WL3fYTnA1sjPLXFUb5TWhgJjTrQ/WbYRCaum2IuJ03BfTv1a50WaGcy
 92S0LQyCGRE1tua7fakVub91mXY+jX5i22MotY=
X-Received: by 2002:a05:6820:6ac2:b0:6b1:349a:8e2c with SMTP id
 006d021491bc7-6b1b01417a7mr639889eaf.16.1787764958547; 
 Wed, 26 Aug 2026 10:22:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b03b5593sm2634956fac.17.2026.08.26.10.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:22:38 -0700 (PDT)
Message-ID: <95c99191-dc07-400e-83f4-b7530e20daa8@baylibre.com>
Date: Wed, 26 Aug 2026 12:22:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] mediatek: add HDMI pipeline support for MT8188
 based boards
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/26/26 8:09 AM, Julien Stephan wrote:
> This series adds HDMI support for MT8188 based boards, such as the Genio
> 510 and Genio 700 EVKs, in order to display a boot logo over HDMI. It
> builds on top of the HDMI PHY driver [1], the DDC (I2C) driver [2], the
> clock series [3] and a clock fix [4] already sent earlier.
> 
> The drivers here, were inspired by the corresponding kernel driver, but
> were largely modified, mainly because U-Boot has no DRM framework and
> the goal is only to display a framebuffer. The HDMI driver locates each
> pipeline component through phandles in the hdmi node and programs them
> directly. The framebuffer and splash screen live in dedicated
> reserved-memory regions.

It would be helpful to add comments in the code where things were
intentionally modified to make it easier to know if differences were
intentional or might possibly be bugs.

> ---
> Changes in v2:
> - Add a common `get_unaligned_le24()` helper for reading 24-bit little-endian values, ported from kernel
> - Add a common `linux/hdmi.h` header with HDMI colorspace and colorimetry enums, based on the corresponding Linux header.
> - Refactor the HDMI driver to use the new common HDMI definitions and unaligned access helper.
> - Rename the mixer component to ETHDR and configure the ETHDR before the remaining display pipeline components.
> - Add the SMI LARB components and configure the VDOSYS1 routing directly from the HDMI driver.
> - Switch display component lookup from phandles to DT aliases and add proper error unwinding for component clocks, HDMI PHY power, and clock resources.
> - Refactor HDMI register access and InfoFrame handling.
> - Improve HDMI mode handling, YUV420 downsampling, TMDS scrambling, deep-color handling, and InfoFrame generation.
> - Move framebuffer/splash reserved-memory definitions to the Genio common U-Boot DTSI and add the corresponding HDMI override node for MT8390/Genio EVKs.
> - Drop the dedicated MT8188 VDOSYS1 pipeline component and its corresponding DTS node, to avoid having 2 nodes with same reg address.
> - Remove the unnecessary `dm_scan_fdt_dev` bind hook from the HDMI driver.

Looks like dm_scan_fdt_dev is still there. Perhaps necessary after all?

> - Link to v1: https://patch.msgid.link/20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com
> 
