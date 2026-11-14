Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD5606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y+VxFPco;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8U5oTo1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1112160706;
	Sat, 14 Nov 2026 06:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNfxBGbn4wHC; Sat, 14 Nov 2026 06:19:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 363AE6066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794637192;
	b=RbWQ+NI19MZvcqEMPSmuFLyv2iHVZ0V3EDJVeR237voHnk1L2EczpnXh8Ni72acqM7CY
	 JhYkMnb8c/lWb9XKOevKCAbxRH17dqHtonf04Nr3FLy3MmwiHA2j3Edmsauc6IE5tZj2A
	 N1ePBxGkMJi6sSTrWW8t/uCstQjpiivnJdXILF8+d2NAmyfPj/nzoW+KQgxT/cmcTfC5X
	 6Av50j/gn7ojnHkJPnCaQlogEuvJlhpLlgR25tQsipT0PecWzsolW4rDZyjWBt3tEVtrs
	 t6dDCJX0C65o4Fp9oCQEEV98fjf6P9gTIh7vrCfjxfAX9peT5LWxTkeMGZswsEw0gMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794637192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=akQ1ngf4+cF7teDVF1nJSTmTAhcx4XhIYaTBPRLYQMg=;
	b=malclQ+5BK9hfyiODSAO8wqZwAj1vFNLSgZiZ+TnSIHxLqwfE7St+CjdrGCBKHxqWcT6
	 60cFbgCLHDw8C0ivzlbtW1DGpuhi7xJ3pYWRiRJwaNYCUGCSsWpNRraeb91oSf/bf7Zvl
	 KQYWv8GlcPrSkgk74xe4Mf6YAUF4E+xZ18+sJqLpFqszg9rC1CLQ5oONl5Mf2UGFp1hNo
	 Ta1PKFs6SX5ch0QixonS8pVnGvW6PNH8JqzT/BI8ZmeaYz2F1UBX5hvVSCChln2nPau7h
	 FoSzSTD2tmOkzyBmel/Ap8HPOOVugG9z79OZ9LMBmCLHWU2ermxW3HsoBQE9Bd9t0Zw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794637192;
	bh=akQ1ngf4+cF7teDVF1nJSTmTAhcx4XhIYaTBPRLYQMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+VxFPcocbUyMluu+GzRGiZGoCyULi3wlPaOfaxMPuOVtcFKRp1Vp7zLFFvkef78e
	 uBVmUnlTACXN2fRzfOXENsjnZdE2GpBFoJhlF5CnR6/FlLqb7Yb22JHzaJQrrW4rhV
	 Pj654UKIHAksOZjLWvkpFeXPvK7eeKnxC1JEf71eG4qh021qNrudCkoRrp30bkuyyu
	 BRZSpbPJHeWO5JzoxJxC5yERh+v9HNelAFjRBFTpiNAgK8t+U65Z1N+y9XpJAVyM8V
	 ZDJuYdRVjD3G1ZhpuT2tDJeOHg2fkEX33XUeVnJbYdG9aFUOkkbS3jE9812X0clv+1
	 EgjBAYKsxIujw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 363AE6066D;
	Sat, 14 Nov 2026 06:19:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C59C31E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 06:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB24640AE4
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 06:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fgYzDTRNSncp for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 06:19:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5942D40A1D
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=i8U5oTo1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5942D40A1D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 06:19:48 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9335784821; Sat, 14 Nov 2026 07:19:46 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8469847FF
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 07:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mehmet.fide@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso451855e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Nov 2026 22:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794637179; x=1795241979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akQ1ngf4+cF7teDVF1nJSTmTAhcx4XhIYaTBPRLYQMg=;
 b=i8U5oTo16OQWh3K/+PtbaMJVyi17laIRaUQB7w6Lx7Vl3MmwlLrCl/HajDfKejFIXy
 WBFxgep8/CPk5LpFR/mIHKKcAZjhk3PEbsJ/raKvl0hDfWRblzLfXPc9+C/fguEn3Oc0
 kSstfI6VsaINHiyfwiD9gaWsymxelgRYiRDgJ+LpEBj1a1kzOm21mAPbjdonlCWW5wa/
 GMWrSwZOketw/S1aUozDzZzudqDK0VYo/9u14ER6dspLSoHACj94Q33UUWzoflA8Q/Pf
 eemP71Cyx8BD9tHHjrEybUpH5hPqL2ZLFGzPLku0b1TGC50ZwypThlBGdPLzlL/3nWWb
 5xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794637179; x=1795241979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=akQ1ngf4+cF7teDVF1nJSTmTAhcx4XhIYaTBPRLYQMg=;
 b=PAVbWD08ozyrAzmnCUPmFMt0zMhJPdd/HsovmYcbB3Q6w1Fqw40kAJ4Y+dsI4zaqcD
 NHK1g10clkQExQjxVz9qrvbJlRZ2taV1YfZXJjo3m+Z4SVON8RAU31otP/THmv/e+inn
 EV9USAz2SsnrPTt0KnBJMlVEhVZyuxorddTM6KGS1SdFII+OHdRbPC2J10cNfl9yJUKh
 WCJ/J8BTcF9L9KGeMp4db/AU5Qsnw3bmB34DTjBrvo+VLUPJyHMBoEbzBaSRKjv5OC+1
 StD1DwdyUZNFTFb7+iMqhAlP4Z1QzmFRgoo9VpCZ2qF+chxE64aSx5blXQrZhFCu17Hf
 HkQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH7H20qF90JFmay06W353tvcc551+j/JeTs3hBvpTdO8u/O3O07pQupRREIXgnuX5+3iCUqK08=@lists.denx.de
