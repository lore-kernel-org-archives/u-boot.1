Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A3CD1812E
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 16:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D748916E;
	Mon, 14 Oct 2024 18:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LEnHaxNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2955989160; Mon, 14 Oct 2024 18:26:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC1289183
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728923179; x=1729527979; i=xypron.glpk@gmx.de;
 bh=W7CDBL0Mr2nJtGhoVSCr6Zgmf/ZxLDxhR8fAfrPbhu8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LEnHaxNvoDZENNVo0LJvrjfU0yf6ko8tPsK9qQlLZ2q+uG7/cgalLu0ctqd+RL2W
 qdhNgnCY2KAty7ZfAsBCiJ2gphfKe/F36wfC08HuaUNU3xg0IrhQxc9pheoztWuvy
 AlNk5DjAL4XPGxxTZ9UZdREtIYccGMofdUyl5S7sxslSVkFmY79bDEGGKqq+f4YU1
 /PqHw9OgeW17TUJ1E9r7vj262p6jhrQo1SbEr7q0lOqhfD1x1xKMD5vvfLjZ/l07c
 +CkWc1O994kh1vSxrmZ3G7jAymPHF8EqO5YcL/8pZxBgjGVTa6xp2vKUp5eDlpj2q
 tJIXmRZNi8XOSKDf+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1tHumZ09o0-00Lljj; Mon, 14
 Oct 2024 18:26:19 +0200
Message-ID: <341e4ab8-cedc-474d-9495-24cd307774cb@gmx.de>
Date: Mon, 14 Oct 2024 18:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241014155642.GO53053@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I8ujPSDyZMaLWLrYvUWzNeu24CjIPs7CDossVRnuyhb3bRcWKEd
 HFdoWOuFYyw7p9ng7NhkjgFfM7ZyIeyOoLnzZ4YORjWhB/qgXCXKlTZBKAC+v9TgQ+jR9CA
 KgGSTrIkoqdzT0FQ7Gubgkk3B8iFwmamobu6qlHD6t9llSCbEKIvk96svdyFhtEiOpQngpN
 ZSoVvAXbuNxg7Qrr3UkYw==
UI-OutboundReport: notjunk:1;M01:P0:M9a5VHYO7JI=;cE3jGAv76zHhamYLeplpLv82zfC
 r4LgcAKxep2qmrjfHgmjJDRn+f5e0/Nfuyh3Dq4jQz028CqWJAZiB/FrLFLhyo9f6QTcy/AZw
 4seab8EzUYuAEXg+jYl/Ux7Jn7HLYIUQNb4z+5Q+wzswfJWLH4qWGNfa/kbzBNfAOkTZR2VZy
 jD2a6yqxEo6RRLb0S2in4VUpy1DG4oqfVNXEbKfuiNaikAYzxflF2ZSm2weUzWXRFXdK0R75K
 uXiiFsILxzoD53O83BQPH5RUKP+gKQn7sr5f4hJxuEMu9yYLIaEcorbLKdSxKRqc8I1MZvcw0
 DxjZvD9xUJ6iN45ypLB0RgJsS/DpoMp1/4YC0umy83pDWnABUdY9jXEXqw3JMQkzPPcLLFS4T
 St/IfjqmfYzjEnCcLlbwFglq2/viMNFzyMtoq6mjU/jjZCAb9A68xy9gR14pBd/SVVZe+qAyJ
 KDMKcnZkxYMJvCuc77J03JmpeRekdJBAZAQmU21QsTcA9hcMBE+iVhbfVz9xkp/ZLOhRoXwfO
 9lHTemXfvlzSQ+tR5ivxfvw2nwAei45efxhpzRD6Byt6sg1pxKVp8D98Qgqogkd5XRkk1Uw7U
 RjOwrybejNZiblyTHOIOF8sQjSeFDt3E/cG1QnYUZH9+imGK6HjgZKnYWVKRIfr34SnqVwJYJ
 Unmeswtyk7tebQLfhpExcXL4U8MIR0CU79Q5JK7aUcCMnIo84UijWYYWMsnUTwkJn3VJnnJZU
 qWqQRCY85+goGF5O1UiRxhAy/DOqBTT3WZOqO5cXI+g58od1Xbo9y/C/vEshMsyQs4eKvAkWG
 pEFONAGE7ccZjpcqRmypQ7/A==
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

On 14.10.24 17:56, Tom Rini wrote:
> On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
>> Hi Sughosh,
>>
>> On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
>>>
>>> Use the LMB API's for allocating and freeing up memory. With this, the
>>> LMB module becomes the common backend for managing non U-Boot image
>>> memory that might be requested by other modules.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>> Changes since V2:
>>> * Use map_to_sysmem() to get the user-visible address to be shared
>>>    with the lmb API's for sandbox.
>>>
>>>   lib/efi_loader/Kconfig      |  1 +
>>>   lib/efi_loader/efi_memory.c | 77 +++++++++++------------------------=
--
>>>   2 files changed, 24 insertions(+), 54 deletions(-)
>>
>> When efi_init_obj() is called, it should be able to add the lmb memory
>> to its own tables. There is no need to worry about lmb after that,
>> since no other images will be loaded, except under EFI's control. Then
>> perhaps you don't need this patch?
>
> But that's not true. The EFI application can return us to the U-Boot
> prompt.
>

The following commands invoke efi_init_obj():

* bootefi
* eficonfig
* efidebug
* env

All of these commands may return to the console.

bootmeth_efi_mgr calls efi_init_obj() even if not booting anything.

Best regards

Heinrich
