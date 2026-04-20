Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B63EA71B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8D283FF5;
	Mon, 20 Apr 2026 03:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ORL6YpPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8ACE8425F; Mon, 20 Apr 2026 03:18:55 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FEAC80087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82faf871346so492272b3a.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 18:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776647932; cv=none;
 d=google.com; s=arc-20240605;
 b=WOld6rToP7DmBpufRXUfm8U5u7xHQ+TEGme/Zsmo/eh9AOGl0//bcDgmtHbfBGPnrR
 hIRyAYBkAvUTx3XXTmKeuNum7TniFU7fCuImFsNqtKit2j40HuSrFOTGEJLnGs2VT+zb
 dwK0mQgCC0S8xE+MFQ/BncnAjSu0Gvw4jKPFuKuf5bq6OHgndGSaGsuv6XD26fL+7BhT
 e5bQkbsvVQ5NveBhIxFMdiS48bfWx/XitNTCYn+QFfhIPpuDPsyPJYkdQoq/6wdGsiQO
 Yiiv2KV26kn58KPEwm5hrIMPGTBIxey24ZyWvmmn3nX0lxerGUFfdrqOo10PtiUBTQjy
 xTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VSHswVN9z/v0owDIBRWKFKMIKVomcCdazxFd9USIYzA=;
 fh=S8xjaNhDK5zkqclbPZi4D14oajyF+NpuR2kRzRAZ3EE=;
 b=g7F8s2q0bMcF9lXcQ8PUS6OrzfdgOkomB2MVhIbfY+5VBJvbOWfutZf42ihItelMud
 N6Thb7Ilmyv5GHBxhvuA2h48Ffzk7OzkyuB84sxxas3gO1xEIBqm4TRQv8TH1gl9PrCZ
 CMZLl96suCyLvCNiwdn+GXdlA9IhwolDt61uLunv9FYaPR5jR2jqAXp4QC3cVoIKH4SM
 8ObUbETH3Qf2EIquJo259kEKuR29lTrkyGor5vwuTAHu2H7AiOh4tXHBBC9ToCYCl/Hz
 SWjipHQiB90SYnhrBxpPZ3u7dnC6OSBaWtmG0LjdKZS1xwdiEhSv+NtvdGsjyBBVqCTO
 g9gA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776647932; x=1777252732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VSHswVN9z/v0owDIBRWKFKMIKVomcCdazxFd9USIYzA=;
 b=ORL6YpPr603Hk8Csx78Kd3xwyXX6k08cRboOmalbI7FgFR0acugNxlTjTVaRQxcvRC
 ps1WbsVkpuXM+uwi6iWXUhvVAYbwnyvGkK2gTqhreQEXAcT2+Hn4CVmO2Qb3BS0z2QtF
 Z6AIwj4xt4t4eYUPXzolDE15EaS0jGxWWaWHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776647932; x=1777252732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSHswVN9z/v0owDIBRWKFKMIKVomcCdazxFd9USIYzA=;
 b=by7NoC/C2EatDK/GMA/5r6ftyHDLCtSTbWNaO/x/mcHYTj+Q3adWq3Z0ZOVHxVWl5V
 D4eBZwqnSrPv1YRirZdV4dwvePbDZ1p3uuDcrFB1ZboE7wF5I7QHQzvTKxkOmvfygacY
 ynpxzYxqYisDZXkdSwDTlJ1RC/jTgSeiutho8lKaQgFFckiVmEbM82PdlK8ggba2lHZd
 CXKDMyWzjl1IH6cJlrdjJvx9yR7/Crg/QvCSFTcYaR6Aw0qEFYur1yWD4dZwu9GUMeur
 Wx1bsq+Nyf7Z+0eajOVOTYfkeSvbjlfN6j+O7cPELhMtKqLtDxH7AQqLXLRas8MpP8ag
 pqxA==
X-Gm-Message-State: AOJu0Ywwb9/pTz5EzSicMsY3vfZBxgV+yd9/4k9nqaAP7rgVyP+svWYq
 NY6P5voEkNbc4eQff9UBvdbb8APXWFmhc/NhrNRqjw4PgLedHwBmM030DGVUT3pOQXSiCmWUeFx
 0YGaMfZBg7I/XeJZBBoMszPmBTJMBRTDqsCKMGivK
X-Gm-Gg: AeBDievxQsJ2BVMl05gOQuDzSOhcMB5iYpnm5uT/KwLgr8KidM2KT+cvUuyyV/iiQ8i
 bsHoilWKUYMYpf/BkslfCfPKMUv6R9QP5GY1YtKPeIuCSRZclfEPDn/0Kn3cljbml6cpVN8NfcY
 Nvz8e11p2ri4VuWw5+GIjO7GDHMrbANR7026yhdnnD2mc259OHREvmwXbzfUSb0BiWSf34yUMUt
 emauIDXFdCkWpXTvS1qDMNPGdeU0j+GsgY7dwRfz+ICq8Vvxl7oU9l5ER8dOHCiT0WYOpE/tHq5
 meN7jYnfAZgav8QHYA+cUbltV77A+fM=
X-Received: by 2002:a05:6a00:e1a:b0:82f:7bec:2050 with SMTP id
 d2e1a72fcca58-82f8c90d174mr12092650b3a.39.1776647932179; Sun, 19 Apr 2026
 18:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <20260419-type-v3-4-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-4-ec49acd6870e@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 13:18:09 +1200
X-Gm-Features: AQROBzB8JYL6FN52EJBeGLCSd5rLmt6fu523kjm-4ofEUQlDboN3z6mh1K2cLRA
Message-ID: <CAFLszTgouVYBOCfFrGJw=J5nagzPUxGeY29t=C5dYGZS7G=m-Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] configs: Enable partition type GUID for QCM6490
 and QCS615 boards
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Balaji,

On 2026-04-19T10:24:02, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> configs: Enable partition type GUID for QCM6490 and QCS615 boards
>
> Enable CONFIG_PARTITION_TYPE_GUID and configure SCSI environment
> partition type GUID for QCM6490 and QCS615 board configurations.
> This allows these platforms to locate the environment partition
> using GPT type GUID instead of unique UUID.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> configs/qcm6490_defconfig     | 5 +++++
>  configs/qcom_qcs615_defconfig | 5 +++++
>  2 files changed, 10 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
