Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59639D0D7B8
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CA989331;
	Fri, 11 Oct 2024 17:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aOCKD7iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E22A89155; Fri, 11 Oct 2024 17:06:40 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2C989333
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fad15b3eeeso19358171fa.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728659197; x=1729263997;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LnC10CaG24WPSzLSNKOFOgGsi6jjDThxQwiyj7ue9sI=;
 b=aOCKD7iGGF1mMhEOZAnk64Hj+G/rujvqLUewzjCVZybjDX6cl0z2pbo43lLW8dOzpT
 +zwuXC9JJ2ELMhzeJ3WnUaF9vN86rleX7ZGay1Ck8AxTUemKtNIQF2Jhuq6S09ls5qpZ
 TZwMvarNfkXkZUzIGmIuHsIXj9LowBIuNSpiidH7LhHJAgfUw/VHhvmBG3y/yICBAfWS
 raxy+D4Njpa/CmWK+tgkHQDq8BClBoyjJ8oQIHyOtVGgt9Ar/mr3xd0MUIZlJoofsSEQ
 KinWmv48j6+SRbbLSyG+9LrKRdA+agGO0eNROAPg4xSvMnDFY0cAQwDsuOggYOd9R5aD
 uEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728659197; x=1729263997;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnC10CaG24WPSzLSNKOFOgGsi6jjDThxQwiyj7ue9sI=;
 b=pVAYiO+dj5JqPe/Uk3WLLCzgcmW9hNYJbK/T7Tu2qG0fDpmyF3WjFAO/AJPqBkvSHI
 dJZBuzWlo1m0/N7t15pL4g3quVk5yqlzWtncuN1I79d1TSEXjAhkgLbFhDMOV3hA2jTB
 Qdy5k3Pbknh5nw06Tv6KcDMNKwIPej+S7BKnc97iljtF4Gk91qOivOV4k6tbdygYylt9
 mQ651p4hyl52wCMQJY1CH7Q3mI076Tpwu0pYoO+sk5wM2Hba837uE+p9AV1cHNf4Nx1K
 84Bc9UCisgQz5MG+4lTlprneW3ETvWPsfgxju9IqfRAolqQoE59N21ejJRXWcByGpmHU
 UWkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm7LyQ7fpgsIS5LSbBlRMc2e8w+7NZP4JD7gCUCPOBlRNE8x/ePOK4bE+vcKAGKfh1QO21q2M=@lists.denx.de
X-Gm-Message-State: AOJu0YzOOCYpepb0MXxeQy2B1qvwk+5ttNY7/vBdL0y4tFI1oSwWGa+x
 9+17Bt2i0hV4POn+N2RzebnTmjQcXeVbL5/xEJZPyBGTWf0zNQNB2tXA8S5tgG/UsR/E+axhinf
 T
X-Google-Smtp-Source: AGHT+IECnKBqoOc7k/CFj4x1daaYO3nw/jGKlt/7w1KCslOD5pYHxmM8tu+9qFbNR8DtXOtxcoFVgw==
X-Received: by 2002:a2e:460a:0:b0:2fb:2f7c:28dd with SMTP id
 38308e7fff4ca-2fb32740971mr12143731fa.18.1728659196758; 
 Fri, 11 Oct 2024 08:06:36 -0700 (PDT)
Received: from localhost ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6a82f3sm4138899f8f.24.2024.10.11.08.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:06:34 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print
 BCB block content
In-Reply-To: <20241011144519.xukl22ksrjsqz55l@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
 <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
 <20241010102051.q67usj6oaykjaixx@CAB-WSD-L081021>
 <17FD1697482D61A4.19251@groups.io> <87bjzqhg7g.fsf@baylibre.com>
 <20241011144519.xukl22ksrjsqz55l@CAB-WSD-L081021>
Date: Fri, 11 Oct 2024 17:06:30 +0200
Message-ID: <8734l2he6h.fsf@baylibre.com>
MIME-Version: 1.0
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

On ven., oct. 11, 2024 at 17:45, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Hello Mattijs,
>
> On Fri, Oct 11, 2024 at 04:22:43PM +0200, Mattijs Korpershoek wrote:
>> Hi Dmitry,
>> 
>> On jeu., oct. 10, 2024 at 14:17, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
>> 
>> [...]
>> 
>> >>> > >
>> >>> > > Reviewed-by: Simon Glass <sjg@chromium.org>
>> >>> > >
>> >>> > > Can you also update the test?
>> >>> >
>> >>> > I apologize, but I didn't quite understand your point. Could you please
>> >>> > clarify? This patch series includes additional tests for the 'ab_dump'
>> >>> > subcommand. For more details, please refer to:
>> >>> >
>> >>> > https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/
>> >>> 
>> >>> OK, thank you. Sometimes it is easier (for reviewers) if you update
>> >>> the test in the same commit.
>> >>
>> >> Should I resend the patch series with ab_dump implementation and tests
>> >> in the same commit?
>> >>
>> >> I can prepare new version, if needed, no problem.
>> >
>> > No need to resend a new version just for this, since it's already
>> > been reviewed.
>> >
>> > Keep the suggestion in mind for future series!
>> 
>> If you do need to re-spin this as v4, you can squash the test commit
>> with this one if you wish.
>
> Of course, I can re-spin that.
> I believe I can save all RvB trailers during the squashing process.
> Could you please clarify if my understanding is correct? 

Yes, I believe your understanding is correct

>
> -- 
> Thank you,
> Dmitry
