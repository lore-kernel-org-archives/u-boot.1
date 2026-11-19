Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E7606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EztLWLlU;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aTbsZ2XP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 288C240E0A;
	Thu, 19 Nov 2026 23:33:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a93NoUBYMzyP; Thu, 19 Nov 2026 23:33:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3DF6640E0D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795131220;
	b=fdVDTUZCNq1b2/bU4s1ecRUcX4f7dgycTxMsboWIBOtfEC1l0SdWImVPyhdlT/Vvx2aN
	 ArAelmsE734pfRP7xer59v7toJ9MsEhRefdjpROzsgYaq3GbrkFgUGJEeVMM110li2Tx6
	 QubtuYpDdnEa8dUbAkWIEmwe9P9VBHEKsQX3HjGtpa/7BEZftlnJLUfQ3w029vlNTFCg6
	 62V9ccwqM2eikz+o4gzwdV66NmUoJ4jyEqFQ3PmbNVN7A1smrppL/ZAbGss4pMmo6VXvj
	 8xj4OjQWAGzCg8fX2EoC4mhBrESwDGQpy9LUYOgtwmg2mPh2Vu3u5XxeopyCSItcuUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795131220;
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
	bh=TQNdeRAp57Fdajxju2ItfO0ZVgJNbHhFX8PPueIE/yY=;
	b=XKYbIZhIqMphLD1P4PWsatoNaipI/1ciLvMpVP9h5RQrxg3jHzo2LcAVACfFLqgdpvyv
	 Oul4fuAZxrQLphCaWIw4r90jBCtvSe5ks5u5pniT96I/MFr92AWiKAQ5uGOeGK3Myu1+4
	 ad/gmvCurzPgA9yGlGqZAoEenlmtQ4x3yXW9HUwECxJlHqNeeXIdd3I9SPKJOPHjqT6kr
	 ynpLq/1pygH0ty6fPvHVrLBfqaGL2CbNsQj0emYCPaPPlNJU+uTDDbbVfYGSd897BEx+Y
	 OdUoosCVZBb8SmbdZrFgjAt0QRZX9girm0W3hKC3NVBUn5KfQrvWGsoGR1d11sqoDdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aTbsZ2XP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795131220;
	bh=TQNdeRAp57Fdajxju2ItfO0ZVgJNbHhFX8PPueIE/yY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EztLWLlUYZkX4KrsG6Ugk3gCzPSM7dxTFcAHFq7Aiiw5PMMs2hABXUroNVCMsiRXH
	 xQxuOKploMSOOUenm8p1kJI3B0goExzG0CQeoOOtxVLx94NQupmuGb4PRFGG7cRu14
	 xq70BUSjM3PJOGGAxI9+M8LIHOPIejBlzTLVDLy+juTxmMePrFOZjXZL4a+5Nug7qr
	 xOvjiT2t4PWrcuN5/5Q2uV790iStDoUTYSZtI3Dp6WvqzL76fL/0T5DCiY8osdGO1A
	 GLszJKA3B7Kzd27U+cvr9clMCGVCvt9DceCUFuF+n3GhlJe9QPi//+K34oVXkiRAjO
	 Hz+pqy2aLZDFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DF6640E0D;
	Thu, 19 Nov 2026 23:33:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94C29260
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A8E440DAD
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l9h_rbyv-jdr for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 23:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9491E40DAA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aTbsZ2XP
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9491E40DAA
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:36 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4877837890fso222012fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795131215; x=1795736015;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TQNdeRAp57Fdajxju2ItfO0ZVgJNbHhFX8PPueIE/yY=;
 b=aTbsZ2XP5ds8ScJHhUmE6whFfHeJBVgQ+8ZzknXUM/zYviryyuw7SaBfmvuUhackaU
 +d0tpYj07oQMPYM2XZO+GEC1OUU2e/EgY6VNCnnXsRcMjOVxFWLiSU4S1suqwIsSzGFs
 KhEIAZhGEOUEvVMCXOiyDrUTyker5X93cIsFoU4e03z/2e+rd+S04m0mFAXHGnA7XZZ4
 mtQzq6f6NpZS9hpCxEB2E1QH2jbbZAHUyFaeN+SY59D/06RrL8vFHC8gYPzkpvpiwPbz
 eK6v7LGJco3bUIoNaBdH/9u60omR6usn6pCtHJACj9ARjJVE9VRG+IHOvwDO3tCsCM+g
 06PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131215; x=1795736015;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TQNdeRAp57Fdajxju2ItfO0ZVgJNbHhFX8PPueIE/yY=;
 b=14XFanon0iYQrVbAugU5ZFGKsBPnRf88xsRGX/tT5HIZF6erNDv6Stro2QhNV8ahoY
 oIYdEsu0wI7uERB5NzTNqb1ACHerLPy5jpGKvgp6gBhPWeo5YzqQICtQM6c1Lt+K+QhN
 9Ai8nBERqxjfJpRE8BZtL7ed+aYws35YCBU+0q3IW6Nyr7bUoxKt6QIVl8khVDarFY/O
 maI2My5IxLB+tltTnc2ik2FGGVjqCEfDrfnNAEpMlmffXfNpcxWnCGNmPdNwl98aiEPh
 H87xupu/Pt+TUdU2tjXmV9aaahwEZ38JvticOWeJKPSlULgYb1ubibX8oC1EUgmsf6L3
 +VVg==
