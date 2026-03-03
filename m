Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83128EC1458
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA72783E7F;
	Tue,  3 Mar 2026 15:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n0u/oyuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6EE83F59; Tue,  3 Mar 2026 15:13:35 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD207839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fQHpL4LVYz9sbX;
 Tue,  3 Mar 2026 15:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772547210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bPLlWf7EYaAr4Mhpszps9qu0xe3Ut5s8nfM05c1SiQ=;
 b=n0u/oyuU3KgU8RL7xS0SpnXEKOmvAlv05NQZbxQrPUoCeWgciNbTWaAuWIq/YbAzbK88t4
 z6qXnEWosDENpzb8DlXX9o53znPyBIO3oRaT+ZtvSj3exxGGoHP0ykjcl/1nhdVFyuVnUN
 HBFbdxPwgtSClFrVyyNnt4yDMKwW8yO/Zg28xr5Z2d4inJU8nHmg8doWEX423GvAl9FaF+
 xj8P4Ecu0UCPQwSKOOEOY7t++FvA2yj/CH6W5p2tSgxyvBsf5fvr9qlfSP9igvhtavQkfF
 jTdxDzyJOYldElxPexmWvO3yunUa+yAkkKOeAFQf+5577kUqSgsFQY6STngFzA==
Message-ID: <014a3d09-0dca-486b-a23a-dd4df16d7e03@mailbox.org>
Date: Tue, 3 Mar 2026 15:13:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] scsi: Adjust SCSI inquiry command data length
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "aouledameur@baylibre.com" <aouledameur@baylibre.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?UTF-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "andrew.goodbody@linaro.org" <andrew.goodbody@linaro.org>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "quic_varada@quicinc.com" <quic_varada@quicinc.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "macpaul@gmail.com" <macpaul@gmail.com>,
 =?UTF-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "marex@denx.de" <marex@denx.de>, "sjg@chromium.org" <sjg@chromium.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "balaji.selvanathan@oss.qualcomm.com" <balaji.selvanathan@oss.qualcomm.com>,
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>,
 =?UTF-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>
References: <20260211104043.2445588-1-macpaul.lin@mediatek.com>
 <52bb5837-ed36-4749-824b-e1215bedfce4@mailbox.org>
 <cc89f88aa46ee7f260b8182484701f0ce02f60bc.camel@mediatek.com>
 <65efde85-3e0e-46f4-acc9-8384a08a8e54@mailbox.org>
 <4143b51709b6a5b80b47409c2fa449c2b30b8cbd.camel@mediatek.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4143b51709b6a5b80b47409c2fa449c2b30b8cbd.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1e405f6126663f00244
X-MBO-RS-META: wthoub3cgcmjttqmobgabiupw5ziz8fs
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

On 2/24/26 10:23 AM, Macpaul Lin (林智斌) wrote:

>> Thank you, and yes, I was about to point out that this is a scsi core
>> code, this applies to SCSI, USB and such devices.
> 
> After re-visit the specification of SCSI SPC-4, we have confirmed the
> standard inquiry (and the 1st) should not "less than" 36 bytes.
> 
> https://www.t10.org/members/w_spc4.htm
> (A summary of SCSI-1 could be found here in html format
> https://www.staff.uni-mainz.de/tacke/scsi/SCSI2-08.html#8.2.5 )
> 
> Compare the logic with the Linux's implementation in these sections:
> https://elixir.bootlin.com/linux/v6.19.3/source/drivers/scsi/scsi_scan.c#L690
> 
> https://elixir.bootlin.com/linux/v6.19.3/source/drivers/scsi/scsi_scan.c#L801
> https://elixir.bootlin.com/linux/v6.19.3/source/drivers/scsi/scsi_scan.c#L757
> 
> Unless the inquiry length has been assigned by the device, Linux use 36
> bytes as the default standard inquiry length.
> 
> Is it possible to update the implementation in u-boot to use 36 bytes
> as default standard inquiry lenght aligned with Linux, other devices
> should apply vendor specific inquiry length with quirk settings. Would
> it be okay? Looking forward for the further suggestions.
This would be OK, yes. Please update the commit message and send a V2. 
Thank you for investigating this.
