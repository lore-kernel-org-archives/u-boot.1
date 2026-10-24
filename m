Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20740606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=feirFfBM;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UWrmckRC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F29F760A6E;
	Sat, 24 Oct 2026 06:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJ3ZcVY8C4wD; Sat, 24 Oct 2026 06:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2984560A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824109;
	b=sTd6VGzcYo3nrAhviOem/0+3+FE6pTY41E5jqVfDk99uNJdU0xElv4vmYMq8caRnPb2v
	 OyWspp7Z6guYYCuj12uqF0Y30L1KkS1fYcK45JVsm8YXdtM5gwUMN0BbTV5TZtN/KLX1O
	 DEM7tgn9X59Fz5nO5FOTjUDgiQcmmAifn5mCAWF4WIj8sthaQ7pKbxkmKVGITpMiQZoib
	 QzXwGD92qFBAmEZsXACZFq3HbsM6+rUukFU07Sh+ENQeQIAe6+HC5D+IoqgKa1HCSc8/M
	 vAczCR+LlJR9IpCTiy9jWlkdeTWxLvDlrUosfecCfExGbO4H8QhGQ9nVAVj9RwzOWpg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792824109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9pLed5ZljoSpEc9WgDUIcw9AYrnn0qgGdzVGbiJu6G4=;
	b=KKWX+6+TY6cnKpAZksnkHal5x62XB6p/Vj58QPyfqbFygaACTxDDAzLuW1IOZvOXegkG
	 jB3feHrpMXzqKgEQmEzbAGp9QsOlDawF3xu5/qVyMGQO3NFEiEKH1DBJMjzJ2QXrFG/2r
	 DkmoOcU4fB4BhhoSJ5cUPzZrEtGusEosk/hXQdkI117hDPTOTqpQUIQ/YVPpBdwpC+dEf
	 0PdzbsZ+ySjyTFucrmIfVuOyx+JMSoeeCL+RX1pcprpDDxk255W/fg4OgxmFXs5hIYr8+
	 Sc6iLX76J0VWfOzSNrhdt/V3e2zOLjNDpTSUdN2zIEWtdagonQLAD+3J/kt/cJFRGDw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792824109;
	bh=9pLed5ZljoSpEc9WgDUIcw9AYrnn0qgGdzVGbiJu6G4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=feirFfBM5Y06Tr2/gDHuYiRNCHBcBbHhIDjfQ2cMo/oKCnqSV72pEU7aP5H/1Dtpk
	 oEkFsF+iW+MX++zFJnuV5PGDwZEJjve5q64lYbypw1ZIOldzQPmGamozEeTFU38gCS
	 aMc+XHBizUqXkHKWqdEye/2w26NDSP6BaNb/qWRUuWJsOR4cd2ZnPrEkioJJR2dHp3
	 xQkLsqp3TCbbaTId4rsIK5Gi2R5arrK15hWSuTLQYg8SquN4dQrZcClnHMTyI/t4RX
	 45v5JCHG11WjdxOKzD/gjeScSStakr+GYmCW4hzJp91fACOiEChCMEjXQn4leh3DWU
	 kCePUmsqXrr+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2984560A6F;
	Sat, 24 Oct 2026 06:41:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7227B4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53F23816DA
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u26urBI8fxJi for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A71381692
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824106;
 b=Dkyrso+quTapJtMqhOj+Pvgrs3HDx4UyzDxpbUdBnLce54tswr8kZQ2kHLpDlepRIA2H
 4JjMyilFXysH3aOuNJ2zOyDlAZFdUu5B+ZueMMzaJSalWqcTHWlH2aY4SDfXiX60SnYNR
 uRFZUaDQEBSbm/oXKKm/DGCrG7Iyud86J6AMur7+/VxakSK+7jtMsnzoCXda+E5jslbpv
 eeyOu7Zw6fbt6Jt2dcrG7Z8Cn8KIK0LJU9x/k+Wg4POsLnJPasA2+6Li1oSD2CeBe9oj9
 P7/IDNfNDonVemaCZDc6n4lEsP7vIk276wXvaUA/YS8UqzMPb2hc+cx3M1FDw4mdReQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792824106;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=9pLed5ZljoSpEc9WgDUIcw9AYrnn0qgGdzVGbiJu6G4=;
 b=HQjuV2SjvS9QG3jBhE+wRiBgFbLRF1oOsSRs+gc1tHQMcPKv9bS977AtLFi6C6KtRcQm
 p52Dkm4vmf6fczhWQDzGyHpWkn7UFkZIrd9AysbW5/g++LNgNhN5oSpXt7/Oa+VMXt81G
 GZW4jjwk2RyjEVWnTvMNVwDbEBlmAcf+2K2M417cvXgCsKRZfNT5Tp4k8hdSpWovcc0mP
 HEMuq1aTjG8Q6bAnSROyfZTJzPdEwjqsv0tCctFQQ+Nw7xj4MJDT2lgdxrJ+c+/PNE5oa
 6R1jIhsP7iVTLjETaCjwgueM6YsHpsXJm2q/MaX8hFiRJYt6PA+1fy1x490m8D7iUOg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UWrmckRC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UWrmckRC
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A71381692
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:46 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso9090595ad.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792824105; cv=none;
 d=google.com; s=arc-20260327;
 b=n+3rSdpYQFy6TZkYVbvl2PueDoL9Jbv9dymmlmdSHPhl7aGA0l5h+nZ3t6VFmaQDzt
 282p5BezkUwVGy770UPXoEBIBgJe98eh6ULLBfCD6dvmJiikL3TWNqCq+tfNy7Ns8wIu
 8/KFp8epxaCLQ2SbjSqOtEXC8B0x+ZfYj9f76/35LLvcok5dDApghDVHG9Cw8S7z196w
 1wJOLTWch3pF/JWBv1qyWSF/nNKPb/83C6o+mcfHZf7ASKWOudGexoA+TQA1NKJwQJC/
 6kwudOoViEcfboOjIb2X3u/1gT5RiGTKsNszpIwL0yoJXlgb//vpJg1aTLCWA6eiR7y9
 1a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=9pLed5ZljoSpEc9WgDUIcw9AYrnn0qgGdzVGbiJu6G4=;
 fh=L/uw9+u71ZiDOqmjlybLnHPNPB0oTVqkdjWVKnRfXQE=;
 b=fz+lVx+cDt1EIwuOAZL9JxThMoR36SqFeAeUekzT186ioV7z/cXe9hn9G64Zu+5Op2
 qM/4Rct237foYrPGXKkLT9rQPtURsqkcCFgOlAHt8B0JNJ1+kvU6PjHgPQMjA133pYKZ
 P7NlBNNWI7I2ppZtRnri1QJS+cRg14ZzG3ppy5ffqrogk5cr0pXqc3xA3eV9MUyk1cjX
 mYwf4rcycu3wI1P2ZTHT27qzt1GRaOzqcQEEa8og65Tew4buWucad9vwA1ORHNH0wxrz
 19W/lD1JOZk/j5rw0TWwRiL9Qr62FUe8e9Vbm+rgW01SRYw9mFYcQiYS7jKkduYOFvwV
 +XOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792824105; x=1793428905;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9pLed5ZljoSpEc9WgDUIcw9AYrnn0qgGdzVGbiJu6G4=;
 b=UWrmckRCJyimNalHYm4ZJPq2A07SWrsephYvQoqNTlC4urj6s+sBuJyqWoCLa7y6xd
 ZYdlUWTl2DK2X2xWAP6+KpQf8bMhm242uHZsDmri9j1pKLzSllu7IiTlrxNswo3KjhjB
 oVQ/SkDF8UGJKzxdhRu3+apsUxHZ3uRsP5zFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792824105; x=1793428905;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9pLed5ZljoSpEc9WgDUIcw9AYrnn0qgGdzVGbiJu6G4=;
 b=YSaVhN/GjkNFgJzk7mf7b354sI3xjC5KikqjWDdpnWxI5a+u6ysXCliBw0R8SJjH9y
 kwdhTWJY9gcAWH24ReQ/Jg4sWIU6mKEbRqAOlTNt7FDOQodhOf8KIyZVJqZB/GCWIucA
 qsOq4Sf/bFS++PmyxYql/0WaQJKVe55uMg3rCH8sEUSpg6AsSoddPI9OQz52HoMGuEw2
 fYFYtQfP0tvKp7jq0jqLqqTSU8o6rxAreHR7xRRlUP6oQi1axzptojZKi4JZurN3E3PX
 7u8xLmqUx3h8w14JL2uR3x+8Q49IUf6r0GexdQnOSzZoCMrSf7c8AB/CsvYkFkfo6khm
 Mb8g==
