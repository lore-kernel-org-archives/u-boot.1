Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883CFCA1009
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 18:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C9088D0F;
	Fri, 30 Aug 2024 20:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725043876;
	bh=oDiJOghJkwFh5X9BJq5w0A2qzviMEbWDcqPIvOqupO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zY0w3Z5NYv23O5shMcAMHCyG+K7bN0MQ2j3rsck0t6ulksgMk8EF688ce8MVuqsFr
	 J9MKEERrndweY4JYVisNyFAmE4xPGZEPkxN3Qenk67qJWrtJCj9R5I4dHJV5NGGa9r
	 Z4TIh/soKR9gsZh8mZkYb289WUR/txWukFXU6z5r9k3nKm4IfnkCR6VbiQCRGsgx8n
	 jdTANhw00NzXnXOAdCNPZNRarY8fCfECmCsHG7n1ECIsmM83E+lrXnrvmUmJUYpTDf
	 WDjv/BPZK+nYXaMIRxeR719ufpuWpw0Nr9xfTfP3/8bzfamHJVp07VB7hB72Z1TFqs
	 cU3nuZApXwN1A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 01A0F88CC9;
 Fri, 30 Aug 2024 20:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725043874;
 bh=oDiJOghJkwFh5X9BJq5w0A2qzviMEbWDcqPIvOqupO4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NcSIMJdNmweSx9bgO/TH7yF1ml4hbcwTekCYcMH9yzsUEWxBsdLlUIEjY5ZU+h3ly
 flMCN1fhArET4gefm0CmewWC/b0izzNrRqCbcpzCrwl7mySnCrEW0RXuFcJJswXNQx
 cJMH8lKXGbzgo1I0QnVgi8zaxsvFY80NDatXKBVRuiZnlE2ZSWyklCJgZL7KLQXEKY
 /JkeEkEkqBOOqsTxPk2l3CcomZx50SoywYFKqyhtMH0PCC4XRze4DIBnPQ9sMN9/Uj
 fa8btqBEOAZHBxGTBsKGCIU1zbD0kjUHMQMozFXCl1ruPU+dMoKf5k8d0SiWen+II9
 0cQsbgCBZQ72g==
Message-ID: <b47a2e58-7df2-4c4b-b0b6-0020a79780fa@denx.de>
Date: Fri, 30 Aug 2024 20:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] imx: Remove CFG_MXC_USB_PORTSC
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
References: <20240828132529.3098961-1-festevam@gmail.com>
 <20240828132529.3098961-4-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240828132529.3098961-4-festevam@gmail.com>
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

On 8/28/24 3:25 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The definition of CFG_MXC_USB_PORTSC as (PORT_PTS_UTMI | PORT_PTS_PTW)
> can be removed from mx5/mx6/mx7/mx8m board config files as it is the
> default in drivers/usb/host/ehci-mx5.c and drivers/usb/host/ehci-mx6.c.
> 
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Marek Vasut <marex@denx.de>
