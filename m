Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4706BC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 15:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C8882E20;
	Wed, 18 Jun 2025 17:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="H0TXi8oS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985DB82E25; Wed, 18 Jun 2025 17:10:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A24C82E17
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 17:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750259420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4PgzOtt/oW8d/0Q9gpCug9TuQSx+gHl9TJ/nT0bCgM=;
 b=H0TXi8oS9k5TAgAmKKel45wlm43ed/0/MM3rRd2yj48GFYg5dGejPvD1SxspJmQhoxYA5e
 Gxwykw9kdJYkhumCbDb10rt6USoaZZoSM75lhy1u4iLTlHU1LXogC9drsM09GN143RoedS
 kS7sSNoL02HO4ZLDTKYCEI/HYMfq/8g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-9vTNp7v2PAiMuJ3l3od7uQ-1; Wed, 18 Jun 2025 11:10:05 -0400
X-MC-Unique: 9vTNp7v2PAiMuJ3l3od7uQ-1
X-Mimecast-MFC-AGG-ID: 9vTNp7v2PAiMuJ3l3od7uQ_1750259400
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso885855f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750259400; x=1750864200;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4PgzOtt/oW8d/0Q9gpCug9TuQSx+gHl9TJ/nT0bCgM=;
 b=KnhotNHecB1IVB754UX9x+d60xqQ3XdeaU1BuSSYfJiVHpasVBb084GzatWiWCgx/Y
 Vl5KKcaxjmP6JOEt06q5AKDvgklbJ8OrcMJ8R4v+G4vv8GargoTVEWXbk3ew713YT6Aj
 GLmzdvWkrKK+Z+ePQsZFEu2EFFd5Ll71/cnGdoPjizPQVrLZVj14jK/oIC64FXdDp38v
 MZ9qBodZ9flNzVDz0QJwJMbX2tgIRdNEHpVIri5icDPJR3yZ3BM/SPbfblpSqq2vx2O5
 G52m63gSnBfN8PJIzviaW+BY6929tViphDYqLqOQDtvkw+z9mzpCczEOnPdn5oKX74aU
 TFAA==
X-Gm-Message-State: AOJu0YwZed8bakGUua1ySZfE9H4SwxROGLLFMGpbZL9PrLYFAf5/8IDu
 FVd00juCU2ilexUE6nAh1jQ5QV+bc/8nMzrlY9M8ZkXZ4ZOWS4JihwiZstOZ0i41ZQmUyE/FnKr
 RU1/IKn9eMarxuHmPUZnGuQJTSBUP4spwEUe6uTiYgcnYQYCAa/vFYBM=
X-Gm-Gg: ASbGnctdceLhvUx0ofAvgw8IYVsYyhf45dMbctp0+OoDJ/EVrqk/UvmfGeK8Gtih1Xc
 L5/9l0v4qkYje8wWt07fcp3oc5Z6oCYtGsKeG2bc/TIP8E6OjMojf49GCdsfAZUsFiHITky9W9C
 VVsHaUqVRxoXtnVeG2L0pjxQvtMWtat4suSd3JIOS9zySGSbjRiwaDhQVpRsao18FzyUrm6skr4
 0l05Vv1YMqgvnn2ObdGxKNt652H70MfGYOwDPEIWgFZQzkLJtmt2RrYJhyjXQt3RYev5ad6AEQ0
 So7i3al+m6KWaX7bISAsH0w/YGi2Hs5xBEdG+IWlnfZeXOR6PFtlPMBjYEjYA3wLuhiXoXc9aAq
 EewjW
X-Received: by 2002:a5d:64ce:0:b0:3a3:6b07:20a1 with SMTP id
 ffacd0b85a97d-3a572e8c1dfmr13144007f8f.40.1750259400148; 
 Wed, 18 Jun 2025 08:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN42cnY6EiE/9t58AueDMVhrHZjWzos9sG1hW1Pdma1N6+Sv/HP13kyTDiHWe/F89V5wjXeg==
X-Received: by 2002:a5d:64ce:0:b0:3a3:6b07:20a1 with SMTP id
 ffacd0b85a97d-3a572e8c1dfmr13143952f8f.40.1750259399676; 
 Wed, 18 Jun 2025 08:09:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a6078csm16885755f8f.21.2025.06.18.08.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 08:09:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 mripard@redhat.com, alexl@redhat.com, mkorpers@redhat.com,
 eballetb@redhat.com, mskrivan@redhat.com, Alexey Romanov
 <avromanov@salutedevices.com>, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Maks Mishin
 <maks.mishinfz@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 0/4] efi_loader: add EFI_PARTITION_INFO_PROTOCOL support
In-Reply-To: <20250618145016.GF6521@bill-the-cat>
References: <20250618080056.1973311-1-javierm@redhat.com>
 <20250618145016.GF6521@bill-the-cat>
Date: Wed, 18 Jun 2025 17:09:57 +0200
Message-ID: <875xgt3x2y.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H6UfiNEo81D98L5p_FtOjBkwLM1eFAAz-q1tEmJhsuc_1750259400
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

> On Wed, Jun 18, 2025 at 10:00:34AM +0200, Javier Martinez Canillas wrote:

[...]

>>     05: efi_selftest: Add basic partition info check to block io test
>>        aarch64: (for 1/1 boards) all +563.0 rodata +179.0 text +384.0
>>                 qemu_arm64_lwip: all +563 rodata +179 text +384
>>                    u-boot: add: 1/0, grow: 1/0 bytes: 384/0 (384)
>>                      function                                   old     new   delta
>>                      execute                                  36428   36796    +368
>>                      partition_info_guid                          -      16     +16
>>     (no errors to report)
>
> Thanks for digging at the size part here. I don't think that amount of
> growth justifies a new Kconfig option.
>

On the contrary, thanks for pointing me to your script. It's really awesome.

> -- 
> Tom

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

