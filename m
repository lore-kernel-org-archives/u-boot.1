Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EFFC36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD95C81D6A;
	Sat, 22 Mar 2025 03:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611797;
	bh=J52vn6Y/CrtIoX5LVCw7hD5f9gsIrNAttRna9CH1klo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZLOWMnymNgO+jQ/NVj3Y9l/Po4RE+r+zEZiaZ1M/EMg59vgRbFMakQs7H4TobBSeA
	 bWHGGrxh1xmBuLpD1eBTZN8paYY1QtcaTPDfpyd8iWiZsxEZhb3QNg/C0RwZP/LryU
	 jDRYrl5GylJB4GtyWk/SMgpwwfEggRMxT+WFAexEIDQNNZuTKmbVapWlMbLbo4TPGn
	 MXIRipmFlSbwOKRA5vNY+scfIBhHjh+Hy+CYMBjf/uPjdHBL0q3XkVfOkvFxJ/BVyu
	 vsvYIii0gEDYQQF04EJ9gn/FlUwlBgwkGr/uLRHsloqAdZH0nfz/W66R0B+dpV29fQ
	 Ar2Axt0KkHRgA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B10F281219; Sat, 22 Mar 2025 03:49:56 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8E5806FC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EXjlWu4U"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E5FD101E8F4B; Sat, 22 Mar 2025 03:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=J52vn6Y/CrtIoX5LVCw7hD5f9gsIrNAttRna9CH1klo=;
 b=EXjlWu4UrS/7gZj0HCkm7XuGTJJF3tRABPbFxiHk6x7JxBRDvXPfdDYkvv9ATOLvy/7rjj
 NIYmIQLpT7lg1jvTEREG9hsGyGmlkE4uE+OOZJlokp386UI/vDrdxGYi7kXvh76G98kpin
 ZBOXgeNVEmi8s0nF//5tsSefB+l5ea2yhUCXZP1rBb4S9CDMZu1lrDg6b9ZVjAUOk24RmQ
 wYMdnXn6iIsakcn0J/4fis5fwKVMhXn2cfI8v+i+czEqt1EIzGa1JfX5jiZwklR7blLsdf
 kHtRC0zxWFPpsuEPd5ZIQoohEwgBl0bA275HCl5W6wFStpImoOQPZ5J4Ae51rQ==
Message-ID: <1fc6938f-d132-4227-9198-45a581f00a84@denx.de>
Date: Sat, 22 Mar 2025 02:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/19] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-4-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-4-f2c8ba815f89@oss.nxp.com>
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI misc protocol is intended for miscellaneous functions which are
> device specific and are usually defined to access bit fields. It is i.MX
> specific. This patch adds SCMI misc protocol protocol_id and message_id
> for getting the ROM passover data.
Reviewed-by: Marek Vasut <marex@denx.de>
