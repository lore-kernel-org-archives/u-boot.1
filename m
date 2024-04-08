Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DAEC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 05:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1763187FC7;
	Mon,  8 Apr 2024 07:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="a4Tp3x+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C7E087FDA; Mon,  8 Apr 2024 07:55:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D14AA87FBC
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 07:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712555702; x=1713160502; i=xypron.glpk@gmx.de;
 bh=+Sh+q9eK/EEKi0UiOKhsMLV8nkdmrH5cpRw8yfbQzBA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=a4Tp3x+I9houoU+66D9+wwod0QUKYM8GB2tVu1dU/oszdA9P2fn/q8oCk1KHkLkY
 VTX2zCIt3q9uc2wwXpzJT8ipvBt7dqRZhU+1HuCeMngBGDx+iiuIjSNKk/+imiVUc
 Jod0YSaGYKJp7mHN6Nu2ZDpu5vTmMizeIgi9TGyMRuHBFf+zh3Bc9mPqAjS4czEvS
 s1kE8ADg6n6N5UFcwRRnu7O1A0SBTos98dJ9IyJs8Vqj0AUnVrlALaXMDFotU1ZGS
 SI7MPJqldAloWubcp/TDOOhwi8qHWjHcWxTxrcccN3GBw0/yRzNhta3TseqtQql/J
 ZAecUwzHDAs2hHWxqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1rvduh1kxF-002XwI; Mon, 08
 Apr 2024 07:55:02 +0200
Message-ID: <b85fb153-f31b-400f-a2bf-983dddaba735@gmx.de>
Date: Mon, 8 Apr 2024 07:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Enable SetvariableRT
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: kettenis@openbsd.org, caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, trini@konsulko.com, kojima.masahisa@socionext.com,
 takahiro.akashi@linaro.org, bmeng@tinylab.org, raymond.mao@linaro.org,
 sjg@chromium.org, abdellatif.elkhlifi@arm.com, eajames@linux.ibm.com,
 alpernebiyasak@gmail.com, sughosh.ganu@linaro.org, o451686892@gmail.com,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <87bk6kj0uo.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <87bk6kj0uo.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l68Mj00dnWnCHYwlWnFmMu2meXwajVom1M06DtujN5/f9h8tyzY
 QIYVsftoxugG+vGfEnO5SbJIK4+OTORpBICl0auXKNzsbvIRVxrZlcEOH0yq/y4XJSj5pYX
 WxfEyAyeSRjQvP3DMcQQSIylis8mpJg8kEcldQD3y7TtgTcZvI4gIT9CP3d2rp6+1sFxTNU
 l5gtN6PnXSuGUoxJBKRkw==
UI-OutboundReport: notjunk:1;M01:P0:uT8iwUPl49I=;wNMTS8TQwUlTcVpk4TKSNDonP2G
 1VWI/xPkfJolGnx32jLuO9hK+GSJITQ4S3AMIo33H7ZEfs+uZ4uwAPYQxWAzRQuWPS0k5gg+D
 /mfmMjmj+fFXg9dD96EjdVuqpvD/5kpTxwkNp20Co1NqMdzizcKXC2tAUZxtnaaZqwQTKNHyq
 lyLmtiuyMf1Gpzxw3QdMkIg5RSKKYLUq1eWEjEqeRBL+J5R4CFjhs1XSnQ6I02UyvWkaCtjeT
 fpRWaRp5ZUuX++o3g4YOus2ROfLjRiEil37koGhtZr8BBC426xTVFyWS6F301kccBsBJETflX
 A2evCF1RUzNN7xN79k98yYw9yKxlqX2049Eal2nYpVNHk2VGjouBNm/rpnzSmfkBv73HdfiEM
 t1X9b+tclkXE9QLaYEnyFipi72kiHLL+LVeFtqmgQfETcoOafYYHiW4F0batI5kE9ChP//0tV
 ITLY7HRec/ZhcaKjBKkf8W43qel7JYJtxIr+HfbHolQQwI2XAFOfk5Uybfd4IAEPT6cHDt2RC
 CYUFaHMlKCxqB21JfOFlixg+ZJjL6I2TL1sQdnJhTtFSgGwYoxHq2FOHMUpOgMkrr3oFPA/pY
 VKGanBz/zOKCtRTd1/Ex2BsLQMrI1WNl8sDoKkoTWZQ1o4Tsv8xHuVy2CWQgx+7FzjGhhqVa5
 1mJAydQM0sXNZDiu/u1dhnNdNz68IlzJthfTvy/HnKdQMYoE6R0H496yPx8leQmk4zqOi1Q7s
 kNxK8ImtDL8QBBTo10qRKQ3eDrR+HLSv+fuqHx8L6kqDJ6GwQBSm0BoM1t7kMcSrF6kFIOTJh
 GRngw1EsWyr7g6hyhrX3QHscO3cLpPra7SAAqvDAb/MKg=
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

