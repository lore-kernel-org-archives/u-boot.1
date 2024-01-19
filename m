Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DD7C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 09:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8A287727;
	Fri, 19 Jan 2024 10:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ebiRgOdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6265B87B7F; Fri, 19 Jan 2024 10:36:31 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1842687645
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 10:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cdae52d355so5376451fa.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 01:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705656988; x=1706261788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uisTIOcHPXvuxeXrALPgPA1+N+nBJ06vvxAQkVPoBgA=;
 b=ebiRgOdPb9J6ybuwh3geGfjVEcrCbW/XV3EzpukeNmx3YTUHBYf0XWH/w7UDYJW53F
 bF22pl1eJ7IUmqlAdPMioBD66/djHOa9/EdkaoQkUpoCVggRCelnMvnydcAfrtTAoill
 z2kdLqRBkHiu0lPHYlk/24rQwH9R+VvMa2azT9sv+OhXs7t/JNJWsSFo3aAdm+LU4zda
 Tscjmkt8/a92H2UN0aPu1y8l1rWTA0i5kmVRSDUbEFHfR51yWUcugewV90X1tNU+HibB
 Qz4gohmI7IlNV+ovWsYgL1gikS4xL/NdQb1xK6C5VGxqB1Z9WtTOy9EEYcJ8st5sfqkK
 QVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705656988; x=1706261788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uisTIOcHPXvuxeXrALPgPA1+N+nBJ06vvxAQkVPoBgA=;
 b=ssjmuzNH6/re3ckBaIExNfb6qL4Rv87nRHlMdS5oz9oEvhETXnEngkB92DWgUlhA+Y
 GKeaZYjhCskeqybwLuB4gtxa89XJa8zUrsGtn17Geb1+7uiui64Aq/xwxx/It9clvqje
 Rfl2wP+gJDxFrNHGbPvZ7rlxQop5P9yYfAfSgoGNwt3x1anxsWkfKPB7bD8Kz/nc1E5f
 qZs3JahH1Goob/Smrt6Oxi3Ije/sYBh78nz6TCLHQhLYLMHN01w56ISMwtGxzpydqb/1
 pSB1GKBJsDZ3/4Fect1ZcXrOan8my++bF4RXq5W6Ca45TQFpeN4TyBclMmXZ3+vgfiEp
 h8Ow==
X-Gm-Message-State: AOJu0YxaO9cF7XImqXFTdKUowdafwlOKoYMyKDQX/qIhQCVU0sIxhCkT
 y1w9H6cwXiPUyFo8Vl6W6ULpy0ZJyG6vTrSUs0HfgYXAky+ZHRli6MyB9e2cOWec9CIzpnmMvac
 IKo1SVVuiYtNOZar8ezKaJyrNJiQQjCv7mlzugA==
X-Google-Smtp-Source: AGHT+IHHik+wn6vkJISbHvsYtfmE6LT4nzYYOEFQXtYOSHPTZvgyQj7Ib9PhPrVuVJRcu9tORWXCGmigVa4oU0a7Wfw=
X-Received: by 2002:a05:651c:1601:b0:2ce:bf:a2e3 with SMTP id
 f1-20020a05651c160100b002ce00bfa2e3mr312728ljq.62.1705656988391; Fri, 19 Jan
 2024 01:36:28 -0800 (PST)
MIME-Version: 1.0
References: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
 <8cf878fc-88ee-4c27-b95f-d1bce5ddaf34@gmx.de>
 <CAC_iWjJNm-YFXy35_fjyHx0AQBFb0GXSDH3mcHv1uBVNp6D_TQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJNm-YFXy35_fjyHx0AQBFb0GXSDH3mcHv1uBVNp6D_TQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 19 Jan 2024 11:35:52 +0200
Message-ID: <CAC_iWjLu+34pp+ifKAgj=YrvgQKmC_ra5N-tWdkpc0mrY9dL5A@mail.gmail.com>
Subject: Re: ** CID 478334: Memory - corruptions (OVERRUN)
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Looking at it again,

This looks like a false positive, but I cant understand how coverity
gets triggered. If your proposal quiesces the warning for some reason,
I can send a patch.

Thanks
/Ilias

On Fri, 19 Jan 2024 at 10:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Fri, 19 Jan 2024 at 10:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > Hello Ilias,
> >
> > please, have a look at this warning.
> >
> >
> > -------- Forwarded Message --------
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > Date: Thu, 18 Jan 2024 14:20:27 +0000 (UTC)
> > From: scan-admin@coverity.com
> > To: xypron.glpk@gmx.de
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to Das U-Boot
> > found with Coverity Scan.
> >
> > 2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> > 16 defect(s), reported by Coverity Scan earlier, were marked fixed in
> > the recent build analyzed by Coverity Scan.
> >
> > New defect(s) Reported-by: Coverity Scan
> > Showing 2 of 2 defect(s)
> >
> >
> > ** CID 478334:  Memory - corruptions  (OVERRUN)
> >
> >
> > ________________________________________________________________________________________________________
> > *** CID 478334:  Memory - corruptions  (OVERRUN)
> > /cmd/eficonfig.c: 534 in eficonfig_create_device_path()
> > 528             p += fp_size;
> > 529             *((struct efi_device_path *)p) = END;
> > 530     531             dp = efi_dp_shorten(dp_volume);
> > 532             if (!dp)
> > 533                     dp = dp_volume;
> > >>>     CID 478334:  Memory - corruptions  (OVERRUN)
> > >>>     Overrunning struct type efi_device_path of 4 bytes by passing it to a function which accesses it at byte offset 5 using argument "fp->dp.length" (which evaluates to 6).
> > 534             dp = efi_dp_concat(dp, &fp->dp, false);
> >
> > How about using
> >
> > dp = efi_dp_concat(dp, (struct efi_device_path *)fp, false);
>
> That looks good. I'll send a patch shortly
>
> Thanks
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > 535             free(buf);
> > 536     537             return dp;
> > 538     }
> > 539
> > ** CID 478333:  Error handling issues  (CHECKED_RETURN)
> > /lib/efi_loader/efi_firmware.c: 413 in efi_firmware_set_fmp_state_var()
> >
