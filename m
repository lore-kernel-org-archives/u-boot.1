Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC3ACD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F5BE84974;
	Wed,  6 May 2026 14:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/HDIM8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFFD848A1; Wed,  6 May 2026 13:11:57 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73FE48488B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 13:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matteo.guglielmi@gmail.com
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6587cee8b57so7114784d50.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 04:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778065913; cv=none;
 d=google.com; s=arc-20240605;
 b=Gqqn7auDLg+cNmzvIk64DHSB1vufnxdxaGVW+7zjzAi5c+MyHZ1bDy+xx8PFHfBHV0
 hbijySVTwA2bGOyiJsdshIrW7Q+VLn1xGkrrpwoO93W+LtOX845paowTduTBTIkCQYKL
 BIQ+c2nLW6r6rN7NaD1fwn6ZvjGqUOqgooJZvOhIQQwU+amZzogoeKiALuY2aL1u0QyG
 LxVe1mrx4WmtiOLnrryPiF8jgetGVaQVbsOow7nhIKWhNoG+iXDl87u8hflGMcPxHk7c
 980FR8tEmlnqybZXAa8MYtE+P7nmK0lb0Lh2MkM1EqzZs9pxmEwkTt0Aw/lOJo/A8poV
 uynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x7nrz0SY7dsZ+hnUMWV+YZInKphwvNoqxvZLrnZ8sN8=;
 fh=+6qlcApFAuRBtMtxf2g/FYYcKNS/xsDFYX5vTyW+ySs=;
 b=lCNYbJvfF/ZBtN8oxoRswWSnds+WugtEY8uszh96TqHSTz/fw3Uc89qp22+Qc3Yurp
 CTFoYHtuYoeJfV3mSpvaUTBsnLT9MEfnIw+W5EC5muVTfpqzDVGpHcJa3XgmzjBFOw8I
 c9CLv3FjJszx4E5908GKHTyviHSQIEalqAepWWt3ttw0g5hHPXBkutiztEKPK7OsfHJg
 Ft0I/mkO37MPxZpblWLHwINg4AGlsDlygO+PCUFMw5bzP4tMX99JTEgY90jPifOVGsY4
 vbow5pnVrNpBMTwAUlPJeZpszNoxYO6NNZ9u0KMevSrl7dymagoyiVMrrbgeXkKMRPVj
 Utyw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778065913; x=1778670713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x7nrz0SY7dsZ+hnUMWV+YZInKphwvNoqxvZLrnZ8sN8=;
 b=i/HDIM8NEZp72D8e9A2zcPLwOUJsRvYE3AZBSGHwUT48zBadhODf7lPKN38W72MBhT
 DH9PmVhj+pdNKHlkWLa8sJ81Sffo1uSllKKhbAe01M5DgNNodeLInQHenReLn0/bRW3A
 jtGZiA++W8qGYIhRCHJTcQ0EiZk3g+iVR2YnogJbMHqmZL/5No+t5ZxQRlDmrQaPjkaZ
 0KSrLWuTyogF/JJkzBEVvP8ivtdtWSMkZobtvqeijk7KOs3m3QuRvYL0dyedO0yvo8On
 1t+9vds2TiOxn1TNIkWcsMDzdpHrP3pU35M9QCoPYfBFy0bKnz+EaRXlgn6GrpE16JeN
 L02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778065913; x=1778670713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7nrz0SY7dsZ+hnUMWV+YZInKphwvNoqxvZLrnZ8sN8=;
 b=MX5JE7H7TteXUHEIx/vBal3tib4oDUZN9wSJ7QqAsZ+GruCTqQZ9Ou+5d4g5vyskRS
 JROwHJuu326V8dZ+bvqYVcKqQNkZfnPJSBcpdIqcw4UGVyfH4jkTrMHHU1p6MI5r/Q7+
 B+pzybnK7PZ6y7mVTe7y0NR7E6lHAsCb84bJ/M4884wXyj38TFAD3vTj5BVp21snntWW
 xRTnz6nlcDj4jm9b/lYEq2l4Y8Bwt+JsyI9DK5SmG5RxosIpvlGKuZQcBPrTEJza/m+x
 Hy/AVwqvSo9dOMivZ+GYkPPOEIOBDeKO3CivonaVAB00DrI5U51Ob481O6ECnIfmmRvY
 85EA==
