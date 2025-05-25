Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F8FC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 11:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28EB482BDA;
	Sun, 25 May 2025 13:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="o/YflnYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A280082C75; Sun, 25 May 2025 13:16:42 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40BD82B5B
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 13:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748171800; x=1748776600; i=xypron.glpk@gmx.de;
 bh=nKpVAwC4r19YSlxgYm9N2Y1C4LZtLbHi4AEMfZ+LjVI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=o/YflnYkdkWHVxmCzdoYqR9jsnO7+ALmHQoJBoRbFphLRtZ7ZDb95S1kk5+XLQDl
 CYIdC1HuOKxGDtcfE+OW57x9ODHOcLbsrx3cjr3OcTbo4oQURsjWOSryL1NDTe5Qa
 gwcpcUiiaIx4PgeQsiiUWci39D+VniHKeN9bkqpoCm2CqL6dfCN596o1Q6kdtMp7e
 Df6kL0Fc4b3LrVrqYRXWZprPkvssv5Rk9JZre84hofImWSJ1tzhYXfgvanmdSoA2G
 zHAktDcj3i8mwNfBkFmx6sZ4qKUo1+S6yBJvliM9pBYG38oxLq+cv7b3Srd/c+WEt
 XIyoKNndzzrqI4IZMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2W5-1ukCVE3c4l-00lKsN; Sun, 25
 May 2025 13:16:40 +0200
Date: Sun, 25 May 2025 13:16:38 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/3=5D_efi=3A_Include_device?=
 =?US-ASCII?Q?-path_functions_in_the_EFI_API_docs?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTguUou4TMev8m0rnr5JLxDG_Gwy6S21p=hfrL15nkNWDA@mail.gmail.com>
References: <20250524172827.1243975-1-sjg@chromium.org>
 <20250524172827.1243975-2-sjg@chromium.org>
 <501660c5-2c69-4f93-ae10-d83253706890@gmx.de>
 <CAFLszTguUou4TMev8m0rnr5JLxDG_Gwy6S21p=hfrL15nkNWDA@mail.gmail.com>
Message-ID: <D832110C-D250-4D4F-964C-FBDEAB378779@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WQOMD3q+GwXKwq0YaRKZQw1AWBlpJg7ylr6MrNv22yVcXBChng2
 1+2Pi6lugSfxMX8XGeFMNGsg0gg1arez9asaH5M8soBqMF8adoiEw4R3tZwr6b/3im0AdQq
 IpqvzMgZy29GcPUTnFHWOEJKcLgT+QQ0mTpk1i6bb5H/UyrTjZ8odnC7hpK2yZNotqIOfyJ
 cgL/EXYHCtRUgVboUu7Ig==