X-Gm-Message-State: AFq9FYLoeEG7zAw5R7NxahzBbc/EIk7WjxFyvnIiiiiFIPd2zV0CsNt2
 c0D1SK+juLh3dgeMpaaL3uvh8S8lPYMD+Rv5WNtBLIvomQHz4KEOqXIWtW8uAGAivp2x1YZ7EGR
 VjcPXvq5h/vGu8skRiaKk2FW6Ln08VnxAk5Gjc0lhy4c3IscdynIb5g==
X-Gm-Gg: AYBFou34YECJkp/sx1ADO5KArsnjfWJndnN5PQTjujKuJJ44M2mCAfopcSBDxrLXRan
 b5T5zvSRFbt8uH/SEVwYuLkU1Z9swb4k3fofNqWeF+ydEryb7SMf8TMXddO7Uqp2O3aUG+fuTLC
 +ilDbE3yo/xmT1vCZiu3CtRydVmNh202pRAESAH29Nzc3JG5Y5csTRur99G75L6v8BQ9oYqIIQS
 ZM+rGOLG5Ulxp7o1S6WMCIlhdeBE6+Ag8fglusWaYMZvNEbZizS7wkxyKqZlD45LVgXqJbmDeUA
 INMQgsdCFw+oovLmJHFawE0D/BZ4bCAGRps4ymFVtRdXp9ZV4tGVYmh7kQmMCU+7KC+NrqxB2jz
 WSKv64l69XJq+szN3bpPOeLBID68Yc8Usdri8wQO552hJEpo3jgcyENyT
