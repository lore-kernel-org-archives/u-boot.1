Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC11CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 17:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC04981E13;
	Wed, 20 Aug 2025 19:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NCdGz9ZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE78682B07; Wed, 20 Aug 2025 19:53:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBFA9801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 19:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755712398; x=1756317198; i=xypron.glpk@gmx.de;
 bh=9u6cSmX6RzMDKXuw//VeZN9h/A288OXQS5ksVSkf/3k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NCdGz9ZYVsx6JiaREx0yy8OuPVjqSWdcFWbRNpBJ3rZzSR+/Idv3F380b0/2lrO2
 HQZXU6D1NnGN+BxvsObai9W13cHBUQ8MMoQe7z1DygUQQ7LAmi+vHzWQ1LWO7LL9h
 FJpBLj6Qy+BP3lxvJdJu0KHcaCzpXIZQBm3JyQ+h2c0Q+v6zxsyhVRmxY68saDAMd
 kKqR/8xyet4MmMxlgzs/tJxlGSOWnBnTmkekiLsniKvWWNk4/EqBep/KPWxXV7zsY
 1EMN73RLiXR/D0uRFpTb8CgLa8KhONIVyD6lcMfITGjFkS2+U3nTW5oCSSQMSSICW
 RhmUKny23k1f819omQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUqL-1ugqFV0AjX-00BGGC; Wed, 20
 Aug 2025 19:53:18 +0200
Message-ID: <bb0e0d75-fc5f-4135-8d8f-75dc9c166420@gmx.de>
Date: Wed, 20 Aug 2025 19:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] arm_ffa: Add FFA_MEM_SHARE support
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, abdellatif.elkhlifi@arm.com
References: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
 <20250711144917.1876948-3-abdellatif.elkhlifi@arm.com>
 <CAHUa44FaLZTPDGrBP-=G9BMBAKDN4BCkJ+DzZajh+xVZQON9RA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAHUa44FaLZTPDGrBP-=G9BMBAKDN4BCkJ+DzZajh+xVZQON9RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OCLK15s4WmaJL7iS11osq43n2GvV4Q07MWLbSgowD+C4P2n7OoQ
 wRanOO0fhK3mrkP3ndYAxFwXia8cpVehNw5SnYSlkAvv6SWc0hjUW6X2YfKTDv9r89DgzWq
 Yenuc0TkJ5p2j10xZYXOfFDfOwEfaSTgMUs6jYXI3ZdcRB00y98oLCPMeFSx3Boa2LmYOm/
 EjEKcjR4hPjMbOwhSatFg==
