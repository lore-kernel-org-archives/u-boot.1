Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDD6C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172D581F44;
	Mon, 31 Mar 2025 15:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HIWJklPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D2C8203B; Mon, 31 Mar 2025 15:46:26 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0A881EC0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c16e658f4so1230300a34.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428782; x=1744033582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUxiQkQcGJB5O03pBDWH2HLrBi2/H8Tk7dDkD1bDzA8=;
 b=HIWJklPdnneQN6ePHnAznxzT1ghHzZQENEDgs5Ee7piBbntldvAubaGYl63qDnMquy
 3w5WEiWKQbQqdpJfrphvwQWDyqUQQHVbdIAP4LtfyCXYbdDP9ymTRi49kM1gIRXaT1wM
 5KpiXJFSd4Jjse6sKlSSLWID6s2gl/he1h8m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428782; x=1744033582;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUxiQkQcGJB5O03pBDWH2HLrBi2/H8Tk7dDkD1bDzA8=;
 b=FzOupwp9MfhjbT36O49pWeHbfLfAP8F+vLTTvMWU/70WB2L1CvnVKWC3S4Trrlbx46
 xkh/pgY5sMmPYZLBNqRoLOU3QN/0VCrQdtMJ1Mn1RgCgSbRnlKyeoRRdwzGsGhLX0S17
 Q1P9fMWwbmGtm32kS1g5vxLw0Est41edtl7wxkv/3UpMSuXkJ5BY75G1scBvCGl6j79t
 4DtowN0LNmABze74yegdk5HgEoNRMTrC8qf+8ZmJzt72QiORr4+ElR5VMuZKxh44YXLq
 rOi5hnARwzvTd5762erSp/B4lgxIsgTkSNa9AkpN5kkb2LJfvul00yMxoe40YBg9aCos
 Uy3A==
X-Gm-Message-State: AOJu0YxquPFTGmWRsiZopmX4dOmZMUc3GLFfYXcgJV8kZF66m8IZxTHC
 1HNIZ+YoIQuU4wiORMpPaXXZGMbGSOzxa6VMiAMTbHExaa7m59IDwSjh7PHL561+8Ie+5MTX5Tk
 X
X-Gm-Gg: ASbGncu4N7KOvU9gkR5SHJH88JZQ0X3xC9fOtCDbOci1VhHyAwH1isTqDy/JDTU+Mmp
 GJ3Vj4w/DkwqfBnTapaOQ9vLJ60zL1I9ywNN1bgldB6cOda8B+CiSb6I5Gu1SFAAHK3dp6gnKH/
 IzjCeYAw1kGGWIATodXGtqB2K3NuN56RQnawb6KBoZArrP1TS4HY3vKiNnGTbvk3H1VsYA0wtg4
 T1Pg/QpAEiKD60ICTUb2qbspJURC3bXGhF1jTatKJnWn1IJL4HbbGAv41/b/RHWS30camrQPpAM
 uxB9Xkwb8h5svPZVEoRb5hG+dA5EWh4VN06TFqrCJxOoU7V12mgHam3H3OMH/t7fZ5YtBC7zAMP
 X4Xdx
X-Google-Smtp-Source: AGHT+IF+0um7lvGuNHYSWel1YmIFKmubWfVdiPJRp/ru/KE4CbS8DBNlNtlgOcaPdm1zH8xx1yi6KQ==
X-Received: by 2002:a05:6830:6b04:b0:727:876:c849 with SMTP id
 46e09a7af769-72c6383bc82mr6387523a34.27.1743428782206; 
 Mon, 31 Mar 2025 06:46:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20250311044414.3155688-1-anshuld@ti.com>
References: <20250311044414.3155688-1-anshuld@ti.com>
Subject: Re: [PATCH v2] config: falcon: move CFG_SYS_SPI_* to Kconfig
Message-Id: <174342878082.1318045.5260857573020502945.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 11 Mar 2025 10:14:12 +0530, Anshul Dalal wrote:

> CFG_SYS_SPI_* are used in falcon boot to specify the offsets and size of
> the respective payloads. This patch moves them to Kconfig keeping the
> values consistent for each of the affected boards.
> 
> 

Applied to u-boot/next, thanks!

[1/1] config: falcon: move CFG_SYS_SPI_* to Kconfig
      commit: bcb8cac2d550b6decfbcb2985be276afbec296cf
-- 
Tom


