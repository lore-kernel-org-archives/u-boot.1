Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75DDE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 16:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BF68021A;
	Thu, 19 Dec 2024 17:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="XFnd7om2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCA888022B; Thu, 19 Dec 2024 17:16:20 +0100 (CET)
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7147380196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 17:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1734624977; x=1735229777; i=sinan@writeme.com;
 bh=V2qH3oo2SdWisaKg8F4gy879581jSpU4vyPo5lrixtg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XFnd7om2ouznP6rbe2Lq0H1s2eP+Gddgy6SJ0XyE+b1zKoXvqq/wfBu8c9+PSUpD
 9LfliHs2Fx6UZi4hGTrcDg7VTb0XhL50Aiid9vjPVbTkB07u9m1VJTYLEa+weUC+h
 5mRBndtPou83Q7BIZRqaU+HsosMdETJJG2ZvulekbBTo3Ix9xwNBePxdbNBBe9WKM
 hNs0+1kKRqALh5frfif6sXD2eu6R6YhPNI1yTQfbKaq94BCJnvz+kzvka6S1bOGn7
 XdwEpjOJ6eHFiFnRyssav5Ep04wlf+YwlW/qIT28coR+qHO1agoetNCXPa76eHu65
 +DiYl5VuHcw6axuT3g==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LpuID-1u1mPX2tmh-00nTJ2;
 Thu, 19 Dec 2024 17:16:16 +0100
Message-ID: <b231e85f-23c0-44b6-8fac-99409ba37438@writeme.com>
Date: Thu, 19 Dec 2024 11:16:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] powerpc: mpc83xx: Allow including initreg.h into
 multiple files
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Sinan Akman <sinan@writeme.com>
Cc: Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
 <20241215-mpc83xx-misc-v1-2-8cd6daae4f93@posteo.net>
 <8941d7ad-84d8-480b-be64-fcc0a3e48dd0@writeme.com> <Z2QX2B911TzstWge@probook>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <Z2QX2B911TzstWge@probook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7bd9CFgAOacjiHZ0hqF3WNIt6iC+NkvJQ87AAMmDciz0GGG71Py
 L6gzlMRYToY5GWKxFPNnxYW5c4IbSesJ2xp37bX9hHuztTX4T/WKql5DDeKfOoDT0dbD6pB
 BV/cr6qIZKj04rm/OhmrqRJCDbAcbH4wNv2T5usfbLao9/0w40P4yDNYMgq8jne5LD3mn5q
 iwa3swWQt3gXuLCeOguNg==
