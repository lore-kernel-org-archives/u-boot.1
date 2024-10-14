Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5408FD18131
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 17:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF49E88DA0;
	Mon, 14 Oct 2024 19:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LkEhELuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6B588CA1; Mon, 14 Oct 2024 19:12:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A4188D72
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 19:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728925956; x=1729530756; i=xypron.glpk@gmx.de;
 bh=D3oAWKfZPx/wd5aZ3O71qRdHF+sd0seTXLB7MfcHs8Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LkEhELuu5ERCsEPmlgmsDkDOpv7V2AJKviior+wOqE+shYwKsUByrDsBfA3jjy9x
 IxAba4lSP2L/h9Su1sZGR92TJDcJYTR88CC/ZNn0m6ASGKEbTLm9kX6VtdREkvL4G
 27CZ6D7P3ADVD/SBuyHHDmF20VCu1mTrUCyWPhmJD+pbtLx8uOck7uNNgV6gY6J2E
 JvuJJ516GdBkSgZNC/1onXkOqw4bzzXstAy2nItjH+i89vGeHuCLqNa/hsfsgGdBW
 /d025KfXZFnGUBbPiu00Lm0UqPWcRw4LQsoLlO/eRKEN0axOl0/JRPt0G7RO2rrK/
 hZSIMrbDZgK9yc593g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1tG0lT0Efb-00IlG2; Mon, 14
 Oct 2024 19:12:36 +0200
Message-ID: <ff804d23-b384-41b7-86f9-d0e8abb1d5ed@gmx.de>
Date: Mon, 14 Oct 2024 19:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] lmb: add a flag to allow suppressing memory map
 change notification
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-3-sughosh.ganu@linaro.org>
 <20241013175146.GN14210@bill-the-cat>
 <CADg8p97a5jVR=_YRpbzBDEFLzPea-UtBFHc+X679vyPhGfC2Xw@mail.gmail.com>
 <20241014150217.GL53053@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241014150217.GL53053@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fw2Io99/B18X2gJBt2ncVeg8e+OX9zQGbYR4a/AA35aEB8pvEbP
 /d4riCnrA0PdyftiJhVIR+1BVkxUu6ggLN7w0cWftaK2gO0N2lqE+l0XSS4W4U8VsvU/i1V
 kKeCSYePmOMjb65qRHLXUyZKdS+R+1p+W0kEX/p/qeAjIef/fLnREEApt4PzuvIDWaMZudw
 3NGnkg9+eDGVbWcI3bw5w==
UI-OutboundReport: notjunk:1;M01:P0:hJFQrMI1RCc=;lKp8pFflZBTqnZkmxrOlwudrZRd
 QWuasyi7i99VPSNXuUdk2/H2AOQrtcMij3qdkEaorlMqgs5R9lgsHQeWV78fSNoJdNQ70TurF
 6yQrTngpnAjIww8zFCIOM1aR5a8W6nsi3cxW1/ujZXBN+t+Q184cVn1rV46nnHNjRStUOAH/g
 gHfKHC59iOo/L86RLlYgfhhSurrtI5CPokJ5384en68YaQm1GvlKvwipsF0r6kqvZndZiQVuK
 eKpZ8fC8CL96fGtcVH0Xj8sJaL2qg2EjEy8+wkxu4OSstftIVN04RgV6DwhE8V9IH+QNNCxz8
 HG6EXBGrOUM6n9hf/a9j3UupTuaX4XofwLiLx5X54N21hGl7DLWDL5sY1UlinEk8y4lIDLrGS
 DPThuxkI0wjUHDwRGGN6GCDX6GEfPljOjJ468ILROtRnOQsh1i32GT/K9cLtOuAyPdC8S8WTb
 yeg5P4QAkkkxf7T1UpmCc9YodddjzRYUsrQxKYHjkgZFtPJ79eJDGnERYFMBiWmaGYCxgLTdi
 0O3JaNvYihmWsiL98G5USQZemR/X58Wdmzah1kzOs0DxvMHbjpCgPk4NBHZvzvbk8tp72u/vc
 ud7D6+visaRtZh07Z99N9VMR7oht8wFvOhnE0oyghM6eedbBbLSqQs+jjmZ+W1z+JMzOTDjrd
 jmnL4+Lq3BLekWZvhAzhvJpSX6W4X2Jb3sM+uYrbOVvcCY6yr6tFT98fyqxbXGlvOaC/0mmbs
 TGGARb6AoSH5t5HQbtRg29k7c/8r5Nm0hG4LzuUMX3+uwrUXjGIAG643wFKlR8tSdbvEuDO+3
 iZ7aUK87aaKzLxgtlBR28UDw==
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

On 14.10.24 17:02, Tom Rini wrote:
> On Mon, Oct 14, 2024 at 12:26:02PM +0530, Sughosh Ganu wrote:
>> On Sun, 13 Oct 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Sun, Oct 13, 2024 at 04:25:09PM +0530, Sughosh Ganu wrote:
>>>
>>>> Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
>>>> reserving memory. This will then result in no notification being sent
>>>> from the LMB module for the changes to the LMB's memory map.
>>>>
>>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>>
>>> Can you please elaborate on what we need this flag for, for example wh=
at
>>> the valid situation for it is? We should be updating (or adding commen=
ts
>>> such that updates are automatic..) to doc/api/lmb.rst as well. Thanks.
>>
>> The flag is used to prevent notifying the EFI code about the change in
>> the LMB memory map when the alloc/free request originates in the EFI
>> memory module.
>
> Simon, this is the loop you referred to on IRC the other day, and
> instead you solve this with the flag about a point of cooperation?
>
>> The EFI memory module adds the memory region to its
>> memory map as part of the alloc/free operation. The idea is that the
>> LMB module should notify EFI about changes to its memory map when
>> these changes are initiated from non-EFI consumers of memory.
>
> OK, so the first change is that since doc/api/lmb.rst is just a
> kerneldoc of include/lmb.h we need to add the flag here, and we need to
> first document LMB_NOOVERWRITE which is already undocumented. The next
> change is that at the end of the series, update the rst with some
> paragraphs about what and why, for clarity, after auditing include/lmb.h
> for other items that are missing kerneldoc comments. I am willing to
> make that second change a follow-up series, however.
>

Cf.
[v2,1/1] lmb: add missing LMB_NOOVERWRITE description
https://patchwork.ozlabs.org/project/uboot/patch/20240919105523.179497-2-h=
einrich.schuchardt@canonical.com/

Best regards

Heinrich
