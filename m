Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24422C982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4DCC4078F;
	Tue, 22 Sep 2026 12:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E73sYFuN6UpC; Tue, 22 Sep 2026 12:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A93F840759
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081254;
	b=ROTLfsAaDHUK4DShkfSvGETvl/nOp1be34zAImfpdGQOBMwSAyeZ90FMumPSB3XoA+6W
	 1oqdT9xZkh+BjYX6LyUWRQtU05IYhCkycEJ9IwNyk9WDnpC+PxYqNWLnYH/6ZJS3chWvK
	 3SdS1HFC8G84HgLy2+t1BXC5UpfuXUdMR0PZNPWT/UCGDGF33iARrwKtVb5QECF4PDxdu
	 X1Grr/oQWcSprHxwjIDaUhDnk9ErIuKHjV3iSeUP6sKx/Ik/kMLBLMNmz/rSJICaqWdX8
	 X0EX0pUBCb6RXsBPF2xAkRPc47ovIRwsvJHhx1LKa/F/J3oU8UkQ5mBc3RGpU+t637g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nNof15mse7UhZMpWpFRMPUA27FVtRlcbnDj+YRmmnjg=;
	b=VGsuAuQL6LHCmZdWkQO+li/cTmuDL67GvmW/moCHODauNMfWae/v1qk19nmIC5f13PIN
	 n4xJm9O0GlX1jrJY7287wG9xjp5DB5GopyM0RbI935zt15hDhT8sXnM0X8Nf53ag1yazT
	 +x0elmA4KzBAmMFnTQHAiwJPLCgcPqgAVboa/D6JsF8OR5qRMi5qe40PPjjaXH9dIiV6p
	 7FUObCUp20eVuZfHBUTBTPg+rEbgP1sZYIRFAS9GFgbkCNMivdnAXGpHTP9P4gL3vWqqg
	 FHq0ub2Tx0cPddWMPlGrWFH/iOYxkcJ+K3HIDNT+T4UNYVQrnwvNqucCMjkWGV6j4kA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=n6cziN3E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081254;
	bh=nNof15mse7UhZMpWpFRMPUA27FVtRlcbnDj+YRmmnjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jwBMP1DWYms50vcmxAqA9q0Y7aTiAGh74lfEtA02TOtYe90S59OFxFcPZ1L39kDxe
	 MPUoL0O7o9IwaKaE+am2PhnlvAI+fvMEv2vf5ssFt+cVZF45qbiz3Rr1Vp2t7QWxYs
	 vS/UYhrbvO5UA/0ziazb6/4LCtakJjfGEt5Ig/eOCWAaDjImspDS/o3M+5BthSS3RL
	 cBzWgyLHgR53nUcVBx9W2VP8F7LgbqzAJlHmttk/oKSBSoltKSs9EP6o3MQNmEFI8J
	 hE66U63n55hnNUec7H/oryntNlWWFBani0oRCVKKtXXyL7guunpDRETfwfFiwTAOBg
	 tWXfniGgbLxlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A93F840759;
	Tue, 22 Sep 2026 12:47:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D547312C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BABDE40705
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJsou2j3oOaF for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 017A8406F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080620;
 b=Epni6psldtXsrl8WMIXdyigiXGMlQW2hhSQWeBbUPWsshV4/BdMnROqdKmL6Q8W2soD7
 AGaLoKdmSKP8IbjVS6uS0Yd5dQr1TqIIuJ5o+5q36758lqda5DqwebiNlG17fjWPmYbhU
 O5VM5ZJdCCwZm7lC4EIeqiF4QUvtOq7W6UTVRH0/rmnNcu56Cx/vQAPfOnzqujLq71Iub
 9Nfq96Qr3pcaArvrthNLzd8LBddCHxSKo0b0AqZpffjAjde0/spKEqorC0aj0eNh5FO2w
 DtMdpf5USS8VIHvB3kdJ9n9iWam+RTGi0ip7R+ybygdLnaOFvrVDrijvrI+5kP6xVBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080620;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=nNof15mse7UhZMpWpFRMPUA27FVtRlcbnDj+YRmmnjg=;
 b=QrAlS5V0UHEJMYzcVj1T740ieBi6Str2kAvL+BiEmjvAahy4cpNJbS426pvuDebU4I4N
 DNJC1QUed0QAP2p+fC/5eXTiAPXJkkb3JNe4IZS/uAX2gtePoMPbQKSwE8dZ4PuMYGawt
 GDjodNIod97N7SSYc/foAajoerKttZnWKQiBi5p19k1DetetWagZAHK9J5qxXq73oCl6N
 VZfiMZDfidAC4gvlezrovf7o1Wf0j7MUxtx1zS0deV+E34nx7Qcqm2OPQ1zumvp57C0kn
 V2hBUPCvlcBTq4GD7GNt1vV/emuaM85J2QWo7PV2W9ovH3D/CFvDeLjMEi/ZqB6/MPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=n6cziN3E; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=n6cziN3E
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 017A8406F5
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:36:59 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AAB63F5B7
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080616;
 bh=nNof15mse7UhZMpWpFRMPUA27FVtRlcbnDj+YRmmnjg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=n6cziN3EDa274kqaGDjoh9ZnuZntcNNrI7fRrAOpPeT+BUSuoiT1I8NitF73Y9pIE
 Iod2wHvhVFoTK+h2k/d+W3BON8eSSqxZWbJzE1je5tTtQqt9qeYMPJR0r1qRJS2/wK
 hcfo71+iTNPRx0muLuXFN2oFQUIemo+9VUvxo8eXia+nArOyUNThXfwlHAKfu/oX2E
 vN/ADKrNmWYB9ybItphv6LIJ0b6ZdraWOU7H6RcnSNiew2fnnR9yMBz1UznvZlGKHs
 0LKqA66DUZftz2MiGQ07ih6bkrcMJ5+NElQo5P5d7w1TuXCY6G0b7JnUDXFaKVXMSE
 pqQPXruROS+ovCA0+L4CYEMH/rpXEJkHuX2bY+a+myrRTqdRcTJlyAVr2zGtAEbyTR
 cL5yC6uEhAMtcZi5iPRFBN9kgIt4tJORAkwOwqLwUqotpP0JxPGhsHFlvw9Saayl0h
 UFHs1YCsAGCM23yMfE4QVEselquf+7fDX9WLAwY2uIFTeM8JQSGGPQRJGPra5vEsrZ
 y2pZKeFM2QDfapQ9hBkTFzwJZs/fLvqhVLiRpjb2ZfYKyiVKaLQ5n4gTg6WEQ/sf6+
 3rV40+PJ35ci1dj4dcGewK8IdIQE/Ezu5yTtEx0eYaG0OLOUr6rg0RjxTimTzc9La3
 vrJnIjPx1Rf8o9fhhfekiqoA=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db87f759c5so77886845ad.1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080615; x=1790685415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nNof15mse7UhZMpWpFRMPUA27FVtRlcbnDj+YRmmnjg=;
 b=Uy6mdSXjZrMu3/XvWktSgxjEuJKAKW/3h6Nx9by87w7RHuirO2euBBJT8SObQM69Mt
 kjYVL13sgqpSQeQjDd1t59or3QYvo5QNAukvGvbx8UEM0GGfzEmef8v4vTQX1OBEJbUN
 +cfR4FAnNM1s2AqvD+Un6z4nnV5o3kwD27/PAsk3FIAG2CvwLX0oY+g1Z4P9qtRztWTx
 F4y5IEckQ+P61Cpg7k2D76p0HIrQhyQf95VHsxcS8RYeqZHL5H6iztq+IDKDsXeWBNOZ
 XTBJj6tBnpsw/uRIz2dW0lCWBIH+t9L1IZZ2a4xdxTfKrn4kPNCY/TIsmzTHMFxfDMot
 aEew==
