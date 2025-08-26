Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED679CA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 14:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAADB830A0;
	Tue, 26 Aug 2025 16:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="UVXb5Ogw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97266830B3; Tue, 26 Aug 2025 16:29:33 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C901D828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-743749537caso5267332a34.0
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 07:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756218569; x=1756823369;
 h=content-transfer-encoding:cc:to:subject:content-language:user-agent
 :mime-version:date:message-id:dkim-signature:resent-to
 :resent-message-id:resent-date:resent-from:from:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KacQYd32H6wGuvlsrhlV6f7XoOPUispVXrFoQszjdig=;
 b=kfc2GRO1NbxURLS/MB7eqcELJE+covqO1QdxpbwZe1lmdBDv0GUb42dy+qEsPG9QxK
 X3ESgOgkcQaOtVxv3FnhZ5yCzAwnlpU50V1Aw3pgOCaS1+mAweunWuL3XE4aCMQNPlW/
 mMZsmhjffOZDL5yButlZ3Ex6LCkjnaEYL5g0Fkye030OKojS6EH44nhWYTpd+k7Inz6x
 JmBVkPUN4azjH3kameDHJxYouk5XXRveZ1Pg3yy4ASkHk3RJUrenIHiqdQdK3fcnBzPw
 FO5SesPr/dlpRuvlI/HC62lrA3E8GinpXDPoth0BIKD3iCfNbpq02UXUeZx37Mozj2sb
 EH7g==
X-Forwarded-Encrypted: i=2;
 AJvYcCWJG2eIErQvR76BbdTygwwnkHQAsE2ONHe1pN6SDZurrnFytURkGZMhlO+bJyHnl27XdEYhUpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwyfQh2FbYLTnmsq6X+dmdi96LZM6LUG1WhMaIh1WF6WP2whmEm
 6rCfRAyCavaqZVCrq27KwMSsSOWYS8kP+XmPAroiVblBzd0rHBNc8/QLuGEu4k8nyNWf7aATzKI
 I8rng310=
X-Gm-Gg: ASbGncuHgf7fJuq7/gTsdd0BZ9B/VFcVNCpxoF6TTQeTduem4suNvnIK1rQb/e4kKVW
 TLJFTvDV5CYHFKmBjqp0O9XPSIfeEOHzudBanVEu9RDdFRyL4IQMQfvoANIwmYo15W1ZdNK3g43
 CnR8F9OPnqn260I4IOEFwNkXd4Nr46deNNaaWNlynokua749gFvLfhqYbGQc7M37RgvmY6y1w4G
 FxxkIVb1H6jtkVoifroh+MeVV++24x8mgyzCrBxgWR0sz683/cjXktRgr/sKughB+gUK3z7de03
 wPZ40BwIORQHx/Z33c0+wcEv16zE0oBow4EFtZh9c1UHLgQMS/2SgSD6j4EmkQU+7/Dv8kNXidB
 7GLVP54oON1xYI8Kc6L+/+coXw6EXchx7qgQ2Fhy2CYYN3im4M3WhXkV4ctuSTPtnvwU=
X-Google-Smtp-Source: AGHT+IHmdG9HP6id9jOgHUJMeByGdNnDt5gM6qwZdAEVLe7OZRhBJLXIQBJ31zsGUuY/zfAkPuIoMw==
X-Received: by 2002:a05:6830:611a:b0:73e:9fea:f2a5 with SMTP id
 46e09a7af769-74535b18a9emr1066846a34.4.1756218569485; 
 Tue, 26 Aug 2025 07:29:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7452a7d1b27sm876835a34.33.2025.08.26.07.29.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:29:29 -0700 (PDT)
From: Patrice CHOTARD <trini@konsulko.com>
X-Google-Original-From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Tue, 26 Aug 2025 08:29:26 -0600
Resent-Message-ID: <20250826142926.GC124814@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:65a6:b0:ba:8f80:e1f6 with SMTP id bd38csp327952dlb; 
 Mon, 25 Aug 2025 23:51:04 -0700 (PDT)
