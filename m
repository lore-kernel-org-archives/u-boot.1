Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A625EC47DD9
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 21:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1720987CB1;
	Sun, 24 Mar 2024 22:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711315538;
	bh=gn4LDFKqcd5sJsePvgc7Bwu5wen77SFDmH5FYelFV00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=arZOIAgyBc3Mne6sC8Ec9nbjdquqMVe+02xXiSKOEMEaMYhjVDNTMxEQN5vOCLq8r
	 4Q6rhpvAaVGkqETN5bqiuQrWL1NfSskzSPz35LGc1MUth9T6LueqCUOhKgtf59ENHj
	 9Slb+sWq40kV1KevG/pZuoJ6W+zUX/ru+Z3BRz9uSk3fT0vli9/o1m1fPSylJTFE3K
	 rCLK4tYARuXeS8+DnNt6051egUHVv7U5oRJnjA5xSVdokog43hO5RgefGDqN+6dsO4
	 OOLwJ3TRfq0HvdpoITX2inj7TU+rzpIQKTg0vfF78ZInmW2sjVfJ3VXMlKOyTSFYqG
	 eqhIjthnGPj4Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 131C18718A;
 Sun, 24 Mar 2024 22:25:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711315537;
 bh=gn4LDFKqcd5sJsePvgc7Bwu5wen77SFDmH5FYelFV00=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nXaRYViHex4KWdeL/hLbNSHlJ12Qch8nov8XlgmknnohKtJDsedJN6+K047oOLY9b
 Kr1+z8K/tu2jJDlZRUPpTG6tvweXAJle6NiCTq/K8YRrndQrQWLfeYf5ASc9cYOFEL
 AOrRgyen9YgyJATHVQjbS3SMNu6eIjvSwAFPG2d9PeDZObZYmq7SHGvHIxdNxGyzZL
 5Hk/SODYnDeTPo8ChPbXU5xBECS2Ajx0A6Swq13ck7Yyz8cXJrZ8Vi5JFC4V7TXID7
 WcEb8Sh9VoK0yv6pzb8+cMDq2iU6XGfI3nBgvNsoTfhvTBUtKA6eTRYMRdwM+ZShW8
 XOJ81GALR/EAg==
Message-ID: <2af5e746-9591-4774-a7bd-94d1390831ef@denx.de>
Date: Sun, 24 Mar 2024 22:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] configs: imx93-phyboard-segin: Add USB support
To: Fabio Estevam <festevam@gmail.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, u-boot@lists.denx.de
References: <20240321144541.15314-1-othacehe@gnu.org>
 <20240321144541.15314-3-othacehe@gnu.org>
 <dec314ce-d83a-4549-a2d6-f5604107bca5@denx.de>
 <CAOMZO5AOv9Cmdpmji-y+YO9GvkMTHmh2d+RxmVksMLgj-23rqQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5AOv9Cmdpmji-y+YO9GvkMTHmh2d+RxmVksMLgj-23rqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/24/24 7:00 PM, Fabio Estevam wrote:
> On Thu, Mar 21, 2024 at 4:17 PM Marek Vasut <marex@denx.de> wrote:
> 
>> $ git grep -i usb.*phytec configs
>> configs/phycore_pcl063_defconfig:CONFIG_USB_GADGET_MANUFACTURER="Phytec"
>> configs/phycore_pcl063_ull_defconfig:CONFIG_USB_GADGET_MANUFACTURER="Phytec"
>>
>> It would be good to be consistent.
>>
>> Also, what is the vendor/product number those two boards use ?
> 
> They both use:
> 
> CONFIG_USB_GADGET_VENDOR_NUM=0x01b67

USB VID is 16bit number, the nubmer above is 20bit , drop the leading 
zero while at it.