X-Gm-Message-State: AFuF++mafqll6GKtMATzxiqqBM9q/PLisqd6DxW0gBiK4IW7b/T0ZU+O
 UoXavB4cuL0Cwz5ZV9THQqY4YtiovMjm76a//jM98WRiUXPjQSuuW9Ht5ju4fb04Pw7guGBjp+a
 WojbNw84AiPWytZb6GscDAlUBCgfh9cKi4k46WeWpH75eTYdSMLY/pq4ycuhoSf/i46KHWCrOMU
 eSPXp7OiNWKz1Y+CbLqg==
X-Gm-Gg: AYBFou1KvOjdT8uJxDcjur/XSmHfp30YOSYih5sxDG0IjHwgKCsMywBxjgC40BE1gcy
 n5a0UHtdeAN/EkBXG642f185vs9XlSdDF+t1jlX/lDrnO1I37t4Da7EKRKaXUI9LE9Vwu8dQWo0
 xsQPMBkBT7X9HyKFairCsDqRgXIsca7mkG81hi7PspB9jbGy+oY2DGCxTZsclDljOPAbwHG5uJ/
 tTwOC0nmoaPpZtkz0aAxaOn3e+IGm3KNx8VXeFEmKQj+5eDSSmjEvTGOWBw1pukcncoK7tW00pW
 4uxIaDnYgpQQ0GQOGmynR5KQAFOsoUJvajL1/SB0zdu0rfEB6ZRDE3yMlWGNBjQeWjJ+P0eG/Vb
 Bjt40NrDIwl6VM5d7mW9Hweqn0PEkaP+ekX2V6Z6tpTrGcKV9zs22RCvV5En59g==
