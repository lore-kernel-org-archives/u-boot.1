Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F92ACF64AB
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DD3840AB;
	Thu, 20 Nov 2025 10:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cK7Ob33/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC5D840AE; Thu, 20 Nov 2025 10:44:19 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7331C84057
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b32a3e78bso551568f8f.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763631857; x=1764236657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qMFBI1M+/T19HGSXkF9r+7j9eIgGZ1QzzvHKZxA2hE=;
 b=cK7Ob33/evuGGwbEKVYIoOvu4VkAlkWAUOKXAmk2WdTwjwIO7r9DJYaY32N/8gJ8/w
 t05hF0EBLCb3LVAgki0x0ORltmxjh3xIYNSfw9VtGyze6dQAlPAtej6btiCPMuyEcXHP
 QGTinIrOwFEu+8mqMGo88et3gGN0KIfCR6ijp/Ls9kW+pzXFKcd7eOfl/WVr4eJsaZYQ
 ejrxOVNrAUjr3wJGTwrq4GPK2yL2xTa/R5s1zrCKiQqmpGdA1GASOnnjLR+K5fuRsczl
 Ot22gITz3NkGv98L99B+k6Pwig2VGcKdKrweMGne5x55EyUKe5AqjHTVERlZ//IsNPhz
 Cocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763631857; x=1764236657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+qMFBI1M+/T19HGSXkF9r+7j9eIgGZ1QzzvHKZxA2hE=;
 b=l3q2Tribq4FK76Z3WFY0wZnHhSmA4AQA3hsayFPlDsE2F00h2f4hyLJ3SakMx/vhyb
 wxwbTlfWAhGv/J+CBXDjHoEwtD22Ee/3qNc7KtP1Y8TBdTwaQ51CGlrgbAImzwDqDvAf
 BJspUSqG8pdkru/Iyv6aam8NI/GDKIhYZGWh4dX1Rfa8XpFRyd7SL92IfrclRJ9ETTOK
 HR2AzddSmFDy1Arvnd9SKYjulFw1BH1+dlXcgyxRNIciqER0XeSb65MRZZ9XQ9RYsZrv
 VZZdOroN0wX/NaAv4cHdmFzzsHYoPSl3YDhu/fb5vLdzMVbYyz0OPROhCBltL4eIdqhZ
 OUkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9L4DM6wOfloi7xMv9nZydvPLXRVD5BXIMORV8+O1Yjaa/Q75/LZ0I23nepxem8EsuKCLZWU8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+YzT12HbPdlbE/JzVeWaEh1LuNKtYKbq5HTjpfb33qpOZXvr7
 XYiVrpYesGOReN1XbJ3LmpgRLpxbrlWkl9wdLmK48DEjJBM+cE6JIBN0+d4HJ+DZ88Q=
X-Gm-Gg: ASbGncs9i5cxX3G/NQ0Z6M/XZcz64wSiFne1fLkjIQkf/e8zwAJUiOQ/Saq/E7aGjDY
 6rt4gZWtmyYjJA72WRfnpz/SZE9Q7FJHAqDy4+tP/zFhZYzmxkkdlQQsWjyLqpPPAjI2k+9zEdQ
 sCiB9x1RBN+G6afvrzcZPehjh6A6Oyrl2P3TmPi5jXENk0GXB/s38Bc1+Ifzm2xQYUQpOmk5P4W
 j+duEnABypKXe8Y87+Fuvs0ncsfdMKWiUJouqntSM7jcNZZwOXOLkE5ILnglWt+CMOgc2vq6GTo
 DbGPVi+w/Uij8KiRuvRIQPvh4ExQv07BOrUsmLgw3Z9IwScaswhGWDHVzSdDawzrgQDpZ4QN0Am
 i6s2++yyIPzLCtkdX0PgiBlRSD9bh8TmiGo1eil///0keNPQ4jLDu9Bu+eOvmPvTGlaC5ek3OZO
 u8jLejJo1x7Ge+QNShPjOusIpAvprlL6c=
X-Google-Smtp-Source: AGHT+IF0V9S41E4T/z0PwplquZRGAgE7iqpbMcZQcAVaqq3yiy0domKNQX6gm9aHoNhFlYkrbI2hgw==
X-Received: by 2002:a05:6000:2210:b0:42b:3dbe:3a43 with SMTP id
 ffacd0b85a97d-42cb9a65043mr2060164f8f.50.1763631856575; 
 Thu, 20 Nov 2025 01:44:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm4386078f8f.36.2025.11.20.01.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 01:44:16 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: trini@konsulko.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com, sajattack@postmarketos.org,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH v6 0/5] Added QCOM RPMH Power Domain Driver
Date: Thu, 20 Nov 2025 10:44:14 +0100
Message-Id: <176363183220.2293399.7296647117885059868.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Thu, 13 Nov 2025 17:04:22 +0530, Aswin Murugan wrote:
> This patch series adds support for the Qualcomm RPMH power domain
> driver, responsible for managing power domains on Qualcomm SoCs.
> The driver is ported from the Linux kernel and adapted for
> U-Boot to enable proper power domain control on SA8775P platform.
> 
> 

Applied, thanks!

[1/5] soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data() functions
      commit: a264c0454b8ddd8c5ac0ed29623c72f65ec4d53f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
