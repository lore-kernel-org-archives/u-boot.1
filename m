Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7652CE95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2D286EE9;
	Sun,  8 Oct 2023 01:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lMZnIuez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3811486DF5; Sun,  8 Oct 2023 01:12:20 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE6486E8A
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a200028437so41612867b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XcAXsdfVPGgFyZt83SW9MY/hbM1+NuPUO9IQbkEvhbU=;
 b=lMZnIuezf2+7tgtMI0DJK6Keb4ppBzXi+Pm1nropaIqiLObYPAhYPwkRFPJaG55p1U
 mgI4LIth9HUApXGEwzNZ+jDSFet3G7pUTb6UMFGNx+AeLl/plJmF4mIQ/Jfa60Gvq963
 kd5neayktvt4bsMjOmQwzVyQka8uPM62aufsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XcAXsdfVPGgFyZt83SW9MY/hbM1+NuPUO9IQbkEvhbU=;
 b=Ycc/zZArprWEEkqLo+BgGBRkSQLbz3xvbwpIT74AF9cO5dYQSMRmlpR/Ff/GKUDb/j
 u4STWRvLsz28ugJY2gnfGo+aLzmxTz5+j6hef2uV7QJTX16rQtyiVo0WvIjcXGLCMShR
 +NIdPBofqT6tQTWf+9hUoECnjCqNWUEEbrCOTuGX13B0oVLWPJXEF9m8kktsWhENk5I3
 riqm646WSOc/hJEW4c4mhUj2KRhd/F8iGSFDCWhxFDjE1YnW+7q1V06fTkZUWw32fmil
 Ss9PG6o+P8t8QXs5MviNZ662/P/cpsk05leu9JsgLybMrwVsWAAmKHaC9Iv0EVComESJ
 rzyA==
X-Gm-Message-State: AOJu0YyYpPI/tYvVJEkyCP/SJVLxIsWa713sF8d9DJk/JdDnzQfP6eBI
 S7L3iTRb2j/vwLt0Pkz1TBMtVDZLmiVoLElWxpZd2g==
X-Google-Smtp-Source: AGHT+IGff4zQMt9U5HujS1ct48lOWMzRbsMtsZ+vWsAGNA6w+z2ORg245wFModhNFWUXHYnn/Ab0iL5pcGIbthw4kbY=
X-Received: by 2002:a81:451d:0:b0:5a5:575:e66a with SMTP id
 s29-20020a81451d000000b005a50575e66amr9717220ywa.15.1696720299260; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
 <20231007214106.15744-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-8-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:10:09 -0600
Message-ID: <CAPnjgZ0Quq5U05Y=MomdgPDeKQfuFStOAtGQ5KLjLYt4GPviUw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] test: bdinfo: Test bdinfo -m
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
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

On Sat, 7 Oct 2023 at 15:41, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The bdinfo -m should print only the board memory layout.
> Test the expected output.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: Rename bdinfo_test_mem() to bdinfo_check_mem()
> ---
>  test/cmd/bdinfo.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
