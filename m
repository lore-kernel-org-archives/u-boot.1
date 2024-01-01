Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B04C47074
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 09:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC031870FF;
	Mon,  1 Jan 2024 10:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="loDAQ3jQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B79587120; Mon,  1 Jan 2024 10:04:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CE2870EA
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 10:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704099891; x=1704704691; i=xypron.glpk@gmx.de;
 bh=jBkNZ4dDkHrnuFngtxD68x7cAUwZcajsPiRO+p/0Has=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=loDAQ3jQ0mwtgAe4UGKPz8P/tZJN14WlDqrffAhThf2ZAP4KUntx1AQec45qovsk
 TBCpj5hW8WVGi763M4p2gq79rEs7PxZlGNP73jaWJzfqvSTtStf788kA+6rVLiPOQ
 GMoZFMpViT/01VjLVY8UuSFuXyKualCwBtRLQS+rgQ3WNh6OyR7P/zE8ebiRUIBpu
 ueawmrRK3a2O7HpcKG1QYFVx+Gx0z9bou1cDgEgp4fTh502gZ+ZDq3046L16bIVvl
 BOS7bEg3TfH3yzjQo7sSOwJC7OV5fQrjdUAGze/T3NvZvhvZ1Ew+HkHawWUKppcVx
 /jGcS9N/+eR0QUKMfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1r5KJA3i50-00uqmP; Mon, 01
 Jan 2024 10:04:50 +0100
Message-ID: <a67e7053-e02c-440a-9288-7c3d71c1627a@gmx.de>
Date: Mon, 1 Jan 2024 10:04:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] efi: Correct smbios-table installation
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-13-sjg@chromium.org>
 <da23504c-e4c4-461f-a6f6-5d52bc79a549@gmx.de>
 <CAFLszTjcmRxoG6C_nw2wX1gfK9y076YF7aPtME=jr=4MH4zTZQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjcmRxoG6C_nw2wX1gfK9y076YF7aPtME=jr=4MH4zTZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m+6gJgzWLZ1WcD9/n00Pn44g00wsrjHYA/Irqjtu/YxLxxBwB6h
 XfrukyjCZrHZ0o/BpW6t8vyA6E9uKPDqENNfBK9W6IihJnZsmrDR5YnDh183CtG/atJLObM
 sW5NEOlUIqMCSw6qm4Ulm5dapYxZpgxwvDUwZ2aCZD8oA6T0385sfxXhgmQRuUzgUOkjV8w
 dRZapXdvBSLCJQX2Ryw9Q==
UI-OutboundReport: notjunk:1;M01:P0:XPJ3f1PFCx0=;XeFHayk12rv7HxAmRrHR1dU/SIu
 dJssrKVxCE/aeXo9WwVM6C9NkTic4YR1DN1pwiXVatW4KihwGFXPkI+eGdbMaO1+vF7n7nujn
 hQkJwwyBrTdQ0k9AZuSituXNonCKUucuvN6lfLUkb5ri9W6g7gFOrHAO06h/+e4XSiC7iflNY
 cr4wo7cEgpHhbXEUgBFPyR23HcJsky1p8mqSyQj8vGW6WR9DuTyDl2EyhCZ7B1krm/DVR+CUQ
 2sN0weoE7cIfWcCBFlEZo1BLW2ZyPA02v96IMY/P8JW+X3CqBxTbL14qr7mJH/uw8G03fKHqq
 +qVFczFF6oqIP1f6HMyQl64NG+wvelrIjTE0sWYLgSCFa/JPK5VnLLhI2GMvj3x0RtrPpa+og
 AWE9FoiQ+r2YexK21V8hqqZpTa4NLj+6uMouj+8q+jnLYxtoaX3l3Ma+B6MYeIXQL089ULhY3
 kdQp0l5m8S2SOAO1mT5nQwxaZLI1FK5YxrIvVlBhp2YZR/ShFnlfRarlJwL+0qctY2d8iFLUL
 06+/s0e48Udm0pj64/kr6R0sR112W7Ioq9MZF4nHum8WAqW0wvXljj9NUZDL/T6OVwzSmZ4TD
 yJK1g55DUqNTLnbISTBqjy7ewBDeRtJuYzKYwsnFbkrZe3842mSS/E9PqX+D84VblaP9CNOFF
 wmg02bBx+duwWSFRpGYoE+TI7lW/9Ch8NZDLknS0IpwVezGVPD67pyvVAzSV5nZqKIURuAiTc
 c0nWqANLoZoLadN9QRQI8tlFu+B9b8vX/E/SsLOPYl3gAO7GTQVMLD7Ndc16u2JOJn4vY2UR+
 3j1KuR9WLWlJr60g9E80rbhLja5I3N1pN/XpWFyc31EfDejAttCwUfuffEJBiReOgZF68Qi6b
 EXT0AMfXpnkAZNLCACneMcclgl477DEtCxXJHQk3bPh6Leh1Np76iXc1+IN+j0u1oP5yjimG9
 Kx8+AY1o8HCEqe+RWbtPbX5UWy8=
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

On 1/1/24 01:37, Simon Glass wrote:
> Hi Heinrich,
>
> On Sun, Dec 31, 2023 at 9:27=E2=80=AFAM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>
>> On 12/31/23 16:25, Simon Glass wrote:
>>> At present this code allocates memory when writing the tables and
>>> then unnecessarily adds another memory map when installing it.
>>>
>>> Adjust the code to allocate the tables using the normal U-Boot
>>> mechanism. This avoids doing an EFI memory allocation early in
>>> U-Boot, which may use memory that would be overwritten by a
>>> 'load' command, for example.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>
>> In patch 11/12 you changed the address fields in ACPI tables from
>> sandbox virtual addresses to pointers. Do you plan to do the same for
>> SMBIOS?
>
> I haven't looked at it, but could if it would help. Are you planning
> to add an EFI test app for sandbox?

Yes, we need a test checking that the SMBIOS protocol is correctly
installed. A tool like dtbdump.efi (lib/efi_loader/dtbdump.efi) would
allow to dump the SMBIOS table to file and then use dmidecode to check
the tables for consistency.

Best regards

Heinrich
