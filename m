Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A360A2623
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K2t96HOK;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=p8X/CmP0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0J1JY/Je
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 067AF60616;
	Fri, 20 Nov 2026 19:01:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrChOOutRYOq; Fri, 20 Nov 2026 19:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FF9B60618
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795201284;
	b=AIAaXevADwY3Eq6MCzmE5pvy9dEas6SU5bGOwVJVSiem3QeqIztX+Wj78ztxPJrDHugR
	 BuRKa0Z5H6TG9NOWGrU0AIvO3YjdI/Aw2n0iVrf1sJcw7RnCf//935685acTuhU7oSLhP
	 SbKhT36wIs1f1qwF7e31uT9GfSEfWEpOUliGiRPPVOG37/OxM2irH8Uf8O0+J08JQMUJQ
	 u3zIXrJdJJeAT5tjat1Ya0E4kVjPqNHgV4VxzdLHOH64mrTmKzsgYZUu/EcN1ofFUOOzb
	 7JlvHiGBAAz2RbTK144GuLzRqpk6bh4W6THJh2QA3LF7JbhmICKlZfhxhBvFoUubalg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795201284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:DKIM2-Signature:
	 X-DKIM2-Info:Message-Instance:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iiJipBn850reirK6+kncrgNMfk2pdS/rDQbCsvsHvmc=;
	b=BsuEfTBab2jQn6taIirF0W9OlckLpsRR0Y9yTX2FqHk7lPpg/RtPJ+I5PnUV8sZ0l0GI
	 XB7iSl99i0RWJnh9EY+ZGVqRGS2SBAFCtuQrjqSubPQc3AirjExWantMj5YQ9DOzXiry4
	 +B9CEoTzezlZ6jIJ8Opukz/MEcvcqpKIkx8qBib22e5PyHgQeScqIYLH3jyVnLIRsZZbz
	 ibsszheotLHU3itlf4ftC4EzXoizZHz0Ldf483B17aeRadn0mlaT6kxA4UTMVdymCh2+g
	 m8id34JtYARspQ0gHZ+UQ9iGHzP1bDiiu1sPO3TJ6bg8wnp7GRq78cAP+mlEYuEyTuw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795201284;
	bh=iiJipBn850reirK6+kncrgNMfk2pdS/rDQbCsvsHvmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K2t96HOKbyUemGhqnv1dG/E8ahmxKUEHWKZydMIwfzOMSw41fRNpV/8pYyMujO4cl
	 Zv1G317R2NOGR1NOAfqbzVykZ9Ck1HoDuT6UahXfwXuG3bH6bKrhvmGiMhHJzoqz9S
	 DtuTpeOVT+Z3U7rW4rMl58OuOtcHs9NIGuEzQNNHqK4oCjgusLr/C5HEEA+iwNvtU+
	 EqC+voI3TAnIlgYd55DrS1KKVVnCjyCbJoiCfhcWmXIMRuqX05joaOC6/j3H0dkCky
	 d8znz9wcfGhoD00QuKG3yJqOtaf0XByNlIsMrKqQDnOxX57DTMSdaqykcb1up38uyx
	 1wCbmuzQdkVXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FF9B60618;
	Fri, 20 Nov 2026 19:01:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 819209CF
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F21940E8B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DswrUy1tHGUi for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 19:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 333C840E89
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.151;
 helo=fout-b8-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=p8X/CmP0; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=0J1JY/Je
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 333C840E89
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:19 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 9E0EC1D0047E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:53:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 13:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1795200798;
 x=1795287198; bh=iiJipBn850reirK6+kncrgNMfk2pdS/rDQbCsvsHvmc=; b=
 p8X/CmP0t7n6MHmeSrNySasRr6L/iJNgIZwII3JMo7dIHBz9eu0C5jYzco4y2JFB
 CbVubs69rd0Up6APQ3my/fj8E95tBN2GjleTn47ufUFztfPmwY4o8jyvKa5FjA7L
 zH2uCYfIadDZVdubeJBCYI0yShf84gH6jtVRgc1gRB78AGUmZpaR12sxinQh8zBb
 FRN9RqOtzuUtOzfX4lzLn2cWsxAY4TTqyOr5AalmPE2/po0cJ0n7Nik7oxoAYbxp
 dwbbbAEdOFV7+AmMX06wNLxgcAGaL0OOedGWP3/W2fw9sr9eZKUY0MYQt9giGDpP
 nXJiVHbhDH1/euiU+pPoBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795200798; x=
 1795287198; bh=iiJipBn850reirK6+kncrgNMfk2pdS/rDQbCsvsHvmc=; b=0
 J1JY/JeJrma6I0XA+wjQWjorqIRb7VdMt9UH8nX3KovmULSwWhSO24RdVV3Hpi1E
 QQwbISLHVoNsYNQZiHH1ppD3GE6QbLFl4Vma8osVmHfFvQB6NWbCdjG0xnznflqo
 ciGjeg54HYzvPIurPU8yhSNnMvHfJEbSU5YgsComL1o4h8jfqPAM8m7Q1gb0hG/F
 jZL0I0kAMJTxEuq8rcxLhnd7pJN8tUzzk8Y34azNXnGs6AcAmMnT2p0+ciQOmq8c
 D1JaXydbfahYBupTJ8Nkl/5tdVUw0+WiH3dCIAy6UiCwvlQlLV/rvewT03R+M92e
 ataSxTczj5W/ZVv6ydYzA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795200798; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm2:rsa-sha256:5KnZfHJu2ZtObtxmphMYqOiIbrrU+mpCLKuPEqHWR9yCurB
 lIYyf5NbSbciWjk5Hf2SoIaYtpNBWcGLqD+Wrz6brjk6cYNVAsgN9YGfhAiklEFi
 fLyMEbFwW8aqB1r7CigQV/weQX0YnUm94mtbQ7H+jsawBQhFgThJZnwt52yGPtqM
 kEtTAY6zGcB5h6oH5zV4T75m6NgX8vogWBbfiZW4LqSIVnoYOBb+c0xQ2WEm9MB3
 sGxlW3P7bNAip+J/BQnfdlw/VW0KKZhgrDXrZfarxGBYsV12twK5wCVGNhJ759fZ
 cEZdgtLuvdbMfVzW0l+Nc0VTx0vDvzMtbJLi7Lg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Utu1eENU9ExXd3GViukhIgmpayfwzXHGWkx40Hfft1A=:2m6kMX31ZvVoOQthNIdR686NyQo80Zfgai2Y+9K7r7A=;
