Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE719CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 05:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0820813CE;
	Fri,  9 Oct 2026 05:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cZWc6S0q0jN; Fri,  9 Oct 2026 05:49:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05A6B813A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791524993;
	b=NMfimppVKFFikwKisy6wjoPUsywVX8ZgipafDjF4Khkx1DFufy+o6gKL9LbkiO/JO2Gy
	 R1EDYENTHmQX6l9bB7qCpvXKrAgCmFXIt7GRrc7zA1h1r36OWORYFfHzYNMx//OFQJd94
	 6Mqf/rzpisLBQSOcP2RxXIde6moxtgxkNmJcFF5WWTCr5vRVqda9LZ3NOGl46SQChhbNK
	 bv8+z5t3esJbmh7FcntaW7UMON3kdfSfr0W/ceGQ0WmL80P73YzKitKAHHRDbV/V7sQkJ
	 WMhmNvRt7Q/EsErRsKqEavEopjeT36BeY0/grDf/IPPj9hdrHysF35i83BRl4er2QBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791524993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oxwfQ15ivh+OfcJOFwXGZAa6xLdlmmIQKezW+zudlrU=;
	b=X1AM6t0+XcbHvuk/lsUfkWxnMyBy1QnSJDbdT0pdwU9J2myf7gukEWD4mZtLXrR+I2lJ
	 Ng+BUFXmK3vcaK9d2SifmFcuLUNyjA1aKEKNBM53vPtntSZojT0WwV7I+qU4inq3RfkPz
	 H6ZCFD+ExTIGNU8Dqr2LHu+kf3rjSfPggH5db7aOzXdo3K7BP6L5p3T675jheFAHy2KOH
	 cagqdbUXmMdWzFv2U8lP4vowwHzJOPRqrWZF3SdUKPtX/xquBw24V7F8GGXpT43kLZ5bq
	 /fOPiK/01IbeS1I3c2IZN1b+tGGfO9e44fIpysin6uwj6XVvDSTDNYuDL2Q+N+R2PzQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791524993;
	bh=oxwfQ15ivh+OfcJOFwXGZAa6xLdlmmIQKezW+zudlrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MC+zY3uKxoyttidnpWV/WPUWneTZKMRMIiTVllvHFpxnE+yTyT1k/l9S3o/jxHl7P
	 1Hi7vY1na+lXEaXGFEi3OBt6fAEUKxcADQIjFCPFT9pCYFk0Y960TvWSj9nkMgWWA2
	 DyWXCkbLrL+IzOo/QfaR9puiAr9REvw5AROUQ8dcdD3ihVMEmS2XQkNRlI9Zz5jPpG
	 Hh943JVFmdvD9Mc8notZ7nqkUqayx7xT2pAXu9TvtzPwqwFKbUXZlbn7VnVpZOvv86
	 eNC4mRWbGV+uSpgNfatVtAdO0ripKZ9iTRrU/BERyrrm/cmOkTTUcFvAGMq2eXWa8N
	 aga1Foj+7r11Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05A6B813A6;
	Fri,  9 Oct 2026 05:49:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BFBB1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71D334009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lNwpfEnapRMc for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 05:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3273540061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791524990;
 b=qkCXBKM1mf/PTkTjRNnLX9JMzFe/Y0fkAFZ4cCalPO8Fw2TPjjzvLZKa02YD6Q5phDN+
 SPlIVfDS6iI889afdXvLzDmSj6wCswQW3IHDBbUcWOPJQXeycdIrWpIOPdoJrqDiJfSFY
 SiA5E986So+sWmFo+kNNQQ2YjgEABv98t9e1zp3EKilNtvsFQbeMY+HpC+gyqEV4xlTGZ
 v0tSJFRsDzwYFAKeGr16yv04w7y16Dq1UqMGKyVCKNTW2fbIxWSCNGpWosPLQ4HLBJwqo
 BnJkW9IdrQjzE1jlmYzSZY+5z/J41gUqiw9fS0pEBEIpWDVcDT79nXncjHr/78sniEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791524990;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=oxwfQ15ivh+OfcJOFwXGZAa6xLdlmmIQKezW+zudlrU=;
 b=eXpeSoQpm4kPH6VSUgVYVCLFZQuV/70D78+Rx6wCxniqa5q3QZzrR6bxR9AckdSBaPEA
 OjpyOC+Pzhdh9WrCxdcmbKwmIAlR4n/iLFc6Vrd/gNhlUNd5j4kwiWmWhe/UuiB7UlMDL
 DwLEyxwCUDxAt/526QQIjtmaYCGDWBYJDQbRYXB0ZaOnDH39J+UIcR+aG58gT2KF4POF2
 JxykVAVUGIWN70lGjPs1gRxF/JUTBo2CBOrDkCU8MVQknvJt0sAAh8IyTbEpteD8jG8zU
 UBTcE6rVA5sNsvuAA7ecXKSEJHZs3CyNoqw9SkPhRwCA0G6+y2MYKPiJJQziCLoJ8UA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nM4+Z8FC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nM4+Z8FC
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3273540061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:49:49 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ab43af5e97so15321327b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 22:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791524988; cv=none;
 d=google.com; s=arc-20260327;
 b=scMv4OK2Q29prl2gtlF6l+F1DOx8KIKXUfoz4KvMKzDaJCl3USQOY+q02e3doIpyQE
 scRl7du9n2iIyAaXQBMlrsBUG34ndXmzcN6SsdP1iTAjl0CY28+F6ToolISfctRZtkn0
 8fKPQNfVY3oKMxLFbs7t/lU8S1lrY0uqobH+cbtTTZJu1ucb4ap1OLNnk1u6Gew6toCt
 wgDkmYmRhZL+EWGm4DcqhZskDt5xNnx8P0qoP5X7JcA6PIjfZZ+/AV9W3FNXTAmR1fQm
 DjYRMraPWMk4nd5CcnSkvZG6nCfQIoPzrGZVTFOZ6e1VWzPLSeu9EExgBQ8GylaFN4qE
 B8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oxwfQ15ivh+OfcJOFwXGZAa6xLdlmmIQKezW+zudlrU=;
 fh=qIHU5praJnpEG8pvGcO48d+yRv1dP1geKvuZ9YauhUg=;
 b=dobSoQBCEPRqS7m3vh+yP5dDT+oKkMe6TzjUstbT2KPEdMhuc83pyRw5nUEBZbNBqg
 wotp7ymjjqUD/mMrPuvlCehSja2XU92vMq17TQMYkBuIfM+B2C3ULdcmuoVJrnLSp8Qs
 TVXdnZHr6ka0e3McxiqFA/ycq+qRX/B7FuDNHE3Z959vBVb6ePgFwOhSVd9VwsiLqrkg
 XP3iLPvp/K0gLqdcRF2Y6wSJk5m4IBRh7YvBr8HI09fuWWGirf0zjdpKB1zmp4ryzSef
 G360xAoBBpTeoZ59QryJL+U88HuxwVOrOHFBoA7B9GhOME2+LobKB9GdeDrF3AXhjTIU
 SsLw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791524988; x=1792129788;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oxwfQ15ivh+OfcJOFwXGZAa6xLdlmmIQKezW+zudlrU=;
 b=nM4+Z8FCX8EoQeJ76mIWk+R3npVb+iifTp/Z0hipj0xvOKsdrWrFJB4EjH5ccomtSG
 rHlkFEkoQhe9vd054MTBrIJoWijohwVQFtNnIqeiB0X7upsIkv/Vps2lj1P+gM+y5HSu
 IYJWFGDtjKqMZC2bK4Ceu9CRdlPwW7p/enNNroXG4m3BY/v0XRF00lu7ce/OpgLLu1Gd
 QxlXJldrAvmb3phuXH2SVpuStKlNUiGCog8oInFqlq6kon7K0ITk4B7r0qJD5vHehSc3
 vZ47+vfeW7uiTmQYnYpcc1hBqxIIy9EkdByHArwXXV5WCCLLYuGTfsCour2uy2cQ3IuC
 Vkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791524988; x=1792129788;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oxwfQ15ivh+OfcJOFwXGZAa6xLdlmmIQKezW+zudlrU=;
 b=i9pbh2cDTzNezCIcbJy+Rl2OAbHELjKEFqnfZVH2g3aY/5hfQ+y981rTWCyP6ItXcs
 LElyhW9yb9/BcSwkSPqLj09LpeK1iCBg0f0nTGOdeRqDhvM5hWrbIhYJ2ZJkNFcqyIx1
 +TSzRbJm9cwKn/9C3DUWDO+WF4NEwn6ibPFWus639QNvtP2eK+0q7Y8QyzvRp39u1l0h
 fSh+DkB7HB4SdlPMhpk3UsCSlLKsznDCZDZ9Dy8wUOl7lUwX+HA0iwZZ9JdEg1rN47Tb
 VA92gF2DV3z1hq6XIrvJzq1kFjq1QgfCjZMkU9HUD+S0VPFfqwqCaR264HiDymBAvYT7
 fTRg==
