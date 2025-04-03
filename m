Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66051C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 06:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26C281CF0;
	Thu,  3 Apr 2025 08:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="T6G2loqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AACC81DE3; Thu,  3 Apr 2025 08:57:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1D48043C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 08:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743663425; x=1744268225; i=xypron.glpk@gmx.de;
 bh=2k8dGNoQA8Qz9Jvp/6PYL9EWeBM+7Pd3V1PuGspBdvY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=T6G2loqdHDA4Ei5EyaH1NgM0db7P+8cHAN7RHnZVqF8h+xZs9qo0qa1fpEJmAS8n
 zs9wa2RplTQdZHhiv82HLNv0hxEuilIlyimTIkQenmR14gaE3D/LQqAJsUqLuQUZj
 Gr1LqVOyUsEf6DxO4q8mCxzk3gZzkFTDM5UC+MmLRLXFKHmRN8mAVVqLbP1Ucbm6j
 +wEKBHtGgaaCEmI9ItcZ8EucbwNHyvqmMissqXVBhHbJAl2idieuOmY3niWtQniM6
 5H6e4aO6ookQShcdaAqC9Iuzlfm78ktgkPqQxt/LPY7WMWQsYijRPTnuAMtMFlVJd
 He22BcWyqTcRb0bgJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.115]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1sziJ31wjU-0138GH; Thu, 03
 Apr 2025 08:57:05 +0200
Message-ID: <e23ce969-3cd6-4bdf-9119-d0175806ecd1@gmx.de>
Date: Thu, 3 Apr 2025 08:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Fix table length for QEMU
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20250403053444.2551339-1-ilias.apalodimas@linaro.org>
 <CAC_iWjLTUgocaxOPDtQCGS==yjV=66_=37nFv-Grv6b32FNDYA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLTUgocaxOPDtQCGS==yjV=66_=37nFv-Grv6b32FNDYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ov3Qq8nAlN1Nn6b6TAwPzdw66TUpsRhDudUvV9AxniiCHPXSTDq
 dGlU7SvXE4+FK2t4aTq98YqGEi8vpsk84f+mFKUQRlyuBhPYD/lW04cDVMSJ8MgG8LLLLsu
 0P4j0UKZOfIh4FhqkOpQZipEBNUCW8VmUhURk8aW18onoH+uwFdQdpAGtutNX81LZS9OYW9
 eBP64AtPS8si/477PKmLw==
UI-OutboundReport: notjunk:1;M01:P0:g/789VK1gbk=;bhPPKPVxEAs0HS9aifoVIWrfNOy
 K+q0zYqNZgd9t+tJR4Hwt1Njb4LPzDX0rIZYfQdgVTxY3Dg26iBi/eUF5eGCXwBRR/bKmaRqv
 XUgtKqgtMKl1CiSYR9o3pAogIhd+3bQE+yvsJAD9lLeD4cA0iq7Qlp+2VXn7Av9ifqEEvUYB+
 xatJL2PAYKdEB0xyTTLvUqbnBJfjpOBYHfmjFz3dZeVPj8TnnsukwM1rcA2t3Sdh5oWw2exbz
 Jfkhr5AC8G8XMWZjPsEXD/XNRS71RdX5CFYLs//0uf445RkLeP/Hwh5Y2TCay634qdNrdWQjk
 30U3bW3Gy9TA9IcuLeniQqTsWQ6tjKlRjEotI46GrtrIx/jUaWXw8BGdrhY0OiCgi1wAgt0VL
 XJiOdVBj4e+8UEQgAfRynMD1I2X+gqUwvWfw+CzdkwmeUGsudpcJ+PEdga5s/OGCVtHOinVth
 Uiokjpb9WSe+4WsQ77ZKjQYLtJUdWpXb6Ey3JtuwfqTanqSLtevdwtpVosdfLMBpjz7w97yDm
 Y9yvkmeckcN5LWBOgvQPINjuKS9VN487QMaETYX7kUALDAMNUNuYLVjxHOeBQSTHTuiPOrDHU
 jLMsCC6WeRj2A62RFfI4wqoCGSXfI4Y39hzbGgq//JHwoHkolmb1y2+sxXSM/eSbngxHVRdH7
 ZmQpzgc26PvYpZcjO1FRH/53Q56cu9nPi8jaukj0qGnysC7MtY47Y2GQt2Dvuak/p2OoaMk2R
 cxp8jhBB+kpzGMOTjKsk8e/x/BYA5q9btyUepIh1kuT7PfG8uVCViD0RCR7KRTAH0GOgarLJo
 Irqxij3SkoVOHKl06HFj2qb5HZ5cq06cI/tNTt1vXVvXo6+xOKKND19qklLnhbvO4GdBL+4EP
 /SxmIwckA6/t2d8b+zPBWS9dhhpGH835cVRvHUE1zS7L9cv8zqHkj2VwexDx3V7Kk6Twa5kDN
 ycNOLx0rHjNJTFSAoid2TnyddlmjwnPvSsRmWBDG+6/T1rrFAaUyYVdNX/nJzGBEhRFABo2eN
 vSWfRXXx+/nyLnMOUfe9yRPf3FbTTcuHlMs6l1SChjCdlRimcZgwCWFerLXtktYssA8YRhHJu
 h28N+dMB72DPCA7Po5fIkeECwXCuF2pyBLvrD8Fb6k1aITXC6SKrsVRFCjeESg3maD9jcmRrp
 fF7EZx7LfvM4SIbvIu+UxDIfojXKCZuiep3cMBDCBHvdFoY6Q73UbVLjOg6J63O9vBFWgaSw8
 K/3YNWiJaiUTY/ZpNPsEiWTCZ4gCG4nKmVfZ2d4gBoNYsm5WgAKGf9fDwaw6rHI5wbVhCaenQ
 M1+FNSLigO4b3TbH7zjDbeISUoV/5qwbxn9PDodX8FiKt8sBx/SDFWuWOYqjoJUpYOkXCh+oD
 Sw22NREWZDq5CGFiNx4Q3LHfLNkP57D1ihcqgjG8llSRd1BO/px0388Ar+dj9goSpy/Y5E5KV
 nyCWqRqW5uDfO/M52SOFVyQ8ISyJ7XnSjdnChOsPOSqzK17Fj
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

On 4/3/25 07:53, Ilias Apalodimas wrote:
> On Thu, 3 Apr 2025 at 08:34, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> The end of the ACPI table is set to 'addr' instead of 'end'. The ACPI
>> code for QEMU relies on those values to mark memory as 'ACPI Reclaim'
>> and as a result the ACPI RSDP ends up in Boot services Data.
>>
>> Reported-by: bjorn@kernel.org
>
> I obviously messed up my reported-by...

Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
>> Fixes: commit 638cc363484b ("acpi: enable writing ACPI tables on QEMU")
>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>   drivers/misc/qfw_acpi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
>> index 0d0cf7646890..77cebae5e3fd 100644
>> --- a/drivers/misc/qfw_acpi.c
>> +++ b/drivers/misc/qfw_acpi.c
>> @@ -305,7 +305,7 @@ static int evt_write_acpi_tables(void)
>>          /* Generate ACPI tables */
>>          end =3D write_acpi_tables(addr);
>>          gd->arch.table_start =3D addr;
>> -       gd->arch.table_end =3D addr;
>> +       gd->arch.table_end =3D end;
>>
>>          return 0;
>>   }
>> --
>> 2.49.0
>>

