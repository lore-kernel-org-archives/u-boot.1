Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686ABD41C06
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 12:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7D989565;
	Wed, 13 Nov 2024 13:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MB9zuqY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825918956F; Wed, 13 Nov 2024 13:47:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807FE8904C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 13:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731502037; x=1732106837; i=xypron.glpk@gmx.de;
 bh=1VEyqMDt9lRU0ukVpWsqc1lbqOIjs49kxlr/UXwAOJ0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MB9zuqY5bpt7flO7kYS2sct8INRrlwwzCrixvo3XzTMUxvuJ1DPAMjkXviDMqxhd
 xoGPAxymLPzjIQcJyYUSlS7QvzC72z5IC28F8oKG4yqXYlNoIODQsQNXyqr7dKS56
 tIRIFcwokhE2mov1Pb0koJqojwXJl0JywdWgia2gePjFTEwUDA9meSh+2kdJKS6S+
 ZS7jVrSvU0rvmi5GB5QMrI4QyAOR5Nxv35qrhXtSa1VJbWFZGdN1vCOVlVoyCOWO8
 lU69QQvlulktLOWxLTtH7+36S4hC5kb0Gz6EqWbqSW5LSb5G4tMvTmCr1zo/N3+nk
 iDDpgrbw7NmqiTbFfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1tLT6e1AU9-00QN2D; Wed, 13
 Nov 2024 13:47:17 +0100
Message-ID: <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
Date: Wed, 13 Nov 2024 13:47:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
To: Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pBUyr9NIPtxE4JurAKnnWqR/XlHgOUNgS+MkVW0Zq6XLYabo8cL
 UnYWs7KEIf9V5+VhWrlDA2wq9bpo3TLQuspiivMwze97LFcjKooWsVIkTQWJDGPT0ifvBsW
 1H9cKyHbaPOBlICJhsMPXlAj8U7MhCzewskMxaF5J8LYL28Nt5SyU97zRs3IH1dznioNxuF
 6tFlicUcg+H0/4p+oWS5A==
UI-OutboundReport: notjunk:1;M01:P0:Q/r2oWHgEQg=;K5/RCRgRZYmDV4XE/i6O5G78d1t
 oHRxumAh3z2zQ1ma98grP3ry+f7ryd/kIGDtLVRHBpRL5FTqysU+asaInY9SlVOiVrKLNgKIH
 Dgs/TOYlKgneDqy58WtPQD0DNiC2DwW/TEVmeBwunZ1MUlf+yY2RSUmUH9E3ETsibZXFZTn2U
 xJ6bAS2/qpGwPlIjYMQ4Cuq3mlWG0pFzbu+uPRoHx1x3mKqBjmDW2pFm6TTAp/pC0SSC0nhjw
 qy8Db+yLOW7HznSl57m/kL7/j3sSfVgY+Kpcbf1EJWGNn0WXPdq/6EzRxKmJfjapmkSKFwUFq
 UEyLJCtyD+fHHcIwGWDqFK3bs567C8PF29eiSki/ND+O02ljNAgp/7f0ahu1D06pIqZO55Y73
 rorE8861EcDchP629q5t5dTqz6mMFj8VBI5hQQbEdoQ4hDqg6sIuCeQJQBqTeBbM6o920Jtm8
 BNC6dvsGamQw2kc7Bc7Ou8KByuAMmNAmO4Qz0VJNVpA9YxdhKA5FqXm/CTydVVZEURjqr+KiS
 8pxCr6ReAorJ92dLpbmBuqXCF+Z7xLLbaoHX3UTbuAtQTUbyj2TnTXTX5Kom6bvUQSIN/YA0q
 LBEYx+sdVMj4TIqcu8PKFXLTC/j3Noh0zHGSfIq6B0qFkgvf/YmojpryozGTifgKVUnvwy3B4
 0rLGy0z2t1ehKDwN08MzQKaxbsCkQZaz9dJzrc9WSfLhGJhkivAXtYj35kuSgzegFga+OVrx9
 NiDD06GpLZiuaJ26hVW4K/ZJOarxxqQoyJzY70ikA1uWfDgDCMi4NYGtNs9qC0AlPYb1pcwKX
 Wxg+eo0ab2+vSoSztMUyapZ/xKhbIwBCEu0cbreO5dl2ZCTU9Y645PiytFP1ha46pTu6zaD62
 f9X3jCurMJ7USxq16nxFWQa4D8ddIJWT30XN/gZhDyDjqNqCCFG+xCSEF
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

On 11/1/24 21:29, Mark Kettenis wrote:
>> From: Janne Grunau <j@jannau.net>
>> Date: Thu, 31 Oct 2024 23:48:02 +0100
>>
>> DM_FLAG_VITAL marks devices which are essential for the operation of
>> other devices. Removing these devices before their users can result in
>> hangs or crashes.
>> This potentially fixes EFI boot of Renesas rcar3 devices. Their clock
>> devices (and with this series the dart iommu) are the only devices
>> markes as vital.
>> The arm boot code already handles devioce removal in this way.
>
> There is a typo in that last sentence of the commit message (devioce).
> Otherwise:
>
>> Signed-off-by: Janne Grunau <j@jannau.net>
>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
>
>> ---
>>   lib/efi_loader/efi_boottime.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottim=
e.c
>> index 4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a=
8ee86b1804cd848b6 100644
>> --- a/lib/efi_loader/efi_boottime.c
>> +++ b/lib/efi_loader/efi_boottime.c
>> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI efi_exit_boot_services=
(efi_handle_t image_handle,
>>   		if (IS_ENABLED(CONFIG_USB_DEVICE))
>>   			udc_disconnect();
>>   		board_quiesce_devices();
>> +		dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
>>   		dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);

Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") addressed
the same issue for bootm on arm. But what about about other architectures?

This logic should be moved to drivers/core/root.c instead of replicating
code.

Best regards

Heinrich

>>   	}
>>
>>
>> --
>> 2.47.0
>>
>>

