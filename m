Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4F606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ote256Bf;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Cez4hUj9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5174440DCC;
	Fri, 30 Oct 2026 17:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6C3GM3aAOEm7; Fri, 30 Oct 2026 17:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9781B40DCD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793379986;
	b=iDJi9OZEYmV4Knl1GCpyiNgBNVPHmbMqt3Kxxv71QNEHCg+YYSZ8X8ZriOR3p0EV7qCg
	 inW8e2Hg3hPwGg28JUorfJW4h6Ota2TlMtw2AJkmgi6ASW+oF4WaktV4ivKLgkPJwmTv3
	 PUkEdqFzQvbnhi6Us5w1POwa6+iECiUdfeZNuSr8vDQtU3ZQnlG+ziw5ns+E6ihGNZVRy
	 n3lAJKlsk3z9knS3YtiHLkWXJNE+XwJre0uFSYkV7glztcWxO/2pYuNtzMn+oAMH8YsRp
	 Elhcuhy/JDhjw2wE2et0RyWOA0H3WEEcQhkeAhDmgT4hZXw1MFVlnTGVEhYPEt+Pvnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793379986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ntO9Anww0hvdzdwe8PLw/sR7kz56P9KPRrEl72UF0yo=;
	b=D9o6Fbq1dStj883dQdJcuAzhm0SVgbwp5d2ai7Q/kEGlx9I3WUMKS0Ge71DLHXTt4xlj
	 6IRQsUzvzAYm8mtK8F3TteIZ732gK6JS5HXNgLN/b3JbA4iP14EyIjwWSMuqScMEhykEa
	 TqtbZ757xpBlsTTdiNmSX7nP0wZvS+RX+APPFLc3vdujDWK1lKTeqp8zAW7x4FdG/gkFi
	 5WLHqIy69Id9d176YNISLF5mnssWG5+EUnycJlV3o1pW8/pBDr7gFZUrIv9xhCI+AKJaP
	 WHPopHC0OFwm3DjTdb1yCZ2q6ttTYwePErFZal99tLdEZs0Ym7rvXSSeNmvEZvyFXHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793379986;
	bh=ntO9Anww0hvdzdwe8PLw/sR7kz56P9KPRrEl72UF0yo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ote256Bf55dh3IdVIsMr2mk9QgcE7/joKXB38rSPon2200Cj3XzWEApOPSk2RdJin
	 0qR+CZuboUwZM+evfLa8PAGRu6mBU1CnIXnk4pMBidK+k4KJZai8DRWsvsDeH6bNQg
	 G50SeLPt2fR737Bkm//DAjs8gBe/QNmIkxiPiHPysTWF8jyx6xk8riIAhclRa86Pn8
	 lVF4MCHvMZpcCCIdqCGoKfTpzG45bmVrJHYsQTPA2td8XY5RP4vMULDf5f2IulVnmI
	 UnrOqH+zhKKRtLlcCXBHZzwDGhCJqito9fXmKGaW45WIfzcDvbPW71/bJIbRk34RJ6
	 v2+Y9i/RrzzzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9781B40DCD;
	Fri, 30 Oct 2026 17:06:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B3DE362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 215B94055A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:06:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WxUvzA6jomnd for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2B341400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793379984;
 b=napq6W79vYMLMSUH3j6Nz6gV2hGlgqGK2ujM+69RFuyyDjfOxRmqNl8IVmZEOq9i4xvW
 oUazu3zIgfjbkSNJ+gVyQnWdoBgv4JD/e4udvR7oaESO9MgnpseKzR3B7Ag1H4jWvIQAh
 JCsHmcAHFKH8iF5oAkUd9DzZYEBpbZ6zAFM6SLF1ATtvnxEl/XB5IrdkO/k337/G8jbLf
 ekNRDCcJKNO2owy5bSuBfI7ljcQ2WuJ6vLEo67qmP+Fl9PMtw6lMj5W0M2FKj/DSnrOKh
 iPTjIMp8YjRanAkjMxsJiy+WwSeQkHaAtu6dWtGvzdSEKoljR6BUQFeqw4i9nN4O0Ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793379984;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=ntO9Anww0hvdzdwe8PLw/sR7kz56P9KPRrEl72UF0yo=;
 b=f1UdN5sTNftHD9a9wbFa1faUOKHZe8ilfuRVsiwB4mIWZ7IgH4ONXCKtjwL+GxQiP8Hk
 75tp3SsVp8aElhcR9WPcTUxxYIKXkTeSxiJxze9k+eKgM/W2p79uBHGN4NglY91V2/x6D
 86MDXkIgON4D6aO/FCVgJDRugsEwzU6ZruV3ynqfVDmjvuewdKHMVGLdVymc1Vo5Eohy6
 2GZRMLBJO4nlnc3NVWgVTiiaqotdJ5saVdC9SGxB0vtRg9uLpRDVmwsv9rTi0U4EMVuJN
 bGzJpnrO5nKegERvpYFm+LvbJW6T5fVS0wxGTqtSO95Onhe8dbCHqCJFwpdMBeorbqg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=Cez4hUj9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=Cez4hUj9
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B341400AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:06:23 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so8080025e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793379982; x=1793984782;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntO9Anww0hvdzdwe8PLw/sR7kz56P9KPRrEl72UF0yo=;
 b=Cez4hUj91D1cRbmQHlwxNPWqCBDYFu7egi97+DD40G2XHBwqtrgHOpJRX7cHbRsIzw
 pHxnmFV+bleKkqRKV4jw1vCaqnQ3JKhUFvdty+eZ9nYfFn8vIo8xoq5ChBIwWF3TKN4E
 SL18njsWUXqlBLqiBvlAm5aHdafC2eb6svgKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793379982; x=1793984782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntO9Anww0hvdzdwe8PLw/sR7kz56P9KPRrEl72UF0yo=;
 b=Paqz1s7FmFczSeRj9RmJ/626CTsCzIGWiTMYlxcOeRUSD/B5OajxZuZz5AVjPPHyB5
 quDdi0dnbAIM/Hqxw5B/1vUtmptYjCsweG69aaOK9OgdKnbuKcSx/TXfXGc07UZltOZP
 VBRCWwJRx0X/yiXH5D5MBczQKhtSFBHT7iHzev/LOaSbTCT1mJK4vtaW//5M0KudkBiF
 0Wr242nAJJMV+BnpqWdDl7C+rchY+DLa0dmjuLM2zeFhl/870yMNsDvRZ6HeOx1LUh0f
 BISVgWoeRPUE4BCpl+QIR6zNr4EEk7tf3A8fUcF+lD4SnequAqdz88mBNP/ua3XWK112
 v+LQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt6sZFOvVbGFU2pL150uIuVV/vjIUKuVfkuj4EeL7xG/NZNep0ipjXs7/aVxbuMBiLAC10m4I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZSdyQQB+S/p4yO8g7hyutgFQKhmVcHSDIMRyxT9xpfX0tLfAd
 xQ6tU2R7Ts4i3jkItpwcBaKHq3TqQrIopX8pNDAhSMtPC7MpJ0144LUCfYtx6FRa7LU=
