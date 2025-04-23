Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C3CC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C990581E72;
	Wed, 23 Apr 2025 16:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hzvvudjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCFD80FA8; Wed, 23 Apr 2025 14:43:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF1180F6B
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745412203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dosAOhWBMypddcP/z7aLnBtp3ef396CgWxNfD/wPoVs=;
 b=hzvvudjNH8VmlQpyFMP2p4KtjyWc2aeE3fmStxMTubtRDY1+lwRigsmj/j5nWinqZiAlWm
 Lz5wjZJ5PS5gPhZt/OKg2zvCnDGJKfkEN44TbpZn74/IyuQ787VsqGyxm1GBSE7egmFFf6
 +J8NfmvmI0ub0AqVvqBZAVf5Q48STc0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-CDsrMy-OPai0tnoieWwlQA-1; Wed, 23 Apr 2025 08:43:22 -0400
X-MC-Unique: CDsrMy-OPai0tnoieWwlQA-1
X-Mimecast-MFC-AGG-ID: CDsrMy-OPai0tnoieWwlQA_1745412201
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ef89b862dso2935620f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745412201; x=1746017001;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dosAOhWBMypddcP/z7aLnBtp3ef396CgWxNfD/wPoVs=;
 b=H9Ad1rPxNKkq3LlRHtWsWSc4AO0pjZnuYjZ/pRoq21LKEP60iWm6gpAdapcs0gsEem
 n7M7oZfq1TaIB3t52hEhZGjJWqSvMcf+ngYw66Tz5qczRwlguIEuLitIAJj1PT0hkxnU
 TRDIulACL8yQ50heuHkX1/x235FAF8IUpXZIYVxaqFBppuCEuBPtmnrTbVyZaSsdi3RD
 MMuwc0FlxfoB2v857WDpJ/87rfpcELXdWipoLUgnRRZA3ZczIhsYfD3R8/2o8RVSStsj
 ofjQC1axsAW0pUPzzxy4Z3cmGA/vZrUV+BR0aVHZkQLFrqkM1G7je4n/YmvhWGwCbvOb
 gupA==
X-Gm-Message-State: AOJu0YzbdfuCoWkzEvl36CqNOejZi5+KWfz7Gz79QFX3tuywOYYf1V/x
 pK7KvFNKciAd7zliRSi4MFicmuRyD9epQuBlxJpJAkt3OVegJwCAAylzgkFikmOF1SRfS2bbVA6
 H6kMvubRJAHtfsqzh2ADU7LYmolTrUYhZswrvrzMzZMHS/IZMis8=
X-Gm-Gg: ASbGnctK7AQV9j8aeiKjT7llfLVQiCOL3scRdXOwkkGjuyN8gCRA/eJT9gnzDgxAtr5
 BF6SezFHShMgiPVyGYov9fTDoWX+e2rGQKVxU46IWvRUEuFHcxRQ3ZuPZDOatTLL6yYSfvl+431
 TujWhBLscC4pPENCWa9vGVosHvTCkDbadi7iPbmnG9gCAjxjYfnwEyfOwA+WBxZk9zb337w9mdi
 5Qjv+3z1Jsc2USQpqKNZYV8QZCUTNxM8GijZmPbWNZosz7X/lqtfI4zImX4odI3E3F1jVi6sOtP
 BiKCjXHjdgtCt7tQ4WY=
X-Received: by 2002:a05:6000:2510:b0:390:f9a5:bd79 with SMTP id
 ffacd0b85a97d-39efba5a86fmr15668774f8f.26.1745412201360; 
 Wed, 23 Apr 2025 05:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv76QE9KGqicED+wfxs8YoHwCQLFQp9y4BmpIJI8e3lzJWocfhbqtHactULkjwX7q19XvXtw==
X-Received: by 2002:a05:6000:2510:b0:390:f9a5:bd79 with SMTP id
 ffacd0b85a97d-39efba5a86fmr15668752f8f.26.1745412200982; 
 Wed, 23 Apr 2025 05:43:20 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa493207sm18765214f8f.79.2025.04.23.05.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 05:43:20 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@redhat.com>
To: Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Maintenance of Python tools
In-Reply-To: <CAFLszTiThPOHm+D=Zts9QP0mm4dYHE=kAqS1LAnfF1MLmc=QEg@mail.gmail.com>
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
 <87a587fja8.fsf@kernel.org>
 <CAFLszTiThPOHm+D=Zts9QP0mm4dYHE=kAqS1LAnfF1MLmc=QEg@mail.gmail.com>
Date: Wed, 23 Apr 2025 14:43:20 +0200
Message-ID: <874iyff3pz.fsf@kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pkg9qmG2gy7okBLkSBJHSTi3-FJiOZuk-R1wGqk9B1I_1745412201
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
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

Hi Simon,

On mer., avril 23, 2025 at 06:28, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Wed, 23 Apr 2025 at 01:07, Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Simon,
>>
>> On mar., avril 22, 2025 at 17:39, Simon Glass <sjg@chromium.org> wrote:
>>
>> > Hi,
>> >
>> > Tom has indicated that he would like Patman to move out of his tree. I
>> > suggested on another thread[1] that I maintain it in my 'sjg' tree, so
>> > here is a new thread to discuss this.
>> >
>> > I have already done this for the qemu/efi/coreboot scripts as Tom has
>> > NAK'ed patches for those.
>> >
>> > For the other tools there is going to be quite a bit of churn, as I
>> > would like to resolve most of the many Python warnings.
>> >
>> > Given the shared source between the tools, it would be easier for me
>> > to do the same for buildman, binman and qconfig. I am thinking that I
>> > might try a move to allow Gitlab pull-requests for reviews on these as
>> > well as the mailing list, if that is useful.
>> >
>> > For tools which need to sync back to Tom's tree (i.e. not patman), I
>> > or Tom could do a pull request every now and then, omitting any
>> > changes that relate to pylint.
>> >
>> > Please let me know your thoughts. The timing is good as I am going to
>> > be sending out a new Patman feature in the next few weeks and it is a
>> > few thousand more lines of code.
>>
>> I have a preference for binman staying in the U-Boot upstream (Tom's)
>> tree. AFAIK, binman is used by the CI and is also very useful for composing
>> "complex" bootloader images (For example for the TI k3 architecture).
>> I don't know a good replacement of binman and I'm afraid that people
>> will go back to ad-hoc scripts if binman gets removed from the tree :(
>>
>> On the other hand, patman is a workflow tool that's not (I think) that
>> specific to U-Boot and is (to me) replaceable by b4.
>>
>> I understand that code sharing makes it more difficult to only move
>> buildman out of upstream, but in a perfect world, I'd like binman to
>> stay in upstream.
>
> Just to clarify this, I'm not suggesting removing binman. It's just
> the maintenance and development of new features that I'm referring to.
> We would still sync source back to Tom's tree.

Got it, thanks.

Wouldn't moving the binman development out of upstream reduce
contributions/visibility?
Or do you think that proposing alternative development process (like
Gitlab merge requests) would attract more folks?

What would be the policy for development/syncing back to upstream?

What happens if binman evolves in a way that's not aligned/practical for
upstream (Tom's tree) ?

Would that mean that we would have to maintain a fork in upstream?

>
> Regards,
> SImon
>
>> > [1] https://lore.kernel.org/u-boot/CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com/

