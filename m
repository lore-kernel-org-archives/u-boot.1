Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAF5C5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5A4940A61;
	Fri,  7 Aug 2026 12:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDU1ZJZKrlT6; Fri,  7 Aug 2026 12:44:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3337F40A40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786106697;
	bh=Hz+JhyhblMhhNF5NcovKMdPpstRXwOY3Q2dX92vZtss=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=J8dktFm2FG4QfafjaWmAgN2HUZID0vNfFiSb7vFQpzlZm4/YJqvIf4IrKcL0du/uR
	 5BV2nGuskySMBkoFxdeMTUGZ3D4f7c7NjHX/LOQlZWF72WVrvb8AsDoEuM5j80/I1/
	 GBQdWqQIqw6vk7ZIK3SYF92fZ6epPNIhfgI6Ih82NCtCrQmVRS0XlH8AfARNdBZ2oK
	 K5256TbCYTRVYEf03D5jU8aEABNn7gLP+cVLBAaviWqh5efciN4dtsuSZA5dQv8av6
	 /0uxITQEjwlP4nEpwGSJAs/MPiTUuf8iVuUNTX8INxzpIYZK51FjCgngtturfcoQir
	 CaXH/nvamJnWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3337F40A40;
	Fri,  7 Aug 2026 12:44:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C6E7259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E9BF40105
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thImlnoB4_HJ for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C692140092
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C692140092
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C692140092
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:44:53 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hGkPY1fDFzMlM3;
 Fri, 07 Aug 2026 14:44:49 +0200 (CEST)
Message-ID: <3f7a1715-0223-423f-a752-40cd82035d65@mailbox.org>
Date: Fri, 7 Aug 2026 14:44:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/3] usb: mtu3: add SPL gadget support
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Julien Masson <jmasson@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>
References: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
 <20260806-ccaione-upstream-mtu3-spl-gadget-v6-3-66e133a4bf1a@baylibre.com>
 <67436bcb-45d0-4cd2-b6fd-6b85633532cc@mailbox.org>
 <DKIN1TO1WZJK.3M819O4VFHXX9@baylibre.com>
Content-Language: en-US
In-Reply-To: <DKIN1TO1WZJK.3M819O4VFHXX9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6tf1t1no1ci186k9x97cwapdwrt6ma5r
X-MBO-RS-ID: 9580a9007c99ccd6fd2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786106689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz+JhyhblMhhNF5NcovKMdPpstRXwOY3Q2dX92vZtss=;
 b=PifaR9xc4svdx5kjRdI2DBpiLMVbli+UZVIlRxVNzn0L1ZlXqolCo+boz2TCwWQ8K/T9xr
 OlQkpgirUTf+E9WzMdzynKbkKHZrSS09gfuWK/v7Sp+cJ0DvSutK4SkVPDVNNhjibbTprB
 d5rGkhKBPvJOsrau8O5fofQTAYlJRyFl77j4E4pHvBSOMLz2sA4byNZLy2vadsZn04OyeM
 BeONNph3FbombJfOVoVcZSrOU9e36Y3aS/CFurAox8O+HO1/1ooTeqeVLgRFAKWer3gGYu
 vfQNwyDeZ0ARfzYJce1aOIYvbSQdhBj7FK0bAc5Q7U2Xl09tPniDdBTvNpso2w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PifaR9xc
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/7/26 12:27 PM, Carlo Caione wrote:
> On Thu Aug 6, 2026 at 8:05 PM CEST, Marek Vasut wrote:
>> On 8/6/26 2:54 PM, Carlo Caione wrote:
>>
>> [...]
>>
>>> +++ b/drivers/usb/mtu3/Kconfig
>>> @@ -42,3 +42,23 @@ config USB_MTU3_DEBUG
>>>    	  Say Y here to enable debugging messages in the MTU3 Driver.
>>>    
>>>    endif
>>> +
>>> +config SPL_USB_MTU3
>>> +	bool "MediaTek USB3 controller support in SPL"
>>> +	depends on ARCH_MEDIATEK
>>> +	depends on SPL_DM_USB_GADGET && SPL_USB_GADGET
>>> +	help
>>> +	  Enable the MediaTek USB3 controller in SPL. The SPL driver currently
>>> +	  supports peripheral mode only.
>>> +
>>> +if SPL_USB_MTU3
>>> +
>>> +config SPL_USB_MTU3_GADGET
>>> +	bool "Gadget mode in SPL"
>>> +	default y
>>> +	select USB_GADGET_DUALSPEED
>>> +	help
>>> +	  Enable the MTU3 peripheral controller in SPL so USB gadget
>>> +	  functions can use it before U-Boot proper starts.
>>
>> HOST seems to be missing here ?
> 
> Damn it, that was lost during the patch splitting. Thanks for spotting
> that, shame on me.
> 
> v7 coming, cheers.
Thank you !
