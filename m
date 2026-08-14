Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9610C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D29D8124A;
	Fri, 14 Aug 2026 18:39:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0mPMGQS7dtS4; Fri, 14 Aug 2026 18:39:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52906811C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732754;
	bh=X19M3qrp+zqdnHU4Sh28Rf/TA9vxxruU8HVap6dlTQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+1lz5Wk9m8puAVcLoZGhHLVEuCpr3nW384uQAGwEjUmVegDm+OQuUtf1zELKExpw
	 vLobOfvqiaasbiVePlkjP34ZU6jPN3xnbZzyVUDtiuXCX45muRVFt2AM96f7NGPkq7
	 W215lHsfQX9SEcIkWXx/mOLQAinUn5Dfinvu1nUbD+vjgJnelS10HqpujRgQqLHg+A
	 ZY1aYa7SiOTh3ENSs7nhXaRkeDwG818WcbEZLJSFQCGhxQn3g042VKAgC+4zgAKQNN
	 UVpo4XGh4AbB+HWaRWSoyPN7lZC0TVtuH4lUZ+Oh3cOtYudyCK3yptkBpVcY0GA1Of
	 ZsbG0uKENCKhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52906811C6;
	Fri, 14 Aug 2026 18:39:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BF93194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C1D480835
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_DVqdUwlUZU for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 95A56807AA
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95A56807AA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=FPkTqcD4
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95A56807AA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:08 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-52d7a3defe8so8633771cf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732747; x=1787337547;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X19M3qrp+zqdnHU4Sh28Rf/TA9vxxruU8HVap6dlTQk=;
 b=FPkTqcD43O+MccHUM/9notw1BTlPtziFkJ29AU3S4xytWg5e7obZcoOMSHrMGSCZbw
 5pQmBOJ1gYQDiNDsQwmcRNmQZT9x6QUTrOx7IpmewC35NkeFOxGH+lDuByXTbuwnxpso
 oDWBwD1tDIjYMn7nfa9p8nRGBNMKz0lnYp3YoG9hXwrR1Gw18nm+/regWECpPXf/0SET
 mudRWol/BzzGFMkcaTXRMMXVMa0mBUTk+cA4eELxkYisZqfvWxHiG3Jqr3IYSYuKo3LM
 bCUg/bQAHq0yqFoxjeL5+FaOxvBSKRv6TDlEBnteawT0n8KU4+z/F8job/jZNrTXzT9O
 wbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732747; x=1787337547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X19M3qrp+zqdnHU4Sh28Rf/TA9vxxruU8HVap6dlTQk=;
 b=Rubj/uPfKaR0I20BgQljQyp3ZYidR40tFzKc13WtxVjcCwvqhqh/kZuGhKackGoXxC
 ksJvPquhXr8yBADHdqG3uJdCBM3j4+FemHcu5QLUWZmHXo4axirrbwNgqhqzAYDe1QiO
 Jc8/rGpEPXM9bA4oLePx2J0fj5ZgcqQwNZpnEpBeQ7CrOYF+QRZMEyXdOWGxCG3WSXkw
 oRMRD8zw+E+4QuvulMQLhX6ACYxCQRKFfSGzkv5cCWsMCk0GuyLw2Jeu5IRMMg4Fp6Ex
 PRk9DyOv2SK+vcNCYsgS+QGuN4UHEkUL0wku6/YmfUkt7seyS+f9IfE71nFzB1hhGLXJ
 /5xg==
X-Gm-Message-State: AOJu0YxpmELopjoCwKFf0sZlOh2rYJR/iWp9kVd/4yyJ2XDyhuj5fkOu
 eC5YkYttngT3R8dBT7p/uBKwGKnYYg4HHhaTIVfe6d0xpdyIG4i57La586OEWsKfJmPfboaUXJW
 5lWHN+dk=
X-Gm-Gg: AR+sD126BUSNYhwQp0HQigUHzsgIe65TkqFX4WfvJUU/eMkURZ0YKF0Fkj5QvsG3BqT
 tanCcdOkvR5I1YTE9ICHNZREZ0qr3l9NpWQ80r9DtNHo7osXdzN73hSIcw0Bbf1CX7d0GYtpiWs
 SavUMx7oj51T9fHoAbEKuYSmTKjy7R2UWyCLQ7HwcCvgdDL2pXFWblvzqItlpo3yURqdoEcxc3o
 X9x2SUup8XXWcMEVFI15QmmXJ293b3Bg4Ms8ByLQiSsflTAH33X9L14SaNkntsmZ7lqer2t6PZA
 T05aQg0NubLInz3xiYnSCUYepCcz4PoZxhiVZb0+OscEqrOdgM4/8PilgyfF9eqIrqSOE5REM8L
 bhHcVTJcabdabe8T/iXCuc8ygcBRrcc3v9gmaLjdYDMFXFqA8syyptDsdzk2Vn2zVp0OX/YiAMO
 kd2wvck62ohWbo7OUUsfJFEVBtHUQHbys63L9etCOFbAlTcUYiS0mj/doKVIQGTI4L37LNNb0JV
 rb/ULawo1uG2BYE+jDV2yaI5DDuPXQvmvI3SjMlPipNOb/semAad6iW
X-Received: by 2002:a05:622a:40f:b0:516:d812:c35e with SMTP id
 d75a77b69052e-52d855011efmr88863501cf.21.1786732747212; 
 Fri, 14 Aug 2026 11:39:07 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:06 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:38:58 -0400
Subject: [PATCH v2 6/8] ARM: dts: r9a06g032: add QSPI controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-6-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=1305;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=o+rXApW1nzJSV8Oz7hdq9+EvLps4eUxXUUtDwYZCQ9k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ6VAlAMFJM5qI1XEdNKl6C7H8d9eSvVnvQlw4LZ+7VtcMGL4FCF2xV+i39n/HCMP/V6f8bj7fL
 iqW5AYTm9ag0=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The RZ/N1 has a Quad-SPI controller based on Cadence IP core.

Take the devicetree for it from linux v7.1-rc2 commit
5be0b48a3b23 ("ARM: dts: renesas: r9a06g032: Describe the QSPI controller"

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- update to exactly match linux-7.1 commit 5be0b48a3b23
- this means qspi driver needs a new compatible string added
---
 arch/arm/dts/r9a06g032.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/r9a06g032.dtsi b/arch/arm/dts/r9a06g032.dtsi
index f4f760aff28..164d30c5388 100644
--- a/arch/arm/dts/r9a06g032.dtsi
+++ b/arch/arm/dts/r9a06g032.dtsi
@@ -66,6 +66,18 @@
 		#size-cells = <1>;
 		ranges;
 
+		qspi0: spi@40005000 {
+			compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi";
+			reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
+				 <&sysctrl R9A06G032_HCLK_QSPI0>;
+			clock-names = "ref", "ahb", "apb";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		rtc0: rtc@40006000 {
 			compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
 			reg = <0x40006000 0x1000>;

-- 
2.55.0

