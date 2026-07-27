Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78781C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26940406EC;
	Mon, 27 Jul 2026 08:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVUGar0e_C1k; Mon, 27 Jul 2026 08:25:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42CC240621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785140706;
	bh=S6rz4h23O1RMtUWpWzAzye6tr/gm1Vj9WBpQFe6i2aU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VRAKUKRPQ9KSD6pH5GAh8ONzvgxO6gybvNqoXBVvDegubq3LUDPKfvNv1tZOWuhMC
	 4t/XWkcc4STYSgfUQKw3FUkpQt+aRLnNjWNdKzciyTvQEjCql6/ZSzesY8sjXhK+2H
	 DKy+NXm/cx0wGTtHpO4Z/KUvFnBxu4yHtZoSqV6lVYPL6hY4xTAjbPQ3LC04K9X9YW
	 xu4Q/yRmeXw6PrYXWV4AHL55RDYlXWfnVyYRkcuBoMDEdbwSL7xUnk9fPE83o4VtQy
	 ZwZx0vrYZWoCOab8L22btEEN7HhAvG6aI0bwkQUv4Kez+fcNejtARaU7nw/BLS4dJp
	 GvQizv9eK+UFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42CC240621;
	Mon, 27 Jul 2026 08:25:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12620490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04705400FD
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:25:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E0oMtYVQKwve for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:25:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BE173400F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE173400F3
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE173400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:25:03 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6682259cb3dso3712530d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785140702; cv=none;
 d=google.com; s=arc-20260327;
 b=AGDjxHe6l4RTEo1PHd31dmCB0ccqwIU9MCg4tRmBUS68/gzWkf5DU7AUdf/IecVjAV
 TrVEQo4d4ahNq2NY4gwnEAqVHcfOaebsNbGL2HWET5QJYQKMO98G96wSIicw6s0Dnb74
 ExKEZ8MAn+bdr11IkYthRZHl0vpLBS/JI6POti0weStw8D+zQ35gRNkNP+/CCJ25MEJN
 p2U0anGXHomc6ajzE2vhLtXwfYjRBunpvmy6iwolMcuAfckEkKnZDxE2mQBw+rcTpT7J
 llqJ3v0sjZKOVLEdME3wvsrQBmj3c7IPUV/KWHXlpeY8qTej4E5CJxyWPHKTV0TY7rUw
 y7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WLuEpqXyai4dhup8uM2MHKmQDNuA3uqmnMu/ukNdbAs=;
 fh=5P8CPwYqUsEHzQUhCqLbcS7kMp503PnixvJNaEOE2DQ=;
 b=KvQ/iycZcIy4YjoFXaD39I8pLVMPjImEvbINbESt6D3ZC64AHXirgw5lx99/PN0IMN
 lXwT8p9chWCjGeNaqNlKADlbswJPtSB0JnG+L58RCY+GikXiEc5G+dQdTx1vySV3yRGD
 S8m2GXL6Ev5IbthH5B8p0m+LiY1zYr8L8h/2vVG7U3MkuvDwa5TiZV/mkOzuzV6mEypw
 iCAPgohMsjPdRmDkbPCiYSMlzlqGdueLeJHo/HVKu4BMbgptNky/dehaebASFGma2rmC
 jxVPTOJBVmHq3VlrYPJXBNkGuBbOlV24pWYfAu8Q6hRqUDrtC6L9bsHrEGlefEOEraZT
 GDkg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785140702; x=1785745502;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WLuEpqXyai4dhup8uM2MHKmQDNuA3uqmnMu/ukNdbAs=;
 b=GTtVSnNzqdUPF6Mo1yvb2eiNS5V2sqDmEDEPn1+cefj0K3tI2OQzK4p1McOEoCxb9F
 r1m+eIan5oSFVg9r073k2nvNwv2jMMH0wybjmEnEejZNyKl+MtYm87bPbJmc4lWId2zA
 0i13VZb3qldVl2I9+ErMhI38VSlgX+4nbT5LP3JVBgjmu1mqaB1FL8uCWFmleU8oGQ8K
 x/T1S5nN25+BXcCH0+9BLIIDYgw078QxB6NWAgGHqqslE1Y9tTEfxVVqECWLWl+0Asld
 BpTi/eSWlYuxcZREGxw+lQ0cUEMRBykWdNR5/oLUgLsVAr4cbBJ1yX69Y0t3pyUGbKnb
 Mpkw==
