Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFC5C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BF882991;
	Mon, 28 Apr 2025 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OBGnYhzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1143A80EFB; Mon, 28 Apr 2025 21:24:48 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D039080FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c33677183so55052095ad.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745868284; x=1746473084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7SxG6o68AcFiNYjjH0sbObrdENWHfjBEg0C66iZfMU=;
 b=OBGnYhzGmz4Ndf/2iOjZuevX1/hhiULnWmyiTxUQCYBdhCG6TpPjue5oLV8lPVy9Kg
 L9/owic2BaWOWJtW8FMO3r0/2tjgLjmU308R75uJI/l9LJjiRcCy7lYNMVeQG/anSh5R
 bCCo0VouYo9VEQWoVDezOLE1G2/IX0MGunWwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868284; x=1746473084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n7SxG6o68AcFiNYjjH0sbObrdENWHfjBEg0C66iZfMU=;
 b=oF20Frs5ZyH+IBiCVB2/bbrukcF2O1HTWI8ggiNsTqKpgxReLWeYVpLYR0FkzaUjVy
 nZXUskQLtqET0FQ5hbebySwOk/9wCtnPgWpXgvrpyEtU7lI9OBtjhxNUUaGMAcKPwhcP
 RaYkrK/l3XQVzkqwjptsr05E8T+DAknBqdyXxLnXcCQwWqlLUSa/obbn43tOkiKNI4tV
 0/JfDA7UQ0DFRbfhMssXEcwjijv8UUQxq2c+qT0OnvfdsP1HPjKuNgcSY3eDNjQtWCGD
 IuLQCYEDW7fBu1sP/RG8h0VK4iHrP6B6QvgFanBfqxzqkyJPrxSCQbyz73rF+QCBhu5e
 ko/Q==
X-Gm-Message-State: AOJu0Yw5EP7zohT+vwJcn9gOdzsUfDJe+Ni9FJgRpURHvLST98Wl0OB/
 qTuEKTyTakSbAYL2dO662D0dGI+aS+nYMjF38lXqc/w0LpMS+G0zqgkqMdEIFr40cWUzECBSKnU
 =
X-Gm-Gg: ASbGnctSGSj6waIoPPPfbtY9R+ePVb4VA0rOArL5jMt/z8TMHBZYKm/7V5gaK8qba/r
 z/iZWIi45JtFXQMNSdm0FhDzds6cz9UUnqBT1sjbxurNuozkHOU1qw5HX+IjuC5qh9YO9e3Li3c
 wmdHyvYZmdQAui6E83gp3Rm9yAALV8ywaV/B6c/R0UBQifCvmSXHA9RKi7ZYJDhU7lt98z82fXa
 4kMIRVv58vUHXy6LqxVGhANIL6Sh7ZOiFZUEn5zX0k+FrHWfau3E31I0MO84m03maRoha6+88IF
 +KJCcEIe22XSjoSGM66ZJKZmpcTY/OgiEzxaBA9jtJXMDJ2GBNJozO4M3MeXbDZEq33lW1Wxgzn
 Wew==
X-Google-Smtp-Source: AGHT+IH3nz+H0Ihu4r9uZ8O8U91X5Yf7py8zUGjusM165B4m4TAsx8kXmYBAIWEhSWMwHwCwnR6K2Q==
X-Received: by 2002:a17:902:f541:b0:223:fdac:2e4 with SMTP id
 d9443c01a7336-22dc69f5e37mr147931425ad.1.1745868284123; 
 Mon, 28 Apr 2025 12:24:44 -0700 (PDT)
Received: from localhost (199.24.125.34.bc.googleusercontent.com.
 [34.125.24.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db5104cd5sm87037295ad.199.2025.04.28.12.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:24:43 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v3 09/17] cmd/cbsysinfo: Skip the CMOS 'option_table' when not
 present
Date: Mon, 28 Apr 2025 12:24:16 -0700
Message-ID: <20250428192427.3877612-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250428192427.3877612-1-swboyd@chromium.org>
References: <20250428192427.3877612-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 21:26:55 +0200
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

