Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A69CC71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 08:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8640282C30;
	Fri, 13 Jun 2025 10:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bpmozMT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB84782C79; Fri, 13 Jun 2025 10:58:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A55682C2F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749805108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V3DKvqhZCnVRYTnWyNFd8kjFW3XvxPeMLYMRzmkqxHs=;
 b=bpmozMT39Tp4dMDOV7BHTzW1dVFMlWYZbDYE2hZy88j/uHucg8wiFn916/Y9NE8YD22ndb
 U2M5GnPmtFp64IZVAYPnJ7sZGcY0Cpz2umT2nlPBc2YcqoB4+Bjz3AI697sApAlDC7nODl
 xQ5Vnoz5muR2vDevBCobIx9LJipoHvY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-QpG40XRlNLGGKiK2jk29qg-1; Fri, 13 Jun 2025 04:58:25 -0400
X-MC-Unique: QpG40XRlNLGGKiK2jk29qg-1
X-Mimecast-MFC-AGG-ID: QpG40XRlNLGGKiK2jk29qg_1749805104
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4530623eb8fso14602135e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 01:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749805104; x=1750409904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3DKvqhZCnVRYTnWyNFd8kjFW3XvxPeMLYMRzmkqxHs=;
 b=le/WGjqAxOSf+QrsBu7VpO6rjnmcvDD5XkW9ttHY1M2bdfjnmLX9o8DhiKjRFBsa/p
 IUBjfx61K0Tor9iPaL0qPWLlYrMwwivS6UyGu39GtqQhp7fX0SKKXG733BwPI6HuRePt
 5yl2atWvfEccC/QVgh7UWB2PzyPpdTi1ZsyvLXqb5panDesNAjIYdCL4CHhfuY0nqvNE
 Y3weJG1Z3HEhSAkKttIDjh4zTnpKSUdvGrzqQ1/sdgorb3nFPa4CLV+4qxWUJIp3ceHd
 nzKG9EhchxjO2NmC+VVchcOTGoZZ7M78+qB8q8Uc8wr6+ggSHJj8mL+iVjjrLMC9aAR1
 tXmg==
X-Gm-Message-State: AOJu0YwRg6IZoOxisLtrj/2mIgKd3n4RCvfGqo0DgEQ4Bo/3T3udYdgR
 j8R93MxuxT46cTWDtIwMGS+CpOR8JnjLOO0y4gZANECZ/P1tBDGFEQjLWsW4muNvvdXakSbg7zh
 ThjkloSXDjnjM+4NjI6WLirQrS1F/SAg/D+nO7W3ukVERWjfDbUs4dX8fECwvGOg+JYyYVGRIrg
 Mt66JpbSkXu+zLzizNMWO5fnquoUR5Lwq8bUeG+Q==
X-Gm-Gg: ASbGncuWNCmFjtzYy2/NAghS0/FBBhvmcTvMDd6nNBkY+YYDvuDU2gFBzLMffGCd/zW
 y9rhLxth5fGAs0nGF0bOvW7JASysIAuL7N9SsesfZSTKOFeXN6RWNM6fo90+FGckGg5Ocsgu1ha
 70WIE0nJDrHuITy5e9ITKrKTQVmDtbQeFbHtrw+zCjg3C/k6/WPw71u7t5KblqOgfyzBwWlxdoF
 iFn6pgUpLmAHT7iojst7O9dCvI5V7RJO99TcR8z/FSBnV2gjJgfbnu/YYqQu1lwKG3MY0K0thZa
 89yUn3B9usepbDm5Tn/KdJ07p62pttjy+ek5zYSSMQPOf7g=
X-Received: by 2002:a05:600c:4e43:b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-45334b73217mr17619625e9.26.1749805103828; 
 Fri, 13 Jun 2025 01:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa9itNHeSiW/vTGnNyKU9MhzbdaEjudtkRamE057ubw1AOjCTBcl70knnbW8TOB3l8mfhTsQ==
X-Received: by 2002:a05:600c:4e43:b0:442:e9eb:cb9e with SMTP id
 5b1f17b1804b1-45334b73217mr17619255e9.26.1749805103441; 
 Fri, 13 Jun 2025 01:58:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532dea15b0sm45921095e9.11.2025.06.13.01.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 01:58:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
Date: Fri, 13 Jun 2025 10:57:35 +0200
Message-ID: <20250613085742.796015-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X3aGjt87nUpwXskKwbGjf-4ErKYJjBtbtfuPqKlyfJ4_1749805104
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This patch series implements support for the EFI_PARTITION_INFO_PROTOCOL,
to provide cached partition information for GPT partition types.

The EFI specification mentions that the protocol can understand legacy MBR
partition types, but that's for backward compatibility and not implemented
by this series. It can be added as a follow-up if needed, to make it fully
compliant with the spec.

Patch #1 moves the logic to get a GPT partition table entry to a helper
part_get_gpt_pte() function.

Patch #2 exposes that helper function to be used by the efi_loader.

Patch #3 implements the actual protocol support using the mentioned helper
to get the GPT partitions table entries.


Javier Martinez Canillas (3):
  disk: efi: Move logic to get a GPT entry into a helper function
  disk: efi: expose the part_get_gpt_pte() helper function
  efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support

 disk/part_efi.c           | 67 +++++++++++++++++++++++----------------
 include/part.h            | 14 ++++++++
 include/part_efi.h        | 20 ++++++++++++
 lib/efi_loader/efi_disk.c | 38 ++++++++++++++++++++--
 4 files changed, 110 insertions(+), 29 deletions(-)

-- 
2.49.0

base-commit: 2ab10ed2399b0c1c790733884935c94ad65aa2a8
branch: add-efi-part-info-proto