X-Gm-Message-State: AOJu0YzvfYfOFtVmKWN6XKCDLrmX5HdUYmyGdnPMAUXb7BrgDt/cUshs
 VgTMskYKhzZI1qtApPOHrFiMyrLXLqHR0T0EVvaC+eUm1Wr95I6zTCF9JU3g50wTl6f9/SekOST
 rLN5qiDNAkYthSpt6W77QxsWy9Wpp6pI6bk375M9/LkRp8/7oWXu+WZzEtQ==
X-Gm-Gg: AR+sD12vqjs5T3Y5aitcSheCoMPmc53PFuhKO94S5HQtL80s3burHDPjhngG8TGZRTe
 0aF20zaVkVPwfHiyZCVt6vuivqDmdaR1MyFVV3j2XgQVVi2473o+I0y7ZOw2sLz/rdkRkMbsoob
 qCMYrbA3AMR1wBehxxuJATdVl8rfNdPXiHRZfD5zHpukzS927XonIfYNUgKWtWQOjxWbzK8r+11
 rq8ryknvPt5lPM7qZ+eq9ZZp3lsSt9vHE1V2idaQ44bcFJG/XIUpdkt8TBdDn6ShZuPfF25J58q
 xqwGQXJdYbvCamUNYT2sT/hkUK7HryMTxT4577AsvL9kDejXY4sV3+CxvADxJRI1n3J8h/MZ12m
 jrCuO1to7595QV13jqWBSKY2DM34K+cpuUWep1+xuQ5difMqSVRH3zc2GGGLU+J+rf3wDw0Yf2g
 +LGeyaG/FudWv4I2TXXgKEYkeh12E9zy6J9pZKdnMdKJnY8ClIkNW84LGNuiR7RHoFNMQuGwyhJ
 jW9G+RX2E27GcIHWINwOYjt0uhSEP0DJvuMvHIB7Ty+6EYxAkhXqyrR1v4/OkYojhGHp7Yq04fu
 bIFwL+Vb5At5B2kAxReRsIuOqFm2YkEBtCjZfnCv55275+06JjGlCVUSEn64
X-Received: by 2002:a05:690e:4411:b0:667:f4c8:1119 with SMTP id
 956f58d0204a3-668c7a309a8mr1293153d50.2.1785140702065; Mon, 27 Jul 2026
 01:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
 <20260724-tpm-trunc-resp-v2-1-381857e959f6@byteray.co.uk>
In-Reply-To: <20260724-tpm-trunc-resp-v2-1-381857e959f6@byteray.co.uk>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Jul 2026 11:24:26 +0300
X-Gm-Features: AUfX_mxf46HTQY9_ctJmlHcR69RT6Od_cq4eyrktrSlTGPh1IDT_VK9Va8_t12c
Message-ID: <CAC_iWjJFyFyhgiFNiGmqGaCJAq+C41PWzGrG66_JDg9CfMXfxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm: bounds-check the device-controlled response
 length
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>, 
 Che-Liang Chiou <clchiou@chromium.org>, Dirk Eibach <dirk.eibach@gdsys.cc>, 
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785140702; x=1785745502;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WLuEpqXyai4dhup8uM2MHKmQDNuA3uqmnMu/ukNdbAs=;
 b=EO/MWi0Gihn4gsg7T29+81CAHpyXzKI5ISrOthRpt7pwyN+Bwkl+nrrbPFGWJgaxZ3
 iNIFms7QMm3+71mgRp8pxzdXgtw+bmYZZXFNJmw+5LF4PNUwsGZl9aIM0Lp0h39nirD4
 lJzncPiqfQRciAP7h4pftU3vFO8yw/0zdBKJC25Qg+gJrd3jHZvww93bGHTW9NXJF14i
 7J2pG1uyf1A3iB681zdonDzxxKCT8XSSLKKjC5XULxJc9UNdVX/FxQ/RwxHwogOHN7Mo
 jtc1GGv2qY2Hu7P/kxQgxYJK8sTIzOA7/t5Sy8ayUxREV6NyWQ2oGESzmBKJ30dMM+Ft
 n+YQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EO/MWi0G
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

