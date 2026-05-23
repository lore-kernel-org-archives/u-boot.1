Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD18CD5BB8
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 23:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E85846A7;
	Sun, 24 May 2026 01:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pOYl2Zop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8772D848D8; Sat, 23 May 2026 16:36:08 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB488489D
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 16:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c80167f56cdso3728281a12.3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 07:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779546964; cv=none;
 d=google.com; s=arc-20240605;
 b=QWn6VnqjUH944HssNwK0zgIAJBpGx3VaZExDAhjiSCIExeLTlImCAyv2ChEdgcyoRz
 3NRVBc612g0jHVDUftaZ74eDEY7SVy8Ga0261B76d+8MgfaH/dTg/KMK1RkvB3TDoBl9
 YacBCrxqIZ+LCW0imwte/5UueSHUrrtg27uwwxPVoP14MUgRsVbkSwsDmbC9OyjIq6vn
 fjRLC7mPG24iW7FRKBJwA9zITZHLVpU3vdJJt4aF5Dub1Wya9nMujI8xdmEBYd40+2JY
 yZQLkSgembYnIJiD6X9+vk1KL40UjGmxS9RZi/TBs287QnNWtdfItISKzylxKzMTivHR
 Vpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wHXYPd5CeHdPO1XM+lxjv5k9ZR739qSzu/1tgz+NzeI=;
 fh=SVhMijhiPBO2xqSBk/z+Mx9c/OIw2NJUiA37JQWdQAE=;
 b=UVY9GeNplqidMSEvrfah4yccgvxHTA8LPWNHcxeD9waFyBckiyWCxqbIxvXG5juvSS
 wNhaVyUy38VfSoKpDrTdkcIzb8EFHVrPprwkg1t5htK7MrOQT4TdlhQTB16mYqOOixX3
 MKNj88dGJepfshOYMKEfz0wGNPnTzK9DMZOeDe40ufar5cNCPqFu+FpukXg/lkhS5dCP
 rC0Iz51PfZBukLcODukBcpbGLHLWbklkSSFbGyrMpc6hNo2pCc+Vx2QXjZTCaOBo1rqg
 wSim9LAcU3RFgQ3uQoC+3lD0Bo8QU+BJdTiP0lZYB82Rgz4zhuSq+3pEib5sH72TZ8rL
 K2IQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779546964; x=1780151764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wHXYPd5CeHdPO1XM+lxjv5k9ZR739qSzu/1tgz+NzeI=;
 b=pOYl2ZopdTRXeYQ+wJMfMwe39dZJ/u1jUjtsN+x5beCh4j1QUJ0eRNslFJtnK/26sD
 7wneppOdxAtabgpjXGRBQvprzD+x4PSqajpnDaVGBR97ob5qB0neCKgwuekltHUdTGeF
 TCv5ygBf8HiWlkQgs0hWIz5/8DZ991MZzu46eXRTcXE4iJ0oS7rF0tG/WZuptiQ5w3tq
 Np17EAQWNAjBSVoQt7FrIrmjEafLv2nUQ5qk76RwHNHZwkSLQRii1LLPZPmykzUOQha/
 H9jtIi0TP6QOrcMEkqxjd2XY/61l9vG3KdMhkXzt2aqdCUf+2W6UDs+TXmFMXFxKThN8
 TMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779546964; x=1780151764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHXYPd5CeHdPO1XM+lxjv5k9ZR739qSzu/1tgz+NzeI=;
 b=UvmlEhIMuN/ABu3P6+tuL6ELE0rX6mJ7P4f2L/8fY3rQajX9Cx6ARHBb1k3PDYdVfC
 ekx/WVheMdTPRpnnS1CXJ52eXQCC6p+fJJDUG+31XrCGxn+odmLN3VSMJ8MJpslxSlJM
 lqqGuULVZIDVR7sZQjloIyJVI6QEcLyFx/m2eXIcwDUlEW4gnqVRQHmaVJAtCsUW0GVV
 fdqcF/evkTA8SKuzI5PYXX0yOaN3nzrePe/SkLxd34EUtGYkteQ/8GDcx5BpXLkB/1ih
 F4pGssYbA3/InFRuiFVFqOlkISH0iAzLSqjM8YBWZuIfY7moKVe94SNszSwszWawJu6Z
 j5bA==
X-Gm-Message-State: AOJu0Yz1TsCJTZj+je1MuMvnd8DCvktLTGGgjkxr0Ok0GCEAPB4PbDjP
 lsHRq7GZrlITPAjrAv/M9SHVcT1PxMnsPEhm4Bn8PxclllTj05YSLO6d/mJD6gDcJUntYkCHUzj
 lUJ88tLpc340fygE73hP3lOhgnCTdOH8=
