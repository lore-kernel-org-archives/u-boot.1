Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797B9D0E6C5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 17:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924118811C;
	Mon, 21 Oct 2024 19:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ATt4uapw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EAE8806A; Mon, 21 Oct 2024 19:07:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5778D88E91
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729530468; x=1730135268; i=xypron.glpk@gmx.de;
 bh=DVJJ8IczSpgtsh7u8bSCdJucuN87lpf6nlh2lQ/qFMc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ATt4uapwALCkCGwx+V1Z8tagq1tAZuMQgjW7uYgZReAnDSgEaAuuIr/BL4sggZmZ
 Bscp5GNeXIr4wriYnq0FVMGokJLV85tTh6oYABlmsZKcCopX7sIhIyyHX4UsaklHy
 xwGZkP9gW1aQx+uYmpO4yfN2+3HnQRkgXpFVQPTk7cBEWd4fZY/JQU9FgqlwdAWIs
 PY2psctoA8srAfIvOKsNCwBO7Ub/gk6oZaiduhtEPnmtIAI25GuLBaj1rUv+Db308
 Tya+UR/PRd3JLwNVLCsEzK3RxzRpl195CtM14P0hdUnfQd+7evjxyQnW86HvmDnw6
 9dwPU8rXvXfc5uN6tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1tf4a33CEx-00oUaP; Mon, 21
 Oct 2024 19:07:48 +0200
Message-ID: <5cea49dd-b67e-428e-9ccd-ef16036a53e1@gmx.de>
Date: Mon, 21 Oct 2024 19:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: enabling W=1 by default
To: Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wdYU7YiMJI4Uge5dXB2IaplSDFLCSgGnwsVRGRpUafhKGnR3nYP
 bFSYbOIrX8y6coOuj3OGu5CIuFgFJymJL+XNT4SjvZPDkUwiiLI6buixQuMsfTleVf5wm5T
 /6jbPaGeJQZ1NNfQB83Ihn1wus2q7j7Ah69QcXEQb/JoMHrx9Xasj2rSeYnT2dAGcRQuMW3
 kOseQXFDqKcNYUxHTZ3aQ==
UI-OutboundReport: notjunk:1;M01:P0:wMBgrhgY18c=;mnlRA/xk6LcNZYddk1ItC4bnn4x
 7G75J4CT2irVKr81lmMGAmVX/8xgGeIMyBWdCuJ/S6YZcXioDiULWsTeKn+JZGvTYUvhWfwKD
 YKK5oymdwdO7riwA4GZGpHYfGvYpDdLhisjh0vxKrvnT+hxq4lm2OmP2rkZrK1a6T9o43JYOu
 ByUvtLWG7Vy1bQLCjinop3oHb4gu3JQfx2R0U23D2W7TlCgKqOUUP02JY8uumIv4WlfyiCArI
 gGB6T8mmuxgWIke5/yMeiWkfPUKhoTXBwdkuicOxFxaWNwHTdgppO20sv3Pv2awRnJiyVyIjV
 1XAcDt2oTUZRyciIjWThcqc+CTK0IRZOnXqX/bLVEdXCutauK04OElMQBaBoh0NKOOjv8dINR
 qCUosUlOiKRWtadZvfVW882u5a8FLtu/UKL9q0mi7vvUkxnng/2YBE55p9EQGXaIDm09bh0am
 B4FntFe0jxquYk7PNCKw4BIemuafGfNWYIwXZ3sT77KcsypXyRWVLTx7jn2GxFZWCi3BLIwm8
 eaXonJyHIuA9OWC2VpBLbyPLWAmGO1L9CwKs1QFd2Rz2T4n3n+bM9a0Mcp9Gr9XY2GW5Wk35I
 +Axtj/YZ20RCtBh4uxUpMvWlX+rXqDt4HhJzMzrrjEjhiGtfjR9BugB74HbIxpfu5uC314quj
 zuHunyr/sP0MqLuvgfmghp7brv7dUkSrSQZXaeTYizQLQRcnSNReObR5egeIOeGx8eg1p7zdx
 Ng71X1aB5qkzq6+nbZySdpjlhXbDlvn8QAK7Z8UdQ0X9r0ixBZ1cT30O/eU+8xh/tvHqHLGln
 j84WUqTz+5NJcDj2Xpn0mhjA==
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

On 10/21/24 18:32, Simon Glass wrote:
> Hi Andy,
>
> On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> Hi!
>>
>> looking at the redness of the output of `make W=3D1` here is the questi=
on:
>> isn't it a good time to enable `make W=3D1` by default. Yes, I understa=
nd
>> the impact, but at least we can do it mandatory for a _new_ code submit=
ted to
>> U-Boot, right?
>>
>> Ideally I would have what Linux kernel has for a few releases already, =
i.e.
>> Werror by default and getting close to make a clean builds with that an=
d
>> make W=3D1` at least against default configurations (yeah, with U-Boot =
there is
>> probably no default, but sandbox one).
>
> Warnings should be warnings...if you would like to enable it for CI
> that is fine by me, but the U-Boot makefile shouldn't do it. It
> defeats the purpose of having a distinction between errors and
> warnings.
>
> Regards,
> Simon

Most contributors don't have access to our CI.

doc/develop/sending_patches.rst does not indicate that patches leading
to build warnings won't be accepted.

We should at least amend the documentation.

Best regards

Heinrich
