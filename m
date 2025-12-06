Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133F5D3B7E0
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 20:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728B1839B7;
	Sat,  6 Dec 2025 21:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KH1/9nAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6132D839C6; Sat,  6 Dec 2025 21:02:48 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2625183957
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 21:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5957e017378so4202956e87.3
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 12:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765051352; x=1765656152; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfGL415RpCsxry8BnfuHQqZiPtw8+il9RbnuvBu5U/Q=;
 b=KH1/9nAl144OIqgdIYQQs4uj6yYeHlxjfyTjibh+TymsP4BGn0DWOrZrxAQSC2FPuo
 k7KVC2ff3trYXLFgoxiP+Fz4BSE5NmR+5tHZBpm5qKxiGnvaoEui6KqZIaQNc/DzYsUY
 q0JL8O+7s56SIYFFF2WqKZSnh3jCOCr6jwIqXB3sVdibDWjy55x5i0gFaYsuEfw46R3X
 myKycQvYY5nxsCHA0LALceCznDckXIrHubvaAMCB3Tf7tjjZ676btFFYayXnekLOUHkq
 F2ukLYIO3Egx4DZtp0lu5JeTSeG0rC8XaywClyivikE3leEGWfXdvRzmmve+I42goOLF
 jC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765051352; x=1765656152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bfGL415RpCsxry8BnfuHQqZiPtw8+il9RbnuvBu5U/Q=;
 b=mgsHQZCrvgu81MJxhsFN5R9qCQNCqZoNs9BdBWRf/fkWKtBmNYiXdoGbm+rjJhD/U0
 CYmezQESpXONhWQUqTmAIFDDlcxa3Ged+3WV3fbNfvknFmfEoHj+UvVE7HZ207YN6vkG
 X+Fwz2iytuuSFhvHG2CI0pEBxQsGBCTZLYkb4UonA1WJPQ9fhiNMrQ6vr2vIqpgwOqNW
 9u3fhJ+nZMK6/Gkv+6hOn+/jXBBrkSfadO/n7alRg8cnQD/gkWMdRvwigLLKHhDJNR/d
 +yyrhowCNAyuOGVtOhH8dJ2mUOrAikrL+hn1qAkWeuN/woDN7UkTv8igzI7IEc+gJos3
 aOeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLH8MZnOBoAi5KHLVyrdB+NERrMfArdcTCcDpucsDznhFm5/kaZgI/uQZfIjXLFFij8B1SAIY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3NzCT+YEguvOLuufFSifS8SQvGrmXHkOtp8UODHJk6BtwpnOY
 083X8rQyXY/OEgUT9Sqt1GAbGSwdBdqDs4Hh/d5e443n+2JDzzgCYYNhkugMPL7jzCqVyrUM7Mn
 tkMujbG41wnFOEvdBE2OEwFis6+jH9hc=
X-Gm-Gg: ASbGncslSkd3XDPDPLAmKUlO2KJM/wimGWf7hkklYFAHFtDTSNezt/dd+EfjvIobQ/x
 S71XTaoEvgyYBLLOL9W5cE9UV4Qmb15XhUabC8e7s1vqDPihdinc1ePQGBcnXFocoqs27g2IVqr
 IIzPZSS3PlAKM5YSN3yYHbtLt+FMJHZ1eUalKpG1aFXj9Z2NxERDWCvgqmnJ2d63Z3klBICM+DC
 DDD63cjvd57eb+wjCa8aBLnownKxmRghwSS1XeyQkjGQMKDVKnIZE0somRuzf317gCDO17VCUvh
 bZeGfVgO3k9O2075w1y0aBVd3yQ=
X-Google-Smtp-Source: AGHT+IFhoDlQeZ+Jlg3rjSM3zI3trdem6KWnZR956Fi/9OvYgqNOjL4PvmeTW5fd8Q5SeyGleBvwVuf2KIpiIqwqhrI=
X-Received: by 2002:a05:6512:3d0c:b0:597:d693:ab64 with SMTP id
 2adb3069b0e04-5987e88a7bfmr897253e87.18.1765051352084; Sat, 06 Dec 2025
 12:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20251201-imx95_b0-v2-1-7bc9851b7456@ifm.com>
In-Reply-To: <20251201-imx95_b0-v2-1-7bc9851b7456@ifm.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Dec 2025 17:02:20 -0300
X-Gm-Features: AQt7F2qdIKgkpPSCX6fdUPbzBPC2OeX0Qd_vGp-wfd6-ZPtUMcR7GeXu3bMxLHY
Message-ID: <CAOMZO5DO2JcAXeu+EODiyoMp9t1rvPN_2=iJpexWmZZ4kJ2Rzg@mail.gmail.com>
Subject: Re: [PATCH v2] imx9: scmi: soc: USB instance number change for
 silicon revision B0
To: Fedor Ross <fedor.ross@ifm.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>
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

On Mon, Dec 1, 2025 at 1:08=E2=80=AFPM Fedor Ross <fedor.ross@ifm.com> wrot=
e:
>
> For silicon revision A1, the USB instance number for USB1 is 3 and for
> USB2 it is 4. This changed for revision B0 where the USB instance number
> for USB1 is 0 and for USB2 it is 1, which is the intended instance
> number. Select the correct numbering according to the selected SoC
> (IMX95) and its revision.
>
> This patch is based on the information provided by:
> "AN14750 Migration Guide from i.MX 95 A1 to B0; Rev. 1.0" .
>
> Reviewed-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>

Applied to u-boot-imx/next, thanks.
