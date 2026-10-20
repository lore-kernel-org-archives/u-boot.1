Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A4606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mHeK617g;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XvdH6eHt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D9096083C;
	Tue, 20 Oct 2026 10:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fy31O_jZRnua; Tue, 20 Oct 2026 10:34:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CD2F06084B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792492460;
	b=M6qLsZL9GkXdNe1+h0q+jwK+XQMhHM0B1wAViDEyfZNWWuiMbX3+9Qbb72UzPZEN0yqB
	 9W7CjTP5nTkdqyzNPSQyjiFqiVn9gxHLLFtKcCFDWgk20fdkt+MRvN9RwD16DsyymWY+Y
	 uf9AwL7g/00LsCOAmeZAe95III5z6mBqoxbLQCHnvkkAfQOXIGdAg2p/ds0j1bvU7kyhK
	 NxN95GcAUIJhbDpSZiFADsHMYhNTYZL+rphqfHdavkm87sW7vPSBhmH5z4Kh9pZ4NkK5T
	 2X8rq89cTBJAErcVBZH5EsKTPKypfvOOirv5ya181O4vaoK5rgEFDDrImcSzYXwd6iA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792492460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YvhIVxSHwl7/mQjcvDwqj5ZXK5EzaVfZ1sXMLQTf8DU=;
	b=T0FO/JZP27a/FUPUK2a+vcBvyKZ3pKRoiOAos3R6KLWAK5bT9HKKC8wMe0mYoC//LMCJ
	 kq+dKXxwEN4SaQ3Z5VkX+gQJfhkuoJ2oiiEXzWxyuvsJiXZIra/PUmXtxAMNyeCIxPMT9
	 c6ThrvOMuN8bVOPGq9bNZw5xlGpuxQj5jy/Mz+RDuF8OBXlIBU1KQ2BkhDaKYSqAK++TO
	 N+JBlk2zwK6bgm2ioMRz+4rG2nX05qOzcMWCILXnCR6dbqDQZv2G7L+NV85s9oVf9f+cb
	 1P5u7HPWwjptSU3AH1eLqwFr/4lE59EGE5+NU8fuVdqXori9nq8Yt9r81Qu1suHttCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XvdH6eHt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792492459;
	bh=YvhIVxSHwl7/mQjcvDwqj5ZXK5EzaVfZ1sXMLQTf8DU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mHeK617gqCWS4gnsGPMkGP+H7KMW/n+tPBfl60YM2FPsbLpbcTAlpShtwGgLVfx5i
	 TYwSu+9f3P93JpYW/nEOITGlkjx4fDOz1eFyOfVTwPW4OG0oEBSfqRgpLOAgmUN4Z4
	 s2kjzpBqQ8X/k6vBVSPT4DDC8GXsjWqRdPXRv+sB51k/Lj5GZrKSFRdBKOfS1fCScr
	 Yb1Yo1BsG0ozgL5GcNsR6iRBO0YnHyOfdlqS9ZzqTD7svzJAAhvDAsX+VJcaOlwO03
	 resRt3Ajjaah1nPBnAZbVO1H4UdSvIKoJNEF/a+5EYx1ceNhXf04OmjlytphFXps+I
	 lulNXE8SEKk6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD2F06084B;
	Tue, 20 Oct 2026 10:34:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ABD53A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29BAB6083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1IPRIPPAcp4E for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:34:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43D0F6075B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792492447;
 b=kMiu7r3vtR/k1l3CtFvb1mR+naPeGIl0+RbaR8o6OLRfsiewgb/QRo/Wm0BZtGmqYjch
 TJ1vcpV5WU9BOK9xZtZ/S8gcl2iNKpcbp2+JQooe6o6m9gkjjT6w/DXaGesjFUVdXnKXn
 w2YqHqyzMd5QEZERlgXttKBehXAeXwT3rx5jIGVcj8YKn130phprPqQiFHVbL95lsR1pw
 zYda2gJ+uAWTu5sPtExV3SodEZXmqBz1gt+qCfuXD76kUBB2ExgJFN7vd4poqsCiCeb6H
 adADkbKA7XnAqf5h4+ZxoS2BPK4r57nMMremKgQQNuX0kiusF/e8Rpedyo8XlAwRn3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792492447;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=YvhIVxSHwl7/mQjcvDwqj5ZXK5EzaVfZ1sXMLQTf8DU=;
 b=qz26ArMrAc6m0/FGJlATkLylKK6nm/lavbUMncVQX3zDhCpiN+1Fop8jDVKTGtvx/rI0
 QejRlYy7gbKAz1aELGlSnY1nPq8HVo3M6z4VPCtEGpbfTiGQ4DnUFmX+VlRvNVPKotdsq
 eE2po5AEcfVKOCBgCI/z8Ju0fYWt5GwiYsF8UTUvN6OLKsPbk/eWnRKSOOeldUaddmglG
 PrFpvyytOWZMwA1RSdKoDRqAJf+qYOdqgCkwNOkwJEsnwBh9sWEDUJ8nsVC944w/EVypC
 EL3dioEGeTZtEjtmh0lWruOhvor6Vwj3XzGCqGIiiRqzj4pL5hW9rcj0/DUyiuAnkIg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XvdH6eHt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XvdH6eHt
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43D0F6075B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:34:06 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1fa22006cso964955e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792492445; x=1793097245;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YvhIVxSHwl7/mQjcvDwqj5ZXK5EzaVfZ1sXMLQTf8DU=;
 b=XvdH6eHtojiODQB5OXjpDwMCeuT/UHQEeuRUVAQkfA36x+GkUfihSpCyJBXF6ZhmDW
 4ZWKilFpY5sGbFo8EytTYYpbDr1MQXuBldMN2wnCCabCSOHcYpuBTy/FyKNO8QaJ0ve7
 3WOsSFNNLkLY17Qho7mIjP5x3rSfj7F1jz4sp1xKnBHMC06MhySbRVvjqCQ1UqnPYKO8
 Y9nFyGpMIoRJV8HUZCZrEwMstiJPfjzS/0pDSAoPhaO4iAXS+in0793AcnUeB9xQu7O0
 BrRIcXZGPQpPNxQ3gSl8MwSlsJYy4iw68mw3vYPGtYpu9lBc4iD3DvFau/hAeOlF0IQI
 OubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792492445; x=1793097245;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvhIVxSHwl7/mQjcvDwqj5ZXK5EzaVfZ1sXMLQTf8DU=;
 b=PQqdTVMaJLEwG9Tm7Dn3QvMOrjtrjOTQf6+0CSSZ0WsHMcRBD+r7ky9XFznpIJj1j5
 vLMBbpyscDbcV9Kmt5T9Vau0yKdG/e04AXHhq9+iAQmr+2BagF7uMHezD5xZwA/YWNDs
 qmH2B7sZ2lFF7UpLylNvbaOYoDXmqPDmBO0NZilgBVjt2qkSm92IC546UkXY+J7w3Z8y
 WkLL8HBLKkh3AqGyZGPxaVOOXKjCvgdiZrJIIrPJdpEfibw3t5va0dfk1pRUex/UMyN+
 Z20x3Ow/7l4yR7x0haO+OMntt0/4K7bMq2nQ5qyAj/UcWOcWa+a1p9a0r+NhBeSFejsJ
 kmEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBziOghhZdb5W7+GFD9TnKKWJLgPJsc5/ma1Fqx0dMGP+qOIMKw5TANWJYubVwSFfgSRE/duAgg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK8iCB/nkLh7aBxgRyc8UXonPi55usdszb6uMI4CMLU/RpljCeD
 G2F1dZsLCM0/WNi2LbxtYHPS7LWDleXo5jA25MTkttfqzhKyKh720mI+V6QKkZHTDm+NIhGHvQ0
 CTiIy
