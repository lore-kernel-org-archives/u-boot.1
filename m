Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863DFF46C62
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC4A83936;
	Mon,  6 Apr 2026 19:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UmkkCv8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73CB83C2B; Mon,  6 Apr 2026 19:49:11 +0200 (CEST)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF978352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1279eced0b9so4696040c88.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775497748; cv=none;
 d=google.com; s=arc-20240605;
 b=Hc7JSrnzJvSoJdXfODmi3Z/hb2EZO79Q3WOK1TqJMtrC3/KvTfmkNPC2arV1awGL82
 ZbMDMjkBVMQhpWDxFLWlZVVtDwxQwOojGq/eHhpBHPv2i6ef/V2Z1iVp9Doop6JvlR1T
 yRVTWyGNQc2bq/uMsJRjhdDGGssZN7hTxhXASRkem87ZeaLy6gtKso/Wkpnn+E2/E5EC
 eZ/vMdV2V3yNMa2D3Dej4IjT0hmhWhgn/+ud0A/G6Bn9oekhmQRBQ35Vp+rV0q3xVFCC
 b6cv2LFJRs3fNUu3v4AcW2WaaXeeh26O74U7mMeOolJdkDksVX6jAtlCS2jr9X01MlkK
 aIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3DdLKb/DAGmvDqFmhVEZCyPPeX37n8vC+p963Rjmm2k=;
 fh=J0JSzeOsUv1WMAux7uic7CWplS4TfaessyX5a0bn7G0=;
 b=BTB6xa4Zjrq2zZT31Q0uEhL+d5VTJcVMcv/fcIDDXSCpuiew+vcVuC3Y28z0aYhNR0
 OutgqFH+96vBuJWM6nNWs5eYS+TCUjabcfdby0zISV419DgY7wv2dal+Fr0arKsKe8+q
 gRXfg+ppL/p5rAh5otVCoCsO/jPTGS5Nl1QaKOOWaKq/Y1pdS/djyvKCOR1ZO3dZgZXb
 qgcBU6svNFQAmyc79grWQ7po6Kuy979IHXpP0JgXHqCE1TM23F+OUd4ggE0FFKQagq/+
 Ddbl4DdutzZ63XbUOcrze13tEqLLX7AYZq9XN2+eoCLOoyi5nD7wWwOVUEwZygrozGjE
 fI/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775497748; x=1776102548; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DdLKb/DAGmvDqFmhVEZCyPPeX37n8vC+p963Rjmm2k=;
 b=UmkkCv8ba3/2XE8ThWxGbGijKlcJi8pnFloIC6xl5pGP1YRISLqfIGhVle2fLxtQU+
 XF0rM9JfJNkDym6IBh4/s1zMrMi6uJ0hX7exbmTSgPW4nR+Bz3b8B72FchpxkX5X3BMn
 TZWpr2iapve8RTYFmac6a3KZEk1rWB6uVF3xDyB2G3nG6x4LW+OktUIWull5dZ/wuFb7
 q0rqH5YCYfAEBxGyA1u0TfMu2xc/mLL3l5IJkqhXFYI+sCQaQMMKK22NTjUZ4Fop7hCh
 9lGnxr76NwK6sFcQeB/50+xcfL2KfueTqTKhzziOe+KaOFsVYA0q9CEW74JwYv1VvA1y
 QLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775497748; x=1776102548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3DdLKb/DAGmvDqFmhVEZCyPPeX37n8vC+p963Rjmm2k=;
 b=O4C1g2XxVXPsp40YkiDB+cnLitGTLcoEnudksUNSSQsEgHfh6M95jmMPBLvVh7Lh7/
 xUOZKZgxWwTjhokIKanoPcnD8vtpRWZOBdea4AwuODf6zEdXcK459pSD+NGL2Z8GhJhb
 ou7gwTOsIPGITP1kE5c2X+kqgEo3yxEeD1OX5eCU5Swmo+MoEt7VFzDjeHkYtOxHH38R
 uca7rGyHwtlxH3K0YAq+WX2hoUHVOGsMhwwK9SCnM5chRGr3RQdOrB1Y//FHRehpBgSJ
 t2kQYDz7M6rKHH4qLjGoegj9FkoNwtGo/qNLKZoQS4QY0AR8hHuw5GjhmhO1RYB6fdmC
 hXDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmvBqWH6M77eGjSAsJLmnxmgcIZ21kNZty0mLKDQBHzMGBYXHkxnIm4Cdv5KJEFiWPAJzY8C4=@lists.denx.de
