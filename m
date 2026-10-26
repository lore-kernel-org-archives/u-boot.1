Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F11606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F/NqNRA5;
	dkim=temperror header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eJDaja4P
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9232E40635;
	Mon, 26 Oct 2026 16:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cmjvfrJw58Tu; Mon, 26 Oct 2026 16:34:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFD0C40603
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032457;
	b=r2O9NkBMGhsuKiox2w/yNzDsWNZbqxSoLOc8nITrNH86KmryNU9LzdOPP6Ij3CH02rXe
	 t6jNUV++/EQU/vomLWiKoIcb4WfDAoHRmbfoPdvA9gS0MJ9Vv6HnHMPOTqcyN0Rvn7yQA
	 glhVCO7XJHnssrvxQCxIXF4eRitWwV9pe3Y7o0gNIZ/dDGdbUqk7D2ToCVlKZbH/lcBDP
	 Pzz0R6S212ckjvH0Fo3UtrBb3RHLFCPSOmkza5E2N+gs+QZhcxBvHmBBEaemET9nXNjQX
	 jQsmen6BrkBuPUQVtUqLj1QxEGwIsFX/j4YgjokD55JIdOj3cAr+Oicant/DJa2UCIA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qcYvjjF+1hb9FpXJzR/sk+nFsOhsZUV+Qtui8br0KF0=;
	b=YMSUwZGep5cAhyA9N2mCn9HK+Wsgv7bsS301R7ggqQrZQpy8YFNtfzEn7m4s102BzOsE
	 l3gI/u9cznrx4OUY076l2PJ6iTIiLTN6EUeVMAfJSRdm3iS9lUizo6zdEDMsu0zq5G5RH
	 p69g5Kjh91xL3z6ra9WCOQnVSvrRDYSId0FH6TrHcKRw6IEw/sAZuCCn2Jyj9L86BjF6d
	 IAHwCZwqnjpjtGnpnZe/h3PGgGDyk8TDnlqsU2VehfW4xb6dDba/W9cpwN5OnvvEr3eId
	 Qt4BEyoBFOwZe/Z9aCdmE/ZD5o5VTOfskmANx0K0TBCXK/7Hc9uC47AyJAVC4HTW+Ow==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eJDaja4P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793032457;
	bh=qcYvjjF+1hb9FpXJzR/sk+nFsOhsZUV+Qtui8br0KF0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F/NqNRA5MB59VM3XHzvwpkOmKfjPPqedpHaF3saxwoJZ1HcE4wqrP0zhPTUCUCOxB
	 rlkP/nPiFNKgnVdGgGtVtYcN3wGHxxrlzt5AvFNrPH8M0eoU0py9BBhd0q2QqKkq2k
	 hVXyE21lZktMz7AZKvpVLyv1/YYc282vEr2WSAV55z7zyFb2P+7m3mBhILmWAPmYj0
	 aJOh3zaPrck7JgHjKQhToQ/AwLS7QWGcH0sqRGZuYE9ZvU7DUfCKfO/OgRV/DTzLuY
	 arlFSGAearQZO6ulivN4wR3JLMMG+rm1YioZIy3Eq7d+Adi3KP7fdyjptNyEccc6fp
	 gk5sHI7oomacg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFD0C40603;
	Mon, 26 Oct 2026 16:34:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A3E8356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F3D940603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgOPUkY7VIDn for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:34:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 06EE8405C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032455;
 b=LutEktru5N6S0jGlHetmmJ8nv0Ti0zp/5xwC0jsjtB4RvDigaQr2c5ypCpIaIGVetkry
 QNIo+7wTyLWZ6rqfmyEbPSXu2/RTKGNEdHr6T3nwbmLs6uNa7XUq3UNP/7CwK8iP4K3oU
 Oh8fyZ8ephXTi/VyISC2J6MECOUayNF7MMZIc51J+evybGn4Ioc1EUAmev8y8xSxQmBIe
 jiS8i0Zrdq3icPD2FI9E0iSBDUj6GHVsxqc9HWTKQt/umjQI2ZpftGm1a0Q+g42RazDTq
 TIKI/+grmL6zg+hP+4DssWm1fhbrghMKBCzwDTtcuuJjq9ny/z9QZlR2g2DZpjAxCiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032455;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=qcYvjjF+1hb9FpXJzR/sk+nFsOhsZUV+Qtui8br0KF0=;
 b=lSX/J21RdhNcb5dzm3NyVxlSVil3Ej6Xy4DeJStLDChXplRIH8hsfMKNYJglCz/Q+ZaB
 eg4N26buYrQ811aJBjNqNz28yXme2ejNSv256zVw0CS7I1f49RhkqS0CLntRPzSDpVmEy
 3iSUvA5/I9d8DoXnSKi3MKXlXYIPMoEK7H7lhFbODg36v5oQ2YgdHuDP7EPoNlP00LduO
 s9yPEkwwCrN/9z4C4fYwnxGvjXO0wvDt/ucIF8kIYwUtKWBrx+SiONfJXrHp5LvKy/3Kl
 8+NxZLHnzI81qptzcmgsx/Ybhfg+w9cKNCacQ+k761g/50FttDX2jx/CUbTN4DOmPPA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eJDaja4P; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eJDaja4P
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06EE8405C9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:14 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b429f71dbeso3211197a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793032453; cv=none;
 d=google.com; s=arc-20260327;
 b=G9osh0WljfEii1JnVm6PVrOago6PszvEZrFpAdIJ1iYsLVp8hZcE8y0X3HfaO1WNMi
 tpHb780GwktMIB8M20J3oVHwtNMIHOfJLRztlgy2PwCeAhYzen661UEzNUb8L9H5Zhh9
 f5eqah9QrWKjIbiK5wCwc4mHZhD156LhFySkxXR0HjT0aORrQH+DTXzIIDsrJduwjk4S
 Yvm1u3191Nyg0yQtfK5xA8nAiSfycmQd11ce879HcpSP8dDddSlw/jGXW4k3hl+Xq8E/
 emnEAwXbjj6yLL1pUKcUlibw9vBMfF+aJyAbLPx6rOTPDFHeHlsbfro9XVOMSr4B1Vnc
 t4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=qcYvjjF+1hb9FpXJzR/sk+nFsOhsZUV+Qtui8br0KF0=;
 fh=Y7aUnP25mbYM6Q7HkV1TTb1PE0Ea/sUWot3vLYc3wB0=;
 b=nmslG0H9U2d44QuI3iFBcQ8SmNFaf+DxYOQoPuhvuqCmNz7ReounhlNqisa1YtcaEs
 mQyCg1/UPEmI0e5TpQOYmfJpf13YcHnbj0lvTXM83tAZeXZNFoIbhSb0KkJFqf3L0vno
 UL7V+oR8cbwZBWJgPWjr9K9yBCHlIwzwqZqj4gKmHfnqDvWAHjvFZAb+sputkpvjiD9V
 5MpusJ5FROv1YLldXaltJKQB0cO/anTiO6pcwSvT+LeU7aQxcZp4PNQ80n0UPnyU+UCC
 /n7wheO92C4o/JtHj0mk8B0ZvNuiV+TP6plIgbO4tcjpm//i6iqHK80njEVqwwziNpvE
 Jn4A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793032453; x=1793637253;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qcYvjjF+1hb9FpXJzR/sk+nFsOhsZUV+Qtui8br0KF0=;
 b=eJDaja4PQfO56Nv91zsHb3s0rRr37YuUBWENyweLXSqmhS8OUvisJVb8eZVz6gjg9z
 OuMGifmIie19sBpT22fqk1Nd5sDDV8OsDtGp4jBJR8jx/x6DG3dUb1aCfo2Q+5yhgTwL
 KyrGpFBVtelZitcn1Y8fkm1dQ5mZ7AXUJyHC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032453; x=1793637253;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qcYvjjF+1hb9FpXJzR/sk+nFsOhsZUV+Qtui8br0KF0=;
 b=RQLLY9F5fAbAb17As/cBbTpUyKCNRtYfRZQDZIkIL0wR/POzkFVnZ3Xf8F8DmuVAn/
 wdwds+sJfw0PiI+hw/T254L/q3W2HBFp5KhUCfRdaqfmcCScOf7C+dHN+vuon69OhaZv
 Yb7dkC/0lLqlFqpl5NAqg26BzefTtMy8GfR1NUYUSYrSAvuhKtzN70RRHiPJ7icjFyAT
 42umQnoZ8paa4yXUS5Bc+exwjS3i+9Z3pvb/xiBu/6QZxK/SGCfwM7Z9vYOnYwP63beq
 9bLnM+aXPU2zkhAuYR9gAuJj0n9qR8j5XXNyuG6zMaetVbp9zC7Uymc0RaL3OOifY4CY
 gifg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOLEn8xf9jk2c7QsCTLbGnL+ucUe8IEIyq/kHJtmmBc8rBCssQt6WrJbJByKIQ58zdY7p54ZY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKdBTezAGasawgzpZSp+Z7O+YoLzeP+4GOrFgoBS0hG8SpUF4fw
 RCbUOieDOXXv3JDm3L2KaJ/hUXOs/8Lu3DCuXr5PPX09RReg29HzsvgKKwkptvnczThcQQMGPat
 RCwj9n8H6VWo7EBfo2rDvt6jmMnjWG+pjzOvjX9rG