UI-OutboundReport: notjunk:1;M01:P0:bnHEROGe3kY=;W7P/o8wLoRnLvx6JGywoyvpLr3B
 fvGgCuFNqc3aj57S1Jcsdf+X+YCZhG/5O3HXsQ25QYGuow/gyMkMlK2myHMekq9r+C8kT7wwq
 MC5aVpNa7CNTAke34z5ZcldPQQiso+m6V842fPESbTCl+uQZxRs3/NRUTj2VWxT/k1WXze+HG
 kjDQv65WCYqFHKK4IetdQYGxda3AYkkngabGI2U21nyPvQ7gMBEso9wyQemBANNCUZCBaiIkN
 eZ3x+ZmJ00RautyoBPo478WufERM9O3hGMiQSNXdN/HKBzCBjbfgs9NayCeMWfnAy8jeIHlZa
 goSZgvfa0DCPbvDF3+nTGbhh2rPXRYqMgVNiZrbfGllQMGaQRblSGrqmlfXnz4xWhntT8g6AT
 9XWGnY24w8HjAKwGg2BBH1fb6Gjww4dzI7nTMT0OIsdsQpWmCUkwDgdDjBDcOq22LhQ9TAMdF
 tzvM4cO9D52SkfklsXMZRjqXh8PPs8RTxnfgVQ5jEWjvCZIZLPEYXHxcjmOIvRTtsjWx9uVZ6
 kVjmWR8zqFI//IS+6ZAynvlFMxbIdj+8IRVvdhqZKz0UkH1YPx0Y1Lb+sIz7LXq5sScMGN5gs
 MknOWECPAa162rNWsVtX9xtm+quPpPF7ptSLNPDMjVYZbp5pckFxIAccCzX9Y4fF27bg0i8Js
 L60gIW9Sad4l8RaZOz5ncEJL/BMAMUeXLlENuJeOl9qrjnlSgOQqA/P9AVp3QFmTtyH9elUnU
 QVOKf50WsZfGuDOlZroXjkeh19t/PMEOBVOTFTkEJC4IO3ONR3DlC80vee09FhCLHH7gYMclp
 yFyEzp4CyMv5CPme6t1aOdemeh7gvDgL8Vc7R7mkSXfGsK2LqSTN9l/KTUyF62NOLIRSNc0tD
 XUQoDGZM5Nw1WsC754HbB3t+nAmVKHfgnOIF3oaeL1ldjdmBFFl9IJgBFqPAun2Lk/j7n7Hh4
 2HtgqOA4OlABZqQDpNnSqWp5Umqq/6NqrkeBVZiA8tVUFGn8ZCEFKD6TzrmvxeMVdIeqEjgQF
 0iWOlg+IhxR72I7nFXk94JHI8lGxRW8UWK4CM5ymBovNvRB4kkdhM+JLLQxxtZhOCDwHoFgpz
 nei3OkC1FnsEzmbtIW3XyCV4XAQXSCMIg0a1CRoy8nAk19HhoQUeB8BnIu7cKOd00fXLSkDfw
 =
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

On 2024-12-19 07:55, J. Neusch=C3=A4fer wrote:
> On Wed, Dec 18, 2024 at 02:18:48PM -0500, Sinan Akman wrote:
>> Hi
>>
>> On 2024-12-15 10:18, J. Neusch=C3=A4fer via B4 Relay wrote:
>>> From: "J. Neusch=C3=A4fer"<j.ne@posteo.net>
>>>
>>> Globals defined in headers can result in multiple-definition errors
>>> while linking, if they are visible beyond the current translation unit=
.
>>
>> Is this happening anywhere ? It seems you introduced this in your other
>> patch :
>> [PATCH 3/4] powerpc: mpc83xx: Use defined constant for SPCR[TBEN]
>
> Right, I should have mentioned it: The problem appears only due to the
> next patch.
>
>> If this is the only place you are seeing the problem, can we not protec=
t
>> that the file is not included multiple times ?
>
> The problem here is the inclusion of initreg.h into multiple .c files,
> rather than multiple times into the same .c file. I don't think there's
> an easy guard pattern against that (the proprocessor won't help here).
>
> I think the benefit of being able to use these constants is big enough
> to justify this change.

we'll go with this for now, thanks.

Reviewed-by: Sinan Akman  <sinan@writeme.com>

>
>
> Thanks for your review,
>   -- jn
>
>
>
>>
>>>
>>> Signed-off-by: J. Neusch=C3=A4fer<j.ne@posteo.net>
>>> ---
>>>    arch/powerpc/cpu/mpc83xx/initreg/initreg.h | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h b/arch/powerpc=
/cpu/mpc83xx/initreg/initreg.h
>>> index 63aa5c946696ee0368bb3453b40ff0110f0fbcfd..ea1176e7fe10dbb549125a=
b6b2706fee05a92734 100644
>>> --- a/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
>>> +++ b/arch/powerpc/cpu/mpc83xx/initreg/initreg.h
>>> @@ -13,7 +13,7 @@
>>>    #define SPCR_TSECBDP_MASK	0x00000C00
>>>    #define SPCR_TSECEP_MASK	0x00000300
>>>
>>> -	const __be32 spcr_mask =3D
>>> +	static const __be32 spcr_mask =3D
> [...]

