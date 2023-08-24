Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD66C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC8984702;
	Thu, 24 Aug 2023 17:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fVSpNeV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2DFD852DB; Thu, 24 Aug 2023 17:25:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7478468A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692890703; x=1693495503; i=xypron.glpk@gmx.de;
 bh=L8uhFywjRvh/15cNS2uYczwztdBV/wIy54HJ5d80yKA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fVSpNeV/aoN8EqQDGs5I4Z//huXbjFf0Qpf8re25bb9c+QP9PfP6dkllOBi0UqiCZ2p296a
 vR6UUcsZi0pR16m3/xU0vFNAw4sj9i3wf3CelcvQkUOqXBeudF4n4X7hbN4+9ZAnRQfZ1ZZS3
 2h5ldbOvCFj4pOOoYX/37pYOgWN1I9i/fYXzCiABWImMGMKa927o+4FQRCh0BBUwDbvNf6KkY
 xD/Y9U2c0Ik1BAjh+zJOKVOYJsxV97HebmPF7abf8WFP9C3WaslNK0oRiJYFWDhRzdNpbsmEA
 bmH9AzsVxQtzNItTGvEUU+HNCuIKSURMwmUi5RjgEyq0EdWK3rwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1qb8913Y2T-002Zoq; Thu, 24
 Aug 2023 17:25:02 +0200
Message-ID: <20d4043b-a087-0fcf-9212-da579fed3929@gmx.de>
Date: Thu, 24 Aug 2023 17:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] efi_loader: delete handle from events when a protocol
 is uninstalled
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@google.com>
References: <20230824142109.2401528-1-ilias.apalodimas@linaro.org>
 <CAPnjgZ0JZCrPOCUZDgL10zXdB+LQQtv2MXZPcpcxXDY+u8MhHw@mail.gmail.com>
 <CAC_iWjLWQhZrZkhK02dS=gQG7Z7y2-cQ6LtKnnrm3tur3J4KPA@mail.gmail.com>
 <CAC_iWjJm9r3cgBX5fuANp_BwJzi4r_jdXgFMDYRw3V=1QYjiog@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjJm9r3cgBX5fuANp_BwJzi4r_jdXgFMDYRw3V=1QYjiog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BN44BBWSzF1P5ETghFvRLojiyKi9dY0B25c3J5F3x11CqpGg8Ro
 TeXtrjPfyit1NirgkXLYmOrmbrwuFI1vsmG5OWfiKDQo6GvM3/BWRpH4tqiKOgaDzB2BJ61
 ySuT3l5Qzmj1bnUdBnyxVzThcOZto6QmlxHeC/h8QeEXP3cAhNrdeFg0BtCqrfkQCKbHb6L
 XCGOqfX4loIfePCvxr/rw==
UI-OutboundReport: notjunk:1;M01:P0:QxffA24nPQA=;sPrNWdKo7P/BzVnZRYX5AJrpspX
 hthSe0iOd8LHisU+YT9LhZNheikY7Jck4EfZKWJbVrXWMiCvXe+s2gTB6lphwgm3quOASzrxp
 tuejhGarbkRcq7Amg7pB8/BR0uwzGI2dhVF/5XDdMldX9WFqdk7s82E3sQQ47yLcAgSAHkpz4
 fq+SMiyDleizuzHQ+rO0c5hjd3Rf6jFmfDduqLSyJtOCNuNbiazcDs/8WBihGU3FIPuPticUU
 W/TRQHq9ghBNZ154L/v0YDrnjfl+RuKChTEkT7h+Sd0b1dngRnxLPIU4UiWHqOpg181ZwY528
 ffH9ZmKXiYW+hEXS1uzZkNKvtiXuzorOQB3pGZmACCGPF5NNI1C8xt1bhJx6EDfsZag54yszn
 o7G2IDdNR2v29mS1HWlC6lOuU7E4p/m6ksShVlQAjIPKMw+Vs257kfwR9wuf06b4hz848yWR/
 +INX7680iRKgZad0Rjczrf/hk7BoMVCiP0Lst8Hdn21OIyFUr7geoPP9vVv0Lc9wFcq2QXaUO
 LjHqIfE3eWt2Q98YJIf5QScSPV787Q1TAaqh7KYfCPnGgGBz8vfPeW2jXy/KwEPLl9w1LmD7i
 rNmN1xvZZSCVl16CPv6CvSnLMObdC4Svclpgz0gtf7jNG9kO5ILZ008CLqSkJg7VgDxGZUIW+
 dkwy7ZldnfOokMcpzrGjYjyoMQo72blXFbzvwukUDbiXxEmklygEhepEhJ1t+mD95mA9yYpSa
 jyOxOZeCwATHti3esI8b3r+oLk2MPi9SiLFryAH7FCFF3V+WE0B7is4NgE6sQtxWSfDG5/LnT
 RTrmYxR2TZFKf4uUUA3splcIkbC+jCjZ8TYs/DtkHmHifoayIjDnawWOEpeumZiF5t1AxjYLn
 Upt6Jenqskx9xZLJ52moRMAekrT3RUWxcp/fey5uvopgS3jEqZtgnLaPUVD6zf6CXNqPk9vZq
 AhMqOCYZ7Xj16vRC7652rCNnaiI=
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

On 24.08.23 16:49, Ilias Apalodimas wrote:
> On Thu, 24 Aug 2023 at 17:47, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On Thu, 24 Aug 2023 at 17:41, Simon Glass <sjg@google.com> wrote:
>>>
>>> Hi Ilias,
>>>
>>> On Thu, 24 Aug 2023 at 08:21, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> When a notification event is registered for a protocol the handle of =
the
>>>> protocol is added in our event notification list.  When all the proto=
cols
>>>> of the handle are uninstalled we delete the handle but we do not remo=
ve
>>>> it from the event notification list.
>>>>
>>>> Clean up the protocol removal functions and add a wrapper which
>>>> - Removes the to-be deleted handle from any lists it participates
>>>> - Remove the handle if no more protocols are present
>>>>
>>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> ---
>>>> Changes since v1:
>>>> - use the non safe list traversing macros on efi_register_notify_even=
ts since
>>>>    we don't delete anythig from that list
>>>> - Add a comment explaining the code that preserves the handle in case=
 of a
>>>>    removal failure
>>>>
>>>>   lib/efi_loader/efi_boottime.c | 89 +++++++++++++++++++++++++-------=
---
>>>>   1 file changed, 65 insertions(+), 24 deletions(-)
>>>
>>> Is there a test for this behaviour?
>>
>> Not in -master.  I've sent it in the past [0].  But instead of merging
>> that series, we decided with Heinrich that a bigger cleanup was
>> needed.
>> So we had to do a bigger cleanup of protocol handling [1] [2]
>>
>
> Forgot the first link... apologize for the noise
> [0] https://lore.kernel.org/u-boot/20230601120625.1843555-2-ilias.apalod=
imas@linaro.org/
>
>> [1] https://lore.kernel.org/u-boot/20230620061932.113292-1-ilias.apalod=
imas@linaro.org/

This series is already merged.

>> [2] https://lore.kernel.org/u-boot/a222ec75-32ef-9dce-0855-afde2702c618=
@gmx.de/
>>
>> Once the last part gets merged, I'll rebase the test and send it over

This patch is also merged into origin main.

Best regards

Heinrich

>>
>> Thanks
>> /Ilias
>>>
>>> Regards,
>>> Simon

