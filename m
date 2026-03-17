Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF6FFD875F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA5B84277;
	Tue, 17 Mar 2026 13:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="NnCqXCc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E0D28429E; Tue, 17 Mar 2026 13:38:41 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96E584258
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b97b30fa5e5so396019466b.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 05:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773751118; cv=none;
 d=google.com; s=arc-20240605;
 b=b50i2NLuz1VSIct9WD5ZHVm2tVRXQRmUhhhvc/vr9F2oNjQAc60gDjPDqAHoGGcTSE
 ry8rnW2Wgv+OLo6taPvvcwTruVuKoiE80wIqO5EvilMtO5K/sDQwAWxjBE2vy86pZOaC
 r9rGfftent7imxO3Mu06NBWPkj2wG7y3qQPhT27PAOHxVJJ4k8IPZvn657Xs+visVdch
 JYH3933CaLzlklBioiet1j9UqmO97ECeAERn6N/5zJR0NkPnB/P/DxLHgkT5z3Kc5X/t
 /7KZki2WuTZ/QuxXIlRz4ymZlGtUQhllyZwA2CnjTGWIQj3Gy4D2gm573ZARCXruvKp4
 guwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wF95OFngTmg5CQArlpltjx69KSrUnI1A4AJQxI1PLlg=;
 fh=iATTYGmqyTc7fooQTq6JwRstiJEIqXhTeWqwsyFlAFQ=;
 b=QWGpgcGVYFhYMr5zvKDQ9EHLAdp943kQaNWB8/G22zH3cgeSDqDO3LmWDozSoedgev
 W09AJBLxP5Flvt9TrImbpmhaZ2rszKLGPPX60AyxfwUZYkcBEpQBPNx6JFXjtegE6Q9I
 LVr22c4NGc8Kir3KQZoHayf8OVF/hbb0Mrm8skDhJ8SiTlpXykNYUNkm54dxCA0P3p7J
 pvP04pSSgl1uPapwBJEVP8zVsHnLSuwBRe5mID5FFOHPQN8bQQ9JoGt9+f7/9PlKkdjX
 cKEh+alsFif+xoykOCp++DfQbWRZbjYCxGqWfDEKP+GeCDT9Xhd8caXSooAjzcOY0uxN
 jhHw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773751118; x=1774355918; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wF95OFngTmg5CQArlpltjx69KSrUnI1A4AJQxI1PLlg=;
 b=NnCqXCc5dw0aG9wFR7D+oeoBWA84p9/rJQkeFveFZK5qcIkz/sct6wIr8zyByVbR0I
 Memjvq/T+x49pzCywztIrKBZOQGb2csSq1pvprflAtqGS7NjpJgxg1Hm75YCA1bAXyBv
 gfnGM85RAZGrGRm+PwNr3hgY6WdBBNV27Lpe0xyxHHNGSkhVPN3x/httrkU1jg5xCAwD
 zWmEsIZmVKH0mO3tRNguAw7tvBg2sUNyXLJcNx+63MpBSqcvgjvhz7/EXJWe7HpgM/MO
 DDA3ajfboGKqHLVWxQknrEYKkTXPSbQDjeNWCakXNIpWqoeDNGasjbL9d0d/vbRo8wTU
 LnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773751118; x=1774355918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wF95OFngTmg5CQArlpltjx69KSrUnI1A4AJQxI1PLlg=;
 b=Z2ipp84aMclXn4SL4GfORRq5tzZyZ3yqhODEOpLZdnxbVyP/garXUjD0efJL0+10pw
 kcW9NOJeohpAd7BJRd27gv6F+5z+cBBV5hxjnmSqsmiCDF9dYjwpJH3OCHmzEVagNbQI
 71BbgKOIsAQEFg2esDaIsWiNT72oCO4ykl4gBB/HhqOBm8O4/wuKhJg9fidtw/xyTeNG
 pRCjd+5jq5R/dz3AoSkVcGbWcgc4rUovP3XeOhDaT5IvHVpB+nsnR9z3m2QV5wMjZHYy
 6j9oCEjbqJUPreJAgNmzXKTG434ybnpZQi9dFfnnBtSXPNckRNgqJZZO+ePLmHDwCL9b
 YN8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpeWWr2u2eaPXnG96nB1xemVAwH6HqmPejWvzfyHTl6sdvruoIDGmj9udD/8X4bEHkI07VsP8=@lists.denx.de
