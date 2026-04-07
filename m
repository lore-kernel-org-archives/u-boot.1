Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E008FF5104
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 16:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501928404A;
	Tue,  7 Apr 2026 18:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="RkDG7qvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79CF84101; Tue,  7 Apr 2026 18:12:29 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7ED83F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 18:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-463a0e14abfso2882972b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775578346; x=1776183146;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXxLaiNcMEkdUCWYE3M9npvub7G+SBDeY+U5rFFwLjU=;
 b=RkDG7qvpn9vCXOUbwgi0u6Ze+7PCVU5PoikdGM7WyKDLD9Q9h3zjuaQA3prD1VxO0D
 fDJXadnyBx8z+clQIs+AGeBEeVE4N1kxp1M/RfZBxu9JDxKlPTQKz4w/hwMzIBVg0x/R
 zAR6Jbxr129YXI/RLuPoc0IONiPzPy/cWqozbxAH9yljxjgpTDy0Amyhm1qNOhW2IZ/k
 iJAN9NUlyeJvICwndWz6CHXRLHGpfvVlaVvX71w0L1wr0YBcB+TxGs0YUK9jW0LD0qr2
 iK1pQWCJsFYY2hsc6vE+wLM1yUYmLNw4v+fugCvOa6Mdg6A/jtHb3rL21JJ/IyLGJPsC
 l/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775578346; x=1776183146;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lXxLaiNcMEkdUCWYE3M9npvub7G+SBDeY+U5rFFwLjU=;
 b=firq2yZ14pu8fFY/QgPA+3Vw4kOUkv+3yICLF5uC/BhTGI5eBc9DiFxPRwK5vKdsO+
 d3F7HDtpjGdrgT5RmO3avsAaty98QNJJ7zlIDRN4ciLttIts+8OB0fNhtwuOdTorPYhy
 sDaQgkEbnkmm9U5lFd7to9jyT7suQ1IwEm7XyhxFitDbKdVJBrXlEBo5WN5fibYSq2Cz
 MRgoToJ/mesOH5oGjwMMj0tR9s2Icp9DWDgSG6gvwNpZgqjkT/lb6MXSiCIqrliqZ6Bk
 eU8WSPTNMk7X5BWbR6Id1H4ULLTmbuY/hE43Ivvftjl/NtL9H0lflJufWxnXRhqMj66B
 p8wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAnqRJAUVu/E2uAmzMwKybSNzbFi5aObn0c35Qm9+0rOlCjMuvUQ8Qgb3oEC8AZuqfNj+OKAs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxps5/pV5SDP5GwaGaXgTa3/+1tl1aTWjsV6Xw9Lx/AWktOVCOE
 HOqMOiTMeWsIDF/OIHttLNlPm/AxwuDC2KL9DZdIHYhMCekqpwZJQ/z0FotN6aWURpA=
X-Gm-Gg: AeBDievPnbsVCVp/gWv5KDQ9vSokvql8QpN8GGcH5i7cgoVZMW0Z6RaCTP4UloknA8N
 otK3DVZ/JZsgYr0Cc5g7h9DCKqIbR6r5BS4O4JaUSho4d9GPRAXKwZhIT6B1ylnoBY95tKEC8Hk
 IIs11X0ZdazEPbEF9LBOXTw2LiwzikaxyI/B5W0cbIcvLAu4uzrpAzWq4eDBjbH0fpOm4lsvdtW
 anM4iO3UYRx3Vw7jS5MyYZoutI28kbZVq3bOQHqfZFVv1RZtVIOaicxYN4FswgFJTEEXYWcPaR2
 CrDOLJN5XBgl8586yvYS5cB+fNPBrgq7jVcOjktSXQ6pYXGQdL0FXlppVA6OwoSiQVPFDADGydI
 gQHwlDR8cuxZkKflM1jbB8of8E47lyC0oEnFXaPgjwQ5sNBWK9BTpnxDFWKagA+LrFKHfe63A8p
 /0j5Kq+7EX5ZLVxWZsSYvIyEGJnbEC
X-Received: by 2002:a05:6808:c1e8:b0:467:d75:702e with SMTP id
 5614622812f47-46ef57f0430mr8936389b6e.6.1775578346196; 
 Tue, 07 Apr 2026 09:12:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm9592153fac.6.2026.04.07.09.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 09:12:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
References: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
Subject: Re: [PATCH 0/3] boards: mediatek: add Genio 520/720 SD card
 support
Message-Id: <177557833481.837601.17069773505904773610.b4-ty@b4>
Date: Tue, 07 Apr 2026 11:12:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pLG9KwoFBvReHNSpfDPjaICYVJViGVMynB4AkITc53A=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1SziY1biyvmGfe+vSZcA5CycJJX0PEll9km4r
 Z+2KqL+J6aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadUs4hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASPoIAI5QJXAVsU7SZkW1vHQR8fiurlDpprwkXDf69Mc
 ftgjheZfnQcO6Cm5TGEV33gcylfvnr51aXZqu25To/gG5oOvJ41k3o/MxRz+Wc/e28fUcjzOTR4
 hxD0Pk3gHCOXvtKL6Sj6CP2Yw5NANF4AYPC3GeDvtcp4VQW1fTrf++t4vv8lmLDXvk3McBuotzj
 TLjXrX24mfJwC78b0PF8OP5D17S4usgwahbYoIPcz9FiBosTu5x9+vAZDA9D9/lu6JTdTM5kUVh
 yaM/N169Cms/o5c6yf0+2z0j7gaiVqf2L5VmECmWa+bI/WPU+fugueyztv8kSmK7L38BaDrt1iR
 LifA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Mon, 16 Mar 2026 16:55:13 -0500, David Lechner wrote:
> boards: mediatek: add Genio 520/720 SD card support
> 
> Add required devicetree and defconfig changes to get SD card support
> working out of the box on Genio 520/720 EVKs.

Applied to mediatek-for-master, thanks!

[1/3] arm: dts: mt8371: add SD card nodes
      commit: 34b43ab5e151399eb14ce53468377c376f34e305
[2/3] arm: dts: add U-Boot overrides for Genio 520 and 720 SD card
      commit: fbd4bd3a1e4dd0f1fc1ef37c9694c4165edfabb3
[3/3] configs: mt8189: enable GPIO support
      commit: 3a12b2c7cd2a1ce029f26cd7d09ea65c9e1c28c9

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

