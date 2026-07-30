Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF98C5516E
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB60140CEB;
	Thu, 30 Jul 2026 18:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 24SSWFILUFLc; Thu, 30 Jul 2026 18:41:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 193D740CC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785436880;
	bh=g+zRyE26Z+69/vDA2X99rzi/kIEQpSH7z+DsES6jiRQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ETC0srpTO4Z9Ye9i77HeRqmHP4v6Tltp3bcxN7vc0iiZPVL7MtiBmR5bOr8w30i0S
	 Vjp+Cur5AhaN6qeR1JHByZIOZzyz9NXxxnzaxwjphzoO03TBWz3G182SeZlf/9bLrb
	 b9J1ROZ0FIRoQdZRZE1XY+W6+8okMFKj8UeE6IM49clL1W01HC4cACl4ZF/pC/uixW
	 Hs5XkLwY3RRPxLdC/6OdO+Gaugz3plHDtr61JYR9DIRrvXtBBA/FwagJ4RGtOMcaRM
	 zXtSiVMPVhQINNSO/Ob0eRf/1gmN7jkcA/HClDGW65Wn5ZrkNCh6Esl9kivL1d4xK4
	 5n8IWmkyWFcJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 193D740CC9;
	Thu, 30 Jul 2026 18:41:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87D97352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E13240CC9
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZZa8iJDzGFX for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:41:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 90BE740CC2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90BE740CC2
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90BE740CC2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:17 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so31245f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436875; x=1786041675;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g+zRyE26Z+69/vDA2X99rzi/kIEQpSH7z+DsES6jiRQ=;
 b=YDx+vMU83av5ETKMcE0Nr8NpG36ByqMbSTkiemAviOPEUoXKQXQ+6K2Ak8xmCmcWD+
 1+v4nKOdnMtKZaVr2hE7tufsOHLpAG96DYLHxeSsoKKoqGC6VJ3hNlE1N2iUyDYrar0e
 oXuCeqYbuI+/1oe+2TWHXNaZg7df4eg+0Q2QUMPEMNozsbK+tqgaDPB4EsDdGipskFll
 Ir5gfPm8NihEm0dvkGplWZpoKyLjv8T9wv58FHxFtStjsbD9ySAjJXPOeN5YnH5cy+jF
 Igfc4ZCB0vqa+7wJXcM6FNYop0mOvH13ywokydoI5j/lMyVxowkjNoRyNJo2hTKbe6P0
 AI2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+Dp1N31AUzZgW+GGGS783DfKlx8Z7S7JNbToS4ttAv6zlCvPBp2sCmMmekn0E6Nd85nu/f1U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwOYiFWuLqimCws5zLZRUN3vFs2R7+Ktq81b/IKyP2DBAXP8xpb
 6xMuvAvcN4iBjlJEW90Z+KrcNY6Ouei7L74HzTF7f/wCjN4dWdYxSc/ZsyzZCdJKxG9zVR/bfFX
 GCI3pCL87MA==
X-Gm-Gg: AR+sD10b/F/y/199p0iVYlvOJ43h79p9XghPxuNOF1k/G4FLD93H6P2LlM+iYGBUsXC
 SStHX+mRsutyJXNjWj+vpymd/b+cpqJybiebgm+CgZMc7Lmf1+ENpKzFm/boUm4Hm6GHSB2izHa
 OFTp0JDrjuwU68Hgr/6Z4ybAJdt/EZHqX3q+Uun0/+oqO48QwP/65zLGuymIZ1urtvgIdZeJzgF
 B8K7h7kmAD6qge04q78DWA4ihmdnPodYLu9TDJl3zmyxNB18v7IWKiHy07BXn2FRuyWsAzjT5Fu
 vHJsNwzMzZJzM5OM0Sb9eiAbCm2zbUPShMyi4FZcV5NWVYlWwtBQyGED0BD1+qOfV6n/9bWh345
 ZxvCAtN4GFMyfPuI4AvSKaNzEV+ZJFTthveVaQBXT+OMN2XtmUceg3/VpWCgYyBqdCLgrPcdSRu
 83N2Erszbt3ND0UqvH6ikr9QJb9mRodnOpxMK8nHht2EC3rQZE0lMft0JnXqTCQqaRsI7eX2hxF
 +OZpErcj1cptJavziqgwUGgIiqMz9PSoNP20Nw5ew==
X-Received: by 2002:a05:6000:4a10:b0:47f:9720:4740 with SMTP id
 ffacd0b85a97d-47fc822dc64mr4852924f8f.37.1785436875419; 
 Thu, 30 Jul 2026 11:41:15 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d8d37sm7919603f8f.8.2026.07.30.11.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:41:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/5] lib: resync lib/div64.c and <linux/math64.h> with
 Linux v7.1
Date: Thu, 30 Jul 2026 22:40:37 +0400
Message-Id: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrA3EjEbpVaQLG0cdwbRkUrGId
 zfV5Vv8v4NQYBJ4ZDsEWln47ROKPAM3dX4kxX0yGG2srlGrpYuTLVUg+XmnkCqNaFxhG4TUfAI
 NvF2/9nlbvq+ZXPxP4DhObVo2bnEAAAA=
