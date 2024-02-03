Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F61C4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 14:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D4A8746C;
	Sat,  3 Feb 2024 15:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="c+9LODlc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9826880E2; Sat,  3 Feb 2024 10:51:57 +0100 (CET)
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com
 [203.205.221.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF2C880D2
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 10:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1706953909;
 bh=uUTLYmd6AWlXaDUqb5lLOXgPJgguzN/aeVpEUgAt3bs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=c+9LODlczUpgNbakOmtaKeLNlKP0S1ADOuJVSTLx0S6Gb8nd5ZxwM9GBJQJLhz3a5
 jKNC3PsQ9Bu4SRwCxq91SZ36uJd61Hhi9hASn1IrdKEqbGSIhiHtoILtzobGGkevHL
 HVVZsK5ARvQ122reR7hcuN9UjQwmtAnyOkQyy+00=
Received: from [IPV6:2409:8a4c:807c:e7c1:c8d:b527:44bf:a351]
 ([2409:8a4c:807c:e7c1:c8d:b527:44bf:a351])
 by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
 id B6AB60C0; Sat, 03 Feb 2024 17:45:42 +0800
X-QQ-mid: xmsmtpt1706953542tbf84zfha
Message-ID: <tencent_0A657770FEC7B98668A070C65A10F4166007@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GvIEVFyyI/DMHMrkPQjAF1qh2Y0Mq8zTUNfeDoIW8o/mlDZQksA
 bdSSAxrg7Zi0jjNO8Xg1S7YCU2KkNmMbmPxxhplH7fSAraM2M5cFb6fX7sQEKtQg39HD+2HUCfQ9
 VRvrkZwAHNRbbC8E9n8JN7k/fBJBIrm39YbzI3kolZPtZkXdxYqHvhxgBLqKIXTQDR6TRU9onuq3
 OMNq1pwDmW0SK0KZR4k3iwb+AU+YNKtQqjkfkOGTBprB5Ki7Xd0tkE8WFfruc4mpCNFJbGI9IEBD
 u7yR4UkCUpyTo75pJN2viKDl9gXvMoWRySgCO6kzzgD3Vqx/3cYqYkEI64PhHCncK6rcas4fBdtv
 sMPqNoJIHGfv5x87iP2ryqrPwNKeogswkCq48NxKpAinzXwlwZ5dbWT5b6GHLrrzdPUutLc1qNqn
 NtJY0+DHiB7FBa+uMXqP6UBoz5QdQ4RfE9hxE5JSvk8oF9HldcFRLqIl48ouTzP3hhSrTHgkekuP
 FcDovl0akJzVPlo6C5RCJfAPbCtobZGSpZeb0xe5JGM3RfIOQ58gQnuWiViUVF+P0pxX+HewD0Jb
 hAZ1SUq8B31cITe1t0kkJFy1wIlauZc62L5IHMe4voRBv2y33opemkuStTH7Ga7ADkt6SKQY0Aof
 0K696QmW3BllvZ2CmZgsjAQjBQY16n9iBmZjtecA2AMsMN2uHe7hb6+hsEich2bZ8JMLrKWd+5Mp
 ukqdWQ/eyjqAP3k/NzlJzbdVXr1UwFsa0C6vmlEe1Wf7D5apYz1IWjQ78GqC/3dI+FW6SAV/HK7Y
 BvUdWhtqgNlhrgpjK0AfavZmbXF+NgFIR9pjbdPiUzQXahnUrDrNH3S7qcw5BTTNx9u2f+wv8svF
 g+rA2ad+0bTeL1ac7TUOwqBWBeSouI5DFFI1Wzy1XieC5KdU/jaJ+3rqnheCUHkVWTzZdMf3/50C
 YPyA6CjIKAq7PHeai9rkFKHB+v9qAUBqPhOVGUgW7ICB32I6LPxnjgp+9kP2Fk
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <40c2a886-7e68-4fb2-b7bb-62a1ea443c20@foxmail.com>
Date: Sat, 3 Feb 2024 17:45:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] poplar: add myself as co-maintainer
Content-Language: en-US
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
 <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
 <Zb36M+p4z2+zd+XB@trax>
From: Yang Xiwen <forbidden405@foxmail.com>
In-Reply-To: <Zb36M+p4z2+zd+XB@trax>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Feb 2024 15:12:12 +0100
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

On 2/3/2024 4:32 PM, Jorge Ramirez-Ortiz, Gmail wrote:
> On 03/02/24 07:54:22, Shawn Guo wrote:
>> On Sat, Feb 3, 2024 at 5:44 AM Igor Opaniuk <igor.opaniuk@foundries.io> wrote:
>>>
>>> Add myself as co-maintainer for Poplar board, as I'm currently
>>> working on it (re-testing releases, addressing issues etc).
>>>
>>> CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
>>> CC: Shawn Guo <shawn.guo@linaro.org>
>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> I'm not actively working on poplar any more, so maybe remove me in the meantime.
> 
> 
> hi Igor,
> 
> Yes please go ahead and thanks for offering.
> 
> I'll sync with you later next week (I found my Poplar in storage, so maybe we cam improve things a little)
> Also it would be good if we knew there are still users.
> 
> 
> Acked-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> 
Hi, everyone. I'm working on a set-top box with a Hi3798MV200 SoC. It is 
very similar to the Hi3798CV200 SoC and many peripherals and drivers can 
be reused. I think you can try moving 
arch/arm/include/asm/arch-hi3798cv200 to arch/arm/mach-histb and let's 
maintain all HiSTB series SoCs/boards under it altogether? The same 
thing also applies to TF-A. Currently upstream code refers to poplar 
everywhere but actually the port is portable enough to handle a lot of 
other Hi3798-series SoCs such as Hi3798MV2x, Hi3798MV3x etc..
>>
>> Shawn

