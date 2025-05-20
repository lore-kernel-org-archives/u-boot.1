Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1955EC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E51C82B00;
	Tue, 20 May 2025 14:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/RieLFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F327E82B72; Tue, 20 May 2025 14:00:01 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0544182A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 14:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3292aad800aso5715861fa.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747742399; x=1748347199; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOZPeDVGJ9ErSMZG9S0jB/VQ/5XZKmBnFpv36Hf/uD0=;
 b=d/RieLFa22UQl9EPoNtkmFAzzisGDziXj4pjTnbg5VCIn3Nfnrfwxqk2aa7fLotdWF
 ayDStvW7DvW5h8EhLmOcI7S36MMrlVNzGa3tRX3vODmAM/6gJCzvOGquthmpNMZ5a0ld
 zN41K5G8r8+NvrGFuWk1Ev/ZLn8Hj9LUbTtYkfvxE7iEAjp/5lu1L2fCgiUrhA1Gn+xX
 KEOVdnRPeAUYDSZ3XR7b7DI2EA/e4k0qWATuNSyvcoXT5363zAKrxjFdjJuvJi3RhGoJ
 eOG4xK2+hTdgUkLeGU7xYl52VpUWmCViCKxf4q7EE/fKhyJmLhGoKB2ZT+D3cSrpYD5h
 z3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747742399; x=1748347199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOZPeDVGJ9ErSMZG9S0jB/VQ/5XZKmBnFpv36Hf/uD0=;
 b=reDHBS0k16tL7dQqZ8RQ+NTma+c8gGiAlK3HgbKUz9n7RIkwU14gsUORkGCYqrHcAy
 LJ2BYslqbT/37cVu02T81Ko+Ql3uBs6TygNSZzQgH6VHHHbCF1PO+/HWUgAuCw1bbO+z
 A5J4KPSYyRlMVqv61G3W4NKNacSLZdKSVYQFI7qGy78o/W46UjwDoyxmBimkaFxqAefG
 2R6OxIpm1uA4X7qe47VCWLIj6buT7CjYm8htVuqGdKLiDuEvsperLDNCTzCLkEMjspm9
 wM6eWdWA3fRqF0eMsZDju8b1fLWKTABE1QvuFF+xBYpdXNDI2K5nM3+CsXaa1qi1Qn68
 PYgA==
X-Gm-Message-State: AOJu0Yxl1sUoImmH89p/YcNcRREEQLp0fZOCiJiwR+/1IJlIo/DCpgAX
 sxb0sqe2V2vDIzERAHm6bnHnQmx44Xk11gS5cSQvECpfIgmQ6+JuqKOfPDsfaw8ezy5xxW/EAzV
 aU6l9Mr6H8tDnoUBeAYTM7XhgTqoT/oY=
X-Gm-Gg: ASbGncsrKE++rKkkdY7Co3kfLeFj18fJ22JOCRsLTQWpMEccL7NmOA2LWhJPcbI74aN
 UY507PM8siJ77ZlEFV0Ns5HgeKvsBwEk6KD+SuLths2aibUGEy3vKJMk04C/yrO8APuLHRt4jFS
 qX+EIbBegfZJx110kQbOlmk8t9EPDXQUdnnv6NGO/x53rjDh6NR9f3i1avvvIfoEk=
X-Google-Smtp-Source: AGHT+IFPtPcQMDkVRMbH3W16D0SrPr9xsCbrbaZTS/jy0lRScPZnZ7v55rnPD9/ofNvJ00DLh7v4Az6onICtf7cYLM4=
X-Received: by 2002:a05:651c:20d5:b0:328:d50:d7cc with SMTP id
 38308e7fff4ca-3280d50d846mr30188341fa.20.1747742398985; Tue, 20 May 2025
 04:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
 <20250513163633.1803464-3-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250513163633.1803464-3-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 May 2025 08:59:46 -0300
X-Gm-Features: AX0GCFsmbB3YLG03mAEbezRlWYIHEn4Y5Jq98_7cyPlsbdE5501tNJADkFzyjYU
Message-ID: <CAOMZO5CNieBBhd5iWyBa4OOP5ynyVAnFqMjF9GHcYjwq0HBJxg@mail.gmail.com>
Subject: Re: [PATCH 3/4] board: bsh: imx6ulz_smm_m2: Add support for 512 MiB
 DRAM
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Michael Bode <michael.bode@bshg.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, 
 Simon Holesch <simon.holesch@bshg.com>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 13, 2025 at 1:37=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> +extern struct dram_timing_info bsh_dram_timing_512mb;
>  extern struct dram_timing_info bsh_dram_timing_256mb;
>  extern struct dram_timing_info bsh_dram_timing_128mb;

Please keep these entries sorted.
