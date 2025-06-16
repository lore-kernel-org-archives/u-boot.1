Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9D9C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3168E81760;
	Mon, 16 Jun 2025 15:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QQhzwkFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FACC81E18; Mon, 16 Jun 2025 15:39:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEB680C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750081152; x=1750685952; i=xypron.glpk@gmx.de;
 bh=4HfwZVDzsBl79SX6I3JfctinG4GmtxSo7WLwr5w8Szo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QQhzwkFIDCq2E16nDrqwAjN7pPPLRXmsmCvjqD49ortCTjeTI2OTkfCc48eNqzWs
 zLL19wODom826zXv2ghUY+Vv2G1SvEH0oopKdq2CehiEGNvynXYB0mzVAZAIuj1AL
 RMoQus/npCtJjJImoWzH688UsztPgLZG95bzyZkNYS/tX68b4aQq0WnVwsbE5duBy
 Zja1WsS51JOWMCB02ujwTu+JeJ3qwSqMVCfarBUDMR/q04GjAR3emm34X3s64l4Wt
 ZbX9VqRF1/cUOlMulLy1XxjTVrjEBix65SlmTGodZNIc1+gCuiJmmXjsamDEhIGXK
 7YcFYu+hni+rLPtMNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1uepE11L29-00y7kc; Mon, 16
 Jun 2025 15:39:12 +0200
Message-ID: <5d30ed64-cffc-4db0-8e92-986771e024ca@gmx.de>
Date: Mon, 16 Jun 2025 15:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] disk: efi: Move logic to get a GPT entry into a
 helper function
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, mkorpers@redhat.com, mskrivan@redhat.com,
 eballetb@redhat.com, mripard@redhat.com, alexl@redhat.com,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-2-javierm@redhat.com>
 <CAC_iWj+YfdT=6nazVJQEuYH_RuWbXNL_FmOL57i35Z4rmOi6Sg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+YfdT=6nazVJQEuYH_RuWbXNL_FmOL57i35Z4rmOi6Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HG2fqMsTOS1xuqMXTEDfQFosDGcQ0DvayNGY/AmoCE2Xbbuwdh+
 xzlSUaRiLq5p9tO5542QMWH3uMUxbPBm3lOyb5ZxqhUedsTnAGYPl4b+2VqHtzDndNEFAMM
 BBe2KXgzAnOkml59b5B+OpeApdsZhWCrurOIuWrFjS7tTwmLXMDQ9WhjZSRePK2Zt+jmWhC
 4vHYk7qxnekgLXzBTzbDA==
UI-OutboundReport: notjunk:1;M01:P0:4RUo2oousW4=;gTZvEyibF2Al46Z0xEP9euHc+U5
 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
 0CLo1qr
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

On 16.06.25 15:32, Ilias Apalodimas wrote:
> On Fri, 13 Jun 2025 at 11:58, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Factor out the logic to get the Partition Table Entry (PTE) of a given
>> partition into a helper function, since it could be used by other code.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   disk/part_efi.c | 67 +++++++++++++++++++++++++++++-------------------=
-
>>   1 file changed, 40 insertions(+), 27 deletions(-)
>>
>> diff --git a/disk/part_efi.c b/disk/part_efi.c
>> index 932d058c184c..c7d79e253958 100644
>> --- a/disk/part_efi.c
>> +++ b/disk/part_efi.c
>> @@ -216,6 +216,34 @@ int get_disk_guid(struct blk_desc *desc, char *gui=
d)
>>          return 0;
>>   }
>>
>> +static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry=
 *gpt_e)
>> +{
>> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blk=
sz);
>> +       gpt_entry *gpt_pte =3D NULL;
>> +
>> +       /* "part" argument must be at least 1 */
>> +       if (part < 1) {
>> +               log_debug("Invalid Argument(s)\n");
>=20
> I think this should be a log_err an match the comment above

Screen output during a running EFI application like GRUB should be=20
avoided as output will no longer match the expected cursor positioning=20
for the EFI console.

Please, stick to log_debug().

Shell commands like gpt should write a message based on error codes.

Best regards

Heinrich

>=20
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* This function validates AND fills in the GPT header and PTE =
*/
>> +       if (find_valid_gpt(desc, gpt_head, &gpt_pte) !=3D 1)
>> +               return -EINVAL;
>> +
>> +       if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
>> +           !is_pte_valid(&gpt_pte[part - 1])) {
>> +               log_debug("Invalid partition number %d\n", part);
>=20
> I haven't read the reat yet, but isn't this something we want visible
> as a normal error?
>=20
>> +               free(gpt_pte);
>> +               return -EPERM;
>> +       }
>> +
>> +       memcpy(gpt_e, &gpt_pte[part - 1], sizeof(*gpt_e));
>> +
>> +       free(gpt_pte);
>> +       return 0;
>> +}
>> +
>>   static void __maybe_unused part_print_efi(struct blk_desc *desc)
>>   {
>>          ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->bl=
ksz);
>> @@ -261,45 +289,32 @@ static void __maybe_unused part_print_efi(struct =
blk_desc *desc)
>>   static int __maybe_unused part_get_info_efi(struct blk_desc *desc, in=
t part,
>>                                              struct disk_partition *inf=
o)
> [..]
>=20
> Rest looks good
>=20
> Thanks
> /Ilias

