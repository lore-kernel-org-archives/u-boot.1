Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D18CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BE3D60668;
	Fri,  2 Oct 2026 16:36:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qgOXmOj_hg2u; Fri,  2 Oct 2026 16:36:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7982B60708
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790958970;
	b=FlSLkOfrTPdlF2l7KaLJ9Z9vXdvz+kk5oQLiMpQH3FuECBYysHjQ/fUjB+qLesX3XRZf
	 tXwff8S3JpfrBq2ecqDwcPRzd7mCHh3mbBJRHxAmhAa6BBMgqW7dLc+buv1F9ztTMZ0jI
	 koV6eufgu+7EEBsetG5aO5pydZOgap0dHOKQTFk+WbGKc/v8WkN+uLaekdTSMWiSFkB6Z
	 LiDLJTGhhw3oEZq2t+ITOlg5244hg6wBxzlRzg3mT+Gv8ngn6lmaFXz41z9WYur2yXgK4
	 XfWKlgwjTKhyX8x+DGWQXI4KlRC3P+nMdQNAE6P67TBfrVwBrOgu5XryKzDmgKm+dWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790958970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2E59D3rCdkdzFwDoBguwNoXnhABN14pdODlvzgCCn8o=;
	b=V55ubvwHlqNUPaE1UbAMls43awiLkgwhU8/NwxpQnoEnMD1fSxZXml5yJN5/tiVlfPQx
	 uFNc2zQ9iOICS38pgpF9SjUg1BGc8mbhb/STT4scIA+XlKz1XmcU8ZsZG9n16v2RkM5Bn
	 5K8bufFmdYDpzHZwXc5XhyxTnfJcxe1Y38wxC7cN2xWxqfPwUY18rc/wlPrjIPzD5c9wZ
	 3PzobZU2r9HumguyNOfdZjrrV09zAas34db3DoKHzvG+sIjSlf4ZWci9TtHXYmYvsCRgL
	 iQ5siYdfckp79D3ZDNcG3lY+HRLR+cJYtsBp12toayzvKYJjO7Nddta3RWHoyrERduw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790958970;
	bh=2E59D3rCdkdzFwDoBguwNoXnhABN14pdODlvzgCCn8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ySc0+w7Ne6hSJrPX41+IZ+c40jbU4c2zcsinv028Jh90mrVo4MsPgauZo8RuPzkbH
	 tyha9J3qIJAhoVNfHtyvqjatd5jWpSuRNX69ouDVxtv2VpTVQ/mUd3r4fuO1qUB7od
	 mFoXNDZQPNrLKPh7/bLitVm5v9mXLxVkBgwO32O41rZ3m/JTrr8WOZcQsIPZ2UNuvh
	 hQXyDg4VkAp+nJHRf4/IY/XLHBA4k7/DqMeLcASVBLYyFMD9Aos3QDMfEczU7jc8T2
	 jsVKmuX4CrOCbQhnfxQzjcmcwTz11ksjsNFUUyvAIMnO6tFyD0FBSeFpMcDylDZEuT
	 kgSPDL+WWmPsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7982B60708;
	Fri,  2 Oct 2026 16:36:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA4F34E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E61A40D78
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8XYKwAwwuJr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 16:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8EF9140D6D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790958967;
 b=VDuMXqQOFjO2i06bjxvcrP0P7w+WDucgg/O5R8xZ/GYguRa1TpXpQ8nHf24N7pJRPdO7
 8BUOBz2D+wQ148x5xXp+t86LFxefSL5MDVi1tO7zE2+bj1XXv7n8j4HoqoiavdKVTtJds
 ZLnfKVkwzXZCZjTWbfKqlhmr5MndSTh8XNydTGLTraSe7hN+Di9cPHne9WbENgBbeMcfJ
 9HexpdjHD9oLx65aPvQU6vaQJdP/7L0FSaOQCbRQFKoV7TI42Sc8TaTUcr0MtgHSDsRVX
 cGEJf4f4DnUlnla7d9WOYT3tC1Scddc6Y83HxS60Fj1HdwOAJtOYhk8/w50ORFgWSkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790958967;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=2E59D3rCdkdzFwDoBguwNoXnhABN14pdODlvzgCCn8o=;
 b=qXisNf+Aovr2gcTZlwH6Q7fP1dZ1D1AzU+o+TYncnixyHZZDuly8C12bG0JqdPqRBpG8
 MUvv4H6ljeq7Hj18/KyhfYKXkco3l1snJ+9YZpfyj7XXnOfe3NjY0tSS8r3f8l3uM4Ukf
 yXiFj43Q2Jnljk/6+0qsATrOyOSBQFVkL7TLJwPKfsvUcJhp+3mFp6+mQnR1tzs+ZCR4p
 F9TlFK+GQHMAHXqcMxaOe2MudrvdB2w6lUOypMGE+BoxlSw1ewP9R5xjtwiEC3dKCeBuy
 1N3izyeRq4sAPfjKxkcP6bMl1GExrlN4FJMqK+Td2Z83gNU2+oAMNzw9bsFRJMedmJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JjuhKTD0; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JjuhKTD0
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8EF9140D6D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 16:36:06 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so44505f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790958964; x=1791563764;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2E59D3rCdkdzFwDoBguwNoXnhABN14pdODlvzgCCn8o=;
 b=JjuhKTD0rY9Mf+E7znJjH1e1CiGCZu27x5F8qVKnvL3MmTH/RcDdMlb7qKDYrgMB5O
 qYsh4NRtlOmxKK/AqbVUEc57F5AlVdQXlCu1v7tj62FBX/h9wBqWAnZlbPbCSnQwDAWZ
 2EPyWcvyf81p8iJpNVF3cSr+5f8IObtoONqZCNf9/YypATFHacWtXGid0E376dsO/8p1
 6/tWDe7t3LBuOQ4lSIyz6OariKwrCkiNYhp4ZzyapPk9ZLCPY7HUMAhBshyLpvG5EY46
 p/ke1AE0UUVbljn9cg4v7MWQ599PjuOImndNyeORju8g8UTwvBbl3/iSgfI4sQnfmYRN
 jATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790958964; x=1791563764;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2E59D3rCdkdzFwDoBguwNoXnhABN14pdODlvzgCCn8o=;
 b=ivTjCcuA4aR4CYgqDwU757dgmAToIzDYkGKwb35AsUS3bQqap28YyjsuFLrzZ+iIBc
 w5N24IlQpPiwzS9zqqW1oshSTQkoMCNThfwo65IUO0mUOWaCfvgG+YOkD5tO0W+BIMdx
 BLnz+DSz+zTnCACYXREEvoN8PuQbSrhfsvAlwrgJ+odpDswdGWdFmP3rImASs083B9oK
 86Qq3ZJt3g+Q4+dIBG6vIG2aPvI0F9BdQLdRTrhjJHMa4fcCgLQB//Fdoe8GZYCozZ3S
 xTTsSaMn9tSl6e18vhl0KBYlRlV6lHJH8WkUGvZe2qtTCRATOM9AX/50FKmDD1KKbVeW
 lw/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUYv0D1a1+0LEIFl9lGbt+/LtVfoMnXsSMYTrf8zhSe6hPEvhCK880fFXAxPMtnjiLDn5Jz1Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKomriRFxe/xAtsIDtal+GF8CAE127NDwWSVDrM3nNWmVrbq1vM
 r3DLJ2OazFBCdaj1cCex9cw8lsu9xN16Rw2uet/QiTPuE2lFSgOfnsHO
