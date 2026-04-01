Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AB910FCAF0
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37CF83CE3;
	Thu,  2 Apr 2026 00:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O48l2+X3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D75A840CB; Thu,  2 Apr 2026 00:14:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE405839DF
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66db0cf6a4aso485683a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775081672; cv=none;
 d=google.com; s=arc-20240605;
 b=CN0cH5K+nC0MstP9E0y8YyIv1GM9IqucxB1jvaxTuHDYe7UyX/xAVJ9r3NWPHczF3p
 ZSHq7B0/jx57lZyuB1DKEcQe61Izb1t1FV2G9mxiX5tigchPWlY7quivEld4zraUkZdj
 7X4PAacYrA43+ndUcodqArW+hz11B8VK0ejgFAyiGX4BBhnVvnTHmd5SXTcjvMfVIEY2
 VlGyC71Z6/Vi+0n8vA/UcvkoiQXKm61+Rk670ePLAUEeBWGogXoqzwVdEvdo14i8bRnx
 3tuVNaVBZDpVTZ2JdDDD9piloZ5NHMgy1jGu37ysLoZylXKA+b6JjW5Q1+0GXJeeYIqr
 ERoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wvQhI16dYtHa366b5giYMg1G2/KyRSxTbxFeRuoqZt4=;
 fh=I4Y6k8DxQJxdWtf6slzkUPsLH7wXAVain7u8cXa04ZA=;
 b=kBDxuwHVFeaCiLrOtwTKD8ygeWnCHTF9DKMRwd+ifVDh100Tiwn7XsuRW7QRFOiNjj
 4hjYQgFdty7qXt4Vn+CFGMjcu3tAYhRtzAzlc+cX6Ict2jM673mAz1ySLVkNBr05klVv
 dKrDP/aysj8UCFtWuPgm7eCcEM/0dJ9XQpvPb4xCEWRLYRzvja+kseu5BDOBRMmhvdVF
 ay65RGLSx2zYiT7fLve5MuIz/btERIs1rw4dDlt6mEC5qBHVpGPZTYhbLdUNgXK6vtx8
 OV8EO+epw/Pj7JFYYr+azFs54kdaFRw9cGBFwgIgr8i6izRGhbko/13OBWGMHBSfT3an
 HsTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775081672; x=1775686472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wvQhI16dYtHa366b5giYMg1G2/KyRSxTbxFeRuoqZt4=;
 b=O48l2+X32toTZhFuJAFydcH4RfNHvXVs9icIqX2GO/o++C1ixh4uA5FjXaFQ85MAux
 93+NwQpQWR+fboM/AbaebEub8dxwGd4jGkdR0LIL0FT2S2ZEwLoT77I1V0BL5Xhm2woJ
 QcmP+xoy48Ed3rbTBUcgTtiROZSD51VdiUFF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081672; x=1775686472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wvQhI16dYtHa366b5giYMg1G2/KyRSxTbxFeRuoqZt4=;
 b=Yoqi72DpFXmfduE4D9SSz61RupRFybfbKdgicg2yiknbIavUm5qMu1Ga/+Sg3oNSYS
 2B95GzO+6zjvr/WJRC3wvY87Cqdz+3uEbpZcpApQde0DfpAznfYYd6lrRmmLRlpL2YVu
 StsG90cxDBytQO6Q4JBEbmum69LtmRQTCKVYLzYOakmAO1UIjhhDGHq5e1paMxS8e3Uf
 LFU/lCCPs3aM3UZ7MaVEI1v1w8zNfXIBNFiuc84QkIStvRkGyrCB61vKtiBR8jdW/+JS
 0j1FDU5TyNHTFUxegWXjPdKfsCOKGWHgb/2VgYzARzSeA3wOjt81WAiMeGyOG1+YRfiS
 gJlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhQQhiAxDD9akPZbQUPoPMjSMfZyQU0yUWkUUHHR6ae+6OoQ1p6PoMvHrWc1z7u4/Zfc2BQ08=@lists.denx.de
