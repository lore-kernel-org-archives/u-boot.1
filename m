Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64615C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04400807D6;
	Mon, 10 Feb 2025 17:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dw0Ey4iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1023E80BAE; Mon, 10 Feb 2025 17:27:35 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8823F80AE5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso1957369f8f.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204852; x=1739809652; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oz+85OP9doZVJ9G2yRvT7+t65pSdghXkurJcMytopdI=;
 b=Dw0Ey4iTq/7Bs+GePbhJwnFvSDapYm1aysVS3Z28shrtTCnP0snRjHkIfJFNE2lSso
 FoKO5XzDMfQj0OXV6kj5Y8sSHD6jp/AZEtbgxnp6Fekrfi+jRbvl2HNnY+mR9ww8N34l
 5I5OAEywoRVBmURa/zrxUjiRnDMuWGBurKk1hC+bhwQ6smA6oePBFhULkMjVUW4bVqF3
 t8vJV9t3mTC5f2p4ZfhGCYoLq/vaEMKZ6tZfe9ro5hXbFEbVFHCPsxLzQXEy3BwyGniG
 u3mEHchmHLgNUyT5lkO3uVfILR19F2Qfvpx9AM+5+D5E9/mNN0FzXA/a2cn6JSxAAUQe
 4Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204852; x=1739809652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oz+85OP9doZVJ9G2yRvT7+t65pSdghXkurJcMytopdI=;
 b=koAJ0DxazRkq4lPVk/wnPqu0dDo9Pphkt9qPKtcHmgfAdjw8c/RFhs+BuLM0n4OfVS
 MIR5rgF+3wn2psSoB6uaVtllLHYdUIT1ZtJeIdSpsX/IleeX5s+XxnPwR8zHyuB4rIdx
 aT+ecKxYtZhjWpH8a9dJGCyYrKIsSo6ri+RSnDMk2f0E4VLnUfTerAPrIpoPnpUZSnU9
 hL7ZYvtpk/x7585s578EcL4qjyMjnxrC32vuAifDOnJx90lQu804zzoEtN/YlQz9ktl7
 Sn44/0UVnflu08CjAeFceJMy+IIl9XKd0lpml/cgSrQNGnPX9SA912WvBb+Kjpe/hPru
 E+VQ==
X-Gm-Message-State: AOJu0YyXyAcXpAWTiCozpvJo5RZZI7V9WuH17b4dqwoVxEjoJgB0z7p0
 W3ThskWPuF8ru0a+pU9tznHq8snfRmp+p1kKNhxWWPdCl3EqmxSYGA25DD2e+l8=
X-Gm-Gg: ASbGncsrQHyMf8j1LHd0GYrGEOIP5bBH1AU0BNHizenwu70Yzkd043VJKb30uRGox/l
 okonrZC56jFGtkXoh6YgE3u4SJ47ercGOBS8NrezRTx+xJsedUvCQt8b2s5EEj2upbht1VHEVvh
 ytkRdyfHBUNZffduAgPz9qsf0gz8v+IxfxquPVPdEdgwekKfMzxmM24/VS6A2dMHVJA+dzH23Bx
 qkDmQQdzYyPcbK519RIlaYdB1ImQd4A5N92hQIIiBSlPnFm9kd1vO+h7jR7h1ijpr6ckxDBcQCd
 o7zP0Exo45xYRuD8N4H8FCv1x0JV8Ds=
X-Google-Smtp-Source: AGHT+IEziE0STf/luQ1G+Uzr48LKw2tCBMwRMRWpv9FUGl8TrnSxx3YKGJT+YifhXG3o2OEnkRSIfg==
X-Received: by 2002:a5d:68ce:0:b0:38d:c88e:d57b with SMTP id
 ffacd0b85a97d-38dc88ed864mr9008352f8f.26.1739204852022; 
 Mon, 10 Feb 2025 08:27:32 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd6080926sm6648295f8f.83.2025.02.10.08.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:27:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 10 Feb 2025 16:27:26 +0000
Subject: [PATCH v4 2/3] qcom_defconfig: enable stub clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-b4-clk-stub-v4-2-f1e7d845f57e@linaro.org>
References: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
In-Reply-To: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=988x0yGrHEqroB9Tvv/9YXcLTTclE0J9JkZeKFs1iVY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvRVGh/qE/ccF4ytarW/9tOsoj41vsDVVewxa764S/N+5
 36Z9xc7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwER6uRgZek7JZM48mbZ+qpZr
 0aOTLvUls3cy7ppUz5OqK5NZX3comZFh2lMvb5cky7ffgvzs0v717HsTuvGcJe/czC/1rTVNAso
 /AA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Enable the stub clock driver for rpmcc

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e4abfdf16bb50503953b79fcaec1263c6b74f41f..9f5518a9fe935d289b44909c6f2e9c401847bea5 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -57,8 +57,9 @@ CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
 CONFIG_CLK_QCOM_SC7280=y
 CONFIG_CLK_QCOM_X1E80100=y
+CONFIG_CLK_STUB=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_SCSI=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_MSM_GPIO=y

-- 
2.48.1

