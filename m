Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B02606A881
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UZHPWe/i;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rOHYP/kY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9669380F79;
	Mon, 16 Nov 2026 23:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LtryeYoEAr4W; Mon, 16 Nov 2026 23:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DDA8D80F5F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794870152;
	b=EWGT6h0OPDcduq7K95gNsOXFAaX4LIO0QnLm9WGT7TT9UhCXNg71m8YTUO0YuM47dCHX
	 sSLuZTRPAOcyHUnz6gEewC/Zhxm8dAFcUbDGykEYtvydjyU9tXmwAXlqlCpfUECI98dYa
	 APyKig1IGlbe8jaRpUud7KAKWrjRNXExjMqOYum+PiSNd0M7Q9G2N73MX4V7GjbHPAoIF
	 bKqAo4scEPSKSZXm0Hh1SJDigE4dR9WP6MaRLWuRe+HEqCJcoRaLHPd7SVASuQLboSepL
	 UpEwifUlbHhcoaOHkrKwXjoUzBOi1v8FXfH9DFsfzQpBLnoSHnn7Wng5edRrXZ4LlqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794870152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cXRkpAPq7b9ENZ/wAIwhO8WzBWgmp72YUIjYDHPTd6c=;
	b=s1wqFAZi9LE2AzEvu9tKd3k/jMra9svuLrOUie4HgeU37YuMTAQTGz+rQ1lW8edfi5n3
	 T7GxuCJg7YlfKpz+4o1qwVBX8jkdE9bDszFLPkJKhx5oO308gufJx6RnjhL+dxfnT6fj9
	 dCVJqtvQoNr9wq/zOO+DKoJqjAhSrA3haXPzdsSYxc50OAicAXjcGTrBRqHGhdcf87ENx
	 bxLNQ7a3DZQ7i1m0ARTT9n8cmzAJiR8n8lBPONQLxoe+gwVTcinhcBv/+Cfhwn6yEARE4
	 c3BfGOJnVuupmaoRNiue+nOHPqIhrfeWqX/paVfMPmhDjb6E23ptUbYq4G0QgFA280Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794870152;
	bh=cXRkpAPq7b9ENZ/wAIwhO8WzBWgmp72YUIjYDHPTd6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZHPWe/iv5uEhZD32XE9z7YuYzkraH79owXJLBikYWbp7eohRBVKW30QVa/Y0ZFgv
	 YA+gt7k53h6Pn74oLJPedqFKrnV63QQ7c5bLFIrTvWPz0tpuDyk+YokEk2KJnN0TEE
	 Y0DTthiNcoqoP+fXjotnNj+xdCQ8Of0QBcO8JBuk4T1Po6+/bEA0PWWey7JfYSHCWD
	 QFLljmZEagWBPEmIYi/pSm2hrocCiF1d4Z5Q27TRzBs17spygg9MV5gNDa39ESVQwT
	 Wh0aM5XtlXS5iN2w4vTvZvQyK7jb18cwjSoz/2pAbmW2IzphK4yjTe0bYrMlW1dHxS
	 02Bf1Gcga+Scg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDA8D80F5F;
	Mon, 16 Nov 2026 23:02:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D348713C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8953240670
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3rVRaCHSwMHG for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 23:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDC5D40660
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rOHYP/kY
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDC5D40660
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:02:29 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4ad587ba293so3089414fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794870148; x=1795474948;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cXRkpAPq7b9ENZ/wAIwhO8WzBWgmp72YUIjYDHPTd6c=;
 b=rOHYP/kYTMlVVvYTj2lJ6ooBrr5q90PKXB0e99CYy/JLFCND4YcwjsX9zSUSCbdBP6
 zEUTdSqkVPz72OcYtauccO0NrGxyvO3K3CKHCkKKMaok9XLg8zpnfpn6MxURwnhSmeY8
 nuc1rqI/v58HUhQjTQ2K0bMdXdcefHy0zqZ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794870148; x=1795474948;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cXRkpAPq7b9ENZ/wAIwhO8WzBWgmp72YUIjYDHPTd6c=;
 b=X1PBGcI3dFxZZ6t1MgRGKo9rp1eNcrnoT0HozLv2FPeTSXtJg0mX/P2KqEnvh18w2+
 gs7xDtOI2itbmXL0uACBoVRItmk2umLIMiekLXdmdB3IDXI6JtBMWCxX1sjJ0C36HRTD
 FjsfbGULW0SSr7KPP6gIu+8c/fWEb4bIi/HDk6PnzjN23AgPc6WdHMJU4wE8b/wNNUEl
 Ch4dp9Eely1hwtpfMJdMInOBO+zZqI8XiU/74p9ScMm6MHXc5H8MmjiiU1iun9pFcEx3
 GIO05CjKhzjhsosqh2Q4iZjpTYze6Gptko1HtwCBWj00QiYVe4KWV0HdEoja5UKTN9uf
 M6fg==