On 4/7/24 23:53, Mark Kettenis wrote:
>> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> Hi all,
>>
>> This is an updated version of [0].
>>
>> When EFI variables are stored on file we don't allow SetVariableRT,
>> since the OS doesn't know how to access or write that file.  At the sam=
e
>> time keeping the U-Boot drivers alive in runtime sections and performin=
g
>> writes from the firmware is dangerous -- if at all possible.
>>
>> For GetVariableRT  we copy runtime variables in RAM and expose them to
>> the OS. Add a Kconfig option and provide SetVariableRT using the same
>> memory back end. The OS will be responsible for syncing the RAM content=
s
>> to the file, otherwise any changes made during runtime won't persist
>> reboots.
>>
>> It's worth noting that the variable store format is defined in EBBR [1]
>> and authenticated variables are explicitly prohibited, since they have
>> to be stored on a medium that's tamper and rollback protected.
>>
>> The original RFC was just enabling the memory back end. This is a more
>> complete version and we should be able, with small adjustments of
>> userspace tools, fix SetVariableRT. If enabled the firmware will add tw=
o
>> new RO EFI variables after ExitBootServices.
>>
>> RTStorageVolatile -- contains the filename, relative to the ESP
>> VarToFile -- an EFI variable that holds all the BS,RT, NV variables and=
 can
>> be copied to the file defined by RTStorageVolatile.
>>
>> If any errors occur during the variable init, the firmware will delete =
them
>> and adjust the RT_PROP table accordingly, disabling SetvarRT.
>>
>> - pre-patch
>> $~ mount | grep efiva
>> efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,no=
exec,relatime)
>>
>> $~ efibootmgr -n 0001
>> Could not set BootNext: Read-only file system
>>
>> - post-patch
>> $~ mount | grep efiva
>> efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,no=
exec,relatime)
>> , disabling SetvarRT.
>> $~ efibootmgr -n 0001
>> BootNext: 0001
>> BootCurrent: 0000
>> BootOrder: 0000,0001
>> Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0=
x800,0x100000)/File(EFI\debian\grubaa64.efi)
>> Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000=
000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)=
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created=
_boot_option}
>>
>> $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
>> GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
>> Name: "BootNext"
>> Attributes:
>>          Non-Volatile
>>          Boot Service Access
>>          Runtime Service Access
>> Value:
>> 00000000  01 00
>>
>> [0] https://lore.kernel.org/u-boot/20240329071929.2461441-1-ilias.apalo=
dimas@linaro.org/
>> [1] https://arm-software.github.io/ebbr/index.html#document-chapter5-va=
riable-storage
>>
>> Changes since the RFC:
>> - Return EFI_INVALID_PARAM if attributes are not volatile
>> - Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
>> - Add 2 EFI variables and allow userspace to write the file
>> - Add selftests
>>
>> Ilias Apalodimas (4):
>>    efi_loader: conditionally enable SetvariableRT
>>    efi_loader: Add OS notifications for SetVariableRT in RAM
>>    efi_loader: add an EFI variable with the variable file contents
>>    efi_selftest: add tests for setvariableRT
>>
>>   include/efi_loader.h                          |   4 +
>>   include/efi_variable.h                        |  15 +-
>>   lib/efi_loader/Kconfig                        |  16 ++
>>   lib/efi_loader/efi_boottime.c                 |   2 +
>>   lib/efi_loader/efi_runtime.c                  |   1 +
>>   lib/efi_loader/efi_var_common.c               |  43 ++--
>>   lib/efi_loader/efi_var_file.c                 |   1 -
>>   lib/efi_loader/efi_var_mem.c                  |  90 +++-----
>>   lib/efi_loader/efi_variable.c                 | 210 +++++++++++++++++=
-
>>   lib/efi_loader/efi_variable_tee.c             |   1 -
>>   .../efi_selftest_variables_runtime.c          | 116 +++++++++-
>>   11 files changed, 401 insertions(+), 98 deletions(-)
>
> I can't get patch 0003 from this series to apply on master or next.
>

Hello Mark,

there are some prerequisite pending patches:

See
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commits/setvar_rt1?r=
ef_type=3Dheads

Best regards

Heinrich


