Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E4BC79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C40EE40726;
	Sat, 12 Sep 2026 13:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GERafFTJipN; Sat, 12 Sep 2026 13:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9C26F40624
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219599;
	b=O2kRyl0lBBqTjpS0Ugq6ghWxvRUZoKJaMVQljXJiCN46KTSZr4JC2EuM5EPl+qnMmUOw
	 RsHLQxF4flVyP/zp6Gazfk/DWdkJcyNI++lrmL/JBilxw+vBj93yo97grrbl/Gg4WqAH3
	 SIDdlGQ4S/oSb9XKYp8RYgCB1Bd97GgzPaxN0VGZrRh8ye0mzJWknHZcP6+bmOHi5U9pY
	 v62fe6b/yL8JXk4cKC0kTvEZksAhUw4SXrmt22DlatIPR2YOys4JATDr5/g/ZdLeXquk9
	 4kkveqBSy0P1cmu50l2g9X44s2By6WxzaT9J7YE5p1RxQIf/Z0FPiOJFt3YRDoyyP2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eoUnqz9k+raSdywN9BM3dW3K+lsDk0raZa8FMfVM6CI=;
	b=d75MxqbsVKyE5u4PmKP6ltCz8RrcWRS95p9OUY3JKNZda+6rO+ec3gpvbFManFVug3Nk
	 9yZ18l+bvZ3qYvdMlwbsnrlyBTdXUkGZSlV1UHS1AJQLR1eFVIeZ1uqkrPYefHFXe70uz
	 6yTyWSht48DstDx84mfg9PP2FGIpGImpu9RLzf+61s0FAVuuiMpK7sxGFEjGr17Ufxlr0
	 rUh89bD4TzPJaGn0+sGOPZzPdFia23yhLGz9UB6KSKxEV09tyAAWcL8SLvWSbtQgGHG7J
	 FftK6+YtZSXnKjxMu6qC1eEnwUjR25JL2xIu+ZqG8u74TZBJCsA7D75vlWFvxelsOsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219599;
	bh=eoUnqz9k+raSdywN9BM3dW3K+lsDk0raZa8FMfVM6CI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lcpo60vqJT4nR8PjX1Zf7i2jOmoteY3iN6LJEQwmoNrSO0pgd9MPAVdf+XaT0IZnM
	 Y8PP9tSQJCRqh4D9/D/GWsezJLPpgo0uZcumdhs2UDCg7O9OP1t6WqshTYtTezaJ4N
	 gePQdBVSLBII8Gy9uT7xyH3g18IXu75WNB+PSuh6GkZQ5XuWxoQfqgmSRm4fhSj76M
	 P82GKxISDmvJaeI5GcaJmCzWQMS6aJMA5IYr/VIWTdu+KsLOnbtVNDMkL2pZCtCVYO
	 yPxaa5SOj6NKZTqkP/fffg9ICOQCxqCFEin0pehM7mleyUlMitasZR2zA0e7AYXoE9
	 5iy3zKRfidAfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C26F40624;
	Sat, 12 Sep 2026 13:26:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C6F523F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4200B80D49
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNbuYOcE057Y for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 47E7A80D15
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789217111;
 b=d885FO4mrcOJ6WWziTmxRPj0tORcqrC5uGGt9UZsvDiY7oqSKjIzOvx4UTa7cGV3j0WV
 KmEL2+8n7fVvIgOFBpAi3uENCjpqQlafJI8x6hIRGwhUlnjiBPkV4isE8lsAljLd8bYHx
 GKEgujstk71vpQ1fnHXYv8UaXmzqa4gCQ+8gLCXJLahQ0m+iNJRoSfDYgFhDLsIdN2xOR
 6FJUYuc8te+ZRI7uNyr9TsBVQgmVzmIhTZe56pr1Jx/0Uvg6Uuqt5xs6ENqUTEJD3pCqM
 z2Oj9RkVXpPzeIU6kclKJ0eN0IWQSDxiqLB6kH3kShyqCZFZznnA6FmjcYcIKN8QX4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789217111;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=eoUnqz9k+raSdywN9BM3dW3K+lsDk0raZa8FMfVM6CI=;
 b=NXs9MDDR9qIAtUNlxoAPXRBx6t9P67r38v/oTk9PswUGvlg9/vBpaGuPE2W52D4/22l1
 y/7pk06TcCEC6YAjz09udXEsalXbkJgt0ABfysIC0+if/XzNROqG/n/V1tSewJrfhUjqq
 4TeAV0MADCQkp+loD74bUerF+dDT7d9zWKy1W/rYT2fg4Gfuy8PMIEwQQp/6dsCe24cL2
 r9UTCNa/toivLaY+286DUY6yNORQAPXQcD4uOduEeIIdx2HzDkMnyiEYmvULYbsQqvs/H
 3w2hnldva+Xfew+eHZemkwTip8lVPBSl+TKGzRjrbe0Fvnrr2gjhEr2XXIFPwNoU+iQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=jgCufTgq; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=jgCufTgq
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47E7A80D15
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:10 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E58E3F47C
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789217108;
 bh=eoUnqz9k+raSdywN9BM3dW3K+lsDk0raZa8FMfVM6CI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jgCufTgqtAlQUs7VIvtkVeYExRGOGhQs/fMnKs4c8v8rulwnpu/hq/VpZwYVKgk/Q
 1yd9B9pOMegcZyxACSWnp3yH2mMCciCKON0szz3VmkqLzCU2tt9hiPFYcqc/PWLIZj
 I0Qsb7f6H9KdQfCAp/8R+QbuMbUvJR72Yr23HIo1h/+CppQwdAlnjZOl/UBIIK/R1f
 9OwoCpSpi9zKf3zS4zBTcBJilrieU0KM0CwkefS4HDWygAvUBAmMnwQgW47ykfhV2M
 HyRPbvNlXvn8DPwfQN9NAba5f2sSMRb0ErRIPaHlqZkNsFKBLfEIlkgoLO59GCx2bs
 DGYJ2xZs90HQvBrc1OSPfpFkemjewPmNMpljOi6bnCNvLs/2TZAE1FdkXYVaO6jUXo
 v+FAfe7hm3wEPMBhjmmRlQ9dTZ5uXc406S6uQCzrQrZCWfI0v9aHoqlPtqeaLOMwJA
 l65QxCSKr3dSortKTiHpZWifTrrJwgJMAzqdf2F+w0SQVOKEk1Xn00qA00uNzTPxrF
 x+90vKcArQwUHiRTcwnHf3ODCqhOcc3Mhf28IaTaD2PSf1qWonBGkkqb+Wq1pER6v8
 9YglJFSW0Ubld1SvGXTfAFxb7nA/W4LNGViDTG77LVZsl25A47WKzgV8emw+RKtfTG
 kJepwAA3lMsd/LgpMpyByhz4=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8623e5d4279so3494887b3a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217106; x=1789821906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eoUnqz9k+raSdywN9BM3dW3K+lsDk0raZa8FMfVM6CI=;
 b=n+uLsrEWCPtIAOtueeZ3btLCyPcnYDN+BEF+qfF0F4wVSWgdL6m9Hho8SoDiNVxzEx
 CE0ELdgZscLy27rsEy/x6zNG+XdtRdASjrl+2L4J2r5yh6kTVv0mc8m7JgFvixY1MiGy
 i2xpnN7NWchz7qapbeh+CP4tWXmJ8+mcdK25PLDyrsGA9z/UtT0o1HHDwdtjxAltQq0e
 qvrFr86jFKP4f+UEr1ZamnpxaNkiJvK4AIj1nQObqtFVWgkyfOqdgOik1GK68XIS/83h
 nzv9UUDd0L+gF6n9tDv32Igt1JUnLu4MLche8/R5h520tof6rECslj1tdNlolI130VSK
 uDgQ==