UI-OutboundReport: notjunk:1;M01:P0:XTlYjcXMaIc=;F7pZsaYekIrsRE4lHVSJv42ZMXl
 koG6bf7crlF7m5UMPWdrzRXU+KvOmJ6AZl9O79ZknaNPVDJoe4jFejrWiRGvhQnY3ejXP19eO
 rp0ZPwLpFxh7NODnU5SdrsLBtAT4rlWJXLiMQVXvGL69MkPZHL8kZNsKvAmEbPjtkuEB24jNR
 GJHW7DbfckL4W8Az8CwOKHv68jYBZBuLRItZPcj5D2qWID+qzf1XONI0gCWalILPvX6xOElQT
 0cTLaQBlmj0jLjF1dI8HGCG2/jOuWWHi/8MEIsXMiUa4qpfdkZSDC8I9epINKZGxaTmJmZBvv
 6jViTvd6H3J7GfPXpE4yEzeLen90CYSqsflxxwgb04+tNE+1X7ysnsxGd4AtB0JeCKaxHDoYl
 8dV1D0Bdm0grqrgoFYOj8pOEj3r7ol+7QUVv6tZZkzcAov1plhfZDnFeKf/P8iiXoj1RrlMz/
 HGSNeZyzFkt+vDSTU0JhJB43VkrONR/s2bV3xytrxFsmMHzLlwmMf/B8XoWyal+aPv+VTEPN4
 ekSQT2wX1WTfI2tNWHjEJiPneK3cHPpThJJvHhYrYhi8baPV7xqWJxvKenlf4jSm/weUqUMah
 5eYZ8cK5WUyNrGMUeTcxgs6riy0dOMJ6W230qDs6DriJZrWXvV2pmsAlnMZ6Rym2ND6CKBLp5
 KFKMK7lDeO6A6eowBQZauZKVc095E5TNfNMKwBmEbBqiD9avN3fC0fRTS/o9pZP3jdtAselSK
 gDmWM4c5ZAIoIOIuzlAzwy6EdoAR/lHqAzOLnS3aBSrKpJuM08IKjB149/OKK+3nnSdrp2d7a
 PwCrDjdxNolIxZCiuKdOSRbnhN2tC13mBweXe4BcTv13iuyWQ5DDt+ASJDeFpihI7RZMylNG7
 /1RvvmIY72Gpmz4TV0MCXp9M81UGihATte61FZNkSSlYhVOaCg5FFYZxXhw0RLx0iSL/AF8LR
 fiMWN2JAJ89vQou8P/DNgJR23XVAqG5goYYYJlTZ2cCSF0fxdCIc4qeYO2GlupKCY4Qt6vDpg
 8XyG+nt8ghuCH501fcKqW8IDrsV+LsM5h499mb8kQrKau/aLr3Oj/u5GbdN3qCY/RhASFoLen
 vzGFDUBn+9UxFvbxqDsvCiiwcgSgwQeyLtOCEIxUudjRITGOABNEmm+H6RTBhzV/xon8wcsYC
 QCWNepM99SV9fiZNjENyiEyVG4B+a6mMvCLGuPyOsEiqHFFItLzfoOaJSSWYD8iMfS8fSDiHv
 acrsNRkBF5uiG1HHT1MuARKYv3islSbMuogmdFEnO6U29EPjzZNDUyjINSje3kcyCwDgRBnuf
 oSg/GSBaY73x+EQFjciFjEh0k6iwNN2DuMml4kCtywHnXjjbU7flokrCBKN5S2apRj6FWVpD1
 3hB0mB260lyy7Sg1+C+FlxcPuh1bBGZpWCpLZFYUfTTMm/dzC0VxmzCN3hvYxKs46KrijIbZO
 hgpLjwJMlqhuqKDn29y6tLk2VYfpt8iiLTcsB1wGOk8qbs0KR3SQceuUTbqHoIjALsrPXKE+y
 +ZuqFfgteXnMF0SwksxX8jp/xCKioHjluXYbx67dxzRiyBSvR1/L6PVX17SQPEZaRStA5aCDI
 NrZO7iMTtvqIvB0O+KsdP3poym5SeyYgaTN+zoEjik/os/kDEmU8YTGu42lOpl+CEzoFJbOHZ
 ULLOSKxmz2PmE5xHaWBll/IaUeV2209r+Q47+yMFLCgCUQqjBT/A9Iq54aIL3PuRNcxHZDQET
 W6d3GYZJmRcYJQgUeAqwwqMwoJZ8d/Yfj6RdEYkuD/A/oEwqo/pGVpFP+A+lJ1befqOFdYhzM
 UUMj/ArnGK95WAE+oz1fYubnmiTnZ9ppupR8TLHGwq1mcj89RZIM6i/cXDSHSbChMoFkZIDnP
 gINzo1ZoCVK5Y1Usid6QEDmeJhiTK/9OuhSjol09u/dpK/oSALU1lAg0MrITKw4VYfpu8dbe/
 8nvLXzykJ1txNDr133wYqSCD3XrW3RC+GsjP+Co7NWemqpzZQFhJbYUikeaBnMQf5FQ3TNT7C
 SNoVLEpqDhNCXOl22RDYbrAUm927LQMVFfue3qbOxvXd/H7RhNG75ZFZu+Qx+JfbR/bE9GcGz
 f+3vji+n8SrNr1kUkMtPmi27c277vcuj0jsFX4pgKAD8m/1ZmxLzCag4zxSVQ4LLhZirV+wAG
 ZJWsMg76020mgCyOthufYtUUhwquNH0zerOcp+d9sI4Buv6JjFxvtgrmNDBx+oUUxCBUoRgpz
 B6SwrZE08v3cX9eSJx4o6/laO6oBfRkyWVDEgK2II/DEQvTYwSPx+LKRCg5GE1uen2AKVAbpC
 VyuVr2ZaMrxZ5sp+DxT6zGzvhLivmKmvQ8vDih1C8cSba9JRje6PaMa3kAXfTQom6jmj25DSa
 Ya+cqrUSNeSWWye27nCWc1/yv7Bm6x9T7Ou6M5iYrNF2ZC+dWZIiilPLHSwE/Ew1eV7cCjZgz
 uLi63VoINqBHnSniN9s1rx1zFzuwy3QAEXZQ0tqffw2ND7jQf4CuqKMs6e+bj7orEbaZR3Baz
 sQVD3j1XrE1tijTo0Vu1Cr+WibaSn5mB5hrNleV4V+Nkc4JsM5FNQT7Kv09bNBBUqOqR5SaqV
 /ZalXjO5JtPLjxOGeuY9Kp2bie8ytB0rmmUEVh/hgvRqFcQI9FxhDVEezeBqhXescnk0dyhx8
 +H5ds7Rz6MwxIofxvU6GnK/ivoj0nPm7vVQ8LgSzrxrvDSC+kpcy2j95YricHfhq1BHpr+Fpb
 4b8Jxi/6ZARXuI94+y2FAhvoP7UcBtxe28U8C2t4Jq/faXNonoeHLzETSvA7baGEHQhFztxks
 IWiKGcJknqy0sZYt7ah5DyDkbKJIpvRbGUN8/N7lP2g22IqjIg4rt0ZlF4Jzc8Eznsn7ma/Ux
 R/Rnq4rqrsZZrIsOT2bfRccSmLhn1lY263YzyBD5Cf/9fViY/euLyIGmPPfyivbhD6wCVgccl
 ncBV5dm3wMoLXtN6nnA00mp3NdLA7MPqhOWNxISWLFvtLFNQsO+tH4OKWW5YLhf8+vRBWAEbI
 VprZzULVtT0y8mNTPhM6ILtvRMETeBy3jwivxYY0YfbtITfa+Gw3YX74NBFtKaoaMA0+h1ltn
 q1lfqnvBFKHBJAK/Irmp6PlIuLZUwx2nhubBmAd9f8YHtQQHKHsDxUDA3EiKrvtacTd8Zw4tQ
 sKTWI6b3CeHuFyxDXe+/3weyIovymaSDkccc/AjOR68lUNKtSOAAU+OSgI3dh7+7JXYzGTgm1
 2oIu/PsRvC5774eQadfpDbgKIOwY7VRPS401uPMmMlCdwsQDwv15qirCkn0TQ1ATtpW8GY3AT
 hxcw966j7NEB6kN7M+K0P2glTA+aIHQ385u9AzCxePtDOP2Sq+JTqzVWxDiJ+jGNIOklFpFoz
 HRc7K/MFiegQqljBa9TjisapXcre+aEAgUC9KcVHqYkq06nPSjSpDFOfh5R0CduzYYEAwAEsX
 AxUqzhC5zpzOZGbvpj/ebf75JGHfOPwyPiULYfLDUgHbp1OLiZ2szQNKZNp5I2dkLh9sGeELs
 ulMWT0V7lncncplgtSuHYQi3cyBJ585AifvfIRVppohfp+FghocfWXzaAgjxh5rO4daNFGYwA
 s6DAPByueJx0oVAItc3g62q0eHjpVEYku0Li0KW4/uq0taPRklYRO6O8q/il4qzY7yk8r+4pG
 +uvX6sOWOBt080B6L5AxEV/j0yKgk4427CHwv0SneIc3LI0CGujVyriLwWRyZNlTTs9+lCn/2
 eEd9NlbPl8m4QFrogv6DXXF5Fy/Ltql9S4RK/I8ZzSvF+SbC0abbDXODL+Mi8nxRvyVc0rRmP
 TXZQjN9WGsjxmIFnWoq23i1dMqjODWMkWvN4joUBPahnxp3pT39AN4Qd0+WEMGVt1c6KunbSZ
 DkO9oG2PivdyJz3OS+XFn52bqb+38fEDAgIUjeThR1ZP/vwcfBNJ9RiNce7dGbkt0bC7TcSy3
 e5aYk6HgpUyE5QrRFS4WA+gu7X3hUHq1H8p0lKoUi69/JmwITp4hqn5iI/rKPIGLsH312mO26
 CLE5e4xVsdpL5ni182QkoV9ydF9287IjN2JBlfQJVOI6SECx/y2hcV7jKq3IbRe13emUm76IM
 Z79RaGKutylvziA79OExaJnNLBBBmHUdoIz1SBrsTnMCWsePsIzUZ/F36YcLZYGF2CHQNad+l
 +8VOPURRKyKrlToomaZJtcLv/LfMO8503pOu78qmZJTfHfLZkwmFMpyS3ec1IYP9vI+27eg08
 trMgb6VxxqCAzeXmv9y0ONCISG7zB1gIQQvA5PNUjnHlQl0MW4cQqeU7SZTMPQLkd6nijnSJK
 FaDNdIHGIGgJYFOGrYZfSgEOhFUMjmHwqPt8HHpC9Kx/0fbrGeekIf1B4xRsgaiv5QffmQTWQ
 /TVKFi9/Himff8KUPt2bPd5H53jsthbCYZkdzHad7xPTR9BsPpcNGWWwquXvP4l4zvklC6FX1
 yCAuIPT2CkEXZQahsF71fUxZSQWIA6c4Lxea6RyhIQMYKQSBY+XOqiWQjz2kmCI+g+ikl5tIb
 2QsIJwLeaLXlrbNcpW/StQUWyX4tqsTW72XLxKJbnuxh1m3YpUKmhq6T4AQwrkPdUjZ+iyaF0
 jQu+AMLrSzXkS9gzH5ivFscXECWMTCccNJYhhFMzrA6RKjgmJ8Cm3kjiMEitPU4QBB5c+cxPj
 tksWsEkjvmyX5DOkxV55VhNXLNInq2R0fVqvVBlhH3AwycUr4hE5q6TBGL6SXQ6SnE3TKGM=
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