X-Gm-Message-State: AOJu0YwIwfoIfFkfz7OanGTEZLPFEsh4OVgbmaN2n57QLeLVVYuVErj4
 uYsN33bSXXBmJgXu3DeQzdsXtdNbJwQoMEvrJxJwnqtDPSTSeOF+Fbx+Y/OepaU7WE/8Kfmz/Ij
 8AUKB48oq/GbradWxHaqMNSlKAd5ru4H5IBTbKQj14ZB5xL8YqBAONQ==
X-Gm-Gg: ATEYQzyUfjj4uqKmmrOAojAmrr//5IgE/vlxK8xmhdChTAXRarMwVo2O1QUQDJ07DOr
 j+/ng+72Qg5l2RQbf6PS+DjzbbOZvHw6BnvigJ3a+PbgCRUAJPkkczzMgaDRHhb3XnU0wf75iEY
 qQ9U5HMxzYpwGRqemyej3ZOp/xJ/UMEWmrhEgth6SQG+P/gGweyQxZmQ8551zKemvfD01DSOugQ
 sXV2ImaJb0U86RVd6LZuh6A3HefAVqfxuF6tARiwPGiL9TDBtvCan8EwamjIRh5Lu4grVsg5RIK
 MZWLoQ==
X-Received: by 2002:a17:907:e118:b0:b9c:4af:dbe7 with SMTP id
 a640c23a62f3a-b9c13aed2b6mr242277066b.33.1775081672092; Wed, 01 Apr 2026
 15:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-11-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-11-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:14:20 -0400
X-Gm-Features: AQROBzCdvLBM7MRVD1x5c0LlLTfHKV31sx4kpcoACiXjt0d1Aq_1rFHUoYTvlg0
Message-ID: <CAFLszTgdz9ZOZ=LD8gK2u3tUvtVr2s7GwwtiasOYH26SfRuQrw@mail.gmail.com>
Subject: Re: [v3,10/15] tools: binman: pre-load: add support of ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -152,6 +152,67 @@ class Entry_pre_load(Entry_collection):
> +    def _CreateHeaderEcdsa(self, hash_name, sign_name, padding_name, key_name):
> +        # Check hash and signature name/type
> +        if hash_name not in SHAS:
> +            self.Raise(hash_name + " is not supported")
> +
> +        # Read the key
> +        key = ECC.import_key(tools.read_file(key_name))
> +
> +        # Check if the key has the expected size
> +        # if key.size_in_bytes() != ECDSAS[sign_name]:
> +        #    self.Raise("The key " + self.key_name + " don't have the expected size")

Please can you either enable this key size check or remove the
commented-out code. Leaving dead code in isn't ideal and suggests the
feature is incomplete. If there's a reason the check cannot work, a
brief comment explaining why would be helpful.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -152,6 +152,67 @@ class Entry_pre_load(Entry_collection):
> +        # Compute the signature
> +        signer = DSS.new(key, 'fips-186-3')
> +        sig = signer.sign(hash_image)
> +
> +        # print("len = %d\n", len(sig))

Please remove this debug line.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -152,6 +152,67 @@ class Entry_pre_load(Entry_collection):
> +    def _CreateHeaderEcdsa(self, hash_name, sign_name, padding_name, key_name):

The padding_name argument is passed here but never used in the
function body. ECDSA does not use padding like RSA, so this parameter
serves no purpose. Please can you either document that it is
intentionally ignored (for API consistency) or remove it from the
signature and update the caller.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5894,6 +5894,37 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadEcdsaInvalidSha(self):
> +        """Test an image with a pre-load ecdsa header with an invalid hash"""
> +        entry_args = {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as e:
> +            self._DoReadFileDtb('352_pre_load_ecdsa_invalid_sha.dts',
> +                                entry_args=entry_args)
> +
> +    def testPreLoadEcdsaInvalidAlgo(self):
> +        """Test an image with a pre-load header with an invalid algo"""
> +        with self.assertRaises(ValueError) as e:
> +            data = self._DoReadFile('353_pre_load_ecdsa_invalid_algo.dts')

The variable 'e' from assertRaises is captured but not used in either
test. It would be good to verify the exception message contains the
expected error text, similar to how testPreLoadNoKey() does with
assertIn().

Also exc is better as we try to avoid single-char var names.

Regards,
Simon
