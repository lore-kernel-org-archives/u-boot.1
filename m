Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0712C88E40
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 04:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65C06406EB;
	Sun, 13 Sep 2026 04:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9r859tYOs6hA; Sun, 13 Sep 2026 04:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 78221406F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789273420;
	b=BUOHUxEcMIua1+2xW0lNlM/k7OMBTtsqNObUJwPsSkW9wWcCVeshRuv0ALnhUVCyNDEG
	 IvxkOOIfPVN3m2D+P1VZ4EWKFomvn0J12GfbNDlqN2yiC4HU/YgzS6xloPgpgVAFUk4jo
	 ElkjbtycrgtotI9UFv4lj7LDCOe0rQsmiQl1y7jg2zfBUdk3o4jG1JsEmw0MOoo2sXHFA
	 R+EHZqMAhNp+NllkwGd4SxpxoT+IzugbJ5JV1D3u3ENulyv0HtGQ/zhb7bxJODC1tPLXW
	 ZGQeUWZ4thUqVrBL1BdEjvzOezaqL4dpuZVR56wB/bnc+P2Tinahdhz2Poii309qc2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789273420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bc33IVqjFy6NNb83j6W7XBAPBRznZoy9anSzTaA3uW8=;
	b=hyS39TS2IFUZ/NTOqcRt/+IYfWeCjtNe4PPAGV7BWFxrznUYoux6dbbga3XNfOH31jS4
	 qtSZOb+sZtLcKH/NUGDrFNnGuhAaq8wKFECDA1CW7A5oqVcXGoxAK2EDLm7wBDg7FkMxd
	 APHnlRE4XsHG7o6V3HcmCwEBRvcojmAgE79sWgEAQFIW7ax3ZUzVqopDvZloAgEu0IfR/
	 wDugM883gYsbqBS5Pkzrg2rj0LrR8e159KJw+ks4RtiHEksyjF0PhUmTZOw6OngqeuwxZ
	 uRyMWgVj91EFU+WFA9X8QlXYt3ILVBRnN33hkdD1nENXG+HJwNJQYDyqqaVU2AKHyFA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789273420;
	bh=bc33IVqjFy6NNb83j6W7XBAPBRznZoy9anSzTaA3uW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=llZRS4SVOsA0DNLp/GKuB5pnecrl4zozgAkPxc8h1bAQo5nvDBydf/C/Uf30xnBBR
	 AS856TiatD0lz/wgxPRUODYf5fDI1eekZwLRjW2IVN4nuzLVZ/7UaJFboubYzvssDS
	 8hb065JwaQv688pmZi8kJMlCYC2D1t8bGBba6axt27nc0J/8O5XIOJaZfd4t4/qQKF
	 pnJRuN2CYfQwuhAZvwkNekolx1iFQgoA6fXIr8vYgX6oyWiHKGah3VuyzyIbseedxr
	 9+4eRshk7aboOJhH9ylZjobDEmkQHUip3X6mvMdS8X8ph43C9sDPfyf8zkYEPUy0ot
	 tE9DVwcpkNelw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78221406F7;
	Sun, 13 Sep 2026 04:23:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36245109
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17BC06064C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJECZ7suarhV for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 04:23:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DE1686060C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789273418;
 b=E8F8YwpmceOqVCwYZbr4BBugOurDFWSGk2LY+xJ1pOYBpnPOkQC0cyO6bUIIbcJk8EOH
 /XUThrR71GKpuBpA6E6qeIl0Y7PFLMaI/8o7rCX4f6itdN+AfVTkHfhedHL2hY94ioCTm
 n5nK0FHTWDG+cnFLHNfE37EJRi7CRhsaVDnZ7ij2gee65InF49wwr3TZUJsGb6XgGufgs
 F0IvdiSlilMAjcu/jyj3DgXLDzDsdy597T6sWsqIVyNyO3a+8NXNYGUVyUU/6ut1vdRPa
 a1YAgOw6WRIr2j2NBX+1o1L20Ll8GDH4jYbaNB5w2ULkYJ4ZFK/cIVCpAZnjANg35Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789273418;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=bc33IVqjFy6NNb83j6W7XBAPBRznZoy9anSzTaA3uW8=;
 b=MtAgQgTrW3Kw3QJotGohzel4Gwhz08hsNV1xTS+B2UaUEafPiU/q7zuD8lIgA/6e4KBx
 EQggtvNRaIhy1DbqULUYeOXcj0INDNpCh5WifQZtWuQUlCPRLNMDkM81MVrsrm4v1x4vV
 OybjXuBgiDItcUvxNzG10ygsqqOeQzaRzCF4hxS9ptcI+vd8R7DWRo2Hpp1KVS+RKaNUD
 +I/6ys5NGGQYnZtINXYxmI+5Ih0HGvv/CGr3wtglqPtn97611zgsCtWMxn3NZhDivi855
 oUbTyS3L39dd85bRcZy8PJgREyyB5WSa6eKLPkM9QzprjmZMm4vJmWjnYLRFAez+XZQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=fkWthhed; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=fkWthhed
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE1686060C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 04:23:37 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3990fe066ebso1814137a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 21:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789273417; x=1789878217;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bc33IVqjFy6NNb83j6W7XBAPBRznZoy9anSzTaA3uW8=;
 b=fkWthhedtrUZ+gVY30+yMMRm+uppd+x/pouTSN2vv/WBLdLaNzaD0mDe5+JnZIcZ31
 Ds4N1RIR5gGNYvqUPM2JDsTuRySDnRvZpj3v7bA3IYMvEXA70iEp+0ZGWiedcJTHnxvp
 Zqj0dHp0ESRbV8nKF3ooWxXa5YnkpwzTVCdbdBKhXDEvs20uH4ax+kjGBm1hyVX5diIN
 ezx+j5RttFZ3X2vw+s1DwxJJzD9qPacSNozDkeZ/ThO/rIzqsH0ks4WKLTKUWvmDUSR5
 ZizgreZhsT4wzKkrUsu5qm7rMV+8k2LI3N8/J3ETH8v2olGE7uQMAlGcYsV+6Qtzth2N
 973Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789273417; x=1789878217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bc33IVqjFy6NNb83j6W7XBAPBRznZoy9anSzTaA3uW8=;
 b=LOTZyQYQxPj4PlDk6V7V4fWC/GK1nkSAX0O3ZwKbugI7ChMGUFo2s3kitqeRIiBSYx
 HZJFtV7c7a4MAFPPYi/xoZuOJAL7woU3VLDY67LRB6mkGP/94chsgU5YcYzpow3/DU9+
 1FAdY560yyzOw63U9ALy3krfPyeQZuY/QhB8V2s4Kb4SKMk9mcEzB5Cfr5rA7tnwfxs5
 crs5P4FZoPv6Nlpc5bYoDxJKxFq/J6QegfijNwUaStGXhDGlBdr6chHsTGsPkSryVGD1
 VxHOnP45NEeFrmdwuefEWOqOyUgUS+pGBDLgmhWMJBPp/yGfH0ndHjlgUgb+LJz6f24v
 sHkg==