On 20.08.25 19:38, Jens Wiklander wrote:
> Hi,
>=20
> On Fri, Jul 11, 2025 at 4:49=E2=80=AFPM <abdellatif.elkhlifi@arm.com> wr=
ote:
>>
>> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>>
>> Add to the FF-A bus FFA_MEM_SHARE ABI
>>
>> The FFA_MEM_SHARE is a memory management ABI described in the FF-A v1.0
>> specification [1].
>>
>> This ABI starts a transaction to grant access to a memory region
>> to one or more Borrowers (aka Secure Partitions or endpoints).
>>
>> This work is based on the implementation in Linux kernel [2].
>>
>> [1]: https://developer.arm.com/documentation/den0077/a/?lang=3Den
>> [2]: commit cc2195fe536c28e192df5d07e6dd277af36814b4
>>       Files: drivers/firmware/arm_ffa/driver.c , include/linux/arm_ffa.=
h
>>
>> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jens Wiklander <jens.wiklander@linaro.org>
>> Cc: Casey Connolly <casey.connolly@linaro.org>
>> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> ---
>>
>> Changelog of changes:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>
>> v2:
>>
>> * As suggested by Heinrich: The ops NULL check removed
>>
>> v1:
>>
>> * Add FFA_MEM_SHARE support
>>
>>   doc/arch/arm64.ffa.rst                    |   2 +
>>   drivers/firmware/arm-ffa/arm-ffa-uclass.c | 210 +++++++++++++++++++++=
+
>>   drivers/firmware/arm-ffa/arm-ffa.c        |   3 +-
>>   include/arm_ffa.h                         |  86 ++++++++-
>>   include/arm_ffa_priv.h                    | 142 ++++++++++++++-
>>   5 files changed, 439 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
>> index f966f8ba6af..3eec735d741 100644
>> --- a/doc/arch/arm64.ffa.rst
>> +++ b/doc/arch/arm64.ffa.rst
>> @@ -185,6 +185,7 @@ The following features are provided:
>>       - FFA_INTERRUPT
>>       - FFA_MSG_SEND_DIRECT_REQ
>>       - FFA_MSG_SEND_DIRECT_RESP
>> +    - FFA_MEM_SHARE
>>
>>   - Support for the 64-bit version of the following ABIs:
>>
>> @@ -203,6 +204,7 @@ The following features are provided:
>>       - ffa_partition_info_get
>>       - ffa_sync_send_receive
>>       - ffa_rxtx_unmap
>> +    - ffa_memory_share
>>
>>   - FF-A bus discovery makes sure FF-A framework is responsive and comp=
atible
>>     with the driver
>> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmwa=
re/arm-ffa/arm-ffa-uclass.c
>> index 32dd9458da9..9af574760d2 100644
>> --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
>> +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
>> @@ -95,6 +95,20 @@ static struct ffa_abi_errmap err_msg_map[FFA_ERRMAP_=
COUNT] =3D {
>>                          "DENIED: Buffer pair already registered",
>>                  },
>>          },
>> +       [FFA_ID_TO_ERRMAP_ID(FFA_MEM_SHARE)] =3D {
>> +               {
>> +                       [ABORTED] =3D
>> +                       "ABORTED: Failure in the transmission of fragme=
nts or in time slicing",
>> +                       [INVALID_PARAMETERS] =3D
>> +                       "INVALID_PARAMETERS: Validation failed for the =
Memory Transaction or the Endpoint memory access descriptor",
>> +                       [NO_MEMORY] =3D
>> +                       "NO_MEMORY: Insufficient memory to complete thi=
s operation",
>> +                       [BUSY] =3D
>> +                       "BUSY: The TX buffer is busy",
>> +                       [DENIED] =3D
>> +                       "DENIED: Memory region ownership, permission, a=
ccess or attributes error",
>> +               },
>> +       },
>>   };
>>
>>   /**
>> @@ -929,6 +943,177 @@ int ffa_msg_send_direct_req_hdlr(struct udevice *=
dev, u16 dst_part_id,
>>          return ffa_to_std_errno(ffa_errno);
>>   }
>>
>> +/**
>> + * ffa_mem_desc_offset() - helper for descriptors offset calculation
>> + * @count: An integer defining the number of Endpoint memory access de=
scriptors
>> + *
>> + * Calculate the offset of the Endpoint memory access descriptor and
>> + * the Composite memory region descriptor.
>> + *
>> + * Return:
>> + *
>> + * The descriptor offset.
>> + */
>> +static inline u32 ffa_mem_desc_offset(int count)
>=20
> "inline" doesn't make much difference in a .c file.
>=20
>> +{
>> +       u32 offset =3D count * sizeof(struct ffa_mem_region_attributes)=
;
>> +
>> +       offset +=3D sizeof(struct ffa_mem_region);
>> +
>> +       return offset;
>> +}
>> +
>> +/**
>> + * ffa_setup_and_transmit() - set up the memory and transmit data usin=
g FF-A
>> + * @dev: The FF-A bus device
>> + * @func_id: An integer identifying the function
>> + * @buffer: A pointer to the data to be transmitted (FF-A TX buffer)
>> + * @args: A pointer to a structure containing additional user argument=
s
>> + *
>> + * Setup the memory transaction related to the access to a specified
>> + * memory region.
>> + * Currently we support FFA_MEM_SHARE only.
>> + *
>> + * Return:
>> + *
>> + * 0 on success. . Otherwise, failure
>> + */
>> +static int ffa_setup_and_transmit(struct udevice *dev, u32 func_id,
>> +                                 void *buffer, struct ffa_mem_ops_args=
 *args)
