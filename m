Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CE9C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 06:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEF1879F3;
	Sun, 17 Mar 2024 07:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tVqjp3wn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rKGirmdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6672187A80; Sun, 17 Mar 2024 07:06:24 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90638796B
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 07:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Ty6tj3JMRz9sbm;
 Sun, 17 Mar 2024 07:06:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710655581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJ3c65wRxXz813JraoSGFgU3wiJV3s50GX72EMrRjM0=;
 b=tVqjp3wnGTgIy1nM1/xVao2znGIzdApu1WANn78btOrNrvSz5NXAvnk4hrYZrohvVUvjhQ
 wf/Rxbsc8sNqk7Wz5XZbOZUqTUkas+CHBrgH6kbcv/TLWQd7y3O1j4cb6vWy+eLWs7+aDH
 IYJLpbwpdKoYutWaWj4umtcu9Yn0vyUjiiubmm7JJep9acHC6l3DY7QoLbyrVuoaMzHdoq
 lqNVgtLqMtEUL+ws1Juy8FLGKbwstmgGIV2V92x2AQDEVMUZVdF58QtGwFkA/RtW0i1lxx
 2H64yCzzUH27lMj05vBVH5xnxr1q+IoTmImTU3Rm6fHMBj8CJPhkTyXD6qQc4w==
Message-ID: <429ad8e6-1f14-43c1-9c2a-bf1ef4a22a8e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710655579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJ3c65wRxXz813JraoSGFgU3wiJV3s50GX72EMrRjM0=;
 b=rKGirmdgcH8Sgq2LNaYZ9pAPETBWYdaqCNE3KaAeCN3PJP+5I56RZGUamzisGhH1dyyNyt
 t42vXKogAU7MXL3MM7rCOdu4X+MvvBg+SAKyIzFclZBGblw5nmzuzIpVmqkhTWIh5tl86T
 Bvq3+m6hVUuZKPGBPzrG6jsnKdNlCVLA8xWdQO7og35+TNNOknLS+14z40Juak8KzretAq
 VgCG7OM0gulWXth0P4c2HV/khsA3LgUqONNv3Nr3hHcX0KejhKKOX30DsI+C84ZL1eM06f
 fkvqoMJwZYc0T4x1pHksb9/g7P+LjU8rpuJK417Y0BOgW09cfb4PyEjwuQZIWA==
Date: Sun, 17 Mar 2024 07:06:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mmc: Convert hs400_tuning flag from u8 to bool
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot@lists.denx.de
References: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
 <df373095-3c23-4a87-8590-dca3dcf5c2f0@bp.renesas.com>
 <c14ef3f3-fc35-4c7e-b739-ebb8e36dda74@mailbox.org>
 <86c47e19-a22b-42a4-b0e2-510258163aef@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <86c47e19-a22b-42a4-b0e2-510258163aef@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fb880056ee9b678d114
X-MBO-RS-META: grzrm5f3gjqt1gp34958wqzy9fgqon7e
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

On 2/20/24 3:41 PM, Paul Barker wrote:
> On 20/02/2024 11:27, Marek Vasut wrote:
>> On 2/20/24 11:57, Paul Barker wrote:
>>> On 20/02/2024 08:37, Marek Vasut wrote:
>>>> This hs400_tuning is a flag, make it bool. No functional change.
>>>> This will be useful in the following patch, which adds another
>>>> more generic flag, where the compiler can better use the space
>>>> now reserved for the u8 to store more flags in it.
>>>
>>> The minimum size for a bool is one byte so there likely won't be any
>>> improvement in struct size from using bool instead of u8 for
>>> `hs400_tuning` here and `tuning` added in the next patch. I still think
>>> it's a good change to make though, bool is the right type for an on/off
>>> flag.
>>
>> The compiler does not do boolean packing in structures ?
> 
> The compiler will only pack booleans if you explicitly say that only
> one bit of memory is needed, e.g.:
> 
>      bool tuning:1;
>      bool hs400_tuning:1;
> 
> Otherwise the assumption is that you may wish to take the address of
> each field and so each one must have a distinct address in memory.

Fixed in V2, thanks !
