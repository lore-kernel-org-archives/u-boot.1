Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11728C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8461B80C93;
	Mon, 16 Jun 2025 15:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gS0HRAz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304F281760; Mon, 16 Jun 2025 15:46:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF258070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750081611; x=1750686411; i=xypron.glpk@gmx.de;
 bh=wL9KQy0xDZVjmYDatFo/xpfhf0+xWvlb/hRezikoysE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gS0HRAz5fW7PIufUWIjzI6KLYHFrBd8Rc9ksILrt04oxaXaAiPaIZkSmV3S+4rP1
 pak0sM3QRxdLa3IF6mGmtKNfKT7XLYoXXEOXLmh8juOydo7HYo9WeLproGSxTQrnG
 iV2jnYE2KRh4menm8iEUy/Ld3fXUe/OCcW6KnRgbJ3G1o1PUK48pyKdUmDG7D6VHF
 BeN8a8ahrjavtk9JASeryNb5LmNDHZWNt2tltZusSJK8XEKnUK6adlIb++WtWRUZp
 bQpjfx593Y7j/VYNGd8I2sQ+o1JXTFCFVi4galYdOCk6XSVxrFV10MbnXyqMm+9In
 vuWwx/7MxPzDLGO/hQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1uzQf839Iq-00flrk; Mon, 16
 Jun 2025 15:46:50 +0200
Message-ID: <a6e2637e-a748-4b0d-88a5-13431284dc06@gmx.de>
Date: Mon, 16 Jun 2025 15:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] lib: efi_loader: efi_memory.c: add efi_realloc()
 for realloc memory
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
References: <20250611050844.210384-1-paulliu@debian.org>
 <20250611050844.210384-4-paulliu@debian.org>
 <CAC_iWjLhWKRdGmuwV6OO-yKBbbjE2Kdr=NrxbMoR9Rxy4NYM=g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjLhWKRdGmuwV6OO-yKBbbjE2Kdr=NrxbMoR9Rxy4NYM=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w1ignUZyDTevPChhYUxfWtgQHAkQCEXkPwgh/y5syrrW1tugs9Z
 JiniShbFV1to49uAUK26sBn+s4aOsncqaNPlRy0JCLM6z6wGWlSSFlv0oYTXTGrEdV3Tasr
 UyBnvlsrXQIeHlLtEfXblPMu9tKFJO28GIvOgUs5TGcgMNVjg0zWjXRCYegW/NI9u2+cEby
 s/u7cTUfWxUXeu4tePmhA==
UI-OutboundReport: notjunk:1;M01:P0:UThNRrv/ywg=;0Sm/UDvwEy1pDY2XKXgH1Qw6/X0
 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
 taURrksMpzb2bJKVBW4ufbDgW/X2eR0/hLpAjA==
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

On 16.06.25 15:09, Ilias Apalodimas wrote:
> Hi Paul
>=20
> [...]
>=20
>> +/**
>> + * efi_realloc() - reallocate boot services data pool memory
>> + *
>> + * Reallocate memory from pool for a new size and copy the data from o=
ld one.
>> + *
>> + * @ptr:       pointer to old buffer
>> + * @size:      number of bytes to allocate
>> + * Return:     EFI status to indicate success or not
>> + */
>> +efi_status_t efi_realloc(void **ptr, size_t size)
>> +{
>> +       efi_status_t ret;
>> +       void *new_ptr;
>> +       struct efi_pool_allocation *alloc;
>> +       u64 num_pages =3D efi_size_in_pages(size +
>> +                                         sizeof(struct efi_pool_alloca=
tion));
>> +       size_t old_size;
>> +
>> +       if (!*ptr) {
>> +               *ptr =3D efi_alloc(size);
>=20
> Shouldn't you check that *ptr !=3D NULL before returning success here?

Hello Ilias,

Do you mean "check that ptr !=3D NULL"?

Best regards

Heinrich

>=20
>> +               return EFI_SUCCESS;
>> +       }
>> +
>> +       ret =3D efi_check_allocated((uintptr_t)*ptr, true);
>> +       if (ret !=3D EFI_SUCCESS)
>> +               return ret;
>> +
>> +       alloc =3D container_of(*ptr, struct efi_pool_allocation, data);
>> +
>> +       /* Check that this memory was allocated by efi_allocate_pool() =
*/
>> +       if (((uintptr_t)alloc & EFI_PAGE_MASK) ||
>> +           alloc->checksum !=3D checksum(alloc)) {
>> +               printf("%s: illegal realloc 0x%p\n", __func__, *ptr);
>> +               return EFI_INVALID_PARAMETER;
>> +       }
>> +
>> +       /* Don't realloc. The actual size in pages is the same. */
>> +       if (alloc->num_pages =3D=3D num_pages)
>> +               return EFI_SUCCESS;
>> +
>> +       old_size =3D alloc->num_pages * EFI_PAGE_SIZE -
>> +               sizeof(struct efi_pool_allocation);
>> +
>> +       new_ptr =3D efi_alloc(size);
>> +
>> +       /* copy old data to new alloced buffer */
>> +       memcpy(new_ptr, *ptr, min(size, old_size));
>> +
>> +       /* free the old buffer */
>> +       efi_free_pool(*ptr);
>> +
>> +       *ptr =3D new_ptr;
>> +
>> +       return EFI_SUCCESS;
>> +}
>> +
>>   /**
>>    * efi_free_pool() - free memory from pool
>>    *
>> --
>> 2.39.5
>>
>=20
> Thanks
> /Ilias

