Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB63EC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFA787E3A;
	Mon, 26 Feb 2024 09:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937677;
	bh=aJLA6B0Ix9eIiWYXzNOfA7BzAXFFI052X3e7fIbh/FQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLlV8Vx+naWW9S18u/eBBWP3pP8RQUEdD9xKqfkXi1Pn8I29wxweCK9OCNcninKAq
	 +aNtfWzQBNlQIhAJTy5KnxpjOcCddAxbvLpx3LcfhdSI6Oiii6YT/VcS8kHLTDnpkB
	 3dKt6KxLYRKw78TYYq6BDztYV8q7RaTbQPjH8dF9IRRfFeVrUQYqEl8RvvuD/KqRb0
	 j+uPvUwKeE5E99PyRX15AQGfECf6N5gNZPJiy4ICN5wI/LnGpd53uyctgBYJpvpMm7
	 4kkmZrXZfX444UarhQkCLoQ9qrryEzrWLYxqIxetnQLFZILaeDdvMcJieb+S2uuYu9
	 NRF1tU4vreAFw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B109687DAF;
 Mon, 26 Feb 2024 09:54:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937675;
 bh=aJLA6B0Ix9eIiWYXzNOfA7BzAXFFI052X3e7fIbh/FQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QpBK/tumORcfnC/xuCZxTLJxUlEH+48N6oNMT4WJ/MoV6LZAN6GS2jY82dtL1BWkI
 Jq/k79WnUG1CkyTxuH1RbIKaTX+9e85t4dGj7G3KQOxlQPeX41LmZL6RXgG4hyPADn
 wREpf2HAnEGaMsDSs+It4gjsXXQxGHGgDLHdCCO3aOo67/Tbxspv3nzIhMI5c0Bp7u
 pzM5x+XSx/AVqQwIJdLxFH8q+M54k//qu/DVKeEcxbL14OzzPsWSdhn837+ROdmKbS
 hIOn2N/pZe/mipITG96HZprajvmiX4/ILOD2a2pIDzjgk0uRK/tjIVI6X3+0EeNLOB
 HtUCs9zr2JaIg==
Message-ID: <266b30c1-6cfc-4a8a-adef-ec2fe7d9fa4c@denx.de>
Date: Mon, 26 Feb 2024 09:28:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] clk: imx8mp: Add support for PCIe clocks
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-2-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-2-sumit.garg@linaro.org>
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

On 2/26/24 9:04 AM, Sumit Garg wrote:
> Pre-requisite to enable PCIe support on iMX8MP SoC.

Commit message needs fixing.
