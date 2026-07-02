Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B913C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C7B84D0F;
	Thu,  2 Jul 2026 11:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CM4SyHII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7291D84CB6; Thu,  2 Jul 2026 10:14:37 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB05084D0B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so1073469a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782980058; cv=none;
 d=google.com; s=arc-20260327;
 b=KUdV8UnqKU7nYsV5lrGw3+0cKAS/pCk1dUj2FR/Yqt2MReeoq/1GMMFD06aBUV1uS6
 ojEhJg8gMHf1Xy8GhNLH3uvGz7kEQPjVi2VUjXzWCJJyvB2L233iBtMRtSy0NuTwmiGh
 0iYwUgctMQQk8Xms3eJNkMc1vAy29QnZjuB5zpZXeOXBcULXrv2tclDWIQLHIWkwHuyA
 DdI4RKYJ12G+IPcRPpjqJmZn5cVaJ7hvlw7bmUxWOfrv5oIrteJZoesX94oNfq8FQT0G
 e/E2uHHIApoOhBhgPDIeiy9IPnJtAriM5kc6oczIzxjoqaVqMor/88xmZ3xmHROESK3g
 A8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QKxnJEKlBG+H3bOuEGI/XCRNQSvB6lT5uS7vXsMA3A4=;
 fh=/dnMiaIlYIGYoicCohHlHnx/f8AcNNCJTBfV7KSl7mc=;
 b=btriqfaPxkc4WZDPD5e0ZAB1KklRuvzcd8lociCCkvaKZ+l1UED0XGd8UwyRhp8C6W
 mg+2zv2qW4ioLFwry0F2IojNF219g5c9KDcdJswFpgol24SsAvXCjqIPxeQMywbmMGLw
 A3iVFZ4nJ1abYd8Ro+8PK12ipzV0mv6cYMSHWeS1LA3OloObUTrNVd1d2Kj0+cmqkbb9
 AitYBmN2YdR0FMdw+PkWsijz2VtE3H+G8q2WT4VX4Cby1RZ9wca5liqnSfeIbC70RC2P
 TlmU/qCrbCgjyfE1rPQrDnsLYrN5gVj4Stt0wAqrzTt2vr+djBFeEsK56OoufT6cr1Tz
 GN3A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782980058; x=1783584858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QKxnJEKlBG+H3bOuEGI/XCRNQSvB6lT5uS7vXsMA3A4=;
 b=CM4SyHIIrjc98jiIH9oTwuiJV5K/Ww1bHiKx8HvBdC4IDAxq54qD/4ZE1IxuVHxQAr
 jat2a48O2BSEi4n/Kq6w3U2mthSW7f8KfI9riZfBpTNuEwnDjq5vEfmnd4jlGsGUZ8mH
 YyJP4Fiqpwu0LWLfnxIalOQxtfYWlmpcfEh98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782980058; x=1783584858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKxnJEKlBG+H3bOuEGI/XCRNQSvB6lT5uS7vXsMA3A4=;
 b=HLbxZ9Mtands1l0tPcmAfCZTJ5c3j5pZNhX9AC8aAQtCdLd21EsyoBh9Yd8tY96DJH
 ZKCZyfMPJ3vA76GZuiY0GVYO5DbG/HuQ7ysAOxW66ioQCAK7FngzAfFL2ltyoO1Ocesl
 q9yZM+Q2SmgK7j7gajru9fFTTV5T2EVRQRmtOTa1SYHDatOPyHpuxLNga5+KQYzVw+HY
 cx+xmCL8QrqeiXN/dM/qG1frHIQyOtNc+t6fVY17fbNm30xX5vYqll3vYwho0fhRAa0Q
 pQh/nKwfJbpBK/mdHclCV//Simpu1kZ/a/JsCnSBWfCtKeJifkxUKVhlYzj7oXVpn8ds
 4xqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJ+WopbgTiRM0i9kOdePO83l1uUP6AspZXs47CqMx660rhLxfgWkyr1j9xXvkV2gVLa2cTCyE=@lists.denx.de
X-Gm-Message-State: AOJu0YyX5XsSIJCLKnshDDTtiI4F/jkh8OXNAA15QGtBHKAe5JvuucWB
 FsKBkOvlb4ndUcQl4hOzNnVmqKbsfwbwQr5IIsSF+sMUdUd74xwRSX/7wM4sa+/4V1Et8fTkNwY
 DQCK/JM74evRg8gqh/1BYAdRuPpnj8MzgNoBcapXn
X-Gm-Gg: AfdE7cn5wdG2V3bdYIyKRArwJ3sgQ7iOmUTdMwF6Otb9lCz/MsmWX9jcYblelqth0+r
 +bnaVWC18q0iOXU1pIS8rQwu5wygoUwOwosVaNrKW1IzA7i4DKitZmTARedZzZJs0qLhss90myM
 VLulHT1tngxm2N98XIWh5rmZcCamtbCJuU4XOaX5gZcZAd3TEv9dN0bV2TztUBI+Gwwtn4+eHrz
 +YGgKAlmnwzeKz+4JryN29IS5rVL3XhYssNwe7cHk6iQno69LOp5XZI/h3waMuHJgxlvvnYbFEX
 CcF4po9h
X-Received: by 2002:a05:6402:1f83:b0:698:9a31:364c with SMTP id
 4fb4d7f45d1cf-698a2cf84d4mr2169276a12.36.1782980058222; Thu, 02 Jul 2026
 01:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-11-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-11-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:14:05 +0100
X-Gm-Features: AVVi8Cce5dA0JYInqf_X_0WnwE0zfzfhMIFrebvx1R-jNfijk-Om6MPnUgczDfs
Message-ID: <CAFLszTj-dE2C244DQx_Q+5Tqe03ShX0g6hj0UEtpTXfAzDXm2w@mail.gmail.com>
Subject: Re: [PATCH v6 10/11] configs: add qcom_ipq5210_mmc_defconfig
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
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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
> configs: add qcom_ipq5210_mmc_defconfig
>
> Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
> Presently supports eMMC.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> configs/qcom_ipq5210_mmc_defconfig | 107 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
