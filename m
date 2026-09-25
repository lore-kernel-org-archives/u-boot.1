Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832C9C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 07:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFE6760BA7;
	Fri, 25 Sep 2026 07:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFzbQoo5OxUM; Fri, 25 Sep 2026 07:25:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE5C660B3F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790321100;
	b=nuZ7xxGTgUefQv7Ekv4fzGRoDyG/VGh0JZF05rT5f+0gy4VChpkzbaUYRzPDxxYrQA8g
	 YEOiFSI1HB8r3HbWW0wIh8RvxMKG4ZXVihBdxvx1ONg2rtrcZGERmH/XMSGM+LV8wjdjC
	 WhC4lTiAZsPpqEv6gW3RL231oo0ZUZzQIxzRas0dJbiPuN3cmxvnfCL6twY1+NsbrF4qn
	 Yec+KdW0yBw4B7haoqi6/atGTZHUMjCJpXzyqDUatL5rXaRGg+lBEHog9B7CSdwla4zDW
	 RtUDdCQpLygTAM58eZAYCSt52LAIbo3asp+1iSQnrd30d+jY/hrn9UQh0ehTWtpXEjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790321100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bsPfTcnPGlRdbnoXnsiNyETcWVjwMpWZKEizFG1jqns=;
	b=OOSxNzs7TZ6DzhVW+ac0kcesaoe8BBS1VwmO8VzTOZeby/c0SxhRow9cwJkO7zzioz0C
	 UUlAEaDTFQkB0XK+pb2sMBqqAlY/UAjJIc+O/ryn2hA42CFnpH/QmvzYGHG9sq1PPaJRk
	 4+dkgsH8dJnhCJqM0egPwjYo10aLUyEPPypb5AjE5etgkBXMccww1B+ewiLVALWgEbYwR
	 oyBYqD/AlzV4X9m2QfRop7ygToQ6xu74ezlK56UyKv2YkkzW78etRztJ/2K+IB1WZHhsP
	 UdeqsCPPg3KuUUhtH9ShYuxD2ll2AlEdp393ROVETbh3QcCqL9WsIiNr6Axw3vrVhVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DYn0vVp1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790321099;
	bh=bsPfTcnPGlRdbnoXnsiNyETcWVjwMpWZKEizFG1jqns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PnrsGDRNZc1+kNzDKHBsveUt18ndZBjeKY6Ka2kMjMXbWRgxmrWAHBZjef56W8+LE
	 sdKCMkiizjSqg+YDsUHTnTWgDAopOfn39SRojW4CDVMey5XIkeHNcEhSKUk/li/LhV
	 u9b3JqqbDKuscmt41+fVdOiU+Dl/NpbHM+k5dR6nvXDYYGXt+pAw9db0hVYz3MxYdV
	 Us18Fd0K3xTF5vZY8lkhWwAE5cTMDCvagyeWITI//ILYcfrjgCOial9O5Kfe+0Ng8N
	 rAhV4E3GDC3R4gWzOutHPzGk8YwU/FQ87LDyAIEDyi+sRm4A0zo9rbnMgy3e2bGC0a
	 GW96o/OJvYyXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE5C660B3F;
	Fri, 25 Sep 2026 07:24:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BF8F355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E20760B3F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPHk3-jx_Hro for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 07:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9AF4360805
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790321097;
 b=pqWQrTeAXio3SCaPzBmCIjbHeIYCgUXgO66e4PWpwWQpahdYwN/EH7iA54+hqTG9WMzD
 /oWfUyRYU91k0XGR4E7J77gQ1xk3Qvfum7OVK/Ey8X333VsqE+bct1GMPCaDC1trCtrDp
 T0LUEewZTQSMcQvDWQ+NdsTi3i+WXap6A8Ma/3CK7AvBGBzo3mKuedAWNJsjesxq/LJNo
 2Js8Q1xXtqXTzljBbEsZMqCMS2gPo3g6h/KcJyglyImsfaDtXfsD1ZOqKeLtT/YmateBX
 MFrWDjb5CxBveeoVqJChYQoJf/225Zng9+Fozptg8CPjS6Vkule2NM1X+SxfUPUOpPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790321097;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=bsPfTcnPGlRdbnoXnsiNyETcWVjwMpWZKEizFG1jqns=;
 b=RWnErQ17XwltTMnl+gq1LC2m5cFLhgsLmiMwD3s445Ageh8ZjHyPTRtCiTESOV2ppgFh
 glCPkaH6EFpEYLmux6i5Hu1yEj32d33hW6/UlNj3I7AXDNBSBXAbwzUULxHiXbvLW0iMM
 yQrDwyqiwS9XvEVMua9qBguxM5XDReUyPEhtzcWOZdYJJY19X57sfL83wwJJaoNoPt/t2
 6perb21ZP3QA6sEDDNFWSnvdPpHVdgyn4PWZ0SXV8hnKhm6ykHRjOhBIAlbyDISba3Bw9
 NV3AY5Dgi6HR0dyLUaLgnzuGPwJGuWy65XjKDy5HGeCFyC+RUHc5Va2yEfqLw0V5K2w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DYn0vVp1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=0xiviel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DYn0vVp1
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AF4360805
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:24:57 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so508057a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790321097; x=1790925897;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bsPfTcnPGlRdbnoXnsiNyETcWVjwMpWZKEizFG1jqns=;
 b=DYn0vVp19ha6VxXw4f2uilsWXRXXoufEiU+5VB5DrnecdA4Vt/82/plfrrcyl8khgW
 R+2wIwSGv1Ho8/k5WfEHGhr4hY0GFQmAcJStpGa1diqzn4UykxcZQwUFwjjldN7SDTIl
 viP5PVOvutaft+GnMdX2uEyutbSVVwUmQr+d98O/Ykp481qcGIvpcKCX1ATj5nL9cJ4m
 Gk7fmWP3uDQJx3+8pVaUN4o/qCbX8YPc2dwKDhzmUPMy98piNE1vLjpMTnyffFSrwwGB
 GXadv6mIMNe1M5IPAZ6lxI7TPRx9BphoQIIetZEQIt2l2Fq0hwFtNIUtwpeZRf8LJd31
 APcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321097; x=1790925897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bsPfTcnPGlRdbnoXnsiNyETcWVjwMpWZKEizFG1jqns=;
 b=WA7aWrSS9Z5iIDtcbG7RHhgUVZ87RWbekSqxGOQaR05TKpAFNtScvxIT2kveJFUluj
 ZeE8Mi29jg+wY3YKzyNpJJtEwC6nVAsiG04b22B0/v3jG+F+wgobNywGeeRBUOhWvy8B
 5F5BpJZzaFzDV9ec2mz8xX9w9Oxv+6+MiEUy+f1RahMk06hsfgH2UMrncGOlo09plHrI
 /ntpiRIjmKhFw2Cj8bYFxyv2Mr/NDf7B+wGy6DV4K674pRwOgYay78GxSWa7xV4L2c/b
 eGqDnWIOnWv3sbKS74zfkDXReosaV4X7J9N1j0UU1l3Iz/cla5AOWIYK/xRjqGmHs0n/
 2YNQ==
