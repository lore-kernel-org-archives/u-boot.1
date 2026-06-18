Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F08CD98E4
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 01:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9005E8495C;
	Thu, 18 Jun 2026 03:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dwLL0SnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2563F846B0; Thu, 18 Jun 2026 03:08:25 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0492584874
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e71198e0adso140292a34.2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 18:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781744902; x=1782349702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3szZWhUUe8Nxe5T8tQo4ECvdS2hWtVriKrbK6L6nvMs=;
 b=dwLL0SnFgfCgEu7yPW9Wq8sWZJT8x+2HBi660C8oI+x5dErH8o4B6uqz6KpHT5knpP
 NOnUC3tqmTqWwcSc1IIpWS1K8Ao/3TsHrMfKxLGjofkODe204A1kq+h9KuXNngmrthxa
 msTKNtFXugOsoUbNHlFuTNMy7drScKT2psNxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781744902; x=1782349702;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3szZWhUUe8Nxe5T8tQo4ECvdS2hWtVriKrbK6L6nvMs=;
 b=oazB+kNY28hDCfjrdzgD4yHtr5U72KjsTAL89kl5cyDUo6mFSObVQ1cfpdzcSDIU07
 mGFt7SeMBkYJKNOCTJRJJ7/K4CEoDw+jQY30qfdpjrlz/4aFQABaCRouOoW0icCH/0uq
 JEV0RJ8mWru6GnP8te8zZmpfnJCqizMjMBFTIDpPRjB0dfv8g/LXCCNqaeFzDIPp32ea
 kykfxcw1d5da0rpqMWd8CH0ODgXN/eBdDEV7wbPJvluXoTuSKr4+ZiM8ssbJXopn0AUf
 vHnzVr2geCSeIs0yj4YceoGy8PgbnPjPN1Ru06W8Nn1DijmroeJZZEHrbD2f840KbxHZ
 Q+gQ==
X-Gm-Message-State: AOJu0Yzs5qzGrJrfZLkwAON0jMI0K4dt/zXn6AV9AFg7vBu25SUDGSwx
 xRfyj7qPqoFo34M5LDANEAwOnBSXKH4H7UvccORJ9uluqpieqJ/O3tEQKlFmBswgM0R2IBq3n9p
 LDbtJcBk=
X-Gm-Gg: Acq92OHIWCjPsI3CWCDyU9OiyHaNGmByydDlIz3f0r9iZYFNzmPlzpLLreAeIMpCz0L
 iQphlqPP7Q8FTGxQrTlQLQs79wqL9vwyNX5RM9ikAJdODGOZGSDc3GBWMNsx/meSP98i1r0KrSs
 J+h5VAoaP4+1MlnMlPj3MCHfLt/MG6jXP0//fZR7JWkIdqBNRKfHnlQ5DBRkkj+ucC6vwCZf1wp
 vZhkM/eINA5xXXPEoT8rdpqbV3q8X0l+bVMdN2pZZmTxTPFWENpMGBYJQgo0NStnVqvv+tnhBiR
 Jo7eMYJ5PG7Tc53jYard32vUjPjEEuGZd4222LXcTpFck6fpY658AsKFSM9b+XuqeLCnPIA9vDS
 1BAAJl1q8HNP2+WC99UQACI9pQPEq7rarnw536Nthu5K4szTdEdrJL9O7xwPyR8bGNEnixz7m5j
 +AGNEa1h2+v0P2DujtNzsXtt2NqYwVHFVVfzv1npXCjmQc5/P93mH1O1Gjoopse/QN9UPNLYWA9
 QT5TT3X7YMhCsIw5aNXbpfA/N3R1ApLo/era+k=
X-Received: by 2002:a05:6830:2405:b0:7e6:c9eb:535a with SMTP id
 46e09a7af769-7e90c65fd58mr4637745a34.6.1781744901653; 
 Wed, 17 Jun 2026 18:08:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6f9f48sm10464553a34.25.2026.06.17.18.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 18:08:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francesco Valla <francesco@valla.it>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
References: <20260604-spl_fit_full_cleanup-v1-0-ec036b5872e2@valla.it>
Subject: Re: [PATCH 0/6] Fixes, cleanup and a test for the SPL FIT "full"
 loader
Message-Id: <178174490013.2512035.15332419793966760116.b4-ty@konsulko.com>
Date: Wed, 17 Jun 2026 19:08:20 -0600
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

On Thu, 04 Jun 2026 22:41:34 +0200, Francesco Valla wrote:

> this patch set contains a collection of small fixes and cleanups for the
> "full" FIT loader that can be used for the SPL. The main beneficiary is
> the falcon boot flow, but the same loader can be used also for U-Boot
> proper.
> 
> Patch 1 was part of another set [1], but I decided to put it here for a
> better separation between plumbing (here) and new features (there).
> I kept the Reviewed-by tag collected from Simon in that occasion.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] boot: fit: fix FIT verification in SPL
      commit: e50ee1acd4a519cb0320d7227581b7a7841e8a47
[2/6] spl: fit: fix loadables load under sandbox
      commit: 2a70a7e2252ecf01057592bb163a11cd337bcc95
[3/6] spl: fit: rework the FDT load hack
      commit: fffbb6f428ff81236d6092bec0d161904ca50335
[4/6] spl: fit: drop the 'standalone' load attempt
      commit: cd9c7bc3b4d2bac01c9dbe39171acedf281506cb
[5/6] spl: fit: use CONFIG_IS_ENABLED whenever possible
      commit: 99b9223948a4361daff09bc973c2d283e48d8bd6
[6/6] test: spl: add unit test for the "full" FIT loader
      commit: e41a770f3800f9c0d2f74fedc04eea09a29a3776
-- 
Tom