>> +{
>> +       ffa_value_t res =3D {0};
>> +       int ffa_errno;
>> +       u32 composite_offset;
>> +       u32 total_length;
>> +       struct ffa_mem_region *mem_region =3D buffer;
>> +       struct ffa_composite_mem_region *composite;
>> +       struct ffa_mem_region_addr_range *constituent;
>> +       struct ffa_mem_region_attributes *ep_mem_access;
>> +       u32 idx;
>> +       struct ffa_priv *uc_priv;
>> +
>> +       uc_priv =3D dev_get_uclass_priv(dev);
>> +
>> +       mem_region->tag =3D args->tag;
>> +       mem_region->flags =3D args->flags;
>> +       mem_region->sender_id =3D uc_priv->id;
>> +
>> +       /*
>> +        * These attributes are only valid for FFA_MEM_SHARE.
>> +        * They are not valid for FFA_MEM_LEND (no implemented).
>> +        */
>> +       if (func_id =3D=3D FFA_MEM_SHARE)
>> +               mem_region->attributes =3D FFA_MEM_NORMAL | FFA_MEM_WRI=
TE_BACK
>> +                                | FFA_MEM_INNER_SHAREABLE;
>> +       else
>> +               mem_region->attributes =3D 0;
>> +
>> +       mem_region->handle =3D 0;
>> +       mem_region->ep_count =3D args->nattrs;
>> +       mem_region->reserved1 =3D 0;
>> +       mem_region->reserved2 =3D 0;
>> +
>> +       ep_mem_access =3D buffer + ffa_mem_desc_offset(0);
>> +
>> +       composite_offset =3D ffa_mem_desc_offset(args->nattrs);
>> +
>> +       /* Multiple borrowers supported */
>> +       for (idx =3D 0; idx < args->nattrs; idx++, ep_mem_access++) {
>> +               ep_mem_access->receiver =3D args->attrs[idx].receiver;
>> +               ep_mem_access->attrs =3D args->attrs[idx].attrs;
>> +               ep_mem_access->composite_off =3D composite_offset;
>> +               ep_mem_access->flag =3D 0;
>> +               ep_mem_access->reserved =3D 0;
>> +       }
>> +
>> +       /* Only one Composite and one Constituent memory region support=
ed */
>> +       composite =3D buffer + composite_offset;
>> +       composite->total_pg_cnt =3D args->pg_cnt;
>> +       composite->addr_range_cnt =3D FFA_MEM_CONSTITUENTS;
>> +       composite->reserved =3D 0;
>> +
>> +       constituent =3D &composite->constituents[0];
>> +       constituent->address =3D map_to_sysmem(args->address);
>> +       constituent->pg_cnt =3D args->pg_cnt;
>> +       constituent->reserved =3D 0;
>> +
>> +       total_length =3D composite_offset + sizeof(*composite) +
>> +               sizeof(*constituent);
>> +
>> +       /*
>> +        * Note: Time slicing is not supported.
>> +        * It's only available to EL1 and S-EL1 endpoints.
>> +        */
>=20
> Isn't U-Boot an EL1 endpoint?

Typically U-Boot SPL runs in EL3 and main U-Boot in EL2.
U-Boot runs single threaded.

Best regards

Heinrich

>=20
>> +
>> +       invoke_ffa_fn((ffa_value_t){
>> +                       .a0 =3D FFA_SMC_32(func_id),
>> +                       .a1 =3D total_length,
>> +                       .a2 =3D total_length,
>> +                       .a3 =3D 0, /* the TX buffer is used */
>> +                       .a4 =3D 0, /* the TX buffer is used */
>> +                       },
>> +                       &res
>> +       );
>> +
>> +       if (res.a0 !=3D FFA_SMC_32(FFA_SUCCESS)) {
>> +               ffa_errno =3D res.a2;
>> +               ffa_print_error_log(func_id, ffa_errno);
>> +               return ffa_to_std_errno(ffa_errno);
>> +       }
>> +
>> +       args->g_handle =3D PACK_HANDLE(res.a2, res.a3);
>> +       return 0;
>> +}
>> +
>> +/**
>> + * ffa_memory_ops() - wrapper for the memory management ABIs
>> + * @dev: The FF-A bus device
>> + * @func_id: An integer identifying the function
>> + * @args: A pointer to a structure containing additional user argument=
s
>> + *
>> + * Verify the use of the TX buffer then call ffa_setup_and_transmit().
>> + * Currently we support FFA_MEM_SHARE only.
>> + *
>> + * Return:
>> + *
>> + * 0 on success. Otherwise, failure
>> + */
>> +static int ffa_memory_ops(struct udevice *dev, u32 func_id,
>> +                         struct ffa_mem_ops_args *args)
>> +{
>> +       void *buffer;
>> +       struct ffa_priv *uc_priv =3D dev_get_uclass_priv(dev);
>> +
>> +       if (!args->use_txbuf) {
>> +               log_err("only TX buffer supported\n");
>> +               return -EPROTONOSUPPORT;
>> +       }
>> +
>> +       buffer =3D uc_priv->pair.txbuf;
>> +
>> +       if (!buffer || !args->attrs || !args->address)
>> +               return -EINVAL;
>> +
>> +       return ffa_setup_and_transmit(dev, func_id, buffer, args);
>> +}
>> +
>> +/**
>> + * ffa_memory_share_hdlr() - FFA_MEM_SHARE handler function
>> + * @dev: The FF-A bus device
>> + * @args: A pointer to a structure containing additional user argument=
s
>> + *
>> + * Implement FFA_MEM_SHARE FF-A function
>> + * to grant access to a memory region to one or more Borrowers.
>> + *
>> + * Return:
>> + *
>> + * 0 on success. Otherwise, failure
>> + */
>> +int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args=
 *args)