Hi Shahriyar

On Fri, 24 Jul 2026 at 13:34, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
wrote:

> The length of a TPM reply is set by the device: tpm_sendrecv_command()
> stores the number of bytes received, caps it only at the command buffer
> size, and reports success whenever the reply's return code is 0. Callers
> then use that length without checking it:
>
> tpm2_get_capability() copies response_len - 15 bytes into the caller's
> buffer. A reply shorter than 15 bytes underflows the subtraction into a
> huge memcpy; a reply longer than the buffer (sized for prop_count
> properties) overruns it.
>
> tpm1_load_key2_oiap() and tpm1_get_pub_key_oiap() pass response_length
> - 41 to verify_response_auth(), which a reply shorter than 41 bytes
> underflows.
>
> A TPM sits on a discrete SPI/I2C/LPC bus that is physically accessible, so
> a reply this malformed is reachable by a bus interposer or a faulty part;
> on the TPM2 path this parsing runs during measured boot.
>
> Check the reported length against the header before the subtraction, and
> against the caller's buffer before the GetCapability copy.
>
> Fixes: 69cd8f0681f4 ("tpm: add TPM2_GetCapability command support")
> Fixes: be6c1529c1ce ("tpm: add AUTH1 cmds for LoadKey2 and GetPubKey")
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  lib/tpm-v1.c | 6 ++++++
>  lib/tpm-v2.c | 8 ++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
> index a6727c575fd..5fd22924b28 100644
> --- a/lib/tpm-v1.c
> +++ b/lib/tpm-v1.c
> @@ -757,6 +757,9 @@ u32 tpm1_load_key2_oiap(struct udevice *dev, u32
> parent_handle, const void *key,
>                 return err;
>         }
>
> +       if (response_length < TPM_RESPONSE_AUTH_LENGTH)
> +               return TPM_LIB_ERROR;
> +
>         err = verify_response_auth(0x00000041, response,
>                                    response_length -
> TPM_RESPONSE_AUTH_LENGTH,
>                                    4, &oiap_session,
> @@ -817,6 +820,9 @@ u32 tpm1_get_pub_key_oiap(struct udevice *dev, u32
> key_handle,
>                         oiap_session.valid = 0;
>                 return err;
>         }
> +       if (response_length < TPM_RESPONSE_AUTH_LENGTH)
> +               return TPM_LIB_ERROR;
> +
>         err = verify_response_auth(0x00000021, response,
>                                    response_length -
> TPM_RESPONSE_AUTH_LENGTH,
>                                    0, &oiap_session,
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index f443b738f82..aa4d3866d7b 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -519,6 +519,14 @@ u32 tpm2_get_capability(struct udevice *dev, u32
> capability, u32 property,
>          */
>         properties_off = sizeof(u16) + sizeof(u32) + sizeof(u32) +
>                          sizeof(u8) + sizeof(u32);
> +       if (response_len < properties_off)
> +               return TPM_LIB_ERROR;
> +
> +       if (capability == TPM2_CAP_TPM_PROPERTIES &&
> +           response_len - properties_off >
> +           sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property))
> +               return TPM_LIB_ERROR;
> +
>

Thios doesn't llike a problem for the capabilities only. Can't we
update tpm_sendrecv_command() with an extra argument of the expected
response lenght? We can then check that for even invocation in the function
itself if the *size_ptr != NULL

Thanks
/Ilias

>         memcpy(buf, &response[properties_off], response_len -
> properties_off);
>
>         return 0;
>
> --
> 2.43.0
>
>
