Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E07BF8A149
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3632B8407E;
	Thu, 16 Apr 2026 11:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="LNowLj3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FE283FC0; Thu, 16 Apr 2026 11:15:50 +0200 (CEST)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65C3D8422D
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso5397232eec.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776330946; cv=none;
 d=google.com; s=arc-20240605;
 b=dhTLoq9tGQhUygG4zWOWfX7JAcYN/xtidQyRtXL5+Yart1SNFlabzkF/L2bUppEFXX
 c03SyrGPW04/i/lMmAEGh5gBSyUQlbaHm0Z/FE4ut6XJTP7Dxomz/7qJ0MJ+dqZUqAJR
 y/R52hqxDqga96A6/0uI8qwa3DBir95WSthrSlHFipvs5B2tIitVKJwH7ZTfELoI+Vfy
 vjRFkkSOn6Pa4OTbbRfLBrRqsemKvOa43zDkR2AqatJ47m7nleK2AbXDvudYVA5Leyg7
 FLQFO3v5rnedf7UCPzoQol2aoUg6CJV4NTWNDlI795EvanNUZ+DrInEZ0t6MrZ2y3UlR
 8Pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eBnSLo1WaWdWZNmP/1Y3PJozIxe7e8DbpBRkn5Mt2ec=;
 fh=I4H8W3eym20rCBE4i5huWUJTEVymNOMhh7coLOIes04=;
 b=GruxNMcIAPi2as65b7klASLpYCF1W0XEAdj/mLT66150t3TucP/BZhpGVB7eRgVzAz
 szpj9nvkrA+sbcJRubWIcsyEOxIlmejSywz9haUXzseMnn9KyLaayHIRSHFlzN4YgXLW
 bziACGBcj4Eb7E2U3KNEXZ2wRK+CjTHFX7vH5IDZdm1kyAEZRWHx7nguYg6UWQzTkWwC
 CsDTu2CX/AhLsme67nGcNHwbwQP/B/dYt3kun9clbJmf+t+FDWDFYwhJKDbKXkKtvpKz
 3XkSwbimU87FOcfe05eSUEYv+G7o3+T3gdzMx0KWbs++mMIe1PojIXHoK7rT7i2kSJTI
 GuHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776330946; x=1776935746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eBnSLo1WaWdWZNmP/1Y3PJozIxe7e8DbpBRkn5Mt2ec=;
 b=LNowLj3MtA9RDfLqj0HvhvpaExVoWTYw798vPCzjtUBQWuu32mOZ8JJUGH6pK85URf
 XUQo/LHaHZhxqIgNNhscfht0UrI07pVpRF7Bo6mVrClr+ruPEa2gyQ8XDb29MWaOJHY4
 s7THa7s3bEptRn7rPruGjNxbItfPfdoVATutw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776330946; x=1776935746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBnSLo1WaWdWZNmP/1Y3PJozIxe7e8DbpBRkn5Mt2ec=;
 b=Qmg9NN0lnkWns7bgf7d/9sFNIS6zk9ikcioxBnEl7L0ZqrBWlieYYmvCLuCcrKPwaa
 rL9kGf2hkJpfQj9dVgbQIhrXR5QWvwVnW0q3rYEOYSaRqH8Miiaj/cWl2Nmxgl44HsnI
 0oZQvO0X96A668ahGvZaJ4z81EqWCAuJzjNTOQSsbeJDzyWiYXKq3Gv3WrVJ1UVgZQYs
 eLgfTa4mUTaNGQeFP578ORfHmRutmDKIqrl21gX4S1DM7B8/25LcUylXEUBNUTXmOPcd
 eQng/wizJYW4w+gjPN8zTeSBFnKdY1LGafav8SVhx0I50bYvRRd3pKMB//Hw3aSCHpVj
 MtNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0t+jrqmarmv9cB/83fv7z9YrMI4By7JpfqaCbyE4aBJexz4OCkutZXXlbooBiHDTNF/wJc7U=@lists.denx.de
X-Gm-Message-State: AOJu0YzdqxLLF/6k5kbo4RtPx9VP9059tYbWaYbXB1gGUuzGIcudEjCh
 RdHm6I6ffauyH3npaUF06/UEfUDxtBnhHRhMl7PWBSbnhvcX28M/GQCw+7kwOpHotV/5qgPo5iw
 D2sINDVgZzdjDxT+vkDm7VNi0vRvBtQqH2nEH1fUF6g==
X-Gm-Gg: AeBDiesqmIy6qCpr+1LUDpF4jlM67LWxjUCiCCR8CMzkrnqvWuMRNF5sC4l4ZJtwNEJ
 AEcv2F4Wo2ZUGZOKD1JlwmYuzbQqYgAGaf5KxDdOEfoRx/89RPbiNrL2Emtc5H8HhoZkQ1//rwW
 BVNpcVNd0Ht2McDUXmjshj/qBZWMOw2bm8hq9UTGG0TY0ZKbaVhDQELB9IRYDFD+Bs2OdeGYEBz
 VltG9GF4FjPsG36IyqNmUpz05gzXErcmRpa2JeNb8mBLND0ImTBrggmOd2O4cBf8zBFNQhoEX9F
 ZuuLfhw=
X-Received: by 2002:a05:7022:122:b0:128:cda8:3a12 with SMTP id
 a92af1059eb24-12c34e8a100mr13093312c88.11.1776330945766; Thu, 16 Apr 2026
 02:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <aeCNjtGCY-mlBWwY@google.com>
In-Reply-To: <aeCNjtGCY-mlBWwY@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 16 Apr 2026 18:15:34 +0900
X-Gm-Features: AQROBzChcYLAatxvMIEn0VpSZjD57eIgHBDuj7Vwb5BuZafMnPk9Z_IPBShE6jY
Message-ID: <CAFr9PX=gf9xdDP+H+Ab8o5YtDmcrUML-Z43YXhQTLi2FBUqwfQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add virtio-mmio support to m68k virt machine
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org, 
 u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Thu, 16 Apr 2026 at 16:19, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> While testing and playing around with it on the qemu m68k virt machine,
> I noticed that the date and sleep commands are broken after applying
> these changes.

Thanks for testing. I'll put your changes into v5. I think we are
pretty close now.