X-Gm-Message-State: AOJu0YwovGtsjQ+FJ0cIbimMnqoXUDvU0iSur/JSD2S2Ja0lg4e7LHVt
 vAJTdDpq57XTvfXhPwsTWbQl4uDy2Wz6eofZVI0A/2DqezpLAQudBaE//vhMxOVoTH4uHpK7DvO
 SC0IFDQP6scRpjxYZ2FuTrhht3sF0vPhiqrUb
X-Gm-Gg: AeBDieuWbzES0AbR+wkH+OJ1NVuWVVWMBpr5MnsHpFNuR197P4rUWGymTaB8Z/SVy8B
 s3laSvij5ZZea3HMQ+TLrn3SDa9mkvoPtU/imKmTYYQnhoK6ltiNmbtHaP9MVcSzi9dRN7TaXw1
 hrEv60p3xOGthXewCn9jr0VC18w6mtS1k4+R6Tp39ZgjyZBOR7BZF9CigQhJI9dK7PklSQpTkn4
 y9icZzuywuRlf+RsMOv8Zoq08C9/UVOIdNvz5NrFCko3w6eet4/arT9bIy953qTh8GzP1TQ7/DX
 jE2v/EPAvrDEfEQ=
X-Received: by 2002:a53:acd2:0:10b0:654:ea8a:f67 with SMTP id
 956f58d0204a3-65c7989162dmr2618622d50.9.1778065913056; Wed, 06 May 2026
 04:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABVgzFqe4Wj8DGJHFfwHgYy-As57CnmROXuyOnMhnEBwvJOZdw@mail.gmail.com>
 <CALeDE9N5WTKjqnFPxr=4ASAR6KCDVpdf8Se0viuLVVjyeTWV9Q@mail.gmail.com>
In-Reply-To: <CALeDE9N5WTKjqnFPxr=4ASAR6KCDVpdf8Se0viuLVVjyeTWV9Q@mail.gmail.com>
From: Matteo GUGLIELMI <matteo.guglielmi@gmail.com>
Date: Wed, 6 May 2026 13:11:40 +0200
X-Gm-Features: AVHnY4KujUsUSna6yA-YomWWh5hOeXUU9CEWfRLsAeLPktpj9MCmGQtcNI3v0DA
Message-ID: <CABVgzFrV=F9QFs_dCFnxQN=aj4h_xjui8KmHuO9obVNyb9odUA@mail.gmail.com>
Subject: Re: Raspberry Pi 4 Model B Revision 1.5 and U-Boot >= 2025.07 stalls
 issue.
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 06 May 2026 14:46:02 +0200
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

Hi Peter,

Thank you for your prompt reply.

I ran a git bisect between v2025.07 and v2025.10.

The first bad commit is:

bab54f5942c428be698216224fd10b91d974d4da
net: phy: Do not do CL22 phy reset before ethernet phy driver probe

Author: SkyLake.Huang skylake.huang@mediatek.com

On Raspberry Pi 4 Model B Rev 1.5 / board revision d03115:

   -

   v2025.07 works
   -

   after this commit, DHCP still works
   -

   small TFTP transfers still work
   -

   larger TFTP transfers, for example start4.elf, stall with repeated =E2=
=80=9CT=E2=80=9D

The bisect test was:

setenv autoload no
dhcp
tftpboot $loadaddr boot/vg3/boot/start4.elf # MY LARGE FILE FOR TESTING

The same test succeeds on good commits and fails on bad commits.

