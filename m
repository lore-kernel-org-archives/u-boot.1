Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2071AD61011
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 13:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138AA83FAF;
	Thu, 29 Jan 2026 14:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DuDkwBF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CE383F26; Thu, 29 Jan 2026 13:34:04 +0100 (CET)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDEB83D9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2b72e49776eso1741539eec.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 04:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769690039; x=1770294839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXNTHfrjTycvynaWd+ksTJAf5CR6zW9CW0Qc+4uY2ds=;
 b=DuDkwBF9cwE2WrThXwONLJ2uUrPa9vOvyx1aTrVQ2mt1iEqzCsH+7t1pN6nH3sc+dI
 LJLpaReoJM2Nneq0QGHIPLvzqvDQqvTV2hy+VgnH++/gT5eiycIjADwXmPjTyBlJRi4P
 3yW22PR4GpKl/wi7KmV/vs7/xobPAUK00lBODy+EqMZXyQHRFZdv7+eSbDm55BLfG6ao
 ESue4wNFXTSgXUGTsrVK0wq0e2wV0tHUiP4XMFK1OyP1Kwmg3sNTz7iNyRrqHhA43Ue2
 75Os7hSk2U7HSUSU8Kt7ZPPbsZEHv/Cr36tzTM/q4KMxX/Mq6B9n2Z3o5iQKSyTWwztG
 yTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769690039; x=1770294839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TXNTHfrjTycvynaWd+ksTJAf5CR6zW9CW0Qc+4uY2ds=;
 b=i27Toh3+vAEhCWe/7QChgrEySaAeCiTx0U3/q/OHUKmklK8eODFl0Hgzr88Mi2gsWi
 gbANtxJRPC8Pz6TTswYT9p9oFEFdQxdsqj9mrJsQYC8gXRgikhyu+54OQ0/YcZTAOfd5
 dlO3PdSJsq72GClG/wfkQ9vh2mK5dZY/MchFhxTlpdkYjlHv1QfetasmFbUiKcRo8U5d
 B8Aq6nyqhPNikvVysON8mFVHQih6X6zt7Viuh/Laamj/OMtXLxeXJzulx9HAt84N8mhM
 bLmVgBhgxokTpXfOXz7+r+4YAJxsGs+2y9pv1gWoSrFEgECa68+6ETs3MAq7nf13P3+6
 ZoOQ==
X-Gm-Message-State: AOJu0YwT86SEKYnLyXlmH4EouZB4HBT9XPCX6BfqC0GbTT2eyA4Bxn/3
 /juXYwFmwSiBjZ+L4VguumvLax8kgu5R8ZQTq1m1HxX6pnRfOVCEO/HifENrOM3Q
X-Gm-Gg: AZuq6aJLxvLgTQzkvBb9ZTzCmOsjbUzeuAhCt4P0aAN57k7obU2xme+dWHuXn4Dvggt
 bbc+h+2w+kgQTvET5FPkfXP8GuGxyPBoV/ixkbxCm3knrAUJknq9DE6Rw91M0IDCwvrl3F6Mz2J
 kPml/3JqT+ZafUxSs4qhJS/6IAtFWRQ/V46o14U/uGGIquRcOMBq2iOTd1Tai4oLb8ThkPdWpJa
 W+MOjkfcjJY5GRvNj7rPIK0O2wfPkbFB7aZwgI4xAltI2PLG8hzcw5HQbd5eGquOkUefBdB6thh
 0tkuAdORXxmHBN0LbDdE6Z86JjbPT+qCVzjXXSHzfki6csi3rTuTEEDMFFouhgjeD5eOP8TsrIo
 2THGHNp1tda4fHisrrvVF1fvWn1SoBamf2h+76fwF29M8/ZSMtmLr+Fnkf3EY6m7uTAcbZDJziN
 G1b/7FGap7P5LSkG8jxcTMWps0DQ73JqsD7w==
X-Received: by 2002:a05:7300:72c5:b0:2ae:55ac:3ff6 with SMTP id
 5a478bee46e88-2b78d8c22e6mr5203172eec.1.1769690038693; 
 Thu, 29 Jan 2026 04:33:58 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a16ec51csm6686619eec.10.2026.01.29.04.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:33:58 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 trini@konsulko.com, Takahiro.Kuwano@infineon.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Add support for Dosilicon DS25Q4CB/DS25Q4DN
Date: Thu, 29 Jan 2026 20:33:40 +0800
Message-Id: <20260129123340.4372-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827122403.20159-1-ssunkkan@gmail.com>
References: <20250827122403.20159-1-ssunkkan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Jan 2026 14:29:46 +0100
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

Hi all,

Gentle ping on this patch.
Please let me know if there are any comments or changes needed.

Thanks,
Ssunk

