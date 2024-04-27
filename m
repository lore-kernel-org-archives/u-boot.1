Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1CDC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 12:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE0B8828E;
	Sat, 27 Apr 2024 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XsAJgzgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 479028826C; Sat, 27 Apr 2024 14:07:05 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD888828E
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 14:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-36c16ed12bdso11594445ab.2
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 05:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714219622; x=1714824422; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2c0tqoEpTyZfI1QcZ6eZAFWpDLVlcbmZBtxw5pVBEw=;
 b=XsAJgzgl3u8tYxBBTohuJUumyblwFc/wDrl3WPXAO/dRkbcgOQ1/KONVhqYtdnb6k5
 HAUzQyEg5YAyeVbL3kA+va6oP1u7GTS84eUftjw3RHYo6dXGh8skxoBOxp/h0EEY3C33
 fsfE3q5Evto3jR9dTIM475HsE9PoGcgoxwuhR5aeVKIN+PguoUtjK659xqoyuCWkjrrg
 80BBeL3LLoy33Tb7xAtI9arh7t1aNwRWi8lTdoU/+QcnA25pGJdldG7z1FOf7F3WEaA4
 yCz9vDmweO+Ny3JjWbeBkBusdU96iGS0LXFzAvMbyT6PmYSWO3s1UcgYUJ5/bw8iIEc3
 ed9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714219622; x=1714824422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2c0tqoEpTyZfI1QcZ6eZAFWpDLVlcbmZBtxw5pVBEw=;
 b=wDL1Xt3t1ihCEBbvItfC3NaH+hoIrDiL37oYDY7QI7VNgqVLAa6uNyl7Mrt1wKI7yg
 v2gZKFKJHB6tEbeVB424pjZHAKQ1YJC/jvwnhiJH1/zYtPeiLJuQKpb8vJzYoDTUcvq/
 TTw3bFUyj6Ko0dlYied7OldmN0FphqBclWAL8XCrNFkjLk+MXobTGRQEIKjwXClgPEmo
 bDhh8iywhjUlMUuMrpbIufbHjhscWPr4mHJ+Vs+B2+a4/3AL74xTj3kWOobtp1rlr+K4
 0JUvNuRjpfpA9eDn9rO/WxtvR33mKGOdWGt84cu0W1g1wv/RarPizFuo2+e3L4BtDiLF
 PPPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxMkH5ks4w0lq+xXfqxDfEzq7FTzKeL8sXPPF+B+vugvYwfV5tnZi4hqjloEvXhAyCV6puDikJ8S1Y45foyf5IguDY+g==
X-Gm-Message-State: AOJu0Yz4HRJ3QiVTXpHxEthQuT1TyQCkwwqUgW2mMXwYyycuC57Z54VH
 /ZkFB29nfYaaF1jddn6XJ86ovSMsM0NPiQ9sNb+OJ5QRW8nfjRzgPVx5kXc7YNKZ0mqNfeTCXhn
 5ZZ0JwUiwwzG3Wc2dTSWAPl7en4I=
X-Google-Smtp-Source: AGHT+IH9rk7zZL+WO/qn92nLuKIBWyFnxYGTfndpKiP+jTVZK0kGqpXGFS1UGNJ8PZa9dNfPJxP0p94VlD0JLxz8vnA=
X-Received: by 2002:a05:6e02:216f:b0:36c:322c:fb1d with SMTP id
 s15-20020a056e02216f00b0036c322cfb1dmr7701327ilv.9.1714219621827; Sat, 27 Apr
 2024 05:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <52d7d87e-19b0-4474-bf75-33dbbc150c31@denx.de>
 <CANV2PTOQknpnfKsZQC9Tr0AhZgMQOOTTND0T+WMp8pwv-5TNdQ@mail.gmail.com>
 <d8a77dd7-39bf-4ccd-979a-97eedb054b36@denx.de>
In-Reply-To: <d8a77dd7-39bf-4ccd-979a-97eedb054b36@denx.de>
From: E Shattow <lucent@gmail.com>
Date: Sat, 27 Apr 2024 05:06:50 -0700
Message-ID: <CANV2PTPt3Ey9uO5rVdLmaDvQdf=v=JEN52kNhcYbvRWfFb_2OQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, 
 Dragan Simic <dsimic@manjaro.org>
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

On Sat, Apr 27, 2024 at 3:22=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/27/24 3:29 AM, E Shattow wrote:
> > Hi Marek,
> >
> > On Fri, Apr 26, 2024 at 5:49=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> [...]
> >>
> >>> diff --git a/include/mmc.h b/include/mmc.h
> >>> index 4b8327f1f93b..7243bd761202 100644
> >>> --- a/include/mmc.h
> >>> +++ b/include/mmc.h
> >>> @@ -381,6 +381,21 @@ enum mmc_voltage {
> >>>    #define MMC_TIMING_MMC_HS200        9
> >>>    #define MMC_TIMING_MMC_HS400        10
> >>>
> >>> +/* emmc hardware partition values */
> >>> +enum emmc_hwpart {
> >>> +     EMMC_HWPART_DEFAULT =3D 0,
> >>> +     EMMC_HWPART_BOOT0 =3D 1,
> >>> +     EMMC_HWPART_BOOT1 =3D 2,
> >>> +     EMMC_HWPART_GP1 =3D 3,
> >>> +     EMMC_HWPART_GP2 =3D 4,
> >>> +     EMMC_HWPART_GP3 =3D 5,
> >>> +     EMMC_HWPART_GP4 =3D 6,
> >>> +     EMMC_HWPART_USER =3D 7,
> >>> +};
> >>> +
> >>> +/* emmc hardware partition names */
> >>> +extern const char *emmc_hwpart_names[];
> >>
> >> Maybe the array should have fixed size here, i.e. 8 ?
> >
> > Is there an ABI reason to do so? Can you explain further why it would
> > be needed to do that?
>
> It has nothing to do with ABI, it is only to let the compiler validate
> that nobody would index the array with index > 7 by accident.

At least GCC knows this without doing its work again ourselves. How
about a const for the upper limit, where currently EMMC_HWPART_USER
substitutes for expressing an upper limit? You may as well be writing
EMMC_HWPART_MAX =3D 8 in the enum and using that for the initializer
also any iterators with a less-than condition to make it more
expressive.

$ gcc -o testobj test.c -Wall -Wextra -O2
test.c: In function =E2=80=98main=E2=80=99:
test.c:16:5: warning: array subscript 8 is above array bounds of
=E2=80=98const char *[8]=E2=80=99 [-Warray-bounds=3D]
   16 |     printf(emmc_hwpart_names[8]);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
test.c:3:13: note: while referencing =E2=80=98emmc_hwpart_names=E2=80=99
    3 | const char *emmc_hwpart_names[] =3D {
      |             ^~~~~~~~~~~~~~~~~

#include <stdio.h>

const char *emmc_hwpart_names[] =3D {
       "user",
       "boot0",
       "boot1",
       "gp1",
       "gp2",
       "gp3",
       "gp4",
       "user",
};

int main(int argc, char** argv) {
    (void) argc; (void) argv;
    printf(emmc_hwpart_names[8]);

    return 0;
}

Sorry to belabor this and I'm not a professional programmer. Best regards, =
-E