X-Forwarded-Encrypted: i=1;
 AKwUvByJkMdEABEaQDy9Zmxm/+6fueziedpXEfBMycD9bGpiaQXGhclfYQrQsiggeY0diw+UoFEbNiQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nTsZhQLSP836NMZYcUA/0xYo5ZhzxmN997/SAe2RJlgDNfArP5
 yCI4wi39u/sSi/+GSLbWJ17tjfsXfp+tN//+aU7+0hLqfhqbsYaJ+UUEXU1P0UZ/HaM=
X-Gm-Gg: AYBFou0UhKQ0CrG3QPT87G7x0W4zO2bAqhXDJMpH1+vWdxypQ6K7VKSr7sGdhoyjJUQ
 wknypIlzutX+/aVl8Mx32ZNMAtlfHBWOJ1BBjQNOyISbIz5EYQ4A/q1DFAYfipX3bc4zEzz3GND
 oj2xOV/0Wf8FkwLFNigyaaNcWPQ7UTqwqcdWhAEdoi4XB9wbI6XR/XRWbFtJLwIzFxEE2oIaVY6
 WFNin1P5dametOL6326bBgIx3CIOstgbP1Fw0UjqiBvzFHOWN6uoFc0PyD00LWZazJJiCRkRNM8
 XvMVix89TCc+NFx1lUrxc5e8YquBZWc477erSnLxPFSgRHE+HUhMYgDvwa1e/vroGkyE9gEPNab
 sXkEnUf2Qwc6JPhZacpyVvfovySlqXRVA9xhvVQj1gHPG8+W9nw0HmlqWVHn82hHhQneCaLhJg3
 jmmliFfpKtWRcVSlI0m0H4wGhfifchCJ90+ropt+gJHbmo48qG/r+NMB6QbNVugZVsiIfm3H1r+
 iBiFsY3HtPcjB0MNQNUzH8UsxO5V2xvCz7fN0aRWzGSDbxp/PDRK6s1eWSZCJGVoue4zluuaKjW
 LiOyD1IoH4qjJJJsMyLchbAQ0pvrxf9NHzaw
X-Received: by 2002:a17:90a:f08:b0:39d:b1bd:b384 with SMTP id
 98e67ed59e1d1-39db1bdb630mr9072146a91.17.1789273417050; 
 Sat, 12 Sep 2026 21:23:37 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm19389409eec.15.2026.09.12.21.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 21:23:36 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 13 Sep 2026 12:23:12 +0800
Subject: [PATCH v2 3/4] configs: k1: enable PCIe and NVMe support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pci-v2-3-4fa1a8b5de06@riscstar.com>
References: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
In-Reply-To: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Scott Bambrough <scott@riststar.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Siu Ming Tong <smtong@axiado.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
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

Enable PCIe and NVMe support on K1 based boards.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 configs/spacemit_k1_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 5f9923c7f470..9c15d96eae20 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -105,6 +105,16 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_EFI_PARTITION=y
+CONFIG_PCI=y
+CONFIG_CMD_PCI=y
+CONFIG_NVME=y
+CONFIG_NVME_PCI=y
+CONFIG_CMD_NVME=y
+CONFIG_PCIE_DW_SPACEMIT=y
+CONFIG_PHY=y
+CONFIG_PHY_SPACEMIT_K1_PCIE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_EXT4=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_DM_SPI_FLASH=y

-- 
2.51.0

