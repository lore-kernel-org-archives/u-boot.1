Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F01C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 17:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7AF2876A2;
	Mon, 25 Dec 2023 18:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Bw1N9Olo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FD9876E4; Mon, 25 Dec 2023 18:14:28 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EBA86E82
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 18:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703524464; x=1704129264; i=xypron.glpk@gmx.de;
 bh=i7vgoAO8/1pLO+DgslzcNR8QxFnJnoxxjPRLQvPUXY0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Bw1N9OloTodZz9jrc+DknR8W1swCtL755yiQUlnj7UaqsbI+e+SRGlEzZcuNqDTx
 i9UJ385NwNTO82h5Zsp2SLu3XUUTHdQnAkEMdWQkutSUR1NcTuIWLytFfbIQBtiVM
 nOFNlpylO8vLi8HU/JW6basefor4/RDBHmqEhVsYqMxw3TEO3LZ8rCkUaVRAjiyub
 Q6MMRnWm11thPunk17nKfstKbzl51H2muqtghtvdwOYyA0ZMszeklIxEki1AJqYvs
 YKpcEZaM0Cw+ZAib9iQamZUukTw8S0T3bQ23vxc3nhlWB7hmnQPVvlgfbyKH8szZj
 VCYsruaN3/WAirhzAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.140] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1rT1zv1qMV-00GHWU; Mon, 25
 Dec 2023 18:14:24 +0100
Message-ID: <b8724e86-0ed0-4786-90d3-78e5923bc3d4@gmx.de>
Date: Mon, 25 Dec 2023 18:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix auto-generated boot options
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231220084133.435240-1-masahisa.kojima@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231220084133.435240-1-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4qzL6dhF5V+teBa9kqHlwwFCaFFU5YWWJOYU8TkJvUDigAEm9CI
 cqkVTuQ3vnAiqkGpDfrIkGgYaodMm/8ZQbcRwzZL5i5Fi7omudHb48h30OlQWm9gSmwDhLO
 jjYtHJuk4NeK7eF3Xzm+RHA7vjlxGVT1kfj3QeesIlR6/HP1ciXPhrn0bXN29bzUJtwPet1
 wrNl6ixLk0opNwfzk7qJA==
UI-OutboundReport: notjunk:1;M01:P0:Slqi8RFbiV4=;aOERQhFNtb47zdbgCZ1ULPCzxgc
 zo4l5dHeHGAN35sWCgbEarTHdwfgSNn9YcebYK5t/GuKSdQ/Cv0WzWjmQEOV+hMAqwwjgEEgG
 AEfaE3Dh2NIILFD0yN/YeD6vQUPV94YcY3+mPkPKxRFfDvqbaygFdMeLymSwN12LnVqBlFwGH
 1Lu5rHGEMh27P13pvkGeqbsz0dtXueC/GY0wubJu+RhcTgE7mpMooKISTxgxMYZyPCDUKrNeG
 1aE2eVu488CswSMSkjQgBDrWVZd9vs8qxjlsi50r3NlDMbQAwrD36aA78ra7drGv52I1Z3Ax7
 gPfoHcKnIaD6oC+h8Qn0bHNcM41C7+UaQtOwb7YVG+9/rE1oFL+1WxxBnShXKqJCjTlmVO0Hq
 CfX+F2tk8nmSBew+mtfCM+w7YxRUsczqdVIjwRENvHxcgMkrJUjmWRfmMmqmhNQwlb5ELDjDS
 0lqg3Fjinca7/itm+UtzUNTNMmkW9NsHAWVtMGD2hnIXvIAjPpaq4M2KGEvTu54+1m5Xgq4Yi
 EsMx+7XSg/1uWR8b/yTmWG7QBGCfBlM/F2ZEAc4sPvAnhPvVduVbcuprIcLd29Oo2UCV/l10m
 G1XhgcUO2POfxJz8AOzRgzZC+8SYmhxd7a2FooyfLTJ5X98+iqEwCpC9p+uGEYzhBPzGzsX86
 h7z8NVWfnTUgzv7RFQA2LnUw9msFSM2C/KfdK6qqsrNQz3Z9h+tuQO/ibBBZGSDReXoP2uPAH
 vmH0rkXnIICBHySQTSrTqF4n6YAAzdqw0ya+EaJ/hbcqk5H5RcAla5wz/vASInwoknbR8zzC5
 RmIuTwQhMGQc7pQ9FFX4NNTy5biCAEJMU5ps/MbSEvT6iU18O8cNj1YVy/oN+MfovF/t9Q2ZT
 1LZHNURgNkElcsHQutHj9X7rs88129mA7NiHh0LUQ4iXDmz2SA1zs2d86/WIFcy75Bn2UBElt
 AhXQasY7ddkO/nOrPOIgn/FSm3w=
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

On 12/20/23 09:41, Masahisa Kojima wrote:
> This series aims to get aligned to the EDK II reference
> implementation for auto-generated boot options, and tries
> to address the following issue.
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/13
>
> This series is based on the efi-next-20231217 tag.
>
> Masahisa Kojima (2):
>    efi_loader: auto-generate boot option for each blkio device
>    efi_loader: auto-generate removable media boot option first
>
>   lib/efi_loader/efi_bootmgr.c | 123 +++++++++++++++++++++++++++--------
>   1 file changed, 96 insertions(+), 27 deletions(-)
>

Hello Masahisa,

please, have a look at the test failures in
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19089

Best regards

Heinrich