X-Gm-Message-State: AFuF++lumPvy5iWno6/DgpBfAx3IcM8up1c4IcgvtYQ2g7zQ1VEBgxec
 LkKg2nZZYjfK5dT5U3EbMUlHqqqvo/N58vHZwy0Ep29i/dTgr7qrLM/zzqrq5+r9
X-Gm-Gg: AYBFou0BkMh2KxkP8Mik1YQZAqdAvL5hRHBAGw6ya+O8o1886Hz9vTxx13MjKrB+FFA
 VTu927cwTKkgymjxf7p/TEehg8gSgnPdHHYewDF5ZTq6/n+Fi41f/eIbenIBHMQM1G9DWfD7hk4
 Bpaw9RNnVC7tqYFmi4r/zpsa+j5jfGj3viW82aNxbtew78ojdDj4VzigZSuu+JgpvyQaXR4imso
 xyob/gTJAluED0XqoyTD9Gms1cUcXMhurQgt9rGgwyp49PQF2jZ2EEj2cgWB37cnj0cFeTV7PAZ
 ivpQUMZVF09ozroJbEPeuzm8rHOnB6wGR7X/Q5BdR24WpOjW5PqTy9hM+HmJdv7DxoTffXC8+bJ
 FOuuTgJ1xa7lvJeE8qqsyLqidF5bWVaof3kKvPS3bavMsvWx1IJVQ/DHWqZLOouJubIQmxt33OC
 J5xIhFhG/CqI2GzBVSjOhG3zPJzcb82QY7VoOFT1XI6JzAdDghTXeeSX7VqGN8jTLb1rtozaL8P
 ZgZWYLbLTS+L/BOz1ekfAme1Fs8nBz/48wvPbAXQXm8KhIUtN8N3uzCS//vQZiSvSM2PEZuKG9e
 M1De/LmcHFAy1wHnEkBKC5kXGJgdd+Dv5rKA7l9cN5JIvl4=
