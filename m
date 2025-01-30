Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15DAC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 08:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237DD80B9B;
	Thu, 30 Jan 2025 09:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jKA0SDoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E49280C85; Thu, 30 Jan 2025 09:32:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708F680AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738225949; x=1738830749; i=xypron.glpk@gmx.de;
 bh=6bJBw5lqD1Jc4j93Ag1xl3pv4QPwjugBkV32vw/Ne7Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jKA0SDoULuwtL89dDBtV2XuQLRj3ngmuqhb7Th/NoDCbES3wHkFqfN0YKdtb4oT+
 4dpZAyCmpWdQlEjfPNbycqMPUMvt4ML/0HOrui6f0VrXRyKubcxYXxtCeW8HCuL+0
 G339M8oKEABd+HcdPnJhGKzdSIlSb1ssF9ewTfxn+VhtnZupUF169VP+naenZfiKi
 smnLREXsP7d2iBgVaZQ3SOwEzhsg4ktV3zBdiigm3ZTX7vlklKq8+oQsFHhGHuAxp
 i/2Ty24SoeuH3DukJ4GxHnaOW5c0kvfJZT7GKKONT5nwOjhZ4U3qzJzqvCYPQA0/T
 IunRvcBBxWbrejhdsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1t5fr53tb1-00cJNA; Thu, 30
 Jan 2025 09:32:28 +0100
Message-ID: <e3ed313a-847d-4307-8c58-f40e8fcee86f@gmx.de>
Date: Thu, 30 Jan 2025 08:32:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make tests skips the DM tests
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <92438c16-1b8b-4e90-a44c-285140f59f0f@gmx.de>
Content-Language: en-US
In-Reply-To: <92438c16-1b8b-4e90-a44c-285140f59f0f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Rt7Odg+pRTTcoUYELN2/vhaKSamw2q3+0tR74FGMXGnXqh5cv8
 Da2UXqFPY6Sl+aJ90855c+BdxuV2DoqJkIFbXZ54eA31hiPt3PtgRQah6XAUrBKeoZGuJkW
 AeGf2j2xz8oosNHa2aRUMzVORkgmLFfLkzCoWdXJCGoEUA5dh7qTTBdDyXYYtZap5f3N2oi
 Dk0mjqODzRuclUN9fc+8g==
UI-OutboundReport: notjunk:1;M01:P0:+8g28vmaM14=;9itUxcrxVKVfAYexm6eyEMGtINd
 CDR2ynl6sfobk2gQMDcHXJahdUXngq9dqnysHnBQZrgMdsnHhArqkefQFbbbOTeJkA30Fi3X4
 ATkLJfIBZPLaCOc0URd+3dCFtQ09oP+/auS5kfrLcAS1KFcOxDDBbMRw/J8bf5fUWLLL9QdAo
 Y/oUzTZ738y/ahVBUcXJLP+bbWH9mR/lRcWMrEYg373YwmWXJWI6Tu9JMlnCvELE1Cyk0vo+o
 wnIl+1j+zurRBDjDo+8J3Hccz2FaS6Fb12J/HKq4JdSxrn8YRnzlDe37RKsykWF4/3mP/DVPR
 vL/1VKZs/B8fEmzQPlHCCNa4kpwC/zjQb1S0nHQS9XxZQC0fgzQK8mdnzN64EcjgXrKj7tQuY
 fjfqgtQ7oJer80wb65I4rCqSRuoAawFlO6qT9V0xkK14Oc8GN/pa5G+74uukTMgoJHk1RzBsD
 k0Ou7t7Noh0E4xqHVW7PljiBuo+r4GsPdaUqWD34nDk7aqh6IfMIlOVDE+nLp5iBB9XvhOQIF
 DuwGCn+MrhuIWgiw3AnrO1NlZ+Z4CnrBjYuHBXzq6r/PsMNai1viUE/C4F2fuzqMxZjJb6eEu
 0BNOlHYstygT6eB/jlbIYdBNGkTYWzVqYXh9I1sd3GGrBE2fRaSR1J04+ZvMT98huS+XwQ3DN
 yGShuLwzW1hrdDLQSjo/vKN1F4ypjOSTTYcAuC5OiGuDuaVFRL5WYvIyJjDObfJ4yr2JjiQ4h
 BKprKd7PVHufYPaBNU2hJjfodILkb9TB7THocXU0D8TwSpyG+Yd7u+/6xUubnT7+7HYDZeZrX
 g62C1Acw7VH/yHSRQTQIQhmP8lnQa8FNI6bH5oLn0FYV2Tt9xV+H/foE8Qe2SwdnrqUNYTEYI
 QacvCsPmW5jG0SqbBSd339jVjj0ftMABFH2MYbD4C7PO8b/+L2DR9snrrOZVtzuHhek2EuG9E
 nlhxMoEVItoRaz2GgBcC3W3eiJEkbewdbRec7VCRVk+MR+iy3KLp8T/9ipEis1QFjI1uTibx4
 hlSQFmmDNCusIE4QXh1ZCo0JLLmmpmMBBAflzTQwCQZ4VCBzfx+F0LEPGa3lJTgCI2sIpT/cH
 oMS8ABUSWPpOY/sE2FpOpCEZYd4P8t2YfiqPH5hX10t0WPAlTxwEDytMEg5w62hwltxOcpPCs
 02jrVkPuCq+1TAoYONWjrV1X7DuSqsFBLifDqb8XF5Q==
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

On 1/30/25 08:08, Heinrich Schuchardt wrote:
> Hello Simon,
>
> when running 'make tests' locally I get:
>
> test/py/tests/test_dm.py .
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> short test summary info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> SKIPPED [2] test/py/conftest.py:625: .config feature "sandbox" enabled
> SKIPPED [1] test/py/tests/test_bootstage.py:39: No bootstage environment
> file is defined
> SKIPPED [1] test/py/tests/test_cat/test_cat.py:8: Setup failed
> SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set
> ['env__usb_dev_port'], function test_dfu at /test/py/tests/test_dfu.py:1=
13
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Lab failure:
> Timeout executing 'dm drivers
> ': Marking connection bad - no other tests will run
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>
>
> Shouldn't the required boardenv_* files be generated by running 'make
> tests'?
>
> Best regards
>
> Heinrich

When installing all packages mentioned in tools/docker/Dockerfile the DM
tests are executed.

What is missing is an error message which package or tool is needed when
the boardenv_* files cannot be generated.

Best regards

Heinrich
