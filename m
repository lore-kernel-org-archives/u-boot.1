Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AB606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WQdTxEGl;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LLuKYdVP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AE3340731;
	Mon, 26 Oct 2026 16:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pz3E8P7rv6er; Mon, 26 Oct 2026 16:34:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FBD94061D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032461;
	b=aT2n++hoDrT0FUDMOhCq3puFrThVdgfsIAqlEmHTiaFZylzUagIq3tXTQsOCyKJB4Bxr
	 oTicAkjr/MzMqwU2//v2ddLsTSWqeh8iqm1sDf0Acu5HMYQmzF5ETNa8wjGVhPaBSX/pY
	 Ap+MCq3xTXlqD1dhURzmAzK67+lTrEFn/5AS2avj4sprLQjEsGUBd31dQSWEaFR29ET7d
	 we42+04x4210b9yTplCkedwbuvNlK5lnEL90q7TsQk5HVhIixzdGltaTxzdWE9jNAIXgX
	 zaQ7WdbcR467dKijLNP7GAeh6ZrC3YaXELaqUL8d6d3wJJaY+GL5j4fYPgx/fFx1KKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wtdVoIXZ0OdlN1fxzEbPeUhDi1FjKurKDWFjFB68/Ig=;
	b=qv3eExNJg/RASDjLLd/mMewqN4VxEYW3+4dii2a1dI+Sj6XIcl+DvBmbXKV96FfeBMbd
	 7UcVimzkzziyUaY23ow6yxR6GomXOBq7yL3rR4oFCwMVjndAdB967poQ+j++va0KxH1Sg
	 u9bcVFNKVjkXu5f/skDI1lqOn+iezGZuWQYNFwk3Jo/25e3+xNcJwDWPO/HkTNCRlVlv1
	 Z7AVoW3vRK6dUYF6Gtmo30JyQtjcgv3d29DpGI3dp9QWnnpvOUPzfEovipRZDV1x+Wn91
	 LnGBiFzXvaBrFJux7iBozGZUHLoFkTRqUofeWk+ocJyEqC25jlKoDbBlTyNYas59BMQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793032461;
	bh=wtdVoIXZ0OdlN1fxzEbPeUhDi1FjKurKDWFjFB68/Ig=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WQdTxEGlI5qJbUALuHJwoMVYMWMyiU/rZNbKnDcdJa7e811UDuXwJMQdQXXhT9qbp
	 6dYIKMN7aCFtIg9h5cwpbSNrVZ4Xi48yS0WNK1gPBUnQOih63/ktoqBls5e94i5sd2
	 YEH+0788awChRFvgGfeD8Eq+MlffFTjfpxbaEzdcY2y7FvVvWKj8c30oHSumucSe38
	 pd8+/ijVUZX/3SV49Mwz5a7NGmGJVEpLb7bz/XSQIIn7Ja5/DjmjTQl/p97bKHpNHc
	 Sux76v03kKEiClUZmlhkdSwH7+3tVJNR/9E803TkxFbvzzftIT53qBseq4R9mF4nil
	 4fQLXuoYCBjWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FBD94061D;
	Mon, 26 Oct 2026 16:34:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 149AB2AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05DBE80DB8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hInGuT0XvRK9 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04E3A80DB9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032456;
 b=S//HV8tkSuXRVbQKymQ63XSk8/0OLfwASxBgKJyw7FVmRBHxGt2avO3eJ39e4EKwTgBA
 aAeYcu3r6f9vf6+GgVUKdsEUWkWbflN6PZq6NedsEV7VVhUCyj2atBBmveJ5tDxpzynl4
 c3L/BnU9HQRgRtX/OUWx8tWNEwE42SO8XcvgbAKq1mfu9wCB/aLcJKTLa2+svzfvW35KU
 xi74YpZyDIXZAueLVV+sXX1Hm+Xc/lZHz9lA/UHa9GL1i4ftY/x0VQXYUz+iVSEFzQU8p
 NOUmwU7Xj9tDZ/EN2MZxKYmC1JnmmIGDBTut2+BnoOF3IV2DTIbKE25AXiKHX5HLoXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032456;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=wtdVoIXZ0OdlN1fxzEbPeUhDi1FjKurKDWFjFB68/Ig=;
 b=cLTOiQ/D0sdZAYcRPZh7GWQR8l2PP+HueAlNHTwhViEgY6zRf1PWHB6qGhLUe6MeknRX
 mYxdfswjeyujOC6RWRuca0CZbXdWO3V8ASJ9BspJuKRBUpIIvYVcfG17I+T4jJ/oZu3z8
 i2ZN+HLFRmD/yhBFHvMzIv6kba2NxqgG0ZPdc23Edpnsp8SRBWpDZIoUH276c4J4YgiQe
 3Qfe2H4jJ/gKnzoofbNuR/sDyUlKzhSJPEhF84kgEKnFXbvcVAeiin9igMJn4TynwjBUr
 VcDLqE5tbkkmwj0vIwz50JB9aOX0b7vkY1scjUNiwT8oWOTjn1BTFEGQxm5zZWAZSbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LLuKYdVP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LLuKYdVP
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04E3A80DB9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:15 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so6345431a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793032454; cv=none;
 d=google.com; s=arc-20260327;
 b=sLw1NtS4SDmUDzs9J7uyRAOXL1oRkt3XVPL2sozK//SdX9Wg6BKJVDEklZ5nr2e8/n
 zYwueMQeOEeObPMHIgVssCmyttYxZ0Fb53N4PvWhW7G02eKcHUJdJsfKjHIbX9r6BQeI
 Qpjo+ffG8CRv2cyU4rolWVIB8jSzsDsvYHX9KpPx/j2wcPqLGC5wL4vm4lhWFDvCFJW2
 /cYgKBMZgXCN+85gxP85KEtrx/hPK+jmbgqPbV6wK/lp9pZrUm2gU/4cWRkUe/oQ3pTI
 uDO9CCL8gvg/ifFaCW8x6ukPTzllg4TFyUwQnE5mnrqi0dgdRONZXxptm5t5PYN/u4tx
 TcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=wtdVoIXZ0OdlN1fxzEbPeUhDi1FjKurKDWFjFB68/Ig=;
 fh=5PkvpXl88OM8KoIivAbK5HhQlV4b9silDRyHKw1GI9w=;
 b=HdLwEdohbfs1rrIdkgmShheU6WGS22CGiwyCQNaNPF6FJZTIAjPgRh4dG0lDm25fZr
 ajdBO/mzPOn0aHOuEVucy7WWQgqOJ/0vbhrpL3/AANlyvz++WwHz2RVc4emqpQpSPBo1
 Dw1dEele1tcwr3whdFVWucQS54I5/FyXzmv85k+c58xXi6VlNddlPuqUUcD9k9m2JpI6
 OmKz6pA/2yzbUBxoXqw6Z7i1trQhjD2bd1zeyHWUsNFEyBSurPKqQRn3hUa6v3pDRAok
 GjXlDevApqHx+LtTOhqNajVRGhc0JjTHAHAXikhJAyOvCNTMVjSX5mxCCs93JEdoqDNJ
 i9tA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793032454; x=1793637254;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wtdVoIXZ0OdlN1fxzEbPeUhDi1FjKurKDWFjFB68/Ig=;
 b=LLuKYdVPGRZR7E5WZa7WvsJfoANCwso75UpdU30kCTfTXb5i2xB/3Jb4wj/FleqtA5
 5nGSLqmKVSWuMd401QU7qG6S5E61+w4OBcVm25y85CG7MFWMuwuqoHppmPu6QUEocDBW
 nIxjGLNOvOQPJhtCIYsi4A3Jh211CX4trRPNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032454; x=1793637254;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wtdVoIXZ0OdlN1fxzEbPeUhDi1FjKurKDWFjFB68/Ig=;
 b=Usj98oiMmj3G+dh4uKmAMJscBsd5lJmaN1KbLvoH1IcbucvnfqY0daPv/aRjY/upmF
 yyN2inTsm6WhXLMPYE8QoK+bBhJ+usOtCtaUgpY0L7j3XxP2n6Bo/NU/POxTvt836qQb
 8hUHPwpjPZyTkA/V0P5EvsmYpsUZLutrPTTtJ4lTn6FZN5wkpZi28wXQqNcBbc0F1W0x
 SyWmTOAVZh/SDoQ5BY2rJ5dVPDZQYolzMZhVuhYx9doKXm2udcMOEOrpo+yPGbHO7noG
 L7sUrab/q5H0D6mvMit3+eBGzJOeJ0Vm/h+cJsnssQmbg6u+8KGoPpuGmzk/gf1t/IKK
 27Tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwRb9XiApuTroj461HTxkAxyDJJVVzVWfA89I2UnmXOkqq01DJ6uwzbwbb6TLXzBtEZcj0Vck=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLYYVpkIGWFKtOEiQB8ydw0eSlBeRHZbbSQy14M6ZWJkj5Tpc5I
 6GKFDxGdzf4+4R0XWTjWz7zfcztEL4dx46NYIh25m3gF+7nrZ8ySTP0STIC36AkVj4btaKrUKAV
 LiwBFW+NRtJr1qi19ZTvy02+jm4keHYuzm/GaagxN
