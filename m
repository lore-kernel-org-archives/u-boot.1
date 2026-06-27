Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEE7C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 13:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1363A83FEE;
	Sat, 27 Jun 2026 15:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ktv/xHwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9368484C; Sat, 27 Jun 2026 14:27:43 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32051805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 14:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6976b0b2c79so1842677a12.2
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 05:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782563261; cv=none;
 d=google.com; s=arc-20260327;
 b=TErXM5u0UibfAOI271UACt+am0G/wV9vUsOukk0TrGVg8LadZhV4VwUr7vM1UXJ5p3
 aS7VeG+GvRzpZ/d72a+z2K0QtLnC2tG+vd1yrned7mfph+GQfTh42lho7x+TsCi18gIF
 Kj9HRK+mHNu671/ctIJ5nzi1fg+T1g7sku940uCnVoSn/DfzII0037Mfw2+LY38eAMez
 kkp7+ySU7HT4Fj0tKjCgTjcSchIGs4Kn4bZYu2GAZxR6V3XyFGssAZ74giScJySje/ZQ
 ucGjk8ZO3h8Fl6imizeEBkSVRbZc+MCQIHcOd8a0uYtnkRuqlwY9qG3TK82DPJnLSbSU
 3D6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ShnY0+k3ALXsEWrfrVXMCRvwQqYnshw7E9WSiaSvZ1g=;
 fh=Po3DImcceHqPaJLma+rOqACX/uP28oNuAFdBw/bIyUo=;
 b=ilkCPGWBVZan2X7OHMuexWj6TN5YOAQJrJmKdk+O/11M6S31zS5FEmXNxxSsQGHivC
 sCLqfo0+bq/r40rDf944nfsKUaCmjv7sjh/Rrih18mjdGLNsPaPze1HaDB+hexRDuohN
 J30idJDvvvr+hsbFBc9OmJ/Yzq+NRSSp6n4FEwtr8CQ1Kzgb4q7kJGwX1ujDjGvmTJNz
 8eegUzyjZ/QkayF4SivsYxvXrWj6qpy/Rv7nqNyfFbwbHDVqGw2g90jNViGq0082GW+A
 Picq84a9MzzZmlUOL616RCH0mWpK/tu6vJnM9WsUMztIyB6/x4+PqTKYbxyDGJBNmDsw
 pz3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782563261; x=1783168061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ShnY0+k3ALXsEWrfrVXMCRvwQqYnshw7E9WSiaSvZ1g=;
 b=ktv/xHwXcSFQyKfXzYxN7wo/1MqGu7vAHs/Q1Wks5ho0PNR5kBbIxEwaDcfasUkFW2
 U2mAmf2vyfWRGtb2TY5RLSaUpJ1drqTOu7qcbD5rK/OXvbQx2SlTiEdILm7LiIn98O8F
 WF/N9uVz3Fqg6Ee6+KK0QTuuZHQ4ik8kZUoMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782563261; x=1783168061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShnY0+k3ALXsEWrfrVXMCRvwQqYnshw7E9WSiaSvZ1g=;
 b=Ab7wzbq12igzcmOWqGRAOlMlFKBE63tU9dLRQGYkudGRZDYUw74+QuMlLI3IO2hUz9
 T4s2O4evyE7cDKTYWAS3vlMLZ9I7bZ9uUwfCMln/dh7xPXw/tpaD+s8N/gP5AbJEkULZ
 QM19MR6LGL7/cqOyb8sPcC4S96DWLiZLXuE+4Q5kCDPV6Y73xd6Y78BjgsyPnrHJZpcm
 8MYZ6Mc4vWoq316g3g6gu586JaXaRuzstPz9UdhRJr2XXHaNUHNMQyX8ENFWoEO8EcJY
 l6m44vfqLAUezFRpAz8M1LS6b4lWn2W6kB8fn2ffai2p2+N18RZUlq/29NFKz1zirre9
 ujvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQINggMKZURsGqs9wfdtfnSxH9jApW70K4elvhp9fd+WkuaWdlXvHdNs+k1nMDmyu75nBnumM=@lists.denx.de
X-Gm-Message-State: AOJu0YyJG15Een7WrolXOd/z6WpkxizL4mgggo4+7CAwO/13QI4FP6gu
 /9EBZtRuO6nv+j3n3Y7KVYOWCzu/sExpg+Jrh7W8/ZMcDPGyF0hfz0H+SmG03ES6t3s9XQK9vDs
 mNkBlDT5f58vCoeqAlj4OYNEIWPFjnvpLHpUW6x92
X-Gm-Gg: AfdE7cnfEZJBol3Fugpm4vWLJdf9F4TMmYiW7I2XSMhOq1me827wsk+NAaTHi68u2gI
 I65Qfit6yhakHdypnNZhtQPn3Kb/F3/8e2VkxoHzuN0J5hcU5mbsZO2WMfUkGR0aH2GWzCs8snk
 +rlb8N3R6wS2cwhcG1rFOu1li9fOnB3LA7Yokfq82atAgZPuk6eLmaThh4yfshg6+vFKuTa5wB8
 NHMn8o3k2kuj1AWeG4NGprFgN5LeTdHvVEW2CxmD9o3eqtMOdgzUvSISLIkko8JpaGZ0yUcCA==
X-Received: by 2002:a05:6402:5207:b0:696:57f7:a129 with SMTP id
 4fb4d7f45d1cf-69810a18095mr3848472a12.2.1782563260688; Sat, 27 Jun 2026
 05:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-3-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-3-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Jun 2026 13:27:27 +0100
X-Gm-Features: AVVi8Ccj5daxHU0n5FK42ECX-0oofp5kgEQ04A0GP5RO8oHIH8di8By1EIJNYA0
Message-ID: <CAFLszTjPf_zmu8oVb2g_ebgdO=joBvS2K5VY9T2gxxfmF+kg-w@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] clk/qcom: add initial clock driver for ipq5210
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, marek.vasut+renesas@mailbox.org, 
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com, 
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com, n-francis@ti.com, 
 mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 27 Jun 2026 15:46:26 +0200
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

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> clk/qcom: add initial clock driver for ipq5210
>
> Add initial set of clocks and resets for enabling U-Boot on ipq5210
> based RDP platforms.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> drivers/clk/qcom/Kconfig         |  8 ++++
>  drivers/clk/qcom/Makefile        |  1 +
>  drivers/clk/qcom/clock-ipq5210.c | 98 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 107 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
