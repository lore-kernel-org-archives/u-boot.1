Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CnVG9fLV;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IeWMDxoN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EB24406AF;
	Wed, 28 Oct 2026 08:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ok5RUGWh5VbE; Wed, 28 Oct 2026 08:56:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3558040675
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177800;
	b=lleLUuC5MdWDdOKqS3clismYOvelncsSMP85ZEGzPKOZ6dfxmZZTLm1nhwxB8QcqGxor
	 My83NJcJkfY1EzYBxvFNFbDuCzo7XWYv8hzX5LdBo9m3IfM7v54HKNmZvx+C5KGAzJh+Y
	 Po9Be6BjQotPpKdb1AYc8mYA5czqWVife108eVJB3ScNvPYe8TGZGtaEB+aiXngb+sJ0X
	 +zDoExnkAwgW5oWYQGPQe+ECv5kapQoyZlSjxwfTH2SdBhcJ6PPQdCFP4mixvebnMlo0G
	 YY2YBP2xp/sRM2fh2t9LfJZTcjpsC83ZB3b30qws9+HyWHdj/OHozm4CYAXCc0qhfCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=09d6fGKS6tqByuo4r8Nf2ni8mAJKcnGxePk6bbWZO7I=;
	b=CG12ECqac8at3nXkv2kM9DT1Tep7HLxNm+43ZMB+Hxo1ouJSevU0HmsLKGMNcW/9rbzC
	 fT3ctvWQnRMqWjATyN9M+kfvsGJmS9/8gU5sZI1AJx4MBbcKFFlOXgrKCEmb3LlqLZ1yh
	 R4jdplmkIpQa2R08KhZDbpZA+40IrJB9PeO+GcPWFPr6jtT0FkZcJnj/ACXRr3qEjcjR0
	 cnZl5tSbFHuW/xsJgGp9GsnUBLaXZ0r7ZXHc1nNYTe0WPEYNKH4/f4GQOHU17QFxzZdMv
	 I9QToRTSTTo31rl9sQEIrqNUGQTQJmRjpS8F4aSLeaFglT1M8sSrc/VKRDx4lYG4ydg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IeWMDxoN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177800;
	bh=09d6fGKS6tqByuo4r8Nf2ni8mAJKcnGxePk6bbWZO7I=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CnVG9fLVrgJplhv8ew9ycrMOsUm5DHm5rsz8Ei/L5m4krnSeFD67xbnSzCdHLmCpN
	 TlIcbx+S5jbGi1bOk94+gxu/spZsGPXAI8RzEwCRlHf0TXnCCuCSXYZeOKOCyamaAu
	 XAV0aFKK6Jz7CmHlWkEzOhCLgNe8O7vOzDLljw1A1vZvjaMOMLORzeGQ6tQWgnwKgq
	 tq48A+ouZHMLxJt+QZRzKs86p0brvwdC0tK4MwgcD8WCoTbMD3T2Og5lbQjFrTSzhq
	 Buehmk+fdgumSRLuKEF1d4j3Yb49TKjhxiE13Ix2IWyZ7J0rZfnDZ/OLXFiC5klbjT
	 RlmWwbrQBjhTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3558040675;
	Wed, 28 Oct 2026 08:56:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE09C473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C36E240560
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RlzZYgSNTQQ6 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D6EBD4055E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177790;
 b=jc/xESWvWdzA4EUsc40YOiSSrCMgDFNVN+dQ4Vm8jyd+1r60PP61K+M5s+FRM22egTQO
 aThQe2fQdaVcJZtz2jlfGytSS4M+KXo/Zf2Pf+OQVz6z8TIuNtbhKzcyWdie9pRr+yyIN
 35IyJ9jT7wXA74O5r1DSNcSqVxwyfXO6FhJERmPoWzivSAOwz+zroFVpNGl6xYpaDy/xP
 R9UBWa2aP6X4FBvhAH0kb6mjaWbgoBuQUlS51KoFBXyBPQ8QatK2V2KXkOLqNnYjJ1ZSR
 Pfkg6Bbabe0WmYcThojTGAg9KQqcj93dCFYV4mJbwzLU+wiRdIRqJ2w7Cql0boqP4UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177790;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=09d6fGKS6tqByuo4r8Nf2ni8mAJKcnGxePk6bbWZO7I=;
 b=c6Z34hMTFIISgph9Zx8hA//sLR6W51LXoOYTT5YxzvqdJo42PuPbST5PeSG2OxxvzaMr
 gAN4jMsebePaS+h8nbQFMiOg6ioQRch9SNBJP0zMVoyLWscMSLStFZme/7+jxjtMceiIo
 o++Z4rbtbtboaO374QZFltCba5nAi9A9pX4+xHppCr/jOHMNG+diwIUsjRyEeT9qLO0ZY
 xdY00IzjyVw2w+6wvbjuM2Cdro1L7aV8Mk444RNBLHFGPKojg4tVv7UPMTTv9+Ytt+rhD
 SaFeWWhLtir/Ew/R1/xVZf9QO4vvy/e3kPBLIM5MnU5oxOSILlgwJdlEMcPhdrNPECg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IeWMDxoN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IeWMDxoN
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6EBD4055E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:29 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so1016929a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177787; cv=none;
 d=google.com; s=arc-20260327;
 b=IGL09/Nn8RWXDjJ/2V2ntP/HMmo4u4HvWYuqTMnMdLfJUStSUOs4ZV6htszx7iE47t
 q27f+yAwqAus8JFdbJkwVCHfA1M7/PwTtv2cwOVAo9AQs/p3kPf1VsNz3Qn1vbVH//c2
 t6E8eW40EHA/ngpiM9sdq+68jDOznUS9sLcTXUZATDUzMjI4DeyF76Wo9JSwiISnYHvR
 BVefFkEsDkT9n9MvERzK836IKuN4mRhu7UExnj4DP+35FBqtWsktV9MphRvamDJb0KBM
 KVvlFCmxHSW8UBrnuMiL+CDsQdtnzMGeEnMF68N4jaL5R0F1vsEydN3WZP4gu//11oxH
 jxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=09d6fGKS6tqByuo4r8Nf2ni8mAJKcnGxePk6bbWZO7I=;
 fh=lV1sU4rAdqVEL5TfZD5UCDkaoeNHSVWpmiJi0R6OCQw=;
 b=O9Z3D1RwzisB4H7mMQ4rGcP3Y29hcqsKstmdRMy6huHta3IlGP9bvja+7OC9krqKv7
 O7JfipVVXrc6U2dxljLA+aeRGdjI7+BfC0YB2SvBFB+erGy9Ob+Wch+2s0mYEnuJQ6jK
 11x/KHGkz8iYpAryGvlwh/8aIEneZliOU64P0F8LJQfsy4U2gJ/Z/sc/h/5nvhlIqwLL
 MxB5AatAW4Nf6RAksCfaPkmkMh0Ne/lNhKIe/WOUSXYxhbByxBnfZskiAho+Dp1jMIby
 oBvORD5sjOYXvUt+81JDdVhZv7YYzveMlmx7Yhhiuqq4pVWZUzFXDHk5aXhFTJQp9WTm
 +HYA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177787; x=1793782587;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=09d6fGKS6tqByuo4r8Nf2ni8mAJKcnGxePk6bbWZO7I=;
 b=IeWMDxoN7Qg/QsIjmBopzgPcUfQwiM8Q8RhbrNAuw/XN6mm2HaMJTMlKO5LHWdYL93
 BPvDeVMT1/ibGU3p8OmXhHeovoGzOk4E2x2o9Kwwj/BsPMfZ3hSfeE3VuBDGS6rOZPLf
 PVTnxjAOKsdqNqXaBorQF3UmN5swIOTlt0CP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177787; x=1793782587;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=09d6fGKS6tqByuo4r8Nf2ni8mAJKcnGxePk6bbWZO7I=;
 b=vt3seVnS9RI+4VM/hUEuBdQMu+uYF7TLWeBvvnywUGikrFdA0Fv8BXrIClAro2/jEu
 ECzHcprvh7AI3+1B2tgjUiILgcxDtCrNhKV5aFpkbgS/Os3rCfVIAayT+BhyfSk18b2B
 5nUyXrmp2DuxZSFoeo7F+SoV8XJEKuDA4UG35zPIdi/wgCwedSBeVR19ig+MsNJ9auje
 G3SP+5PlmA8w3Z2QtaaPIsC+keGwbC4prevHokdMniF37YP4n9IcnseatvqqaaP2s4jz
 WVJQtQiWrguX0NIvNaftKo6UmZITd9r/yS/mBqJ2fweSm1pwGvNCm/s2Ij5DoAN0FZRb
 VIPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+Gyv13cOkJ2c6kVgHCM+3bp3pigAHWpbKjxbbIGls0tQ2cyqqtzJG5ENLDhhKypYfuMlEIjQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJeoRSnOR6tdhDh5Z/H/tmr+Rqf+tiZUULhcCMyvevbT8MtbME3
 Xw4+Nqq7f13yalWbo0ExJK9IB/VLN2CHcLc0l6Y47MBNx7E0HlLiUQuZiAJycWak2FllIxn84gF
 /3MK9yu2z0AlBidjUVvKabO9XDE0sUVD2LC6EEmNr
