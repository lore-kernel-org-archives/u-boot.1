Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EAEFF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 17:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CD98407D;
	Mon, 27 Apr 2026 19:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c7jIWd1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED9284106; Mon, 27 Apr 2026 19:04:28 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 397F683BC4
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 19:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso4322871a34.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777309464; x=1777914264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CKbxPYjXnvkkXDwW4QtsMuD7r/rbm0mRPEx1ZNVZOw=;
 b=c7jIWd1q6DaSqZn4dw1OZObEfEkO0SPxnJ9NUBi/CD5CXwdEGgEYOR47d8dmKz83Gy
 9dvuI0bG+qqYMVOZ0UF4SPYEny/jn9hb1EkKhv8laJCu5OS0lKe6yyhFt2seZJrvH6H6
 831Rekd42xhvbQZ4HwFrIHLZIH8Ome9mcf4e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309464; x=1777914264;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4CKbxPYjXnvkkXDwW4QtsMuD7r/rbm0mRPEx1ZNVZOw=;
 b=O4SOMGhCqMpApLogKr+1MhfNqGtjS2rUc5kmo/FklmH3zPNR0/xMj2apINOHF/S9l3
 NDwtQsSS5DtbRWGt7V9y9QUKwdwmAd1qQ4OEhqz++SYqkUoaNNVFVWqt5IQZQLRvLY7Y
 dtY11txQGzLA5Eeqt0BAWBvE/pT08DDapuB/l6xwiqx3YU+wwm+SJMIHcAcY9X5TuARA
 8yYWNS1HlBvjo73Hs4qpxh1zZ6Q3bgcfs8f+C1C5Ze3QEKbsswGG+EpSI1mc8qkVmDyl
 CS/WRA/tAwpkquzeFMP+i/tbLdk3Ms+V1qEBtsav9frblOUTLaPvcmRv7eixV/pD5aZi
 knvA==
X-Gm-Message-State: AOJu0YxnHGrWqy9Tv0yr8LSDjjiMBbsVnJx/7e4aW5q2Hwn+lBLHe5Ql
 tRF8IQfVnDlveBwxRL9n9LXoNBZDKazuVyaZIev6UaqKze0+3L8f3ZkdGmjm2uQtCj2/+EQG2cJ
 J45AMDU3zH4z5
X-Gm-Gg: AeBDieuiAjaegd8GJBIJAdu0DXV/VVMwAIFZ6ASTdhV2KyRqY52TVowbUr+M/I0NiYD
 0O5IEpatVQsaYLvePkGlIjSyKUPX2FhKoSQ29qP2zAnQ9WrwWAzcDsaJzNkjjr9QW9RM0YV14mf
 zEM5VnKDVVXhF9BoN2WYsWeMhsnd4YQYqHFWcmw8HfMf3/A731j4JyS3d7b1cCH59Hko8DFXtXc
 4UeZvqzoZaWwpHZeC6AVCQYGMnB2YAzpc9X6YW6qmtbtLu5hXbElYd1TsTHSx+9OVv455MWlEji
 tdszmeTcmiOnqmPkMTw6riPK8pfw9lco3GPb/TYelsETvI1TWuVWDuFj4eok8Mq88EoSAfIRfjw
 RdyBPMdLF/PclhoH1xFVhX9hrAd3WXoLdvvqvV0R75OIoByR2OEUtHV5rEj2Ww87kCRr+od++W9
 cZ3Ttbd2qbyYKOt2eKBP6c0ltSLNLvze5alNaLM+0bfARMLLCttVode1orGmc5NfS6RqRGig676
 eLIlQcM00uN2slVcl1ymFpdsA6zcWxBY5NBg9uLFTyIC/pI9p/Iusga6pH23//r/ev64Ps=
X-Received: by 2002:a05:6830:2815:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7dc951d6926mr30606817a34.21.1777309463975; 
 Mon, 27 Apr 2026 10:04:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de84b52f31sm3023313a34.24.2026.04.27.10.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:04:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Harrison Mutai <harrison.mutai@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20250718141621.3147633-1-raymond.mao@linaro.org>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v3 0/6] Add support for DT overlays handoff
Message-Id: <177730946247.3487905.16986307622558058663.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 11:04:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 18 Jul 2025 07:16:13 -0700, Raymond Mao wrote:

> The series include refactoring on bloblist and fdtdec to support handoff
> of multiple DT overlays and applying them into the DT base during setup.
> All changes are aligned to the spec update for supporting DT overlay
> handoff[1].
> 
> Notes for testing:
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] bloblist: add blob type for DT overlay
      commit: 9d89fc4054faa7b5a9422b97b756b2cf63a91ad8
[2/6] bloblist: add helper functions
      commit: ad82e750fd2af6d7f098e78e70cbba1678e84b2f
[3/6] bloblist: fix a potential negative size for memmove
      commit: 63cc797a7e89a2543c9997a271ad8f02b04a6777
[4/6] bloblist: add API for applying blobs with specified tag
      commit: 25baace94298bbe50a91f7b1b7470bf0eb5688fa
[5/6] fdtdec: apply DT overlays from bloblist
      commit: b70cbbfbf94fdb50367a0884a9c44770b4c3bddc
[6/6] configs: Select OF_LIBFDT_OVERLAY to hand over DTO via bloblist
      commit: d3935134c9d597b57cebb954615cf3b80eaf85d7
-- 
Tom


