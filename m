Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A99D0D795
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5AD89335;
	Fri, 11 Oct 2024 16:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IuWgWcQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33208935A; Fri, 11 Oct 2024 16:38:32 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078D489348
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so19190295e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728657509; x=1729262309; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6qOfvTiOFso3G7c2hqztL44MqGmtGHntNZfQRLW/OAg=;
 b=IuWgWcQvLhgX4ug2ETb3Cdq0m4qBW6Fc/cDML7VjopRPDRHlR4mZnWDhkegp1CYRMk
 DIeH1CQG4ZhPClESASFJQ4sEHNASMXNUh9pIfC698E9Owb31jfGxyuV3uep/Z8LmFZK4
 Sv+fcIaUXYfPBzlZPsZau4U2iU1s/NPXnOQOVeSdHangco4f5lR9THNhWrGcCDmEWbUx
 ZsbSgFRW1F33JA5992oPKwKTU1cN2c+OlniAdbZSQ4Epu7J/tfmPa6te85raxR0OFEE4
 OnjZes5HTMnQou3RRs0T+i7qNUpwpkLGsvz/gFtGkq/YZJhAGdQoE2ndUZwvuiLfXntb
 flOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728657509; x=1729262309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qOfvTiOFso3G7c2hqztL44MqGmtGHntNZfQRLW/OAg=;
 b=uagud2qvCv1gUv2IPO+/vzovaCkU0kcFPvH8jnakz5pNdqc0xPLwG++bG3NoI3bKYQ
 YrkB5bx2NJ6dXJ4MSKktOeUyqKDIjoe1AImtCwLIlQPbe24HYva1ZdSv6q9h0oOJzxV+
 nLfn1u2dVSYPu5y9HfmQZ/Wz3Z8fMO7zgp4ibL7fLQUsMLR8GxHJuvhIS9iSzQJ72K7p
 t2o63ndWF2gatm2TPg99nv7wvexSxs86U2UHF8prCE3LWkgr/uTds+FMaIzLD1qCakbj
 wt+bwCU7o8uDC11l6NezrfWTTc7ZNPYve+0iL7MXkoD3PdH/Xu0JUqurDRE6ff6OLvDw
 7PHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPQlJO8HMYTbuDnbQVmX0LJMYck5doucbilxQMwHu1Pf/Gf2AxU8lDYDgnAXE+O+CSGlVQM90=@lists.denx.de
X-Gm-Message-State: AOJu0YxB46b0f97GjuK2vf1CnPzTxAXXG8lTRBdwCmRCDLDCIXvRsebE
 mRRetQOnCHosQS3FMIby40ljsa5geXRD56TvGDiQnyyVdRIZLEKNTPfU8TVUmgc=
X-Google-Smtp-Source: AGHT+IEjM7I2B+c9GtT77OeeKXNmsiQU1P3fbo7BSOSqszLqWNsBaSCjC4xKMEJvTpkykwGi5zzNgQ==
X-Received: by 2002:a05:600c:5024:b0:42c:bb41:a05a with SMTP id
 5b1f17b1804b1-4311df55e0fmr22461095e9.34.1728657509438; 
 Fri, 11 Oct 2024 07:38:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5188dsm75991815e9.24.2024.10.11.07.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:38:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 11 Oct 2024 16:38:25 +0200
Subject: [PATCH v4 2/3] usb: dwc3: fix dcache flush range calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-2-5f3498d8035b@linaro.org>
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WkL4d/oa8d34YakzfvLf/4CbUT+vDaGFbb8LMUkM3jI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnCThi0vfvCHEtS6Gjwjl8xdTIqFbvrejcM/MdhEED
 EWMjkQ6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwk4YgAKCRB33NvayMhJ0UcaD/
 9xoXjoqiL1MSRbexPpqp1EWMOQjIma1e20FtYPrhz5SjSbqreZASFd4euKGunE98+j6FEipIwcY6Na
 2X7K5EpsJkXK216i74PqJTcfGX9+7PgWBHkPEAx/kWdJRjbHOvupQqDrFpT9We1ODsXQ5dHLZzg0GM
 aqF7dQ0Zm21Oy06Yo3hRYZzvsWMcmXHXLHD3PFD8GJ6o4ihdDxgkjDhcfvFIlr9HgNgcnrPrvaw/Dv
 mnJXmjGbCwzXMEtE2ml30a7CTPUzkHa40a+OOCtt7Y7TuA1fSGc4AD5BWUI2lrK8zrTR9fp3BPpE+W
 xUNUkujWUTfav7w4w+u3KalVsReCp37l9zfW1J6ovvtlvowYGBXjZwNjBzVvsJmhijzxITkGAzfiZz
 qWApgqWLAhj54Xsv7yDMQi/uFf4k8NA/x3y2G04egHbpqY3QNc4Bdz6ysxXaD9OZyQgxTVLjt7fj0V
 jv7+WDjJs1PJDgouLZE8gLHs0HGCenI5XhSC/9Uene31VMsI1PE7hLTzR3qrBx4WOJnWoV5n2pjNg+
 EiVfv0OcPcvNfVELcECo4YtTK5CkrvmrR0SzFvXs2/2E6B0295cQrJJ7CknrN/ILn36MWXNTqa5KGs
 Vnt0R51xbqZMOHEY/e7dVVCDGItIusexMLyYP8TE7frTZKQGOMB4j4U4gOog==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The current flush operation will omit doing a flush/invalidate on
the first and last bytes if the base address and size are not aligned
with CACHELINE_SIZE.

This causes operation failures Qualcomm platforms.

Take in account the alignment and size of the buffer and also
flush the previous and last cacheline.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/io.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 04791d4c9be..0ede323671b 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 
 static inline void dwc3_flush_cache(uintptr_t addr, int length)
 {
-	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
 #endif /* __DRIVERS_USB_DWC3_IO_H */

-- 
2.34.1

