Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFE2C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 14:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F8E8767A;
	Mon, 11 Dec 2023 15:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702306113;
	bh=j0nUO5hi8gbAigYFtWe3/Ll4IymCvq9E+6377U5WtHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oK/GkYT6wMGehc85l/qU3lUIk0y9PZpuc3IM/7LBqFYIxGzQAQShFPVMRtNmMh4tu
	 cI5v6YuSouxJ4VU1r22k82DNiz1SlnM4Zy2eP9jGGmd22hlnAPNMzxv08pRDn+xR0j
	 URV2rYgBLAj2fGXxeSM20KlGLRqPmDPSsVQg6CfqiePRX/KLGL0FnP5OEsDidJ5+HN
	 dMSVxiGiF/2Oh/oAuop9az3+XJgL84cu5Qa3X8qPnloDzbxelvQYqf/r2cej1acreG
	 eS+0pDP9+OqJWMqSY+WsuaSe0ljwt6uGcCK0rRv9q0Bpt20YAPU4gDNmW9orRLZ1yk
	 0R65kxikz9rMQ==
Received: from mail.denx.de (unknown
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: festevam@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EECFC87073;
 Mon, 11 Dec 2023 15:48:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702306112;
 bh=j0nUO5hi8gbAigYFtWe3/Ll4IymCvq9E+6377U5WtHs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JDwnhg5ziDIrcTVQjtrhVQY97A4sApkaZOKUOJfV34nVEaUapAhl5gpzGR6Uv/+Km
 CZt+PXAsm0sJ5iDLF4TJAsoa3OspbnrpKs0wJ+d2pU5wJj/WMxY0sfFdZdt319Ndkl
 YTrFDFnlnU/9dgw/eFCB1JyxfTPdj2IPAfW/t9jFnvilhZKQf34iW56jj6DXyuv1u9
 Io6hjUqo5/QkeieQC+SDKB4BpNDmHK+yFYB572pQCR1MbUANVh5K+Wboexog5QViNX
 DW1aT/y5KodAr/gpYzxwFuD8Yzi//huHKBSx/j9B713Oie5VAw4sCzCgK7Mq3wqljb
 m89QT6lNgh0sA==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Mon, 11 Dec 2023 11:48:31 -0300
From: Fabio Estevam <festevam@denx.de>
To: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Cc: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] imx: imx-hab: Select SPL_DRIVERS_MISC in the SPL case
In-Reply-To: <CABqjNW-C3862iH0sLQxGnVBL3f4nhcasS4swMo-DSex2GGx8BA@mail.gmail.com>
References: <20231211134617.457471-1-festevam@gmail.com>
 <CABqjNW-C3862iH0sLQxGnVBL3f4nhcasS4swMo-DSex2GGx8BA@mail.gmail.com>
Message-ID: <b24495a2bd3ceb5ba744bc359312c10f@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
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

Hi Lisandro,

On 11/12/2023 11:45, Lisandro Pérez Meyer wrote:

> I actually tested this, so, should I reply with Reviewed-By?

Feel free to reply with your Tested-by tag.

Thanks