X-Gm-Gg: AYBFou18uxEAGO+skGXBKMEJ5YYXDJbmb05BmBOV0u6aym3rw3DPkf8rCwoACOrlByQ
 IeFeqXmsLIx68k+w+np35bVzt7xDnm2ytZOTIw1EjxxLlX4LdQykYzr0RihfQjysT4CQNTObqOe
 Z05bp6r8RAABx0ulrbBfWLu91UoZ8pKHsSpvfgrthivC09TrL9umQvBdK2B4QJOH/zl+EJZqJVc
 0exEjzLUY8XwdS8ekSnawg7GDtgVIuF75FP/B626WLgiwXKu6ZE3r/sNzt18OQieljMrOAfCzcR
 GqkZwXCtoW+6/36UWYKRJgu7TEzdoGVMuUtAZ6av9ZNMbKV3472ByVFLlpjuKBWw1LARNGcpz3L
 y/8z3bQ73Rjj4HN7RlKJdmdbnBfveHDrhow4=
X-Received: by 2002:aa7:c714:0:b0:6b1:c34b:f1d5 with SMTP id
 4fb4d7f45d1cf-6b442ff1e07mr5448210a12.18.1793032452681; Mon, 26 Oct 2026
 09:34:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:34:10 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:47:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:34:10 -0700
