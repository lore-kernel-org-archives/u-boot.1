Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2432BCE7AE0
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 11:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A1BA83EF5;
	Fri, 14 Nov 2025 12:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gO1kqkY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 927DF8406D; Fri, 14 Nov 2025 12:35:23 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDA783EAF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6d13986f8so1355535a34.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763120120; x=1763724920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GOtHpVzKAFma8GXWKD6X0I74d8ycOJef1nRfs7lr/WA=;
 b=gO1kqkY4hjCXbHM8CtkNIoAi0KXqyX3fGl+y/+H1QyYwkbvfISbctO8/L+l4dYvfAE
 lBkGzG35eLp0cEz/Pkq9syLYwsZvLKzHRXtiU6MLyUtGMFSlv0AiNHklcNE4PjTMNw78
 /+jMI9jXGA0kF+xZZwF59672nlEY6QK0ZDgVGYyHtNtJ0yArczq4Hn8TFnLxG8PgzrsA
 QL2NTkkQzhC38ulPMXcxZ4g3iXJsBhylqZo/IK+QenE2nzCYel4vJQGN8RCG4u+mmFH5
 Ogu7vF12CbYruN8Btt0Wi6DVRNphvxNrt7uq5pvO9r1lPk+FJau+TKOdGAm70mi083OY
 Cgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763120120; x=1763724920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOtHpVzKAFma8GXWKD6X0I74d8ycOJef1nRfs7lr/WA=;
 b=koA+kMcErDaInbiX400zZahqarenmUDj+0NK0/yFdnFETJro4SLRZEScAi9KMXp8W9
 YQr+q9cidmKKv3ybokdt/IbkLOFJ7VeOy0tcn2vcS4zo7NLxHJwPzZyUHCG3QcNsA9SZ
 vtKJ9LXwq9fwgmqiFyAGRTno/QU+d/QpOwAnaIXCrUvUEkBMH440QLQKC3+dzJqT/RTt
 qQIHm+FJz1LD0ixMrf4+LMRVXO2+83VekwcJ34eP6prYiP06+PL7/tpYRwWmPgU/JaF5
 6zjdfVn22cdFMb+NO0wid3R7/UhS5qXlJAdhodYCihyX1Qu1AEsMnOpfvCwtmAeI6CCT
 +FzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDO6PR/n84iQSXzimqBzUDQ7QcvqYZ/fV3wyWy00uHzIXA6eepkWaWuK7mpA0IIjWSHCCvPjw=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ0XTmRypGjBu/JRQYq8MImiCxC94g5WDoCYD+Co4pdwL2Hvuz
 3Y8cnCm9YLOECPakEcK6sIf1uexYsEPx7mAi6bmRz9tar7+9buS42g5CWyXLAUdrTaY2hhNFOaU
 EVR/gTrQI4N2/dc32GMJuqJNCSlx1rM2eBxEZ
X-Gm-Gg: ASbGnctTtxSWAtUnJstTBS16YD6jQisgDHH4v1vmSL1cddN1JxnpFOlF06fENmn+DbM
 b7USGu2cPEhytn1P85J4UZsLtaDhCm2Nnh4KJDf/+k5K0ewex4G888hrh//PHQ0e5IQSskgbUf+
 36fbrbJYRoCsJzPUnkOmBo7ggA1llOiFNdaz0LG6ACg/Y+veT9lOf7gTkbAfCubEdbkZ1mPeLvz
 FS8E7AE3mO95Oj33SmjKCE8Z2jLFya0cuyTlVUH7+KTSX1iR6qfALSujMOLbCSVFe/BAYBv
X-Google-Smtp-Source: AGHT+IGsXNITo8xTTh4+p1ioqEpOOS+R4zIhzw1NHuCAoTnfeURYUuvxB670St2vLJcHiOVRZKjCt87RGVEAUt1kaPA=
X-Received: by 2002:a9d:65c1:0:b0:7c7:48b7:640a with SMTP id
 46e09a7af769-7c748b768aamr476353a34.7.1763120120203; Fri, 14 Nov 2025
 03:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
In-Reply-To: <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 14 Nov 2025 19:35:09 +0800
X-Gm-Features: AWmQ_blfLHnsgQM0lGSg9ce-jSOvfedYJ53JCcwVMYeh_TcmcjLzSgLUANo4dAw
Message-ID: <CAN7C2SDCO8e8u9m13fFjt+HmS1H8uUdA6b0e67go29jkBCm1XQ@mail.gmail.com>
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

>  U_BOOT_CMD(bridge, 3, 1, do_bridge,
>     "SoCFPGA HPS FPGA bridge control",
> -   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
> -   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
> +   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
> +   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) bridges\n"
> +   "Bit 3, Bit 4 and Bit 5 bridges only available in Stratix 10\n"
> +   "For example:\n"
> +   "1) To enable and disable all bridges (command without mask):\n"
> +   " a) bridge enable\n"
> +   " b) bridge disable\n"
> +   "2) To enable and disable HPS-to-FPGA and LWHPS-to-FPGA bridges (command with mask):\n"
> +   " a) bridge enable 0x3\n"
> +   " b) bridge disable 0x3\n"
>     ""
>  );

With all do respect. If you have no clue what this is intended.
Read back old 2013- 2019 UBOOT style. These command
and operation is what backward bridge control via boot.scr
or boot env variable.

I am not here to argue, but the patch that touching this file
breaks all Cyclone V SoCFPGA and possible Arria V / 10
SD boot.

Meanwhile, if bridge control method is removed then all
H2F F2H control will be dead. So unless there are very
strong reason or better control method that can support
both old and new bridge control method otherwise no reason
to do so.

Brian
