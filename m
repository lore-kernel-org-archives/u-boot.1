Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEEBF8E499
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 00:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2CE584227;
	Fri, 17 Apr 2026 02:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLo1bWqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99E884228; Fri, 17 Apr 2026 02:00:20 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3237C84227
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 02:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso12834766b.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776384017; cv=none;
 d=google.com; s=arc-20240605;
 b=AJNAWsz7UMmVIVaA2NPyxIAJQx6NzlgMyJHZJLaFQ2NHX23wYz6tuVSGLk6zdv3n7A
 o8/Ekz17wtbgOqx3nxV+yJ1RMOjDjxxAKb4Nh51c8lvCkkLB1Ni7vIzL+YeFQZIxPPkb
 BJOEyujoB3g49IIwLkB1YJx34W/UHUImSvu9cHghnGPQHE4Tg8GbMpchcRzBoZsyJU49
 l++OkQTWE/eGx2KRKKw+6wAUdLmEgtJTnhAdUvi5DQMMs//I+oaE9HsH9e9odYvy/oaJ
 kltWD1duEQS4h831ERGtxCFRz9PqaMDrMNZZ2g4N4Cck1yd7kS+P8A7s18dgVNsupwka
 aDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fUuog3+CGEp71uD/bP/B6Bi0gt6QzqxLEhywEOk3asg=;
 fh=T4PkicUUx6uDDJku+sxXk7XY6skMi90tHfLhn9SkZQc=;
 b=ODBgdKpdWoUSzUxpdEO+HMAFvHePne/Jd2IFjUqR81kXnmamft5wLAka4njN8GTR+p
 KtBQD8/rIVa6mha5WaSmUrYcZzVVsVZYNauut8CDDSnrBKFQm5AvdYEn647pHDfZv5YG
 mOR+xyoljca0X4RQuNNrdNxzyx54HcXwgglJ2bVQPVH1NDVsX5YUiIZyrV2ZJQTMCExj
 9HlyR8VUsT2pmexUvNTR0uuAK/Jq0l0yCNI+spDeUx6rackUPx+Cx39JfgsN2m+4JWTA
 15NyF5M7AY6A/MxYNOFsz3zuQm9cP4ZJSnvsKxVd9lRb658ON9vrL5T1usC++YZsGdUZ
 3a5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776384017; x=1776988817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fUuog3+CGEp71uD/bP/B6Bi0gt6QzqxLEhywEOk3asg=;
 b=QLo1bWqQy5k/nsrsxTc/QkwelMJvDQhKBfMAnOvRIzTZhhrU+Xl/spbViXNNqJ011x
 j+xVtTKWA8JzyGGV6qU3YzxkbnwJl+bubB3yTgtny8g/2dlFr7DAXUTEUtVHSnBfkC1A
 Luxo8AW96rN+vTzLG7cIZ6DJ4AuNb5hqQS/FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776384017; x=1776988817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUuog3+CGEp71uD/bP/B6Bi0gt6QzqxLEhywEOk3asg=;
 b=Na7ZvJu07F1GZwRKIvWsUXTjAs0+dzACL5EQDkPsFIJ86CdzbPMK0DWhkapIimzPZV
 /SoV+MWPbWzXCKcLASRb6eByzo/lpZK76JF2zxXCZ+4nz8DrAODApkmhs0t2e1X2VdCW
 r60jPlJt1q9jkv7REJ2I4kZ2jo7wqXRUwWlI3Hm/3HkVpY7z/Kt78jfnABDlgnobowuB
 YsjfMKOMPdR8yCRQwGw+EOBRrDEV1ZlK2ioLs+UeVzbasozLt0hFMFFMmeBv/aa2o/3/
 XXVbocatUvklI3GGEGDAkfwEo2I/nZeXHno1F8Os3q5jxGUNNdMNjmSxdgjbwV5efWIW
 UChQ==
X-Gm-Message-State: AOJu0YzzvNACDcXs7DIaCSXdCMqpQS3Zn/XHNF6qCf5Jfdo49nz8clqZ
 XfKa0mcU24u77uTYONf5BPjkLsRXzD7wRIC42hgU9vle1xXHtxwwtvP+TzWdqi/Ul7xRNukjL84
 dNkl8oj6d//uCm/6hWaqawBB/ut+CKq5ZjlQ6uA5y
X-Gm-Gg: AeBDiev2aXHzgbwaq3Sg3ezF99zBgrDCa5V0bTejoz0n9fUONLSO3EPFgHW37n6zZmD
 H59dD/LCG2ZPIksUQaPwmG3GacA3ZV2mBZoCcZ4D3S98rOJbz5kGaA1JyBCChq1lbeVsGpjH/Gh
 G4mInxQnutg9T5qDIGuAPmJcB6CVcToM6dq4FVIRSOKFo/Yigh+EQRvGH0ThDVYe/pyBGh7b6cr
 5quegRQ6jLV1fh9pZU2CmK0kcEBSPG5DTrFNYaWQrdBX/jMQcDUZ/rARCvecJidSH0BZQgQk63P
 CmSfrGk4QsEwRJyG17Qb
X-Received: by 2002:a17:906:9c8d:b0:ba2:b229:f14d with SMTP id
 a640c23a62f3a-ba418b7e453mr26031766b.2.1776384017251; Thu, 16 Apr 2026
 17:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
 <20260416-enable_fua-v3-2-84508de2bfd9@oss.qualcomm.com>
In-Reply-To: <20260416-enable_fua-v3-2-84508de2bfd9@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 12:00:05 +1200
X-Gm-Features: AQROBzBb2V9oV0HbInVeCijUqd5awbo3Uny_1M3DZQ86HUW3Jv7JPkpZI5BWmZY
Message-ID: <CAFLszTjNshFzjNMWAduua1=Oqrm-CPG3r7ttF9vau3t6VPE2cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] scsi: Enable FUA bit in WRITE10 commands
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>
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

On 2026-04-16T09:10:45, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> scsi: Enable FUA bit in WRITE10 commands
>
> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
> ensure writes bypass the device's volatile cache and go directly to
> non-volatile storage. This provides write-through behavior that prevents
> data loss during board resets.
>
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/scsi/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