X-Received: by 2002:a17:90b:3891:b0:39d:ee20:1e3b with SMTP id
 98e67ed59e1d1-3a098b4b199mr4659737a91.23.1790321096556; 
 Fri, 25 Sep 2026 00:24:56 -0700 (PDT)
Received: from 0xiviel.ip (122-63-128-121.mobile.spark.co.nz. [122.63.128.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm8904742a91.13.2026.09.25.00.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 00:24:56 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Eva Crystal <0xiviel@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] image-fit-sig: fail when the control FDT has no
 /signature node
Date: Fri, 25 Sep 2026 19:27:40 +1200
Message-ID: <20260925072741.1966573-2-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925072741.1966573-1-0xiviel@gmail.com>
References: <20260925072741.1966573-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

fit_image_verify_required_sigs() looks up the "/signature" node of the
U-Boot control devicetree to work out which keys are marked required.
When that node is absent it sets *no_sigsp and returns 0, so every
caller treats the image as not requiring signatures. Nothing downstream
can fail it after that: a FIT whose signatures are absent, malformed or
invalid verifies successfully, and the only indication is a debug()
call, which is compiled out of a normal build.

Against a control devicetree holding no "/signature" node at all, and a
FIT whose configuration signature carries no "value", an unpatched
build reports both images as verified:

  ## Checking hash(es) for FIT Image at 10400100 ...
     Hash(es) for Image 0 (kernel): sha256+ OK
     Hash(es) for Image 1 (fdt-1): sha256+ OK

That '+' is fit_image_verify_with_data() reporting the signature as
verified, on a board holding no keys whatsoever.

Add FIT_REQUIRE_IMAGE_SIGS, which turns a missing "/signature" node
into a verification failure on this gate, and report the missing node
with log_warning() so that the condition is no longer silent. With
CONFIG_FIT_REQUIRE_IMAGE_SIGS=y the same image is refused:

  ## Checking hash(es) for FIT Image at 10400100 ...
     Hash(es) for Image 0 (kernel): fit_image_verify_required_sigs() No signature node in control FDT: FDT_ERR_NOTFOUND
   error!
  Unable to verify required signature for '' hash node in 'kernel' image node
  Bad hash in FIT image!

The adjacent configuration gate in fit_config_verify_required_keys() reports
the same missing node with debug(), after Jonas Karlman objected that a
verbose error is wrong on a Rockchip board which enables FIT_SIGNATURE for
image hashes alone and has no /signature node by design. This gate keeps
log_warning() for a reason specific to the image side. Under bootm the
refusal surfaces as Bad Data Hash, indistinguishable from a corrupt image,
and nothing in this function can tell an intentional hash-only configuration
from a control FDT that lost its /signature node, so a silent return
withholds the signal from exactly the case this patch exists for. The
message fires once per boot rather than once per image, the level is
LOGL_WARNING rather than an error, and CONFIG_LOGLEVEL suppresses it for
boards which do not want it. On evb-rk3568_defconfig the shipped
CONFIG_SPL_LOGLEVEL is 4, so on that board at its default configuration
this message appears once in SPL.

That same case is why enforcement is a separate option which defaults
to n. Setups which enable FIT_SIGNATURE only for image integrity, and
which legitimately carry no keys, must keep booting exactly as before,
so failing the gate is opt-in.

Measured on sandbox with test/py, running the vboot tests:

  option at its default (not set):  32 passed,  0 failed
  CONFIG_FIT_REQUIRE_IMAGE_SIGS=y:  19 passed, 13 failed

The 32 are the 31 pre-existing vboot tests, which all pass on an
unpatched build of the same tree, plus the one added by 2/2; the
default configuration is unchanged. The 13 are by design, not a defect:
test_vboot.py boots an unsigned-images FIT against a key-less
devicetree and asserts that it boots, which is precisely the contract
this option withdraws.

boot/image-fit-sig.c is also built into mkimage and fit_check_sign,
where <log.h> is not included. tools/mkimage.h already shims log_debug()
onto debug(); log_warning() is shimmed there the same way, so host tool
output is unchanged.

Not tested:

- SPL: compile coverage only, on evb-rk3568_defconfig with
  CONFIG_SPL_FIT_SIGNATURE=y and CONFIG_SPL_FIT_REQUIRE_IMAGE_SIGS=y.
  spl/boot/image-fit-sig.o compiles and spl/u-boot-spl links with no
  warnings, and the gate's message string is present in the SPL binary
  and absent without the patch. No SPL image was booted, so there is no
  SPL runtime coverage.
- Sandbox only, on x86-64. No signed-boot hardware.
- Jonas's Rockchip setup was not reproduced.

No Fixes: tag. The early return is original behaviour rather than a
regression. The oldest commit touching it in this path is commit
b983cc2da0ba ("lib: rsa: decouple rsa from FIT image verification"),
which moves the code from common/image-sig.c to common/image-fit-sig.c
rather than introducing it.

Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 boot/Kconfig         | 34 ++++++++++++++++++++++++++++++++++
 boot/image-fit-sig.c | 15 +++++++++++++--
 tools/mkimage.h      |  1 +
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 0b3399a66d..ff4d609b3f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -154,6 +154,32 @@ config FIT_REQUIRE_CONFIG_SIGS
 	  need to reuse the same u-boot binary in setups without
 	  keys or rely on image node only signatures.
 
+config FIT_REQUIRE_IMAGE_SIGS
+	bool "Fail image verification when the control FDT has no /signature node"
+	depends on FIT_SIGNATURE
+	help
+	  fit_image_verify_required_sigs() looks up the "/signature" node of
+	  the U-Boot control devicetree to work out which keys are marked
+	  required. When that node is absent it returns success, so no image
+	  signature can ever be required: a FIT image whose signatures are
+	  absent, malformed or invalid verifies successfully.
+
+	  Enable this option to treat a missing "/signature" node as an image
+	  verification failure instead.
+
+	  The missing node is reported once per boot with log_warning(),
+	  whether or not this option is enabled, so the condition is visible
+	  at the default loglevel and can be suppressed through
+	  CONFIG_LOGLEVEL.
+
+	  This option covers image signatures only. Signatures on the FIT
+	  configuration nodes are checked by a separate gate which this
+	  option does not affect.
+
+	  Say N if the same U-Boot binary must also run in setups which carry
+	  no keys, or which enable FIT_SIGNATURE only for image hash
+	  integrity checking rather than for signature enforcement.
+
 config FIT_SIGNATURE_MAX_SIZE
 	hex "Max size of signed FIT structures"
 	depends on FIT_SIGNATURE
@@ -281,6 +307,14 @@ config SPL_FIT_REQUIRE_CONFIG_SIGS
 	depends on SPL_FIT_SIGNATURE
 	select FIT_REQUIRE_CONFIG_SIGS
 
+config SPL_FIT_REQUIRE_IMAGE_SIGS
+	bool "Fail image verification when the SPL control FDT has no /signature node"
+	depends on SPL_FIT_SIGNATURE
+	select FIT_REQUIRE_IMAGE_SIGS
+	help
+	  Enable the FIT_REQUIRE_IMAGE_SIGS behaviour in SPL. See the help text
+	  of FIT_REQUIRE_IMAGE_SIGS for details.
+
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on SPL
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 5a2c6316b1..3826005072 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -188,6 +188,7 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 				   const char *data, size_t size,
 				   const void *key_blob, int *no_sigsp)
 {
+	static bool reported;
 	int verify_count = 0;
 	int noffset;
 	int key_node;
@@ -201,8 +202,18 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 	*no_sigsp = 1;
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
-		debug("%s: No signature node found: %s\n", __func__,
-		      fdt_strerror(key_node));
+		/*
+		 * The control FDT is a property of the board rather than of
+		 * the image, so report this once per boot instead of once
+		 * per image.
+		 */
+		if (!reported) {
+			reported = true;
+			log_warning("No signature node in control FDT: %s\n",
+				    fdt_strerror(key_node));
+		}
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_IMAGE_SIGS))
+			return -EPERM;
 		return 0;
 	}
 
diff --git a/tools/mkimage.h b/tools/mkimage.h
index d8d292a809..d65099fe2b 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -32,6 +32,7 @@
 
 #define log_debug(fmt, args...)	debug(fmt, ##args)
 #define log_info(fmt, args...)	printf(fmt, ##args)
+#define log_warning(fmt, args...)	debug(fmt, ##args)
 /*
  * Use stdout rather than stderr so error messages stay
  * interleaved with normal output in the order produced.
-- 
2.53.0