X-Forwarded-Encrypted: i=1;
 AL+hErFriTQi7GPv+JvuBBNYt8hyF+C5/cG5/5t7TWjjZIuC/J1a6Io1LgGGJjQ13VFvetwiay64rP4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ut1bW4Rz8USfbjb8bVFe6LOONOnNesF9mCPoLrS3b9HdCDL1J
 Mn3LES/4wjoaLf1jSkjBV9DBYHFgYRV+mX3uRv9xqeVMrI5hXktXHOcyemnDOi8aADY=
X-Gm-Gg: AYBFou251I+sd7UQ6lMWhGXUJM9fzCapos3WVXpOZKrZ1XjtVSWhAQ/VFRzkfEkVhxx
 tH7IVldoarLo7zhsQDZYyfBC5x+cY5uuMeMS2IS2Vrc0atMZq1YzBP1fWcdOUHKd6NL6LJJDEOd
 p1TBB3X7cUn9bY5lckdxHvTyVK3xv4ppcnLqAstTcllnXeNnCv9HII3rzlyz2QVMbKjAH+gMvpn
 O7YDp9It6ZZWC4qsO3c+nNhR7S9uN5Mqd7Qryc2mirCWvfUer/HVT2UJMKHTjHXMUVGm67UD1cI
 hxrweT9FPTOtDYuydWlUK7rt+z+45Q9ey/KwuerOt/JxKLTAEdvvnWcYTkMj7EMCKE9OCWLml1w
 HLycGwY3WLOJu2gbKaVxKNj3fKlzPXqusN6p3v+ha87tDehRw8iGTLC6ogDDY+rfl3Ri2Yc3Pct
 cvOEA9/ZoN6M2x8TfaK57D026XUxIKtKVgmAUczTf4Yw2aF8WvEuwVsRrZgW5xEwMZHftCmKu3i
 TdSWdfyMlJo5s0oP3WayRBjwa1yVevt9XcEGygKQFshCsdVhFIhU6kzVJQC0KqoaIpfdteCF7Z4
 6/oWcXsyJAuUH3H5KAnNn4EDwmLkTLUcZgz5XUeb0aF3Qs+VCgLfKugKAoooMy0MzGha11YgTtO
 pbt5EdAlMOAdkeams246kcSDJirJu3ckq1og7c/fi79UNfNAWXOiOyTVeUhre0dvtNQPraX2D1W
 KzTPJdiC3MoZMfmYed/FR+7g6NNhTsJQA=
X-Received: by 2002:a05:6871:2e96:b0:4a6:d447:c07d with SMTP id
 586e51a60fabf-4afdf2a858fmr10646640fac.11.1794870148242; 
 Mon, 16 Nov 2026 15:02:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe22576bfsm7743620fac.7.2026.11.16.15.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:02:27 -0800 (PST)
Date: Mon, 16 Nov 2026 17:02:24 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH v3 2/8] spl: add the devicetree of the next phase to the
 bloblist
Message-ID: <20261116230224.GN554944@bill-the-cat>
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
 <20261116-mtk-mt8189-tfa-fdt-v3-2-ca423d2d8038@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I6k8yGCupkH634CY"
Content-Disposition: inline
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-2-ca423d2d8038@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--I6k8yGCupkH634CY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 04:32:43PM -0600, David Lechner wrote:

> Add SPL_BLOBLIST_FDT to copy the devicetree that SPL loads for the next
> phase into the bloblist, unless the bloblist already has one.
>=20
> The next phase then takes its devicetree from the bloblist and applies
> the devicetree overlays in the bloblist to it with the existing code. An
> earlier boot stage, e.g. the one that initializes the DRAM, can then pass
> an overlay with only what it knows, without having to provide the whole
> devicetree of the next phase.
>=20
> If the bloblist has no room for the devicetree, move it to a bigger
> buffer from the SPL heap, so that the earlier boot stage does not have
> to know how big the devicetree is. The next phase only finds the moved
> bloblist through the registers, so depend on SPL_BLOBLIST_PASS_REGS. If
> the devicetree cannot be added, report it and carry on; the next phase
> then decides whether it can boot without it.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--I6k8yGCupkH634CY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavuLfQAKCRAr4qD1Cr/k
CtkeAP0aANzsw70pHKbLekD3xx6tHiPyz/dIDP58ZWbLF6sjBQEA8IPKW7CaPiXf
5bNBHdO4AmGix5EoSad1ZKCw5Y9UggU=
=MhVA
-----END PGP SIGNATURE-----

--I6k8yGCupkH634CY--
