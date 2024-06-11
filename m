Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED92C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BA6886D1;
	Tue, 11 Jun 2024 16:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="XkQ7nkc/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdUVflKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B217886D7; Tue, 11 Jun 2024 16:07:19 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7E18865F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 5BE4B11400EE;
 Tue, 11 Jun 2024 10:07:16 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 11 Jun 2024 10:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718114836;
 x=1718201236; bh=qA0KIPTQ1U1pOx6Qo0PLSifCegwwfa5G+a8ZLPvc14A=; b=
 XkQ7nkc/tDvt1+/eobrsXQqs3QW+caRA9CIw7I/yAUntZ0E9dchWu35A72NO7TFr
 tUvO8kuDzfgxHYm9twirybu6TN0j+tQgs9u7CaAoVSNsS0fpwj92YjKIABNAyqGE
 x2hXeTQP6XV1PxlvLfy7UoC/a4P8O6xY9DvEU1lh5a77F7k5cgTxpVvvsAjYckwo
 rUTpnzZ3/HA2urPK3a0OgK5XdkrdIYTGrszEKirNptl7NrH3JdPRHugjrQLCYTZL
 AcHh6YUe/g0qsewhEKx3cheVuXiAyphA9C9OU7QaNzKEv4jac3cypOmc2hAYBpEO
 biIiwRgYcxNe2raeMqe7zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718114836; x=
 1718201236; bh=qA0KIPTQ1U1pOx6Qo0PLSifCegwwfa5G+a8ZLPvc14A=; b=I
 dUVflKSCqy+CsuLwTTZpr09/2qqR4elqoaS/D/721ardbNT0siN/9ZqnxX4Kx2pe
 oQ2blTVuKOKl5NlBejG4UQfBbUs/LuU0Tcqj/lhHNusk9xYGy+mQMOrtq7idmq3H
 ZWwcEf9B5EehvYACcnqg4aLM0E5Y6JdPQKG3/7EcYYJ8vteeepcT17MrwTugS/Mw
 dxwMzkGpXlqKei2C6avOnS4orp/NQ5qS/IB6t7PSt761T+tQ3ScdsiKFA9vsgc4g
 4dkMDVKDhasoyiCsktaCMTnT6XjBphSni2vP/Ex+zOfuDjlAEGIR7vc/61JDzD0I
 zuZN7FU8ZQJZ4JvgFSqEw==
X-ME-Sender: <xms:FFpoZiqUNseTOD1EIy-URVAxRHwzZRL85TgAJEWCk3JHONXJfSo4ZA>
 <xme:FFpoZgruCCb9DxPQyoPJWosJZn56iiyGPFFuR_e8wibPpD2FG2Xs4Pp_aDM89x_UU
 clF5KA_V6T4xjYheXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:FFpoZnOuQkwF9zJp4tqGrzeTgmvFEaKtGLRWGXiTkBG8blYc_tlVyg>
 <xmx:FFpoZh4FBzIJ31TjUkJBH2ZG2ysJM1nseITNjNb3Li5D8sDtCYzx3g>
 <xmx:FFpoZh7mgZO9bymps_hHMpt8btT9ZIeWKjQd-qR1E5M6smZeK1ds7w>
 <xmx:FFpoZhiLnCuhw28YSHOnIKO8TW_oHYkCAYPAdPxMyihJdLz-zWbCNQ>
 <xmx:FFpoZk1Dq-_upbBl0fi06oHmD4Dfrls9u61ZMmJr5uOyf4ityIrVHAqH>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0C24136A0074; Tue, 11 Jun 2024 10:07:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
MIME-Version: 1.0
Message-Id: <c789596e-d676-4fcd-a25b-4311257a9153@app.fastmail.com>
In-Reply-To: <CAC_iWjK+KdrYWWfdVVqzyzUia+b7sddKHPF+ziQFp_Am0CbzQQ@mail.gmail.com>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-3-79096e3ca3b3@flygoat.com>
 <CAC_iWjK+KdrYWWfdVVqzyzUia+b7sddKHPF+ziQFp_Am0CbzQQ@mail.gmail.com>
Date: Tue, 11 Jun 2024 15:06:57 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>, 
 "Tom Rini" <trini@konsulko.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/7] Makefile.lib: Preserve .rodata section for EFI file
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=882:49=EF=BC=8CIlias Apalodimas=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun
>
>
> On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wr=
ote:
>>
>> This is required in performing objcopy to MIPS EFI files.
>>
>
> This seems not mips specific. What was missing for your case?

So MIPS EFI file would come with .rodata section. If we don't preserve
it here, the whole section would be stripped away.

.rodata is always necessary in binary if it's in ELF as it contains
valid program data.

Other architectures won't generate .rodata section in their ELF file
so it's harmless. Besides GNU-EFI's universal strip commands also have
-j .rodata argument.

Thanks
- Jiaxun
>
> Thanks
> /Ilias
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  scripts/Makefile.lib | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 62f87517c09c..52aed7a65d47 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -469,7 +469,7 @@ $(obj)/%_efi.S: $(obj)/%.efi
>>
>>  quiet_cmd_efi_objcopy =3D OBJCOPY $@
>>  cmd_efi_objcopy =3D $(OBJCOPY) -j .header -j .text -j .sdata -j .dat=
a -j \
>> -               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
>> +               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc -j =
.rodata \
>>                 $(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
>>
>>  $(obj)/%.efi: $(obj)/%_efi.so
>>
>> --
>> 2.34.1
>>

--=20
- Jiaxun
