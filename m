Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12BCC4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 14:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0116987CA3;
	Wed,  7 Feb 2024 15:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qz+1jK53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06DFA87C4C; Wed,  7 Feb 2024 15:16:58 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A0687CE8
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 15:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d09bdddfc9so6965851fa.2
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707315411; x=1707920211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eNPn3x6XUJmymF+Cci6UkKFUZJyh81o2shkuHk8/fNc=;
 b=Qz+1jK53CFSS1xBxKJllQePT8z2FYG7rfyOQsT0SuuLG7Q+Q0bOnQUAQmoUDOnKX63
 WMSMs+n5eWJeAggshAZkLz3Q0NR6W9wo4UkelAI9vmBJ27cLPe6/xg6MUzYf76QSIpc8
 75M/uOCtVsgijbhPBSTT2wql8ONjV3Zho8HxxzUid7K7m7pv3pJt+6V7qPH0N5X4qONO
 jXy581jA9/28L2U4sDlOfNvoO9stN2O7qjBC+fmBH99nLFDbIvBCMUV6FDVasWS3n4Ov
 3k52CQ3IaCsLTbm0hmhq6SXl/7ft1NLzzjRVOl9S595FhXnOm4ufpPkDKO+D0iyyyMOS
 Et4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707315411; x=1707920211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eNPn3x6XUJmymF+Cci6UkKFUZJyh81o2shkuHk8/fNc=;
 b=VZr0P3MB7WaelY+x2phPsAOtV5FlB4AcLB98g3KLiA6r34pL+9WTABoDZumqdx4p/A
 N+xWD93Oo/RTVMTz2N4kVQZYcdwz6kRQDVoTUXyI2MDVapRUAqCnccC7RbkKdGuLJX/e
 P+hmJAzPCe8iBZQslpnIcLZiG/Fnpa11LaaAVIe2eXDqLObHrhJL3slWGJsaTLJHfQmP
 HB5sxIQnC9RtsxtzRcdZKTjyk1kvP04oyL4Z67aIpO2me65u2nqUplTSLqJbGLsaDqmI
 2VS+AXK5r3acflb2OXj6TRCwuLdfgVFISKDpOWYCoInnCgZamsBGOgG+1+b4vX1SRgXE
 f4dg==
X-Gm-Message-State: AOJu0Yy1uxv9acs8m6Ip0PeVIc+H153JEZD/sSJ8zR8PPlIr+XkIWh+C
 aJYSe3yHYGchNU5Um1QVH9TmYmQ23TP+zxmAAV7Bo0AZJYCpijJRb071QoEpm0l3zXo0YfaXQkA
 BDxZJulbCksilztRutU8WMqTpFFY=
X-Google-Smtp-Source: AGHT+IGnmldeHEn/MGtSWqUZd5TUyA4/ZOx9mBCJwQSfHlnM4r3P8UdlNRN9DZM9OIrZ9IkSiQlDkK4tYapNalIFfA8=
X-Received: by 2002:a2e:a273:0:b0:2d0:a9c0:7d66 with SMTP id
 k19-20020a2ea273000000b002d0a9c07d66mr3538457ljm.4.1707315410595; Wed, 07 Feb
 2024 06:16:50 -0800 (PST)
MIME-Version: 1.0
References: <CAByghJZqOnV8w4nJKDOjiPVUGkq2KqYS=qxps09744==oXwtZQ@mail.gmail.com>
 <20240207134813.GV1152441@bill-the-cat>
In-Reply-To: <20240207134813.GV1152441@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 7 Feb 2024 14:16:39 +0000
Message-ID: <CALeDE9MDJZjtMDhbg-vfis1E5uVfYn4WwD1hoPgYWxRiPfjwGQ@mail.gmail.com>
Subject: Re: [RFC] Drop md5sum, crc32 and sha1 cmds in favor of hash cmd
To: Tom Rini <trini@konsulko.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 7 Feb 2024 at 13:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 07, 2024 at 02:00:16PM +0100, Igor Opaniuk wrote:
> > Hello,
> >
> > I was playing a bit with different hash functions recently, and
> > it turned out that md5sum, crc32, sha1 cmds just duplicate
> > what is already covered by generic `hash` cmd.
> >
> > => sha1 0x60000000 0x200
> > sha1 for 60000000 ... 600001ff ==> 4ff5ffc91d00a95155518b920f46e2483d0e1437
> > => hash sha1 0x60000000 0x200
> > sha1 for 60000000 ... 600001ff ==> 4ff5ffc91d00a95155518b920f46e2483d0e1437
> >
> > => crc32 0x60000000 0x200
> > crc32 for 60000000 ... 600001ff ==> 6fe352e8
> > => hash crc32 0x60000000 0x200
> > crc32 for 60000000 ... 600001ff ==> 6fe352e8
> >
> > => md5sum 0x60000000 0x200
> > md5 for 60000000 ... 600001ff ==> e6bbbe95f5b41996f4a9b9af7bbd4050
> > => hash md5 0x60000000 0x200
> > md5 for 60000000 ... 600001ff ==> e6bbbe95f5b41996f4a9b9af7bbd4050
> >
> > Considering that most of them (besides md5sum) are using the same
> > int hash_command() function under the hood, but have a lot of duplicated
> > code for handling params, does it make sense to do some cleanup and
> > drop all them in favour  `hash`?
> >
> > I also plan to extend usage info for `hash` by adding a list
> > compiled-in algos based on hash related compiled flags
> > (CONFIG_SHA1, CONFIG_CRC32 etc), so it's clear what algos
> > are available for hash calculation.
> >
> > Comments/objections are welcome!
>
> It would be good, implementation wise, if each of those commands was
> just a redirect to hash ..., similar to how "load ...." will call the
> right filesystem calls. Does that make sense? Thanks.

Yes, I actually have that one my todo list to basically alias the
individual commands to the hash command to remove those commands. My
intention there was a first step to allow us to eventually minimise or
even remove the use of obsolete hashes etc.
