Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57275C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 16:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C41E882D34;
	Fri, 13 Jun 2025 18:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="do8gzagj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65B482E67; Fri, 13 Jun 2025 18:59:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FFE82CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 18:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749833978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qpzb+LP9vsKsAbSh62Nix5TZ8g8heeaZHYWABUBtwPs=;
 b=do8gzagjW1l4/r7+WvprQbHoOBhRQ7TvBvmBOOH7/aYJzoGzGwbKFAnB//KlPMwc7ysDR8
 u+A57ngueYZazukX1iE4bXVUuPeyllZ8cLl3z/QoU+C+YkYGp+CNGr7oBt9ycN6C++Va1S
 QGGLaTKolvqZaESEAbdaCvyfoBzZNU0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-4oan0XgoNweSTuI2WiFfBg-1; Fri, 13 Jun 2025 12:59:37 -0400
X-MC-Unique: 4oan0XgoNweSTuI2WiFfBg-1
X-Mimecast-MFC-AGG-ID: 4oan0XgoNweSTuI2WiFfBg_1749833976
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso13929365e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749833976; x=1750438776;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpzb+LP9vsKsAbSh62Nix5TZ8g8heeaZHYWABUBtwPs=;
 b=h/LwjmF7Eh/ZGuPmiQ4ZSCcVhHNJQ1wej/5OpWaOzVs1sodH8G+nuAC6lMyLRHWQNj
 e4Zt2/zCdcGjs5HCDu3Q+Qz2m3yWOuXazvoBabpvHTB/jZOjjPbw6YOd8TPWKTCFHIE/
 p4Ups1RBm5RD1pzZZ0FQT9NvPmcDsxK6EVtllN7gJrZMJtlF/rcbiFwMIqKeh11yIUR7
 11MXXuup707vbhH/e/I9JnkVREyxiQNEVysmbvmIee+Tpuwh552s1fAUSrUt5NUwLSdn
 3zc3GhJVa5zbfNYFz+z8I19T4CgmO39DT9rw6wAwidztnqTa99Mb/Z03zNS+EA+wvpQo
 Tc/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpud8mp85MBqhkHK0K2qwBqVIODOna9SMaidf2AvLNcVFwkjxQi4JwqGzgcgX51SyrT/uPETk=@lists.denx.de
X-Gm-Message-State: AOJu0YwCh5ISmV37nlP7TAiAHEtmhFWT8wCxFnQ8I0npam6zyDi9Blga
 Dx+yqECc0uaer2crKlNiZNJgmCoH4IUPq4+tp1z4NmkEHwK7wq3Esbi0xDVEBu3yKORp7BKqGn9
 aLH6COWU/sdNlK/klHSVePcAKgk5rtZSW4ZFWSnYq54TBMg5XhLBOwoo=
X-Gm-Gg: ASbGnct2GCpJ38l4aW+zADjvI4CsMdeE7tXoBS8v3j3X57aNqGluEPNtvPuRHAg4T4q
 cxxC72Ph2vP/+qzBJPJyhCCyk+Ty35E+OcKP4O/lMNK6RQuiSIO/VCW50r8wjmj7hVE2PXxm58I
 dKM+I5O5OS2LnOC4AOfXyDXw9aQQzzoNqfgoRp4d7au1pC610xGV7MaR0fw0VPH4QoxKCIUklvh
 r8ZJd0Z78llkNPjqyr/kVHpI8xMmc+ItsC9ItKHm9Bf3I0iLpjGgVnXDUk6MaaUno2yqGhk5dLu
 vg0x0iyXU8CUcTzHPvl/8HRkF+GUIx4yZC4Z+Qdh42XgJA0rQ88Pjp3lJ2VzI/6TjTqdQFCocFm
 9n6LP
X-Received: by 2002:a05:600c:3ac6:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-4533cb5751bmr2582805e9.33.1749833975867; 
 Fri, 13 Jun 2025 09:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlBg1Fex09muGUmWKxu71lJBNRNltX70/l7LyR5jUJ98sP+6KaYQIpCr+wL0O1I24Z5kcwRA==
X-Received: by 2002:a05:600c:3ac6:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-4533cb5751bmr2582515e9.33.1749833975430; 
 Fri, 13 Jun 2025 09:59:35 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e151c3csm59136965e9.30.2025.06.13.09.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 09:59:34 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
In-Reply-To: <20250613154922.GY1382132@bill-the-cat>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
 <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
 <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
 <20250613154922.GY1382132@bill-the-cat>
Date: Fri, 13 Jun 2025 18:59:33 +0200
Message-ID: <87cyb7vaq2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kPI1MM6O_jihh-bNQU_HOByu-ehLoMUSnwPLqTqcmtY_1749833976
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

Tom Rini <trini@konsulko.com> writes:

Hello Tom,

> On Fri, Jun 13, 2025 at 04:54:48PM +0200, Javier Martinez Canillas wrote:

[...]

>> The project is https://gitlab.com/CentOS/automotive/src/ukiboot and reads
>> UKI (https://uapi-group.org/specifications/specs/unified_kernel_image)
>> images from raw data partitions. Just like ABL reads Android Boot images.
>> 
>> > Are you planning to add it to the EBBR specification?
>> >
>> 
>> I haven't thought about it before but I also didn't know that u-boot had
>> this requirement. Probably it should be documented somewhere to make it
>> more clear? Maybe I didn't look enough but didn't find a doc in the repo.
>
> We are not strictly and only EBBR requirements, if there is good reason

That's good to know. Heinrich's answer seemed to imply that u-boot was
limited to EBBR requirements.

> to add more features (and tests). But Heinrich's follow-up question is

Oh, I missed the lib/efi_selftest directory. I'll see to add a test then.

> quite important. I feel like there's already a half dozen offerings of
> A/B update that works within UEFI.
>

I just brought the A/B boot protocol used by ukiboot because I was asked
how I was using the EFI_PARTITION_INFO_PROTOCOL. But I'm not proposing to
add a new A/B update mechanism for u-boot, just to implement an existing
EFI protocol...

> -- 
> Tom

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

