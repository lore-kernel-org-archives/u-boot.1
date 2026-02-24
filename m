Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A681F3C99F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AABB83E7A;
	Tue, 24 Feb 2026 16:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ejpkZ+TX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C860283981; Tue, 24 Feb 2026 16:45:36 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25EA82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 850B925D5A;
 Tue, 24 Feb 2026 16:45:34 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id heYg3yLRTc06; Tue, 24 Feb 2026 16:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771947933; bh=7osG4V+YwK5RVgKkDcBH7Ghrv6MFUpU7xSXAtF4zqlQ=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To;
 b=ejpkZ+TXyCHVXiaPj1MnHCNjZL6HGcWksH1tHfcvhUK4yMUZ0ttKlTu3tFBGVO8np
 CI7+45lQVyvbKMJctFIJMshk/HNNvIxkwNv/B6sGD9+mtorpAb76VRPsEyiUvW65YV
 nrgMjhMxvZoUdwW91HnSj22AddBmXo2Zrn6+jwSjrSLevVySxzOzi+wXTS6zSOpNZX
 9JxZXWc60Kvq5wtsHGiUrEmtAGmkOHssn3AVWse+eavYixlHEztr6udFRYcAH7D9mO
 x9IJYiEFxIoodfHerFvjx10wLLCLlZiMaIejbDA6j65PiAY2iF01tm3vl51pe/O0fL
 HDrZDcTm2QsHQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 21:15:26 +0530
Message-Id: <DGNB47VK06DI.3IKI82M28U9J1@disroot.org>
Cc: "Minkyu Kang" <mk7.kang@samsung.com>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>
Subject: Re: please pull u-boot-samsung master
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Minkyu Kang" <promsoft@gmail.com>, "Tom Rini" <trini@konsulko.com>,
 "Kaustabh Chakraborty" <kauschluss@disroot.org>
References: <CGME20260223103749epcas1p2d9af2576eb9704b70a8572f7ccb8080f@epcas1p2.samsung.com>
 <2d9001dca4b0$74a82c10$5df88430$@samsung.com>
 <20260223184541.GD3233182@bill-the-cat>
 <CALrBrZ0qZMRG=vfw07POB3WgsMJSdXGvp=4sLy7dYAprJ=nitQ@mail.gmail.com>
In-Reply-To: <CALrBrZ0qZMRG=vfw07POB3WgsMJSdXGvp=4sLy7dYAprJ=nitQ@mail.gmail.com>
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:49:06 +0100
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

On 2026-02-24 10:06 +09:00, Minkyu Kang wrote:
> Dear Charkraborty,
>
> 2026=EB=85=84 2=EC=9B=94 24=EC=9D=BC (=ED=99=94) 03:55, Tom Rini <trini@k=
onsulko.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>> On Mon, Feb 23, 2026 at 07:37:49PM +0900, Minkyu Kang wrote:
>>
>> > Dear Tom,
>> >
>> > The following changes since commit
>> eed514b11d04a2f8a949521ad3bffba3ec98bd2f:
>> >
>> >   video: correct label for cyclic video_idle (2026-01-29 10:00:59 -060=
0)
>> >
>> > are available in the Git repository at:
>> >
>> >   https://source.denx.de/u-boot/custodians/u-boot-samsung.git master
>> >
>> > for you to fetch changes up to 11198fa347390eb449c2a0939f5f00cf510fe28=
5:
>> >
>> >   doc: board: samsung: exynos-mobile: remove requirement of stub devic=
e
>> tree
>> > (2026-02-23 15:35:33 +0900)
>> >
>>
>> Unfortunately the exynos-mobile does not build in CI with this PR:
>> https://source.denx.de/u-boot/u-boot/-/jobs/1383183/viewer
>>
>> --
>> Tom
>>
>
> Could you please fix this?
> I think, it should define CONFIG_DEFAULT_DEVICE_TREE for exynos-mobile.

Please review and accept the following:

https://lore.kernel.org/r/20260224-exynos-blkmap-dfu-v2-3-742cb9f27842@disr=
oot.org

>
> Thanks,
> Minkyu Kang.
>
>>

