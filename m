Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331C6F433C7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 04:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844B9841C2;
	Thu, 16 Apr 2026 06:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WARI7Jd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD7D841D5; Thu, 16 Apr 2026 06:18:29 +0200 (CEST)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8609F83B99
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 06:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-126ea4b77adso17528329c88.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 21:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776313106; cv=none;
 d=google.com; s=arc-20240605;
 b=JNSDtIFyKNABLK1UWT4us28odbS5Hw2/E9eyLEh0RbvhPhlkUjdNl6WNAKwu8hj0t4
 by6mafeajdCp6aDd9BUI26CigK7g7sBjiPSC+WFxIJflzy3cRkHXhQ6zd5jHuVjre3c5
 ketJYTBR0xDEUAFv7Ei5fNuwXo3O1MScUjXVCDP5L9NZnrSBodV/L3QqF8uek1eHgWB+
 db8hM7WU0GEeKd+7mry+lVWdYp906sq1B/XNHkr1dLWlwgt3sSQIwNmAzDw+O5NZyckx
 8UOWT8amm8/AujknpVnbqgXbOC4f2NZJxatSKDg/qKxRHAzRsAyj81VV7yVEqhGsPK7k
 6XcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pviUDMA6BL2CpZW9zaZ0cCmHlWJK9yehGA61WjyEd3Y=;
 fh=MqVxsXbTqLT1mEOVeZrDVva9zXkQPc3S8baR4giEULM=;
 b=HRKexYIVJAEh2MckyAC8CJoL4cdjI6VFDjAVSErNm1Xf23x0vzFCk6e+v4vaT7gKPe
 jYmPsMG0K2THzidLpe+UrDdHYQYY0ndhtb4FRYZc66ipTNa+lPuC3WSutpVUjEUDJO2D
 7Zqb9i6VHxpUnmaoZRDD3hIqrtZACbkCCULUABAPows/2zMCptmnL/v0+aoxHB/WGnN/
 dmOj/o63eA1HVyMeysbX6xRDxuvFJg8M4MH/iFA6MzzdLd1yhrtRLHiuLmJ2m2hzmZtV
 L2gjW81ji9UFv+RVlBxn8vmYLYMcKZcVwNsIRtu5bVSVaORESX3VuKHEuLxg6VO6cv1X
 cGCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776313106; x=1776917906; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pviUDMA6BL2CpZW9zaZ0cCmHlWJK9yehGA61WjyEd3Y=;
 b=WARI7Jd4AUmoq9ZkJmSjPCXnnJDhScIRJrqicOeEcKlbygiYDr0eV47TdBN58qlkiw
 gHDjJYNKKGydCn+tYCJlm1tJbubETRNNry93Iq2o76sZrS4vOR15nGhyJZUUMAhv195p
 HiNHlycNJfVyU+RylqkRxH0WUGhJ29dRumbIAyRYXIoBl51wYXPe2oDH7w98kOe3YENf
 tPlXtKqHXM50D0BJV5VCzDDzLFy5RSrXmfdZ1ewKggpptiZ8t1N9BFDS7aWRSfdfJR2F
 5MCprh9e5tiYaLdGsYIFXZx/3iV3Y4CMcHMnIW9umcRYTjd4X3w7weAfeiuGxrs1ldTM
 pfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776313106; x=1776917906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pviUDMA6BL2CpZW9zaZ0cCmHlWJK9yehGA61WjyEd3Y=;
 b=UR87uCB9Sgsik+FO084Q194QzP5XCWtu/XKpHE0i6pTogmV6i4QUWJ1Dt1ysirs/H1
 C9MtDQ9xkjyzfFAfdRx5gmmL9/9VTWBtwn0Ab/ihbWiAheVndvtCs0zHRX64z31v6jg5
 HTU9yk4L0yzpIGcjQdjGXFOzY21Pes7dU4MAZviPbi7THxmIeGPJbrp1tP0ID5qo0cjx
 ++a4QkO2GSpBQiNrg8UfDvYwUdEtOow3ntdp6+urLwik1ZJkcbDl52GTJFGhn7AOsOzx
 abSMp2bJEetSV/dLuqe6zakvMnLSQqaheB2ghodmibcrMzYGMosCgj22oPJUslMmKoDd
 ot9w==
