Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF49DE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDF780634;
	Tue,  7 Jan 2025 12:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249119;
	bh=lB0fXS+cNMjQl8B32s4HasJNtIKNpZQ3GYZlDDhgag0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8rB7DU5npFXCVV50FBQ5xttRKV3r8WDniDbXvc7IicoK2nAGcL29JxdzohVKEc4u
	 BhRnDkmj+cwZ8XfJK9F7Jcq1oYEvt4A4pXbqTd0Jembez624T21J9OT2CsIImVBsCz
	 vAjl+NpF4gaUEkzPVS/4dMINXw4iTGwGDBfPrxy+sszpDYn+VXmHEsM7j1pjQfUA30
	 xG3jXvVz3SUzo7MuT7kYJTJMUJc5nE5B2X9Dl5fa/4lLfqa9tDnnQ9qs1XDPN3+ZRx
	 vqOrXqLt77LTUgZ+As1y0rQIidLrQuBt6ZoXzZToF3XkREnOCzDJmPskqPd5PZj5tV
	 fyl3EyRtqaK2A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF0680658; Tue,  7 Jan 2025 12:25:18 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6A0F805FB
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KuBOLdNk"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 428D5104811F3; Tue,  7 Jan 2025 12:25:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736249113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB0fXS+cNMjQl8B32s4HasJNtIKNpZQ3GYZlDDhgag0=;
 b=KuBOLdNkkLZY5zES5VvMOBR06+A+XVovk6/JYfnZgkA/grYOxVyDX/MeyiuJQYztb1KlPV
 y1U572JovDdvr70tCU9FehBiku9f5Mg0C65gEtTMtn2I+Vv4CNATi4kpMjVBv4Dc4ndGDB
 hFCYqBB/764LsOdEUfNECJlpFRhcO0Bjx7LRD2KOrZn70wRqe4MgbLXuk0FLQEHS3NqDUM
 AkE1t8kHmAz3Y2C/fxkJ6Eio9a7/8QlcgU90bbjeQSFoAA9DYIQbg9Z0aQt85RjTBBhPia
 WI8Yh0IgldXWJiy8VB38iM68RyT1hSlZ3aVbUU0eTH4Z11iz6XsOCLo68VrQBw==
Message-ID: <56167f2b-63f1-40aa-bb3d-26eb72cde729@denx.de>
Date: Tue, 7 Jan 2025 12:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAxMS8xN10gaW14?=
 =?UTF-8?Q?9=3A_scmi=3A_soc=3A_Override_h=5Fspl=5Fload=5Fread_with_trampolin?=
 =?UTF-8?Q?e_buffer?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
 <529cf75f-5e89-451d-acd4-942cfc91799b@denx.de>
 <PAXPR04MB9644460F64C5A3F04D4EFD92E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644460F64C5A3F04D4EFD92E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/7/25 11:04 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marex@denx.de>
>> 发送时间: 2025年1月6日 5:44
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Tom Rini
>> <trini@konsulko.com>; Stefano Babic <sbabic@denx.de>; Fabio Estevam
>> <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Lukasz
>> Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Simon
>> Glass <sjg@chromium.org>; Alper Nebi Yasak <alpernebiyasak@gmail.com>;
>> Alice Guo <alice.guo@nxp.com>
>> 抄送: u-boot@lists.denx.de; tharvey@gateworks.com; Ye Li <ye.li@nxp.com>;
>> Peng Fan <peng.fan@nxp.com>
>> 主题: [EXT] Re: [PATCH v3 11/17] imx9: scmi: soc: Override h_spl_load_read
>> with trampoline buffer
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>>
>>
>> On 1/3/25 7:45 AM, Alice Guo wrote:
>>> From: Ye Li <ye.li@nxp.com>
>>>
>>> When SPL loading image to secure region, for example, ATF and tee to
>>> DDR secure region. Because the USDHC controller is non-secure master,
>>> it can't access this region and will cause loading issue.
>>>
>>> So override h_spl_load_read to use a trampoline buffer in nonsecure
>>> region, then use CPU to copy the image from trampoline buffer to
>>> destination secure region.
>> Can the attacker intercept this and rewrite the soon-to-be-secure-only software
>> with something that would later allow them to take over the system ? For
>> example, could the attacker flip some secure-test bit in the TEE while it is in
>> non-secure DRAM and before it is copied in the secure location, and make TEE
>> accept privileged SMC operations from any unprivileged software ?
> 
> User can authenticate OP-TEE. When authentication succeeds, OP-TEE has not been modified.
Does this also affect U-Boot proper ?

If so, does U-Boot proper have to be signed too to avoid any possibility 
of tampering ?
