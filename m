Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030A9C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 10:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59FB28786A;
	Tue, 26 Dec 2023 11:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LfPEFSzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C61878CB; Tue, 26 Dec 2023 11:11:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A248783A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 11:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703585495; x=1704190295; i=xypron.glpk@gmx.de;
 bh=WKkSH86/3rMjJLCe4TyTGXMiU7RrYj/N0b0l+HQQAaw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=LfPEFSzbd/FhvGYMFguUtMyaPZ9k1MnXahQ6Zjri6uiIeE5Jxgu6D1MJD0YGla2u
 xfGoptNj3d05OgmThvENNKF9h2/HIzuw35CDpPdxFCdoZD6NLPFZQ8IFpyoDPlJS3
 HwPoJj5kS5XqHIzQ0Wq5BDUyzsd7hsh7nuWqjwjORRqE6VU8bKjRGyOyNdI14Nrl4
 dO9KYnciSesSjcdHbhnw6APe+AjGErTbbVrMGF4xE2Dpusdx8bIr61ktx6hutXGfv
 ya8hEgFRFxwRp821gZACnAKV0VtYwrRCBwntawX3K7eUZSC4+BO2/ELSD8EsuBl3z
 yhYfLFb90j1XPdJn+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1qk6dP3qmj-00ap1y; Tue, 26
 Dec 2023 11:11:34 +0100
Message-ID: <f66c51bb-7dd8-432b-9579-598eb3619c04@gmx.de>
Date: Tue, 26 Dec 2023 11:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] test: unit test for smbios command
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
 <CAFLszThrHODfu-ZhHEzRe5wT-nMpXAp=UCBJC3FipTi9owhajQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszThrHODfu-ZhHEzRe5wT-nMpXAp=UCBJC3FipTi9owhajQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OvABYexeT1NsRxBY0a0+Jv+h6kQ1Uz8xu/7VOQffj6Tez+0lKu2
 Kx3CycYcwkusgFrCVquz1ByXBjXGHYqdVexwu3vZG82MgKUsClsGazxxpmcztMEwVMzpZHk
 fOFSsZUTLv48eMdhWvXupl5U/Wpyi4zgp0ggug7SyGbpZvQ7Odu1+ilYFa0N01nD7WnzpUU
 410tLIJTOyAtJlbwkWZ3Q==
UI-OutboundReport: notjunk:1;M01:P0:503pTXa/vcY=;RHuzWc4/00BUNXDfui6lxgLp5U1
 P2WQue3XBFazz8WKFRdYunR+0C9ipzoCtTSjpaGzenlkm+dwm6KDXgGGW9JG9K8ii4FVCuaAa
 lZCXwOc44qW4WHPRDM7RJU5BHVhAfBGKIIput7k6iCNdcsEJw07J0vQ15Y38whrUB+AEWgMg3
 HJ9TatOoleA7K9iFRl1vt64OaySsSWxCZcvUNDkGPbVd+lpQea4oLnp2depBclZxTQkWYpO92
 d8SHcAy9HocIOiN+VgTRD1I2E3A0nXBpS8sByKLorAjOBlECnN1rKPDJrOkCbcmFz1shdCyXQ
 l5PDsrU00As0kXca2TWWXkwSBkqpsTg5L/M2aCHs1c8SG8khChUv0drwX1XIhVlC9cSjZIxS3
 zD1bcbHH3HMgmQzhWHVwtD84pcbfaHJx9i+FqKgaFVXzvha8HLGJ8LI8A9sAnelbZlje2YYu6
 E42UlEikJoVAjN5hVwre1S7dlidG3/qLT7IagLg+W2KxQlt/NJEM1z+T1GPyOISnmC/QJDwoI
 JktKrkl5yhpUuC29n2uh0oAzII/fmdBuqb71mtadLIcSS6ba65hze/58KUsf3Efg5ZO1jjeLB
 sesIN4qCBNNFROJ9aUrbsRnwFBQgT9JHhmCiGdxx19xzupflB2qmW7kmOoSdG8rpphjBY73du
 fatoz3bZKyGYq/4I6WYoWXr4uuFTdcZ8ncvePklbUTguROnXOzfks/giIXS55R35w5eKB3/Su
 V26cQiQG1pAkqbF+UUt/JBBcY+GL6t3hZyoWiS2TM2SfYt5UPbpWLuRJtACXo0Uk9kxjy4Wmf
 e9DNdiAxPbV7iC/dQjokojC4oLls8eolWrdKTnoR0cgw0+DrYuNBmNni/J0BS//r6ttD88dEK
 TtVdgTfvj6gXcW4EUBRnE/Zefv8/MVuU7XAZDWHuPAjLaNJWrHO6eCeymm91hjM1Nk7e4FpvH
 TRflexyAGMvNtT+bEHGiDzgXJJo=
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

On 12/26/23 10:47, Simon Glass wrote:
> Hi Heinrich,
>
> On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
>>
>> Provide a unit test for the smbios command.
>>
>> Provide different test functions for QEMU, sandbox, and other systems.
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>   test/py/tests/test_smbios.py | 47 +++++++++++++++++++++++++++++++++++=
+
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 test/py/tests/test_smbios.py
>
> Can you please write this test in C?
>
> Regards,
> Simon

According to our documentation we can use either Python or C tests.
We generally use Python tests for testing the CLI.

I cannot see any benefit in trying to write this in C.

Best regards

Heinrich
