Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1155DC3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 02:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3C58091A;
	Tue, 13 May 2025 04:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A53C80C83; Tue, 13 May 2025 03:52:33 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 124E280584
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 03:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=hal.feng@linux.starfivetech.com
X-QQ-mid: zesmtpgz6t1747101123t187a6898
X-QQ-Originating-IP: JKHQKTTExm2cp1AJ+g5Cnh+ZcBgMahN94eRKdes9wO0=
Received: from [192.168.125.115] ( [219.128.232.47])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 13 May 2025 09:52:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13975804235117325434
Message-ID: <A943772C5A99C764+6288fd5b-22fe-4a9e-8dab-50d293c685cc@linux.starfivetech.com>
Date: Tue, 13 May 2025 09:52:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lab failure on JH7110 (StarFive VisionFive 2)
To: Simon Glass <sjg@chromium.org>, Hal Feng <hal.feng@starfivetech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Minda Chen <minda.chen@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
 <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
Content-Language: en-US
From: Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.starfivetech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NzSDQCFWCzVTuSBU+mSDxbXOrQle/P5hlyDTMtX6nnkoh4OmMwNxqgnT
 TmMXtvXzhIYE4/jVFee/39WdvvBkkarczpJ0+hfHRiAqXTqzoLdA1YPpJ91ovajRwLjGBs1
 U/Bli0Xkf2XZ6HSRWwzi7PbkIVmCecN5604iGHd2ADqTsgMNdd3J1aag7qgDn58jBDSJaVq
 UPQ534psXa5LCMZrEK3gwByX/vQeF0z00+IJAmmrouErMIXXFnBTjOOmxBxujO4+h4d606j
 89mLEgrnpPeNbPlq9Am6Y8G1jXtz3lscXCwX94QRwFk0K1mENlOST6DR0RqYinY/OB9LCdq
 GpxXOKetvwI2mMpywRKNoTFzFLs3kS+kjAebTVOLDXXJxzNS5OIx2fmUlfhOSZP2VVNtMwM
 d2vlq763gLI8yaHqdvu5xUH9sexOlaFFZCdsYGeQndgDzvcYs/d+li3UHv2Ub+JVq22UpCP
 Siu7G7mlKMPxkK2T4ZgdkCFdRX0tdsgH2L4NtNeoBQ7YWUPHLTUg6v8SQmEAfeFq3V2gzF1
 MBOUrYrogY4FuNONWQmGMtaTuHOHPY3OLYyQqB/xw5Z/c1Vff7H3Mj2kCqYX/u0rOvTdknl
 Fqn2+BuavNdP86sHKGUgTyDPhPmZQ2rBMg2frxhN8bPS1OnwQvGdSjSslH5956HjKurr/iH
 aVxq86BNArS1lAZoDlZpj+0lR2YFT2JQo0MWAhitkmiSt+4CTk6uq0gK83kRM+nCyGKszT1
 8fTbKYGeP8g2pzJ3k3C6ngWCuQAvNNMV9FSu1c0ndpxDkgIWq0D94myidti9s13TqEcf/0P
 IHDR1llAWddkOEbkpSKQm+uIcT/rscf6bqoi+eEF1KwjbiQt61Zmb1+xdD+S3cKWmUnZrf0
 xTMe3xZoQrKoFgZ+2N50J2TKJBoLKaLuVKzIHvXp5jLC8E+jtOdcee/+dmpJuaq4XXqdg6e
 SXERilCQvAtEaBVwUsx3WVgQN1JRaEMfj4hUVVzr/zoTKYqbHTgQu6Xhbn8YYTEKmq8s=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 13 May 2025 04:12:06 +0200
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

On 5/2/2025 9:38 AM, Simon Glass wrote:
> Hi,
> 
> On Tue, 14 Jan 2025 at 23:56, Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> > On 09.01.25 20:37, Simon Glass wrote:
>> > Hi,
>> >
>> > I am seeing a lab failure on this board with the test_dm_compat test[1]:
>> >
>> > =================================== FAILURES
>> > ===================================
>> > 559________________________________ test_dm_compat
>> > ________________________________
>> > 560test/py/tests/test_dm.py:20: in test_dm_compat
>> > 561 assert not bad_drivers
>> > 562E AssertionError: assert not {'starfive_gpio'}
>> >
>> > Would you have time to take a look, please? A patch to fix a similar problem
>> > on another board is [2].
>> >
>> > Regards,
>> > Simon
>> >
>> > [1] https://ci.u-boot.org/u-boot/u-boot/-/jobs/14394
>> > [2]
>> > https://patchwork.ozlabs.org/project/uboot/patch/20240611200156.224552
>> > 5-19-sjg@chromium.org/
>>
>> I will take a look. Thanks.
> 
> I just wanted to check if you sent a patch and if so, if you have a
> link to it please?
> 
> Regards,
> SImon
> 

Already fixed in commit b6d150b9496fc42a2c88515fa14426ac892c3500

https://lore.kernel.org/all/20250116034534.91513-1-hal.feng@starfivetech.com/

Best regards,
Hal

