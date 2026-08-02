Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2EBC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 22:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEDBF606BE;
	Sun,  2 Aug 2026 22:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGXhOz37yFyz; Sun,  2 Aug 2026 22:08:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA062606AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785708518;
	bh=lPmNYwO/VuITcSxDWgsP4J5vROW4Fcj8PYNFX3ADIJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LmEpGoSLXBF7oCjtGlsr9RyebM/Sq1+g7LkbwcZjyTF3PtZmpo8V4FiUitDGYbTDx
	 WXrNb/CC9h9imnXcAKWyFF+uPZYyGQGsRCngHsnQktu7hSQEg+ay1s8pxAa/p83ACU
	 qwWLAn7TA84T9LT7/5yRciSa3nA3+CAs5RlSC7IxEwDgkiGzRI19T7eK4vbYSpF2KO
	 fBSYnpIHv8XRwuTw+IGwq/eBMz1Rkq9PxewlDvx14xBT2rmtfcSvweN+74Td1RpvN+
	 TYNksWckfQ7pWIKFtHEENvKEGd/9X06o2Ut4zGmYMLIvYW/LvGyblcqxKR1mmnSSnJ
	 7cV2D4X8uustg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA062606AF;
	Sun,  2 Aug 2026 22:08:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 88B9C3B9
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E6F4405E9
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u9noXoZ2A3xX for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 22:08:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 07A82405D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07A82405D2
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07A82405D2
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 22:08:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9F7805D7; Mon,  3 Aug 2026 00:08:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D345580087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 00:08:27 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrhQ6-1xK9cO22iK-00fdIa; Mon, 03
 Aug 2026 00:08:21 +0200
Message-ID: <601345a8-0b4f-44e6-a25c-e827ca79ccff@gmx.com>
Date: Mon, 3 Aug 2026 07:38:16 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] fs: btrfs: report file sizes from readdir
To: Cole Munz <Munzzyy1@proton.me>, u-boot@lists.denx.de
Cc: Alexey Charkov <alchark@flipper.net>, Marek Behun <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
 <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
 <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
 <cover.1785660029.git.Munzzyy1@proton.me>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <cover.1785660029.git.Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qIcOEu0FHHYFZvy1oy9fVyRWGfgsK+lYcSCItVcnILhDwRxs4+U
 WuyytZpwjI5Yrb4F8Hvj+TzoGUJVfTKNB7vtMi+FlzkY8XeglGUmvEFuQOq19kU63AKnyMs
 YlVKccs2zFu0TFPU2IF+PypPo3QbDghqgmY0Fsu85hW/IXeZsC/3+vMntD46WX5dnvwBLpf
 xWcCTFeSlFJ3rkrDrSjkQ==
UI-OutboundReport: notjunk:1;M01:P0:q5pzkQ8eeQM=;/TrN1s5itwHbzIslELgloFUl8tR
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.com; 
 s=s31663417; t=1785708501; x=1786313301; i=quwenruo.btrfs@gmx.com;
 bh=lPmNYwO/VuITcSxDWgsP4J5vROW4Fcj8PYNFX3ADIJ8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FQ7Ku0TRMO5HrKopiP1MwLQEaHAWyw7d3Px45bavgq/Oolv9PMoM1CHVbYnZfuGZ
 x+JPobZ6TujL9OQjNQLrkFSw3nDRYkaW1uPa16oiSVCvsPiKaw9F9u8XtopNDy9O3
 7sQ9EC07IQVDQeO0wwWsIyE0Aw+MmZV75/36aw2FhRqliDFowsJgH88iSDVgV0aen
 A26ZhYScMPxAKiaIaN2S4DjMYXAUkSxNfd1NC85oNCHVhQBYG2ygNmCbGmP5/E3tT
 aEcb2sUm+im6vAfnDdKF9hCjJIfH5BYYrwWOIxQhXxLi5K0sJSC3BnjCYDwd0G/wy
 HVLil0WvSDWHPbUUHQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmx.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com
 header.a=rsa-sha256 header.s=s31663417 header.b=FQ7Ku0TR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quwenruo.btrfs@gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FQ7Ku0TR"; 
 dkim-atps=neutral
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



=E5=9C=A8 2026/8/2 19:05, Cole Munz =E5=86=99=E9=81=93:
> As agreed on the v1 thread, the fix and the cleanups are now separate
> patches:
>=20
> - patch 1 is the fix in the v1 shape
> - patch 2 makes btrfs_search_slot() release the path on error like
>    the kernel version does. That is where the btrfs_size() leak came
>    from. Suggested by Qu.
> - patch 3 is the dedup Alexey asked about. One helper shared by
>    btrfs_readdir() and btrfs_size().
>=20
> The pending btrfs test suite still passes on top of the readdir
> series: 5 passed.
>=20
> Changes in v3: split the fix from the cleanups. The release moved
> into btrfs_search_slot() itself.
> Changes in v2: helper shared with btrfs_size() plus the leak fix in
> one patch.
>=20

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Cole Munz (3):
>    fs: btrfs: report file sizes from readdir
>    fs: btrfs: release the path when btrfs_search_slot() fails
>    fs: btrfs: deduplicate the inode size lookup
>=20
>   fs/btrfs/btrfs.c    | 77 +++++++++++++++++++++++++++++++--------------
>   fs/btrfs/ctree.c    | 16 +++++++---
>   fs/btrfs/ctree.h    |  3 +-
>   fs/btrfs/dir-item.c |  7 ++++-
>   4 files changed, 74 insertions(+), 29 deletions(-)
>=20

