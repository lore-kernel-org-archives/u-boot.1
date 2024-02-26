Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154D1C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB9587EEB;
	Mon, 26 Feb 2024 09:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937687;
	bh=15yIqdeiv9ZOo3Q90fgJcVbar4U3yL/skwRs+ZfrJKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wrkvIHGtF+4Xw/wgyZ2PnMkOmTeaxyckzDhVCIYJAmxOOF7VumsSPxMZWsmuZSxgE
	 UHke+y9njf8eTfDshz2vFrKV1iuyXM65gXcqUK2Yy2FdpiBwasafChpnVn1ihitzXX
	 R0EBrgQf3WXbd+QLVdonNzZuOe6q6XVzfZrHqpYBrDd49CqtDYkusLhNL4CXKITOqU
	 9O0CTaeWeYYcDwv2eC426TF8KdD2x63+5o6hFrPqglnrE536TMF0OSiiC4ffX6QUDU
	 Tj1i3b6qVff+BM85Gtt9VIGAPadvfeH6h2On2ySyLPgQ+2Ak1hh/5rwDBx+oYohqNT
	 8VczXHK98eBkA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B2D8087E9C;
 Mon, 26 Feb 2024 09:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937685;
 bh=15yIqdeiv9ZOo3Q90fgJcVbar4U3yL/skwRs+ZfrJKs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Nt4ngxHljJNS4+bPWe8XN+f3x1Z3ibro6ilt0M/Yr99icDhuGZdqGBs+QX/3wGx+X
 D0veGvqLe7wtEcR2y8Tr4xPvWg18TdE4I/P711nG29VdHVhGaNV43Bnh6TbP4o9YgI
 JJtlolNhQq7VGYKeYSIx9kiZUXKlB+QQQ4OA1he1qy/k1HS0PKW65ptEVGmUn4oQWH
 HYieH/R0oOdGOgLfHuM9J7XtHtvJ0aLTxAoi2KUGVz5yassq3NxzNRBfczUCZ/06gz
 eL0IoRwlmA2fxBK0VmEGXVP71XPfmIBKsqDM/AR5VwG1DukMR4Kjh78u1NqbZuy76A
 crty1eN/5VIpw==
Message-ID: <a7465eb8-1b04-4e72-8b21-8d8ffc8a41e6@denx.de>
Date: Mon, 26 Feb 2024 09:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] MAINTAINERS: Add entry for PCIe DWC IMX driver
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-9-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-9-sumit.garg@linaro.org>
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
> Add myself as maintainer for PCIe DWC IMX driver support.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Acked-by: Marek Vasut <marex@denx.de>

Thanks !
