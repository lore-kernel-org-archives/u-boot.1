Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4284C71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137DD81E18;
	Mon, 16 Jun 2025 18:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AEuYcA5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC292829F5; Mon, 16 Jun 2025 18:10:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8830881760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750090206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yGQy7Ko49zmw95q7LZugeQLSiiaP9bCKWVxCGIAyWI=;
 b=AEuYcA5ZIT3KObhDNannGnm1CdaA32SkWYtFpyqIKX2LwffNNLzRlShZyQpRMpf1Ltpv8I
 sZLrTBdN4YoKUScQCtpQkF/ms2lglFce0UwL9Age5s0HFPrs/qz7Fv1USnaHjAPaghB9Ct
 KjJZeu2DYy88E35bHXV6/J7zg2m+TtU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-qXu1bCgJNN6EgnP5EvCA0A-1; Mon, 16 Jun 2025 12:10:04 -0400
X-MC-Unique: qXu1bCgJNN6EgnP5EvCA0A-1
X-Mimecast-MFC-AGG-ID: qXu1bCgJNN6EgnP5EvCA0A_1750090203
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a52bfda108so2252040f8f.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090203; x=1750695003;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3yGQy7Ko49zmw95q7LZugeQLSiiaP9bCKWVxCGIAyWI=;
 b=Q3L4foAa4HzqWMIMxBlC/eqzydUhaZIHyMYfIDM4n0TMx1lj4GGSIfo6NusXbu80Yo
 kCKYFOZAATCCm6y5KPivUqfqSxOqOo3MlQhYQ3FxptLEvjA8HWToFbkXSo0zpX7603tu
 iiW2F2V2eOk7OYf7hZxxiwu5CUo6yJH1f6UOp1wuLa4OLsQryohpkTuRBJl4G+WhmAqg
 HzGatReR9DLzT3DVujKz6S7J7Xnea2cT2Ib4Cm+FGO6sTb6jvq/BiV+zZaPLGELwjJD6
 D+jK7LlN8OMC4Aw19b11m9YuVltjDsqj4ViUyYNmqjIqyVv/G372xj/mWdQA+tiyWMvq
 41DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDszSmeAoWLhhHG0nOuU5RFqFrTblWqjrXCo81ofJukKPTIAWt8LWkT3PAKx3WPeER/xuYgow=@lists.denx.de
X-Gm-Message-State: AOJu0Ywyy6RDtgFwD9ATFYEak8o0ruKw6Q4sf2ybNjQliaZP8Ux5N5pT
 n/QbCiSB6lJrUGOqGZ7WAfUVheW4NFwPJ9/RfBkLU3oK8/OjGSKwdSYUHMsdbCui6LHTipemB+l
 eLsRhlbs33G6CiHftlqyqcjjuW+JZuXrs1Xx5tfOT2ccK4RMx6TBhOJY=
X-Gm-Gg: ASbGncubARLsUWKROSNYKplIGHkdV1d/Xcrpho1n73zcVv8IKJhe+OV/o61p5kMzgbO
 sUfokDDu3jAE8zYB81DNFCnnU1mVHbUeX8kpGgh5Aw9dsQLFBjsx670/dwvYhrCcKx+yClqFzem
 cHpfHWWQ6Au2WNqhlq2Cd3riPzD8qsxvIoOq1yOSSXj5ltrew8rc62wEh4q6gRhFk1CihI6wmQB
 d2x+ki2yblhU16TGaLn/pqIR1ZTRF2NOoiaTfaQZFCxShEJlNYuyTKKLVmHIFr83aSp14CyCWfW
 J7/VPD0QEJ4ZTSxL3yBwudeMboscjYa/cc8dj5MHB3U1nIZLyWvmVF/U5TLXkdRNNJydxqG3/nm
 Ct7yR
X-Received: by 2002:a05:6000:200d:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a5723a26bbmr8569519f8f.31.1750090203464; 
 Mon, 16 Jun 2025 09:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4wOscGyKvbT++ODhXzNPqL5QMVOdNXbsskizutIQW6ZrXoeRwMrM2p2ev3kmRWhiaJxA4XQ==
X-Received: by 2002:a05:6000:200d:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a5723a26bbmr8569466f8f.31.1750090202985; 
 Mon, 16 Jun 2025 09:10:02 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b2ca65sm11535069f8f.77.2025.06.16.09.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:10:02 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com, Casey Connolly
 <casey.connolly@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] disk: efi: Move logic to get a GPT entry into a
 helper function
In-Reply-To: <CAC_iWj+cqadHgabnWFXXFmzYBpXs+sgbCGHu3eB9dANmcrYfCQ@mail.gmail.com>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-2-javierm@redhat.com>
 <CAC_iWj+YfdT=6nazVJQEuYH_RuWbXNL_FmOL57i35Z4rmOi6Sg@mail.gmail.com>
 <5d30ed64-cffc-4db0-8e92-986771e024ca@gmx.de>
 <87o6un7p95.fsf@minerva.mail-host-address-is-not-set>
 <CAC_iWj+cqadHgabnWFXXFmzYBpXs+sgbCGHu3eB9dANmcrYfCQ@mail.gmail.com>
Date: Mon, 16 Jun 2025 18:10:01 +0200
Message-ID: <87ldpr7jmu.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0m0GqvS89fbGcact_TW9R0sj9pqw9HbP-51c3Kvt8wI_1750090203
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:

Hello Ilias,

> On Mon, 16 Jun 2025 at 17:08, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
>>
>> Thanks Ilias and Heinrich for your review / feedback.
>>
>> > On 16.06.25 15:32, Ilias Apalodimas wrote:
>> >> On Fri, 13 Jun 2025 at 11:58, Javier Martinez Canillas
>> >> <javierm@redhat.com> wrote:
>> >>>
>> >>> Factor out the logic to get the Partition Table Entry (PTE) of a given
>> >>> partition into a helper function, since it could be used by other code.
>> >>>
>> >>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> >>> ---
>> >>>
>> >>>   disk/part_efi.c | 67 +++++++++++++++++++++++++++++--------------------
>> >>>   1 file changed, 40 insertions(+), 27 deletions(-)
>> >>>
>> >>> diff --git a/disk/part_efi.c b/disk/part_efi.c
>> >>> index 932d058c184c..c7d79e253958 100644
>> >>> --- a/disk/part_efi.c
>> >>> +++ b/disk/part_efi.c
>> >>> @@ -216,6 +216,34 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>> >>>          return 0;
>> >>>   }
>> >>>
>> >>> +static int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e)
>> >>> +{
>> >>> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
>> >>> +       gpt_entry *gpt_pte = NULL;
>> >>> +
>> >>> +       /* "part" argument must be at least 1 */
>> >>> +       if (part < 1) {
>> >>> +               log_debug("Invalid Argument(s)\n");
>> >>
>> >> I think this should be a log_err an match the comment above
>> >
>> > Screen output during a running EFI application like GRUB should be
>> > avoided as output will no longer match the expected cursor positioning
>> > for the EFI console.
>> >
>> > Please, stick to log_debug().
>> >
>>
>> I agree. This allows to have for example flicker-free boot output. But
>> also, I tried to follow the convention I noticed in this file and AFAICT
>> most messages printouts were using just log_debug().
>
> Ah yes, Heinrich is right, I forgot that this is going to be plugged
> in an EFI protocol
>

Cool, does it mean that I've your r-b tag for this patch too ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

