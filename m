Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6F4D3C931
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 12:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128A488F0C;
	Sun, 10 Nov 2024 13:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GrkzErvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B4A88FCB; Sun, 10 Nov 2024 13:03:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D9D88EC4
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 13:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731240212; x=1731845012; i=xypron.glpk@gmx.de;
 bh=9O2U0DTIAs0OWd1SXveivC0/3eShef0qWeayRxOuNF0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GrkzErvmLl7sbDwSXMe/Ijo71WQT1Xr7Wdt4UIrfvTbpNCoGhHimnZwB2O/KuuyV
 UpiQA1eNwappDPnQvUwYsUTlgzNOVaMSpzP6CXSNf0IMTp5XZDoMCPebtkhf5OW4n
 nRpUJURM4tXbZioYDftpiwCX9Cdhy5f6HqiC1vxW1XwMmCPls4Fq9wk3F2C15su98
 83xImkqMUsfWK28R2q/CEMiZQXX0t5up41ohoIkiR/xlNWp7vxpWF/D2/elnaqG0Y
 v17OmITtUKSIAay7Sy3w/TqNWvCy31WyOpNG4f/ZArfbGgzxAFtyyX5E+JuYnL5+Q
 r4m2PbQW4hT70adDeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.110.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mbir8-1tn23G2NkU-00bGNV; Sun, 10
 Nov 2024 13:03:32 +0100
Message-ID: <40438b03-5265-4428-80b0-608041aa6a16@gmx.de>
Date: Sun, 10 Nov 2024 13:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] lib: uuid: display HTTP and IPV4 Config II
 protocols
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
 <20241108133850.431075-14-adrianox@gmail.com>
 <CAC_iWj+JZ0bEnRL9eRS+eotBcUSh1EKucwAB2EGV5--n0mXSXg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+JZ0bEnRL9eRS+eotBcUSh1EKucwAB2EGV5--n0mXSXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8M9ziGbPnkRYZUuNXNHAiJYCDTSAtCBoX4KSPZr3Nh7cJiGVL9F
 G6DsgOpYTzzWCtJwxc/vN2TfHRANLXnj60gh8thtE3rBwQfiztBbgV8iccEnCE0yHnJbD6o
 j3WMGnX5//PgZzQ0VCOTVfHNsdeX+n3NBLLgXa86kCKnCYiFyKWKLlmvWyUuDjWxCOQtenS
 yak67NmLJ8ZDnfZR1ZzCg==
UI-OutboundReport: notjunk:1;M01:P0:MFCPHMFIzDQ=;0xYvs6d5rc2ssa1wNm3sf3Dd/g0
 Sp4U0i5wRe1s32P3qMbqjqDEVmvEGula92RECKYxaId49vMJ+nzUFC59iIqjV/2er+pCf7zAg
 2wi6V9XhL59OR33Xk2sTq84slhu/DSud5HuZnr1Jxf4NYRyL+jq7tS9ARKYk4GFwxfs1VB8vP
 cf8Ob9sa8G+Xye8E3otBUAfqAU1eBQ/gf0JOlqZdbF7cXMo6VZN7R2WXUse+Zh6B8Gu3nejHj
 YuyguyKrjpdWg0UKpUXy2Gq+oaf2zaaWT3iPKxgkfQAjXmUxbbA6C0bmV39oQW3HAnbQzJvYJ
 9IKG98GXX0Mr2L0aebbh5oT6cirp56JbkFIGhVwmVUcyKFZJOHdi4R9V5eKkUutCa1BD+bpv4
 OE0GKBnmOeK5DRNXOsA2FndfBJ9pFId+py7IjgYRiYlfSdTi9kEPiHq0FxGG+PGdy84BfQG9O
 aIyaI1Ol9eyp6vo5HdsFh5QpXHc1oYV42JUAhIug+61aQj6WmPqIvpGcQWQUrwus0d2DIazZ5
 +9e99Yuw8ZiKBDAK3JbpaABXoNVzGKshZUQbIFndgUH36asXAB+2s3UAo1USZdnS93AaCspyo
 q0RkajSUiMruQZ+BaaEv5rZOTVILtA7VZx+SNTEseoDlsqvcRJIi3Fau/IzRhaQZc2ViSfODT
 /i2O8VAihnyWsBJQ5EyduuGFIflLUnXSMWw867uo/J/s++NhonOr9Z7FQ3lBlCsMgMaOFXX/U
 x5a7xwsKyy66ztDzPTnOYIwGCqyg2mCJuIYwxSmZ+RDxBK41RnQEyi49ihm9lkTuUOhAsqR50
 SNXMVMPw7mj+IewtdGmQ2JaRkyysGotvwzw8wL7Ra3BfJZVb+LTdTPzE8qElwZ88jUMNY4+ur
 TfTjKKsjcusUfINxd3thvXolaPyKP8G4m7MUeglh4e7qgCRNWxGsuOWzl
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

On 11/10/24 09:41, Ilias Apalodimas wrote:
> On Fri, 8 Nov 2024 at 15:40, Adriano Cordova <adrianox@gmail.com> wrote:
>>
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> Add long texts for
>>
>> * EFI HTTP Protocol
>> * EFI HTTP Service Binding Protocol
>> * EFI IPv4 Configuration II Protocol
>>
>> to the uuid library.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>> ---
>>   lib/uuid.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/lib/uuid.c b/lib/uuid.c
>> index c6a27b7d04..dfc8218fb5 100644
>> --- a/lib/uuid.c
>> +++ b/lib/uuid.c
>> @@ -174,6 +174,20 @@ static const struct {
>>                  "Firmware Management",
>>                  EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
>>          },
>> +#ifdef CONFIG_EFI_HTTP_PROTOCOL
>
> Can you change this to
> #if IS_ENABLED(...)

Thank you for the suggestion. Not adding all the strings in SPL builds
makes sense.

Beyond this patch series some clean-up needed:

There are a lot of other #ifdefs which we probably should replace
separately from this series.

We have a symbol CONFIG_SPL_UUID but libuuid is built in SPL
irrespective of it.

In vsprintf we only check CONFIG_LIBUUID.

Best regards

Heinrich

>
>> +       {
>> +               "HTTP",
>> +               EFI_HTTP_PROTOCOL_GUID,
>> +       },
>> +       {
>> +               "HTTP Service Binding",
>> +               EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID,
>> +       },
>> +       {
>> +               "IPv4 Config2",
>> +               EFI_IP4_CONFIG2_PROTOCOL_GUID,
>> +       },
>> +#endif
>>          /* Configuration table GUIDs */
>>          {
>>                  "ACPI table",
>> --
>> 2.43.0
>>
>
> With the above
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