>> +{
>> +       return ffa_memory_ops(dev, FFA_MEM_SHARE, args);
>> +}
>> +
>>   /* FF-A driver operations (used by clients for communicating with FF-=
A)*/
>>
>>   /**
>> @@ -1006,6 +1191,31 @@ int ffa_rxtx_unmap(struct udevice *dev)
>>          return ops->rxtx_unmap(dev);
>>   }
>>
>> +/**
>> + * ffa_memory_share() - FFA_MEM_SHARE driver operation
>> + * @dev: The FF-A bus device
>> + * @args: A pointer to a structure containing additional user argument=
s
>> + *
>> + * Driver operation for FFA_MEM_SHARE.
>> + * Please see ffa_memory_share_hdlr() description for more details.
>> + *
>> + * Return:
>> + *
>> + * 0 on success. Otherwise, failure
>> + */
>> +int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *arg=
s)
>> +{
>> +       struct ffa_bus_ops *ops =3D ffa_get_ops(dev);
>> +
>> +       if (!args)
>> +               return -EINVAL;
>> +
>> +       if (!ops->memory_share)
>> +               return -ENOSYS;
>> +
>> +       return ops->memory_share(dev, args);
>> +}
>> +
>>   /**
>>    * ffa_do_probe() - probing FF-A framework
>>    * @dev:       the FF-A bus device (arm_ffa)
>> diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-=
ffa/arm-ffa.c
>> index 94e6105cb38..df904cae412 100644
>> --- a/drivers/firmware/arm-ffa/arm-ffa.c
>> +++ b/drivers/firmware/arm-ffa/arm-ffa.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   /*
>> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-=
office@arm.com>
>> + * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-s=
ource-office@arm.com>
>>    *
>>    * Authors:
>>    *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>> @@ -84,6 +84,7 @@ static const struct ffa_bus_ops ffa_ops =3D {
>>          .partition_info_get =3D ffa_get_partitions_info_hdlr,
>>          .sync_send_receive =3D ffa_msg_send_direct_req_hdlr,
>>          .rxtx_unmap =3D ffa_unmap_rxtx_buffers_hdlr,
>> +       .memory_share =3D ffa_memory_share_hdlr,
>>   };
>>
>>   /* Registering the FF-A driver as an SMCCC feature driver */
>> diff --git a/include/arm_ffa.h b/include/arm_ffa.h
>> index 2994d8ee3ae..b91b0279371 100644
>> --- a/include/arm_ffa.h
>> +++ b/include/arm_ffa.h
>> @@ -1,6 +1,6 @@
>>   /* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-=
office@arm.com>
>> + * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-s=
ource-office@arm.com>
>>    *
>>    * Authors:
>>    *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>> @@ -81,11 +81,74 @@ struct ffa_send_direct_data {
>>
>>   struct udevice;
>>
>> +/**
>> + * struct ffa_mem_region_attributes - Endpoint memory access descripto=
r
>> + *
>> + * The data structure used in memory management transactions to create=
 an
>> + * association between an endpoint, memory access permissions and a co=
mposite
>> + * memory region description.
>> + *
>> + * For more details, please refer to Table 5.16 and Table 5.15 in the =
FF-A
>> + * specification v1.0.
>> + *
>> + * This structure was taken from Linux.
>> + */
>> +struct ffa_mem_region_attributes {
>> +       /* The ID of the VM to which the memory is being given or share=
d. */
>> +       u16 receiver;
>> +       /*
>> +        * The permissions with which the memory region should be mappe=
d in the
>> +        * receiver's page table.
>> +        */
>> +#define FFA_MEM_EXEC           BIT(3)
>> +#define FFA_MEM_NO_EXEC                BIT(2)
>> +#define FFA_MEM_RW             BIT(1)
>> +#define FFA_MEM_RO             BIT(0)
>> +       u8 attrs;
>> +       /*
>> +        * Flags used during FFA_MEM_RETRIEVE_REQ and FFA_MEM_RETRIEVE_=
RESP
>> +        * for memory regions with multiple borrowers.
>> +        */
>> +#define FFA_MEM_RETRIEVE_SELF_BORROWER BIT(0)
>> +       u8 flag;
>> +       /*
>> +        * Offset in bytes from the start of the outer `ffa_memory_regi=
on` to
>> +        * an `struct ffa_mem_region_addr_range`.
>> +        */
>> +       u32 composite_off;
>> +       u64 reserved;
>> +};
>> +
>> +/**
>> + * struct ffa_mem_ops_args - User arguments to the memory management A=
BIs
>> + * @use_txbuf: Whether to use the TX buffer for the memory transaction
>> + * @nattrs:    Number of the borrowers
>> + * @flags:     Memory transaction flags
>> + * @tag:       The tag associated with the transaction
>> + * @g_handle:  Globally unique Handle to identify the memory region (o=
ut)
>> + * @address:   Virtual address of the memory region
>> + * @attrs:     Memory access permissions of each borrower
>> + *
>> + * The structured filled by the user and passed to the memory
>> + * management ABIs (e.g: FFA_MEM_SHARE)
>> + */
>> +struct ffa_mem_ops_args {
>> +       bool use_txbuf;
>> +       u32 nattrs;
>> +       u32 flags;
>> +       u64 tag;
>> +       u64 g_handle;
>> +       void *address;
>> +       u32 pg_cnt;
>> +       struct ffa_mem_region_attributes *attrs;
>> +};
>> +
>>   /**
>>    * struct ffa_bus_ops - Operations for FF-A
>>    * @partition_info_get:        callback for the FFA_PARTITION_INFO_GE=
T
>>    * @sync_send_receive: callback for the FFA_MSG_SEND_DIRECT_REQ
>>    * @rxtx_unmap:        callback for the FFA_RXTX_UNMAP
>> + * @memory_share:      callback for the FFA_MEM_SHARE
>>    *
>>    * The data structure providing all the operations supported by the d=
river.
>>    * This structure is EFI runtime resident.
>> @@ -97,6 +160,7 @@ struct ffa_bus_ops {
>>                                   struct ffa_send_direct_data *msg,
>>                                   bool is_smc64);
>>          int (*rxtx_unmap)(struct udevice *dev);
>> +       int (*memory_share)(struct udevice *dev, struct ffa_mem_ops_arg=
s *args);
>>   };
>>
>>   #define ffa_get_ops(dev)        ((struct ffa_bus_ops *)(dev)->driver-=
>ops)
>> @@ -196,6 +260,26 @@ int ffa_partition_info_get(struct udevice *dev, co=
nst char *uuid_str,
>>   int ffa_get_partitions_info_hdlr(struct udevice *dev, const char *uui=
d_str,
>>                                   u32 *sp_count, struct ffa_partition_d=
esc **sp_descs);
>>
>> +/**
>> + * ffa_memory_share() - FFA_MEM_SHARE driver operation
>> + * Please see ffa_memory_share_hdlr() description for more details.
>> + */
>> +int ffa_memory_share(struct udevice *dev, struct ffa_mem_ops_args *arg=
s);
>> +
>> +/**
>> + * ffa_memory_share_hdlr() - FFA_MEM_SHARE handler function
>> + * @dev: The FF-A bus device
>> + * @args: A pointer to a structure containing additional user argument=
s
>> + *
>> + * Implement FFA_MEM_SHARE FF-A function
>> + * to grant access to a memory region to one or more Borrowers.
>> + *
>> + * Return:
>> + *
>> + * 0 on success. Otherwise, failure
>> + */
>> +int ffa_memory_share_hdlr(struct udevice *dev, struct ffa_mem_ops_args=
 *args);