X-Received: by 2002:a17:90b:4a4f:b0:3a8:13d6:f740 with SMTP id
 98e67ed59e1d1-3adeaae6f7emr1257410a91.22.1792824105367; Fri, 23 Oct 2026
 23:41:45 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:41:42 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:57:56 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022135740.3869144-4-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <20261022135740.3869144-4-padmarao.begari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:41:42 -0700
X-Gm-Features: AclHuK-AhGdPVgtaZAVjl1V-DLbThRIRkJviEG3Ut9u1hICcSZs6-yWhMVXNKkY
Message-ID: <CAFLszTiq+CVjUKaoH-86f_MCgtspYK-34t_ssSJy3pLpZrCDQw@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: zynqmp_gqspi: fix chip select for part-concat
 flash configs
To: padmarao.begari@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Padmarao,

On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
> spi: zynqmp_gqspi: fix chip select for part-concat flash configs
>
> The ZynqMP GQSPI driver hardcodes CS0 as the default chip select when
> SPI_XFER_U_PAGE is not set. This works for stacked-memories
> configurations where spi-nor-core.c toggles the SPI_XFER_U_PAGE flag
> based on address offset, but breaks part-concat configurations where
> two independent flash nodes (flash@0 on CS0, flash@1 on CS1) are
> concatenated at the MTD layer.
>
> With part-concat, SPI_XFER_U_PAGE is never set because
> SNOR_F_HAS_STACKED is not active (no stacked-memories DT property).
> As a result, the second flash on CS1 is always accessed on CS0,
> causing incorrect reads and potential data corruption.

My understanding of this is that the problem has nothing to do with
concat: any flash node with reg = <1> on this controller is accessed
on CS0, e.g. a board with two independent flashes doing 'sf probe 0:1'
or 'mtd read nor1 ...'. Please can you describe it that way in the
subject and commit message, e.g. 'spi: zynqmp_gqspi: Use the device's
chip select when not stacked', with concat only as an example? This
patch doesn't depend on the earlier ones, so it could go first in the
series, or be sent on its own so it can be applied as a fix through
the SPI tree.

> Fixes: 217b0a28b6db ("spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver")

Just to check: before that commit the driver always used
GQSPI_GFIFO_CS_LOWER, so a flash on CS1 never worked. The tag is fine
since that commit added the 'u_page = 0' default, but it would be
worth saying in the commit message that CS1 has never worked for a
non-stacked device.

>
> Fix the driver to use spi_chip_select() from the DM SPI framework
> as the fallback when SPI_XFER_U_PAGE is not set. spi_chip_select()
> returns plat->cs[0], which is populated from the DT "reg" property:
>   - flash@0 (reg=<0>) -> cs=0  -> CS0
>   - flash@1 (reg=<1>) -> cs=1  -> CS1
>
> [...]
>
>  drivers/spi/zynqmp_gqspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
> @@ -881,7 +881,7 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
>  	if (slave->flags & SPI_XFER_U_PAGE)
>  		priv->u_page = 1;
>  	else
> -		priv->u_page = 0;
> +		priv->u_page = spi_chip_select(slave->dev);

Elsewhere in the driver 'u_page' is a flag (upper vs lower CS), but
here it gets a chip-select number. spi_chip_select() can also return
-ENOENT, which becomes a large unsigned value in 'u_page' and silently
selects the upper CS. Please can you make the intent explicit, e.g.
'priv->u_page = spi_chip_select(slave->dev) == 1;', perhaps with a
short comment saying the controller only has lower/upper chip selects?

Regards,
Simon
