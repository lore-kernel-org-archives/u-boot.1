Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A89DC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 15:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A67D885B6;
	Fri, 26 Jul 2024 17:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722006411;
	bh=Ne3VurO2+US59sNojXonzv42CRIkmcTypL2IaXMVZOg=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulRapYny5w3nTLx7OKzpRgXt/w64HT5LGe+nUDkqMdu63Iu2kNfEvi8HI/HlCe64B
	 ru40tFoSyGAMBtHPORJg8dmmXeTY39xA50ja8FwOFuOvCPqpMPs/KLYdyWmY+cGE5M
	 68nP3YOh/Q4o8EimQKsWCCw49CFqOY6Ozf3p5I3fWTvx7dshZKr/iDsNz0ihS0Tjzr
	 WxdJa6EwkncbbkaA9I0vJO+4BLRfsbLbi87il+q2lOycypuj3XX1ukPcCp1fLonWcg
	 nJgw/CL6fsj+ce8fwA5eIsupzUonIeA0taHhYUr0KMi5GUqCphyB2PIsD6UXblaWPj
	 O5uMXg5qMfnqQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E012C885A8;
 Fri, 26 Jul 2024 17:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722006410;
 bh=Ne3VurO2+US59sNojXonzv42CRIkmcTypL2IaXMVZOg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=cEECIYAjvOWOSsO85VvsiWKZfgo4oY0/Ns63+xazft8v8OHuZekZAPttNDIF04R4D
 m3onJH5ZwPk3mgemWf9oBC1kzTsZyXUQGiwWyyLnMx7yd6BJYitHwESkYzOwcuwSkW
 B+bAy/qePaBxXAt0goSiDBLMNUKdzR+/nuJB0epMPd5dJwL3BfIM2TflhLTxZP6ZpX
 GKJ0Y4fX5AF/GoMYIPlXZ78rw7CH1LyLVb4tPFG1ew9Gjv8IOUXw6DupZSpV+9RlCE
 EFk9GUDlltFzUb5Dee6tOaTtooeZidxxTwTn9rApMDp/7bA5MBxYZKueEvnL6AlOrL
 nvqca0klHFYNg==
Message-ID: <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
Date: Fri, 26 Jul 2024 16:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] clk: imx8m: register ARM A53 core clock
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, u-boot@lists.denx.de,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, festevam@gmail.com,
 peng.fan@nxp.com
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
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

On 7/26/24 12:29 PM, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Register ARM A53 core clock for i.MX 8M Mini, Nano and Plus.

Why is MX8M(Q) not included here ?