X-Gm-Message-State: AOJu0YyTJQdv7xM0aZb9rFWi8ROXQqg8OEuUJtNO4xBVbO4i/zmnl+Wa
 fkrZ7TuCBjell48VkWMZHq1vaCASMQwPL4q1vuPNx2W2XQR4r+4AwfI/G0IJ7XPw0pqz4kswzJZ
 AJY5ispLwr7mnXYuA90FnA9cDmPq/jA==
X-Gm-Gg: AeBDieuF+eTi9iZDnGL4VLcG1bfTwHTdKJutxlh56wRp/9iVNyrk7bpRWxQhy+z+SUi
 vOcf/LfpT70QCMf97VQdg8LwWlPSAmoaCdciioH48ONTWXf/qoIgCSZQEGCNrfaVAxB1Q6hOsSk
 FAHjMn2BPeim4X5/+6Nzg/0zcCE+HqpuojgtNeD3o9et5TotSG5VdPJi3K4sgAjFul6C2m9KLj/
 4QO/88QuLQNR12eB6q1MenQYu9lK46wekvSLWULf8rW0Jyvorb3NGpR1G6KVFxq5SbhTGYsTlUf
 yGusLx9sA4B6newo7iX2KYg9juZWFxKY/gqTVKmbC/8nwzgyOA==
X-Received: by 2002:a05:7022:23a2:b0:128:cc34:35fc with SMTP id
 a92af1059eb24-12c34ea5acfmr14603375c88.16.1776313105741; Wed, 15 Apr 2026
 21:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775829166.git.jcethrid@gmail.com>
 <5dd2cbc6dd82ab4c4136bea83683b71fc12778f9.1775829166.git.jcethrid@gmail.com>
In-Reply-To: <5dd2cbc6dd82ab4c4136bea83683b71fc12778f9.1775829166.git.jcethrid@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Thu, 16 Apr 2026 00:17:10 -0400
X-Gm-Features: AQROBzALMfTqpKmCV054jwRe1cazZm5gIds9U7mDAIlaekVAP5LLmxjSxjthdZ0
Message-ID: <CABdDSeWHvR55-yB8Q1TfyDPjmV5tijuoqLeGzvd78KJ=i6wu_g@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] mach-sc5xx: Remove update commands from default
 environment
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, linux@analog.com, 
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On Fri, Apr 10, 2026 at 9:58=E2=80=AFAM Caleb Ethridge <jcethrid@gmail.com>=
 wrote:
>
>
> diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfi=
g
> index 976d8e0306a..a58e74d3a45 100644
> --- a/configs/sc573-ezkit_defconfig
> +++ b/configs/sc573-ezkit_defconfig
> @@ -5,10 +5,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x100000
>  CONFIG_SPL_GPIO=3Dy
>  CONFIG_DM_GPIO=3Dy
>  CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x10000
> -CONFIG_SPL_SERIAL=3Dy
> -CONFIG_SC5XX_UBOOT_OFFSET=3D0x20000
>  CONFIG_SC5XX_FITIMAGE_OFFSET=3D0xE0000
> -CONFIG_SC5XX_ROOTFS_OFFSET=3D0x6E0000
>  CONFIG_SC5XX_LOADADDR=3D0x83000000
>  CONFIG_WATCHDOG_TIMEOUT_MSECS=3D60000
>  CONFIG_CGU0_CLKOUTSEL=3D7

Sorry this took me a while to catch. It looks like this accidentally
deselects CONFIG_SPL_SERIAL for the sc573 only, which needs to be
enabled for the SPL prints and early boot banner to show up. Other
than that I tried the patch series out and it looked good.

Thanks,
Greg