X-Received: by 2002:a92:d952:0:b0:3e9:eec4:9b6a with SMTP id
 e9e14a558f8ab-3ef08858917mr4441225ab.12.1756191064627; 
 Mon, 25 Aug 2025 23:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1756191064; cv=none;
 d=google.com; s=arc-20240605;
 b=HWz5xrr4HQKKV4PZl9nALcXUiRxyixVq+sUfATpqjnu6kM+wMAg7KhZnQHkga6bLG2
 xscOYu88gVAZVxyz5/C5Zppooc52QISs4iy3logYROT0rlRccFom75Y4TCEFIu4odnTK
 3axavgZHp3Rfo3cJvWXcjn/grDXaRc7N+Zy+oYE8pO9W1N6bc3pY5/Ka1Epi1djoB+Gw
 ma3YENrE5Dg57CqsDhoRKNdcYwEamcAmE2XIlkOtIpWtWyFXdtlYyez5IcXq20UJXIEB
 JaH43u5eEkaxpmtiP4gvJsXcjX14f4uUN/S9ur9NEwpNKn5FNLn9e4i6e2bCxfFkBg0u
 FjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:from:content-language
 :user-agent:mime-version:date:message-id:dkim-signature;
 bh=KacQYd32H6wGuvlsrhlV6f7XoOPUispVXrFoQszjdig=;
 fh=eVy7okcflBqDzz3EqmW6UtTR9jeyJPb1xiusmcjulPo=;
 b=lkA0hD4jRrk0xDQw7fRTLH2WCTjWXiKO1iH1sHkGtnRZ1SLOzmAHN07f3NbXNSsbkC
 H5lnms3p1d6N5aW1dykiQf+mxg56PzDICSaUBIfl6nVW8/061v4+LnsgeiqFrFbjmcLg
 GXd4utE4ZQzEtpBmBH99Fe1vgvrz0K18LPlaw8BqT+Nl2ibSx4jEtLAk4Z7J5JRTgr0h
 xwv1pTpKfsD4AjUYO0gFX1yFpd2exkl0uFrXmcu0E4OqPwrtGSGWt/DM0yQCY8XH1X2+
 RSdAMJZyuTelUtRyjGQ56a6euOy3/TU3kzOYHWQqlhLwvVMXrkgtnrssAxU4QXUKLFlC
 PYiw==; dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
 dkim=pass header.i=@foss.st.com header.s=selector1 header.b=UVXb5Ogw;
 spf=pass (google.com: domain of prvs=0333e70c0e=patrice.chotard@foss.st.com
 designates 185.132.182.106 as permitted sender)
 smtp.mailfrom="prvs=0333e70c0e=patrice.chotard@foss.st.com"; 
 dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=foss.st.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com.
 [185.132.182.106]) by mx.google.com with ESMTPS id
 e9e14a558f8ab-3ea4e64b39esi126473025ab.137.2025.08.25.23.51.04
 for <trini@konsulko.com>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Aug 2025 23:51:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of
 prvs=0333e70c0e=patrice.chotard@foss.st.com designates 185.132.182.106 as
 permitted sender) client-ip=185.132.182.106; 
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4PEE3013844;
 Tue, 26 Aug 2025 08:51:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=KacQYd32H6wGuvlsrhlV6f
 7XoOPUispVXrFoQszjdig=; b=UVXb5Ogwrbm47VZeN/BBANUQNhdjkVQMfVgjs1
 5p4uw2nJWobX4S1b7ze18+7JsOvgIgD8rrjhEe09xItnnqTeTKeI4B75EL1SaG8k
 cjYF+yi1En6j3T8mhre0+EHw/LFnJ7aGbXDN81gbhBGHD1EzeXP/PNV/qvz+gWEJ
 ehwJxAQvqOJaoplDq2nzTe1tbbxjR29zLb+gWExvAAD6APjfff/R00AVI7op9+Z5
 sWmAlh3/yGKQgVb6RahEBaxYtZFzw9bz64wqKfPDqIliyYMvVxPWWNuUS1tNXuaK
 QA2MuCVVIOTIk8/pybqWWv3Df9gQXaJCsRKwu6mGLiZuvO8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qq73yhtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 08:51:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 81BCA4002D;
 Tue, 26 Aug 2025 08:50:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC9B55AC2BF;
 Tue, 26 Aug 2025 08:50:19 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 26 Aug
 2025 08:50:19 +0200
Message-ID: <2235ea33-6eb6-4a04-9cf9-e4ee47f27dab@foss.st.com>
Date: Tue, 26 Aug 2025 08:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Subject: [PULL] Pull request for u-boot master / v2025.10 =
 u-boot-stm32-20250825
To: Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
CC: Christophe KERELLO <christophe.kerello@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
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

Hi Tom

Please pull the STM32 related patches for u-boot/master, v2025.10 = u-boot-stm32-20250825

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27466

Thanks
Patrice

The following changes since commit 7d879baa6f7ca201bcecff74f2a7545560289280:

  Merge branch 'u-boot-nand-23082025' of https://source.denx.de/u-boot/custodians/u-boot-nand-flash (2025-08-24 08:01:29 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250825

for you to fetch changes up to 198c48f2657e67ded7fc7679c2ed1c26227f9fdc:

  configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR (2025-08-25 16:54:53 +0200)

----------------------------------------------------------------
Enable OF_UPSTREAM_BUILD_VENDOR for stm32mp25_defconfig
Fix to avoid inifite loop in stm32_sdmmc2 driver
Populate oobavail field of nand_ecclayout in stm32_fmc2_nand driver

----------------------------------------------------------------
Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: set available OOB bytes per page
      mmc: stm32_sdmmc2: avoid infinite while loop

Patrice Chotard (1):
      configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR

 configs/stm32mp25_defconfig            |  2 ++
 drivers/mmc/stm32_sdmmc2.c             | 16 +++++++++++++++-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)
