Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36B0FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 17:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3467684659;
	Tue, 28 Apr 2026 19:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l/Ur+Ngd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCD88465A; Tue, 28 Apr 2026 19:58:28 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F188460E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 19:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so20360107a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777399105; cv=none;
 d=google.com; s=arc-20240605;
 b=UNU5A0bUGmeg4fCnRnvUhJuLp2g3ce88WSyy8llit8x03D0JTl7rN+al/+64XK1V8q
 k7Efc+PinDlhBP1wExnY8EOThrLRDYR8wCbJndWbKvNxp7HhECYVKA3OaONWYb6qxNCM
 zYvJDHgY5t29wXHGbCfGtuWC+tMVZBG8modAKOWpwWWC09/cPmuEWezUeP2zREWVWKoJ
 4SxQlprUTy/y66SOgDKaN3Uxa1yi40s3oLAZeVARFyoRps1dTUiHSsNZfJOJ0Gcqg/Dq
 IiPtyeKZSA3TJ9tzOc2zQTDaEn2bQ5oAT0Gg5GKW4YyHZO1OEKxMxMo/sTX+sbpMmWDC
 dDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/0g4MSYEXVP3zTWaEE1wiaeJ7c3dm4uf7QXApVxZWzQ=;
 fh=tI/u//27UWCQW8f0bxvI2Rif5Q2rVLBUBzmF2xkjV7s=;
 b=QnfH1BtUoZG5QYHqPEpBBVClRkM5xmwD+CGYkTxMthwuWuECE1w8H5WxSs3vOwGuyI
 quZmMdcRdmCMPFwI3yRZ2fBkyl48Lj11uvepR7CYvErjbtBSfM+PBA/dK1/lbnnh+C7S
 9Fte6cKFRtsAZRZ3+GOIbDjlxQjXSBzAWvPgehHiFThfOnO7IIRNfrvJtGAcIHtH2kq0
 5vWvFGyuzBHpTJYF5vLFTROKgjSkLjWY4X72Pn0wU7ywBNrAxi8a1b2kVN1MxZt4OhHg
 OWawOHuAeSVSVEMBl4ejVRtir8sWqRCkvouYB2qWpaZASG2fuHOG+6v0jV0J/+cCsUfe
 zy7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777399105; x=1778003905; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0g4MSYEXVP3zTWaEE1wiaeJ7c3dm4uf7QXApVxZWzQ=;
 b=l/Ur+Ngdv1DY1TOcHrq9N0C21/HdKM090JzfC6dv5QmuLaboi3204gUsM4145XzLmh
 xEIyEWZDcoJxsqIyNMgOCZdvk5Bt+ojQGa/fexbupP+Cdahn91AJMHGItuu79+p1evDX
 LvCziQo9nPuimGP5/CSbByKwCORtnyvrbHT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399105; x=1778003905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/0g4MSYEXVP3zTWaEE1wiaeJ7c3dm4uf7QXApVxZWzQ=;
 b=MDqMJvQPgyuBph0dyj3bfUt3b+iF6f8yIvpb3s37ctqXjjAXk7JJMXEaPYZPAtp4AY
 d1sR7EMdkbgT/CKOIfMbCZf6LumEUikE5m8CA8ua/FDwoOC3u6tDYlQ5i3sRjEJNth7S
 uNI4hrZx5wF3zXN30tKfqy4cxQXRZZr7hhTM/lTo9cOUemksaJiNHEydU+Hk5rkEaqLp
 vjyC6hTYOev3TPNcOUa9pKvtsHtu0Yvh2EUNNPzSarHlwhCEEFRpauMZSrvirWJwrCmS
 S/IjM8fbXED/xSHUFfSfTjb5HXzObvcEmFK+I1JzEqz6pRpHKV+SbVnl147aJ6mh6yZW
 klGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8gHqpdZR4S18h3CNtFYuU8VRAM90+ktH+abNkSbyeUaVKxKAx8O98GDZbrLLheklCBAg7Fy4=@lists.denx.de
X-Gm-Message-State: AOJu0YxtHvNZiD7QyUNldKqihSfzZAuvt2iILsaOT7kx5FtRvFvlmEts
 JDkj6sRtJQlJPpPk4G7poIc4yyLd60mluJ/Kw0SikwEexqd78Sp1omZY/DPwSIxH/jIdCbU5+1z
 NqAeFmDRoc2tnR3/PQr5QZGbb+zZqN2pyaOaxxKCxG0OBHnkNBkE=
