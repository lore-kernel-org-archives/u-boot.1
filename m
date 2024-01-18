Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36C4C47DB7
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 19:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F0787BCD;
	Thu, 18 Jan 2024 20:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705604936;
	bh=DlISOtvAVcA27qJtvubx+iLyS98p0kQwRwBnDqkTJko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=enj08hTmiH+QduNqR3CRPxj46H/ZvL7D5yPa6nQI4etN1evAGZ8wkqy1fCPka3htQ
	 Jp/zcyNyGPj6VbgwO3BxbQiD6zvfhZnVdVo6kkZArju705bNkdss3fXiFDrcAvMKwz
	 YC63oxwdVAVTvKlujZgWWPIypf5YtNjJwVAJcTGqD2H/cM4y/TnHAP+xz22/Fsyd7c
	 UWAu2sf1/6zNIFA4Y8Ek2xKa/TGaivotuLLuB2e7TdGIk8dlimmt6TOSDLBfMHQ0is
	 Hyh3p3Erbic7UHnsICSwqZUixSo+i6FqS8V+e5p86uE+vcvPfjocsNIeOARtJ0cGAv
	 FVZty8+mf7spA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 85EB487B52;
 Thu, 18 Jan 2024 20:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705604935;
 bh=DlISOtvAVcA27qJtvubx+iLyS98p0kQwRwBnDqkTJko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NhMr1oPqum7488Yqs5kCPMoCd+Xe/Ad7SaueoVRk3MBbhPBESTuWVZtWK3t2+pAbq
 CgOGN7FevjjXfQa68n4Z11QjzQvpYNePc8IQ5u3DhCWq3sIoexh4klQ94qkMljgPmJ
 xaoSt0prrOW8uEWPpGSXaF0DVRI6ArMDU0o/v00b4L8MQTBZ9+rwzH4cDwmFWfN++P
 si09FvRwT3XxjtbCgvh50a/Pg55IruvLsX6C/RVOApDjxlRDjoglvoArsaWIB13GdT
 4mMt19bcMEKnIT8zsIA58XgPVDsBYP+OrYYvlDSC/XKDSPR9lsLtrIwbEU1gVEF0yg
 EYhVaGjTYNfIA==
Message-ID: <ba5f6816-1911-4c7f-a9ca-714e2ab66536@denx.de>
Date: Thu, 18 Jan 2024 19:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: imx: imx8m: Enable the SError exception
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: uboot-imx@nxp.com, thomas.schaefer@kontron.com, u-boot@lists.denx.de,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20240118150640.3802089-1-festevam@gmail.com>
 <20240118150640.3802089-2-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240118150640.3802089-2-festevam@gmail.com>
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

On 1/18/24 16:06, Fabio Estevam wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> To work with commit 2f3c92060dcd ("imx8m: workaround ROM serror")
> we need to enable the SError exception and install vector in SPL.

This really does need better commit message, sorry.

Details, please.

What does trigger the SError ?
