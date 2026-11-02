Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EB606A334
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZEkjNYcp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L86w8VUM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48FC56066E;
	Mon,  2 Nov 2026 22:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOo61pkQDBCd; Mon,  2 Nov 2026 22:15:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34F2D605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793657734;
	b=HO8j7/Ahg/i4z144Ss+nEizCw/aR5tR95DaW6sHolS0uGnzqd33jW6BkSWT5MwZ8Vhe2
	 VHobAtESOUhdD8nSaSmZByj0kG4zvNChKPzbUcyiYxhc60tVULGO6Zm1X97CHgJ4AkcMp
	 25QQILc3CeWCALlAarbz1JrSuXOb2ocdz1/AsxJ6XLqlUlasKPr6O1Cz6kpq8bgENO6Wx
	 d2dB83tBHhIe+6qG/sm2p/mLmkLLnX4O43jm9LoNUnn5MG5MOSQ9jeHu66lGGwHxJNL7H
	 4iBCSVmla/JHax5zQMo/wsLsOhfqfpFeebNahPe/u5e7pHekfNp6axM7/8SEtABNRPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793657734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fWVF7DnBvRCMbuRI3hUDqKUgc9uGNITuwY2BxyA7Ubo=;
	b=pv6VtlmNtZntgh0gRBH/p4yRxrCwAba7cb+p90y0GhZXqBGW1TQSaiezDKfrT4SLc3TC
	 0vpQcM76JKGynpEqHg1srXvQFjqV9AJpK7sggGAku1OmbGeMTsACVgTu8QR8+1N0fO5nE
	 UnLSe5Hvg1OvkVba4ls+JtnddFxUaSBOYyaf0tFU8ITylIPcEkwjdqu/BHufaaP5nGRbT
	 dYDUlkRIYai9tWlIBgQuLajLgk+6LAOrorPzA4pOnXSxMrZ/uN47Ot6xyuIj1h4h9F4Dm
	 i7JeBTsi1nMnJiC/RR8X26gbOdwqLcX9X9l7dfR+woUXfS8TPcs+VLG0l3AoMXGSrGg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793657734;
	bh=fWVF7DnBvRCMbuRI3hUDqKUgc9uGNITuwY2BxyA7Ubo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZEkjNYcp4U/mUly1ePrQrDJmgcE7s1uPYZwMEY38SdjMJA6GOIHFtxr6O+CBKhBwu
	 tFFdrO01IpZE8Zf8d0gzddMClCoRTRMovDaBksOeVEfkqgG/wR4EjnqlPRmIVzYdj6
	 3H02fcKwnTyvw8rWIdZC2xeN+XdlHbWIUHq6slByGBUIVd4dt9qy5tIkfYpg8Xl9Cp
	 cUXwGgEa/sWAu/pyXDELjjz6+VzDKmifYNjtX9hXl9KZumNLwvdzqRa6qxi/Llf9zp
	 V7Vj3fle41WkGsh5qzO55G0/AHiK0rV7Pwz98NHJsUzYi+GnLMBw7ZV4T1sh2ApdIM
	 39zHRVDqwl1OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34F2D605E9;
	Mon,  2 Nov 2026 22:15:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 35279A15
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3267380C3D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLPALeGJR8h8 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:15:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3FE3D80C3B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::82e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793657731;
 b=KG1g/Y0WuqVaZQl5TYYPSkKmUYwSpVoYbguJzTgrtneYCBLZJSMG9iHftXNDUK7MGCOj
 xoO220lkAzhzlwQ5JiSvpv2T5cyJvyGhJc7D9hl7aJ8YnxtTMbK1A89WLiBy7JYzZlwvt
 GvSDka8Kt9E64FkSYHpRscJPzjiFqcLRu4Vnoy30mSz/cjLoAeyvZTloy110ugfULgl45
 iQaBQ1gxxSZzd7sxo63ReOYbSwelQdOBNpMsCE5zyKxcZSPLcL0ErdgnqoxMPqBZRE6Wq
 G8C0Xski4p12WnwQOIzVPIYcBFLmG09XHulW1ZEq2wzf56MXmtEzbRDfe6sT6WnHQEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793657731;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=fWVF7DnBvRCMbuRI3hUDqKUgc9uGNITuwY2BxyA7Ubo=;
 b=bd16df032Bf7kY9g7rAFjy292y3Ljvp5sayNP9GH+feXkVlLlxD7Mi393f7D410KHKIa
 z+tfpbZ3aSQLQu2FJQg3hG84ziumATSYTHpfpCmSniKoRBlmlggXOxWfz93sK8Wqh+oP4
 bdlHrW4q7OgVrlb2AeBXlZkXN5HdDWxlXLmvecEl9VvDGQjvVI5ZdSfcZHnd1gvbln19p
 8/Klv+kbSEfZtw21BtZe51aJQbsCHX8r8+7d09lnwzWtANTH1rLv5rlBkTML7uiI7tIhK
 3wylc61eEcHAPL32a5lF1Nw5PHFb+0ND0Chja1AW7wMpQ4nmJpRXCric0XrBS97OCoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=L86w8VUM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::82e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=L86w8VUM
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FE3D80C3B
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:15:30 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-5366ae57896so43037741cf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:15:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793657730; cv=none;
 d=google.com; s=arc-20260327;
 b=WGS5cD2KlAjggwhYsB3uQYY1m4PJaeGQgqsRzT5xF/4sDatdzhlext38PjFWTSsoxt
 QecVNvJtIpOS/HnohY9hlLfDlzMKpU6frCGuzMDyVfdbZuY2NgepMcYU1+yQoXDdSm3d
 fTzD2QRfuXK5pEEi01wnbZeZMNOSzFB+Rg6drHtZLfABDUvM83Qke28mbq0hxnDoBjwi
 yOTJ0JJmQiYhH2RvfS8HO9exuYpT65KEbZ84CDOXGyTzUSJfhkOl1PCDe+Pb4eupd2kG
 vCAl6j2nT11LYtplgf83K12i7sER2pjPK+n12INY1eCUfvNSljk5erFSm0AB/9+SqgAa
 eauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fWVF7DnBvRCMbuRI3hUDqKUgc9uGNITuwY2BxyA7Ubo=;
 fh=b/7Rk8ajIQgO7Ts7znoWjP29vH6EL4gSWKvHBIdwZT4=;
 b=lreNanzmQIG9dgK9pwLDIyRClV+kOMhbhDMxbiHsvItjn6I3rsOFFKx6RazmTF7H2q
 hW1oYjoTRqhOlf3zYCcCbKzTPFUE+uyfZeTxBgrmV+tbeVoCAUSQMCua3D4bXfkwncJC
 lHFDSX7Y5/NJoDs0lMt4xKcIbVzQA+Z/0L04HP2PdIXsZA3ePNq+ccS7lzTuvxKGbNH4
 qzgiobekD3asMWzmQkU4+2L2R2oxGZvSmyM6NXoZgbcmqbQgKyO9Rquk0WFQHsxkFBLb
 xaIVoKjiZojoCAnnvTMqLDq8XpDytMnGE/If3ylFSJBKTe4oP0bhfmsjyW8n4JMoBKO0
 sk7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793657730; x=1794262530;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fWVF7DnBvRCMbuRI3hUDqKUgc9uGNITuwY2BxyA7Ubo=;
 b=L86w8VUM07lJ1FvQBLPiMgr8J0aA/4Ouq5+6Cf75Xk06R4oyi4GhllJcmM4g4B9pKI
 8tvi/Frtp8TEs670n9HsMrwztz32qzMryD0WtbzGxCzrZdnTdpRRSgy2BzZrD3X9bS4L
 6Tus+NQlQbewJWpaI6CYHqzPiG8lCGG/rejjlna2lGte3jByCnUqsPxTgntzagr7od3C
 kerST0FXc2+ibVRzF0AXW6+EBECqgSR0N3hHIoiWfSGCvL1CaedQiNklbSlNwlI1L2xJ
 8z+Rm2JCgooNc0zOUmVm0eo6k0+U5l0cvWtJRxQT9OXK3CMpkaCBUIx1NSeIGBO1RK48
 59TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657730; x=1794262530;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fWVF7DnBvRCMbuRI3hUDqKUgc9uGNITuwY2BxyA7Ubo=;
 b=KRm/UxcdMMorncGDPmlObIsZoxRKLAK9oTBGkxw4ZDDbNAjva4nguuwP3CTP1UdyAB
 rWpREXQE7kWl9mbIAMHBVql3WacUnYDtyRy8r49gIHjkKWuEqD3wTzT8c4IcKkjAsy0w
 qiGJ7HGKsbdDMwklXUtLvnryFVci6ZMYymA/yWpcfPow5PXsXskzx1dRsIOCLOfeVZNe
 C0RWHbNf2HfFPur+3RlxEWO6SCcGy8QlwE41/8F9daZxM8hM1YVWc+AwA2pgP6lOPgg7
 NpJqaxEmFgD7VVu6uHwZQXJqlTaMzb0mqeA7vVsLZ9XTZ7upMcHvySFGt/+G78m0O2s5
 c9tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/zmJEpqa9415EWdxX0iOY8B0XkqRPv7wsxXTZEuv6RDw+Te+7orZrhGVIbiIj3WRFkuxv92Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLHDib6vad8TbYK2WwVDZz3+9XRYEcJR8MNEOdhsO3YqYB9BIaG
 qSCpinW7eDndfx+zzrkllk/LH2fHMGR+ytAlzWhgsAX8yOR+U3D/miyrag1KztuFAOriUUR9djX
 VbrCKw4E+T9lEnBEKvlql/I4Opi0N9N4=
