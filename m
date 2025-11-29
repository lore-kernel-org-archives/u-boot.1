Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0DACFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 03:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC51C8352B;
	Sat, 29 Nov 2025 04:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X8rPmOqB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d5c97+/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B17A835B3; Sat, 29 Nov 2025 04:47:41 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2CA832AD
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 04:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dJGMb0J7Dz9spW;
 Sat, 29 Nov 2025 04:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764388059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7nCHGatNZoNfMqmpkQNvcpV1XBpLObqL4WFfI8chxw=;
 b=X8rPmOqBY1/G33kF68qPo88+beCkpXtpF9LjaQpa+2zTKvztgR6vEEouWvSOa2KhU3a54G
 fvsYGXrfpBPpnggB37Otv5qAR08dz0k0Tds84XjSk1YQ3qjFlmZfl/b7we7VASna7Wm1D1
 Uahzs3/yY9FeAYfO15paU93juca3wb1VyvCjMNh5QZUi9Coe5dBDoQnNFdcPsBn2djclSs
 uLtnBX2Ik2zcLe8tZwYD5QzZ/rTbgWZLTaKHVp/iQALdAqoJ5EmhVQpcxgO7sxqQ6Ya4oq
 LKHFdvLHtbnzx17dhIxFisVmE3Kdcp+Y5dd1aBiiORdoICSrQez0emN6/2sdjA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="d5c97+/M";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <f78909f8-a1ef-431e-86ea-56cedaa477de@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764388057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7nCHGatNZoNfMqmpkQNvcpV1XBpLObqL4WFfI8chxw=;
 b=d5c97+/MV0Dned4uTnc4Arwdc4uBC3Vni6P/cnRIOuJo5SOBrqyAUaK2/1V5KSlcUDSL+N
 hxtacfQ8WzIj5x90NW4iUH24ebnvB1ZsdmAWFgVTkF1VviMDp9kZGYoCgsWMKiSnJVK/Jh
 1E306Z3yvZq0BR/j/ebyjZ5A5QKD1RwNl4UXiiADpcC9+8ZTr+Jad87nuA8vtC7B6k+r7Q
 PBARyo7Ov/DUBMYTu52v7NX5PiPkMpc5GV+3afyZ25FzhVCrsP/Y/Knl//4sCC0YsmWq5g
 0bc7s7b2fyuU9bqmkOjUrB9FTjmlXOMppFXbl/1OwAcXJuTTLmVC4fEqvOvtjA==
Date: Sat, 29 Nov 2025 04:47:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/2] net: phy: aquantia: Switch to generic firmware
 loader
To: Beiyan Yun <root@infi.wang>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Zi Yao <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
References: <20251101123401.110681-1-root@infi.wang>
 <4D63D655-F67F-4FC7-B02F-653BF49754EB@infi.wang>
 <59b26617-ea1d-4a65-a474-de16399f8205@linaro.org>
 <7e2b90c8-b814-4027-a7ad-9a0a5e747557@mailbox.org>
 <4A01442A-8AE3-4EFE-A8FF-34DB526B9176@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4A01442A-8AE3-4EFE-A8FF-34DB526B9176@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 11850b347a972989559
X-MBO-RS-META: zisoorpe6b8bac6w5ogoizsobffbm1pz
X-Rspamd-Queue-Id: 4dJGMb0J7Dz9spW
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

On 11/29/25 4:10 AM, Beiyan Yun wrote:

Hello Yun,

>> On 26 Nov 2025, at 10:24 PM, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 11/26/25 3:22 PM, Jerome Forissier wrote:
>>> Hi Yun,
>>> On 11/15/25 08:48, Beiyan Yun wrote:
>>>> Hi all,
>>>>
>>>> Gentle ping. Any comments on this patch?
>>> Since there is no comment I will pick it up and move it to my net-next queue.
>>
>> Ideally the driver should use one firmware loader, not both.
> 
> v5 removed fsloader, only the fwloader codepath is used.

Oh, that's nice, thank you.