X-Gm-Message-State: AOJu0YwUSGBhfRFXq8IpYYiT9eQ8JwBYPZdlleTUSqTKxl+a/I8vjRxp
 iMzxzhAzX77vyKqJEFJAwyLZVpdIw4KdYDY7DkVMkPlEIFxh7ab/51o72XvQASnhA2uLImMY3e/
 DjC6VnWy7+Rz7Ekr6GxZzMERifm7hKVtKssj1iiksHw==
X-Gm-Gg: ATEYQzzIiSjFkDTSg+w6augw1KY9YsUPEanmIsAAvsAsyVgIR79ksH+rWW1CqDZuI2e
 sNVhiFUay3KhKAQCBXWszg0BhNSU2/Gs9ZaUzNrOlgK0F0tbueXgUZ5ihQ75G3WfRFclfwtYImE
 lLOzbIqzm3ifDRNQMys+03GvKXpE3Z8t/k/QvbvVnpdw4/Q1T0jH8El/cdDpKzHbPpivy3eJmSe
 K3RlljXQ0dKtDhcuEdJV28SXCmQkazY+iyYI1kf38GVVmnJ934NKAMio7u7o1sg2LAcpbNOLk3B
 9uPA4nU=
X-Received: by 2002:a17:906:c38e:b0:b97:80cd:e4f with SMTP id
 a640c23a62f3a-b9780cd0ea0mr608690066b.55.1773751117572; Tue, 17 Mar 2026
 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260316-scsi-inquiry-len-v1-1-a8176ee6620d@flipper.net>
In-Reply-To: <20260316-scsi-inquiry-len-v1-1-a8176ee6620d@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 17 Mar 2026 16:38:29 +0400
X-Gm-Features: AaiRm53MNoP6RgOXquE4iUVoAw17pDQKc0_LKmFaLdE4LDNJSmaV_Ov8U4IbTX4
Message-ID: <CAKTNdwEf+jx4sZ3TVMYR4ZWL0a-=UOUP1r4HgKKtw=3PDkxORw@mail.gmail.com>
Subject: Re: [PATCH] scsi: Fix oversized data length in scsi_inquiry()
To: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 macpaul.lin@mediatek.com
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

On Mon, Mar 16, 2026 at 8:42=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> scsi_detect_dev() sets the inquiry data length to 512, but
> scsi_setup_inquiry() only sets the command up with a 255 byte length.
>
> This causes some SCSI devices such as the Foresee FEUDNN064G-C2G07 UFS
> chip to fail to respond to the inquiry command, preventing its detection.
>
> Set the data length to the size of the scsi_inquiry_resp structure, which
> is the maximum amount of data that scsi_setup_inquiry() will request.
>
> Fixes: 570712f4bcc4 ("scsi: Extract device detection algorithm")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/scsi/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 8fe6b38a8c74..6a3a91b1d32b 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -513,7 +513,7 @@ static int scsi_detect_dev(struct udevice *dev, int t=
arget, int lun,
>         pccb->target =3D target;
>         pccb->lun =3D lun;
>         pccb->pdata =3D tempbuff;
> -       pccb->datalen =3D 512;
> +       pccb->datalen =3D sizeof(struct scsi_inquiry_resp);
>         pccb->dma_dir =3D DMA_FROM_DEVICE;
>         scsi_setup_inquiry(pccb);
>         if (scsi_exec(dev, pccb)) {
>
> ---

I noticed that Tom applied a patch by Macpaul Lin [1] which does
pretty much the same thing, which had already been reviewed and which
I haven't noticed before submitting mine (it landed in next nearly
simultaneously with me sending this out).

FWIW, I can confirm that Macpaul Lin's patch also fixes the issue I
had with my Foresee FEUDNN064G-C2G07 UFS chip, so my patch here can be
dropped.

Thanks a lot,
Alexey

[1] https://source.denx.de/u-boot/u-boot/-/commit/041364141b7daef8318a4b849=
5cac8570002773f