X-Gm-Message-State: APuU4Z+wY6Hw6LKxkTXT79jLhXqLRCa2dcLogEEuptSY8on+Dx7EHFpD
 /AZkcKhJXHBUFCWtONzfrx/fnrtIaLGAX/AQXiy4NJ8aoP+dBQ3scux9
X-Gm-Gg: AYBFou3stJR2oKQbOCVmAsSTT0xsaXJ1R8EjWvDjo9jtKf7oHVtDIO3ZIFBdnizgMey
 yFBaaq6z/RX2Zq9F/AZGPyQElhd592GDK9FGJyh2gWCLK48pY4msjWtqEmxxLCdDBzcBsu0Ccmj
 PZ/B1bDEAhbQtok6B6Vsxb1CAZL3A91rPatSYWd0FabUnynrBC9DBrYUmTSxn0s4SnGV4ToJt8z
 oYsmqi0eYQ5ZhIRqFSwtLnKnJtnQZP3lt9m0NhUE/mPbT2+6rwAkhMIKr0cwalzbpz0N1gy8IaF
 8q4edHs/SDfYpXsGAkrefksxkUu3HYkQu59Bu4mGWgur4C0lMpMhwqHmZCVQVPn7aVWgT6jfFa7
 YnHegcu9COHJ7EmLW2VCjf41MMXIHuCP7z8fALyqsbUuE9P07zPotKkzVqI1+Gcy4zGvQukJUYb
 c9aFRK0tylFZDTzXXErWxcuS5KpkJCiYJLX3fyVmy9UsGvPefetL14TRMFGWhp/bLcp9tmYab0H
 m8rziOkpULdnf6qPoh5ZscMXnMHYqH74HuPWq6B+DjMKApCaAki8dNQ1ukmBi7jgnaxk05DDjen
 x/24RNpHgTxt2FG48NzvGk9v6Fmdt2CQOs7D5QpXQ5L6lYOFblAf4PL9
X-Received: by 2002:a7b:cc16:0:b0:4a1:d766:758 with SMTP id
 5b1f17b1804b1-4bb4e2fc5eamr151406895e9.16.1794637178971; 
 Fri, 13 Nov 2026 22:19:38 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8c248sm8970616f8f.58.2026.11.13.22.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 22:19:37 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Stefan Agner <stefan@agner.ch>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] colibri_vf: configure the DDR controller from the DCD