X-Gm-Gg: AYBFou3OTbxwiEhz4cA2ESH//wsWw/Zxueoy6xNkpAq86wADBR+vxjTRKOGjv+5IUDy
 cpoqn7cKmjke/URCma8+NdoDHegiwSOpFQvMD3ONTNgrmGy6pp0lQlIfOrmzorO/l3/gD10xZNO
 wdpq9Z4UNLsHfgugSNMb2BvuYCBi0tbyjOVBmvqC6NVUHjJ9iX1kSc0wFIJhG6CuzvH/6s53rQV
 EZrnLgte3Dd4NC1l2PyV8w0m8u96X/klIOLYB84VcBsyHgDaGbei7xlgFsTeFzmMj+b/wHSrrlQ
 JEfUJ2LaZTYdQmd2Mh6pBXhdl6RDAyK+ZVxHLo8a3zC7KDK+UIOIZEtF/xQ5Zt8NpaATK4i0AZZ
 mcObqcAWP7holRednRk4zK4gV1LwXy83f1J9znZ/fajozbDDzRFpOiEYpW/7Bj2NQ6ZfBzzCPLA
 +IAwA/LcO1XLlxcnwwoWXGbpeMnzmavkVHTOCg/H5Tr5qmJ0/UDatBUVrumX9YxXmboC61oqNxG
 b/Zz984Nw==
X-Received: by 2002:a05:6000:2f89:b0:48b:9ed:b82d with SMTP id
 ffacd0b85a97d-48b12771d77mr5842600f8f.51.1790958963765; 
 Fri, 02 Oct 2026 09:36:03 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.234.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ae1sm7135338f8f.39.2026.10.02.09.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:36:03 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 02 Oct 2026 18:35:58 +0200
Subject: [PATCH 1/4] arm: rockchip: rv1126: Remove useless TPL_LDSCRIPT default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-config-v1-1-11bb20983682@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
In-Reply-To: <20261002-config-v1-0-11bb20983682@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

The arch/arm/mach-rockchip/u-boot-tpl.lds linker script file does not
exist. Therefore, in the end, scripts/Makefile.xpl logic fallbacks on
using the arch common linker script: arch/$(ARCH)/cpu/u-boot-spl.lds.
This is also the default value of TPL_LDSCRIPT option common definition
in common/spl/Kconfig, thus dropping this RV1126 specific definition
simplifies the configuration and has no side effect on binary outputs.

The RV1126 Kconfig file with TPL_LDSCRIPT definition has been added by
ffb191e458c ("arm: rockchip: Add RV1126 arch core support") just a few
days after 957848882c8 ("rk32xx: Use standard TPL linker script") that
removed the arch/arm/mach-rockchip/u-boot-tpl.lds linker script file.
The commit date of the second follows the author date of the first: I
suppose this caused the inconsistency.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/rv1126/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index d066df9a86e..57ef4e1aaf7 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -43,9 +43,6 @@ config SPL_STACK
 config SPL_STACK_R_ADDR
 	default 0x800000
 
-config TPL_LDSCRIPT
-	default "arch/arm/mach-rockchip/u-boot-tpl.lds"
-
 config TPL_STACK
 	default 0xff718000
 

-- 
2.34.1