X-Change-ID: 20260730-math64-resync-3e50332c1683
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3381; i=alchark@flipper.net;
 h=from:subject:message-id; bh=pK9HWRc3AeJVtyyPDv7K7iRizIgkDSP4FeLVMc7iqVw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlz9qzd6Gtw+d7CwPXeXK27nJ9cF/4gpEPY1kL1+qrQ
 rMm/LJy6JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqQ5sZ/uce3Z4nYMxRFp9Q5CNn3DHvXMUeWa+tk7dFNZfp7TnwMYWR4cDySU7
 WLTLJtY7GZ3eaPnewe8WQ4s17XfD1zPsHX+/z5QIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785436875; x=1786041675;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g+zRyE26Z+69/vDA2X99rzi/kIEQpSH7z+DsES6jiRQ=;
 b=Q5vCv1kQTb/Y3IVSTu8g6ssvjUP14slxo+1zRaW2f31AYD9sqPJ3X1PT+OOr1GlgXc
 oGnh/fqG78kSf1VAZ/sJNtod0nXCTSlGixzJTjehuQkHXMT2GtdVrjS6vWItrn2TAYTM
 +c5u23pL5curk68rMWCjeK5SlVgT21DYrV21peWyD8oz6Zr0mMqGotcTSUXauVMX17Xp
 PEhMqS2w12C6jYIn29pIEotQ6EUcwfKKHue7ZRG3XiypUFohb4lBz5/IMkKHcG5C31Ds
 p8s18IH5foNJD557TV/DSUlz9BsY6R3q/vOndd3sdy692Ovh/ak1Qz58NNn2t6/sg4+G
 Fhkw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Q5vCv1kQ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

U-Boot's <linux/math64.h> was last really synced with Linux in 2017 by
commit 0342e335ba88 ("lib: div64: sync with Linux"). Since then it has
only been patched locally twice, and both times in ways that increased
the divergence rather than tracking upstream.

The one that prompted this series is DIV64_U64_ROUND_UP(). Commit
3adc17f60bf8 ("lib: div64: Add support for round up of div64_u64") added
it inside the #if BITS_PER_LONG == 64 branch, whereas upstream defines
it unconditionally after that block, so any 32-bit user fails to build.

While auditing the header, two bugs turned up in lib/div64.c, so this
series starts with those. Both are 32-bit only:

- div64_u64() and div64_u64_rem() shifted by 1 + fls(high) instead of
  fls(high), losing a bit of the divisor. Linux fixed this in 2019, while
  U-Boot never picked it up.

- div64_s64() used abs() on s64 operands. U-Boot's abs() is not 64-bit
  safe: its own comment says to use abs64() instead. Both operands were
  silently truncated to 32 bits.

Transitive headers that affect what <linux/math64.h> offers were checked
too. <linux/math.h> and <vdso/math64.h> have no U-Boot equivalent and
are not needed; do_div() comes from U-Boot's <div64.h> in place of
<asm/div64.h>.

Deliberately left out of this resync:

- CONFIG_ARCH_SUPPORTS_INT128 is tested by <linux/math64.h> but isn't
  defined anywhere in U-Boot, so the __int128 fast paths for
  mul_u64_u32_shr() and mul_u64_u64_shr() are dead code on arm64,
  riscv64 and x86_64 where they could have been useful. Wiring it up in
  the arch Kconfigs looks like an easy win (but could result in subtle
  behavior changes or code size drift, so needs to be approached
  separately).

- abs() in <linux/kernel.h> diverges from Linux and is not 64-bit safe.
  Patch 2 and patch 5 work around it with abs64() at the two call
  sites that need it. Replacing it with Linux's __abs_choose_expr()
  version would be the root fix, but changes abs()'s return type from
  long to typeof(x) for every caller in the tree.

- abs_diff() lives in <linux/math64.h> here rather than upstream's
  <linux/math.h>; it could move to <linux/kernel.h> alongside abs().

- mul_u64_add_u64_div_u64() and the mul_u64_u64_div_u64() macros are
  not ported, as they need a u128 type and ~110 lines of
  lib/math/div64.c that nothing in U-Boot calls yet.

Build tested with both gcc and clang for evb-rk3288-rk808 (32-bit LE),
generic-rk3576 (64-bit LE), malta (32-bit big-endian, which is what
actually compiles the __BIG_ENDIAN union paths), plus sandbox and
tools-only. No size change on any phase.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (5):
      lib: div64: fix off-by-one shift in div64_u64() and div64_u64_rem()
      lib: div64: use abs64() for the 64-bit operands of div64_s64()
      lib: div64: inline __iter_div_u64_rem() into its only user
      lib: div64: sync with Linux v7.1
      lib: math64: sync <linux/math64.h> with Linux v7.1

 include/linux/math64.h | 201 +++++++++++++++++++++++++++++++++++++++++--------
 lib/div64.c            |  46 +++++++----
 2 files changed, 203 insertions(+), 44 deletions(-)
---
base-commit: 44f0dcf476140c1077ee3dbe16a80fdb6f8265c4
change-id: 20260730-math64-resync-3e50332c1683

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