X-Gm-Message-State: AFuF++mOpN++lacOfdfScdISEi14uXzdIaOigxWAf2aV7k4jzgzX+Xdb
 RDcHiidShQiM+DKtZbTcBnlFx8DEvKBzmvudS03qBrlfSWTmh1gj6K3+XoeI5MWpB8blkBnvW9Q
 l7tVWNMed4gGO0v6SeDOfh7zQhION/VMd/Tjn9cdKKHDdFDr0xAIOTd8s0sbMkDNIgdii33gL/D
 9wCXLyy+YEHnyq+vZHRg==
X-Gm-Gg: AYBFou0/KSIE3vUPQSb/eXWF3BjB7AqR8JaT33Q+Sm/B6xz2aB2Ee1bE/7KRPizvvw2
 RYxyIa5l8+n4UEui8VTuMVUEudW6SbkSPkF1iQY4m6dRsq86Swni3G3T/Ys/+Y8ajYCcFN48+dg
 0TDHlSrRFy7k2oM8j/qNrsU2wk/7Hb3UGI2sCcffc7fq9S2EeBBZwLAlV3LfY5i4oR0YaS+MAlA
 DChvv2rQoW79CjNZll/mQ69hyKSQpMggnHn5VNpHvJYoWj7qB4UZDciy85PJobPgg7BEJB3bE/x
 52i78b3DiWsjx5Fe+SykWw/QZDDK0rAIuqbC5fCYsDESvUTgCDww2DCT0kzERVEzbYt9dFkxaLM
 ekHaZBmQKux8tvqGysSbqv7cnYCfu76rFjvIjPGPwgG4asJf7fkEl7sU19UskB1bZPA==
