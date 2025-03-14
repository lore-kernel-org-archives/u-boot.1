Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACAC35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 15:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7904581E47;
	Fri, 14 Mar 2025 16:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vzcf6VAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F226181DE9; Fri, 14 Mar 2025 16:31:26 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0374881D52
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso1454075f8f.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741966284; x=1742571084; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VPUorqKfsLVRRT6LL5YY8NsN1BebLDOcS6il2uJCEXE=;
 b=vzcf6VARlDYeVdp71uzpx9nWQ2XGIC5dA2J0eeGdCg/R/P94404XnCZ8zp/rNMXsf2
 n8t9WYeX7mhEHpLjT4zanpgj7M1zC3zMa9q0Uz8ONXctCufbmxQTvmh7TGcuGe+UNlxa
 WZvhNFbG0QQCNsnHDXCcUpbD/ctAlvjPP/+JhbQd9+zF8KopxdnWKa6amwgq8vZ9vI/y
 XSU4Gi4jVO1JllH18zYvS0TUSz9cWp4ocEWztiICUH4gFm1zcbljuqg0E83GkyHDiLZ0
 heKEs7po57WTGY8JfXYVG3E1emw4gbJFnObEQTtlNRYb5ps61ze15/I0H9ljUXk2yI6g
 2eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966284; x=1742571084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPUorqKfsLVRRT6LL5YY8NsN1BebLDOcS6il2uJCEXE=;
 b=U2ob1707x+8USb01G6983kzgncvu13OQpV9N7nL/eM/lGJR+lmGnCw7qNkMMnQGTJc
 s+ao9AKWKxgoQcIgH0F0LY3LHg7OSetA6ohTjSrrjNf1jcRitdhLznz3cf9RgAPRH+IN
 A1EgeG7En2fn2nMoj51ofy0Lz2IdPAZGA55b/LHsvtXLvKl/y0e8lB2JDzofuPuaImNX
 ZXy7fKr2+gB5FOtbZfm6Ud4Wk3SMf0PS3LcsaqQVdOfhSen2HT4XbFHWxML2qMMvrWR6
 UkjsBdnHsOlcl0Qh/lLrWR6vCH6kf/r22J3IA0b9tL9ZRMfIW3sxr43lOrcX/HnyOjYu
 hprA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhICFKLIgBPaBfkMQfqHMkwPZ36l/5Ki8BhwMNnSzb2nWD1h+SclgkdYjwGlIYk2jfWEEOdBU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/myDQAMpyT3QZ0kH/4xFhkNeye+fdaY3xU/AwpW/GJi0lxydQ
 u1OXDlE2+bPPinkAKhN+fEcbG77PQ7foQBkL7/7oOkjwMrWhmBQ/7QDzHTBfA00=
X-Gm-Gg: ASbGnctl60FvQqYACAEXtoZqXZ+kduqgr/Kdd7CgeHEsYkDpCmHhl/Y0320cyv4G0FJ
 sz0/s5pHHQLqVNMHPmX57l8aUqukNwL+j5ceYI0Dl+MWKQxOjkjPVzH39Vs/vCCZlnRdCjAtVwc
 TifKv0CUtLdgXBcYVZ9WWPV2MwbCy+0h12tqEa9joC7+aieWHucCtpsFTw3fnde/Qg0ScAqOfyc
 7zncWv3HiKR7/CAEHanciJgThzu0tfZrHS+0d1+FyVsKB3pdAXGiPR4bYV/VHOHUn7x80GEEM58
 pPyq8+zNw1cOENf6421nZCCBWhEV/cPEwloQ3AvyB09o6m5aJ0wYqGrG7mLMFBn15mVeHYo=
X-Google-Smtp-Source: AGHT+IENskWHlgqCln/0eP2PLO2w9JEzvG3OHMlL55DpCCPc3KjAhSX/nlaskDbec+4HAv7lJmKMxg==
X-Received: by 2002:a05:6000:156a:b0:391:2dea:c984 with SMTP id
 ffacd0b85a97d-3971d133670mr4219447f8f.11.1741966284389; 
 Fri, 14 Mar 2025 08:31:24 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318af0sm5907399f8f.73.2025.03.14.08.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 08:31:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 14 Mar 2025 15:31:20 +0000
