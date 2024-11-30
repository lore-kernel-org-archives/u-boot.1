Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C3AD735FE
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 11:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E8E88B6C;
	Sat, 30 Nov 2024 12:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cyr7Ae4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C91A88D13; Sat, 30 Nov 2024 12:04:55 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7E788B58
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53dd8b7796dso2699482e87.1
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732964692; x=1733569492; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJ1/LUoA0YGzRZdCLFXsDES/WquIc7PFUiptNdcZ1sk=;
 b=cyr7Ae4iLrZRMY33hMeE5Rk6Cb9/Ml2qht/l5sT0QUgBVC5EkivGrYr1lQmfFtJ5P0
 8KYhTaopJc6o6Pr+bra+FnGH15DCa2pIKv20cCrAOI9vHaAnEDrWs5ZfSBXePIAD2Ut5
 LEjJCxlyc2UoSqIz5HE/7451VbTazkueSwvWWo1JMre8BS59ql3VIXbU4ZI5KKlJE2z0
 fAH86V7rjAvuUv9K9ZyuKXqKU7fiPqn9Y3Ak9yn0MHlJobEeAkXMlF8nK2VG0OAs4bxR
 VoS+jgiqD2b+2iYJJN8KupplPLnS9enRajvvk7KIKatQnynwAC+jmQj7XDveIBYjLAij
 /5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732964692; x=1733569492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJ1/LUoA0YGzRZdCLFXsDES/WquIc7PFUiptNdcZ1sk=;
 b=WUTbzsutdZhebSr5/wHBQuuYSUbUoRi1rjduAXKs3XA/RmD9vTq/ooJ9IiV9nVce0R
 nudl+iJI0MPBqbvG4CLe1qQeBgCUrAoQ6R1MlQGn0mKTTBgyzO4O/H7C9CfJq06Rb9D7
 x4NYpzH7Kp2G6TqLDpBU/luQFBucN9xF8g2CAsCvx4Dr6JS3Iv8O4vQMVxdz/1AFUvw3
 UwA7pkhwN2zMUzoh3K9TemKwZRYOVVrq7P9XQoCVMaEaO4LjJ65FDhv7tXOeafDGFHZ3
 RcbhIaGClElmB/ZaglxRZV5bJX3PMSIUW4U3r5itSKDkoH7mfhhmLYGNNDn+cu7OfsRP
 +2Jw==
X-Gm-Message-State: AOJu0YzqhJri0HWidyVtSSyS4aC9DLl5pHkQEvgPbJi4TJKx3ZZJZKEW
 GLGI6+DoTSHsT1yF4ikRqu3NsJsQFhdPwQt+cQ2spH1TTiIeXBS40tCjCeSWt0A0BciJ4G4Es/R
 SNc6WMZzsTVSCEyvCMJ4n/ObdP+g=
X-Gm-Gg: ASbGnctxfYSRO784KZq13ILx2eScCsxdoYvrd2NW43D2HVSf1FkeoKAnWbbbJbbMix/
 +ni7/5odlxx9EwUDlcqmvW2aRuCExbb0BlrJ30QjiGWWXh9sxXCB0P/05/viFKqE=
X-Google-Smtp-Source: AGHT+IEDXvOKf7RT44knpVc0kJN67DE5ipuN4zQCS7Lg1IHRcA8mistCCJHtGjuqSnvJNfAyHHMtUy5w5T/GkZMcjqI=
X-Received: by 2002:a05:6512:23aa:b0:539:ea7a:7688 with SMTP id
 2adb3069b0e04-53df00a9f35mr9097353e87.1.1732964692150; Sat, 30 Nov 2024
 03:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20241129001657.219101-1-marex@denx.de>
In-Reply-To: <20241129001657.219101-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Nov 2024 08:04:40 -0300
Message-ID: <CAOMZO5A2wcH5A4PSGpr+HFGJgJyyQbxMJC-4B1pi_cQhHAki5g@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Replace YModem with SDP on Data Modul i.MX8M
 Mini eDM SBC SPL
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, Nov 28, 2024 at 9:17=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The YModem support in SPL was never really used on this device,
> the SDP support is much more convenient on i.MX8M Mini based
> hardware. Replace the YModem support with SDP support.
>
> The SDP can be utilized by forcing the board into SDP boot mode
> by grounding test point right next to silkscreen label U30, and
> then by using mfgtools 'uuu -brun spl flash.bin' once the device
> enumerates on host system USB bus. The SDP capable USB port is
> available on the USB micro-B port on the base board.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: Would be nice to have in v2025.01

Applied it for master, thanks.
