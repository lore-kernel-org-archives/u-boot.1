Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B7CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CB69810E2;
	Tue, 29 Sep 2026 22:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENcxT6MWTRWk; Tue, 29 Sep 2026 22:21:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD415810DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790720487;
	b=rl1CSq8tRF++BCE06PUxSUq/jHh9oR3X1SJMSpJij8D6VJIwxvRUkuLNTp3gIw09uV9O
	 Xi8QnbnRIx41aPVkcE/Tt3MM26cn9RxESpVNM+revB3rVpvNpSepozmuSn7SUE24GiaV1
	 YtYQsYKEVUvJai8I+HohjTpz8dpu/CHiif1M2EnWkYHNs4VO2mhLCbMZzMBKjwXP6yZkS
	 9N7CytxBiDZtslJIv23oIX541UOtb64FDp0+4DdKSBSxe+NUJrh89zhPIY6Gqdzx8iYYf
	 LJeWz7MRo7XjPv7J9bkYPYhwKP0IkdNsiXslHETJ+EqJwIVYmXkubAhshP0bormVJog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790720487;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=P1aswhgsxVn5juL5v7EOQ5Q/o1qpRp72XRqMkY0CKH4=;
	b=MDvIPCtDMY2w+SYltyul3fiyl7CE7Fpas0JBQ0gJWuEuF0B1BmJE5izXKGKY4/ouwR3a
	 uzcFHy+DZKG/o1knIwxsQ2UcGmaNxdns5Wbb7qeazgPyBpU/N3uCjuvvpgrJbWrzYhld9
	 Mh5kK+baaDhi+C9nfmVgH73q66n1Kc6dkwN1T6a5PyOfPFUD6lCC5DR1mvjUSSgnnLmyT
	 34lhBNY5BVtroLSehVjBb11uFQxlZUR4yrEDNmTMVr1s8LdtxtTG3yGHh2R+cfWhhA18R
	 LVD7x4Ru46wL6pDLpJamsPcRH2pqQgijc2W1Uc9kwtqnCJiLPVk3hCsLHVox2W0vk6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790720487;
	bh=P1aswhgsxVn5juL5v7EOQ5Q/o1qpRp72XRqMkY0CKH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rUeoTosffYl1yRo11tzjnvOt73M9QhY+MOC5BokKxsS6Cg3vYsxro87QG4IFAKDWh
	 sS3fs9Ct0Jl7vrp2D6w2l1C8lXndmsbElp58Mrph44bXijAGyQJD3rhKv22tHmHdrj
	 JTc/0ozblO94f6Zrhce6dIkTh0EhdSx+O0PaIpPLPRc/TgYNKIxs3JzWL3Kv/D/AUu
	 nQ2BcZquaDWPJeSWQ8c7ju9whdH41HsMIs3ZtBKcyZ6g861mKd3dXE12kxSEY3li2J
	 VNDaoJwJk09nIpg3e2wLghonUyTsWsuOwge81AgCLX6NZkKoQSY+sliCQZVQPz/ums
	 UCXVzmu99hhgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD415810DF;
	Tue, 29 Sep 2026 22:21:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7871C14C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A56E400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wos-aec9gtps for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:21:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BFA0140242
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:3a::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790720484;
 b=ADQgoPFt4mSsHiGJ7Ne7Zw2TUUKYYzxOT+Ad8JmbsoxmPLIiufsFgBn5MW9fnxu0SlWX
 mZNqUTP8LSbLVc2QtZ+v/UcQy+OzYzaEJstfJwrokLalNv7leU8zOs0QzdZ8GpGTxtqtl
 zpsy9pqIf8go6cEMFzziMytNgX+CsLEAy81plRA5h0m3qwDj/izsZcQ5Z/WQwJBIXR4/T
 BBQjGFqj9kFxEx7X7DhruLaR/UE1FS2nhK29TyviCMm+ph3vhXxh6vjUVcjHFp1B4XRyk
 WRO9R0XKD7ej6mk8DjtceFuR3kbv5EalFiS4MlCgKtv2Q6kyjB17PrCV3LBrdBBh8ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790720484;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=P1aswhgsxVn5juL5v7EOQ5Q/o1qpRp72XRqMkY0CKH4=;
 b=PWJQU7NI/XHrRF5Nfyse4vgSAq8Q4C4YU86FnGzphOtwD/3XC/RBqEW8aM8r7MHJFHe/
 1PJEdf5OJsylDwpO4nAuD3GdmR/2PUTOu9VCK1o5I+juKx/XI2+114Lg2DMooLkrSkD3D
 1AkP9XK/9wfH7UFxwCG70rS4RysNQDB2LzEI8+gwW3Y3DVTRqVa++Y+UGjHysM7MHeH2g
 2CBlK4xJErHW9HSR+qvNYfP1awRbNvTd2WQaJZFPUWzn3P2r+guiWm5q2ff2y1W63am/F
 ZlZSWYSDU6AQFxQ6PCJg0HisBxF+4CO1GOjUymT8Yb9mfJp4FAG2aE3q3T+uC1xLQMg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Xn43V2io; 
 arc=none smtp.remote-ip="2a00:1450:4864:3a::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:3a::2a; helo=mail-vs2-x2a.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Xn43V2io