Subject: [PATCH 2/3] clk/qcom: sc7280: add some debug data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sc7280-more-clocks-v1-2-ead54487c38e@linaro.org>
References: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
In-Reply-To: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=wwzfi07FEq2tTZD8/0hk+k/kdehPMtnFcHRl/8LZNn8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn1EvIvHElet0RsdIBXWbs95caOdD6cWQXc2hK0
 coFjRTzhNSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9RLyAAKCRAFgzErGV9k
 tlOZD/wJEZD6mcXN4IF4mHrSd6hnp+gjNZAqmV+9owZRdNlUauAul83hRqgzHTozScnlyS4NXeP
 HJ9VzotNkqQMN0qfTza7mlvZrh0cyA3+9PmVL+Bj3RiZMrZ03LDzE9q2Z7f5oq8yUHn/UC0zcBY
 YPzCl4MEpZEK/Mm3B3agyDlVgccSUlIjMeBA0Ysm/7f6ygX8BbnpyKqiNnbX8aOEevPDnVLUAgC
 qjkZD4Eclo7cjW7vltRhYD453X0YnhNYajv8GaVZ80rYqKNBoz87CoH2fqQmpPf4gyjSJg8OSEC
 XWMdfydK9EXFfqT3l817d03J0l/zhYkOw+Qw0CIW2lEJJ/tLo3cSUPcIXXLOb80js/GY+zadEFL
 yPPfurReL+ty1aDsDgaYt6eKnAhrFRrCSZSLYgadsnZSSeS9H2OMGNF5n0TsVhXfzsx6CKysUar
 uzXaBp8F4Y5x2O0jctleSjd2e4JqnDSbyip3HUqroQTxzMD50/Yu1/oWgkm8CqBNjW1vhlJbA2S
 +afDTevlkruhO08jGWdsgheabFAssJwyoVXtke64YszIjvgrixMsPcD03mXyKL3yGxs5iqb4VKK
 y2pQQC8jOlJv6/5nXvNJE1r6XmcNQ5gefzfMyP0ppvvRWsPoq8EilPmcDMD2I0XYwdMG4XqkmEJ
 BlJ7FDePxk2mgQg==
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

Dump a few PCIe and USB clocks

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 8ffd1f43f23e51140c7822f0f523fdfd8ab1de7a..2cbc01b6e0a4f1db0e4a894cd869b532d6b3fa45 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -99,8 +99,20 @@ static const struct qcom_power_map sc7280_gdscs[] = {
 	[GCC_UFS_PHY_GDSC] = { 0x77004 },
 	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
 };
 
+static const phys_addr_t sc7280_rcg_addrs[] = {
+	0x10f020, // USB30_PRIM_MASTER_CLK_CMD_RCGR
+	0x10f038, // USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR
+	0x18d058, // PCIE_1_AUX_CLK_CMD_RCGR
+};
+
+static const char *const sc7280_rcg_names[] = {
+	"USB30_PRIM_MASTER_CLK_SRC",
+	"USB30_PRIM_MOCK_UTMI_CLK_SRC",
+	"GCC_PCIE_1_AUX_CLK_SRC",
+};
+
 static struct msm_clk_data qcs404_gcc_data = {
 	.resets = sc7280_gcc_resets,
 	.num_resets = ARRAY_SIZE(sc7280_gcc_resets),
 	.clks = sc7280_clks,
@@ -110,8 +122,12 @@ static struct msm_clk_data qcs404_gcc_data = {
 	.num_power_domains = ARRAY_SIZE(sc7280_gdscs),
 
 	.enable = sc7280_enable,
 	.set_rate = sc7280_set_rate,
+
+	.dbg_rcg_addrs = sc7280_rcg_addrs,
+	.num_rcgs = ARRAY_SIZE(sc7280_rcg_addrs),
+	.dbg_rcg_names = sc7280_rcg_names,
 };
 
 static const struct udevice_id gcc_sc7280_of_match[] = {
 	{

-- 
2.48.1

