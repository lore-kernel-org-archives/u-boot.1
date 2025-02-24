Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494E0C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 15:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F2A805C3;
	Mon, 24 Feb 2025 16:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oWiITDEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B058081A; Mon, 24 Feb 2025 16:54:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C369800B3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 16:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740412454; x=1741017254; i=xypron.glpk@gmx.de;
 bh=gNfNlRb2s+PFCFLkolP85zi+xuia2yPsCby++xlU0uY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oWiITDEzaaMTDTbQlvASoS8HqADW0wE2DB9u2OoNGjRO8pMC6V4TZyOGUG34gJDR
 cXoQA+4OifgtTo7vR0Kx/Jo7qn7iVeUjr9ghc9W6YIR/Z/hHMBXIh3ebZEhe9ZfIO
 ghSws4DBFRnzQBowSRWZH0mppVvYnqTwWjmMm8lX9y87j/xp3k8Nd+dnBYCCl9Fcz
 S6C+nCosohqWX0obVbi0yZzx8r+e5Ad2xqJ5v1RdpxL7Y1HP7pbw7msrJYfwuA59T
 KoY27uXypaLa+EuwQRw9JOytSYPbr1IABt8QZ4yOyTzs6uImjCImhCFJDlv50rUG0
 OqJvYjPd3eaytwCwhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1tnmaQ00pY-00StLY; Mon, 24
 Feb 2025 16:54:14 +0100
Message-ID: <31342144-345b-4dd8-b80e-f53376a591d8@gmx.de>
Date: Mon, 24 Feb 2025 16:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] spl: Align FDT load address
To: Tom Rini <trini@konsulko.com>
Cc: Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-11-CFSworks@gmail.com>
 <2cd9e4dd-cb85-4661-92d2-fae4bc54ad05@gmx.de>
 <20250224145657.GD1233568@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224145657.GD1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UvixW4609E6QXSZad+fEFMnUp0M5y2F/l05mxBGTvWrz1Pg1JfV
 iD8sRRdOdwUe/DtWVyPWCQZ8/b1cTsdopBAoSm2vuNmLyKONRpcbFFV+3NOONKmFw0JuAlG
 8G6X2dt8MT9FiS28rgLRE4DV8X2MnvfPkIfrfFQz8f98aUl6s+MfmcK42TewEYMXpGJfaip
 Rq43TVq6KMxlcf/af0BGg==