X-Forwarded-Encrypted: i=1;
 AL+hErG3RO0Eg1efNP+pvY3Y++8kb5xLJsGC0lXc9YLyiFCVKpwTU9HnSj/q0TAFLU/AxggX5U211XE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/M29z0dI0EanckM/hIO8zdQuCENxlSgl9XcvggVg/YhHdga7gD
 z2eOOd+GDUzi7tJRvD4T+JH/Ai0aBmxGVRXUFF7Fs5PYMvfavyLbtcJ6qVsKQu7mBl4=
X-Gm-Gg: AZFdTZfVGGgV0joUC2MCJOTqbq8koJ7F/m97rlXV2Bil1IeV7rlII+ZYnLdxyfClAhH
 QUafTu966qeqDDFVU5THym4MRYVbxNKu2NSu0bG3p5ZpjOhpsLa4irLHSR3o7aXofM/xkweHtyE
 W0C6pkhY1flvcJGq1kvdbNCya+OFec5GDXhL4UEGux9Ldk9mDppem6bXgDO3Q+YGVfC81K/AGt/
 xw1caqb4VB8uKRCcaT3yhUeWvVN1AcDCVTtMoCONW56puSUc3CYy2pdA64cUaYYVLPfXjSUBDId
 I1xIACTeva3nNnFMz1S3oYN99n/1+FQggVvMPboi1qGq7IbdeyvA4dGCFZvM25LHvdew1llImOp
 1Hq0rX9P975PFw6RlW3UskvFDqboqNk4ECPZzbJoi+RHxvK7G/eoV/znHDJONmRZ1E7+iBgt0Jj
 hC2Ma7TPwjy39qHj1Vbd6TCCsSJa7Kq+XoSKCClCQPqro6eeDNFucYyB5NyvemAgQe1ABuS1N4g
 xIT1wvf36Gkdw1kdhP0/EP5MzjfMWerBCRMXx46YW0Ww52/FJ9/TEk8ouyPkjaVbHjUh6IuETu/
 PFSd7YbMnxdH0E7kkts2arF2DuRsPiO1CQ==
X-Received: by 2002:a05:6808:1925:b0:539:c292:8b04 with SMTP id
 5614622812f47-57a07d12f6cmr2201130b6e.8.1795131215059; 
 Thu, 19 Nov 2026 15:33:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm813561b6e.3.2026.11.19.15.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 15:33:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/4 RESEND] binman: pre_load: Require key-name for
 file-based signing and fix integer division
From: David Lechner <dlechner@baylibre.com>
To: yan wang <yan.wang@softathome.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261117095322.16813-4-yan.wang@softathome.com>
References: <20261117095322.16813-1-yan.wang@softathome.com>
 <20261117095322.16813-4-yan.wang@softathome.com>