>> +
>>   struct ffa_priv;
>>
>>   /**
>> diff --git a/include/arm_ffa_priv.h b/include/arm_ffa_priv.h
>> index d564c33c647..a259911d5b9 100644
>> --- a/include/arm_ffa_priv.h
>> +++ b/include/arm_ffa_priv.h
>> @@ -1,6 +1,6 @@
>>   /* SPDX-License-Identifier: GPL-2.0+ */
>>   /*
>> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-=
office@arm.com>
>> + * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-s=
ource-office@arm.com>
>>    *
>>    * Authors:
>>    *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>> @@ -132,10 +132,11 @@ enum ffa_abis {
>>          FFA_RUN                   =3D 0x6d,
>>          FFA_MSG_SEND_DIRECT_REQ   =3D 0x6f,
>>          FFA_MSG_SEND_DIRECT_RESP  =3D 0x70,
>> +       FFA_MEM_SHARE             =3D 0x73,
>>
>>          /* To be updated when adding new FFA IDs */
>>          FFA_FIRST_ID              =3D FFA_ERROR, /* Lowest number ID *=
/
>> -       FFA_LAST_ID               =3D FFA_MSG_SEND_DIRECT_RESP, /* High=
est number ID */
>> +       FFA_LAST_ID               =3D FFA_MEM_SHARE, /* Highest number =
ID */
>>   };
>>
>>   enum ffa_abi_errcode {
>> @@ -219,6 +220,143 @@ struct ffa_priv {
>>          struct ffa_rxtxpair pair;
>>   };
>>
>> +/* FF-A memory management ABIs data structures */
>> +
>> +/**
>> + * struct ffa_mem_region - Lend, donate or share memory transaction de=
scriptor
>> + *
>> + * Specifies the data structure that must be used by the Owner/Lender =
and a
>> + * Borrower/Receiver in a transaction to donate, lend or share a memor=
y region.
>> + * It specifies the memory region description, properties and other tr=
ansaction
>> + * attributes in an invocation of the following ABIs.
>> + *
>> + * FFA_MEM_DONATE.
>> + * FFA_MEM_LEND.
>> + * FFA_MEM_SHARE.
>> + * FFA_MEM_RETRIEVE_REQ.
>> + * FFA_MEM_RETRIEVE_RESP.
>> + *
>> + * For more details, please refer to the Table 5.19 in the FF-A specif=
ication
>> + * v1.0.
>> + *
>> + * The interpretation of some fields depends on the ABI this structure=
 is used
>> + * with. This variance in behavior is also specified in the Table 5.19=
.
>> + *
>> + * This structure was taken from Linux and adapted to FF-A v1.0.
>> + */
>> +struct ffa_mem_region {
>> +       /* The ID of the VM/owner which originally sent the memory regi=
on */
>> +       u16 sender_id;
>> +#define FFA_MEM_NORMAL         BIT(5)
>> +#define FFA_MEM_DEVICE         BIT(4)
>> +
>> +#define FFA_MEM_WRITE_BACK     (3 << 2)
>> +#define FFA_MEM_NON_CACHEABLE  BIT(2)
>> +
>> +#define FFA_DEV_nGnRnE         (0 << 2)
>> +#define FFA_DEV_nGnRE          BIT(2)
>=20
> Prefer (1 << 2) here. That's also what's used in the kernel code.
>=20
>> +#define FFA_DEV_nGRE           (2 << 2)
>> +#define FFA_DEV_GRE            (3 << 2)
>> +
>> +#define FFA_MEM_NON_SHAREABLE  (0)
>> +#define FFA_MEM_OUTER_SHAREABLE        (2)
>> +#define FFA_MEM_INNER_SHAREABLE        (3)
>> +       /* Memory region attributes */
>> +       u8 attributes;
>> +
>> +       u8 reserved1;
>> +
>> +/*
>> + * Clear memory region contents after unmapping it from the sender and
>> + * before mapping it for any receiver.
>> + */
>> +#define FFA_MEM_CLEAR                  BIT(0)
>> +/*
>> + * Whether the hypervisor may time slice the memory sharing or retriev=
al
>> + * operation.
>> + */
>> +#define FFA_TIME_SLICE_ENABLE          BIT(1)
>> +
>> +#define FFA_MEM_RETRIEVE_TYPE_IN_RESP  (0 << 3)
>> +#define FFA_MEM_RETRIEVE_TYPE_SHARE    BIT(3)
>=20
> Please use (1 << 3) for this value, like in the kernel.
>=20
>=20
> Cheers,
> Jens
>=20
>> +#define FFA_MEM_RETRIEVE_TYPE_LEND     (2 << 3)
>> +#define FFA_MEM_RETRIEVE_TYPE_DONATE   (3 << 3)
>> +
>> +#define FFA_MEM_RETRIEVE_ADDR_ALIGN_HINT       BIT(9)
>> +#define FFA_MEM_RETRIEVE_ADDR_ALIGN(x)         ((x) << 5)
>> +       /* Flags to control behaviour of the transaction. */
>> +       u32 flags;
>> +#define HANDLE_LOW_MASK                GENMASK_ULL(31, 0)
>> +#define HANDLE_HIGH_MASK       GENMASK_ULL(63, 32)
>> +#define HANDLE_LOW(x)          ((u32)(FIELD_GET(HANDLE_LOW_MASK, (x)))=
)
>> +#define        HANDLE_HIGH(x)          ((u32)(FIELD_GET(HANDLE_HIGH_MA=
SK, (x))))
>> +
>> +#define PACK_HANDLE(l, h)              \
>> +       (FIELD_PREP(HANDLE_LOW_MASK, (l)) | FIELD_PREP(HANDLE_HIGH_MASK=
, (h)))
>> +       /*
>> +        * A globally-unique ID assigned by the hypervisor for a region
>> +        * of memory being sent between VMs.
>> +        */
>> +       u64 handle;
>> +       /*
>> +        * An implementation defined value associated with the receiver=
 and the
>> +        * memory region.
>> +        */
>> +       u64 tag;
>> +
>> +       u32 reserved2;
>> +
>> +       /*
>> +        * The number of `ffa_mem_region_attributes` entries included i=
n this
>> +        * transaction.
>> +        */
>> +       u32 ep_count;
>> +};
>> +
>> +/**
>> + * struct ffa_mem_region_addr_range - Constituent memory region descri=
ptor
>> + *
>> + * Each descriptor specifies the base address and size of a virtually =
or
>> + * physically contiguous memory region.
>> + *
>> + * For more details, please refer to Table 5.14 in the FF-A
>> + * specification v1.0.
>> + *
>> + * This structure was taken from Linux.
>> + */
>> +struct ffa_mem_region_addr_range {
>> +       /* The base IPA of the constituent memory region, aligned to 4 =
kiB */
>> +       u64 address;
>> +       /* The number of 4 kiB pages in the constituent memory region. =
*/
>> +       u32 pg_cnt;
>> +       u32 reserved;
>> +};
>> +
>> +/**
>> + * struct ffa_composite_mem_region - Composite memory region descripto=
r
>> + *
>> + * For more details, please refer to Table 5.13 in the FF-A
>> + * specification v1.0.
>> + *
>> + * This structure was taken from Linux.
>> + */
>> +struct ffa_composite_mem_region {
>> +       /*
>> +        * The total number of 4 kiB pages included in this memory regi=
on. This
>> +        * must be equal to the sum of page counts specified in each
>> +        * `struct ffa_mem_region_addr_range`.
>> +        */
>> +       u32 total_pg_cnt;
>> +       /* The number of constituents included in this memory region ra=
nge */
>> +#define FFA_MEM_CONSTITUENTS           (1)
>> +       u32 addr_range_cnt;
>> +       u64 reserved;
>> +       /** An array of `addr_range_cnt` memory region constituents. */
>> +       struct ffa_mem_region_addr_range constituents[];
>> +};
>> +
>> +/* Functions prototypes */
>> +
>>   /**
>>    * ffa_get_version_hdlr() - FFA_VERSION handler function
>>    * @dev: The FF-A bus device
>> --
>> 2.25.1
>>