X-Gm-Gg: AYBFou2jzWCq7nJeniR+5U9aSxdGSDmN7YL8Le2DG6BoRWLTu5BhoPukO6FDlfP3tsi
 UWf7Q/DGdgiNvMZA+kvBRby9ObuhQBmLL4DlLHmBxjF4Oat2/gcCROv5b6v960orsgZNzhQUx9P
 MBVRyGZq9uhsDL2Tn5475+yp847MefHSifBfPZW1oCwGTVW/ZFh7SSlOMPjuogngCIHeo+QRsGN
 bed1hPYvaDslXDyqjVm8uPEC0+fw2dJ9M0h15Z9hm0P3P9sVqg9GGQkRKR/g45ZHd54AWCGxlOT
 aR8nWiA1XpvTg1+ioRAnJdblg4TIqDpjnuWkfjEPZ2f00efZBEcTqHXxvtyviXeCDBxur0uog8Y
 MtNynlvaLAv9EQxgT3zY2h45TfEC36HzhrT2GsZdYfQMBcBpE42WlKYVt46fiV44GJA0Q0sJvvt
 XxQ2rEb6fog0a5ZSmThvatKPscQuXhfYI6g47Ms9qCi8IjvrgWkoKj+H8HFU5PJEYJyCFALGczp
 xkly84kk4E/Q8EJ6w8P5oFw/3/8HRlOQHfJ1dXKFb1WwbGc3jit2feXmw==