X-Gm-Gg: AYBFou1evweUvlMVn/nCX/rviupLTBQIglyzjLEo2tl6fA528yIZn6Y/VRtql1zTSlR
 WGXrBzlmVO7AvLbJVl18eonINPPGs51SpE/1kPVxKNUISWje8XRgXT2IDgjpMelpW9VntZrIz+3
 MOk8W0ouEDFMR4LEDGi6Ek9ecgZ/ORnxqB1/dwnHBpvA+xG/Kja1M4jeKRfl1L22r3+nH8DOrrk
 7999f3dTLYqbxm0tLXThzAccEC5LOTUyuYXylJUXNHdyrSjZNctDTnRoLFfxP407X45kxqN5HZd
 RnNd0/unWgqEWDjRB7m/QoYDQuz2PzA6cZ/V97U0DYcfxT6DLEe3fqc8UdfUPeTg4NTiFSiG84y
 LAt4T85l4tRXGyDAXvLWmtopLfRaAdyium0w=
X-Received: by 2002:a05:6402:270f:b0:6ac:b861:dab3 with SMTP id
 4fb4d7f45d1cf-6b443112b17mr8986395a12.39.1793032453818; Mon, 26 Oct 2026
 09:34:13 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:34:11 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:47:32 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-1-f86616860bcb@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261023-mtk-mt8189-tfa-fdt-v1-1-f86616860bcb@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:34:11 -0700
