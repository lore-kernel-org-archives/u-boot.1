Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EC2D116F5
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 12:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FF583AEE;
	Mon,  1 Dec 2025 13:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvdGdYZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8929083B03; Mon,  1 Dec 2025 13:27:33 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B7183AB8
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 13:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-595825c8eb3so3770738e87.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764592051; x=1765196851; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaaNBfuVXdtj85Liu9TEgpc/ZpuoPZYsjV23+r2I644=;
 b=IvdGdYZpAiaNdTfuyp66DHol8PEbB9P0JyxG3kL6AP/LbWo4Zwp4QpwsngWLa6/Fz/
 cF/thWgwCjYT3sqK094p4eCo83I+17YPnoHHxHgNX0PR+AUDPyVyAo4G6qpgEeoYIGLB
 8KKjpkone2otDfXm4qiFaHJ39lq3JYjW5lxgV5ZxYpODuF5bJ3hZmcgKmtj5QAkQ00P2
 Kncf26fBoSSjDRty2cUqDsDl4BBfsgKijIw88ffDpYKh6YTsIADgBQQ+NgyV9DXuCg0f
 fc88d3Sn2K1TKycPfxo/38joomqFDHdZhoC2RzXi3lvrVu8VC7jYlvIyRAbPzKAT8yOK
 4pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764592051; x=1765196851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PaaNBfuVXdtj85Liu9TEgpc/ZpuoPZYsjV23+r2I644=;
 b=gsLtiHxAeVtEyH7c42gH2221uB/KOIjWws//OrSeOv5x4yxz/FJ0i+eqDDRxdVbNLH
 udosWhXDNXLkSuxHyxaL+qUCww1aN60Eih/64Eb9foYB/D4GQ74wGLNFJjEp4w6r+gX5
 EumJUs4pwdfZ8NGWBp3YfUzYCde1/Q4bHi1bgtBs3sJq4UeUuqZ1N27dU9bkvetu0aOL
 RnlIZLzDQtDIo60La9OnFyjYiIqJ+w1nNO9Qc70AI7FouJyYZ49bbsG/NaSDaFDNY+FG
 1iUDXcFzNLYzO5zeEmwTN+r4I4fUiDaEpw43RuMw8vRWkPZMAI7uArqaJQUHtkmIthh3
 BRjw==
X-Gm-Message-State: AOJu0YwmW2tn+wTmFgnnvMGeRvhC+OC1CPd/vVw2+zXAczaFXIIrLUM1
 lKlQaemnWUDB/d82Hay7EvK37PH7DMtUbzZtFsmQcX0qhhMUt+Gv5pa1kcScp75x+hSkulu7HDK
 uO6BK2iQjxa4oNOZiMZgemIb0eRgnCSU=
X-Gm-Gg: ASbGncvt5T3pa5z0jptVbhc9LhQxfQqMlRRGXDz3TdBnGhApxdAhu+BCjFCuKhYhssp
 iI5DGdyKMBSG/0a00y+s6caqFV/KWyT4z3PC0wGNlrGMMxpPt5EoOYU2xY135JsoiN9pnwjnjwe
 qehATPJfn/HdnFW+mj+EZHTqTrk16y/wb3AnxclFItNdkgPrYRjIVHlBsJ7YlWSf0H0kFCJIlIg
 +br34Z8DwfAs52ERUHn50joVSjlVVf6rEqx9aJbUAjc6IC/52HWaz3peqIl7TH+dVnfr2vCuZS9
 IRi7UpjI2dqhzW2kKSdyoynLug==
X-Google-Smtp-Source: AGHT+IG9lHNgdhkkYsFbHlogG1SXylUqelnXRSdmeBTL1GMR1dxOlcWYcqoVULiEtJsapX5AMT65uJyLao3kPGiQRhA=
X-Received: by 2002:a05:6512:4022:b0:594:5000:4555 with SMTP id
 2adb3069b0e04-596b5277ce4mr8795391e87.29.1764592050428; Mon, 01 Dec 2025
 04:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20251201110034.1968871-1-alice.guo@oss.nxp.com>
In-Reply-To: <20251201110034.1968871-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 1 Dec 2025 09:27:19 -0300
X-Gm-Features: AWmQ_blXbeRPZUv_Rgn-Dyu0AXAo4vfR5nCM2oSu8Hpq9bjMltHlTPJxjzbP1-w
Message-ID: <CAOMZO5ASAXjAzZOTCusDhpVAACDgNQXi+tEuVmT7FLEgyWG8Zg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] imx8ulp_evk: Switch to use devicetree imported
 from Linux kernel release
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, trini@konsulko.com, 
 sbabic@nabladev.com, peng.fan@nxp.com, alice.guo@nxp.com
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

Hi Alice,

On Mon, Dec 1, 2025 at 8:01=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> Enable OF_UPSTREAM for i.MX8ULP EVK so that devicetree imported from
> Linux kernel release can be used.
>
> If mailbox@29220000 is enabled, gd->arch.ele_dev will be set to this
> device for communication with ELE firmware. This is incorrect because
> mu@27020000 is the MU used for communication with the ELE firmware. To
> prevent misconfiguration, disable mailbox@29220000.
>
> The driver model for watchdog timer is not enabled yet, so disable wdog3
> temporarily.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Now that OF_UPSTREAM is used, the following local U-Boot dts files are
no longer used:

arch/arm/dts/imx8ulp.dtsi
arch/arm/dts/imx8ulp-evk.dts

Please remove them.
