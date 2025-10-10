Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB265CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 21:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF518404D;
	Fri, 10 Oct 2025 23:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FuZn0J94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB5EE8432E; Fri, 10 Oct 2025 23:40:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC95983F8E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 23:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760132444; x=1760737244; i=xypron.glpk@gmx.de;
 bh=DLFqvO4CZQ+hcQOtGBsdLNJayB3AqUJJu6awqRk9MV8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FuZn0J94uywf1WjZKiaGfxzCSTuxj2ZlP+3cijPpSv2NWFR2zcJTIXUH9DlBCOav
 DCRYVCMbrAuJtCa7E6XZTxYU3pLuzNRfur8ADi8MHnrjDuVKGXdGzkLtllpqQ2J2N
 I+eyklSBMjGoteEE18j5fk98/wH7/F5dal1DnYZ6pbUZh7GJpD2GIbqAQd9n16yRs
 rwIF0bUp8+GJySjkH9NoIwX3qvUV0V0sj9a6D7DpZwRfV/QmsyS/cHOtup7UHXAk2
 bXSs0tZ6Rcidbz24Zw4QXacqsAAWCoASl8U5hXbTDfCcxqOtc7AphI+oUD4XIBrOp
 D+K4LHH/nklbNChZoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1vBzgN0oHj-00CF1a; Fri, 10
 Oct 2025 23:40:44 +0200
Message-ID: <4ac4a2a7-814f-4407-b1ea-f5f57d3bbd7d@gmx.de>
Date: Fri, 10 Oct 2025 23:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFH DO NOT APPLY] test/py: Update to pytest 8.0.2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251010134330.1094378-1-trini@konsulko.com>
 <20251010134410.1094470-1-trini@konsulko.com>
 <d407b3a6-3945-416f-95fa-160da63ca8fb@gmx.de>
 <20251010141809.GX298503@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251010141809.GX298503@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lMt+eAUbPhhQFIrGjW8gra4UMfzlHV2nDxcL5d83u5lpxUcbw3e
 nIAQABcaM2sPSmEOePql1MOYSN7VgYiS3xibRYHzPAidNK8jg8dGsjDClmDjkFGB7QUiZ8s
 FMaBConDi8ZfXj6CsjUIOrjnhy9aBPb4SbJbtTTT9R75bATedWKW3/Q4CW+tiptEgNcbWOZ
 ByXxtwhJBiEkniURt4BCw==
UI-OutboundReport: notjunk:1;M01:P0:FG5/a22NYPc=;EYOma4owrDcs/tH+4UzTeR1KJqe
 +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
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

On 10/10/25 16:18, Tom Rini wrote:
> On Fri, Oct 10, 2025 at 03:47:14PM +0200, Heinrich Schuchardt wrote:
>> On 10/10/25 15:44, Tom Rini wrote:
>>> This is not intended to apply directly as currently it leads to the
>>> sandbox.py (and sandbox build with clang) tests failing as the efi
>>> selftest now has 4 failures when before it had zero.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>
>> Why wouldn't we try to move to the current release 8.4.2?
>=20
> My first move was to 8.4.2, which had this failure. I jumped back to
> 7.4.5 which doesn't (so that we can move forward with newer labgrid
> support). I then started slowly incrementing to see when the failure was
> introduced (as it can be helpful to look at the upstream changelogs to
> have an idea why our tests now fail) and luckily it seems to be in the
> 8.0.x range.
>=20

The issue is due to a change of the sequence in which tests are running.

test/py/tests/test_efi_bootmgr.py before=20
test/py/tests/test_efi_secboot/*. With newer pytest it is running after=20
the secure boot tests.

Cf.
[PATCH 1/1] test: uninstall PK after secboot tests
https://lore.kernel.org/u-boot/20251010205514.GG298503@bill-the-cat/T/#t

Best regards

Heinrich
