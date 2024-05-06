Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B7EC25B5C
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D720488025;
	Mon,  6 May 2024 12:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="UCHls3gz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B8AA881F1; Mon,  6 May 2024 12:27:00 +0200 (CEST)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B69B88052
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1714991216; x=1715250416;
 bh=umXfqnqnS3kzIMg+mM5CkZFqWeQQjtP2tzfdYMNSbfc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=UCHls3gzrwddocsKHIKnfLlA9aNhiBDo3AWQUvpMQ9I8IaZbFz9L5kH827zdAF8d8
 9IoLrFddIPkJ01IB0M9g89ZT14IIXyKzceEJGBY14FON7+v0sm0rVFLIm1LqYmqzAD
 As7UENoC2Lk2vMUx/s/OQKoCtSjAjjKAMp2OPybiZIyCvCCaYvifa4F27BSmOnEU9K
 Gk5MLnTObgvR/0xW0Q9ISnkBoJDyeFreJ7qxebC5M9m2IZmG5my06oQNu+HRgOAXZc
 pPupfOzAHU26juSFByYyzk3U2SF27UZsEGEzIyd6ZaYR+SlHvQOEq5My60HVqywNm4
 +kGPm98dJ7wRw==
Date: Mon, 06 May 2024 10:26:51 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
From: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH v2 0/2] qcom: ehci: enable core + iface clocks
Message-ID: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 5d18b8f13c0c2383e3379057c7b20ffefb242723
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

These clocks are mandatory, as can be seen in msm_hsusb driver in the
Linux kernel.

The appropriate HS_USB AHB/SYSTEM clocks were added to gcc_apq8016.

Technically there's other adjacent SoC families that can use the
msm_hsusb driver with different clocks, but only msm8916/apq8016 are
currently making use of it so I think this change shouldn't break
anything elsewhere.

Signed-off-by: Sam Day <me@samcday.com>
---
Changes in v2:
- Remove nonsensical/unnecessary reference to pending qcom debug dump
  from commit message.
- Collapse ftbl_gcc_usb_hs_system_clk into apq8016_clk_set_rate, since
  it's only 1 entry.
- Add bounds check on clock id in apq8016_clk_enable
- Add warn if a rate other than 80mhz is requested for
  GCC_USB_HS_SYSTEM_CLK
- Caleb: I opted to keep the non-bulk clock enablement code as-is in
  ehci_msm, since that more closely resembles the existing Linux
  kernel code.
- Link to v1: https://lore.kernel.org/r/20240502-msm8916-hs-usb-clocks-v1-0=
-eeccf483b68d@samcday.com

---
Sam Day (2):
      clk/qcom: apq8016: add support for USB_HS clocks
      ehci: msm: bring up iface + core clocks

 drivers/clk/qcom/clock-apq8016.c | 32 ++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-msm.c      | 37 +++++++++++++++++++++++++++++++++++-=
-
 2 files changed, 67 insertions(+), 2 deletions(-)
---
base-commit: 2f1e76bcfee75b9f99ade63002c05ffaaec86afb
change-id: 20240502-msm8916-hs-usb-clocks-34bc22b03f3d

Best regards,
--=20
Sam Day <me@samcday.com>


