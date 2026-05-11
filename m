Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CB8CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 17:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5616B80F0E;
	Mon, 11 May 2026 19:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uj1xAC6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60AC8341A; Mon, 11 May 2026 19:01:18 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A76803C6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 19:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bcf41831af1so207021566b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518876; cv=none;
 d=google.com; s=arc-20240605;
 b=DxBE5VTDIpfyfmgNWEK37DRSL1VFu+4ttVVXNmRiI/IYtHWA2oOgY/r0JrNnwmfaeU
 9qRSyzP1xTKKs0DrxxhulJjZ84soJFrciHw/OVUyy6XT2vuDtFh4Tcfoe/9OX6Z0w6Ab
 qmWZGwsPmxGIokxwG9bhF1c+O5dSz6340z0vqY27cZ12O8juTTbJXyQcwx3qh0X8k4UE
 MhhBalEPjVx7XexcZgRQ2dNqKeAhdhkbHXE7JjubSRUfCyLez7NcoLetF/EFDwjP6POm
 CnkHah9bV8f4+63X7JUFjq1iB+QT/MNHMTcPKZuL/2lcmGz+xYNCBFilzASkd99HSHzx
 0pVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4IoDjVNPkhhrlo/ncykU+6Utlqx6lU/tiM3RbMoMujM=;
 fh=4S+CaPjWrEUq6IBaHLxukaf8lc/EXhxCPJNN7m9iHfY=;
 b=c4qbOTmTXj+4BQGT9DsQYYoV+PBxsGsI+YsJXnVYEWlfSlJ4unvAdcUVRjsuvxeeNx
 sSoSflK0yRQktzTQpDulPHvKWSwHTMw6cDdYsaeg44dR840QxrKfCklRd3tUvDpOvpSP
 OAFY0lkLRtAPu/A7B5v5hPJI+c0Rbse0L9n75EBOl4dQMgJKthuDYOLMdMl/OV4Gaw5J
 bo61waQ+IVy1KnHACam+QCsr0IgNmX3FSJyZ/pYaWa3SJir30taMn5mC4Gbw8zIkQjjK
 09JcsLYTdBp06zNNtIPEzdxyWPjuBQLFz0NG68xdyco8sEv7ji+2zArFW6fZLJisukwc
 BNxw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778518876; x=1779123676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4IoDjVNPkhhrlo/ncykU+6Utlqx6lU/tiM3RbMoMujM=;
 b=Uj1xAC6yBoPsAJLsBZvoxTLAOHAZdBxd6//UvXg4ZLOM8Me+rjeUyF8zp1jvho0vhK
 Rq0TqXogUKlj4ddClj3gHzB+axam53ZDyWSxeciLGAJAbXe541jHmtINlM3GZeQdOU6y
 KundvOGouOJpoOeWufis0DLc0PQTTBf819L94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778518876; x=1779123676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IoDjVNPkhhrlo/ncykU+6Utlqx6lU/tiM3RbMoMujM=;
 b=KXKlPYIBTgw0GwYFZe6FL3A4mhqjZ5Q/21vmH6BwmFpnCN3AeY5pz86ZkZC2MtOuLC
 J3svd2C3pAd94TUkRFG3XAzjSEz9ONtKpxYhf3erQP1yNsJCpOy+0/26K5QLf/VKUo8E
 TcA6Z2QBVa6mzgNs+hEntA2rk3mepGPyFEvthB4oIjHe384DqVIyGYfNsh5BZyhzPxUB
 DcqXX6HFeXT+Hfy9aHnSXzzOMFFPQZluh/nuD1AfD6MYTioZP2XVWDtrlZPrtn3aDxgB
 8BgX36JOT0uqnLNTfbNJOWKfqBQ3k6h/IBQseB7sJy7aDi3IQEBV72ArO/gatJBuf7ZF
 8Vfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oZiYFUvnBtGZNLqlfrMLHpGxLW47G7kOdqQw7t0AbLvrtTlPeMzNkvYyWsYDYFzTTHB6xcr0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3IQHP+ssHlVIFfoKhaGzohICNKT1UBddfwzsvNgLcpXKwpUgE
 TbAWbMnzqA0aw1G3PdqsEnhLTvqvaRBmdxYECRseS1P1U0lwZPh2d0dJmGnugyxDQD8HHMjWp3P
 rauQA/1xKUN3gwm0F5nlvI1O0jorndO8u4quPEvCg
X-Gm-Gg: Acq92OGi6WsijGS/pEi8U3LI75NVRVgBeN39TX3tAJsdug95hwx7IU0cAyTAGifhwCM
 +XrxqGGgmz65vWGj8t0wDjUcnhpemS87vFKELN/K8sQzST/pOzhjZUvu5uUM0opp+k1NDjned+L
 DYmVZjRbZxIz5XsB9PPjzegouWLvnUNRRpWapR6gVFtnfoIWvkxKxNnyAAfpyboA+bvfJqOZS9i
 +PDChOhuW95NWK102hDHulkBJVWDeuK8PflyeWAEIDTl18/NYTXBsZziFG+RCrqsv+sXLbiUuvA
 htUxgg==
X-Received: by 2002:a17:907:7a8e:b0:bd1:e2da:dbf6 with SMTP id
 a640c23a62f3a-bd1e2daddc6mr157968666b.30.1778518876120; Mon, 11 May 2026
 10:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
 <20260507-doc-sysreset-qcom-v2-3-37fef7a9cf92@cherry.de>
In-Reply-To: <20260507-doc-sysreset-qcom-v2-3-37fef7a9cf92@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 11:01:03 -0600
X-Gm-Features: AVHnY4IQeBHU1PmcS0smrroKxVGahOLM2pfvA6F8POquxnq3V4BvKBHc5RXv5SU
Message-ID: <CAFLszTh4m97_KEJCNV8AckBL6Zbs6LjzCL1YJctnicrw6V-M2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] doc: usage: cmd: reset: specify when the -edl
 option is available
To: foss+uboot@0leil.net
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-05-07T15:04:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
> doc: usage: cmd: reset: specify when the -edl option is available
>
> The option is only available when CONFIG_SYSRESET_QCOM_PSCI is enabled,
> so let's make that explicit in the boot cmd documentation.
>
> Due to the implementation in drivers/sysreset/sysreset-uclass.c
> do_reset() function, all options to the reset command are passed to all
> sysreset drivers' sysreset_ops.request_arg callback (including -w) which
> is only available when CONFIG_SYSRESET_CMD_RESET_ARGS=y. -w, however,
> works also without this option.
>
> Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> doc/usage/cmd/reset.rst | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> @@ -22,8 +24,12 @@ DDR and peripherals, on some boards also resets external PMIC.
>  -w
>      Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
>
> +All other options require CONFIG_SYSRESET_CMD_RESET_ARGS=y.
> +
>  -edl
> -    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
> +    Boot to Emergency DownLoad mode on supported Qualcomm platforms. Unsupported
> +    platforms will print an error message but the command will successfully
> +    return (having done nothing).

When sysreset_walk_arg() returns anything other than -EINPROGRESS
(e.g. -EPROTONOSUPPORT from qcom_psci_sysreset_request_arg(), or
-ENOSYS when CONFIG_SYSRESET_QCOM_PSCI is not enabled), execution
falls through to sysreset_walk_halt(reset_type) with reset_type still
SYSRESET_COLD

So 'reset -edl' on an unsupported platform actually performs a cold
reset (or hang() if no driver implements it).

> -    reset [-w]
> +    reset
> +    reset -w
> +    reset -edl

nit: I would suggest 'reset [-w | -edl]'

Regards,
Simon
