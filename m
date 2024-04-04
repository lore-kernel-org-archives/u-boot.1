Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0736ECD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B1788445;
	Thu,  4 Apr 2024 14:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aoZrv36+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FBA887842; Thu,  4 Apr 2024 14:06:17 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6130288417
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 14:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e2ae3a3f66so632895ad.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 05:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712232374; x=1712837174; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDBR8Spb5YdfrgD8fPC3n6Dq5cParb0su3coj60EEQw=;
 b=aoZrv36+iFJKbH5UZN/Xs4Oo8sQGwgOGuMSMQzk22Qz6/GFlpXdF17Pf9PFlCQRbPs
 AMBOhuCeynoc28xeUTzEu2+xtPESkhShe1SinpXaEk7fkSzvc3ExAYhvsxRFb9UFRfkK
 95xRj1Bq7jLTmZ0IUqyTQubdZXfRRuJBGF6t1VK6/B7mlnVwxfXaFrmymWDHgrElAyqr
 AvjK+NaRF2M1Abgh56KLvV1bMiOL7xUgmJ+/Ncl3ALYT1jzv1NEAZgRrqOXj2bxQK4uv
 F4oDqxj40S7KfRe1lK1pThGcfv40oZznBg8ijD3ChmccVfGUVnnXdeeSA9VfaMKrztXO
 psPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712232374; x=1712837174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDBR8Spb5YdfrgD8fPC3n6Dq5cParb0su3coj60EEQw=;
 b=Ip6vCtD84/Z9UFTqrpdrdOc66+BlgXjGShPEy0PJA9sPzB5o/EUviZfGwACzrHsZM5
 AU/eCO9L58xqaqJp6D/4O8U4RXWp8/zj00Z6ATkYlfboLmD6HMlbFjtUeYwlVcaXsXQz
 3cuSlgCNsd5983+Z3hcCvy6cnQuq6W9HaFOsTER1PFMGoMtn5yJsYZ3KTiOe4Fex/R1F
 020U+J5ybbo2mpbPKKbV6B8V28fv43wrwT4GLWJDhCknWxJSZrOSsvSMhfvs4F9ujP2G
 cnl7x2VcB9DvbIXnmPAQmFhpV3w+yoiipVxN+w4+SBUAJ93tZGboOjJ8O5HF6nlr8PiW
 vjew==
X-Gm-Message-State: AOJu0Yzl85iG4xrPjGa224k478dmsD0gsQDewvwxUeUMOni+sNzLszKs
 7CKqV7xwH1J06s2uSpBN9cO5FXncL/WQr2bRCoqbDANEhZTpPcL8m/QID8Jf84AnLeWy/+SkOr2
 gUvSNXhJ2SPN8wGOG7X+PVd65QGoS7T7A
X-Google-Smtp-Source: AGHT+IF/AaQObdI/B+XbKxU/2qS5IRFOY8L0xP+uVZKrAqNM3D03tE9zZeIzd5Vqfbm3UGR/NXfGFEHdrxC121u/Ch4=
X-Received: by 2002:a17:90a:ac0b:b0:2a2:666f:966d with SMTP id
 o11-20020a17090aac0b00b002a2666f966dmr2123950pjq.1.1712232373873; Thu, 04 Apr
 2024 05:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240326110656.21110-1-javier.viguera@digi.com>
 <CAOMZO5DYmkp6Wm79bBFv3fFuVWu+LghiKqPkC5kcLnW21Umy3A@mail.gmail.com>
 <DS7PR10MB51676292B8A1A964C453AEF2E03C2@DS7PR10MB5167.namprd10.prod.outlook.com>
In-Reply-To: <DS7PR10MB51676292B8A1A964C453AEF2E03C2@DS7PR10MB5167.namprd10.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Apr 2024 09:06:01 -0300
Message-ID: <CAOMZO5Cq7FL-JY4x3jWunMx9z+hTY974sY03xrG357oP1sXMTw@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: fix signature_block_hdr struct fields order
To: "Viguera, Javier" <Javier.Viguera@digi.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

Hi Javier,

On Thu, Apr 4, 2024 at 8:58=E2=80=AFAM Viguera, Javier <Javier.Viguera@digi=
.com> wrote:

> The struct has the fields in the wrong order according to other documenta=
tion from NXP (see for example the AN13994 - Encrypted Boot on AHAB-enabled=
 devices).
>
> In the current upstream u-boot code there is NO runtime error, as those f=
ields are not being used. Only ' get_container_size`on  `arch/arm/mach-imx/=
image-container.c`  defines a variable of that type. But then it only uses =
the "length_lsb" and "length_msb" fiels, which are at the beginning of the =
struct and thus in the correct position.
>
> On the other hand, we were hit by this problem in some bootloader encrypt=
ion related code we do in our (as of Digi) BSP. We get the blob offset from=
 the signature block header to read the data encryption key blob and due to=
 the wrong order this patch fixes, we were getting a wrong position of the =
DEK blob.
>
> Hope this clears it up a bit.

Thanks for the clarification.

Please put all this explanation into the commit log and send a v2.

Thanks
