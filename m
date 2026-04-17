Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0EFF99C69
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 21:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4F68420C;
	Fri, 17 Apr 2026 23:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="YE986jIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F2284214; Fri, 17 Apr 2026 23:31:09 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06DD841C8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6830f4f34c9so659591eaf.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776461465; x=1777066265;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDWgMTmXxj6KuyK28j2WTWI6FHaIx7jDpf5Aowtvpqw=;
 b=YE986jIGi2tO+c3fDFrii96wZjI3YgDQW0J2n/4AzGUJoBgQpaVMhJ7JL0ffIvNS7O
 e8UbpMLDzKJKBA8ntNwen1SMkrM6r1sJhT3wf8y/tYQJbrJ59G1l+cvF2lwJke6TxUZU
 07x1YR0KfzF0XIhpER+rIRsyfrs7prdi5WW4elgcTDwOfItseXhwxObKus0r/yCDsOW1
 0I5gieXSZQIkX0v4aWqfRZQGis2+kaGxXlYMfJAr7Ge3Eg1nfnOUHjG+ixzcurm1PNR/
 XHSRm2QL2KVhE48uCrcPh61RnP56FkogWRZtTqrdNMgjsupZM1bJ9DK2aSHCoY9tTlZp
 RZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776461465; x=1777066265;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xDWgMTmXxj6KuyK28j2WTWI6FHaIx7jDpf5Aowtvpqw=;
 b=fggPh6wukfD43GQiFOzprhaI+sfhLDFEUq9hyI958B/xyyOeiOImrpmP7y1xFB0m5i
 gegIXnd+XaQelv+VTnbb/tpPVk6cc5XxuqoCMt032H7aUFCK7aWVGBpV37Bar+0GyTxE
 n6kyHFqo458GvLtqFIrGjHT+KcxxLEJTwfI04caeOKWiShVttleGaoo+0ISQlzEnr+cu
 Li86qrggIuG1oQGHrZsFJX0JrSTOne0JJ+TyGMNi/z6aqLTRn+AZWt4nUUuDZlJ18CTW
 tE4jhIShqCx6ldNWn06N7eOATC/k5b6AeYqdOXxi5VTT8c4ivG0ulVl46W2tGYcI0p9K
 6y1Q==
X-Gm-Message-State: AOJu0YweCQ4YqdwC/x/A4GuuwGwkijJvsuRra60K5gLVUsa4gQY3k0r4
 TXQoUHVCreOQc+gCa2f9gjz4VNxwibpyP/bVlAqwcqZ1bzJ3yfebJllteixTcfeNDBc=
X-Gm-Gg: AeBDiessa/RhsO6qon+gJjupUGQ44BR2ueocGS7dM++gd/mRj8irf/6hfsiqVwhTDBA
 Wu99Rxz4fSXhrHyRyJVd3sMgOpRGnZqSBFJ6TXsbhgZ0EZU/JRKf6Tmj0Tp+Dr26KxmdgAvXWhc
 a8xuI05UPAtnRzTx3BpYQzzO55Ehft/7vAIGIJUUlC7985yGUtdL+ZVgxvGTr6S9NFpAxcXo1lP
 IKZxvmLXX4b7XTpFdIwU45D2YfiDAwD3dMJLA56LHtYIqFZge8+U3sW4BJ2KpzRcpoUL4HtA5+V
 01u2raJ33M2gQL7ViYAdqlLmiEPl7rZsG1LGPcl/TR3oSVSNr6b5w04dSo+YeHSnYtZg1jWxCRT
 bEbJsCEKXVQX0i+J6twUvUqhxmw+sBS8tj9i0+c3Dk27Cwwdcnc6m5o5bVAFmxnPIojqeLTEC5E
 CuA7xO5OA/6ufcUFnx8VuQFRwwQBlh5yNZNaUaDg==
X-Received: by 2002:a05:6820:1caa:b0:689:92e5:f314 with SMTP id
 006d021491bc7-69462eb9a93mr2357949eaf.35.1776461465496; 
 Fri, 17 Apr 2026 14:31:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef27:3314:b886:cd3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69464e5e752sm1668691eaf.2.2026.04.17.14.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 14:31:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
Subject: Re: [PATCH v2 0/9] MT8195: add ufs support
Message-Id: <177646138790.59267.5816858010618113967.b4-ty@b4>
Date: Fri, 17 Apr 2026 16:29:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NmhvWpT1RQNrWUhoj+Em22R/iUzjqlmZqngKJZereb4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp4qaRe3qIdCPvznXnTXL/4ai3X/9PMJTxphKq/
 90eFmF74LSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeKmkRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjRkH/jW3MLEyOoc/HYm3DKEc/nkrkU3NrOMR/OdR2SU
 nxDvh1NO5BNFgiTpgvBqlpyiO9FlwtWHSfeDApG5W1ZGVfop5RFpQfO/jrqH8DdQdK2lD+p/k6T
 zhrfKPkzQTOLJ7ilnPCvtqj8t6ws72NQ7T7zITiyqAneTPXGw+wgXd0vL9U6kPNLtAwCgcBmzUv
 XWu/1+CX5v6RD0LLoUlrYz7QsIn7WwCjmZbu3TjvC/sIwzHpPG6GWstJeBfFF4apK/iFbqzyZSl
 pnpyDa7Pc00ZOTT/sIoBQXVP87PNOnQmsOiMrIS6/FM0FX7D9/kKuNnys5CnXfk9T0CGlePlLWu
 ZZEM=
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

On Wed, 18 Mar 2026 17:50:52 +0100, Julien Stephan wrote:
> MT8195: add ufs support
> 
> This series adds ufs support MT8195.
> I also include in this series some cleanup on phy-mtk-ufs.c phy driver
> and ufs-mediatek.c mediatek ufs driver, and pmic support for MT8195.
> 
> UFS boot has been tested on a MT8395_EVK board.
> To enable ufs boot, we first need to erase mmc partitions.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/9] drivers: phy: phy-mtk-ufs: cleanup headers
      commit: 526bbc51267b7a73b2f9fd7bc1d0806e71be2517
[2/9] drivers: phy: phy-mtk-ufs: use tab to indent defines
      commit: 193594df1e40d3bc590305821e20f82a247e94e4
[3/9] drivers: phy: phy-mtk-ufs: use clk_bulk functions
      commit: 026335405a066b50d5796569d6e3ad3b01e10582
[4/9] drivers: phy: phy-mtk-ufs: disable clk in power_off
      commit: fa10626aeeca843901a9153fbd6e0fb8bfd3af1a
[5/9] drivers: phy: phy-mtk-ufs: do not alloc priv with priv_auto
      commit: 823ea160d4b5b931ff015545412c5ba7d1335307
[6/9] drivers: ufs: ufs-mediatek: fix phy handling
      commit: 3fef4f9d70292fac4528fc6bea1d35b63ce995c6
[7/9] drivers: ufs: ufs-mediatek: implement clocking
      commit: 276182d33b0aaa3fb808534d6b70577f2e52c916
[8/9] drivers: ufs: ufs-mediatek: add MT8195 compatible
      commit: f97ba4f64b750feeaf2b523a9adfbc45f5b4d0ed
[9/9] configs: add new defconfig for mt8395_genio_1200_evk_ufs
      commit: 449aa22d8aa31b60224e6ef0951b2b24c54ace2b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