X-Received: by 2002:a17:902:cccf:b0:2dd:c100:b2bf with SMTP id
 d9443c01a7336-2df60b60b50mr11833535ad.42.1790080614815; 
 Tue, 22 Sep 2026 05:36:54 -0700 (PDT)
X-Received: by 2002:a17:902:cccf:b0:2dd:c100:b2bf with SMTP id
 d9443c01a7336-2df60b60b50mr11833195ad.42.1790080614222; 
 Tue, 22 Sep 2026 05:36:54 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:36:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/7] tools: mkimage: support shared image data through the
 image-data property
Date: Tue, 22 Sep 2026 12:36:20 +0000
Message-ID: <20260922123630.608961-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912124454.13578-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 12:47:32 +0000
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

Link to v1:
https://lore.kernel.org/u-boot/20260912124454.13578-1-aristo.chen@canonical.com/

Changes in v2 (from Simon's review of v1, plus one cleanup noticed while
addressing it):

- new patch 1: drop the duplicate FIT_ALGO_PROP definition in the
  cipher node block of include/image.h, noticed while adding the cipher
  property defines requested in review.
- patch 2 (was 1): add FIT_IV_HINT and FIT_IV_PROP to include/image.h
  and use them in fit_image_setup_cipher(). Non-functional cleanup, so
  the Reviewed-by is kept.
- patch 3 (was 2): fit_resolve_image_data() skips its own pack and
  rewrite when re-processing a FIT that needs nothing resolved, while
  still validating every reference; reject image-data combined with a
  complete external data reference before the import when compiling a
  source file, where the combination cannot be legitimate, while
  re-processing keeps import-then-compare for the resolved form;
  complete the kernel-doc of the three new helpers, with the cipher
  check describing the source-file and re-processed cases separately;
  explain in the kernel-doc and at the remaining check why it runs
  after the import; add FIT_DATA_SIZE_UNCIPHERED_PROP and use the
  property defines.
- patch 5 (was 4): the commit message now states that it completes the
  validation for the new property rather than fixing a pre-existing
  problem, and the kernel-doc of fit_image_effective_data() gains its
  parameter and return descriptions. Comment-only, so the Reviewed-by
  is kept; still a separate patch to stay reviewable on its own.
- patch 6: new, user documentation with a worked example under
  doc/usage/fit/.
- patch 7 (was 5): two cases for the complete offset and position forms
  of the mixing check; the Reviewed-by is dropped because of the added
  cases.
