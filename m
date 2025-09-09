Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5158CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 10:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BBA83106;
	Tue,  9 Sep 2025 12:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MuTuIsQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0B58313B; Tue,  9 Sep 2025 12:41:04 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F75A830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 12:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-333f901b2d2so55605131fa.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757414461; x=1758019261; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mmHWljjL4Yc9cddh4b5xPgUkXB+2aR5uoE42ziLQ1U=;
 b=MuTuIsQ7ScCD3jxL0a2MNf6v6hG83LMUb/3IYNP5enoSeop4+goeAOxWSnW+ujWLGz
 9f0G6uu54zqdxVADRqcEtUHvGkV/KkQrXsPCor7EIKp5+2ayApCp7g+eo/D3VshWQmIy
 9pFi78ZYC7dEga0VLzehQooRP7fGzCCG7CjtoNlFTRXjp5pRXTLZnrrgXeyhyUxF9xoZ
 wyroUzKX2UZ8+RlNEVGgmZWCrGkDwE7Z/G5SiUwLBQM2OApHLq2JajC1sTXNY+KTUfSg
 bbBesU9YeyYZM5CV0lkkYVd5/NLgktdx6LO2q6n0MkeaxphjEOY3xj4qF1PTQY+YuwLt
 8pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757414461; x=1758019261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mmHWljjL4Yc9cddh4b5xPgUkXB+2aR5uoE42ziLQ1U=;
 b=I7iB1CGSMRPBbLcoCZL4ex8l5JdKwVN8IGhAI4laA30npQQ25+MC4OuYC6gQaWuiTZ
 9taYr+DwF1kpZqd9oZX8CFo2D5bWzCvn2RuEdImcZMyQLGL+mOTY87tfKRKSyVmVOD8S
 PxZtKBNZ/20lH8sOb4m1//t7nnu2Z2OYaKHeNtvZbaq/RZHfnfhry7r1bYNZC/eWZGlQ
 rAAdkHK7gzgG2ijCjpDuea0JuxAJ32T/2lYjSVNrayFBDBcvoZWoHCu1fEKYhbt01C48
 32KrnLHNnTXX0EeAZt8NtXvW85biLO/J6g2uX0+yFdagBpfdxjN689W/uJNAhYMbxvrz
 Zxdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9/80PbaDR+uzJxWOb5BqhcKe1o8Jvz08g45rD24joqtQekWIIlaPMkbJL1lq/4DyiPq6LSL4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4XITedmjdV5q+ByeYVjkIWVLh1/MOUSuPicnCnnbNOxueB2cy
 VmVZ19NGcWY1XSPi+ZVCpLagJtl+tR2AMgTBKlcB8uFL6uB5iSpenXOKQDbBNbw5k47gifJTRRB
 5Lq9iE++HbkEcLYTMCwyNJEbhMGHYAC50CRO7
X-Gm-Gg: ASbGnctawsbXKuwJfxSATmmRtbBB0IzhIIVRkBYtuasy36urc2hN+8+8KXgNhZf6qRc
 2X5L8lmLYaBAvdlSgooq6wKlANnFt4TQDDPQ5cHH01wqRHMTR+augRsUBknA5z9spYcDxIimpKm
 reHUA1kI2X29b7zoiUdDIcZT68wlDK4Al2KpFiahWGQe9SWTHbsdZaUWUzuwxGOYIyoqAX6ej0w
 QKXRHbIHaAzStePT67pHrgSUMx06t66cNdU1KI=
X-Google-Smtp-Source: AGHT+IEBTAADWAYs4rBIyjp/BdE4QpUhnuh8SkyQu2XJiYBsWO907Js5q4F4jQ7jlDkzykyx8DxXMUo9BfZUOr/dTQ4=
X-Received: by 2002:a05:651c:3248:10b0:336:c0b7:953a with SMTP id
 38308e7fff4ca-33b56faf551mr32908711fa.1.1757414461202; Tue, 09 Sep 2025
 03:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
 <20250908211838.3772709-1-john.ripple@keysight.com>
In-Reply-To: <20250908211838.3772709-1-john.ripple@keysight.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 9 Sep 2025 07:40:49 -0300
X-Gm-Features: Ac12FXzrAckS65U7Hpyfj9jvaiXwqLPB0h5JhehdiUCRa9ucj9zwOY31S5XTLGU
Message-ID: <CAOMZO5B8=3zbb66K3eZnt11HPxuDe_+Vqwy=DJUBcEgqUMu+WA@mail.gmail.com>
Subject: Re: [PATCH v3] imx8: Add ahab_commit command
To: John Ripple <john.ripple@keysight.com>
Cc: peng.fan@oss.nxp.com, alexander.sverdlin@siemens.com, 
 andrej.valek@siemens.com, hs@denx.de, peng.fan@nxp.com, sbabic@nabladev.com, 
 sr@denx.de, trini@konsulko.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

Hi John,

This version looks better, but error handling could be improved:

On Mon, Sep 8, 2025 at 6:18=E2=80=AFPM John Ripple <john.ripple@keysight.co=
m> wrote:

> +static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
> +                         char *const argv[])
> +{
> +       u32 info;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       info =3D simple_strtoul(argv[1], NULL, 16);
> +       printf("Commit index is 0x%x\n", info);
> +
> +       if (sc_seco_commit(-1, &info)) {
> +               printf("Error in AHAB commit\n");
> +               return -EIO;
> +       }

What about:

ret =3D sc_seco_commit(-1, &info);
if (ret) {
    printf("Error in AHAB commit: %d\n", ret);
    return ret;
}

> +int sc_seco_commit(sc_ipc_t ipc, u32 *info)
> +{
> +       struct udevice *dev =3D gd->arch.scu_dev;
> +       struct sc_rpc_msg_s msg;
> +       int size =3D sizeof(struct sc_rpc_msg_s);
> +       int ret;
> +
> +       /* Fill in header */
> +       RPC_VER(&msg) =3D SC_RPC_VERSION;
> +       RPC_SIZE(&msg) =3D 2U;
> +       RPC_SVC(&msg) =3D (u8)SC_RPC_SVC_SECO;
> +       RPC_FUNC(&msg) =3D (u8)SECO_FUNC_COMMIT;
> +
> +       /* Fill in send message */
> +       RPC_U32(&msg, 0U) =3D *info;
> +
> +       /* Call RPC */
> +       ret =3D misc_call(dev, SC_FALSE, &msg, size, &msg, size);

 It is better to check the value of 'ret' and return immediately in
case of error:

 ret =3D misc_call(dev, SC_FALSE, &msg, size, &msg, size);
 if (ret)
     return ret;