X-Gm-Features: AclHuK-rrDXjhC24WMdj_aMEx-8AsYZd53ZhbEoTy_AdqK4Uh1iCmubCQSFsVa8
Message-ID: <CAFLszTh8aCgwOdA6v0O7k4-B_7pSBS1HYs6vBqCvwCtDXGn80A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fdtdec: apply bloblist DT overlays to the built-in
 devicetree
To: dlechner@baylibre.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On 2026-10-23T22:32:44, David Lechner <dlechner@baylibre.com> wrote:
> fdtdec: apply bloblist DT overlays to the built-in devicetree
>
> Apply the devicetree overlays passed in a bloblist in the case when the
> bloblist does not contain the devicetree itself. To do so, copy the
> devicetree that U-Boot found by other means, e.g. the one appended to
> U-Boot, into the bloblist and apply the overlays to the copy. This runs
> early in the boot sequence so the bloblist is the only memory with room
> for the devicetree to grow. And we can reuse the existing code that
> already applies overlays to a devicetree in the bloblist that way.
>
> This lets a previous stage describe what only it knows, such as the
> size of the DRAM it has initialized and the memory reserved for the
> hardware, without having to provide the whole devicetree of U-Boot.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
>  doc/develop/devicetree/control.rst |  5 ++++-
>  lib/fdtdec.c                       | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1818,6 +1818,36 @@ static int fdtdec_apply_bloblist_dtos(void)
> +	memcpy(fdt, gd->fdt_blob, size);
> +	gd->fdt_blob = fdt;
> +	gd->fdt_src = FDTSRC_BLOBLIST;

The devicetree did not come from the bloblist, so this reports the
wrong source; FDTSRC_BLOBLIST is documented as 'Provided by a bloblist
from an earlier phase'. It also has a side effect:
env_update_fdt_addr_from_bloblist() now sets fdt_addr to U-Boot's
control DT, which changes what bootm, booti and pxe/extlinux pass to
the OS when no other DT is given. Please can you keep the original
source? If you do want the fdt_addr behaviour, please mention it in
the commit message so it is clear that it is intended.

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1818,6 +1818,36 @@ static int fdtdec_apply_bloblist_dtos(void)
> +	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
> +	    !CONFIG_IS_ENABLED(BLOBLIST) ||
> +	    !(gd->flags & GD_FLG_BLOBLIST_HANDOFF) ||
> +	    !bloblist_find(BLOBLISTT_FDT_OVERLAY, 0) ||
> +	    bloblist_find(BLOBLISTT_CONTROL_FDT, 0))
> +		return 0;

One thing I'd like to check is xPL. If SPL receives a bloblist with
overlays but no devicetree, it adds its own devicetree, which is
pruned to the bootph nodes. U-Boot proper then finds
BLOBLISTT_CONTROL_FDT and uses SPL's cut-down DT instead of its own,
and applies the overlays a second time. This doesn't affect MT8189
since it has no SPL, but this is generic code. Perhaps restrict this
to U-Boot proper, e.g. with a check on xpl_phase()? What do you think?

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1893,6 +1923,8 @@ setup_fdt:
>  	ret = fdtdec_prepare_fdt(gd->fdt_blob);
> +	if (!ret)
> +		ret = fdtdec_apply_bloblist_dtos_to_own_fdt();

A sandbox test covering this path (a bloblist with an overlay and no
DT, checking that the overlay ends up in the control DT) would be
good, perhaps as a follow-up. As far as I can see, the bloblist
overlay code has no test at present.

Regards,
Simon
