Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B8DE71094
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 16:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB108644E;
	Thu, 21 Sep 2023 18:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PooN0UZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7338D864AA; Thu, 21 Sep 2023 18:29:20 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BBB8642C
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 18:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso1373381a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695313758; x=1695918558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fOE+u9CkqsXO6VyFoHMdGVO/cxveVZ1qgLDLNyYebAk=;
 b=PooN0UZTko++THrXwrPz7ezH+EuRZFJXp4gZi/weblUAA6ryJbTjhgx0NeObPah7sI
 Xm96rdSox2J2K9GVfCea4KQQ+rZYxqIotT4xDfD3HloUzcarJIrwhLgduahc/wroZwby
 0/mCHHrfx8VM2peNwJtPH88k+f4J88KoU6HKRYUHFPK3AuwYqvIHZTNFndGMf/yRkQBu
 3BGLsli43coM4f9jNbSlLmVa/QKg1MESVAtp3aLf9pN3CA9KwbBvue8ksNm1AEN3rB2w
 1EwurD8Ak1uBFeeHhROS0Tv0qDYqEEQ/TkatqDwn3ak8X31LDAtHtwhBwicWZ2GuoWIF
 i8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695313758; x=1695918558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fOE+u9CkqsXO6VyFoHMdGVO/cxveVZ1qgLDLNyYebAk=;
 b=PZ85q6e4Gcw3B53yvnc2PQ9PlmzHjFaII0H99K/yTINy69Kpx8wjf59KikzXxLY5YZ
 AJ+IF3oljDxnmdcLGDFKGUl9GDb1mnIt1H9+Xto52wWJxcDeWE97s8RqIp5rfQxnHdRc
 +dAoz+lWf/5Jx/u9JV7hsGjPaHZQBaJuqQ43YNoE1bupW/LETgd+NGt50oFRS2qPvwqG
 JOhi5ISmQxg6U5Wpsis8mgJFvyg8jS3eXQXeKBF90CSUFIyxyMKQUu8VPW/dGcUtr+42
 q3tzOMkMxI3pcOmkdoVPH2P/dnxvxUoMUSo7kNwowLeFuoilkzJPseIxQaftb7IMpC1S
 gpTQ==
X-Gm-Message-State: AOJu0YwPyU6rWCigpQNOYJxAYZb4+YDREbBQ4TpZD0QWfvUmKC5qAl4c
 Em7WneY4Pm5VhiZx00H+VuN1nHiodI+gHBbDTFvtXg==
X-Google-Smtp-Source: AGHT+IFw6NzPyWzqG/uy6JwqDWfPj5SM7Fhuq6Kw8uNor/s2JgevaDUQgEOp/mMatEsUa3LUrO41Zd7C3dZK0raoUKQ=
X-Received: by 2002:a05:6402:f1a:b0:533:12b1:ebe7 with SMTP id
 i26-20020a0564020f1a00b0053312b1ebe7mr5485056eda.15.1695313758038; Thu, 21
 Sep 2023 09:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230921153720.542101-1-artur@conclusive.pl>
 <20230921153720.542101-2-artur@conclusive.pl>
In-Reply-To: <20230921153720.542101-2-artur@conclusive.pl>
From: Simon Glass <sjg@google.com>
Date: Thu, 21 Sep 2023 10:29:06 -0600
Message-ID: <CAPnjgZ0QSYEAy4auM-COVF0B5Ls5E+8QL3_kYXbAJrm4RYWDpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] common: add prototype for populate_serial_number()
To: Artur Rojek <artur@conclusive.pl>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, 
 Marcin Jabrzyk <marcin@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>,
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

Hi Artur,

On Thu, 21 Sept 2023 at 09:44, Artur Rojek <artur@conclusive.pl> wrote:
>
> Provide function prototype for populate_serial_number().
> This is useful for boards that wish to read their serial number from
> EEPROM at init.
>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
>  include/init.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/init.h b/include/init.h
> index 3bf30476a2e0..e0b7fbc943ad 100644
> --- a/include/init.h
> +++ b/include/init.h
> @@ -283,6 +283,7 @@ void board_init_r(struct global_data *id, ulong dest_addr)
>  int cpu_init_r(void);
>  int last_stage_init(void);
>  int mac_read_from_eeprom(void);
> +int populate_serial_number(int devnum);

Please can you add a comment for this function? You can move it from the C file.

I also suggest renaming it to something like eeprom_get_serial() or
something like that.

>  int set_cpu_clk_info(void);
>  int update_flash_size(int flash_size);
>  int arch_early_init_r(void);
> --
> 2.42.0
>

BTW tlv_eeprom.c should really be converted to driver model.

Regards,
Simon
