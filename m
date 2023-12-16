Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E19C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 20:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FC487727;
	Sat, 16 Dec 2023 21:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZxXvIaKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D7686CF4; Sat, 16 Dec 2023 21:57:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216B987745
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 21:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702760262; x=1703365062; i=xypron.glpk@gmx.de;
 bh=NrhkgVS5xEOGzeKAxASR1g1beNw1BFePfRdIk4De7MI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ZxXvIaKPDEVgExvjPPrF5epszJ+frKhfemNO6fD/JePKzrkgqp0zjnuLwrItj9Th
 8QzTQpHgIbszTbCp9rdiWeQstiwleRRtnHvqqtAf7NScW0j72nVteDKukn/LpxqTy
 khwvz7VtnMUYx2T7WDWp8fhBejKboguYPBKeqpcY5v+mt4IuNgalKah+4QzdwPO4Z
 kuEOiuW/qM63Z14X3ofuo5kUk1tKdpJtmdgT9TF+U5ykrPkIG6ziuxawmq1wPft4g
 oMRSYPBnLm+zb796TsgFkKntzShcH52UIqCh1Cf8yzLJCpqa9lam4XMKYh0b+A9vz
 vVBBB5oAVEgckBwYAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.0.170] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1qnCxG14M8-00RbFg; Sat, 16
 Dec 2023 21:57:42 +0100
Message-ID: <c8f1c7cf-346f-42b4-9652-69476e763d5f@gmx.de>
Date: Sat, 16 Dec 2023 21:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
 <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
 <20231121132110.GQ2513409@bill-the-cat>
 <CAPnjgZ30CjQZ0+DMp2gy0HzrnRsjcY5NMi1YVVRQiN8UG-5oBg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ30CjQZ0+DMp2gy0HzrnRsjcY5NMi1YVVRQiN8UG-5oBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JlBHwECXs0Z20sr6eoWoyDHe+kcVIFp91VEscWzt43/Xkw+z13C
 CMxrtejwdEMKzAfQb2sFp3LnXOvB75WZzgzSSkx9cVL7IlDny6ioevQf775pkWt+U7Hz3Z3
 SJXnStTXe1UBAbz6VoLVELvdwMd3m2dI73fSeNFMU/x3M2Ubc5BwJVh2oGTk1s+ocHErTDs
 4IgF+fOlaLYZ4YuT9qDdQ==
UI-OutboundReport: notjunk:1;M01:P0:x7X8nulUdhE=;bVqji8J66tT/wKHJy1aoXegFBwz
 ROlbgMr9dFm5rf7mmo0UM7N1i9qZO0O5Sh/rvf3y6MWo8nkaxGtSCs+2ta9Mthvl0GNCp689T
 8k+i8JnYEPUokbiB9OFGrHoftOaJN080VeY1G8uGXArTAKwUyl+M10J5FaxwHSAPr/E4QacwD
 GwATAeSh3wkj+nqQtUsqKNH9sYKYLZQAJC9FtZWVwE1ElEiOyqmLEPVgeBXqf1WSmfnmoHAM4
 IT4YOp2suhjK4jCEDw493OLkAVptPjMWH1GISGNApPdG3J6Xrn/bjVxq8rzLXgem88rY1vAzh
 z2I/ICdRxhSSCnuk/LzDeY/xryY6XdcvMi9xQP+drVzKknNaBDbC3IBfQ30k0BAZ1cKc+DEJW
 YvP84wIKdktaWXv7AU8K4rowseoXhIp88Km6V0NXndHrSm/zKf/qq+x3SAIp1eyOxicmDdl9Y
 lq3G1aNM30dRZshaqLAtNi6v+ac+oZZOR9iPb2+kz7tA1AsKlx++TNIg7w5LHXVQNQI2J5yiL
 fnLM4d8Xq0IytWWkGBFVeZLOTbDUmS0SrOistPnEojUSPRGWn4R4Ne+2X5UAHoSoAjzrQjmz/
 7q8CkSCBi0A0IIGuP70N3KJk1+NF7BoL+RkYmFxefL3sHaYZU9LnWNm7D4BJwwrLP6lbwms5+
 LK+pvT6dqV3hXqUEbMy1/QgMV08PRpJNRnAloLFsWBSFy8zXY3Vwfes69NPd+IB2x7vF7cFsQ
 7Q7I7vxMyewWd/nI07cvJhWYZm2Zvzc6ZcWN4XmzduFYIqE0N1oTCfllsj5adObvjRNjSDltG
 zLe+gdKHn37zJ0MenWfyqQgUY4ruT8vkTFCJuTEK3HeTy0TOO7hlapdoQz9YrEtKRdZo8K/u+
 MeMr23jYW7GIF9lC17Y9oGohw7FFdPF/kLzHvOB+530c2K1/JAOe0ngtkEgdT7MvJLmQ0uagW
 ozixGA==
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

On 12/16/23 21:46, Simon Glass wrote:
> Hi,
>
> On Tue, 21 Nov 2023 at 06:21, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Nov 21, 2023 at 01:18:09PM +0100, Heinrich Schuchardt wrote:
>>> On 11/12/23 21:55, Simon Glass wrote:
>>>> This function is defined by bootstd so using it precludes using that
>>>> feature. Use the board_early_init_r() feature instead.
>>>>
>>>> This requires moving quite a lot of code into the board directory, bu=
tt
>>>> this is the normal place for code called by board_early_init_r()
>>>>
>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Drop duplicate acpi_xsdt patch
>>>> - Put the board_early_init_r code into board/
>>>>
>>>>    board/efi/efi-x86_app/Makefile  |   5 +
>>>>    board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++++++=
++++
>>>
>>> Our target should be to enable building the EFI app on all architectur=
es.
>>>
>>> Only x86 specific code should be added to board/efi/efi-x86_app/efi_ap=
p.c.
>>
>> A later enhancement to make U-Boot as an EFI app more generic would be
>> good, but outside the scope of this patch which is moving generic code
>> out from "lib" and in to "board".

I cannot see that this patch is moving any code our of lib/.

But why should we move generic code into board?

>
> This patch was marked as old /archived in patchwork so has been
> forgotten. I have marked it new and non-archived in the hope that it
> can be applied to -master soon.

There is nothing x86 specific about the code. Generic code should be in
lib/. Please, provide a new version of the patch.

>
> I believe that having the EFI app support bootstd could be a useful addi=
tion.

That was not disputed.

Best regards

Heinrich
