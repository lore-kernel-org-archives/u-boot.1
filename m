Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9173C04FF8
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DAA28869D;
	Thu, 18 Apr 2024 20:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713464047;
	bh=P7Fo5/0qToOkHobsxUMLLAzbf37rRcQ3HvzdeUjJ50M=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hOGMUyi5ETBC+kUyJPu0+oFzvA5sETnebyACwqiowSAC9uUkPea5rJLNJ1Z9gsqnV
	 Ncbvgivlcnpk7mYrwlynnk76SZqXtpkp4k3UIuGnHDecxRxuMGK5k3tqppLgCcptvl
	 UuLrdGg30zzE25Mm7BO5slyWDEdY4tQUE4w9jj5Aiqisl07sTlhhQLeXLGPg2EbC/0
	 nDchUGBNuCJvDPX9ud7LuVgMTLt/nwWy7f2A2CKrm1va3tIQvqzpzJw4RIMJgrVV8P
	 SB+j1tE9LrjGzCgtc9O3GqPHkkqTZD2tuvre1t0XIaYnAQqAYHziS3MnRLLZOLZub6
	 UY4MCVGNIS7HQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CD00488679;
 Thu, 18 Apr 2024 20:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713464045;
 bh=P7Fo5/0qToOkHobsxUMLLAzbf37rRcQ3HvzdeUjJ50M=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=AwU4Gi+wRkVesBLyEN/iZOlnpVKuxfaA07ZEKrZTzKM7l2qv5Ebxwp05W+h6tg75y
 eDBvnkMOaHX7/uuXMrULLtfEyNSX7i5rY4A5af+vUTsYfpmSi7laUGi64S/Px59dk/
 vdWERbwOIiY3Pdm981REkH4pOAkk4z9IQJM/asXxPtkPo1ac9XJ3ErUHPoqlxhQr/T
 BX3AVm6t+1//9M3k65ZkaU/9Q9h3y+g8sFWCgnp4+X4mCjIslCXhY5bYv3do2s1AKw
 HdA7Lt24eK/6tfdp3QGWrrB6Rd7dp0LDjT/tEHnSC1E8TTH6jArPMiEHJoLYsHVivw
 3wPK2lRbks3ww==
Message-ID: <40d7c542-a365-4100-8bfc-899aefbf13c5@denx.de>
Date: Thu, 18 Apr 2024 20:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pci: dw_imx: add support for IMX8MM
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Fabio Estevam <festevam@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240418175612.4068609-1-tharvey@gateworks.com>
 <20240418175612.4068609-2-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240418175612.4068609-2-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/18/24 7:56 PM, Tim Harvey wrote:
> Add support for the IMX8MM SoC by adding driver data with the compatible
> string of the GPR controller.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Marek Vasut <marex@denx.de>
