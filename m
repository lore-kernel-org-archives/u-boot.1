Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26A4C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 14:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E640087660;
	Sat,  9 Dec 2023 15:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="P96q1BIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B693287664; Sat,  9 Dec 2023 15:40:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3E48761B
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 15:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702132798; x=1702737598; i=xypron.glpk@gmx.de;
 bh=y+Ft1KJ/0oZBoA+yKPr2FmR4Sjt7KWg7Dug2gPezibk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=P96q1BIgQK1Yh1KfHmT7KD0HIvpyzbboOY/GfldFVyU5Dzugp/h4Pqm3bsOK3+jf
 4QrH3FhgxYExXIN2SVKnvxKVrmrHMZTfvtVoDk8l0zn2b4TXckaDG9NSVE1ThTgg5
 PevpnvmIvB/wTl2EhSbs/aysM0ijEs9KwGBYDyptuKAP+3P18IqGBQUc7f/637+Uq
 e2PQ7Ss+5Wnfh6/8+T0lJQrcbOMdTFmOO5dSIi7JsVP+f2h0uq9pARSY13irGILJd
 8cfrjFWSsjJ/T2Jug1fuMGC3X2jGsDjKALMsp6ke3HsEYb91U5ykF4898QlkhOB4h
 B49yvBEigB4SjDO1rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1rXEPT2MtR-00nycj; Sat, 09
 Dec 2023 15:39:58 +0100
Message-ID: <ef369d4e-9cfb-41ea-b57a-2d0165587a4d@gmx.de>
Date: Sat, 9 Dec 2023 15:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Makefile.lib: Always rebuild DSDT
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, u-boot@lists.denx.de
References: <20211020123742.31098-1-andriy.shevchenko@linux.intel.com>
 <3a272671-7c96-4644-a4ee-05257c7efb30@canonical.com>
 <CAPnjgZ3X9hC_n3pqgsDcAuoAfP6yEwQCG0h=PXq-oDj_cwpozQ@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ3X9hC_n3pqgsDcAuoAfP6yEwQCG0h=PXq-oDj_cwpozQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p9uprceVGPrBk/g/aGweJHsMYxsgiojCG9WlgQ735qldnIdJGiW
 ID+M0Vm2u0sWGSXMfkMArzvhj44XYhcDWZVz+pO1AY78wgDXh/k6eK0QQYuouJKceqGI72Q
 hXe2z57XgYU3HI1Lw7LPeU94WGS21z4X2vR8bHpkjJqTRtRsg9zo8tRcdFbx9z4H8Pm5t50
 n5B//qLwCVkWXPLCdQHxw==
UI-OutboundReport: notjunk:1;M01:P0:B2dKzO0nPk8=;kZ3BgiX9FRXdS8cw5jNnvX9xWzs
 jLXWSg3J4sodWUW5DxeO2dbt5CDU5dzkNJHY4LP8E69TvYUJlBoANlJMwqd4FPvpqRynlLYzT
 8b67HSDVrzjzQyXzSh9LnHJkcxDMOk3uDiIKorCoccX2H+lOJp+eEh/jn9Uk4bMI3MCMUV55y
 CJeWpnq21/gQvUWL1IowmGENvSm97X2xuM8hrbwMoovi1xJTWm7gtneKMOSj66FvuFDpuhbx/
 FqwA+zhnN62kJCyufGhE99bm9X5thqx++7rpda/fhCMJt2tLjhn/lGsgcqr37FUhmgRw0Krti
 Rf0yd1i4WIwDN5+S2FkWEnHFUtSH+X8gGDGt94L7Iw84653WwmiYNP9Sg0Wubnz+JvqE5GRcO
 i6DmjE/1jFlfywaoesT3D8zMq1+4neHcKB1IS689CF2jyghV4Y+xYU033hu6oOR3BKdb7+kn4
 q9WLz+IIkCi24tKm9QeyQv0kGBmolDE851UMl9x+OxAe8rfiRlv0Vz1vzpjUvWV+ARKG9qtYI
 stHSdi7DCG/sHRxJAJ6pWiiLT+q+y/vPso4chHvCMXTrRaaSOKql1R7BMSCNSvL57KTq4gEFJ
 SLfJSXo+GOUKKM/kXkPq5QbojOqxBwEM8vZWQt8eY6f0c1K0LJeWwXi64ryOf5zx6i7IJGOlf
 DG9WydoLU8az3KgQ92s6iMm7nZJDyU3i9Dpq+F+hxkF/8+cCuEiDh/HEslEtFfQtbodisEpju
 GmSu5j8CS7RY8bad5PZm3tOUuVAP3ApwBhlsGT/SzSoOQ7YavOmxZgcNxLY4apGRnnnHDlLBW
 IwzqZqBUS3k9wSFF45lTBcmvRDfnzWkl0O8larPntkGUJbpjoVyh3FUqDB2al8rPz5t6ZS1SI
 I88A3dt0eWGKcJezam79fC0DDvlIrcaSg+5n0pJ60nCPvCQQENfFoqv62ZHtHC001OJvzhN9U
 mHpJPa7GbCm62CV1iQWGsrQHQJA=
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

On 11/30/23 03:45, Simon Glass wrote:
> Hi,
>
> On Wed, 29 Nov 2023 at 10:17, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 20.10.21 14:37, Andy Shevchenko wrote:
>>> The dsdt.asl is usually combined out of several files that are include=
d
>>> in the main one. Whenever we change the content of any of such files,
>>> build system is not able to recognize them. Hence the easiest way is t=
o
>>> force DSDT rebuild each time we run make.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> The build process that you describe is not in our documentation.
>>
>> By which defconfig is $(src)/dsdt.asl consumed? Where does it come from=
?
>> Please, provide a reproducible example.
>>
>> Would you be able to provide a documentation patch explaining how to us=
e
>> a user provided dsdt.asl file?
>>
>> Best regards
>>
>> Heinrich
>>
>>
>>> ---
>>>    scripts/Makefile.lib | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>> index 07696e86bb54..8c3c893b398a 100644
>>> --- a/scripts/Makefile.lib
>>> +++ b/scripts/Makefile.lib
>>> @@ -441,7 +441,7 @@ cmd_acpi_c_asl=3D         \
>>>        iasl -p $@ -tc $(ASL_TMP) $(if $(KBUILD_VERBOSE:1=3D), >/dev/nu=
ll) && \
>>>        mv $(patsubst %.c,%.hex,$@) $@
>>>
>>> -$(obj)/dsdt.c:    $(src)/dsdt.asl
>>> +$(obj)/dsdt.c:    $(src)/dsdt.asl FORCE
>>>        $(call cmd,acpi_c_asl)
>>>        $(Q)sed -i -e "s,dsdt_aml_code,AmlCode," $@
>>>
>>
>
> I agree that this patch is better than having the bug. But yes the
> docs could really use some notes here, for the person who does come
> along and clean up the dependency bug.
>
> Regards,
> Simon

The patch is neither applicable to origin/next nor to origin/master.

I only find a line

$(obj)/dsdt_generated.c:    $(src)/dsdt.asl

Best regards

Heinrich
