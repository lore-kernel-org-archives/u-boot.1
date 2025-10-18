Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2EACCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 20:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17CB283631;
	Sat, 18 Oct 2025 22:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYtEnMgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8F9836B4; Sat, 18 Oct 2025 22:11:06 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD9883438
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 22:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-579d7104c37so3903074e87.3
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760818264; x=1761423064; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DShVlhAlSL8goFK4b4vqmgBbJzrbAT7+mmIgfmzD2wg=;
 b=AYtEnMgq1UBlCIGWD4TTd7DWfBQApN7F7O3ID9PcnhXPM07juKn859cuqBbVx6tb8X
 vbkDgbS3E4rJDAL7sSMvU6+zyso5gXkwJRqfRAzgdIgRc3PJSA7EmOe7ug35StsjlrOj
 9KWKTCzRnShm4WvFdRDAlqxJo7HeM1wVTQnIGvhQuoG9oPpQCAFeuSmtjN9aFgTX3OCU
 dA9bT3TgYPR6sooX/qeyjd25M+ZpUhixbDhx4To2lZC9zKdqwbrzf1a7B7GSdBrx/JAV
 X8IIZ8cJj/HkBvrELj301Ro93NdF4X20u/38Ob/GllY5VjY3zrv2NK5ubh2XWDcD7rpc
 vDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760818264; x=1761423064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DShVlhAlSL8goFK4b4vqmgBbJzrbAT7+mmIgfmzD2wg=;
 b=gp2BkwoOrJOxYgLwftrRgdCXxlcEABJzc5k8QIFLuES8CslSauzXrFJZ0SPg7Q08IF
 LeyAorbVEosEkvS3RFBjJQlEVyEfJ2bFQYI9tAp+hIjsO5wjIBNv8CqeFxtxrRZR+n2J
 U8LdIog24mXPI01OdwU/hV4gTjST8JAQ+wQGvSO48gBKs08wFDS/iRDx0M8GnCmVgv+f
 r23BV67w2uUmew3ektcFcJR0oOjupvE+GyFz0LJUzT+VbGArw8+tyddBkJxRogrBw931
 wl0j9DqnKZ12+SWnx2cd3R49+o0TBhK2O1TZc3OyqJVwmOWD5eoDc3/q+cn+ckU8i2gn
 YMPQ==
X-Gm-Message-State: AOJu0Yya4M+56/zcT0Nc7419d3kBovs/V9lnGwGZTwwu/n/AtIEaOQ0O
 rGumlbtWq1o78o4x02DcYV7g2NKC7SKk3gkt+IgC8/u3NR12vuZxisq0vcLb/ioTGDrL4UEih5P
 rxeWASoQ9RmdKAuiXLBWE9zV4a0a92aR9Ekn6
X-Gm-Gg: ASbGnct90vO3dLex8/A9Bg4Oea1+9Prb60q09NtI2JzQZ7KnrBv1lwx8KRh/G+QZraS
 flRYdw7wRY2a9Dz5UvPXK1CnqqY0Ck8I75Y4kNKAe4HfFijsKhtoTpCrHxkrRIPnSgPpXZyh92m
 vvT1cIVZBHZa7fomFAvINN0y8NtdOStmDBsR1xHNpim8dAo0+dq95QwzHB0ls3i0vE7+7HUUADO
 udrmlIA0lurwTM37BHIU0F+Ga9Ymx4FjcvD0/0cGZ36P6VI8L36sslSNFMKsIr5CckxximE+vMN
 8jQ8/3K5m25Bg+c=
X-Google-Smtp-Source: AGHT+IHMa3MNNBTMYi9Ze8DLyppLOh5gYUznm1GtEpvnJunx5KkpdBPLNZI7STHDrOfEqzjcs27gTaEXgI+506fzR1I=
X-Received: by 2002:a05:6512:15a2:b0:591:c2b9:5be1 with SMTP id
 2adb3069b0e04-591d8557d6cmr2384864e87.33.1760818263846; Sat, 18 Oct 2025
 13:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251015-imx-rproc-v2-0-26c6b3d16c35@nxp.com>
In-Reply-To: <20251015-imx-rproc-v2-0-26c6b3d16c35@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 18 Oct 2025 17:10:52 -0300
X-Gm-Features: AS18NWCWlApI9WOQTnONPGtILLB5E9Ej6tYRUKXE2ESlGKzCYlvuNWY9kV1gk0o
Message-ID: <CAOMZO5B8cT0NPSAtu7pxODiy_=8PD_aYWW1U7+fs_xLJP8cKbQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, 
 Judith Mendez <jm@ti.com>, Ryan Eatmon <reatmon@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Tue, Oct 14, 2025 at 11:18=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> This patch series introduces remoteproc support for NXP i.MX8M and i.MX93
> platforms. Most of the i.MX-specific logic is ported from the Linux kerne=
l to
> ensure compatibility and maintainability.
>
> The existing bootaux command in U-Boot only supports loading raw binary i=
mages.
> However, this approach fails when the remote processor firmware contains
> sections that must be loaded into both TCM and DDR. To address this limit=
ation,
> need to use remoteproc framework ELF loader, enabling proper loading of
> segmented firmware images.
>
> Patch Summary:
>
> Patches 1=E2=80=932: Import memcpy_io and memset_io from the Linux kernel=
 and enable
>              them in the remoteproc subsystem.
> Patches 3=E2=80=9311: Add platform-specific remoteproc support for i.MX8M=
 and i.MX93.
> Patch 6: Temporarily adds Cortex-M nodes to x-u-boot.dtsi since they are =
not
>          yet available in the upstream Linux device tree. These nodes can=
 be
>          removed once they are merged upstream.
>
> NXP internal R-b tags are kept, because the patches are directly
> cherry-picked from NXP LTS tree.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Please add documentation that explains how remoteproc can be used on
NXP i.MX8M and i.MX93 platforms.

Thanks