X-Gm-Gg: AeBDievDEAylBf1XT6CmRNK40o7SMTDMMBOLm46lnNmrGWbAYg4MF/4CsKte89DJpTP
 GyhyqZ7mch7MdQseX5r7iIpCLOB+UKxjHGhlMDPpcfycs0cqKW1X+m/vNrQLLqf78mTj8GqqN++
 QMJ0/xij+/Udit75SLiDFCptHS7//bxNIuF/VYm8J7mR9KxTkNTeGSQUsQxrnaO/mafSfZBZFeb
 wfi8BawdDAn/mBjbTZ+ZkaWc/EdjQhZarQMgdepXOq5bytBcF08923+4j8fqTh2Wu31aSJky6M9
 v9rBPYH79K3TDV6lxYnUfxHp/54=
X-Received: by 2002:a17:907:8745:b0:ba7:670b:f076 with SMTP id
 a640c23a62f3a-bb8020c9f60mr281846566b.2.1777399104566; Tue, 28 Apr 2026
 10:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260422091949.1684616-1-s-tripathi1@ti.com>
In-Reply-To: <20260422091949.1684616-1-s-tripathi1@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 11:58:11 -0600
X-Gm-Features: AVHnY4LZiwXKFnZe5fdmavhq__08XMbTsq58rJMhh9MI6_uYdedQNO8luufZ49I
Message-ID: <CAFLszTi0VKwL6uNY0ONfKob1NN+9-7-m=Basvd_iw18O6955DA@mail.gmail.com>
Subject: Re: [PATCH] doc: board: ti: k3: Add fTPM support documentation
To: s-tripathi1@ti.com
Cc: trini@konsulko.com, vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de
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

Hi Shiva,

On 2026-04-22T09:19:49, Shiva Tripathi <s-tripathi1@ti.com> wrote:
> doc: board: ti: k3: Add fTPM support documentation
>
> Add fTPM support documentation including an overview, configuration
> steps for RPMB provisioning, OP-TEE TA build instructions, and
> verification procedure.
>
> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
>
> doc/board/ti/k3.rst | 83 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 83 insertions(+)

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> @@ -1258,3 +1258,86 @@ Currently, OpenOCD does not support tracing for K3=
 platforms. Tracing
> +Enabling fTPM in U-Boot
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following are the steps to enable fTPM in uboot:

The section is titled 'Enabling fTPM in U-Boot' but the three steps
only cover building OP-TEE =E2=80=94 nothing tells the reader which U-Boot
options to enable (CONFIG_TPM_V2, CONFIG_TEE, CONFIG_OPTEE,
CONFIG_TPM2_FTPM_TEE, plus the relevant tpm2 command configs) or how
to wire the fTPM node into the board's device tree. Please can you add
a step covering the U-Boot side. Also 'uboot' should be 'U-Boot' here
and further down ('u-boot prompt').

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> @@ -1258,3 +1258,86 @@ Currently, OpenOCD does not support tracing for K3=
 platforms. Tracing
> +Since fTPM uses RPMB for persistent storage, the eMMC RPMB must be
> +provisioned with an authentication key on first boot. This requires
> +building optee_os with the `CFG_RPMB_WRITE_KEY=3Dy flag

Missing full stop. Same with the paragraph ending 'OP-TEE fTPM Github
repository' below.

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> @@ -1258,3 +1258,86 @@ Currently, OpenOCD does not support tracing for K3=
 platforms. Tracing
> +2. Generate fTPM TA binary
> +""""""""""""""""""""""""""
> +
> +To generate fTPM TA binary, follow the
> +Building the TA <https://github.com/OP-TEE/optee_ftpm#building-the-ta>`_
> +steps mentioned in the OP-TEE fTPM Github repository
> +
> +3. Build OP-TEE with TA:
> +""""""""""""""""""""""""

Please drop the trailing colon on step 3's heading for consistency
with steps 1 and 2.

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> @@ -1258,3 +1258,86 @@ Currently, OpenOCD does not support tracing for K3=
 platforms. Tracing
> +Expected Outcome
> +^^^^^^^^^^^^^^^^
> +
> +To verify fTPM support is working, run tpm2 commands in u-boot prompt:
> +
> +.. code-block:: console
> +
> +  =3D> tpm2 info
> +  Microsoft OP-TEE fTPM
> +  =3D> tpm2 init

'tpm2 init' needs to run before 'tpm2 info' will talk to the device,
so the ordering is backwards. Also, showing 'tpm2 init' with no output
tells the reader nothing about what success looks like please include
the expected response (empty?), and ideally a 'tpm2 startup
TPM2_SU_CLEAR' / 'tpm2 get_capability' round-trip so readers can
confirm the stack is working end-to-end.

Regards,
Simon
