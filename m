Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA24CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A6384715;
	Mon, 11 May 2026 10:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jzR+KUxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EB884836; Mon, 11 May 2026 10:52:00 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4389484706
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 121756001A;
 Mon, 11 May 2026 08:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A80C2BCB0;
 Mon, 11 May 2026 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778489516;
 bh=TIiYhjba1Jzp9UVkLa3e1Snmu85J0B1H08stvz+NTLI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jzR+KUxb7zGd8APk3pSE6y92cMKeIlJ0WpezAKNx0Lv8vgZyGluQtVTSDv84Kn2vA
 n6QvORx/1LBR/Cel2fecQJ7nDG1UOzIXRTbJt3zBzKlym+kEhxAB+9jGE6oWx/VJjw
 yXncFerHBgsVF1FuZUyf6vlSmGL6HG34P5zGWkBsMXIbEb2wmbeXdIoSYqoeXAP346
 FVslayjOe4pOAK8woTtaT3wYQpUHocapD4F2akyOWreLcnMsRgJeU5DrWdlc6SpWKZ
 DzSCZm0rW7qisiiBqVTBcA8CbB/NI2whfjisscW+BBFAumhnbKfGlrNWUxGanqUqQZ
 K0xElLjXxgy5A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Gurumoorthy Santhakumar
 <gurumoorthy.santhakumar@oss.qualcomm.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH v3] usb: dwc3: Fix crash on fastboot exit due to
 incorrect memory free
In-Reply-To: <403bb698-be10-4b4f-9a30-df70847b61fb@oss.qualcomm.com>
References: <20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com>
 <fa4a37d3-1eaf-4fbb-adf3-034d2556d2db@mailbox.org>
 <403bb698-be10-4b4f-9a30-df70847b61fb@oss.qualcomm.com>
Date: Mon, 11 May 2026 10:51:54 +0200
Message-ID: <877bpawcph.fsf@kernel.org>
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

On Fri, May 08, 2026 at 09:17, Balaji Selvanathan <balaji.selvanathan@oss.q=
ualcomm.com> wrote:

> On 5/7/2026 10:55 PM, Marek Vasut wrote:
>> On 5/7/26 5:20 PM, Balaji Selvanathan wrote:
>>> The dwc3_free_one_event_buffer() function incorrectly called free()
>>> on event buffer structures allocated with devm_kzalloc(). This
>>> caused heap corruption and a synchronous abort when exiting
>>> fastboot mode via "fastboot continue".
>>>
>>> Device-managed memory is automatically freed when the device is
>>> removed, so manual deallocation causes the heap allocator to access
>>> corrupted metadata.
>>>
>>> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event=20
>>> buffer cleanup")
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>>
>> Did Mattijs RB got dropped ?
>
> Hi,
>
> Thought=C2=A0Mattijs will give reviewed-by after placing "Fixes:" tag in=
=20
> commit footer.

Usually, when comments are only nitpicks, it's okay to keep the
Reviewed-by tag.

Putting it back here:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Thanks