UI-OutboundReport: notjunk:1;M01:P0:Z8DdTE1Xa+o=;7rddYQz//yk6vW4U9abNRilB/69
 VKp6d+4VjguoMg6wo8WqwB6yZWPRhfA+nzPuF778zrz/B23aoytKyuJOmk7vPdVUXqyWkoZJD
 zQS2ZyWj1D0Eo2WJqaUYRa9x7TP2qu3TskoLQDU4NKcdPkSspdIV1Kp807JuW6AZ1cjj2UWzB
 Xmi5Wd8RxKjavAsnlcIvN/mlRXzZvH+sKhxsSgbqDUuSh117QqBSum8rNjGAQK2ZDn138Ky45
 ndaNEID64slen9aLNGoY88I0FjpQVxh7Cb9gWn/5H4+94T3QdutxJa7aHoxn8tK46f/YLNH4m
 ineMO2MUei6b+R0BO4la0/UK2b80XgM7UOfu9uxajv7OnMbuJdjCQ3JedWV4ZDgTaT9YuL7k7
 fbiV+pPGhzzsb+ro74X+J4h+GCcnBuJzdCJfGqg2QsPiZvWRWW6dxwaia044bJpFUqEELG1LR
 s7HxtlHIOiY9lWXWAJdsIkv0qCiEHV//RuOKdfUl2muX03VfUTZAJx9iNtRgEC3P0OMI5snya
 xdPxB0l8i/Yw9h9JjygegqYiypi1TJyAsWXnhCEkxnjutbsfJCExITn8k3xnAfTcdgJ13lOTg
 5Hr0/XK+twujdT06yRqYAnmbTLRXU+C0BRKl0uJnMUdueKIVMRe8iCssNDke7UCnHLyBCAYkm
 civ26+dDtgBRzuvR42iofvfRLOkgLxBlIPw/2nwLa6Vrhlyf9gNbb5X8QHUGKWHO0k9fywsfd
 H7+66aQ5XnThNkTbud7qaoDEN3b7VGrs8RKx6MdVi/TQc+Fc+UReHsfB/q8n/Xl/KDXKj/0DL
 KKncMv7sWHLPtdlU7h54255JGJ3w6RkZwxQ1lL3Sl0WtyRh/Ow+Qwp5JH19SNhDXHHLCAMsgZ
 GQvKW0zKKDQE4MoiS9Ws67ocRl2ZO6Z8PhStwNwWBgU/2dxSP5VuHAzRN6xnyWsBsLqE+A38J
 kLuVSUREe1x7xciw40uGF3xYsKLnPQB/QlOnpkRDgu/zdMnUxhwMLXBd3W84I86pvJe8A/yq3
 rBCotk4EmNN6FynWMlGyfsqK0CFmCzCP6cEoJ0/x7ARNobbA31lFz7MxWUeXiTR7hfFtndamG
 X96rUqVp0dtZkhDzFNqyrD6c16ZWOFlBmnIylSIxDuMmeklsccRrRA2gTgBrh2+TGLoB39aUP
 fM3Xp4peyWqF8/4R1w5Hy499y28LlgLCA2DxiqQLXT1ecuYd8+fXXn3ZttE+DMKOFm9sPeaTY
 +nR7l3663/PRske3NOzH+84utXyVw2XObNko6m3znUwTBZNFZmDDzOcqA/3mdC6vKPrIIwBKt
 d49L/MvpOSVRYOgLKUUelyBOqJuRigWeJ4rLR7HYqsDV+HYizSr52I/X8WsHFOvcFGKQcGdTu
 6AoTxr9QjtJ9uWoeb2hGYj/2L9hifU0Ca/1pop+/SsEm4+DJWozpk0hLHMQrNeLjD+5cYdR3f
 CPGoliDVqkLEkuXCMkwQJCPhsO/NiogtKAggxLv5AIOp+Kro8bHtx+0MgI8nByM89RpNgw55M
 tcbbglwRm588pvZNbe0Hf5bLFsb7F94spJ/5GH568HiPawo2TWXhAkCTXZRmtZegULz3SL1+F
 tY83CVIYIvr3ie+gy5kT8WbkeMlDSQ89QbR3zBwu33UEQGwJ8I9mULED+XId5BJCjtp4sRz3G
 10YrEZxixCZiCPp/oZBajzGRwDfiUaRExdVP2MRu9FnbBjoW12SlNZ/LTazS80K3aLXMv5l4p
 1uMa2tP+vwOITAlAeLO9LmPzlIfJfiVWPlGFqGuBuF7ySyw1oAE9VSMDbCEv85tqw9006f2Vo
 qGKynSO0HFMBZdbRyws05utmDjQyhr9f7Mnp6/+HV853+QNqhn/1ZHqDQz/FKxQakRa5Z38Ka
 1IvFbewCB5OM22z+Cm32E3i3skXUuYOMTVhClZR2mJ+mokGEIgVuValBYvGOhQ0gVXja9dBiT
 SeGRqpRFmDgCATZqxuQebPeghdQ50hLWvgasAj5jIDDikLlo5HJsAHNdbK0jAXOYPjm9eCn06
 utK+swuQB84l+AUnnq12I04yuZoZ8YK04Ql3X9iROSysaPQCp8I5vYMpZw326+yz3zuJtbwgk
 7rp5cvvS9AGi13nKZthyNzRrJXZnbkVffTi6nTebh6MjUXNmbyVIquIQvdTRUvhv/ZTC8Njs6
 yDn7cqbYat1GrUE/K1f503YpMdlObJeUq4lIIQDmmSUgQ1KQdE8AwoaLbo6A9Zql38qW3RSVk
 jQacJLhr8jgHrxOF2eYj3mnZXDJdR5V4ET5mXtAEiEEtTiC5Unp2t8jUxfSXKOC221VinJbD4
 nqSleFi5116TlD7cMoBCJkJ0asJKAG1J+oCU1voafTmX3zoeuOIFTBK+XQfTEp4TJZXOdskGr
 w6TstV+8QDrARfgSiXCMM40tWFAIoRjQCgl7eJWZIdvjkJAAqek9yhmma0pey+YZz6IobmLr7
 3f+x93k9KNN/BASI0XmQWi8DxGynCMsSV+7NowY7zIzMlwJmwCb8diLknPHw27JqENROlQsZM
 dx5mq/qxXZAVSjVBmLplcJupEvnmmoZec4+BpCTUiUNBcrwKHlwoYjRn8yFAqHrkWL5RRCanv
 NKDfurKOD6+HwedpM0qnrlON2BCYu0zCWX430+U03KQxpiaAserOGqrsfll04JES1ds0iH3vw
 U2wAxXR+vzQjjfOsoptfMPT9FtBmqJrezkMxZ9Ay+P+3jDP55Dho+y6pJ/zVbbpQJNNCWz1/o
 wEFwPQlaPMuXZEpjG1YILGBzeN3mwNmoAC2jw2HeiOg3LQD5qXQXSr6MtjmVkPjQL5sXNDRcQ
 RRXqIy8BJBbV3qHpbmer06BbR3gvjkA44fm0cTPewemowi7hmnhobQT6wD3fer+ILo3IAF/9/
 j0TVE2/0QXeGJsAYatsvSk9gUbezhVPH2ryS61YNukdK+DBIvPurcN4CVRFDJaY9D/AuN0QaF
 hFeaTRDWg2FE3sPwFgw7ZhQ8RGHOp43NvwFQ6JkdaWuOD/h+QK95Kut9OEp4cCfZJqygxiCKg
 i5PctelwNxg8hxRyr0Z9+pWMOYtZ6hgcJy9DTrVF2SGnMgWZwe/fGfLXltmz8/5m9lGMK7KP/
 tjFAs08QQ6UTU=
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