UI-OutboundReport: notjunk:1;M01:P0:71GHNGaAjuM=;MdNa9RDvUNWhKjIV6ZcdNIlreCe
 KJj5jDZt/irgI9PO1AYd3pp5/b5KiFlL2gnaL3tZacNL+7tdVN48mLvxiajDpRfK5aEqCECUE
 ebl9FiOtIz8GTS1dS3GVN9Ej5TD1t8gG5e4deiP77LXb/1G6FfEBE6TElQZe9FG57IROU1+WS
 rMJgBiYMzj97++DsHFMplwQ+vf20ITmHjEZoWhv5z359w0lMSZLJ199hP11XZPDOiGtpAi1Gx
 629mwjkg6zz9frF+CYu9nolveFLyJpz4yuo9L8K5ujpER8vBrLTTyfmc4MDZxXdzOR0JquX9T
 7ZgAllGKKuQ4KLN8XV3TQzIopCACDtoAFNLljvcmpiClZFfrLlqi1G/CsoZ+cQ7ED9hjX93N3
 jzeE3IxAM8poAurc3zRxbFhMhyZob36UJ5navu5q71Axt3EtXcLKGsS2sUedMNu36lp4WCX5u
 Gct9OM+qAewq3oKBxbbFQowR8h7zb4rPofsIKuvZqKnTOM2Qv2WcqUxVusMXdo+rcAYajXF8a
 F461LHx+N7k8wB+sL4JAqdNLm2IcQ52PnjRyE7jJ4TUyu+5UXCljuEvOmsK0URzDrMCnDIpuC
 dEDEojoaJBt4YUi3J8jd8FNiSlYYCvEPIa75bsztHOPoMaX+ja/01c6efsidOEi7PlQkAKgFb
 HLnwlkVd3PgYnhUE6oEgdnl9+Gw0Uo3Se2VIYYzkn+aipd1xYwh/mjZzoNJ63N9Qf59yPfqA0
 21QS53IwfoFJ4amp2JwaXCBuFBjF7uklq6xJay/l4rQIPAz1yUkmdYSBNwTYm5oU+kJzp4iEo
 u6J5ljDuipIqXcVKg3rh8e8+c4Ueq44W5R5tibUJBUbt4nAtN9yRPTIi0lMRx9tg1MVky/o97
 pRKfTpG0wnb572LFKp/c8YnLgJil0c/zfKeWEvHTXpWMpgv7KPiAy5b6QyWWx4h6Hruehnp8p
 qtsQluszIAcdnbCwu7LbEaAfDHz3tpc4oMC2z1E3E07pSScdi+VW4SwSaN4n+UK9bah3ihQkv
 GFEH/xVaqyqD/6QlZO3Bb66RHOV89N4nwHz7bQYOwnCieRn+vkQS7LFPJpSsIG91j79tqpmT5
 ogptgqP2AC+TG5ZiDxpw7KItz9U3BMB1Sxi65mSly+9nMSMnboR94/Kw0JBTeQEvonniBHqD3
 T2yvgaThZWI/GautgfvA1zjXzRbiOLTMCeg92CtzUJqoIuR2bL4l7dyPHPWodcyCPViI+0VW8
 I9AIKiiAnDKj5xF3gExEjI2cJnF2s+1WqytTmWHhZs/VGVq8RPzJbiJ3SphJmZx2liWZkPuDH
 GnjCE/30IFSARdnL3A7vWw2jIyzN3m3xhVZnemABkdQoHTuCwD3t/UFo5oPJUbGCAo6yAEJnY
 DmdausHqg/gRRgu2kVhWHlGqIG8RkfoS/ZlWuVSdLliP85JWsZcMtoyRYr
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

On 24.02.25 15:56, Tom Rini wrote:
> On Mon, Feb 24, 2025 at 09:59:42AM +0100, Heinrich Schuchardt wrote:
>> On 2/24/25 06:55, Sam Edwards wrote:
>>> While the image size is generally a multiple of 8 bytes, this is not
>>> actually guaranteed; some linkers (like LLD) may shave a few bytes off
>>> of the end of output sections if there are no content bytes there. Sin=
ce
>>> libfdt imposes a hard rule of 8-byte alignment, make the SPL also be
>>> explicit about the alignment when loading the FDT.
>>>
>>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>>> ---
>>>    common/spl/spl_fit.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>>> index 49b4df60560..86506d6905c 100644
>>> --- a/common/spl/spl_fit.c
>>> +++ b/common/spl/spl_fit.c
>>> @@ -397,7 +397,7 @@ static int spl_fit_append_fdt(struct spl_image_inf=
o *spl_image,
>>>    	 * Use the address following the image as target address for the
>>>    	 * device tree.
>>>    	 */
>>> -	image_info.load_addr =3D spl_image->load_addr + spl_image->size;
>>> +	image_info.load_addr =3D ALIGN(spl_image->load_addr + spl_image->siz=
e, 8);
>>
>> We want to keep the SPL code size as small as possible as on many
>> platforms it is restricted to the cache size.
>>
>> Can't we fix this linker issue in the linker script by properly alignin=
g
>> the SPL image end address?
>
> Size growth is always something to watch for, but not at the expense of
> correctness and saving a few bytes. We really do need to fix the places
> where U-Boot could but doesn't ensure the device tree is correctly
> aligned in memory.
>

Hello Tom,

spl_image->load_addr is always a multiple of 8.

Adding

    . =3D ALIGN(8)"

in arch/riscv/cpu/u-boot-spl.lds before

     _end =3D .;
     _image_binary_end =3D .;

is all it takes.

Best regards

Heinrich
