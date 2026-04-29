Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96F9CCFA13
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 17:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8168D848C3;
	Wed, 29 Apr 2026 19:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c2YEmasA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F301E848C5; Wed, 29 Apr 2026 19:15:13 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FF9848B6
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 19:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bb962ce4dcfso173219266b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777482911; cv=none;
 d=google.com; s=arc-20240605;
 b=N1Y/JRzEcW/jrb4wrUEvMcSGPJIvlY5P+ZpJJrHweqqWKAqKyjivjYap1487j9TISn
 xZjYQa/Ag7ci5rMoZFpDhYwoLfzC8rQ0brmEBq0hRyIGMPwRQKU5ZS8VF7GP6pirEPnk
 6EwQvlSintLUHdaRnQm89iJjtxh+r9ftH5tG87QhP1vmf0a1fTQ9qm4OtbRbuduTcMRE
 ofiTWkvZjVCLLiNPb6uewbs5NsBadVaw/aGDLckUZqqvoLv2MZnTRRQYo52lQIBNkKy5
 /cPiEftnP7fkh8qm8eEvEJsk3Iy28XQEZhXOZgamwBveXBnbZ3BeeHcAnHmpZFSz+yBS
 wjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=stIoPaBQ2ySWsfc+zh8kFUZrrJKDrRsXOfTYMlUjWZQ=;
 fh=+/pNFDyGYsDJMoXpsFeigOK5l3QyGzKdfAevrQne9bY=;
 b=lT1pWgMuItbKs8N0IAVPZ17Gc143Dl6VMeaS2YU9jf6pbNz9yW6HnHWPWpb/Fd3eWb
 yZDQhOIHx5KUQ0CmXujaIPkN8V1uBEj2jBcs23TMEjK+FybzcfAilL9sP+8+KalPZPza
 XbxHy1E4dSmXZWjZM127/JFboXwUazLaYs8WYvfLXiyDjr6kvfBaG7+XKqJL8tW6f2vu
 xtNQG/obaG9BpI4+3F+F+szSA5RX+2HSH3OIwMYTURgcr9nT97DG1xRmEazrMxrCRL9W
 OqFMfH4BpRWgwMhbOWDe+DYRvvfu5GdsBz3sdGa8fnZKd8ARnyZdKhfZH004SJvDvk0N
 vpig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777482911; x=1778087711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=stIoPaBQ2ySWsfc+zh8kFUZrrJKDrRsXOfTYMlUjWZQ=;
 b=c2YEmasA5L/tgRLEUq1bNSIr/l0Zffni1aUdcfUy/o7LRJljEIRGMzUlVQSMe1+IkK
 vBz+84VFwRTcjmO256gN2Jbiepcs5i+jTt0q3cClfeksBVvv5WRxomZnQRDdYBDcLhX+
 CfAaxIBq+bO1x3WlhE7u3gwI7FroBXSaNr89A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482911; x=1778087711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stIoPaBQ2ySWsfc+zh8kFUZrrJKDrRsXOfTYMlUjWZQ=;
 b=alfvO6BaFnFaVo6gZ4QVPNAi6YBQVaEciziOXdmcBnRdh/wlb7WOpu/shShINe+f5e
 hmdlZv54qcUGK1RSnSlA+QXXSLujuR3CPbltLmX3MW1MENOYjnGsDHfaBO8d2JlZL2DT
 3h4y7JC1B+XyhFsHdw/cwbCkHl6qQA5hZKrWcg+c0n52zSMJuZoToYLrbacZHkG3XXBm
 dtURKR8ac3MLmJoPxDWVEZwHbjAymvgQnt8Ddrj6b4ktC8TEEELd5JyguTYaeEVm2ylw
 HAkGL1JWb06UokbKVEPSp2dlSIMdOYtBykC4J0co5YTezkJVlNf6j0jZ6aIYyNwCHnLF
 lkyQ==
X-Gm-Message-State: AOJu0Yy/obCvB2LF1eBlQLqLHymrNQcHQqWdwGyDJtNR2bRPEmhNTmBU
 3kTFveKF0l86ftNI18V+fb8Q4QJqfqEuYRLGycVQZthzus/zHuDtd3WWYvTF9FdlqpSUVy2/rR6
 UBRpHPbj4s+dO6T8YExtf3wz3bjR3gjaUyIpoc0FG
X-Gm-Gg: AeBDievjmY1PbnGyUSN22d01MwHFRv1fRMPelsO/tHgYPRHXRiqJ3SOink+yeYOblGk
 0KmxHi5x96FgPWTQKh3SQ3vcInOJ7233851OALxRQdYC1ePz/ROThCsH7yBCedtU8S9zot2SA7k
 M/8gv78WR1ogR6ulfAq3TALB5NhFrXwbkP+Qcc8ZcAbkpGtaUIA1kFaqjVnNWt6bgia0vG5vpLI
 U/zZb6h1bbugoIzXGQwmhNZcpRQLwdFRXS2HFw63o5YhpTrrDIy+2tC3uTKWuOkwgsnIkBv2v90
 P4bA8g+K0n8NwQbYdBatzo43Tpu5U630zH/ICdugn7egXO+4uiJ+
X-Received: by 2002:a17:907:960a:b0:ba2:e022:c146 with SMTP id
 a640c23a62f3a-bb804f1a82amr564871366b.43.1777482911446; Wed, 29 Apr 2026
 10:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
 <20260429-sys_rx_eth_buffer-no-net-v1-1-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-1-396ef37ae93c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 05:14:56 +1200
X-Gm-Features: AVHnY4KU6dPBGmy2hDB--3kxnGV-qRsnR6t296XxvyhoGFSj2_aGKkAGxymOUyk
Message-ID: <CAFLszTgre7DW4p910s7O5mr2PA2ZDNm1MjOF2cm5ZfcrtsfMuA@mail.gmail.com>
Subject: Re: [PATCH RFC next 1/5] ls1028a: only include drivers/net/fsl_enetc.h
 when driver is compiled
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tang Yuantian <andy.tang@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-29T10:35:00, Quentin Schulz <foss+uboot@0leil.net> wrote:
> ls1028a: only include drivers/net/fsl_enetc.h when driver is compiled
>
> As hinted by its path, it's not really meant to be included outside of
> the driver itself. This header uses CONFIG_SYS_RX_ETH_BUFFER which we
> are trying to move under CONFIG_NET dependency. This file here can be
> compiled without network support so make sure this only gets included
> when needed.
>
> The function from that header (fdt_fixup_enetc_mac) is already guarded
> by CONFIG_FSL_ENETC so simply guard the inclusion of the header the same
> way.
>
> This was tested by building ls1028aqds_tfa_defconfig with
> CONFIG_MSCC_FELIX_SWITCH and CONFIG_FSL_ENETC disabled.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> board/nxp/ls1028a/ls1028a.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