X-Gm-Gg: AYBFou0efW/iYOJFJpAFF22AzDsjPUp8SYzxMw0cgqSufueMfFmwoCzAztmYvHMzzQQ
 SInzavyNS8cHDYX+dMyRRrzN/J+WCCdAP5A3+JbmfvNI99CUu1Z5lhVmUSpryke9vKPHzaL9FFK
 MYbMSQO4LyIjN1g9XO97cj6zRQMcQDr16kibqrliFaAJ0C5MFiuxJpTFppL2YcOiYtoLIUtv735
 iU92vSwMlHQ67QnOXqAHoUtIMaWKHg4rm7joltKtYJoPJ8zIHgwqDtDuSReYgJawJk8MBdP86E+
 8nvHKOQvVbDsBhbXXbIVb5AChV4cYVcSUPoS3FGZPrUcTOfKZXHCKL2DCRAfCJCz5vP43WGLKoX
 Y7ngMBzVkQWqCbY4dzo7CklILtYSFbZxj150=
X-Received: by 2002:a05:6402:241f:b0:6b3:f05e:fd5e with SMTP id
 4fb4d7f45d1cf-6b49cbf883cmr1132981a12.33.1793177787534; Wed, 28 Oct 2026
 01:56:27 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:56:25 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:39 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4c2d8a04-3030-4c9f-80c6-0d49a6900ad1@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <4c2d8a04-3030-4c9f-80c6-0d49a6900ad1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 03:56:25 -0500
X-Gm-Features: AclHuK_9tH6hQ1g-CQnq5PW0vnSNpfUWKGlcPgIlPDar0i3x_mMeNLv1MINzZd0
Message-ID: <CAFLszTgPKoWeaUHoQ0KDY7Gawy8VXBTtsY5da70VwhCEMJzLrQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] usb: storage: Fix the capacity faked when READ
 CAPACITY fails
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> usb: storage: Fix the capacity faked when READ CAPACITY fails
>
> When READ CAPACITY fails, usb_stor_get_info() makes up a reply of its own
> for a 1.44MB floppy, 2880 blocks of 512 bytes. But it sets the values in
> host byte order, while the reply is read back as big endian, so on a
> little-endian host the device gets 0x400b0001 blocks (about 1G) of 128KiB
> rather than 2880 of 512 bytes. It also puts 2880 where READ CAPACITY
> returns the last LBA, so even on a big-endian host the device gets 2881
> blocks.
>
> Set the reply in big endian like the one it stands in for, with 2879 as
> the last LBA, so that such a device has 2880 blocks of 512 bytes on any
> host.
>
> Fixes: 149dded2b178 ("* Add support for USB Mass Storage Devices (BBB)   (tested with USB memory sticks only)")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  common/usb_storage.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
