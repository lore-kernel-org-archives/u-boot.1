Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FF4C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 08:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C75E86F1F;
	Mon, 15 Jan 2024 09:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="s3Cianfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61DF86FB2; Mon, 15 Jan 2024 09:34:59 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B5A869F7
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 09:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705307696; x=1705912496; i=xypron.glpk@gmx.de;
 bh=sUe7kJpTbtwEWDgrXMnL35nw9w+2EzIYnOxz1OqS7og=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=s3CianfkzTq2j/HH4TSiJYtYFHtyq5h/mIaOd3HBGaPUp0jelOlTSnnpibEOsKbq
 Qvmy57J9IjpNeTycwV8Hiqgg+1VNFJSKYjuKIE3eh4iOwHL2+WNmpkMsymHtkf57r
 ZxBdwsXIrqkyuXN5MlTgfUTNk1MVi22RAGfkXiQnMOSwWR/OuRaBMp0mcIxwoDYAs
 7jeHJ7esxi7m/tpOtWXaKtZilB/zem0b22BBIQnkHFaHrsJIvWntxaNCzvS2vzFpb
 GAdpdN37MgOL4CRk0SoLOFiL5ChCCm0mvvK0wr/k5NBfFBRUgx5G8RfQ8DajGmuYE
 X7A36ok76eNlW5cJNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1qoHe60bk2-00pJs3; Mon, 15
 Jan 2024 09:34:56 +0100
Message-ID: <d70d5134-1cc9-4d56-9aa3-499ed992584c@gmx.de>
Date: Mon, 15 Jan 2024 09:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Content-Language: en-US, de-DE
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
 <20240110011637.174710-3-takahiro.akashi@linaro.org>
 <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de> <ZaSDUrTQ2Z5N+gil@octopus>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ZaSDUrTQ2Z5N+gil@octopus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K0aTIMdCVg1fwPMk5jWwhz2KaD2/XWQEPhYQyvB2R21EdohVrxp
 jfnyeJQYUKugNlL1PIkcXWfhGJVeBybJ/u8+2ULFOx3QtTMheSk27RYVipT2oi1JU4EXTg4
 Yk5Mz/16zUy72NkhsfOt4yVuohm5uAgbIzd64D7CmgrtfGtCqJkrbCDdDiN6mttSXGJRUi+
 fWbPYz090QGi+RHqBlLUA==
UI-OutboundReport: notjunk:1;M01:P0:nUH2Gc2oVFc=;rn/RPnjT14Uz8dbNGE4gLNXXW/x
 JvkcejPFrMkbCjXJKs4LA9WBa/yc806Tzp1d4SU4LvX8Mhwt5/DZ0QEYst2fGzmXP2hvuYsqi
 YZSs01S3S1n86SBUuiGKABWrd5YAX5Gs9NPDJXvjptVrvzskpIeY2ZYJCy7q3oIDlHzbTWn+X
 y2Y+EkkTyqPwO0MYeHwIKKSAj7w8/TPMuNogmf/7dVlBY1AToyOlQyv+4OqPx6PZCIFeZfCo8
 OVUEHuGAog5rX/SVXOl6ZT/xBYMv7PBWVjX0HlOV3dkfQyrItKvuNoZ1Z4IWJV/u18QZ9Oka/
 NOxZ+kmGLlXPdZWKDRUuKidGG2+vilZ9Hqh5WQfIo3SMw8aroRk1HdLfFn+eKhyYUnuLjjl8t
 VeGn5VYFuhS6xUiYHDM/C1acL6YHQN8K+BmIh3LpESxeC8wlovxqslzzLlsz3k6Bjj4r5DUs4
 ltpezke0Bl4WMevDAoMeKXeB1PtTn1IFXTrXFUKwdohoEnm6bEsvJ5acM0X+nmO7yBexP69L+
 itef0/Li0qOLZb4KxnDZGXa3VezDvrIfmrDMjCdg5AkVSUIFk8WaJzPn/CS5/Z6PT485e+AAV
 Ov26Me1rbnve2CtbxLt8r/kd7nc3SuwkQ7hziFg69t9V/wUrmRj3Q2v/oenQQl6ti8MFVYNf9
 QUoRtHVOGsxnUUf2nwmx5N9CIeFGoeWtUbnuRw/BFZ9qeoBA9iF4zIwN/v6ggUNtKNEb9cGWn
 swKjQXQPorLTPpcB6gtar4JcrK/sZ+f2kE+CMMjXn/xjZENder6MU0hgOb0fKmr8g6G6k7q+t
 kuhmRKVLP7V7s5iXz1Y4cDOl5oAdeG/v3LU8RHfiCEL8DzpN8uSOf3KJUpJvJBFjh9yT8UbnE
 4w5fvrLqdJfiSPCD9ExY00Pw+tlEP/6IWgoo5H5Qb2noazZDx/p+1PmeJkPBLKfH9RzCOlIlS
 tT62t5rVkQv8LtYBavLZ3bqaVpI=
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

On 1/15/24 01:58, AKASHI Takahiro wrote:
> On Sun, Jan 14, 2024 at 01:46:45PM +0100, Heinrich Schuchardt wrote:
>> On 1/10/24 02:16, AKASHI Takahiro wrote:
>>> At this point, EFI boot manager interfaces is fully independent from
>>> bootefi command. So just rename the configuration parameter.
>>>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> This patch breaks the 'bootefi hello' command in
>> qemu-riscv64_smode_defconfig and other QEMU defconfigs.
>
> What happened? Please elaborate details so that I can trace your issue.
>
> On my side, I didn't see any problem with "bootefi hello" on qemu-arm64
> and moreover CI check (github pull request) didn't complain anything.

The failures are logged in
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19302

I have pushed the tag failed_20240114 to
https://source.denx.de/u-boot/custodians/u-boot-efi.git for analysis.

Best regards

Heinrich
