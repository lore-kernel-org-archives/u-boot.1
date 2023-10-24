Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F24C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 15:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D288487019;
	Tue, 24 Oct 2023 17:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qGRkQSZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44938701C; Tue, 24 Oct 2023 17:06:12 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F0F87009
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 17:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a62d4788so7287342e87.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698159969; x=1698764769; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RL7gJBXVCAh6pmXR4RO/0jzq2sXsuK+l+cFWGSwZgto=;
 b=qGRkQSZ/NELvwlmfDF8bX7mGyeyw32eN1Fx98yBC3rVn/4LiL0iN08aHipa4tJlc+d
 Lj7rSkgVVsgQnpktxDQgPxUTHzXmylZK1d3LihNHUNTnQgxLWCIFLGA3W23EduQ4+Q9y
 RtO8CtxUYSmLhP1E6R9DNzdDTjuf5T07Qi5hkTQMeOHxm/aXdG81piy71gCif6T2xci3
 3Tdqo++1Z3K/RYOeaWcop79jIIyxHcZx5GUBZ7PlykzYor8XDJp2EMAGnoqTT1UImMgC
 pm00EX77aN2dYM1t4fz5FOROb7a3TqrxfQsfa7FpvDR/d/y75fTwczgCJlXWtWv8iwO8
 KJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698159969; x=1698764769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RL7gJBXVCAh6pmXR4RO/0jzq2sXsuK+l+cFWGSwZgto=;
 b=m8f/UddmVi2X9PwPcK5xr+Uo3XPN4Cenqe9SAKy6Nn2cEF4S/oZ2BKIAT7rMvzg232
 SqalGrK5leVUQDiWR3Bzi2FU0C15mT7PMCXSepzbYwNU/tQ8tyeOaHl4laSXUkOyDid7
 CTYTIAoUivrnOLIkqGP7CEvSHOTYqox2MqfnpWI3uBWL8Dxozb1BfzOqBhp8TJLC8XH7
 B4Dqjd87aFx1GCBI/49tIIKfMj6Zur1iCwPcgID6AMOx5MxlFAHxuXE1wmnUI03Q1ZON
 I5Gj09mgVdv7GZ8P0gpDCTPCYQeX8iTvdLch7QFQmgFhDjfPf1xsI/4slxITMTjIgxUm
 Q8oQ==
X-Gm-Message-State: AOJu0Ywm4Fgm9jghK4Az5yPQGmZ1d5I6LUfWj67R8I6aIh+LpcC0vvZ0
 d4zbtH11ga0uf/fBBCq5bYi0drmGk89h037srVT8zA==
X-Google-Smtp-Source: AGHT+IHcLFwRGUNl6oKpAx0w1kTWgzFZx8mex+hvDjxr+m9anepZcGxEP4Yx3e9kp4ruceReVj8FE/sRMnu4LD1LYEw=
X-Received: by 2002:ac2:593b:0:b0:4fe:7e7f:1328 with SMTP id
 v27-20020ac2593b000000b004fe7e7f1328mr8727756lfi.16.1698159969184; Tue, 24
 Oct 2023 08:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231024011828.GY496310@bill-the-cat>
In-Reply-To: <20231024011828.GY496310@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 24 Oct 2023 20:35:58 +0530
Message-ID: <CADg8p97LUPHUqwhNnOmcD1Ev57SjXxqiLCKjkT8EsYS2OuACWQ@mail.gmail.com>
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

hi Tom,

On Tue, 24 Oct 2023 at 06:48, Tom Rini <trini@konsulko.com> wrote:
>
> Here's the latest report
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Oct 23, 2023 at 4:40=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
>
> 16 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 6 defect(s), reported by Coverity Scan earlier, were marked fixed in
> the recent build analyzed by Coverity Scan.
>
> New defect(s) Reported-by: Coverity Scan
> Showing 16 of 16 defect(s)
>

<snip>

>
> ** CID 467053:    (RESOURCE_LEAK)
> /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> /tools/mkeficapsule.c: 859 in dump_capsule_contents()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467053:    (RESOURCE_LEAK)
> /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> 853                     empty_capsule_dump(ptr);
> 854             } else {
> 855                     fprintf(stderr, "Unable to decode the capsule
> file: %s\n",
> 856                             capsule_file);
> 857                     exit(EXIT_FAILURE);
> 858             }
> >>>     CID 467053:    (RESOURCE_LEAK)
> >>>     Variable "ptr" going out of scope leaks the storage it points to.
> 859     }
> 860
> 861     /**
> 862      * main - main entry function of mkeficapsule
> 863      * @argc:       Number of arguments
> 864      * @argv:       Array of pointers to arguments
> /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> 853                     empty_capsule_dump(ptr);
> 854             } else {
> 855                     fprintf(stderr, "Unable to decode the capsule
> file: %s\n",
> 856                             capsule_file);
> 857                     exit(EXIT_FAILURE);
> 858             }
> >>>     CID 467053:    (RESOURCE_LEAK)
> >>>     Variable "ptr" going out of scope leaks the storage it points to.
> 859     }
> 860
> 861     /**
> 862      * main - main entry function of mkeficapsule
> 863      * @argc:       Number of arguments
> 864      * @argv:       Array of pointers to arguments
>

<snip>

> ** CID 467045:  Resource leaks  (RESOURCE_LEAK)
> /tools/mkeficapsule.c: 859 in dump_capsule_contents()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 467045:  Resource leaks  (RESOURCE_LEAK)
> /tools/mkeficapsule.c: 859 in dump_capsule_contents()
> 853                     empty_capsule_dump(ptr);
> 854             } else {
> 855                     fprintf(stderr, "Unable to decode the capsule
> file: %s\n",
> 856                             capsule_file);
> 857                     exit(EXIT_FAILURE);
> 858             }
> >>>     CID 467045:  Resource leaks  (RESOURCE_LEAK)
> >>>     Handle variable "fd" going out of scope leaks the handle.
> 859     }
> 860
> 861     /**
> 862      * main - main entry function of mkeficapsule
> 863      * @argc:       Number of arguments
> 864      * @argv:       Array of pointers to arguments
>
>

Both the pointer and file descriptor are not being freed since the
process exits once the dump_capaule_contents() function returns. These
can be marked as false positives. Thanks.

-sughosh
