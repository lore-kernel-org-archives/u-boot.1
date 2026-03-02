Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66316EA4E07
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A0C83F56;
	Mon,  2 Mar 2026 15:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VLbDAm9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A6B83F0A; Mon,  2 Mar 2026 15:20:42 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFE983F30
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4837584120eso32503335e9.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 06:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772461239; x=1773066039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjK76yXrSwuTJFCVzYIjRyuBhP0HW52WVjSPKtyvaCk=;
 b=VLbDAm9TUXBlj5opGI/guBVKYWyvgExG3Pe/uClVmnB1074NRt/TH1Gm/RLpxSTt9k
 I/L9/CBvmFkoDFWl2uLE+2EnY7I5asUsFJrVj9RskNe+9cxGq++hhccxmiA5L8JGSaSE
 1ikRf6Ezqb9TeHHgPkXPXfJb8gCaE2lktnmyoM7eUkMlodA26ys6BbKr/zsabhf/p2h6
 DV3FvUmDXqBlCWv3HLK28zKh4nTuOm/qeQrIWO2aHRkma5ap/85CCT16Bt3zMaU5ZoaM
 ImYEwFx0louwnB8rblAjcYJeuQESjVXX8DeF3tJ8F60Lp+Ke7ZgtW2UzblduSzvlb1J6
 W/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772461239; x=1773066039;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rjK76yXrSwuTJFCVzYIjRyuBhP0HW52WVjSPKtyvaCk=;
 b=tuIxIwLMPvMu83i4DsArRWrj4fH9pAY5BoAR2Jtfh0RE4pmW5PTjKyw8eshxnbwxTW
 1vUx9dUc1WVK9W0n1VhMMnWunAx/4A3LG+qP7YADqkJ1qBnv3EaNP5XeQFL2b3kdYz6n
 lMzh5pXe+pTYyisE8m5I7i/tAe/w+m6wZwdOKFj41YmEELG4UfqL5yWYlQNx5XPQ44E7
 t38PQQ+/K0f876l7TqFI2VNThwPRllFeHw+F2497Yg3tcv5XhvP6JYSITVcFu/dJoL7e
 MxOsLQsurTeX1numQxuyjo20fNvY74n9Zcx26Mkj+ckzhJ49SrKIbpPCEtRlHnUybkyC
 CQkQ==
X-Gm-Message-State: AOJu0YzVQBdx//hNNpbwDcYEQSLFTFSuVRHYCc/EKtLFRfG4O67zum0B
 LviuFKl/2kdNq4FFLeA9b/p077bxssfuSOQWdB56znYMa++cb8OSXC1pd2uveF7jtBQ=
X-Gm-Gg: ATEYQzw755SJP7BrzykaFvK7zzmI95ciky+1vywrpQX5q8UeoM5WJPKtS6+psXKfqOo
 O9wTHj7ZCAstMk7KohvAceyQeZntzW/RLgD/lhVEugNMPZcN/rHYGcAJrGc+OcZUmnP8gADW62L
 JfkwTc73LuOr5Btxugdhe8F/ctuUv4NMTrdBYWXHF24fPfuBZvn+PYTUMhvvltEz+FD5l6bB1vo
 YP+yIOOV1Bp+Rl7Y/81rh0HW5d0/J6qivPOSmzG6HqIAcvyJxNykRqB34OFl1atqPjpbuzAm8eg
 N448Afsvq/wmIU/WYZJywFPfIrIgI0iEUQhnvbdpiDG2T+qdOYgArXeLaFRKvQlKqhZXxIyIts5
 tFd1RioFc/Ho+Ac6wGo2fqoL35jOlVtVXmR4YTUPIYGbc9G2lHVVH/+jWNTy0Eguxdo40d7IDTA
 HxGRyw3M/Rb2L6hz4FkOEpqHtqcLqRFiArCSJeZmU33ANS
X-Received: by 2002:a05:600c:5308:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-483c9bde0f0mr218990265e9.35.1772461238968; 
 Mon, 02 Mar 2026 06:20:38 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b6d540b2sm8214202f8f.36.2026.03.02.06.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 06:20:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
Subject: Re: [PATCH v2 0/3] drivers: ufs: ufs_hba_ops callbacks cleanup
Message-Id: <177246123803.1351530.17937032404051099523.b4-ty@linaro.org>
Date: Mon, 02 Mar 2026 15:20:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Tue, 10 Feb 2026 17:22:42 +0100, Julien Stephan wrote:
> I am currently writing a ufs driver for MT8195 and I noticed that return
> values on ufs_hba_ops callbacks are ignored. Fix this.
> 
> While at it, I also removed a useless wrapper around
> ufshcd_device_reset(), added a wrapper around
> ufshcd_ops_phy_initialization and fixed a typo.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-ufs-next)

[1/3] drivers: ufs: handle return values of ufs_hba_ops callbacks
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/1bc12d3bdfc5c8acd4c26ef549b46c869c535051
[2/3] drivers: ufs: add helper for phy_initialization callback
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/43c7eb95c47854c891feea48969bb7f55038005e
[3/3] drivers: ufs: fix typo in struct ufs_dev_cmd kernel-doc
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/6fcf667c12bb649b4123e64f6c97c9e58cd48ff1

-- 
Neil

