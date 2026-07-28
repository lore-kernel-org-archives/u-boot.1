Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9DCC54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE840608F8;
	Tue, 28 Jul 2026 18:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ene097LbOTqU; Tue, 28 Jul 2026 18:42:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B32E0608D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264138;
	bh=fyvM+PYShb4Ak4Wyo4eLdINRtfN+tOQIDFEvumo/k+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=biKG1j1IXJ+ovdaU2UTRz4NFGXWtiO5X9ORk00dfc6+wDlMScLu23wr8XQRByzg9I
	 C6+oG/J3haMDiYMwzdNClIaFzA2e9/qdVhHXkrkpceRnHmO41rC3ZNslYWcjmfluax
	 wpWFlE1zqxPOyEWjYzOSWFo0/k0e7hBv62eNizxtrEsRwKjM6GHgbTxkIEYH+FvLB5
	 EgaJqjHnvP74AkPBDo6bP4XvyQLbtuHvig3EtaNOh/CrH+u/7QWeNkQUQQ0PTNO170
	 ajo0ruGRSpdhcaG+6O99LCEz6Dl+WVedIkyzlhH07yjAqyAzFEdpp6UnWZFYv4aZXr
	 FsGQpGktphoSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B32E0608D7;
	Tue, 28 Jul 2026 18:42:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BC4E4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61C354038E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1X41lo9zGgBk for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:42:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8B3D140364
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B3D140364
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B3D140364
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:42:16 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso134663a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264134; cv=none;
 d=google.com; s=arc-20260327;
 b=evYZVTl4GspX6Slkca2SwtWUspf2yVZF2t2eNUkk7ifjzobTrs+mK9G36dRBsmgmPY
 CpzHJY4gzDVQknnkI5D0GSEJaVs/s8VGYer/VBsGGGDV0od9KeQn361FYL/kVeQa9W/J
 288nSZtZ8tS3Y1DksvopSjk80M1cWhz3s5aAvTira1CyX47MVBwJebC0ezSYTj1TGA6W
 RUMfPo2Sdca+EYRlBZAgYO2QV6mSf+/7OcP+/V13Vam6SkcIC7vLpwkabaPqBGoqtmDy
 r2XhmmQslFxCAzpy9MO602dY+HB1p8TZRYayQmJmoDIkFJW8trbllfS0hPBq2KjSabci
 c5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fyvM+PYShb4Ak4Wyo4eLdINRtfN+tOQIDFEvumo/k+U=;
 fh=1sJY6HnY4R4oHTO5tCWkmbpubr7BE1lyMmOuiyCO0PY=;
 b=XlAj9qZ6AxjhtROQE9AGlCg+/Hj/Uiveh7gnwPEQmHRZS2IVkkI4hc7LNu7mAq3QjB
 wuWrFk9k246GwH8v2jOE3jdu0p7KmV8X1iwgvdquSR8x7ZxnJ4MGJo/E1C+TnLurvQ7+
 NZSZarWWQlaMa83fhBpOUJ30mtB1bqIKEdXPA9DKu3IlOSj6yx5pwnryPwRSEmTBje6l
 lM6Fk5ANd0rtPaDW/ujfDHEynrjnk3U3UI3DyduFjleLLpdd82c4tMYzaY1GX+OpHlPG
 ci+yB+8aQkvRXOGPu4h7khs3Wtlx9TghVGMwI2q5iCZwGVjoyxolO/9TantHO0rlY6K1
 qRPg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264134; x=1785868934;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fyvM+PYShb4Ak4Wyo4eLdINRtfN+tOQIDFEvumo/k+U=;
 b=XvQeW0KQLSHUNQ7j3p/MXx9dGKtlHTSHzBXLJhHfXPa50pWQIgTKqb48lTXgzJiJaT
 339WYIBN7/QivgUKFt2AwPNE3s8E6xLZbnVDvDMFXiNpsJRssvsSR/zU6fmaHYRU0axG
 pGrwdfLPHaypdvzxkiX3i3KEEpOrZ1Ey8HxlHtSfDbsMFSVWqYkibv+nWLcVPIl9ugeS
 NkhQBh6bscMGNwVo9apQE8WCjoth7EDfAML4XjyBwQQnFaBtAMiuLP63Wu7lZOJd68Dz
 HCto2X5jMK70c2a6umdT0nUZckRYVSWzMHvAX0D/95nulxme/WDiFUb9hcFqpXkZ6k+P
 i22Q==
