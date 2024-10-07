Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E112ECFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D5DE88D3A;
	Mon,  7 Oct 2024 15:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="X/JmdA+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8818788AE4; Mon,  7 Oct 2024 15:31:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E7C88D15
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728307871; x=1728912671; i=xypron.glpk@gmx.de;
 bh=gYi6m5PDZZOxu/sOz0rzRaSNWQNmuoX3c8DY08LZ9uQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=X/JmdA+Ei7eMXP8mLNwXDxdqOl4ZyxQfQAVIcQb6+gq1MYPUzaBNtF5Uc7d/GB31
 +naZMb64PKivsgNlcC8y0tPR/QHyxexZkxavwCyoWZF57jAcGlVvG4p3PzEz/5o79
 W/rraeWB2r/lvzTt6ZPs3twx/WpCNnJHxyMXgy7Yf6Wwh5KjcRokffQimXEqRk8M9
 XUuX/3C7FOGigTyDQFwjty8E07SqLSLHgXUXEhegLRhUnVPsOnG7UtszX5U9qxNGV
 0TM1wk3fi11IEyOgEcCJIT5ixZA9CvHulo3xaeRfD9W02FCLLq4a0ev01brKhQq6I
 zQCl8UcWn4vben5fhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1t17D82bdM-008hMA; Mon, 07
 Oct 2024 15:31:10 +0200
Message-ID: <86b48670-ada7-4245-b12f-9b6e423e3db5@gmx.de>
Date: Mon, 7 Oct 2024 15:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 if 64BIT
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
References: <20241007094206.2928071-1-jerome.forissier@linaro.org>
 <4f24827f-22d9-49d3-995c-6e2c3ed6859e@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <4f24827f-22d9-49d3-995c-6e2c3ed6859e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uS5FAF1EhQrNKUxr26tMB9J9ooN7Hda2VsJLywg4wbiy4GubUQp
 TZy+WJzt4MaszrkUrvo3oKcCnK/9tRnUzP7q66kgLC/fkDeI5rbze0O0FfJBk9glcS0hvsp
 E5wfyOND9vdWJD34R+o/7Z36sY/MbK5O32c2MHbpE/z5mJmwTCCgrRZlnX7F9UQoqXJ07VE
 jIC+oj1pKA/40KuhYX7Yw==
UI-OutboundReport: notjunk:1;M01:P0:dLCHeBo3cX4=;XwAXzbmwFfQto+PV9YuZXHW/1Je
 IMEUsoeld3mUf41Ecy990lpSE4wR1R0IgLA2NhKB0iLxFVTC27rcT926/AP+GaBS9U4pySPTP
 DuTJ9kdS0CubQ1FkbLCsejWn8cplBc5sPO4bD+EQzkQxUMY9gIwHqj1VNylrw4brswlPj/Adp
 8Pp1EEo+L6B+WTzl5SEswj4OEhNQQeORbLQCRock9V+cNvQu46PGfP20VExJdoHrYIjnXx94k
 HWVClcwHrs3A+g87/T96T+vJ9CrvR7ISQ9Hsla9rYR2lnP4PTg8rNOkFc4b8Z2QlRo5r9cn5d
 4KnW8oGWj1kLXsPBJcOmLMOqWn4oaSbYWQTo4BSo3w8Xf8J7d388EyDj7jWRP4A4xt5JB8b1+
 CeVIRGmam/dg6qQQEp/T6DwZ1UEZ9VCi8ihoNA6l9Pc17sJYhiui0TmWZBFiyIHa+80z93hy6
 dGrRY2Z5zWCJhFmTp+qMyZOuZYDZ2/0GNxq+2TNbjcCmFYBvBFUucItb9CYM9lCDx/RMGiYZz
 yu+D/V8OnsgpYfIQ12WrJnO65cqE/+rWsC8vYPaUw1O7KYLDJtfL76sClFOtATctJoH4dAVfd
 BLersi+cBn54Rq5lhD6wz/uAWhtTdOr1Df3ROSpHtwiNnchDpQRZi00gkjxHVgKLwVaKajysp
 aS1l6mz38eUpSCBCdymVYqxRicz45ZjzqwS2YLYCFCGcpz8vr83g0iktQLn9XrYj6Sm1eroEm
 mEDnOEq7Y1EnknoH4CIq9a3GQDgZ9ZeVaAYdfGo7jalWFeKzZ/Oolc3yW+wUalHyDQWCI5BMC
 MlblO0fGPAuSTr8mmKHv45bg==
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

On 07.10.24 14:55, Jerome Forissier wrote:
>
>
> On 10/7/24 11:42, Jerome Forissier wrote:
>> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
>> exception may occur. In fact all 64BIT architectures should default
>> to 8; that's what this patch does.
>> Fixes an issue found on malta64 with QEMU:
>>
>>   Breakpoint 1, lists_driver_lookup_name (name=3D0xffffffffbe043578 "ro=
ot_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>>   31                      if (!strcmp(name, entry->name))
>>   [...]
>>   ld      a1,0(s0)
>>
>>   (gdb) p/x &entry->name
>>   0xffffffffbe04b0d4
>>   (gdb) p/x $s0
>>   0xffffffffbe04b0d4
>>
>>   $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>>   4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a58=
4  2**2
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   arch/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 8f1f4667012..72bf4029251 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>>   config LINKER_LIST_ALIGN
>>   	int
>>   	default 32 if SANDBOX
>> -	default 8 if ARM64 || X86
>> +	default 8 if 64BIT
>>   	default 4
>>   	help
>>   	  Force the each linker list to be aligned to this boundary. This
>
> Superseded by https://patchwork.ozlabs.org/project/uboot/patch/202410070=
94206.2928071-1-jerome.forissier@linaro.org/

It seems you are pointing to this very patch. You probably wanted to
respond to an earlier version.

Best regards

Heinrich