X-ME-Sender: <xms:HpcAa3hYCE63nGsYqYupueRCBMV1YUFIFbLkms0Vu4OsKqirunNnFQ>
 <xme:HpcAa-CYksz6P7jRtUshtBTVfB9iggvW2EyVkeJLTWRmGeZZ3Puuem7FKVzRk-u_k
 U-_ocYRYaiFkdUUEgrAy45tLZFAeMacP0JbpOkUh5u-04vCywNuIv5w>
X-ME-Received: <xmr:HpcAa9vlgibDjg0LY_VLMCb_jZTruG2yIy1jm9L0TD480e22YxueWW-2W3Flod_RCHv7aUtqBbXW7A2gxJvpY-TxvfkZ44-RZ_M9ww>
X-ME-Proxy-Cause: dmFkZTF40NY3j+ynN54GON3MNlAVzxJLtPAx2Hedsg+UjTHj4zhL7JTRhAJpFoXsLtvn+d
 lqP28eeB/BzEKpHqS1aE0+eMkKY3CaL4Kd1ab7pTKj71pDm6Q2932xedD8+/6RWYLt1Czy
 se4sW5hWg3zR4ZwAPtaB4BBpz3CUPGBBKncmjcZVDZeuALhJjD010wD8WQDSVMVovLzHpd
 eX6y5K5z3VcfqK/1d8wCfoxHFm7g39w/fJGF/1QrK6LIeZvtqkFpz4Xv5ssVbGumUJwN71
 AOtPCYYcwZGGBR8w+SJVJHQmuAE4PQ82dv2/TzBiysxC0z9kpgUlKX564Oj2+rPjlig4Cd
 FcVqqrLmAOEHKs18hAA2HHT6vyUSvzjr09dZAM5uppYHdhbYKEw5Jl4LuVqPV0sYVJCG8j
 WD4tzZcX+G8gvx5D8PZo5wodzbsBCRr6v0BC9IcGEt4xV+S/skJAkQcCjHzNN4XbklCW8W
 jv9Gr8+O6yhDfqOtkECeNHRHZtyIlFPR+KmezbPEefx6ElSE2m0ZuRfWHqV9Pu0UJDA0nI
 NTJ5G8GbknaIiT6QJayn0TyWbksjRq8iUEDBlTrTnrEh3wo/hLasbGDXjMSYXgHaUDb8sm
 r5UQ/VbE7n27ymoc6mdhJF9QeDNhSZWTK0R96+u3vpVBBcFtPc2xBykPf2Aw
