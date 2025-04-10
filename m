Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F86CC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 18:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE2583DDF;
	Thu, 10 Apr 2025 20:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744309465;
	bh=eKXnzRQaOFPrGPyxJBmvpcD8JNxJ+OJiFx7ZswhWKOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yQ2tfWz2yeOwS+8QHeA/1EahE4UExg1lxZ8LJvdI/K0S/zs43Qf9JJiHkX9i6/HVc
	 v2RUn6dfoPG0QfpN7zgI26hSc3BGTCWUMuYNETifYw5AOpvwq8zyNb2qIcmX1Ile44
	 cY7jBNhTgV/JS+w6x0B4jai4vgIadNR9jMqUd0SDdXLzy0ZYx6HEZHE5Ibrg6STMXv
	 tZyYwk2+xJLEIm1FKZ3m91ltQ0evve6SSLC5mKf4belAuEgO07QG9hAS7HUpIg+6MP
	 KRvUNWFKvnxIs1HCsSJqJuJALZber0QzjspOY/olXcVimAuQ9qXNx2sodxUeTZiHPe
	 nIw8mOIt4PTew==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D60F83DEA; Thu, 10 Apr 2025 20:24:24 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E40E83D92
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 20:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YvxVM9sj"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4613D103B92D7; 
 Thu, 10 Apr 2025 20:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744309460; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=eKXnzRQaOFPrGPyxJBmvpcD8JNxJ+OJiFx7ZswhWKOQ=;
 b=YvxVM9sjyuKN2BoI8oV/MGBWG0wOA1JoH8uMwoXQLAoD0p54UJyUzURWmT8cQMibMVEAJ+
 h7y+ou560jyo7HL9K8PDmdxGjVO04qt30ZouFW1JE8ltOj/1APSRKvFwsH/KTDh7hatcUx
 fr4CdRhgINgJVHbbtMlTjrfEI8kx51izg699YsVG+HpPVU1TM8TB6mnjsvxkIi9U2pcN6a
 3CNtfynXSgA7Ex5QLteMN8kQtCOfcpFr5pMD5pHfn8cbmZtHzBzQZRczBNCD9td++hEbVE
 LYclJFSrcuZgXayh6z86hr3F9d4JFL19mm7Ne6GVzqVWvO71BOy6Ku4+NH1r2A==
Message-ID: <746f7719-3e93-47b9-953d-781009e94524@denx.de>
Date: Thu, 10 Apr 2025 19:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: r8152: add device id of Linksys USB3GIGV1
To: Gabor Juhos <j4g8y7@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250331-usb3gigv1-v1-1-04374174fab9@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250331-usb3gigv1-v1-1-04374174fab9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/31/25 5:06 PM, Gabor Juhos wrote:
> The Linksys USB3GIGV1 device is a USB 3.0 Wired Gigabit Adapter
> supporting 10/100/1000 Mbits/sec transfer rates. It is based on
> RTL8153 and it works correctly with the r8152 driver:
> 
>    uDPU>> usb start
>    starting USB...
>    Bus usb@58000: Register 2000104 NbrPorts 2
>    Starting the controller
>    USB XHCI 1.00
>    scanning bus usb@58000 for devices... 2 USB Device(s) found
>           scanning usb for storage devices... 0 Storage Device(s) found
>    uDPU>> usb info 1
>    config for device 1
>    2: Vendor specific,  USB Revision 2.10
>     - Linksys Linksys USB3GIGV1 000001000000
>     - Class: (from Interface) Vendor specific
>     - PacketSize: 64  Configurations: 2
>     - Vendor: 0x13b1  Product 0x0041 Version 48.0
>       Configuration: 1
>       - Interfaces: 1 Bus Powered Remote Wakeup 180mA
>         Interface: 0
>         - Alternate Setting 0, Endpoints: 3
>         - Class Vendor specific
>         - Endpoint 1 In Bulk MaxPacket 512
>         - Endpoint 2 Out Bulk MaxPacket 512
>         - Endpoint 3 In Interrupt MaxPacket 2 Interval 8ms
> 
>    uDPU>> dm tree usb@58000
>     Class     Seq    Probed  Driver                Name
>    -----------------------------------------------------------
>     usb           0  [ + ]   xhci_mvebu            usb@58000
>     usb_hub       0  [ + ]   usb_hub               `-- usb_hub
>     ethernet      2  [ + ]   r8152_eth                 `-- r8152_eth
>     bootdev       3  [   ]   eth_bootdev                   `-- r8152_eth.bootdev
>    uDPU>> setenv ethact r8152_eth
>    uDPU>> setenv serverip 192.168.1.253
>    uDPU>> setenv ipaddr 192.168.1.1
>    uDPU>> ping 192.168.1.253
>    Using r8152_eth device
>    host 192.168.1.253 is alive
>    uDPU>> tftpboot 0x10000000 random.bin
>    Using r8152_eth device
>    TFTP from server 192.168.1.253; our IP address is 192.168.1.1
>    Filename 'random.bin'.
>    Load address: 0x10000000
>    Loading: #################################################################
>    	 #################################################################
>    	 #################################################################
>    	 #################################################################
>    	 #################################################################
>    	 #################################################################
>    	 #################################################################
>    	 #################################################################
>    	 ####################################################
>    	 6.3 MiB/s
>    done
>    Bytes transferred = 8388608 (800000 hex)
>    uDPU>>
> 
> Add the USB id of the device to the driver to allow using it
> from U-Boot.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
