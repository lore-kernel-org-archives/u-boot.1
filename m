Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D653FCA100C
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 18:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB7188CC9;
	Fri, 30 Aug 2024 20:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725043875;
	bh=AWvqaNxdEL2UQ3b19RLy0Ci2lKjHmYShIj14jNI3upY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PeHLAJHoZ5HZOzp1Nc91US8HMbzsHb4vnXnjm53+AuMDSWpLA0U+hwihyuAq2DJsK
	 TskxnO+Hz14Un776UyutoBbJeZyEYBFZ6agroAnfrCLdtaWOsym9QDu8th9F5fhA33
	 lo6Vad/ifzGtDqJrJIzhGBNgo5bUgoh8B8KIW+n2q3DQYhmZMMtwuyaUWOKcQxLF85
	 bD0LeHyoQ8fBiUiWkGtR3hc0eCVU80kni1ES71FclUXGeoE0657ftfJGwpwVQq9syN
	 cy7vdHbERqJtRWuCcxeXYTlDvujyx11XWgl7U8j+whqOKdKlgwGB33vjS/LjTfZLWT
	 zyv5AZ13N/hRA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B6B6C88A58;
 Fri, 30 Aug 2024 20:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725043873;
 bh=AWvqaNxdEL2UQ3b19RLy0Ci2lKjHmYShIj14jNI3upY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZcL3paw++c3sisBEgC+ZnuKVAwtdntphdFdXXDUzGqYACv93C3OjCtwbwQkIcpTKV
 PWYJEq42/FWJgobY6rfoUPPwndGEEC2A15hl4Nn28s1jj2uTSwqeZgkqzzwpAOQM4n
 Qan1nzZxsgA1Gzt40uqeoLoQBhxF56YH45SmC/laBQOkJW17aMFnQR0bseM3A19N+i
 9P4Ci0zYHqE7H5qK0Ihtwhcw4qoMglDTUpwkZIVE5z6JGNSiJhKiyOePQ2FsLm75I8
 zMov6vggdGv37pb9vkdbA4UHdMutHGU0I0XStAMUPThvxgbmmaYvRCF7gzeGkki0WH
 XUw7o910dPXLA==
Message-ID: <bdb55e88-c5ae-4329-a750-b81a66a94bc7@denx.de>
Date: Fri, 30 Aug 2024 20:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
References: <20240828132529.3098961-1-festevam@gmail.com>
 <20240828132529.3098961-2-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240828132529.3098961-2-festevam@gmail.com>
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
> Just like drivers/usb/host/ehci-mx6.c, add a default for
> drivers/usb/host/ehci-mx5.c.
> 
> The motivation for doing this is to remove CFG_MXC_USB_PORTSC
> from board config files.
> 
> All the mx5 boards, with the exeption of mx51evk, define
> CFG_MXC_USB_PORTSC as:
> 
>   #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
> 
> So move this definition as a default into ehci-mx5.c.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>
