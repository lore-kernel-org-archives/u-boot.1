Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6021C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 20:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4758460ADD;
	Fri,  7 Aug 2026 20:45:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpfDfyYs3Wmn; Fri,  7 Aug 2026 20:45:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C902F60877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786135502;
	bh=ctloMvnHIHrnGXymuseKTqXA/Qf+nTtCOQX3ruqHGyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pT/YuYHT6tRjLEFkZNG03YTkpMELKeM1M3PGtc0lySW/t3DpdlQVWOyTpYXdg7fjc
	 E/CTLr0I5i0a2j0xsLxzEOnr0hANyLSTf1ucMGjbUE1gN5Nl+CdEweK7Em4fggkY5S
	 vYosxx9qODQdwORHaVP2pieFeMgGwkOpdB6EW44qLSunmloNmxwW5qsUc9BxhMg3hD
	 ehUb+NjwmFEyaIZvqlfYgejCLIP25C3DAXqVs6Bs+pMFeldPD9nXSc80UZB3yd2xfi
	 EkIlAfm6WZBNNWfQUnTw6Zctr0nUEzAXeuXH54mWBeMnJksXcNYtXbnKcF5dPOca7N
	 dDSJd3z5DeTeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C902F60877;
	Fri,  7 Aug 2026 20:45:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FE17296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11AFB409B6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TB8mgYj6KhXg for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 20:45:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 30A9B409B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30A9B409B0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30A9B409B0
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:00 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so6040773a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 13:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786135498; cv=none;
 d=google.com; s=arc-20260327;
 b=Qe9S6QZxM+WDxUS45S1zunw+kbpFLlDnoCvDqAMMsOy+FHPkUq26EADNqiDdgKMiF8
 jE+I+isF/Dw1CFBnX2bSeV70tpNJ9ftS9JeddY9TktX4wKItfEDZduvHyASciqKKEBX7
 1Iv6BiS/wUZLGJsCiMLeRFE0aTuWpqLzEf4uF0JbQQEsFHTBHn/frcYravYZPdcA1GG1
 AjFInxpiMnJ1KdGCJ1x55aON12q2XdsQQhKrFNja4UlADhZEaK5BWuip+OkY4gSWlbat
 zoj2/UbfS0hXoqARr3/76PLfStLdPaqhdo1ldgwXPpO7BtlLn3j+yVQLp7EqH7JHzf+I
 5Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ctloMvnHIHrnGXymuseKTqXA/Qf+nTtCOQX3ruqHGyk=;
 fh=ijpGqnd/DhBct2Cw5aDmEJPs+G5NkZyVrRaaBz7981M=;
 b=QjkCIF52YbrhauqiQwjnS/K7DGNF285OgBKZstCUB6shLCag/iX85VrTo28JcVh4xA
 3SI5Ip0WigNgI4FNVpaOfJcFxAYvuzkQsqlwaOOsZrJnjXAZBdLKO6rTk3aoj+OHUfdl
 OuJCHXJwu9CxtLfQmJVFcqyRe2Y/QPXuaO254Xbi/Uip5Is5uX4hstzQ9UYUKt492Aeo
 oAkWh3j/6b8F+aDuUKq+hn+KPJyKWvT1okHVL3D7o5GNMd5EnXdbYOcymbCICqBWmroW
 6wT6ZxPb+9QtpYMiT6BbkxK6rLGM6ejxXrLJpEd9YA1luH6kxIXBFH+NlDfj6J63QAN9
 SnCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135498; x=1786740298;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ctloMvnHIHrnGXymuseKTqXA/Qf+nTtCOQX3ruqHGyk=;
 b=gQpNqZ2B11z5uZsjpxuRnXwSs3QLgja16FQzOYMIBhyDKSYZ6kahI4IXxw69Dgv3X1
 J4uwb7/8rxOXFwuelNJaNCGSO+nFbdbwES7muDT6mp6QT1A3fc4cMtjxg1J7qVwPXg7D
 +JG7SrklVNQ0v3PuEDhaZonDgQXcnSmOWAF7qbd4ZvN55ebw74W24oxbDbQOLd75NE/i
 b3CsaRWC56ABhmjLNlPxGBSKe6k02whaHpSjQmutrwAlv8mvymP4ZQwq3SWWroZbBWL1
 JnUrq4pXmhqA0YieEGiN7xEuuFoD/kYjzviNUkUG31FVtfBcoBUDWRLCtoM+weHaOhP/
 0yow==
X-Gm-Message-State: AOJu0YzkraJYormzhWhJ/c9cNJUGdiKypUJMUktskAxwahaVlaD604TB
 OlcWA+NV9kzBgi6pKmrskD+zpql5xRTbIiXFDdUcKypIeEEWsZgy57a768X92GzeZSIcooA6yeV
 KNKP/zDZ40qlbanY02deyXC7JRvfjyLNXuyWC7Gi7
X-Gm-Gg: AR+sD11OklKacmaBed54axuzFkGHcvqwewIQSh08m8KBuROLH7hVfVLHAkTMCaksq5B
 OIsM2ukZ8NlwuPpmXbSi3NbA2r1bmqtbmq4IxkJvnapTa6uTWetdUj+3uHnlSo4YrGnLZIBQPMK
 /Q+XdrvFLD8IsI0StMVGQUoK/HOoxXZZ7JAl5zxU1mx5PY9o1GdLQFUDoJlaZFVazE1JvwL+ARY
 VeZonFR10WgOh3uKRvDjSlg+XZUaUmf/vQYdIhkjFKopKpK4E5tPjt3TfwlP6KAYYwOSbtZdad2
 HmDP7Qelo9HCzRWbP7l9fMEU/Ix4kILjzPuXFWfIat4=
X-Received: by 2002:a05:6402:530a:b0:698:5f47:1d41 with SMTP id
 4fb4d7f45d1cf-6a1e5b0df19mr3500476a12.14.1786135498264; Fri, 07 Aug 2026
 13:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
 <20260807-riscv-full-fit-support-v1-3-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-3-21a34f79c350@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 14:44:41 -0600
X-Gm-Features: AUfX_mzQ6KO5s2khVeoP4SzV-DBsMhAPisvF1qn8uNQlEzJ0bkUK1alDJHevZOo
Message-ID: <CAFLszTg6Jmnhi-e=DxTDYvY1cDiA4d3bJ6LTKvRVCOn-2xtvUg@mail.gmail.com>
Subject: Re: [PATCH 3/5] spl: fit: Use map_sysmem() with buffers for fdt
 address
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786135498; x=1786740298;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ctloMvnHIHrnGXymuseKTqXA/Qf+nTtCOQX3ruqHGyk=;
 b=UEnlLtH+h2JG7FhZGoolEJWGpisxUE88CAV+weq73Lm1XZlxxl8mPoq31krqOIsXyy
 uNFRv6Toe5/5Pcu7FS7c6AYaXZrZAtgMlFhoF1a1Lm32p+85KYbH5s8Fat9YTFo71/B5
 DqFADPbQmVT9GcDM5tQUFfypAFzFgUP/7dQJE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=UEnlLtH+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-07T08:06:41, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> spl: fit: Use map_sysmem() with buffers for fdt address
>
> The current implementation casts an address to a pointer. Make it more
> sandbox-friendly by using map_sysmem().
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> common/spl/spl_fit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