X-Gm-Features: AclHuK-IA6zjw5-G6agqYgnlhqukonm9SUkIZrcrMKNy5bkfv3lgDWN-tOGfrzA
Message-ID: <CAFLszThXaFoH1JLGy5c-FaEWcOgwdzNA2vpiZBYELQLEZs_FQg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from the
 bloblist
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On 2026-10-23T22:32:44, David Lechner <dlechner@baylibre.com> wrote:

> The first patch makes U-Boot apply the overlays to the devicetree it
> found by other means as well, so that the earlier boot stage only has to
> pass the DRAM information. The second patch enables bloblist support for
> MT8189.

One thing I'd like to check on the design. TF-A still has to know how
big U-Boot's devicetree is, since it must leave enough free space in
the transfer list for U-Boot to copy its devicetree in, plus
SYS_FDT_PAD for the overlays to grow into. If there isn't enough
space, fdtdec_setup() fails and the board does not boot, even though
U-Boot has a perfectly good devicetree of its own. So the two projects
are still coupled, just less visibly than if TF-A passed the
devicetree itself. That ties in with Tom's question about why this
platform can't work like the other bloblist platforms (I tend to
agree). It would be worth explaining in the cover letter why passing
the full devicetree from TF-A is not practical here, and giving the
status of the TF-A side.

Regards,
Simon