Date: Sat, 14 Nov 2026 07:19:36 +0100
Message-ID: <20261114061936.846858-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018195302.2900162-1-mehmet.fide@gmail.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco,

On 2026-10-18, I wrote:
> I will report the numbers in this thread

The temperature tests are done, on five modules: three Colibri VF50
and two Colibri VF61. Each module ran your two tests, each in both
directions, first with the current U-Boot as the baseline and then
with this patch. No boot and no memtester run failed, with and without
the DCD.

Setup:
- Colibri VF50 128MB IT V1.2B (three modules) and Colibri VF61 256MB IT
  V1.2B (two modules), one after the other on the same Iris, in a
  Voetsch VCL 4010 chamber.
- -28 C to +85 C ambient. The chamber's limiter alarms at -30 C, so
  -40 C was out of reach.
- Baseline: U-Boot v2026.07. DCD: U-Boot main
  (2026.10-00725-g0cba6c79d63b) with this patch.
- Toradex reference image tdx-xwayland-upstream 7.7.0-devel, Linux
  7.2.0-rc1 on the first VF50 and 6.18.48 on the other four modules.
- Ramp 1 K/min. Die temperature from the Vybrid's internal sensor.

Test 1: boot loop from +85 C down to -28 C and back up, power cycles
and reboots taking turns, memtester 4M after each boot. "ok" is a boot
with the U-Boot banner, the right DRAM size, a Linux login and a
passed memtester run.

                    boots   ok   at <= -25 C  login   die temp
                                 / >= +80 C   (avg)
  VF50 #1 baseline   108   108    10 / 16     79.3 s  -18..+120 C
  VF50 #1 DCD        108   108     9 / 18     79.5 s  -17..+119 C
  VF50 #2 baseline   114   114    11 / 19     73.2 s  -17..+117 C
  VF50 #2 DCD        114   114    11 / 19     73.4 s  -17..+117 C
  VF50 #3 baseline   114   114    11 / 19     73.2 s  -17..+118 C
  VF50 #3 DCD        114   114    11 / 19     73.4 s  -17..+118 C
  VF61 #1 baseline   167   167    16 / 27     41.1 s  -14..+119 C
  VF61 #1 DCD        167   167    15 / 28     41.4 s  -13..+119 C
  VF61 #2 baseline   166   166    16 / 26     41.1 s  -15..+118 C
  VF61 #2 DCD        167   167    16 / 27     41.4 s  -15..+118 C

In total 669 boots with the baseline and 670 with the DCD.

Test 2: 45 minutes powered off at -28 C, power on, memtester in a loop
while the chamber ramps up to +85 C; power off, 45 minutes at +85 C,
power on, memtester in a loop while it ramps back down to -28 C.
memtester 56M on the VF50, about 15 minutes per run, and 160M on the
VF61, about 35 minutes per run.

                    cold boot  hot boot  memtester runs passed
  VF50 #1 baseline     ok         ok         21 of 21
  VF50 #1 DCD          ok         ok         21 of 21
  VF50 #2 baseline     ok         ok         21 of 21
  VF50 #2 DCD          ok         ok         21 of 21
  VF50 #3 baseline     ok         ok         21 of 21
  VF50 #3 DCD          ok         ok         21 of 21
  VF61 #1 baseline     ok         ok         11 of 11
  VF61 #1 DCD          ok         ok         11 of 11
  VF61 #2 baseline     ok         ok         11 of 11
  VF61 #2 DCD          ok         ok         11 of 11

The VF50 now initialises its DDR from PLL2 PFD2, and that is the part
nobody had qualified; across the range the three modules behave the
same as with the baseline. On the VF61 the clock does not change and
the results match as well.

I hope this answers the question of the risk.

Thanks,
Mehmet