X-Received: by 2002:a05:6a00:2ea3:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-86cc98620d6mr4176314b3a.6.1789217106573; 
 Sat, 12 Sep 2026 05:45:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea3:b0:845:e9e8:645c with SMTP id
 d2e1a72fcca58-86cc98620d6mr4176261b3a.6.1789217106162; 
 Sat, 12 Sep 2026 05:45:06 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm2272101b3a.32.2026.09.12.05.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:45:05 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/5] tools: mkimage: support shared image data through the
 image-data property
Date: Sat, 12 Sep 2026 12:44:46 +0000
Message-ID: <20260912124454.13578-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:26:38 +0000
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
target, external data properties mixed with image-data, and cipher
settings that would produce different ciphertexts. Consumers need no
changes, since bootloaders ignore the property and the data properties
remain authoritative.

Patch 1 makes fit_image_setup_cipher() use an explicit iv from the
cipher node when no iv-name-hint is given, checking its length, and
fall back to a random IV only when neither is present. This matches
the specification, makes encryption reproducible, and lets encrypted
data be shared without relying on an IV file in the key directory.

Patch 2 adds the resolution and validation described above, covering
inline FITs completely.

Patch 3 makes external data mode (-E and -p) store the shared payload
only once: sharers skip the extraction and are pointed at the
referenced image's region through identical data-offset or
data-position and data-size values.

Patch 4 teaches the configuration load overlap check to size data-less
sharers from their target. The check runs before the references are
resolved, so such images previously escaped it and their load regions
went unvalidated.

Patch 5 adds the sandbox tests: inline and external sharing, mkimage -F
re-processing including conversion between the two forms, the rejection
cases, encrypted sharing through a shared iv-name-hint and through a
shared explicit iv, and the overlap rejection.

Each patch builds and works on its own. On sandbox the new tests pass
together with the FIT, vboot and mkimage pytest selection (77 passed)
and the complete binman suite (606 tests). The feature is also verified
on hardware: an i.MX6ULL EVK boots an Ubuntu Core style multi-board FIT
whose i.MX6ULL variants share the kernel, ramdisk and FDT payloads
through image-data, keeping the image at roughly 40 MB instead of the
78 MB it would take with the payloads duplicated.

[1] https://github.com/open-source-firmware/flat-image-tree
[2] https://github.com/open-source-firmware/flat-image-tree/pull/58

Aristo Chen (5):
  tools: mkimage: use an explicit iv from the cipher node when
    encrypting
  tools: mkimage: resolve image-data references between FIT images
  tools: mkimage: share the external-data region between image-data
    images
  tools: mkimage: include image-data sharers in the load overlap check
  test: py: add tests for the FIT image-data property

 include/image.h                      |   1 +
 test/py/tests/test_fit_image_data.py | 373 +++++++++++++++++++++++++++
 tools/fit_image.c                    | 370 +++++++++++++++++++++++++-
 tools/image-host.c                   |  18 +-
 4 files changed, 757 insertions(+), 5 deletions(-)
 create mode 100644 test/py/tests/test_fit_image_data.py

-- 
2.43.0

