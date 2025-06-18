Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E14CC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 20:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14A182C2F;
	Wed, 18 Jun 2025 22:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="d03904Ln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6312182C55; Wed, 18 Jun 2025 22:19:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C57B782BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 22:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750277943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxUVcAtVBvC7jqnlnQu6u/cBvpb4pjBJWBpU+Q3zqwU=;
 b=d03904LnBroS7dmAhWKO3Sud7I5EwFhNCIlEUTY+vjaITxpy3A3L0zKwmM/Z5v0a5PUa34
 o+mDEpAIFNYpGGMinH1upGvqwcLk88gaVwbBnhNTQHQnHZkF33kc/HhX9bpdmR780kwaMr
 AhCsvKGuNagmfez4waXPUb5GH2gT+xM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-TkNdTTvAOCWh_YfoJIxm2A-1; Wed, 18 Jun 2025 16:19:01 -0400
X-MC-Unique: TkNdTTvAOCWh_YfoJIxm2A-1
X-Mimecast-MFC-AGG-ID: TkNdTTvAOCWh_YfoJIxm2A_1750277940
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso305355e9.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 13:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750277939; x=1750882739;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxUVcAtVBvC7jqnlnQu6u/cBvpb4pjBJWBpU+Q3zqwU=;
 b=G+din9ATmbcKDhkb1fEnL1eJFhGE/5omlgPpg1FDfQljN3dnrOOLj3VpGSKoE0t96Q
 ermThbWx7K8AxzETie4hdWUN8ErDmyz6RA0UWL0LCShiJeyHUoCvEy99fuLgOkLf1ugd
 1DqV+IF5LOnTGy/WgSz2NNKR0r00RdkQlurjMjhykaC6Uv259XpNKsyGE5gcK6r4AsX2
 2QIXIQKb1kfu4vOHHhsl2mE12gcgiR24PRsPA0rjg1tJhLJiHj2yxDQspRxhZOIrBIYs
 3QccO/IO4yuqlavzssB2TulX8l0mfGTiEsPrEeEYbJZqstOV7vd1DfilpLNlI+VYVuQB
 bI5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEFJ91CAuX6YGFt53C9ODVweM9Uqa7whcIHlA42X4axpULMZKPSgV4031C6sc6zQJj+LjGMls=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9uecRfD53d+TQb61QGalaSpsGS2/mQ6tgoVlo+rBTFbBVmixf
 iR0oh6zNwYrqyUFCupJ3Ir5NXEKAbi+o4rUnpLWJQmJYlFNMCFcmE/bv4+qlq59n8QoOdzH2ZD0
 ttk2O7X6tRUhkOUClNFY3ub/mjURMekJGSvsEM43WK98amWlDMeR6vhY=
X-Gm-Gg: ASbGncsmP/KqHL2ZogQXjUyNG9TObj68xr3LIIH8g8P1Z1m8LB1au4bFTt+Qj/KL8dQ
 2sjpDIb+cAr4oUoebJBVt3P5LHLnzJg0avzsHK42OTXlE5ZmBvO2aG5v2vHPod3hH9rlo5AerYz
 F5qiAcEOpumLQIpFuH4Lpi912TKVBZ/5utYlA1sxz1hjl1xbDK8o0bx6zlfjYsE7r1Pg8LYsGYl
 AmZF0lvpAbIOtr9o94EeZIQLXxtcP3nlB5hIHvt1M7gnJFOmq/IzdcNSW2CzlnBN8yjMnv3J4dx
 L5goV1v36RFkV7LzUl2z5tYZr059DpVV56Ts1lplbFWZ3nfXBaqWQReVJ6umoXvxsgIQDy1xNxo
 JN7Re
X-Received: by 2002:a05:6000:144d:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a5723a3aebmr16437611f8f.16.1750277939661; 
 Wed, 18 Jun 2025 13:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVxPF2TW9W2LJkHSt6naA+eRMTKl8/MW+chh5GXRUYUwGwxXxzmhA15ORSBgBExum+5kWAw==
X-Received: by 2002:a05:6000:144d:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a5723a3aebmr16437592f8f.16.1750277939243; 
 Wed, 18 Jun 2025 13:18:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a7ddefsm17800147f8f.39.2025.06.18.13.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 13:18:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, mripard@redhat.com,
 alexl@redhat.com, mkorpers@redhat.com, eballetb@redhat.com,
 mskrivan@redhat.com, Alexey Romanov <avromanov@salutedevices.com>, Casey
 Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Maks Mishin <maks.mishinfz@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
In-Reply-To: <CAC_iWjJexudN_ZHB0TS5xnFLYeL8_99yWM_kqPgDR==1dB_2xg@mail.gmail.com>
References: <20250618080056.1973311-1-javierm@redhat.com>
 <20250618145016.GF6521@bill-the-cat>
 <875xgt3x2y.fsf@minerva.mail-host-address-is-not-set>
 <CAC_iWjKnLXYUEiJ-B_vxjCaoMpcPazT4HijAsdtA+PCKfCQXKQ@mail.gmail.com>
 <8734bw4yqe.fsf@minerva.mail-host-address-is-not-set>
 <CAC_iWjJexudN_ZHB0TS5xnFLYeL8_99yWM_kqPgDR==1dB_2xg@mail.gmail.com>
Date: Wed, 18 Jun 2025 22:18:57 +0200
Message-ID: <87y0to3iry.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o43HFE97W3cCNeic57QlJme-TasmIu_dvJtRHfHBh8k_1750277940
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

> Hi Javier no worries
>
> On Wed, 18 Jun 2025 at 22:49, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>>
>> Hello Ilias,
>>
>> > Javier I reviewed the patches but I probably missed something.
>> >
>> > I am getting a compilation error with the selftests applied.
>> > #include <part_efi.h> seems to be missing.
>> >
>>
>> Sorry about that. What's the command you are using to build so that I can
>> replicate the issue. I tested with the following build command:
>>
>> make qemu-x86_64_defconfig && make -j8
>
> Yea that's ok. The problem appears only if you test the patches
> against -next. There are big changes in the kbuild system.
> AFAICT it's only that include missing to make -next happy.
>

Thanks for letting me know and also for pointing out that I should base
on -next. Once your pipeline [0] finishes, I'll rebase, fix and re-send.

[0]: https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/26761

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

