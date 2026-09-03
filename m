Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDEDC624DE
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 357CC60816;
	Thu,  3 Sep 2026 22:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CtDLMbl1qygY; Thu,  3 Sep 2026 22:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7C06B60B4F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473594;
	b=WVU33fvba1abCdNGtVRwpLkHfoTbDiat7LfzqaKzYTyARzXwpt/PGwvq6TvECO+aVjxe
	 PjiWrIwewdc9nhpExSJao6FrEi+D43HwP3yd7+8ySLSYrAfcGgqwgN1x2M9bqpQBsKEJW
	 WbHLQQvbc9IXl+CIEsPpNL9TKSdc7FUYA2V4hxHq1y2vA8nQ3+qIOF5psxVYPlH7ddGqS
	 4gyIHtqQw3udxqZVSpdLpBvQqVGW9E60o06dhKX+u4IhxiJcCSjg0JNDdrtILoZG6m+CT
	 s4zhoxsFlPghB/FPhWkm7774b3r64ZLPGYVkcwZFYlS3rcwycJGHa5pkhrHHXZkfIjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YDX1in3nNa9a9RgoZpha8UzgJm9Ng7C+R/Ry/mTILzI=;
	b=Znm2P/ZBr3xZwbdWGWfBk79AWdwVs/0MYt3T0bgwwrqn/zGYN4Pfm9tbC8vGq/xARW8T
	 WrKFxZMF14G1VcHwgrsaBErxJgmVgzw6tWnaDyt2ymuF5BxueiVBU0JFHq3T1zo7gXBaM
	 9blnrwSenyZ0XDDsk5wCUV+KS3iP/xlGCyEAx/jyJVTkpMDHNerREkGrqRA3C0MGKlVhz
	 SZ+DbKUlm+dEbnGo/QFS+YNUX2fvXeCVAV9YG0dJT2bZ0yhr7pu6mhonndyqv364woWuN
	 Erxpk3+nUplgwGTL3M595j2ZLTf9lxQJlkDLCi/IyLic66KDQlW/cB2/ZcdsBEPZhig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="RZ9xfM/M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473594;
	bh=YDX1in3nNa9a9RgoZpha8UzgJm9Ng7C+R/Ry/mTILzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fXGp9ZjtjENKqlUTCNSjNP0yLdzlKJljYMzP28LT+wNeGftis92kh0P0wwqbutdH7
	 PQ63lwtPTaVZJl/i4FbBCfNrq1aojNI1Cs8krBfV3Zn/ATG+S6uuARGoWkI6wnhNE7
	 e/EN3oaU9T/jSRlvInnH4g6r1GJICGTx/dKvKVWfYoBwfXdUTSuElWNYaWQpL4AzJk
	 fhQnT5MebxE3PaQYxVLSTxE5cg6B7NgbfyThu3mzCGdXhJrLuAOXnyz0pFg4uu+sAE
	 NxAuUmRlr1H9B70lQUhTMddbD6tKNPndujw2/VsBapChmKdSqWmYEXv9HhBf69SD8h
	 G731jcKmXCmMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C06B60B4F;
	Thu,  3 Sep 2026 22:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A5CE118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BAA060B4B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3wFwcuHvzRWW for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0B90D6070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471464;
 b=qLk3a8zQEnJB6MnahYsX9pEGtx3bCTKxRjtW+HlGnIX3mKLYPQN+b2f8sK395DosHzRf
 ahtlTE0CSW2U1lMoK9bzGtm/jIjtpbi0Z0xvZLP0RxuzS1Zs90wyMQDlAFLwxMtrQTRi+
 //QtnB8iGeXnRPws/WcC14WC9d4LrKoN/vCVK+WpxgyUaP8tklBR0dSALkrecy9NLH6T7
 tNwWdr8Y+OvXFYvlWGNoGrVvCJKUCrXbjS3DNxa+8NnkPl4ZnnIgErktKJzP2XnJhCp6x
 mkYAiFsdrOjjvrISu328tLIBc0tJTrFENrKrc9cegJZ3vygugJ8KyRs5JmOlkMLGQsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471464;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=YDX1in3nNa9a9RgoZpha8UzgJm9Ng7C+R/Ry/mTILzI=;
 b=nXJwbWKDeinzluB+IGhNjMnKbHZoovuOsHJHpjnrgmhtFFzr0oi+gMRLKCm+biaG9R6j
 msNBLfS8dCPRi7xQ2UNk5BX8asCz/xKTxE2cVSpJ6VCWwpbgCIctg/4PZ9R0XvZk/1WqU
 rZrZ+G26Ly4aAMFHM8YqVs5eI/OfjCtCEqVXbE70VvL4wSyG6JWSGTpFHUY/PAZp996ab
 85NMxpLX/PmzWCneX7gL9JAYR63e2XbkgAfoiwyKhIf8U1mLJf37o+tL8QBT2mCOXryfF
 mcW4p6aM/7Krb7X98At8y1BZcv/cdJNiw5uT3B7MXTUPWrl9fGEPS2vC7t3lLidyj/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="RZ9xfM/M"; 
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RZ9xfM/M
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B90D6070F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:43 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-46adfc81112so161544fac.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471463; x=1789076263;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YDX1in3nNa9a9RgoZpha8UzgJm9Ng7C+R/Ry/mTILzI=;
 b=RZ9xfM/MVWv8YhlOtntZk2WqSDwr5RU25K+ROQWH2ke2AXtz71m2O5/ZOsf7+l/yPS
 Rg0Zp/xwsNfokjh682nefk8k+tmeLBGytwJZQ+JInXK35rpBtfYOXd9MoBa8G/SCIJjB
 Folgpm3fZREGnPQWFdNUsc4NzzfP6zBwe1BYCq31D4vWI4k4m6/K/ZIDJIO81U2O3B21
 DwodRg9+ISAUWIVjCRxn/kxAMcT4y6tLKDxllBI5KeqgRCbc28tSLN/zrdiSw5hz7kZ+
 KYe3WeQ7lR9NMhBC65Z6PU0bXAuhaSPa9L5zhZ5xXKwxdiaFwxD1gkAv6dxb1TArL9Al
 pxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471463; x=1789076263;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YDX1in3nNa9a9RgoZpha8UzgJm9Ng7C+R/Ry/mTILzI=;
 b=WxT7QZNIxxeBJg4rm10ZhaBJPpNv6jYjvc8tjAiswOut4wMSUyONTFYbfXW5L785hZ
 M43cfB2/As+C+iNh0wpjMUs7oeNtfufcHFsMkLyEGK2KcWAjtlksXkv0T8CN+QP6MvbT
 9vexi+9QL2HIZRDLUE9gxoZEvs5xem/cxqTjPgIvVHaVWNGOT+zTzJknbmIqkiT4BuJv
 xNpXv8v/sXWWzPSdv352MX8QKg1Rsyui6v6Et5CZQENu3Oi4o4adWyQEe1WfEQI67SUS
 DNDb/1XYcH6Hj6RkUgtpIyF4MeBX4lBYCb/JiiqzIFo9ym9POWAcYLT3GycZamKZfdML
 GF3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4OVuJ9dRxVJOLREYST481K9PTnMw277Fy1qeNSeUyNA4yR5fK5gXtCA6lPzborDZM+CzLWdE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmgqp8vkq1Fj7+FTfES8IZnz3fpMoAScyBvQL4juwKM+1Ph2gI
 r1A3EuNSxt7PS9ScUc/JvVqW/vcMReGVJ0YSUnxCEoWdCmHwx5cTk5bc0EgVvCXupWc=