X-Gm-Gg: Acq92OFluCS4huQ3/3wb37i7IPi61qLl3dJ/QxLmaBtQ+Wf3XyBfFaXu9ZB8aenci6f
 grEFvYSIpYhkAyUiIxjGf8wWBDcZnpq4musfTcTqXSl8NS3XIvMzZOJueYUdJEiA3culxyzvnBl
 0jCB9iO5k/wq4PJHMENZtyG/tOK2VbAf2Oi019lH6rk3fN+QvBZL73i7fjBTCj7mmza8ApmI+NO
 q8UVMxP8qxrjKzHlDP+KxulHBWumadZNztaCZvdZ+ehOy2vq/NAc6xDJtC7lIBkfSvBBQXE3HP3
 9PsXGJ/hwM3SYf4fIYaegv00TIaRx1Lcbpui5Dr2m2O+mA6txsxXnCIpWH9tjmHANhhSXO6p3RV
 NZhla1H3h4LFtMis6bG7GdY3TJF0v2fxCf26Cim+p5Ts2Y6PVrWqPbcIgv/JHVQAxxDqWXFGh2c
 qEJ5ik
X-Received: by 2002:a05:6a20:918a:b0:3aa:c93b:6266 with SMTP id
 adf61e73a8af0-3b328c98e37mr8010238637.19.1779546964427; Sat, 23 May 2026
 07:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260514181854.399679-3-allan.elkaim@gmail.com>
 <20260514181854.399679-6-allan.elkaim@gmail.com>
 <4c039e22-4766-4b43-9d01-2f0a31b556fc@bootlin.com>
In-Reply-To: <4c039e22-4766-4b43-9d01-2f0a31b556fc@bootlin.com>
From: Allan Elkaim <allan.elkaim@gmail.com>
Date: Sat, 23 May 2026 16:35:53 +0200
X-Gm-Features: AVHnY4JhAljZQ6XAX3j3KULwdE5GMC8EgnQaXGA-EU7NvoRNvRGZZ6ERc3fNKsQ
Message-ID: <CACgNL-HemH0x5KwYr7-X1QT=DxJ=QL-OQc0jKpFZnQJ_340wDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/squashfs: add sqfs_dir_offset() error checks
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: u-boot@lists.denx.de, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Sun, 24 May 2026 01:01:46 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Richard,

Yes you are right, thank you for catching that !

I'll publish a v2.

By the way, I hope I'm doing this the right way, it's the first time I
contribute to a project via email.

I'm more used to contribute through github/gitlab's PR/MR, if I am not
doing it properly feel free to let me know !

Regards,

Allan

Le ven. 22 mai 2026, 15:29, Richard GENOUD <richard.genoud@bootlin.com> a
=C3=A9crit :

> Hi Allan,
> Le 14/05/2026 =C3=A0 20:18, Allan ELKAIM a =C3=A9crit :
> > sqfs_dir_offset() returns a negative errno on failure, but three
> > call sites in sqfs_search_dir() use the return value as an array
> > index without checking for errors first. If the lookup fails,
> > dirs->table is set to an invalid address, leading to undefined
> > behavior.
> >
> > Add negative-value guards after each sqfs_dir_offset() call so
> > that any lookup failure propagates cleanly as an error rather
> > than producing incorrect results.
> >
> > Note: the corresponding sqfs_find_inode() NULL checks and the
> > heap exhaustion fix during symlink resolution are applied in
> > separate patches.
> >
> > Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
> > ---
> >
> >   fs/squashfs/sqfs.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> > index 07e2bd82..430e9bac 100644
> > --- a/fs/squashfs/sqfs.c
> > +++ b/fs/squashfs/sqfs.c
> > @@ -496,6 +496,8 @@ static int sqfs_search_dir(struct
> squashfs_dir_stream *dirs, char **token_list,
> >
> >       /* get directory offset in directory table */
> >       offset =3D sqfs_dir_offset(table, m_list, m_count);
> > +     if (offset < 0)
> > +             return offset;
> >       dirs->table =3D &dirs->dir_table[offset];
> >
> >       /* Setup directory header */
> > @@ -627,6 +629,10 @@ static int sqfs_search_dir(struct
> squashfs_dir_stream *dirs, char **token_list,
> >
> >               /* Get dir. offset into the directory table */
> >               offset =3D sqfs_dir_offset(table, m_list, m_count);
> > +             if (offset < 0) {
> > +                     ret =3D offset;
> > +                     goto out;
> > +             }
> Don't we need to:
>         free(dirs->entry);
>         dirs->entry =3D NULL;
> here?
>
> >               dirs->table =3D &dirs->dir_table[offset];
> >
> >               /* Copy directory header */
> > @@ -651,6 +657,10 @@ static int sqfs_search_dir(struct
> squashfs_dir_stream *dirs, char **token_list,
> >       }
> >
> >       offset =3D sqfs_dir_offset(table, m_list, m_count);
> > +     if (offset < 0) {
> > +             ret =3D offset;
> > +             goto out;
> > +     }
> same here?
>
> >       dirs->table =3D &dirs->dir_table[offset];
> >
> >       if (get_unaligned_le16(&dir->inode_type) =3D=3D SQFS_DIR_TYPE)
>
> Thanks,
> Regards,
> Richard
>