X-Gm-Gg: AYBFou1K53cboqIkKykChTdYBg4h64b4l8HB+FdAbeojliUJA+UtNbUvTG131utcwWI
 N3rylEJ47TW2zhd86m6Gh8pnZ3GsEe0Lz0DcX7dSCcBITEAjYj9y7ix/ne9pYTtXOekpLPj7wzu
 wecnJKBRImR6j5cTy7vlWLWETrDBnU+ij1XNFdwGHyK+7N39Uxfh+bWPbbFS/deXxdGxlR5LWgf
 e2fuvbeiyRy3KFOt78UO1tHziECmI4R0/qPU6pqiDOEwY7G0xAHlIOcMpN3lSQp0EW3RoA2xugW
 0R9IOCQ7+30jT9/3RkcSsaq5vcXQnDOyx/oPw76Eu1GvLB+BmVQ3WRkl7vjSNLx76HEqWL9Eplf
 TsbqefOnhlzG3to20M37hwfYVqtcg9WMXnXtgL5kOD+v7Yt3wh1nj7Ec4M62y1HOLDbPTE5qBdk
 SUL/275jnMAFYNpLbn1dbkyYrc8j6k/WQl35a5JltMxYUg9UcBS3JUJ8pKpC1JUE9ALmZ7/rC7u
 fR60j9w+LYj3Pvjuu7ySz/Z+l+DoH5eF282gsxr1mQpWwpEM8MP8ZcpPGOe5YTkEkNFbMkqRPFG
 ERJ2F7hscP8MJJQBjpprqqfurv4Nj9v/oSBrP/JnYFIYwRbDzZUDin9mIz7y0CjcrK7QsliW/q3
 j2TtWw4K3LfRYYrwlu44OJCfF5RInrOiRcV9dGe+nQ6zF0MvNWnS8/o5Gs+4wf+S3nS/XhwXKIQ
 7nSJsY3m/aTOC1XMSyYNpZq6iOlfWdMHug78lJS5OjWYLN9WU=
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ac14ec7947mr61713645e9.2.1793379981733; 
 Fri, 30 Oct 2026 10:06:21 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm188053075e9.15.2026.10.30.10.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:06:21 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] net: dwc_eth_qos: Support external RMII reference clock on
 i.MX8M Plus
Date: Fri, 30 Oct 2026 18:06:11 +0100
Message-ID: <20261030170618.2820085-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In RMII mode the IOMUXC GPR[1] setup always selects the internally
generated reference clock, ignoring the snps,rmii_refclk_ext property.
On boards where the 50 MHz clock comes from an external source, the PHY
auto-negotiation times out:

    Waiting for PHY auto negotiation to complete...... TIMEOUT !
    phy_startup() failed: -110

Set ENET_QOS_CLK_TX_CLK_SEL only if snps,rmii_refclk_ext is missing, as
Linux does.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-imx/imx8m/clock_imx8mm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
index b7b3702041ee..065a946f2855 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -10,6 +10,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <div64.h>
+#include <dm/read.h>
 #include <errno.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -852,9 +853,11 @@ static int imx8mp_eqos_interface_init(struct udevice *dev,
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		setbits_le32(&gpr->gpr[1],
-			     IOMUXC_GPR_GPR1_GPR_ENET_QOS_CLK_TX_CLK_SEL |
 			     IOMUXC_GPR_GPR1_GPR_ENET_QOS_CLK_GEN_EN |
 			     IOMUXC_GPR_GPR1_GPR_ENET_QOS_INTF_SEL_RMII);
+		if (!dev_read_bool(dev, "snps,rmii_refclk_ext"))
+			setbits_le32(&gpr->gpr[1],
+				     IOMUXC_GPR_GPR1_GPR_ENET_QOS_CLK_TX_CLK_SEL);
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
branch: imx8mp-eqos-rmii-refclk-ext

-- 
2.43.0