X-Gm-Gg: AYBFou3Y1tdeZ7xd4AO3MkB0ejZ8y/bzzbA2xyiD5sHUqLa16/DUiFDf0TEv+fsCR+2
 QV44u2Nfy5z8nU+Fmssnc8HNtujDUPb25eGZPlUcQFe+E88ueLqwPmLjXZjtqoSWL2KbIOYdxls
 fWDPVG1znA4fgHgYfQVKm2sZFjcqCRox+dfy0hlSfzGEDdt7xCncXvdc2/Uwkzh0YVwfkDN7vtW
 x7QRmry+kbqCfznGK8w+0Pjk349JjKsof8jOtTrOKXk4zEU6yLPNgCN3QmCWTv/XuWNQl6tFEfF
 JozJNRvx0m0ms1ERVWKLWbsxQFL2beITe/0wjUBLpc5XdSbQptCjKhgXB38pmz2BnBd9py9m/G/
 VUrpgEsuXzQOtpfEmKx53WZfMEIShjZtlQi1tschn44Y3syT70+ZqDvd7bB/PlcGVGSmbgQ9ydI
 BYSJbxYePM5cqXC1Y+7rfKNVT0bZzlm6DHf2qckX+XEcCNSMoTf4N1Hkioy/OD8LmYpfrEpD7Qd
 xPVoq2vi1fOuHAwJikg
X-Received: by 2002:a05:600c:4f42:b0:4a1:ddca:8b66 with SMTP id
 5b1f17b1804b1-4a1ddca9066mr236753885e9.31.1792492444523; 
 Tue, 20 Oct 2026 03:34:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm67880245e9.13.2026.10.20.03.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:34:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5/5] doc: android/avb2: document the root key
 provisioning and lock state
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-5-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-5-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:33:56 +0200
Message-Id: <179249243657.2829155.4053591683527777102.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792492440; l=630;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=DCGDr9KV8IAU/ZsuVgob+/71DyhSx8MhOekKoYoV7A0=;
 b=02sxT3Sc/XXRNMGPSkt0eO+KqXkWevcTSgXkHc180UnzlxTsYNtoN2VBZtozVaZc4nANZhuTq
 8p41fdSH46cCe/8dTHAxev+hLM3oCtu5vFs7XUWbzVbgYeyVpyT+0qX
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 22:25:07 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
> how to derive the SHA-256 digest of the vbmeta signing key with avbtool
> and provision it into the TEE persistent value with "avb write_pvalue_hex",
> the fail-closed behaviour when it is missing, and the device lock state as
> seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
> mandatory userdata erase).
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
