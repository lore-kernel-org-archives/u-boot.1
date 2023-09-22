Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C2CCD4F5B
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 11:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169CC86672;
	Fri, 22 Sep 2023 13:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="fhwAJHVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFC386679; Fri, 22 Sep 2023 13:04:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B158652B
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 13:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695380643; x=1695985443; i=goldsimon@gmx.de;
 bh=ZyV4VRhnWkN05wT2wsUorNRS3uXpOySr+iCxfP/JOxA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fhwAJHVY2CYF8SqB1pd8kS87TzG/e2rLVYBEUQoiU3Ud4zw+/0ooLAZUk6ZaCFZFJI4MVJmJHe3
 0GpY6k05jE8ntCbBijXKUeyfS2DNzCAILmmlpqGCo9LaD2S1ZK3eLPCz09cZ6lalibW1AeMTQmxUW
 91NCZYjpbPDcPlb0YPwiqIzGB8XG1uoP3JlJSOrXEpmUffo2ljWGsYpxvCsI5sBxeOorlDf50Wzir
 0kg3VW4sDkWvLiDocbxaaTHqMqPwkvHrj9lUQs8PgcDaEPe98albiu5u4gMbn8wFxxOICMlfhW5T9
 Qk0PFDKclOdEYiMs3AJeq1qR3T0OCO1Lz/Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.88] ([176.199.209.230]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1rgWvV0MN4-013dfP; Fri, 22
 Sep 2023 13:04:03 +0200
Message-ID: <5d88f7de-70d7-fbae-c2ec-e16faf5af5a5@gmx.de>
Date: Fri, 22 Sep 2023 13:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv9 01/15] submodule: add lwIP as git submodule
Content-Language: en-US
To: Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
 <20230914161828.3662-2-maxim.uvarov@linaro.org>
 <CAPnjgZ3tr5rqdPfnUS=5F19-7R9SU6fpe3F7o9+TghKs=m7zrA@mail.gmail.com>
 <CAD8XO3b3VMCwOBsU1fHGiF7VeGSSFd6qKgK8B5HhdCHOtF2sWw@mail.gmail.com>
From: Simon Goldschmidt <goldsimon@gmx.de>
In-Reply-To: <CAD8XO3b3VMCwOBsU1fHGiF7VeGSSFd6qKgK8B5HhdCHOtF2sWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mxEMlOci0YL92k5nsdNHjwmewG0/ySgJ2Zr505vAQrQNL08zWtr
 pmelt0UF5h9puka/unhbTI1fGla/pqR2ffund5BWZLCtZifszvG/3A92wIruBLja8aQ6t2w
 a6Ttig9UaESNo7SH6+0EiB79IKlnEisYbro9UsyHdk++tvKZckF8naiu8FFxHq3ZFOtupjW
 o2YGJ7+w8nffeVW2BbIiA==
UI-OutboundReport: notjunk:1;M01:P0:Lc9UbB15aCc=;fTqpQm7CRyiNVCloMEKm9KEuJdv
 ynLsK1e6SGBXgVzcdlXBkRycG3t0M+5aAy4bUFFZXiP7kRmbHJtd62q1cstxecYsVbrK/Kkr0
 zsj8hPaythqDFiCKVcLcQ6d4oyMbvRC0vPiq4Ge8Ziu1l2Gx6ukXHLLQGyWKzZDI5fI+1mszX
 V/BuS3BeAb2S/deAFGtf/JpcCsiJwCqmLtMg27SEQwnjNLzPrrMivJyJshO0xKLaJ1YGrUvb7
 L6EoXBd0yKmTie0QOobgLkJ+r2aKyTGeXwPXC40U5Kncs6EDANClURytHeSzFgp9FCSsEDari
 wztSc5Npwcq6TaqT0HTKRLq5GjpISgGsBbtnncg4ZaWPXteLVgyaCOzHvN6WnWMDV5dEsf5O+
 Oqx7RYAzU1OOGNG/yDN4iTlhTW9O7mjExmcF4trjxhX5lUKMfjvFdIgpIKnD8C4WMiI9UZmhj
 NP7gNXTTwMXU8p4OuufZ0wjBfP3fXEqgccnckSFsh2dN8L/Yj6N9YvzvGLvM0Tm9+b6Sq95ya
 icy08Dmo+dsv7t79akD/qxFBIgYxBAyIXYXUo2kIlspT57jEgwjzpA9kbf5pt4rtbTn0M9mDA
 8Z/gDs5JgCN8g5sFFGnsT0IqawvC7NKF+Q4RXRpide6S6zwL1nvUesOs62hmINV/vFSBKz30I
 N2iIX+BLtgmCNH1DAZVpDH8TXJMcvDnM+jCk8ctk3lJBbHc0WANw9MqAl0dy1Y4112mPOTJcB
 WsZq8juNtTDJ5g9SlCVH/YNnJPaf9Qbzw1ZrbQvFO22XTvkOUPI8Uyip0GhPxzsV7xslZBdIT
 UNegSFEn+VpJQamPc3Jtr2EKKu01/q2Skb7jrzf8w7P+urmaCUWC4G89nUgUFv/RjF8qUW2LH
 rQ4jD/hN0lEnDKafpkrADn8w2JC1eUebf64hCKh+/cM0kwM33nJUtylSlGgDrg+VsAsyzP7t9
 ADSlbrBXjgiGiyOu/raxEbf/VJo=
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



On 21.09.2023 09:09, Maxim Uvarov wrote:
> On Thu, 21 Sept 2023 at 07:06, Simon Glass <sjg@google.com> wrote:
>
>> Hi Maxim,
>>
>> On Thu, 14 Sept 2023 at 10:20, Maxim Uvarov <maxim.uvarov@linaro.org>
>> wrote:
>>>
>>> add external lwIP library as a git submodule.
>>
>> Oh dear...what is the motivation for using a submodule?
>>
>> Our current stack is nicely integrated into U-Boot. This would make
>> moving between development branches much more painful.
>>
>> I would much prefer that we bring in the necessary code, and that you
>> send a patch every 3 months or so to deal with updates, making sure
>> there are no code-size regressions.
>>
>> Regards,
>> Simon
>>
>
> I would like the project maintainer to make the final decision.
>
> And this time I'm trying to understand how lwIP maintenance works. And h=
ow
> long does it
> take to merge a patch to lwip. For the latest Ilias comment I did a fix =
to
> lwip, which is pending.
> https://lists.nongnu.org/archive/html/lwip-devel/2023-09/msg00004.html
> and created a bug with the same patch:
> https://savannah.nongnu.org/bugs/?64697
> And it's interesting when patches get merged.
>
> Also there is a long list of not yet accepted patches (86 open items):
> https://savannah.nongnu.org/patch/?group=3Dlwip

The list of open bugs and patches has largely to do with users sending
things in the form of "this or that doesn't work for me, here's my poor
quality patch that fixes exactly my issue". We simply don't have the
manpower to check all that for correctness and for not breaking other
use cases. Nearly noone sends a working test case for things. But we're
trying to catch up.

> I am afraid that if lwip patch acceptance will be too slow it also can s=
low
> down U-Boot development.

Our response time greatly varies and greatly depends on how the supplier
of a patch works with us. Many bugs in our bug tracker are like "this
doesn't work for me, please do my work and fix it for me". Nearly noone
even sends so much as a working reproduction. We're not a project like
that. We need people needing things fixed to implement the fix.

However, if you're talking about accepting and pushing code that easy
for us to review, clear, and in good form, accepting should normally be
a matter of some days.

Regards,
Simon
