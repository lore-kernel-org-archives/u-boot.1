Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391EDC77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D2882D60;
	Tue, 24 Jun 2025 01:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zeqspoSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131AB82E20; Tue, 24 Jun 2025 01:49:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 039E482E52
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45365b1a897so24211605e9.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722580; x=1751327380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skkR3KYf0Mn1boap+WVEXnVAPREYAb9bDkhjy9EPaGc=;
 b=zeqspoSq3KaweoXSAuG0eyZapvTqQ5QpfVh9AxqPEUiedMjZEhHgiWJCw3ZmdCacJP
 q+zUpdIAP5Y54cVuBajK3Aunq+o0aXiM9Bw1e3tYSNExYWNTvcy4xRBPiP028rQNLvHU
 IVoH0RVlXQBTSHNsyVMqrG3sFW2qs+L7evXbD7dWdkmq+IwCAmX9kV6gytahJUOdqscN
 NeB0oLq0D3yRxIYDSb/SbC9vkS36v1+hevaxe9pX64Om0bzQzCzILmBvFRRvfH7yfVDA
 ubJVnFPsloEKNiFvFkZiUiRD5LtrHNXEwRcRnL/DQafWlIS2PNw89M5XtCWTTymvjRJr
 mSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722580; x=1751327380;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skkR3KYf0Mn1boap+WVEXnVAPREYAb9bDkhjy9EPaGc=;
 b=b0IIRPPBxE7SotwmjZY8aUVn62sQJKsCMyemWHMDiypLoEdHnU1P+F+nzIAaasj/yb
 OTyldjMtCEamA+JRiR31TalfCRsPoJqQS3ZxVlMOJQt50voeu+KNt6tk9YH3CECIAxHe
 rTF5CCVV/+io1OcGSJccWZOmEP2K+KD8a2VPDQc2Wtd8Bk374bdggqgWBKRKM900RBHt
 ov3r/yQogMAPvMztneugvitXUt81mmNxZAqV1j/zTQuvMKSBrkmKjz15THPADfoJtVc8
 HrcuL4R6lRB3UTG3yr6nRJgrOEGxHfrwgcpkmW6rw44MmSzuphJcYsv/ngZtjmLoggTt
 BHIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJhW7TVDP+YZ4G2eYljm1atZuggZjzvyqh/boOAj1L5yU3YdaRJCcxh/DlswbS8cA72teP2sI=@lists.denx.de
X-Gm-Message-State: AOJu0YznOaZU9MmipwGnDRpbQGfL01SVgfttEiusTTnDiDZ9lfAvsRvz
 TIApQHHghYyC4cGQWX8000b4z1MNBzahWHvT3oSG1AclrVKu8RnMfEcyON5CVYHyOmM=
X-Gm-Gg: ASbGnctGZ1DD8oco1+s2jZM9yAPXsx7Gzi9CfemlGqE7AJ9MuK3bgYq8KVEORkbTzoe
 CoXd0UxyCB5b8cqOgUPg6gxWZ85eOTsDbW+Fe+CsgcmXCytntBNH4KLbyAnFxyrVW3OW2miBbuB
 epTw5ar7smPzwqOAGYNhQ2oo5AYip+pBYEDQbNWMw47AqcXrReYg/YUNu8wA03fPiKTEQ0VlioU
 rCN7gS+T30PjT2PoZEyI1Auiv7pwEwmeVxZNOk8K0wZ7W4RBm/nwyq/GMESGdts5IQiZzzZ6n9Q
 6FT3jJ5FNz3fWIwUHS5WjnbJXEIy7ygzqk8w9Njo2CqDb2A7CnkamLQhpznhN7ZaOkrAQLqPzbz
 2sa0iCnGoHao=
X-Google-Smtp-Source: AGHT+IHYkcpkmJL/1s03RjRLTfXxNTrpECUZhJDK1QqD8cEK9nmEaGuvikPdkG91WT+jS3zo98p6BA==
X-Received: by 2002:a05:600c:1da0:b0:44a:775d:b5e8 with SMTP id
 5b1f17b1804b1-453653a2ee4mr137407685e9.1.1750722580426; 
 Mon, 23 Jun 2025 16:49:40 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:39 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250508103238.230608-1-sumit.garg@kernel.org>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
Message-Id: <175072257929.128390.12889749777051999311.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Thu, 08 May 2025 16:02:38 +0530, Sumit Garg wrote:
> When debug serial port isn't connected, it is at least reported on RB1
> that autoboot gets interrupted. It is probably due to random characters
> on the UART RX line when disconnected. Lets try to fix this inconsistent
> behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
> interrupted only when the <SPACE> key gets pressed.
> 
> Reviewed-by:
> 
> [...]

Applied, thanks!

[1/1] qcom_defconfig: Enable AUTOBOOT_KEYED support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/78f177fcc2ed

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