X-Gm-Message-State: AFq9FYL9FlGv72PjIVu9pdYbhYQEYEe4STLI2qi93u8p9Afv1ctlfhZw
 L0lUNN3pzb85b5RiVC3WHzVb0ysIakjl8xk0lUVJupJHkhZP9Qc9kVIiF+/MaL778han6RljGuN
 Wk+q17vbTFEV54c56UXJEKEgziDgjZKZFILb964Ad0w==
X-Gm-Gg: AYBFou01UliJCPBUe9dIO5B7rE5M8QXQrYyoDyZ/5KTCr5zGMpUCW8VFxWr0CIf0V0T
 ofeZagNw/sEdiqF0orhKpQc3h18Y4MKjrBmZoM6HdN1YoPWGkNhF4zK20SWUb7HKnI+tof/4JnT
 feWKkBKJHsJjSjSapkZ1s8TJL93rBQX2Umm9SeKPeJPPrnH8L1cZSC6kR1fdB0shW5SXKSn5/2d
 Fx/ZXdZMCvhvJCcAFca/3lYELwdZd/gKbafVi2AkZ5U+lJ71IgKZyRsYXmmTQW+3ZLBJye+V3nX
 rhRecV81sRYvBT8Edl5g9duOsaRVS9ZBc0yQ3dCXRW3G8Dmm6/eD8baxBrDSFOI8sWpG9pRtSx2
 MuWs79aT76Xz4IhN7sl9Y/xNhWbN++IB2kur7hETitZ1ZyyPskXT/R6uZ6AJnte6sd/2XHS1+2P
 axCkCmyN3Hkk6SOOhPlKIxsB+FHujm7KmyslLoy3e1x8F2P4ZVngPBi6nQz0nZgrf8mOM0YyYOV
 embzblsEtSL4QMtRMzBKuVCbi3qcLtSsAG7kcY9TiUZThvMZx6ZJgY7rSIYKoFISrlxgnzToAuE
 LMTtXmi+FG99k8rgczZpUShIRXpAd1AEGujGn5+NhRYygFRFKD+zN7oCysC0qFVe/EBCdrfAQJO
 Iz4Modpw+M5uaRLfCOnMOSGM4ThDZ9Fnhgkn6M66b3pjan/zgoae293WkDTlDuUZo
