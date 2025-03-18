Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4508EC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2AD081CE7;
	Wed, 19 Mar 2025 00:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dlSQVJtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF3181026; Wed, 19 Mar 2025 00:43:02 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E64281CA8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4769bbc21b0so62763091cf.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341379; x=1742946179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N95iawrdqIep4/62/LqB7wkXaBcYgaqdUQLXyN1KA4M=;
 b=dlSQVJtr9rvkxN9TfhYgyFQjNgtCuMT0omAtKhASqcy5pYRi3agF8GHTRVpvZYKDTK
 mssrdaxw7YcK4jkhCgxU1XlisUDSzKo4mbsDka/IVjuVYnQwvMDJ9aJzHGvDiTw9TuCc
 OM64+YjT3kzAmK9oPttdwSKb+HJyTvzUB6LWAlOasRLRbRiAoIS2KGEQRuCBKSEHR3N3
 Ystg/D+0l0E08Dobml2FAI7ze18Z5troqxZG4lqlGBXlPmeOTE57q6lkSVAXZwhjebIm
 th9LKuQIYo1V7wY7Drfm/LIhlNsW9R1YrUsl1epNr+sUfp4GDpH83+b0U+IeobDiSFNp
 Ycyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341379; x=1742946179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N95iawrdqIep4/62/LqB7wkXaBcYgaqdUQLXyN1KA4M=;
 b=pWaUw0k1uTSGaR5JE9p9x9uKHk101/srd9+Fn9h4zyO9lryqoPq7MhMeGlo18Oecty
 H1d6Y3eHtG4ti5PrmzbNfgDzQnbLpeK+N5zHNJtfvuFgcLI35Gvigz7Ogwq1vOPLO5Ue
 kr+v3J6ZCmnfMKIDK07RkPmHmCjEolVJc/vNqoR29iFRbtHOQrdHV5Ik4VKWubVymWN4
 ZroFcQITiZuLvAK5jIOIHPoiF/5A6hfH8Ph4ywOe86VkbRcXPx/H1SpxaMXpc4SeI63c
 Excx2Dd9wXJyw2fGXcFQlVUHW52ZUZJwIbsjrfwgEwU+BfcPbq1Qtsa+LAUefjCKDqgO
 QZYQ==
X-Gm-Message-State: AOJu0YyYo6oi+tGt6Pj9ojPnmHRIiVsu5bVMlQLVZGu2rL5tqZH0dyg3
 ShzjErtvWaz6IZ2OcznZg0BC+75f3RODgGBRF+4Zhm1NoRlzkIFxGySoEg==
X-Gm-Gg: ASbGncuvV9DHnKJEP0MvpknxQqFEQ9fcBor3Si+vhis9O9gVbW3TEPfw6FhHbZKof73
 WUzVktDgwrGFOsm5L5VhSyBA0nZ8UYKngAvNrZCUjU/bk0wMmIHUWjEC3ynvzY1Xv5IIX4GFS6b
 I482KMvkIupyQcd/vS63lnRD5nDcH2JYMbdPeAGDEZ29EBxOdkcIrzt8IWbU0vPUfTu6T3HW4tD
 aBO4kjJbNiYTRSYbYnS7jNpdFWmYk6B1sRbj77ETHm89kt104d5S6d3iieqkZHWJunk5B/AOggQ
 n1YhV2NXf+FJWP93iXAEG6VZ2fzeiaFg5h8XXZp1gHXlUkTfHL6qkDawXSuAWndB5pww2gBFmR7
 3+Ygn/aDgAAjY6pQZJ527Qem3c5MIKA==
X-Google-Smtp-Source: AGHT+IHOUETj1yvnO5CmMbbLTwTUYEFEv/+b1GEQOKKQhEuLfd8o4OfkROM6VmZ2zG/4Lr9VxX7/Og==
X-Received: by 2002:ac8:6f10:0:b0:476:9847:7c73 with SMTP id
 d75a77b69052e-4770831fba2mr16024731cf.26.1742341378562; 
 Tue, 18 Mar 2025 16:42:58 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:58 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 08/10] clk: imx: select SPL_CLK_COMPOSITE_CCF when
 SPL_CLK_IMX8MP
Date: Tue, 18 Mar 2025 18:38:36 -0500
Message-ID: <20250318233849.587520-9-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318233849.587520-1-aford173@gmail.com>
References: <20250318233849.587520-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If SPL_CLK_IMX8MP is selected alone, it causes a build error.
The clock composite is required when using the clock framework, so
select it when SPL_CLK_IMX8MP is enabled.  This is already being
done outside of SPL.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

V3:  No change
V2:  No change

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 56d893e0579..d17a54fb9b3 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -60,6 +60,7 @@ config SPL_CLK_IMX8MP
 	depends on ARCH_IMX8M && SPL
 	select SPL_CLK
 	select SPL_CLK_CCF
+	select SPL_CLK_COMPOSITE_CCF
 	help
 	  This enables SPL DM/DTS support for clock driver in i.MX8MP
 
-- 
2.45.2

