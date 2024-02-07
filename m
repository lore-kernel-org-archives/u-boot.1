Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26734C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 14:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D5B087C4C;
	Wed,  7 Feb 2024 15:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RFSIWvIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D424687645; Wed,  7 Feb 2024 15:10:19 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167A887C8F
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 15:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33b3585518eso106425f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 06:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707315013; x=1707919813; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JN3utWBxUO/qEZna1E1ETeZHUEDOXFKmZMan7aczUU=;
 b=RFSIWvIEypn2ecVz1xxtxBkvtKN94kl6bs08wIyURy5r8yHAwIPq8lAt9SIKbgW3lL
 zBftuwu48wQ1VlfO+fpXb94IjsqT8PtT1WQGgT1HO4yRxK9oQyDiBCT/okgnF4425xnD
 n8n71L1WFBrWq3akZlB2MYb/C6ZkeWldwwjZIonPoi6KhhY6E1Up68VmDZhYKbS9gqAr
 ltl0YDiQ6s3iMk7TC8/dwDQhK9RshVLvVg8CbeuuMd8DPulnDn1miR6Gz2h0dC+LU1if
 ZV4aclGD4WHCwc9V+Y2vVi3nox/hJ7dIRwW3xU6mScqgsYgjPxzBNnAH8247A3B15MYK
 nAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707315013; x=1707919813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JN3utWBxUO/qEZna1E1ETeZHUEDOXFKmZMan7aczUU=;
 b=mfMoNIcjUdZ0q7LMDFtoDnJ4Y2alOgtKpBc3LGC13Yowy6agbCoK02TuOujLYFG2ip
 JS3dVPgv6BTw4dOviYcAmKZFMwaXqHt5cr4dRFqVdb8qxfQSZxXm9lgurqSmYX6Ur0C4
 MExg/n0YkAVdnIXrypvOkqTGXgezVpNrOzrD4lMx+SaqZ0gD98/OWOSn2MLnvEKPZpDP
 a0pGIofCtqLycm0XO93HOVOzaEDHNWk7cNOXtz5xeHX9KowFptdNdXRaCl7fQPNEGmPD
 CmXRyEpuigu2OMXV9g+Cct6FH7bBwQy8nbaa5ybWngKH4PirEwDVJjYQnpw+KePLQiMB
 gpIw==
X-Gm-Message-State: AOJu0YyNeUtaxnYOxD8NADU53ovD46RdmJBkWIJswfDkoPgwrovA0QTy
 Pzb3zL3gwkcstUhduscC75/HXMQ4zXf4e1xtMQYK31bDb/zO78JHwwk+8vJUaLgAo8pu7SwYVpR
 7gGLie9bIn6hJq/FYrRfoOV4kOZCPu3hM2YUh2xuw
X-Google-Smtp-Source: AGHT+IFWA6ltc0guPqEHBqDgw+7i3a67I6T+sn/9Zta9osuv8zLlOCYG4wue6z5Y2yO9JmXyCTv8Qo+LHCw9M+1Zk5o=
X-Received: by 2002:a5d:4c8f:0:b0:33a:dbcc:68c3 with SMTP id
 z15-20020a5d4c8f000000b0033adbcc68c3mr4446942wrs.6.1707315012800; Wed, 07 Feb
 2024 06:10:12 -0800 (PST)
MIME-Version: 1.0
References: <CAByghJZqOnV8w4nJKDOjiPVUGkq2KqYS=qxps09744==oXwtZQ@mail.gmail.com>
 <20240207134813.GV1152441@bill-the-cat>
In-Reply-To: <20240207134813.GV1152441@bill-the-cat>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 7 Feb 2024 15:10:01 +0100
Message-ID: <CAByghJbnL=W0p=yu5S_6NChAqobOF6rK92m=Dh_rY5e_=1JvGA@mail.gmail.com>
Subject: Re: [RFC] Drop md5sum, crc32 and sha1 cmds in favor of hash cmd
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, Feb 7, 2024 at 2:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 07, 2024 at 02:00:16PM +0100, Igor Opaniuk wrote:
> > Hello,
> >
> > I was playing a bit with different hash functions recently, and
> > it turned out that md5sum, crc32, sha1 cmds just duplicate
> > what is already covered by generic `hash` cmd.
> >
> > =3D> sha1 0x60000000 0x200
> > sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e248=
3d0e1437
> > =3D> hash sha1 0x60000000 0x200
> > sha1 for 60000000 ... 600001ff =3D=3D> 4ff5ffc91d00a95155518b920f46e248=
3d0e1437
> >
> > =3D> crc32 0x60000000 0x200
> > crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
> > =3D> hash crc32 0x60000000 0x200
> > crc32 for 60000000 ... 600001ff =3D=3D> 6fe352e8
> >
> > =3D> md5sum 0x60000000 0x200
> > md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
> > =3D> hash md5 0x60000000 0x200
> > md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
> >
> > Considering that most of them (besides md5sum) are using the same
> > int hash_command() function under the hood, but have a lot of duplicate=
d
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

Sure. You mean something like this?:

/* cmd/crc32.c */
int do_crc32(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
{
        return do_hash(cmdtp, flag, argc, argv);
}

/* cmd/hash.c */
static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
                             char *const argv[]) {
...
        /* if not true, we are called from crc32/sha1/etc alias */
        if (!strcmp(argv[0], "hash")) {
                /*
                 * Hash cmd is used directly,
                 * Move forward to 'algorithm' parameter
                 */
                argc--;
                argv++;
        }
...
}

>
> --
> Tom

Regards,
Igor

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