X-Gm-Message-State: AOJu0YxeXtfGIXG9PTktT6Wm5+XiKwu4e2fhKqzxxJWjv21PgbcpwA9D
 uOb8CoAX3pgAcxsXhoJAOrbiVlYGN0dWnc8itRrjKbomMe0qsJ4i3NHE4oZWSF4Id5T9a6ahAvQ
 OVVzY6Wmbp7jOIhBhUCyFMwwvLtD1vQ==
X-Gm-Gg: AeBDietkJFUCaffxCl6TdYv2py5AUp5mkXDFcg2FCuoPIdDjcZSa/ncMmaqGh4Ucwg+
 Q/HWA9zhbPJ6Suub/1aSEmLOZb7pAcwtDM5t8PAXqp9G8+kUilRmU27FAGNL4Qr9GdvFBF4eoig
 pp+OBTtIrdxchfZqj5rggPK4jZjrGN1Fvm+0JYLfwIqWcB7tg8Xym3aDYiSmnv08y4Pl2XvlzRJ
 dTcV33BZkycLMxztIU4vtv+vXQUXOfSg6U3OY9MwVpCiSAuUnAt2jvmnNZVSGuJTIFWuvDMa0UK
 o044Xdg=
X-Received: by 2002:a05:7022:6097:b0:12b:f8d6:d4bc with SMTP id
 a92af1059eb24-12bfb76773bmr6018428c88.34.1775497747932; Mon, 06 Apr 2026
 10:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <CABdDSeVpWbu+hadgWJVWaeU7=4xKuvpitbRU+ScP2Za=3dbP5A@mail.gmail.com>
 <20260406133252.4709-1-jcethrid@gmail.com>
In-Reply-To: <20260406133252.4709-1-jcethrid@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Mon, 6 Apr 2026 13:48:56 -0400
X-Gm-Features: AQROBzD1hiejnq61Nk3ptXjs1VN_ehdONBiZSPr6eQ9shEdKV1DRnw3fmnpBTEw
Message-ID: <CABdDSeXQz2TXpjahEXpe5JqT=K5Tbh4N6oEAcVknkG_T5_YHRg@mail.gmail.com>
Subject: Re: [RESEND v2 12/13] arm: sc5xx: remove LOADADDR and use
 kernel_addr_r
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: caleb.ethridge@analog.com, linux@analog.com, ozan.durgut@analog.com, 
 philip@philipmolloy.com, trini@konsulko.com, u-boot@lists.denx.de
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

On Mon, Apr 6, 2026 at 9:32=E2=80=AFAM Caleb Ethridge <jcethrid@gmail.com> =
wrote:
>
> Hi Greg,
>
> > I agree with dropping SC5XX_LOADADDRR and replacing with
> > CONFIG_SYS_LOAD_ADDR . But should we really replace ${loadaddr} with
> > ${kernel_addr_r}? We're loading/booting a fit image not a raw kernel.
> > bootm defaults to CONFIG_SYS_LOAD_ADDR which is exported as loadaddr
> > in include/env_default.h.
>
> We have recently opened up our support to include build systems which
> produce a kernel image + dtb combo instead of the full fit image. It
> probably makes sense then to leave the kernel_addr_r define in for use
> with booti if needed, but remove the kernel_addr_r from the bootm command=
s since
> they are redundant.

That sounds good to me. I'll run it through CI and add a tag in the morning=
.

Thanks,
Greg
