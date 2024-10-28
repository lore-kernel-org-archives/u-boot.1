Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA50FD13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 05:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4706E88FA8;
	Mon, 28 Oct 2024 06:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XVDH8KKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EE888FA8; Mon, 28 Oct 2024 06:54:26 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7446888FFB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 06:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730094849; x=1730699649; i=xypron.glpk@gmx.de;
 bh=GylGdNrzVD6ZI69ZpbFcRv3FjdeGYBrxv11L1ObWIoE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XVDH8KKHINN3tpzZxgPnCvfLfLEkP0dSdWKcPN/jP871E2wjuR5wWvBkaYUQULJg
 SUC3+GDeb5pvU7R2uFswYEDIfgpRTURHYYjKeyQ2n+ntB696BMj5UH4At9lo4ykdh
 o9CV4oMl8sKxpCAwSiSqqf4hyCO/ZKtb8djmuRfPL1VFts/UF2+6tQ7qXQQgELOV8
 d2UiWd6KUXz9iCZ/JlNI8MJfK+i3SOEG5ukhgaY5S31US8n7BW3iR7kevYzcD/k/Q
 IidVW61UjI7z2EmSUn+SHj/CTYIZuVFXEs2eGQIM04QlchG1EykivnXDMKb05PJXb
 KHbzOmnVLZjM4lW9sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1tObkp0mmQ-00SD55; Mon, 28
 Oct 2024 06:54:09 +0100
Message-ID: <f5d2100a-bd30-40b1-a305-44475070c5ce@gmx.de>
Date: Mon, 28 Oct 2024 06:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/8] test: boot: Update bootflow_iter() for console
 checking
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241022120032.196311-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z8V9CA+wd+CqdWB9bdSiVU6VmjZV2W7MOT2ET7ACxsnbrChWAlj
 DtNQP5o5F/2hT31e1Dd3hUArf6u5K+5XmmmIfjmX9rJTm8xblEbK42GhqoO6ymlvV8d86yQ
 PXj+0zSAMxTqS9V6FgRMEtV2+opA549EbclVUeEbdodXqhLa1iy4s2UHeIPF1lZu8zPB96+
 xZd8+ZlOQr6qJFRyFSR0A==
UI-OutboundReport: notjunk:1;M01:P0:FhaXVLFHRP4=;bPDyTcCJJrIa5kASPBLokVpbjAf
 ZKlRprnKk6ToxP6SzgTgcbpOav2QT+YOLVkRZYHWLZUgejeVmSmHjhMIjgcL7/vvcKUB/Grd3
 EN+YcNMhhmMylpXgLejzPxd5SR9jcozwTd9NkyHqAhk+fvNel1wGHsKqtmrw4HeoD98/nTfVs
 DS4OQcW77XR/GdDy/tkbw/MZSG8q7L7HI0kvs2zwEPqBp1hWwLHQpwUddIKc7yA1NIHFWBTyY
 bHCCcjW4Om14Ub0IHm39UXbv4MvrHUmjdhEL6JJkVCm6gKCp/FyfKP/XZw4+nDAyiurFfadgU
 9ua5WB2ke1tsIJdxtr5w23mRrVWrqOompj1q7fwCF7TEqSwUnAeUXXGh3rI1qBdSX5ToAJJQW
 R5DEgSq3sgISN6C3ceuCsDCXF6HUCVGx4pQ18INXOQJRngOeOSWisSgBWSaMa9Qpfhj4exAjD
 KR/hnGel4Kppn7f83gfhdAqmOLLADBYTH2255WRVps/A1+2Td1jfy3VBVS/wcS7tq8j2oJlc0
 +3eO1NDcB8oY2vANk9tA2jkHPicEbzKzSI9AjMYQJHF9KH4bTkN4jutToEaCm39yV3kMy14D4
 Q1xClADRNBUAe/ZjnYG1q5ozwq0jdiSyfy4JUTalNgnC8KkFz1FwCUmVPb4/BYB8hlCzH8Zvb
 UxtuKIJonSLJubGf14XtbrWrX/dW1Ng5CwSBkAmhAPnY5LMUPcTFEGn2NYa1j8GdadU+ybQMH
 O2DUUYL/8CgMAyGaureB9T58hHExKQx8ghz1e0i4tGWxMZVnylwEF4ktD/zF78DsNTmKdKu8L
 y0SxNdPH6RkrLXHJB5K4Dr0g==
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

On 10/22/24 14:00, Simon Glass wrote:
> This test checks console output so should have the UTF_CONSOLE flag. Add
> it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   test/boot/bootflow.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 154dea70a59..cc894e804a4 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state *uts=
)
>
>   	return 0;
>   }
> -BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
> +BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);

The test invokes ut_assert_console_end(). But where does it check
console output?

Best regards

Heinrich

>
>   #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
>   /* Check using the system bootdev */