X-Gm-Gg: AYBFou3aPUBDxFa/y7aLnq0wi9Pddr9ZWAwqoWxq7E+ZE/2De5tnUdvqonaN0F1t3Vl
 qtcsXakOdmHWtvry927/43z9oDMUS0djeIuqBEolc8tZ+3DYS2LhWyuyw1dydScJ9ty93gMscGf
 VpPSC9pbM9X79pZIoDGPRCsp+tod8ts53n3dxU5EYjnmkCIr/sedO+E7k3SBuXsxDCW7Z6wFhBv
 JUYBuVUH/HwWCOlpVsVkUKjvWxUrd2ne5w9n169yST3skXljrifM6rlaDCAW/PutwKT+/Jsn4nA
 2Nz5jZA/bSdemSopUSuWSkiAJxrYfOtgqFn3Jz+e4NSONZZn0blfUweq9vb9VF0R+Zu2ttc7YWq
 iuY6m/VkmXNhzt1wzPTA7FTyTIpOLhmDvjdDVOKcm2+mS0Yek3NXnYUc1mjxxGx2iDalWzsu5/G
 hudKHSkRptPHhLPIipAaQAPCvW3dIWNxwgsREw/H9skeQHe/GHe68+L++Vt/1W0FD6WA==
X-Received: by 2002:a05:6820:1ca9:b0:6ae:84e6:2de0 with SMTP id
 006d021491bc7-6b6fd8cda83mr1470581eaf.26.1788471462897; 
 Thu, 03 Sep 2026 14:37:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:45 -0500
Subject: [PATCH 01/14] power: pmic: mtk-pwrap: check dev_remap_addr() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-1-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=s8J7+oYVrhS6XoEVaMDICMcdQAOBwUJJGglNk+nfoSA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmeg8j9qIlXuhEDgRgKZgNJVQVKQ/nwWlYxeaf
 nbW855n0oiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoPBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A6sYH/133X6sP6t/4WvrBEV1KAh0CYA/s3RvwcHDTypf
 r8OsFKzwrP1MDZMYdzmMCLTTO2/3zAIY8O598kiJMUsXMHo8vpeRJiEz0nVgcbLE/MEDDNoZGQU
 8ZIHI/2UgS/biH+WQBcaLngbZP6276ll+PIBmzIEV73HTP6xrc/TDUjFXWGFFOu1SAhr2K9o33z
 wSvmmKAKxenvzaePflDW5UaXwuKAHHRwFgIiDch361JrL3HngHg1nhKhA0eRM8T4UJzxZ/DXgwm
 5rOmklP1/n30hCnSXe2MevJR5+Vjtn4W2TxiGeEPobAzVF6j64mAvWR91d4KOyZG6QX2Lhj/Btk
 8ql8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_remap_addr() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Fixes: 219c05f3f68e ("power: pmic: mtk-pwrap: add MediaTek PMIC Wrapper driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 21cf4ed6a8f..f23061de386 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -712,8 +712,8 @@ static int mtk_pwrap_probe(struct udevice *dev)
 	wrp->dev = dev;
 
 	wrp->base = dev_remap_addr(dev);
-	if (IS_ERR(wrp->base))
-		return PTR_ERR(wrp->base);
+	if (!wrp->base)
+		return -EINVAL;
 
 	wrp->master = (void *)dev_get_driver_data(dev);
 

-- 
2.43.0