Received: from mail-vs2-x2a.google.com (mail-vs2-x2a.google.com
 [IPv6:2a00:1450:4864:3a::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFA0140242
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:23 +0000 (UTC)
Received: by mail-vs2-x2a.google.com with SMTP id
 ada2fe7eead31-7b314b72db8so1476500137.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790720482; x=1791325282;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P1aswhgsxVn5juL5v7EOQ5Q/o1qpRp72XRqMkY0CKH4=;
 b=Xn43V2iorH1EWKzucfcbQMHGdxnan+O2gZZqkUdGcBQPKsFQaOBr25sYyGydDMFHux
 tWvHvpPVk14FlVKgoAmetoFzIIKD+siOif2OMB73UAHbsNvLhhgJPQ+PUhSm4mA5t3xv
 7epOaVbM/tmajtgUlib8V2XUNkDC7n/7y7yNuPrluhGYNB7DtXeG1hABfXA7U5H9mylO
 9dYf9gaNFMqbRSTf1ZhW5AReoSA075I1J0i1xMur7faevLPJPjcOPkoziFi2Zr3wspWY
 1IkLMvVUH3cROC0zoDCAeD20/tBat+8AeR2qkfyI2ZsblP+2RtCBwMZq9ZKQz1luhxHp
 mS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790720482; x=1791325282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P1aswhgsxVn5juL5v7EOQ5Q/o1qpRp72XRqMkY0CKH4=;
 b=zucv/ehg2oX86j9UoM0KT7mH9lb940dtIfC4hy/cZuISgrKYAkIJNfwvYibMVYVol8
 S+yIjFmlGqAjh5YI1MkHLeFnniewKCFTwFBoegQO0M/2OyrDAcGXi8ceQfguosezbO4C
 emIVw9Mmn6Wb3X5IlWrDnsNC38OyPhnD3FOS0ErcNSAYLaBb323viDbsFWYQP/9joX4E
 2AYj0HDwdYHcutuvSc7VnEU/2EJnnMgBZzpY9SSmAwRYZprN/JhxySP9wPIA6yS0311/
 mc0x5Le1rfSZOf4WtzWBRBls9XNvlyGhRvkltW05NYaI6b/6HoVvS0+ky4UlV0QpGMGj
 uSRA==
X-Gm-Message-State: AFq9FYLbj1JS347dzsix9a6+FRAMK44haR8UqNKxew3xE5jSQ2QJCOf5
 E4Adb4jo+utcDAQ6ff+V/eELyQwqxBCw6b8FYNL32nvhc0kddLmJUaJUQ1b6YzHw0s0=
X-Gm-Gg: AYBFou1RL32EmreBnSL0XaMpuTmmEcn4lrfCVDDC5wuHbOsCCg2lDV28ADJUY2zTWWJ
 3gY4NL5YBRQRbhNfXMgXqV1xhgg6sTpc3Yz6GYjnwXcXpd3wK9BHll8jdLu1MO0njlimbifYNMu
 vyn4FZFWwAliW6P0t8AztKopZtLjJ0nFhRj3LUF4CZYYLFW4yaV/qwVSuYZMKDvwh662B3isEGl
 CUgy7+vRKxGZvLPDoTfcso2hqgH4woENGcHglc6T4NQDwlPAj7hDhoR0DPu4JZbI2o8ZjPAbmPS
 vTmvmE/WEB0fx+fcocl8dYKdCQI9nfDnQu7qNHOim7b16g5tWqktqc8MF3aQXRe43kyf45aAchM
 B7Ep0+DceCLUQuohQMulvd87D32kA/pe/e0TTdIyy1ps68GiQQsPvwO8eP0v2KIK0PT87j8AzXz
 6j2WDObz6m/2niy39nAApXnvogIo9pG/C6eZeXYM3Eal1z4esKrVC6JlBO8v6IQuYDMw3L6XYiF
 UzVFtc2M7A/il31XwFDZsj7fzQB8dWpoxA9tzcHAt9V8zY5
X-Received: by 2002:a05:6102:869c:10b0:7a6:a661:efe8 with SMTP id
 ada2fe7eead31-7bc48cf6934mr192391137.22.1790720482139; 
 Tue, 29 Sep 2026 15:21:22 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-988d2a051f8sm746472241.3.2026.09.29.15.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:21:21 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Tue, 29 Sep 2026 19:20:33 -0300
Subject: [PATCH 3/3] configs: milkv_duo: reduce CONFIG_STACK_SIZE to 1MB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-milkv-duo-bootstd-v1-3-1b75c9ad6483@baylibre.com>
References: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
In-Reply-To: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
X-Mailer: b4 0.16.0
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

LMB reserves CONFIG_STACK_SIZE below the relocated stack pointer. The
default 16MB is a quarter of the 64MB of DRAM on this board and leaves
only about 1.4MB free above ramdisk_addr_r.

Use 1MB, as the other small memory RISC-V boards do (sipeed_maix_bitm,
sipeed_maix_smode). This is well above the 128KiB required by the UEFI
specification, and leaves about 16MB for an initrd.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 configs/milkv_duo_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 20e19fde712..2b4572077f2 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -10,6 +10,7 @@ CONFIG_IDENT_STRING="milkv_duo"
 CONFIG_TARGET_MILKV_DUO=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_DEFAULTS=y
 # CONFIG_BOOTMETH_EFI_BOOTMGR is not set

-- 
2.53.0