Thank you.

### BITSECT LOG ###

git bisect start
# status: waiting for both good and bad commits
# bad: [e50b1e8715011def8aff1588081a2649a2c6cd47] Prepare v2025.10
git bisect bad e50b1e8715011def8aff1588081a2649a2c6cd47
# status: waiting for good commit(s), bad commit known
# good: [e37de002fac3895e8d0b60ae2015e17bb33e2b5b] Prepare v2025.07
git bisect good e37de002fac3895e8d0b60ae2015e17bb33e2b5b
# bad: [a7d1214d2c9a38af3a9a1271dd8388068cba904c] bootstd: rauc: Fix
potential memory leak
git bisect bad a7d1214d2c9a38af3a9a1271dd8388068cba904c
# bad: [d1b6489ef11bc89145e9fcf1d0f05d89a934e410] kbuild: do not overwrite
.gitignore in output directory
git bisect bad d1b6489ef11bc89145e9fcf1d0f05d89a934e410
# bad: [8aa384d01a079ec2d816f7051a7208a337727338] expo: Rename x and y in
struct scene_obj_bbox
git bisect bad 8aa384d01a079ec2d816f7051a7208a337727338
# bad: [24e7625085ee14a55275e2fbdaa5e595af1d632f] patman: Add a helper for
managing cseries
git bisect bad 24e7625085ee14a55275e2fbdaa5e595af1d632f
# bad: [24776ab2766787d9629e7250486a0a662871b070] patman: Move Patch and
Review to patchwork module
git bisect bad 24776ab2766787d9629e7250486a0a662871b070
# good: [da24eb55327978410f5559f44ce1434ae8d8932d] Merge patch series
"BOOTP/DHCPv4 enhancements"
git bisect good da24eb55327978410f5559f44ce1434ae8d8932d
# bad: [f74c6f9a81de1c0c04c578b0e6e2d8b1303d6d43] u_boot_pylib: Improve
ANSI-colour output with backgrounds
git bisect bad f74c6f9a81de1c0c04c578b0e6e2d8b1303d6d43
# bad: [96b0a77da0e3877308effd3d916c779fb3deb9df] binman: Read the
skip-at-start value on startup
git bisect bad 96b0a77da0e3877308effd3d916c779fb3deb9df
# bad: [bab54f5942c428be698216224fd10b91d974d4da] net: phy: Do not do CL22
phy reset before ethernet phy driver probe
git bisect bad bab54f5942c428be698216224fd10b91d974d4da
# good: [44340456475da953a30c5cc4fbe8a9bc013c8c0f] net: tftp: don't call
stop callback from UDP handler
git bisect good 44340456475da953a30c5cc4fbe8a9bc013c8c0f
# first bad commit: [bab54f5942c428be698216224fd10b91d974d4da] net: phy: Do
not do CL22 phy reset before ethernet phy driver probe

On Mon, May 4, 2026 at 12:55=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:

> Hi Matteo,
>
> > TFTP downloads in U-Boot >=3D 2025.07 on Raspberry Pi 4 Model B Revisio=
n
> 1.5
> > stall during transfer (continuous T output), while the same setup works
> > correctly with U-Boot 2025.04.
> >
> > Please note that U-Boot starts correctly, DHCP works, and small TFTP
> still
> > works, but large TFTP stalls (e.g., kernel or initramfs files).
> >
> > On the contrary, Raspberry Pi 4 Model B Revision 1.4 does not have the
> > stall issue and can download files correctly up to the latest stable
> > version of U-Boot (2026.04).
>
> As far as I can tell from PCN [1] the only difference is the dual RAM
> chips so I'm not sure what difference there may be and I only have rev
> 1.1 and 1.4 of the 4B. Any chance you could do a git bisect between
> 2025.04 and 2025.07 to work out what change causes the issue?
>
> Peter
>
> [1] https://pip.raspberrypi.com/categories/560-pcn
>
