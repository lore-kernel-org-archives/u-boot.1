Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AD5C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 03:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AE18642A;
	Fri,  8 Dec 2023 04:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vp6iPtaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213CC8642D; Fri,  8 Dec 2023 04:14:16 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF79086335
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 04:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a1db6816177so217532766b.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 19:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702005251; x=1702610051; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B/JovaJUpmi7D2p6sp1ObRYNupRUexxZP1LEJALBCEk=;
 b=Vp6iPtaWl9NvEL9WqE4nRKIV6dh/7vXe4giVynurEfdARpPr3uwGQgixhJxzUtrBev
 qalT/SkCu2yLVoJKfpl/0NBMeheQVj8tJHDqemGN6yPZql/oEypOp7i/ssM+GjTE71FI
 g8wg/PAPGZ6oEc3138XRaDOM2hDSMzpcZm3jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702005251; x=1702610051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/JovaJUpmi7D2p6sp1ObRYNupRUexxZP1LEJALBCEk=;
 b=EoIicygwzxHWkn2Lpt8L0MM6AxRlUt9dawyOdf0/XrfBN1O+g0iO+JdE+IoaMdY0Bj
 vqd0eMWVpBMKmNCQtwGmtTYC02lGzzG77sgZqTA3bUxEdwk6mfTOK1VuMcVElnqMyLaM
 qyzKqwOI4jqj7dP6y+C8doGWrhWmJTdljjI21sTPU6v9VX/O79/1luWVRENaVToZcV8B
 3KWSDJdL1jGAazFrGeJGGVn6c2KNxGy9P7CHHjaOmHmgBJIre1gri0EWYx8dDIinNMsD
 vkqF4Rw3ZKcLm/r1S4r0HFospdg3FopQeS4ksm6GUS6KUrASLXQYESIx+p78rZs+zeZ7
 kNIA==
X-Gm-Message-State: AOJu0YzBo2TOsXfEgJiPEz/O4XG2d6+q6t/pP0PuusPeHM7Oj3ABTkPj
 em4MPfELGVLfvC8pPwD8OpmuHu1OIf5p+ruqUMTLVg==
X-Google-Smtp-Source: AGHT+IGNFR5F53bVew4v9mvWKkzZOrJRLEPUGtd5OJby6DX8BFDvEPY2ftUdsnFX7qTrjwBPtsUVvA2P1DdrONOb74I=
X-Received: by 2002:a17:906:5fd0:b0:a19:a19b:426e with SMTP id
 k16-20020a1709065fd000b00a19a19b426emr1121356ejv.217.1702005250995; Thu, 07
 Dec 2023 19:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-3-raymond.mao@linaro.org>
 <CAPnjgZ3_LJRBhTQHEuu_Ow+6GB4r8ZtdgEBtxxHtYG1m8LmJBg@mail.gmail.com>
 <CAEfUkULSsZuY-Yszg-O6H8PfQYWhMa2wJHgKO0N0ZtKnjQJ5fw@mail.gmail.com>
In-Reply-To: <CAEfUkULSsZuY-Yszg-O6H8PfQYWhMa2wJHgKO0N0ZtKnjQJ5fw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Dec 2023 20:13:54 -0700
Message-ID: <CAPnjgZ23J5tW3Tr5ouhxu3yvo4uMZwHkhQLpBKwxTHoBrbagSg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] bloblist: Adjust API to align in powers of 2
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Raymond,

On Wed, 6 Dec 2023 at 13:08, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> I am wondering if I shall put in your review tag as you are one of the authors of many patches...
> What is the best approach under this situation in the U-Boot community?

Well, where it is modified by you, I think it is reasonable to add my review.

Regards,
Simon


>
> Thanks and regards,
> Raymond
>
> On Sat, 2 Dec 2023 at 13:33, Simon Glass <sjg@chromium.org> wrote:
>>
>> On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > From: Simon Glass <sjg@chromium.org>
>> >
>> > The updated bloblist structure stores the alignment as a power-of-two
>> > value in its structures. Adjust the API to use this, to avoid needing to
>> > calling ilog2().
>> >
>> > Drop a stale comment while we are here.
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium.org>
>> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Update the bloblist alignment to align to FW handoff spec v0.9.
>> >
>> >  arch/x86/lib/tables.c |  3 ++-
>> >  common/bloblist.c     | 24 +++++++++++-------------
>> >  include/bloblist.h    | 12 +++++++-----
>> >  test/bloblist.c       |  4 ++--
>> >  4 files changed, 22 insertions(+), 21 deletions(-)
>> >
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
