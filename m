Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A4FC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 12:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 443EC820F8;
	Mon, 14 Apr 2025 14:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WE3iT7u1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691F982114; Mon, 14 Apr 2025 14:35:43 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A4A8209C
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 14:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 927DB444AC;
 Mon, 14 Apr 2025 12:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1338C4CEE2;
 Mon, 14 Apr 2025 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744634139;
 bh=keJQ3kzxWKlMeIm6nGtONhO+ARGHaZyxFduy8ZwNoIg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WE3iT7u1GzMzzazQmDgt1NUecoq2TliMCoAVsleaozHgJsMF+1vzl466QJLDPapbw
 VTF2MTESqpb64N+fnA2sVXbdbXiwrDpaRjiZ/WEhfOiguJ/UiUvUui2xYMIgst1xvf
 pDNe0BtdZxiQ6bpTcDNR4OySneJASf4fcbkyjfS79eEf/2DrzVo/I7+Ifp8We6HbQi
 mDfQkpq97JKuwHYKT3zApW3oAQQ2U9ZfoBYXFkmKnYA1/2Ku7fZ9vQ/bWRremC4K08
 o8bSjp7JPcfo2KHEJXHANWvjt+qOwPgjbJlEFNOKXRL7i1EHybCl/XB6kqr8aX8v1h
 XHqSbdbjVnZrQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Vincent =?utf-8?Q?Stehl?=
 =?utf-8?Q?=C3=A9?= <vincent.stehle@arm.com>, u-boot@lists.denx.de
Cc: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>, Jassi Brar
 <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/5] board: st: common: fix dfu alt buffer clearing
In-Reply-To: <87plhfc4n3.fsf@kernel.org>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-3-vincent.stehle@arm.com>
 <87plhfc4n3.fsf@kernel.org>
Date: Mon, 14 Apr 2025 14:35:36 +0200
Message-ID: <87mscidip3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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


On lun., avril 14, 2025 at 14:24, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:

> Hi Vincent,
>
> Thank you for the patch.
>
> On lun., avril 07, 2025 at 19:05, Vincent Stehl=C3=A9 <vincent.stehle@arm=
.com> wrote:
>
>> The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
>> macro to declare a `buf' variable pointer into an array allocated on the
>> stack. It then calls the memset() function to clear the useable portion
>> of the array using the idiomatic expression `sizeof(buf)'.
>>
>> While this would indeed work fine for an array, in the present case we
>> end up clearing only the size of a pointer.
>> Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.
>>
>> Fixes: ec2933e543df ("board: stm32mp1: move set_dfu_alt_info in st commo=
n directory")
>> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Marek Vasut <marex@denx.de>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Patrice, Patrick,

This was assigned to me on patchwork. As [3-5] have been applied already
by Michal, could you please pick this up?

I've assigned it to Patrice on patchwork.

>
>> ---
>>  board/st/common/stm32mp_dfu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu=
.c
>> index 1db8e45480e..8c1f80b678a 100644
>> --- a/board/st/common/stm32mp_dfu.c
>> +++ b/board/st/common/stm32mp_dfu.c
>> @@ -105,7 +105,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>>  	if (env_get("dfu_alt_info"))
>>  		return;
>>=20=20
>> -	memset(buf, 0, sizeof(buf));
>> +	memset(buf, 0, DFU_ALT_BUF_LEN);
>>=20=20
>>  	snprintf(buf, DFU_ALT_BUF_LEN,
>>  		 "ram 0=3D%s", CONFIG_DFU_ALT_RAM0);
>> --=20
>> 2.47.2