- patch 4 (was 3): unchanged.

---

The 'Shared image data' section of the Flat Image Tree specification [1]
defines an image-data property: an image node names another image node
under /images whose binary payload it shares, while carrying its own
load, entry and remaining metadata. A multi-configuration FIT can then
offer the same binary at different addresses without storing it twice.
The normative text is in the specification's main branch; a refinement
of the cipher interaction is under review in [2].

mkimage resolves the references right after external data has been
imported: the target's data is copied into the referencing node, so the
later ciphering, hashing, signing and overlap checking steps see normal
image nodes, and the property is retained in the resolved FIT as a
record of the sharing relationship. Invalid references are rejected:
an undefined target, a chained reference, data that disagrees with the
target, external data properties mixed with image-data in a source
file, and cipher settings that would produce different ciphertexts.
Consumers need no changes, since bootloaders ignore the property and
the data properties remain authoritative.

Patch 1 drops a duplicate definition of FIT_ALGO_PROP in the cipher
node block of include/image.h, a leftover from the cipher support that
compiles silently because the redefinition is identical.

Patch 2 makes fit_image_setup_cipher() use an explicit iv from the
cipher node when no iv-name-hint is given, checking its length, and
fall back to a random IV only when neither is present. This matches
the specification, makes encryption reproducible, and lets encrypted
data be shared without relying on an IV file in the key directory.

Patch 3 adds the resolution and validation described above, covering
inline FITs completely; when re-processing a FIT that needs nothing
resolved, the resolution step leaves the file to the later stages
without a rewrite of its own.

Patch 4 makes external data mode (-E and -p) store the shared payload
only once: sharers skip the extraction and are pointed at the
referenced image's region through identical data-offset or
data-position and data-size values.

Patch 5 completes the validation for the new property by teaching the
configuration load overlap check to size data-less sharers from their
target. The check runs before the references are resolved, so such
images would otherwise escape it.

Patch 6 adds user documentation: a worked example page under
doc/usage/fit/ showing a kernel offered at two load addresses by two
configurations while the payload is stored once, followed by the rules
the producer enforces, the resolved form, the interaction with hashing,
signing and encryption, and a pointer to the specification.

Patch 7 adds the sandbox tests: inline and external sharing, mkimage -F
re-processing including conversion between the two forms, the rejection
cases, encrypted sharing through a shared iv-name-hint and through a
shared explicit iv, and the overlap rejection.

Each patch builds and works on its own. On sandbox the new tests pass
together with the FIT, vboot, mkimage and cipher pytest selection and
the complete binman suite. The feature is also verified on hardware: an
i.MX6ULL EVK boots an Ubuntu Core style multi-board FIT whose i.MX6ULL
variants share the kernel, ramdisk and FDT payloads through image-data,
keeping the image at roughly 40 MB instead of the 78 MB it would take
with the payloads duplicated.

[1] https://github.com/open-source-firmware/flat-image-tree
[2] https://github.com/open-source-firmware/flat-image-tree/pull/58

Aristo Chen (7):
  include: image: drop the duplicate FIT_ALGO_PROP definition
  tools: mkimage: use an explicit iv from the cipher node when
    encrypting
  tools: mkimage: resolve image-data references between FIT images
  tools: mkimage: share the external-data region between image-data
    images
  tools: mkimage: include image-data sharers in the load overlap check
  doc: fit: document shared image data through the image-data property
  test: py: add tests for the FIT image-data property

 doc/usage/fit/index.rst                  |   1 +
 doc/usage/fit/multi-with-shared-data.rst | 114 ++++++
 include/image.h                          |   5 +-
 test/py/tests/test_fit_image_data.py     | 391 ++++++++++++++++++++
 tools/fit_image.c                        | 449 ++++++++++++++++++++++-
 tools/image-host.c                       |  20 +-
 6 files changed, 973 insertions(+), 7 deletions(-)
 create mode 100644 doc/usage/fit/multi-with-shared-data.rst
 create mode 100644 test/py/tests/test_fit_image_data.py

-- 
2.43.0