X-ME-Proxy: <xmx:HpcAayee2rALDli1TLE3i6zc-cIN-Gg9J5oka3yoKHQ3XI1mfBUfBQ>
 <xmx:HpcAay-x49dIOZxssUTCsqFpjB-kVKD0djqetODe7nsJ5_4mHJ6UjA>
 <xmx:HpcAa1SLKslCKWpBRYKS1nK3182nt6b_KK3AJpjY_RLbFmc8BhbBDw>
 <xmx:HpcAa7qf2LBmCxT5skbRJL-_SiPhoDfvkTR1NWtCWNuT7bGyhSGVxw>
 <xmx:HpcAawj_yjAFTwcZLOEe5viVbol7GdryvoBboKUn3KLPocU_gM3PHVte>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 13:53:17 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Nov 2026 19:53:07 +0100
Subject: [PATCH v2 1/4] doc: apple: Add Apple M3 as supported SoC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-apple-t603x-support-v2-1-606b4f5fadc5@jannau.net>
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
In-Reply-To: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=2m6kMX31ZvVoOQthNIdR686NyQo80Zfgai2Y+9K7r7A=;
 b=kA0DAAoWoRs8240vZWYByyZiAGsAlxeh8R+y+Ja44Nq6UEWVTcAwtpsxvgkVhoa061x4IfALt
 oh1BAAWCgAdFiEEYivpiACrfCFcfeBWoRs8240vZWYFAmsAlxcACgkQoRs8240vZWY5+wEA+tQt
 2bWvAAISCks35wzzsU5o9UBWEbLp8kdNIKF4c8ABAK/wSzAtRkH9290qpyhYGWLXSkmjdUwFUUO
 /ZzHklqwC
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adding M3 (t8122) to the documentation was missed in commit a1a47eee6763
("arm: apple: Add Apple M3 (t8122) support").
Since Apple silicon SoCs have switched to upstream DTS stop listing SoCs
with device trees. The expectation is that u-boot support is added
together with Linux support. So the device trees might lag a little
behind. Since u-boot's dtbs are usually not used on Apple SoCs this is
not an issue.

Fixes: a1a47eee6763 ("arm: apple: Add Apple M3 (t8122) support")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 doc/board/apple/m1.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 900c5e6d91ea..66ed247eca26 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -9,6 +9,7 @@ the following SoCs work:
 
  - Apple M1 SoC (t8103)
  - Apple M2 SoC (t8112)
+ - Apple M3 SoC (t8122)
  - Apple M1 Pro SoC (t6000)
  - Apple M1 Max SoC (t6001)
  - Apple M1 Ultra SoC (t6002)
@@ -24,8 +25,8 @@ On these SoCs the following hardware is supported:
  - NVMe storage
  - USB 3.1 Type-C ports
 
-Device trees are provided in dts/upstream/src/arm64/apple/ and available
-for all M1 and M2 (t8103, t8112, t600x and t602x) devices.
+Device trees are provided in dts/upstream/src/arm64/apple/ and available once
+they are merged in the Linux kernel tree.
 
 Building U-Boot
 ---------------
@@ -82,5 +83,7 @@ supported SoCs.
      - Base Address
    * - M1 (t8103) and M2 (t8112)
      - 0x235200000
+   * - M3 (t8122)
+     - 0x2a1200000
    * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
      - 0x39b200000

-- 
2.56.1

