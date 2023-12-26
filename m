Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D127EC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D0F8786A;
	Tue, 26 Dec 2023 10:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YV4WhjQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B587B87872; Tue, 26 Dec 2023 10:58:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C365E87835
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703584692; x=1704189492; i=xypron.glpk@gmx.de;
 bh=H/9tTjEmcAmZvNfi6x6S6JkIB8NySkU7QQ35I9esaFQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=YV4WhjQr+S+J5k0P/PYQET00KlpCBMAc/Dpos97+Ru6Nb1bF315FBaUnLYd2qZge
 e0lhLo/9JAwKMv6b1y8WPgdiF0CivzG7UY78dvW+JgnSsAX5RUykH7/rT2GgtO9d9
 27cqiz3z+tuYZghujMKK+IO6Ldu7SHGcvsbdT8pT46Ut39otw6EAroowSU2xgdTPV
 0iQYom5pthM8G0mYNDsaZMn2CdUnhl7wFbbN9YvpFzvijpOedTIisSLl3ZDh22LD4
 0bTzw5g706xmCyMhSf1Jb5g0hCIy0VWv1YN6VFIePi5jjEFYAvNKoYe3wUp8c/bWq
 77IfMBPo91ep72yFWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1r6C4v377V-00woJ5; Tue, 26
 Dec 2023 10:58:12 +0100
Message-ID: <e9a835ea-ea99-4db2-b5ad-ba7742397d46@gmx.de>
Date: Tue, 26 Dec 2023 10:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI: usage of sandbox virtual addresses
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <9f681497-d13c-4ccc-9209-7a8b33e3195c@gmx.de>
 <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszThsThxhWCgP+UHmA5BxRUUBfDP7SDahtAm5WOrHoT0xhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S4J1uqvli6jOlqpT87/kWSK2T0Oz68UQTc4kOKvmPRPJ6rYmigL
 RNO8o1sAn8eTdzRv5gXXrXocCXA1X+/8LS3NNDLETXf9KHLRXi5V7WiRggkDEqXmzRK5rj2
 VYgEY/6u7HV8IAA+NHRq/sNeow8M+IJFZkbbkJ3peAmpNRBcPa1Id7TXZxTglCXCS9saoYn
 Nk8d3stENlS7dgrzgM9kQ==
UI-OutboundReport: notjunk:1;M01:P0:aRcvt/XWQDc=;gBfAgxq6QDrxINzA+nsNC5WjXqu
 ZTPKa237CrzymaLAFtZtMhFxTuENEXoynuZ7N9tqveOt/0zy1Xw4uD0f5TsLvM5cWmspLNWRb
 EhfLIIS0z3z1j2FtKRiGMhZWfdBWk03/lkuGm12MODTWpJCVjkjPZt5u1+gE28N53jRIJKFcq
 NHMn0VFTDZPzLgoG0JFbpVUW0eOpNANaz4K4os6HPqGWYIz7Qa7ZzMP/HB5VSN0LI2Pw2k+1l
 U1mLLkfvfWyEficXmsVeuCvf8Kd+/QQ0JHipoOFlQLbRCZfH0i1BR9GZ/B7kH0yTgtsJjgyFI
 jU2L06iM2AuCbOeUtB7T1NaBZDlsalODKDXs9MKYOGQr3WnMP0rh8wGRXsEnqmtKpogSwiGzh
 l9a4jp1Oy3TtNyczmF87AXqr/CetEYEtHrfHpAFK29HDfSeK6F1lVDYxo5ZXQRbrQPqy4mGuE
 BTkMydUsGWQIa+Ppp5rnfLTTYCniPdqxt+5R8Pq3r9VPYEHmOy6ubaIJz7yl3GmEwatm1g40a
 us8IWnd/vFaowHXfLWglY6FGO5lIUho4PKfBvflkzMogrW5OmxJgzmqIsemDzVavoyYcvkBzj
 axa+UxQ7n0T0o1I2+qMbawvGp2TE9iqYpgFuGAQl1fCQDcbKxEut/z/BNe3abxA6B+W51oAG5
 brVL/jq/JBHhDANkbJTIkwiVZMesXOy6Z/6qoPGGuAPpt3qRoa6zga3x8DCBb7XoWd2iOJpqo
 gYKBJrkhRoYgKPozO/FvfAthuGNFj1zzb7MZYHL+mwl8aEiVHdDKxlNDC+TFlKVTQOg0azsfB
 XcLPOzold4c/xelkPvEUbG/+sFhchaMYabrD72e+jcprt4DZxbwNZIpTEHchG7Bcx6oTEosPc
 y4Bblk29GRPQVTYtHypD8yXdjc2+1H2R1yh5ZRJB6nPZtpXyDq45sw2UdoAP4WOWNkNoSllJF
 iFfosUbpe9Z7LGNYajB8P+3LXb4=
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

On 12/26/23 10:50, Simon Glass wrote:
> Hi Heinrich,
>
> On Tue, Dec 26, 2023 at 8:56=E2=80=AFAM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>
>> Hello Simon,
>>
>> currently we use sandbox virtual addresses in all ACPI tables. This
>> means that an application started by the U-Boot sandbox consuming these
>> tables will crash due to accessing invalid addresses.
>>
>> Shouldn't the ACPI tables be migrated to use valid pointers?
>
> The confusion arises due to the difference between addresses and
> pointers. If we store addresses in the ACPI tables, then things should
> work.
>
> My approach has been to avoid using casts, but instead use
> map_sysmem() and mem_to_sysmem().
>
> Which particular piece of code is wrong in this case?

Tables DSDT, XSDT, RSDP, FADT in the sandbox contain sandbox virtual
addresses instead of pointers to real host memory.

All code referring to these tables should be changed.

Best regards

Heinrich