Am 25=2E Mai 2025 12:52:58 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Heinrich,
>
>On Sun, 25 May 2025 at 10:18, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 5/24/25 19:28, Simon Glass wrote:
>> > Include these function so they can be browsed in the API docs=2E Excl=
ude
>> > END since it causes a warning, which becomes an error:
>> >
>> >     =2E/include/efi_device_path=2Eh:22: warning: cannot understand fu=
nction
>> >        prototype: 'const struct efi_device_path END; '
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> > Suggested-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>>
>> We expect builds to succeed after each patch=2E
>>
>> In patch 1/3 you need to change '/**' to '/*' for variable END to let
>> 'make htmldocs' succeed after this patch=2E
>
>Thanks for resolving these=2E
>
>>
>> Somehow you dropped Ilias from the Cc list for the series=2E
>
>Ilias asked to not receive emails related to my tree=2E So far I don't
>have a way to cc him on some patches but not others, if he is in the
>maintainers list=2E If I remember, I can manually drop him from the
>patman bounce list, but then I have to remember to add him back, so I
>generally just leave it=2E I am thinking of adding a feature to patman
>for this though=2E

This is a series for addition to mainline U-Boot=2E Ilias should  have rec=
eived it=2E

Patches that only apply to vendor trees or other derivatives are not what =
we are discussing on this mailing list=2E

Best regards=20

Heinrich

>
>Regards,
>Simon
>
>>
>> Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>>
>> > ---
>> >
>> > (no changes since v1)
>> >
>> >   doc/api/efi=2Erst           | 6 ++++++
>> >   include/efi_device_path=2Eh | 2 +-
>> >   2 files changed, 7 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/doc/api/efi=2Erst b/doc/api/efi=2Erst
>> > index 43d6f936fb0=2E=2Ea98298f93dc 100644
>> > --- a/doc/api/efi=2Erst
>> > +++ b/doc/api/efi=2Erst
>> > @@ -178,6 +178,12 @@ Driver binding protocol
>> >   =2E=2E kernel-doc:: include/efi_driver=2Eh
>> >      :internal:
>> >
>> > +Device paths
>> > +------------
>> > +
>> > +=2E=2E kernel-doc:: include/efi_device_path=2Eh
>> > +   :internal:
>> > +
>> >   Unit testing
>> >   ------------
>> >
>> > diff --git a/include/efi_device_path=2Eh b/include/efi_device_path=2E=
h
>> > index 67474d6d0c1=2E=2E33b6cfe9b79 100644
>> > --- a/include/efi_device_path=2Eh
>> > +++ b/include/efi_device_path=2Eh
>> > @@ -14,7 +14,7 @@ struct blk_desc;
>> >   struct efi_load_option;
>> >   struct udevice;
>> >
>> > -/**
>> > +/*
>> >    * END - Template end node for EFI device paths=2E
>> >    *
>> >    * Represents the terminating node of an EFI device path=2E
>>

