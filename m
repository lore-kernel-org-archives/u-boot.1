Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771B6C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 15:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8701F87E7C;
	Fri,  9 Feb 2024 16:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GQLRjKW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB7087E74; Fri,  9 Feb 2024 16:51:37 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7538C87E70
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 16:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6557D40576
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707493892;
 bh=UqcpRVbHdtjuydh9vHSDm5T3ZvNzpWa7FnY/F//Gl/Y=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GQLRjKW+xeOIt1aw1FdFArc5ImwvJXHd+USiJ8laM+T63sw3evbGsdZQHiex6X9Go
 sWLCcy36DPTF56bKr/b8Dop3ns+dLBlC3AwzPwC/vXkx0NPy8uYUfuFw6EC0Y1O3wt
 2H1CKXDIu3p/4JXBXJy06GGdMJwVs1V2vcEV1ukuzbuGSHuUXwacFo0sLFrQlp6p36
 CWMPCD7wrVsmh5ErwfecQJVl0uhoaKYMaxQ4zv2Ghf6wTOrPsL+FijskMKm9kqhGBT
 VE0OK2QSvlkPYhzJvOxY60FiyQOnFEbJGJ/o3EAv2txxspGMv4ELhrz6EIOH9/fNXD
 OWm30wXgSPpqw==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2b047e8f9fso77568366b.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 07:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707493890; x=1708098690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqcpRVbHdtjuydh9vHSDm5T3ZvNzpWa7FnY/F//Gl/Y=;
 b=oycXev2ezhiBbq8uvD4ulZy22Qw+D2J7y6Rj3PFOihJx6UuuAKWV+nv9h2Jpt5qGox
 udyD3HiQMbETF5/3bafiemJ69neHmDe6whkewKX7iRKZC9FC9hb/DLoRcTAhT1QKrtua
 sXfWOAA5bhosq7FoQeWrAX36M/BNeVfXxPPVF1MXYxT1G48MxvfJN6vN4iiGNfSbP7Vh
 Be12cQ6UHj8kY9cX88IcvACBQl9m4brc8MMBiC7m3Hi/n3+IzxZ4vF5ENFNSw2eGG2nb
 hlK0BA1gHDfBEvvn2wBNwU54+tSzfub/Jaa5Wjk8ILDtpXnrWpaQzImk5OFv4/rU+BWX
 xW+g==
X-Gm-Message-State: AOJu0YynM16ijZkEKgxfvcJD5bnIblsQF4+Tu6mFcDoGlzbnH5laPZIR
 JkGhQv+/wp0ovNU94oTn5QJ0DeAN4M19eI5vIYI79VHBh0sVxR0kMD5fU55bdPPyK5snW65FcI+
 yQRlluNOKqkvFInB6tFy//NKma5a/KsYn4qNAt80ocSrpK9qWH5TWHsyWnlKZakNxNFo=
X-Received: by 2002:a17:906:e213:b0:a3c:d6f:4788 with SMTP id
 gf19-20020a170906e21300b00a3c0d6f4788mr407534ejb.48.1707493890705; 
 Fri, 09 Feb 2024 07:51:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsve+DA3sQAZsArX57eiby9wbHAGuigzG1xUv6epyRlKRaX8aLf3duYqWp8GuGxvEnecdmmQ==
X-Received: by 2002:a17:906:e213:b0:a3c:d6f:4788 with SMTP id
 gf19-20020a170906e21300b00a3c0d6f4788mr407519ejb.48.1707493890382; 
 Fri, 09 Feb 2024 07:51:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVVQbfU87lnqNKYcPMzZ+ihs3/nlGXveZr1hYQE2V8iCVzA2nhzD3sQhc+bGLXd01OtOrqWyPlprFkuExMm4YxNH1Vv8Rh/Bt3AARjFXgcwgcF2E+ftIpIERbE2YSNl1SUGCVHWqEOr+gxISxx9WD57cCj9urh5lK9mAvHeSGvupcjgTHLasHpfqrx1xAie4jZ3wFqHFvLwbvIMBLkf
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a17090655ca00b00a38620c3b3dsm866944ejp.198.2024.02.09.07.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 07:51:29 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] smbios: fill wake-up type
Date: Fri,  9 Feb 2024 16:51:13 +0100
Message-ID: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We should not use the reserved value 0x00 for the wake up type but
use 0x06 (Power Switch).

Correctly display wake-up type in smbios command.

Display SMBIOS type 1 field family in smbios command.

v2:
	use wake-up type 0x02 as our default

Heinrich Schuchardt (2):
  cmd: smbios: type 1 wake-up time, family
  smbios: fill wake-up type

 cmd/smbios.c     | 25 +++++++++++++++++++++++--
 include/smbios.h | 10 ++++++++++
 lib/smbios.c     |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.43.0

