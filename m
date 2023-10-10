Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67B5CD8C99
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1290D86C08;
	Tue, 10 Oct 2023 16:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZQ81do+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D22486C08; Tue, 10 Oct 2023 16:57:51 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C8F82BBF
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so1040470466b.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696949867; x=1697554667; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w+q0byOOa3+p/fCAAr6hYh8en5lJmpuMGarCfLXX1S8=;
 b=ZQ81do+QLqcNiQs953XGP4wiccUr/DG653+XXzfL8P/f2bDuTzllQT/0DU1IUCrYfp
 3RnAWBfwuo6ulX/V9peeqsPxwl4U0Ca1E6HpvjAR1gsB1ROrWFjbh6akhddggqH4Ylcd
 7f+rcI2zezIBaGiLXa9ynFyqx2Cy0xoeV5w9zveOTyFVTUL/Q8dn9k7fAzuA2FmhB8QM
 EtW0f8BIDlJJ4iNu1SRYOZHTYHYyC0lr0OoxWAwkEgekuJfkYanu4T+T2znqK/RQIsen
 M0xv4E59IQARkuZEmZ5uUSd1C7gQLUixe0TrY3Ec6pn/Cts/xXlo/ORnz7Hsv52TCLFb
 0b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949867; x=1697554667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w+q0byOOa3+p/fCAAr6hYh8en5lJmpuMGarCfLXX1S8=;
 b=pzVKH8RDDoSrVFTG+zfSBjBsc95641WDtUVcjje1+PKM8e1KEf6eBWbNXNNxuEMWuf
 AGBCaJBTYqRK6qak898Dj66gGDRyaRhZzmWz4FJPk+qbCXFSkozOWX7HBThedmfsDG1v
 IWWWhX4Vnk3/NLmWlp5AJRDjsMLd/GJ4jyf30ZGeHwCYez2ai9fK2FvLtmMZNoxgBNdq
 Paa3cE3feHTTjsrIQdzS3cRB35aXxRF2LVIswAP88DUPCKCAOxEy5bn4ptgFc37VeBi3
 MUnlylI7hz9ppJT6qrX2zL1FRuGkkkY5vQDygdSTZ7347cpbPK3izGzOs0COruQYSgtL
 jElQ==
X-Gm-Message-State: AOJu0Yzxw5FngJT/draTugbDml7bV+3vG53H6u4LBlvgNHiQ+A1PeURg
 tEiPTj6Wdp1JKfHU53YcnnEK1IMsXQlqVu8SIuhVKA==
X-Google-Smtp-Source: AGHT+IGm1lt0SdAtN0KTQkUf2YIhU8/naxBWvAGpv/+NPrlos4Fqe9vmRL2kAclZhwTJqzIL/HenVVAkjT6f2dXVjZs=
X-Received: by 2002:a17:906:cc4b:b0:9ba:fe6:224 with SMTP id
 mm11-20020a170906cc4b00b009ba0fe60224mr8048436ejb.59.1696949866928; Tue, 10
 Oct 2023 07:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231008015312.1988866-1-seanga2@gmail.com>
In-Reply-To: <20231008015312.1988866-1-seanga2@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 10 Oct 2023 08:57:30 -0600
Message-ID: <CAPnjgZ2K+rHVf1ohmGF2BE74uJFNEu9z00=2botEhfnUEzTc0A@mail.gmail.com>
Subject: Re: [PATCH] net: Add option for tracing packets
To: Sean Anderson <seanga2@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, 7 Oct 2023 at 20:01, Sean Anderson <seanga2@gmail.com> wrote:
>
> Add an option to trace all packets send/received. This can be helpful when
> debugging protocol issues, as the packets can then be imported into
> wireshark [1] and analyzed further.
>
> [1]
https://www.wireshark.org/docs/wsug_html_chunked/ChIOImportSection.html
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  include/net.h | 4 ++++
>  net/net.c     | 3 +++
>  2 files changed, 7 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
