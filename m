Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D31BC021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91FCA80FC2;
	Thu, 20 Feb 2025 22:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ok2y6g6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B6F80EC0; Thu, 20 Feb 2025 21:59:14 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9917380F5C
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 21:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22100006bc8so25309275ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740085151; x=1740689951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7SxG6o68AcFiNYjjH0sbObrdENWHfjBEg0C66iZfMU=;
 b=Ok2y6g6org2YI2Xvet0Zka2Wtv/xKXhFrGx4n6hiLPj59mmmPaQSMuE3/og1O36+mc
 doOsnmosvcaiVkbt8pSd52NYyCwrlymvljN6anxePWvS+jHhMo5M4d0tmOMM4jtKYFZx
 SBzfZmlFnzWIVqj+fLEhdfWY5ZitNW6nm1Zgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085151; x=1740689951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7SxG6o68AcFiNYjjH0sbObrdENWHfjBEg0C66iZfMU=;
 b=Vi5NikQhWn+Yiv8BmDBn2U6YXLVnR/pHloo6XHrBoAFiKccTqGhQ6pnEAH8I0E6IpX
 bRLxrXpkqpkwN9j8+3+6+JKrWbrXmeqbiMcMsDSSG71FL+qWQovnQF84Eft+W1Z/en0f
 tUvucTcMweXb69Gji8Fo9Th2qXcbrDTLAr3Cei6uMrw8euzdjX9a6ImI7E3UdPI/mhfA
 012f5Mxu1P3JsYBv9yIERsO/5iAf41kgSxTPPcshKCrZM99XO2GzZPHimRwkZSg+jjsa
 e04S5UVUXW8c448/x7WCNcLRhSbMMGTh6PDPcWxZqAUgPpWG+Wg62jasGh+KhzLyt8VD
 3eCQ==
X-Gm-Message-State: AOJu0YygzI2OZ29tBLZajps3rBUSPWn+Ls0R+/otm4Z3KSG5h3xVhJ7p
 wHHkMyQylTlEvzJkgPQNcVxPYMz+R5V7HrTTxeLAZwfWkiopnREARp4zAETaSjSQ1ToeBxn3yZE
 =
X-Gm-Gg: ASbGncvQG/qElgNmO3DFWdtfjdzil1xL6Z4UDdFkKI8rPxWqsESTzbI2lt6UmwX/da1
 C4bYnv6BPXTVppLl+7sxhbnEnwB/xmH0kRPWWrAyuINLELwONn729KkdB9c9zHw85rvJouqIxQ/
 BOy9+UDkhd6PYiDeBInEoDyvsVyhmdaXTCiZOBGQZZPew3vdeX4lXfZb3z0kaOnromXKqlFeBtz
 x2chJcGib0qWfvNa/GM0JiJjN3xEQ0RpAWGn8TW8o0QKmj427nbticYAImoqidJAtsRzhTV0iKE
 hTWZpsRHqt+tM70bOvlge130EX9+R8DWuAMDrWyicZEbdtjaPMHBDGk=
X-Google-Smtp-Source: AGHT+IE6fHOKq+MxLTsupQpHjwqQSjAMbrfrHvW8ptS68gZqongXpSL3lPRJylj5LWi1V6jqN5zEOA==
X-Received: by 2002:a05:6a20:2444:b0:1ee:d06c:cddc with SMTP id
 adf61e73a8af0-1eef3da4cf2mr1143677637.30.1740085150866; 
 Thu, 20 Feb 2025 12:59:10 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-addac355db4sm8481328a12.49.2025.02.20.12.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 12:59:10 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH 06/12] cmd/cbsysinfo: Skip the CMOS 'option_table' if it isn't
 present
Date: Thu, 20 Feb 2025 12:58:48 -0800
Message-ID: <20250220205900.3127680-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220205900.3127680-1-swboyd@chromium.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

The CMOS 'option_table' isn't populated on ARM devices running coreboot.
Check to see if the pointer is NULL and bail out if it is.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/x86/cbsysinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/x86/cbsysinfo.c b/cmd/x86/cbsysinfo.c
index 3936d30da0e1..ed7b50f6d0fc 100644
--- a/cmd/x86/cbsysinfo.c
+++ b/cmd/x86/cbsysinfo.c
@@ -224,7 +224,7 @@ static void show_option_table(const struct cb_cmos_option_table *tab)
 	const void *ptr, *end;
 
 	print_ptr("option_table", tab);
-	if (!tab->size)
+	if (!tab || !tab->size)
 		return;
 
 	printf(" Bit  Len  Cfg  ID  Name\n");
-- 
Sent by a computer, using git, on the internet

