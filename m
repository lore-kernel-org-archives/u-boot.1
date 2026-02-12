Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01135EE368F
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 14:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3115E83AAB;
	Thu, 12 Feb 2026 15:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ilV5xDQz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XidIj3Ja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5826283015; Thu, 12 Feb 2026 15:31:27 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605E783015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 15:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fBd5m5hFCz9vDx;
 Thu, 12 Feb 2026 15:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770906685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpc1ZY23CCsNUyJXbMpUpVXWWbHphBa8OQrB8msDZY8=;
 b=ilV5xDQzvFU0u9YXW/YFMEjCSBqu511cnqi+sw5PP/lPbHmS/Np5XlFxTeYbjrqScEgSZI
 OfnvRxVyMTnOJyhwYGRuY22lXiHvvehaV2J7Z6jvCVoAZpTwrjvu6KIZCiBXvDIW20/EH2
 4DZb6xar5rPF9xMHJ+N7UBYRmiN1nhqhDXz4Ymj3VKqOwKxr1FPCwU56tnHEhNPmt+BqG6
 ziKMdUR1cSfwJ+MxM7VihqJrD0omAZyzN0LS52MjmllYuuqxdjoC5I9dkAbICAu4Aon161
 tAcWfhgQcgH/8YAq+I7UJ/jRLf9VcVFeykiJi1A6H3iXXXwyTSIQZak6A4uiwA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=XidIj3Ja;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <65efde85-3e0e-46f4-acc9-8384a08a8e54@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770906682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpc1ZY23CCsNUyJXbMpUpVXWWbHphBa8OQrB8msDZY8=;
 b=XidIj3JaWG202NdXdorqPkmqS3+6mGM+KAs52pkVMJKwIzcZweMYrrm9+ewNiTBMa6ZEw9
 Y0UJAst06ZDgFQ9tbJ6d/5kqMVjT8jKj6/81JPFcqsVREkkA9RTaW87vQvWQ5YyPT7WnCM
 PJOoU5iGAZQ/WMAKxWGDBt8eYJaL6ypGryjGk2DH0wS5SdEjmGwvDgPfiIL4iJdTgSoIf1
 KpEheoNZ2LAEAnR6ieImlMcYFfWDugTwy8V4ecLonGmP6yguP5wi+UeChSBSw4KdIXJrcU
 TaEFnA775m3h5cyT7Dd59MX5tAUT0Oyuq9aTyt/zp0UpcqpFBjvfcUuXlbrHjg==
Date: Thu, 12 Feb 2026 15:07:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] scsi: Adjust SCSI inquiry command data length
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?UTF-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>,
 "aouledameur@baylibre.com" <aouledameur@baylibre.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "quic_varada@quicinc.com" <quic_varada@quicinc.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "andrew.goodbody@linaro.org" <andrew.goodbody@linaro.org>,
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <cc89f88aa46ee7f260b8182484701f0ce02f60bc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 486uye6qkwbsn76o7pibq9rugfruu81e
X-MBO-RS-ID: 922e14de183054bbf3c
X-Rspamd-Queue-Id: 4fBd5m5hFCz9vDx
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

On 2/12/26 9:21 AM, Macpaul Lin (林智斌) wrote:
> On Wed, 2026-02-11 at 12:06 +0100, Marek Vasut wrote:
>>
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 2/11/26 11:40 AM, Macpaul Lin wrote:
>>> Adjust the data length of the SCSI inquiry command to accommodate
>>> various
>>> UFS device vendors. This prevents SCSI detection failures on
>>> Longsys UFS
>>> devices. Verified with Hynix, SD, and Longsys UFS devices.
>> Can this be quirked using some vendor/device ID match , so only the
>> problematic devices suffer the consequences ? Thank you
> 
> During the patch reviewing last time, Eric (HT Lin) commented
> the length of 512 bytes is not follow the specification of UFS storage;
> it should be 36 bytes. So these are not problematic devices actually.
> However, I'm wondering how the parameter should apply to the
> traditional SCSI devices like harddrive  or USB disk.
> 
> I'll double check it with Eric then update new patch around the end of
> February.
Thank you, and yes, I was about to point out that this is a scsi core 
code, this applies to SCSI, USB and such devices.