X-Gm-Message-State: AOJu0Yycbr+udD2jhA6RO+hMeEw4T9TbNc0Z8cn6SvKb2r3lW7+GFdkV
 9TfWA6uWQf1bpDtAlvNYd4MBXCw8s4D541qjwMty0k5uDEesgIJCi9A5VdKydXUdptqLcqI3q5e
 X/U0ziG1LYNfhZ3s+DN+xHgDxWUnlHfF56W+TlJyB
X-Gm-Gg: AR+sD13LFmDCALzEumHKgoGmwbuWvUtyS3olMspzs2GtqtzZKQE5ojRCj/RyxX9ubum
 ne9JuspsGBxdA+AFSd/o0dItpL7GtE0I3sKJ12a5bM387AYABhGN9BXrQTUFpUDltMneeOBIcq/
 CEcNIW3QlIKafr4FGoFYW0CQFuLVpyaSRXwy/oXtX4VwKtUpf/AwfO02V9AP2lMCe3sOv1VLquD
 aq02QjLNrbMbiTEmQ9uXLE8GqCDKPKXdd8aUKy5MzxOFDoxWwoyGHWM/MvkUUrce+8NzM4=
X-Received: by 2002:a17:907:c80e:b0:c1c:25a2:45b with SMTP id
 a640c23a62f3a-c1f727c57efmr179792866b.63.1785264134468; Tue, 28 Jul 2026
 11:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
 <20260724-tpm-trunc-resp-v2-2-381857e959f6@byteray.co.uk>
In-Reply-To: <20260724-tpm-trunc-resp-v2-2-381857e959f6@byteray.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:42:00 -0600
X-Gm-Features: AUfX_mypFG2X6ftnn0s_eP5-qzqYxhH-qQl38qMguDDEqi6L9LjaljNfJ3lhgQM
Message-ID: <CAFLszThRysSxA=U0_qQ1DS26Y9xbNG2WQVtdJdKX74JdrVvsuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: tpm: check malformed capability responses
 are rejected
To: shahriyar@byteray.co.uk
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>, 
 Che-Liang Chiou <clchiou@chromium.org>, Dirk Eibach <dirk.eibach@gdsys.cc>, 
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264134; x=1785868934;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fyvM+PYShb4Ak4Wyo4eLdINRtfN+tOQIDFEvumo/k+U=;
 b=n+NOVf4r5lFuoH9DNqJeob4F41r6q/LyRA5pCcdfiKThHyi33ErqIMfEhuYP73/Wm0
 KBVuH8UyhsJZUB9PiEFkLQLn4pijHK22KmuKUJxDCCvcXhQJ5MfviA70TqRcVlTjNHQU
 j6CBDD9w8sOoq/aG9PYNQZRoY7UMBb3IuglGQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=n+NOVf4r
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Shahriyar,

On 2026-07-24T10:34:14, shj <shahriyar@byteray.co.uk> wrote:
> test: tpm: check malformed capability responses are rejected
>
> The length of a TPM reply comes from the device and cannot be trusted to
> be well-formed. Add tests for two malformed replies: one too short to hold
> the data it advertises, and one advertising more data than the request can
> hold. The sandbox TPM emulator gains two test-only properties that produce
> these replies, and two DM tests ask tpm2_get_capability() for them and
> check the call is rejected instead of parsing past the end of the reply or
> past the caller's buffer.
>
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> drivers/tpm/tpm2_tis_sandbox.c | 27 +++++++++++++++++++++++++++
>  include/tpm-v2.h               | 10 ++++++++++
>  test/dm/tpm.c                  | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)

> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> @@ -197,3 +198,43 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
> +static int dm_test_tpm2_get_capability_long(struct unit_test_state *uts)

These two tests cover the tpm2_get_capability() paths nicely. I traced
them: the short reply lands at 10 bytes so it trips the
response_len < properties_off check, and the long reply advertises 51
bytes so it trips the caller-buffer bound. Both correctly exercise
patch 1.

But patch 1 also adds the TPM_RESPONSE_AUTH_LENGTH underflow guards in
tpm1_load_key2_oiap() and tpm1_get_pub_key_oiap(), which get no coverage
here. There is a v1 emulator (tpm_tis_sandbox.c), so a short-OIAP hook
along the same lines looks feasible. Please can you add a case for at
least one of those, or say why it is impractical?

Regards,
Simon