Date: Thu, 19 Nov 2026 17:32:57 -0600
Message-Id: <179513117714.2216103.2105831055136402867.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4148; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=bzAUYuAPAL7lPGuhTSwIY6JOR9kB32HNiO7syvdSJKg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/4c7My1sv3tpZgbaO95xZmbJeCQjk7/vkboCc
 MyF/XX2UWKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav+HOxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AB9IH/3XIH47n3ptdsK0aabKsN+pkRHXwXNismgNZD3C
 TvsH7nt2HYpdbg72nVGO6hIbblAV2A8eEmuRUD41znc2Abcu0PDGCg7QDDWWZPBicEr0bPEm/qy
 Ms81lYU4FmfhPql7oqqPFet7PIoSghTrCZFrLW4bZh8QH3hujCJZ70MscsDlrpdtEfk5Rtc9Ov3
 04Y/G3THuW/qHWhbX8s48LBb+T7dTIjpH65yf9lTtK0y3WuGeOb2PXU1l7iRwox4E9mqv89f4AM
 WqCFBoYHlMRHl6eN8GkokNNwVME6qpAhk0pNVvDVX0mg72On0Pj7LyvzKGY3PJpKUHwrlUXE5F0
 NP4E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Without a key-name property, os.path.join() is called with None and
> binman fails with a TypeError traceback rather than a useful message.
> Report a clear error instead when file-based signing is used without
> key-name.
> 
> Use integer division for the RSA and ECDSA signature sizes. Using //
> gives an int result as semantically expected for byte-count tables.

This also looks like two separate changes in one patch that should be split.

And since patch 2 depends on the // change, this should come first in the series,
not last.

> 
> Signed-off-by: yan wang <yan.wang@softathome.com>
> ---
> Changes in v3:
> - Move to position 3/4 (was 2/4 in v2), after the HSM signing patch
> - Place the key-name check in the else branch of 'if self.hsm_key_uri:'
>   in ReadNode() instead of at the top of _CreateHeader(). This is both
>   earlier (validation happens at node-read time, before any signing) and
>   clearer: the else branch makes explicit that the check only applies to
>   the file-based path
> 
>  tools/binman/etype/pre_load.py                | 15 ++++++++------
>  tools/binman/ftest.py                         | 11 ++++++++++
>  .../security/pre_load_missing_key_name.dts    | 20 +++++++++++++++++++
>  3 files changed, 40 insertions(+), 6 deletions(-)
>  create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts
>
> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> index c550de1efc7..1bcf48dfb36 100644
> --- a/tools/binman/etype/pre_load.py
> +++ b/tools/binman/etype/pre_load.py
> @@ -54,15 +54,15 @@ def _parse_pkcs11_uri(uri):
>  PRE_LOAD_MAGIC = b'UBSH'
>  
>  RSAS = {
> -    'rsa1024': 1024 / 8,
> -    'rsa2048': 2048 / 8,
> -    'rsa4096': 4096 / 8
> +    'rsa1024': 1024 // 8,
> +    'rsa2048': 2048 // 8,
> +    'rsa4096': 4096 // 8
>  }
>  
>  ECDSAS = {
> -    'ecdsa256': 256 / 8 * 2,
> -    'ecdsa384': 384 / 8 * 2,
> -    'ecdsa521': (521 + 7) / 8 * 2
> +    'ecdsa256': 256 // 8 * 2,
> +    'ecdsa384': 384 // 8 * 2,
> +    'ecdsa521': (521 + 7) // 8 * 2
>  }
>  
>  SHAS = {
> @@ -239,6 +239,9 @@ class Entry_pre_load(Entry_collection):
>              self.hsm_hash_name = hash_name
>              self.hsm_sign_name = sign_name
>              self.hsm_padding = padding
> +        else:
> +            if not self.key_name:
> +                self.Raise('key-name is required for file-based signing')
>  
>      def AddBintools(self, btools):
>          """Register pkcs11-tool if HSM signing is requested"""
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 8caf275d466..d4522e905e0 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -5981,6 +5981,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>          self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
>                        str(exc.exception))
>  
> +    def testPreLoadMissingKeyName(self):
> +        """Test file-based signing with missing key-name property"""
> +        entry_args = {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as exc:
> +            self._DoReadFileDtb('security/pre_load_missing_key_name.dts',
> +                                entry_args=entry_args)
> +        self.assertIn('key-name is required for file-based signing',
> +                      str(exc.exception))
> +
>      def _CheckSafeUniqueNames(self, *images):
>          """Check all entries of given images for unsafe unique names"""
>          for image in images:
> diff --git a/tools/binman/test/security/pre_load_missing_key_name.dts b/tools/binman/test/security/pre_load_missing_key_name.dts
> new file mode 100644
> index 00000000000..262219fb6ab
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_missing_key_name.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0+

nit: GPL-2.0+ form is deprecated use GPL-2.0-or-later instead.

-- 
David Lechner <dlechner@baylibre.com>
