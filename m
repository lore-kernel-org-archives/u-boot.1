Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FBCCD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 20:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91DD8497A;
	Tue,  9 Jun 2026 22:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r4kpoTz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3078498C; Tue,  9 Jun 2026 22:45:46 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1754E848DF
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 22:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-48611ccd5aeso3522182b6e.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781037943; x=1781642743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5migHRdoiGDJoj0Z+GVd0BSxajmQwzyAGxFEU8n/FKk=;
 b=r4kpoTz4OhGq9W07FOAyutCaDlZcCabfmB7Fcu74wagqffaHQdJNDT2GSF0xe6xsvv
 X9auhvp8Wdx0iN4c9m0UC3N1mrBV+Ou41/3pWFLl1iiaI1CXgyVWfuaMmOe5jbhGTf86
 u9ITrXrycvXdFnzmkuM5g+GDZhbSip+6ImjUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781037943; x=1781642743;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5migHRdoiGDJoj0Z+GVd0BSxajmQwzyAGxFEU8n/FKk=;
 b=AIn05zjtgR5asVhqQwde1yWvWjTZva1sl+3eQIGS1JxKIX03/+nVvPQF9V7YLrYJTA
 0tTz9W2G4cp+Duh29UPvm9fWm8mbgPYQoL+0lBtVno+hp7UEYN5wFqgJndbVbDmVWqsW
 wkg8B1yPgaRjuxGAqtqjbMxwuS6gdUHct7KyGxecd4muTLPOHTBTDDbQXW7QpEptTTv2
 aQ0j956Qo7BGP53xiePRepDkNL1v/4cC3FlozC4e7Z5H0X4/eVNN2CJ9NZ2Xol7IxHAn
 H9ZFUPR1AwmwoJGcua4Xp38Xzi2vOVRLFWQ+w/30oIWPi0JAlD2WzBi60IZvpqbHS4RR
 i0uQ==
X-Gm-Message-State: AOJu0YxDuSXEF0lLzFB8SP2+2HojRxu9rcXOaXe1/xPPKLVftWcAA3LR
 yf+5kWmC6Ijy4LzwgKxHVwAanGOM4B/PzBxrOwFMzVtgJ1It+iTbMDNc/8wfnnfhzKe4v6UJq/W
 5uIM8A5U=
X-Gm-Gg: Acq92OHS2szkVBWMhubzWmRVctlsxMoQKEHtZdTaGvfxyPCvIoOWhfM25AS4w+QP6xV
 Yj2DDrCswfdXWpeBeiuMAnuvW5phueX5BPw6HQO+xLZOoUfe1bdCtXGf/LFwBz2LwdjeVGJ9l7m
 1DqYIu58Oo5x876taXEkMqIua7w7GorvohI1yCleg95uH6UKXXm8c/18uAt/He0djLRmwSwc70q
 G0klIfQI3+VDhBMf7vpqrViB19KmdkecaMkk0GjEdMLJ5rXc1g16Mlib69SkCo67dFm9Pbe3TCj
 mJX8qYDtFy8SjOv28XqWvkC0BLJISoamavVac+kHSpo49nOrMn2BUTz5dIdk4FCrqqNlg0fOgU2
 7Ktn1g+gt9lt3mihEF1bN6vgbJb00dpluVRvlsedQhnQQ7kar8D4RuRF91fjEH1/o/1t9ubhdkH
 XxSYQy/eDR1UuTbZ8/ZWl9L0DQiAkdp5by3H0vDbPSqlTJVUJuKzPRBPoO59Ls7XC0HOxo495cO
 qt/bGAy0y1F7CKvQzR3/TzD39uPJaExy/EuC2Iok+x9vy022r6XGZrgEMJa
X-Received: by 2002:a05:6808:2388:b0:486:49e2:91d8 with SMTP id
 5614622812f47-4868defaff4mr13441436b6e.20.1781037942819; 
 Tue, 09 Jun 2026 13:45:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b5a39fbsm16814021b6e.1.2026.06.09.13.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 13:45:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260609105859.1174825-1-stefan.roese@mailbox.org>
References: <20260609105859.1174825-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-watchdog/next
Message-Id: <178103794184.3816035.15280314701469558928.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 14:45:41 -0600
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

On Tue, 9 Jun 2026 13:10:33 +0200, Stefan Roese wrote:

> please pull the following watchdog changes for the next branch:
> 
> - watchdog: orion_wdt: Add support for armada-xp (Chris)
> - watchdog: Correct dependencies for WDT_MAX6370 (Tom)
> - watchdog: designware: Fix probe when clk_enable return ENOSYS (Jonas)
> - watchdog: sbsa_gwdt: clamp WOR value to hw max (Juuso)
> - watchdog: octeontx_wdt: fix DT matches to Marvell compatibles (Juuso)
> - doc: wdt: fix typo for expire (Jonathan)
> - watchdog: orion_wdt: use dev_read_addr_size_index() (Peng)
> - watchdog: rti: Use dev_read_addr_ptr() (Peng)
> - watchdog: mpc8xxx_wdt: Use dev_remap_addr() (Peng)
> - drivers: watchdog: Fix dev_read_addr error check (Francois)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