X-Received: by 2002:a05:622a:488b:b0:535:a5fb:67fc with SMTP id
 d75a77b69052e-542b8ad90efmr183732011cf.72.1793657729759; Mon, 02 Nov 2026
 14:15:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-imx93-frdm-distro-boot-env-v2-1-d173dc546803@baylibre.com>
In-Reply-To: <20261102-imx93-frdm-distro-boot-env-v2-1-d173dc546803@baylibre.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 2 Nov 2026 22:15:16 +0000
X-Gm-Features: AclHuK_GlHeSTKnsE878QRR-PmHqTAi4WAE-b9RHC-ndtRqm9ZJKVsd6B0zqKes
Message-ID: <CALeDE9PBLc+YhMBC8OPUVjLtSa=x072799UCXfs4LKnyxxh_Fg@mail.gmail.com>
Subject: Re: [PATCH v2] imx93_frdm: make room for distro kernels and initrd
To: Daniel Drake <ddrake@baylibre.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 19:35, Daniel Drake <ddrake@baylibre.com> wrote:
>
> The DTB is loaded 44 MiB after kernel_addr_r, which is too small for a
> generic distro arm64 Image (Debian's is 48 MiB), and ramdisk_addr_r is
> not set, so extlinux boot with an initrd fails.
>
> Move the DTB and boot script addresses up to leave 128 MiB between
> kernel_addr_r and the DTB, and add ramdisk_addr_r after them for
> standard boot with an initrd.
>
> Signed-off-by: Daniel Drake <ddrake@baylibre.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> Changes in v2:
> - Leave 128 MiB between kernel_addr_r and the DTB instead of 92 MiB
>   (Tom Rini)
> - Link to v1: https://lore.kernel.org/r/20261030-imx93-frdm-distro-boot-env-v1-1-5ba9a72f0904@baylibre.com
> ---
>  board/nxp/imx93_frdm/imx93_frdm.env | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/board/nxp/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
> index 96096bc51a0..b3a19a4720e 100644
> --- a/board/nxp/imx93_frdm/imx93_frdm.env
> +++ b/board/nxp/imx93_frdm/imx93_frdm.env
> @@ -6,8 +6,8 @@ bootm_size=0x10000000
>  cntr_addr=0x98000000
>  cntr_file=os_cntr_signed.bin
>  console=ttyLP0,115200
> -fdt_addr_r=0x83000000
> -fdt_addr=0x83000000
> +fdt_addr_r=0x88400000
> +fdt_addr=0x88400000
>  fdtfile=DEFAULT_FDT_FILE
>  image=Image
>  ip_dyn=yes
> @@ -39,4 +39,5 @@ bsp_bootcmd=
>         run loadfdt;
>         run boot_os;
>
> -scriptaddr=0x83500000
> +scriptaddr=0x88700000
> +ramdisk_addr_r=0x88800000
>
> ---
> base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
> change-id: 20261030-imx93-frdm-distro-boot-env-c6408edae532
>
> Best regards,
> --
> Daniel Drake <ddrake@baylibre.com>
>
