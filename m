Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896C7E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 20:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D68E8060F;
	Mon,  6 Jan 2025 21:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736196686;
	bh=lz1GtFUUdG0saXhdzPd8b0/EfSTGRjCoxypmjBARxyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wHaQXIgthgVCLtwWIVadol6/CYHBLYqCzUFXRCHbDahGSGMZc3fDDZ8uZ/H103pKG
	 pYBz8N2Kq6MFolDlUyKvEnXmzKCIdlM4XOXzsPi4Ina0R4sb62NiuMOLQiKUApkGgt
	 5aCcs1jRvfR2XE16cEGHAAffB2gkY9nFmthYZO8gZ6A1X97rP8N4lcderTVhwGfny2
	 tBihhB0w41cxIQ9fWA2LepHtHncUZRQIPie0AbLjULltNUJ5yNsrNBCKYb3K3pSUlT
	 Md5GUyXptZDzOQv6FvydgXTy89FX8vY6O8OdsHo3nrAaXEWaf+AL13n5ZX96PuSxMk
	 Hk7kNYYj0tDSA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF6880609; Mon,  6 Jan 2025 21:51:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5EA805F7
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 21:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gfu1SWxr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BAC7710A4C6DC; Mon,  6 Jan 2025 21:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736196683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lz1GtFUUdG0saXhdzPd8b0/EfSTGRjCoxypmjBARxyo=;
 b=gfu1SWxrYvf04wKCELJkThLuCI/s2HwZsFJiP6xy+5XX7Muc4rnxAIDm6dX0boMRXe7eb+
 3ub2W7V/BHE1CIiT0sjwy0NtgchHoAA5sVKPxtq6GwiXb8nXgvK7nW3UFBvU/vy5O/T2NT
 GLgVHP6zqqKuLBHI5mZBRcnfJ7/bgI50G5+cVbLur5J/aAS0hfcApY9hhVS9ycmd+qiPs+
 h5/fs51JSblaNfl+MOI8A7i76TKU2kQxqP/j0m7KGIZnkcM4aCfYRf/SwdqlwKIgRBBqRq
 Q18t8nS23dpqHBzTPxZ7MLvIfnKSot5DFPYEQOgLvqS9ufhViH3qNJJ4qA6Isw==
Message-ID: <2f0d260e-d6ee-4b16-9b88-194643ae3d28@denx.de>
Date: Mon, 6 Jan 2025 21:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwOC8xN10gc2Nt?=
 =?UTF-8?Q?i=5Fprotocols=3A_update_struct_scmi=5Fbase=5Fdiscover=5Flist=5Fpr?=
 =?UTF-8?Q?otocols=5Fout?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-8-6744df5dc020@oss.nxp.com>
 <a563cb62-7922-4a68-a24c-534e583b7dcb@denx.de>
 <PAXPR04MB96444924697478EB9C2CE46CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96444924697478EB9C2CE46CE2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 1/6/25 11:41 AM, Alice Guo (OSS) wrote:
>>> @@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
>>>     * @status:         SCMI command status
>>>     * @num_protocols:  Number of SCMI protocols in @protocol
>>>     * @protocols:              Array of packed SCMI protocol ID's
>>> + *
>>> + * The number of elements of @protocols is specified by callee-side.
>>> + Currently,
>>> + * set it to 4 is enough for i.MX95.
>>>     */
>>>    struct scmi_base_discover_list_protocols_out {
>>>        s32 status;
>>>        u32 num_protocols;
>>> -     u32 protocols[3];
>>> +     u32 protocols[4];
>> Can this be made somehow future-proof? For example, figure out how many
>> protocols are supported, and then malloc this structure with the right size and
>> query again ?
> 
> Hi Marek,
> 
> Currently, 4 is enough. 10 protocols are defined in Arm® System Control and Management Interface Platform Design Document Version 3.2. I can make a new patch as you said in the future.
Or we can future-proof it to 10 right now. Are there any downsides of that ?