X-Received: by 2002:a05:690c:ec8:b0:87e:645c:182b with SMTP id
 00721157ae682-8b07edc852emr2834287b3.26.1791524988351; Thu, 08 Oct 2026
 22:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261006155217.187050-1-michael.haener@siemens.com>
 <20261008215518.209510-1-michael.haener@siemens.com>
 <20261008215518.209510-2-michael.haener@siemens.com>
In-Reply-To: <20261008215518.209510-2-michael.haener@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 9 Oct 2026 08:49:11 +0300
X-Gm-Features: AclHuK8SaXJft4hljM4hkc_sTuUgF6uBG0dU3j-S-XtC1A9MRAmjzcxF5d4mR-8
Message-ID: <CAC_iWjLvTF+JnYwZZvuFvv68hk9PzOQMsGEdQcf8-f6Up+813w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] tpm: Add an option to start the TPM during init
To: Michael Haener <michael.haener@siemens.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 9 Oct 2026 at 00:55, Michael Haener <michael.haener@siemens.com> wrote:
>
> Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> 'tpm autostart' command does, but it does not depend on a boot script or
> on the environment.
>
> Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> is used (and then only from bootm) or when booting via EFI with
> CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> uninitialised and the OS has to start it itself, which Linux reports as
> "A TPM error (256) occurred attempting the self test". Boards have worked
> around this by putting 'tpm autostart' into their environment, see
> board/xilinx/zynqmp/zynqmp_kria.env.
>
> The startup is done from an event rather than in the uclass probe:
> nothing probes the TPM on a plain booti/bootm, and the event runs exactly
> once in U-Boot proper without changing what probing a TPM means for the
> existing callers. The startup itself is in tpm_autostart_init(), so that
> it can also be called directly, e.g. from tests.
>
> Boards that share one binary between variants with and without a TPM
> fitted can enable this safely: when no TPM device is found the startup is
> skipped silently. Other errors are reported as warnings but do not stop
> the boot. Note that the full self-test adds to the boot time.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> Changes in v4:
> - Move the startup into tpm_autostart_init(), so that tests can call it
>   without sending EVT_LAST_STAGE_INIT
> - Add Reviewed-by from Simon
>
> Changes in v3:
> - Split the tests and the Kria conversion into separate patches
>
> Changes in v2:
> - Move the code to lib/tpm_autostart.c and the option to lib/Kconfig
> - Stay silent only when no TPM device exists (-ENODEV), warn otherwise
> - Use u32 and %#x for the tpm_auto_start() result
> - Mention the boot-time cost of the self-test in the help text
> - Document the option in doc/usage/measured_boot.rst
> - Explain in the commit message why an event is used instead of probe
>
>  doc/usage/measured_boot.rst | 18 ++++++++++++++
>  include/tpm_api.h           | 10 ++++++++
>  lib/Kconfig                 | 19 +++++++++++++++
>  lib/Makefile                |  1 +
>  lib/tpm_autostart.c         | 48 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 96 insertions(+)
>  create mode 100644 lib/tpm_autostart.c
>
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> index 488dd546f13..d74cfab2594 100644
> --- a/doc/usage/measured_boot.rst
> +++ b/doc/usage/measured_boot.rst
> @@ -55,3 +55,21 @@ Requirements
>  * The operating system must also be configured to use the memory regions
>    specified in the U-Boot device-tree in order to make use of the event
>    log.
> +
> +Starting the TPM without measured boot
> +--------------------------------------
> +
> +Measured boot starts the TPM as a side effect, but only on the boot paths
> +listed above. A plain booti/bootm without CONFIG_MEASURED_BOOT, or a boot
> +which does not go through the EFI subsystem, leaves the chip uninitialised
> +and the operating system has to start it itself. Some kernels report this as
> +an error.
> +
> +CONFIG_TPM_AUTOSTART runs the same startup and self-test sequence as the
> +'tpm autostart' command from an EVT_LAST_STAGE_INIT handler, independently of
> +the boot path, the environment and any boot script. When no TPM device is
> +found the startup is skipped, so a board which shares one binary between
> +variants with and without a TPM fitted can enable it safely.
> +
> +Note that a full self-test can take a noticeable amount of time on a TPMv2,
> +which is added to every boot even when the TPM is not used afterwards.
> diff --git a/include/tpm_api.h b/include/tpm_api.h
> index 022a8bbaeca..73c0ac6b3e7 100644
> --- a/include/tpm_api.h
> +++ b/include/tpm_api.h
> @@ -339,4 +339,14 @@ static inline bool tpm_is_v2(struct udevice *dev)
>   */
>  u32 tpm_auto_start(struct udevice *dev);
>
> +/**
> + * tpm_autostart_init() - start up the first TPM, if there is one
> + *
> + * This is run from EVT_LAST_STAGE_INIT when CONFIG_TPM_AUTOSTART is enabled.
> + * Errors are reported as warnings.
> + *
> + * Return: 0 if OK or if there is no TPM, -ve on error
> + */
> +int tpm_autostart_init(void);
> +
>  #endif /* __TPM_API_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index ff7655e1496..33ae8037479 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -565,6 +565,25 @@ config TPM
>           If you want a fully functional TPM enable all hashing algorithms.
>           If you enabled measured boot all hashing algorithms are selected.
>
> +config TPM_AUTOSTART
> +       bool "Start the TPM during board initialisation"
> +       depends on TPM
> +       select EVENT
> +       help
> +         Run the TPM startup and self-test sequence from an EVT_LAST_STAGE_INIT
> +         handler, which is the same thing the 'tpm autostart' command does.
> +         Without this the chip is still uninitialised when the OS takes over
> +         and the OS has to start it itself, which some kernels report as an
> +         error.
> +
> +         Boards that share one binary between variants with and without a TPM
> +         fitted can enable this safely: when no TPM device is found the
> +         startup is skipped silently.
> +
> +         Note that a full self-test can take a noticeable amount of time on
> +         a TPMv2, so this adds to the boot time of every boot, even when the
> +         TPM is not used afterwards.
> +
>  config SPL_TPM
>         bool "Trusted Platform Module (TPM) Support in SPL"
>         depends on SPL_DM
> diff --git a/lib/Makefile b/lib/Makefile
> index 93a389b10e4..b31861fe4b5 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_$(PHASE_)OF_LIVE) += of_live.o
>  obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
>  ifeq ($(CONFIG_$(PHASE_)TPM),y)
>  obj-$(CONFIG_TPM) += tpm_api.o
> +obj-$(CONFIG_TPM_AUTOSTART) += tpm_autostart.o
>  obj-$(CONFIG_TPM_V1) += tpm-v1.o
>  obj-$(CONFIG_TPM_V2) += tpm-v2.o
>  obj-$(CONFIG_EFI_TCG2_PROTOCOL) += tpm_tcg2.o
> diff --git a/lib/tpm_autostart.c b/lib/tpm_autostart.c
> new file mode 100644
> index 00000000000..ae69f797652
> --- /dev/null
> +++ b/lib/tpm_autostart.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Start the TPM during init, so that the OS does not have to do it.
> + *
> + * Copyright (c) 2026 Siemens AG
> + */
> +
> +#define LOG_CATEGORY UCLASS_TPM
> +
> +#include <dm.h>
> +#include <errno.h>
> +#include <event.h>
> +#include <log.h>
> +#include <tpm_api.h>
> +
> +int tpm_autostart_init(void)
> +{
> +       struct udevice *dev;
> +       int ret;
> +       u32 rc;
> +
> +       ret = uclass_first_device_err(UCLASS_TPM, &dev);
> +       if (ret) {
> +               /* a board may share one binary between variants without a TPM */
> +               if (ret == -ENODEV)
> +                       return 0;
> +
> +               log_warning("Cannot init TPM (err=%dE)\n", ret);
> +               return ret;
> +       }
> +
> +       rc = tpm_auto_start(dev);
> +       if (rc) {
> +               log_warning("TPM startup failed (rc=%#x)\n", rc);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tpm_evt_autostart(void)
> +{
> +       /* errors are reported above and must not stop the boot */
> +       tpm_autostart_init();
> +
> +       return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
> --
> 2.55.0
>
