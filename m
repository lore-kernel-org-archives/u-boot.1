Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F91CA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 14:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E688B8119B;
	Fri,  9 Oct 2026 14:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkrvSuhjkUHk; Fri,  9 Oct 2026 14:38:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E234E81257
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791556731;
	b=EzA3lxrPuQHaxtO18ejBo2yAvJbTv/YCa708i1ytfLocnNB2SmQMXVOO5RpCTjqiVTGe
	 jFIdl/4nybUqj6hjLdnzdtrU2nUHm9St6SUOkXckM8VYAlFOIm3xKfZqXw7r4t+BbL1gA
	 EnWei3wNVG7qntaBA1Rs66MBOXuMxrzY6PL522IKMqfvHwoVFni+mw3SGYdW2KRsTsbRF
	 LYT9nEOBszuG5VOIvzHN70Q+A2GBLJG0sjKVQAXqEJWxZrF2GLnCiI+4uMzgoLeNrezes
	 F3J/rTRhF1S7PWdsR8mD54rBp85qfrDAuOhGJhGv0KM/piOyy9sY74wcBNUWa+KneWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791556731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qxtB+ICzB3ysoSdLBa8GqAdCN6bMISUmDKEFdIy2k3g=;
	b=kXnmppXNqDLAK5Sh7y5/EsfLpUBQnXOfEHzwYQl9m0m485Wcw3989hUf2wNy9YODCGVS
	 BEE415EWolHndJS3T6iBxgK5qiIkBo44P0StAcQvi+ebsPQGnRTibXpndcmCl2qKhhDpN
	 AaeRe9Svp0jzXO2i0HZePHEsqYT2xJkwJUvWHjiPH2sA8F7nDu7FdS5HfstVEzq91Yugc
	 8F/5g6qnhUddjYgxh5oGwqr2pNfk0QFYRJeoPEnPzgEaxjZb61jQJeBtUZ+W/SUbMyTR8
	 oHZXOAC/QLWUCsrWTK0DKFKZTb1LOB3QitA1L1SeyEG+iur0SCK/yu7XmGRfqvKtR2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mVnTsqYV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791556731;
	bh=qxtB+ICzB3ysoSdLBa8GqAdCN6bMISUmDKEFdIy2k3g=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DP/H0sK/dG1x/PeWbsSDhPCi/XlQ/27EnUllsj+VGoXhD6WFoomDowdbqP0jLJWBk
	 TMeHRva2Ob3d9OoiR+DVdjBfhE2TrCsmtaIL0LsIZ+n00KsvDjCtBwpXlGRDZAWfnQ
	 E1UjpNzmTkEiSRWh68MPIuGbcm4IVahbOljdB+MicYJF4/kE+cOwPwBDtwHNutu5Sn
	 7DPiJlB+rqYQb2r8ON1EkkTbR1s5cVIX4CFTmWCXyh1RDgrG4bD18w6PZPmP+2s1jg
	 MyD9xA/47ZKu1oq3Oripbs43r2QJ+WDWedmZIi2L9RFgd4Ujm2ltrGbz/MoA9XkS5U
	 Czl1rBmpiprRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E234E81257;
	Fri,  9 Oct 2026 14:38:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0C3B317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B68D181257
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:38:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-OxuEenNy7j for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 14:38:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85D348119B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791556729;
 b=XzsvIekzItk/hvbjemgjsTLBPucLZURpWRHrta9vOoXrVdhvcUcp5TsNmi4D1r1KEiC6
 WFfm1PoxcBEUm9PEcznWSZ+n6YN83M/bLFxQPOcBBvSgvJR3kYSqx3T+UHAeceJ/FNnmp
 NOsm5zO0vnfKGXW+evp4XLTfdf9v17rejhL7LZTzxrx/8CPuNHqpNwW2rJfl4sJAKd7It
 Caw3cD8gN0p5lGRWHLnlQUrPX9jVQJhMI5Fiw4kIyTk42pXSQBzsPdugWaUpZFppG+izX
 aqjfnHhS2FrnSQeavkg1SN7ffb9TkHsiUUoIIcWQ6ewWKVPv8EEf8rCzZjCRAzeGyng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791556729;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=qxtB+ICzB3ysoSdLBa8GqAdCN6bMISUmDKEFdIy2k3g=;
 b=aVRIz5qjlTLzYurqAR0+NFXthRsaBFHVPifBsB6qJGJKTPuZkLYwf9fKmJiRp83Q7jOi
 SJ/GzOogjZcfA7nI47Jr4omwut+FMu2qwEi550vmaka2IgIsRGkN6KghvD0zvXF12ZDoI
 CdEm5CE65omLFbanvY0rblP7fGTi+dFMSHQPXQ1v2ZKBF1fJnn8T8nwXxITXWD+mWs/jl
 wRAclaGSt43UmYxiM2kcwSh/5ePP5qdTiy7ROt4DBrIPifg++FKXGE+pBkhKzs6y9NfRq
 qh6sHo5cYuPvR+T1Vy0cKjWsxVMrt2pBQyDNwVF1hIF8alxAHX6tcdd8BmFiQRvWvnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mVnTsqYV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mVnTsqYV
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85D348119B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:38:47 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5da029a1749so5515721e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791556726; x=1792161526;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qxtB+ICzB3ysoSdLBa8GqAdCN6bMISUmDKEFdIy2k3g=;
 b=mVnTsqYVDI03EpShxSV8uEYGv3NQEAzaJcFIfY7/3LvrtDI0vbVwrg3pbi0STwv/te
 +1Ot6ZxLseYgsU9tecjphBEo4bMu9mZNhmN5en/LdG5ZznpPMxW8Bqbl6CaHPStr6eNV
 VUZ7h8Xl03rdOhO+Kjx9HRUeEqbWWGGyl+c0ZGZUlxwc/MPdEiQKJbKdwjMDzsleZAgw
 hGEIDkVmEHXg2OhWu91RQArDKWJzaHG8R2Xw7nZDCgXG6QnCdWAyWrdEwJa8Swe4jftR
 Ly6XTOU7bTxUttp/3UQYzfqdu0qE7GaZ5Dt0raxYyc3/R4aBcI1Hbd804331qR9vxbxX
 z95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791556726; x=1792161526;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qxtB+ICzB3ysoSdLBa8GqAdCN6bMISUmDKEFdIy2k3g=;
 b=cE2qo2LWSZYdSHlgvCdG+nnIVmLjPYkKVCWUMMyc2Vhhy2RzbBcMt0Uhv/Ts53Uu7o
 hYgFL7wZ4np5Hnz++qvDTe0GLlJV3sidV/sBnoL6dJ/O9riwlBDvwg0l8Rp+MkOvvqnG
 ulKD5YcVw+LJATowel3JDepqaOOKRiumP0u2ulGJXAHcVZOh510rUbJNa/qInta3pq7A
 FUtkFWPqfmpqU0Q0HUN/05DQCAsLSL0Lz7UUOmproKtedV7HWbpwH8FKHgKVnusC9Z1K
 klqwgkoohNrderZpoOP+x1fHHZmVYd2dSh+R8zbqVb0Fnd27Q0y5Ykxn6IBBEXfG2S8B
 ZnKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMYRtTiCuh4tRfeZ4yuLxRikVkedD1RQdHe2c5pQ+5wqW2SUDF1wG8Teeg0akCOPBt+o9I8JU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL2VsdbVznPKVv/QmjN+T9ZY7XbDNqu1oxYSSFEtiCJx/Cwdk6J
 AlW1Go2ipdSbZHbBuE9WNOAv2G2cQm7U88N6OwxJJIiYNe8K1TRkZdZLsd83/Fmd9c8=
X-Gm-Gg: AYBFou0tZ5QCBrCqRwnZmixdsPVRbxbi/fThYQZVTt+gdPpAbRdcyCNGN4yz2MEHHas
 4CUsolWWKJBU39jWRWtznFd8en7CfE1OxnCNZ3+aJvKs56feSaH2rlJdiffqurCvLmNW85Xkgxy
 9Z7wQQtic+QorD3k8fRwQrGJx73hgTLJ/APjTwwZEPyh8NyR+ZCxfNCr1kjwC0vxHpMjmHwUkXA
 sfUWLS5w2KSj+GKrjq9qfhxUmkcloXb3fko8gWfmchAgk8TkYqkJ+otrACmWJd6OYlXKuW3+G7F
 baVx/FWeD6OOueLLpr50XlSDLXUi83FysZAsO5dVJ1KmDMWRv7KHB5dFHL1cVi09083MnbWhAgz
 VjmQcbWo5mK/7lgokr5F3GaoNn6w4d3Cm0kL/qiHO+Mov9M8O4P3ido+xqZkQyJfGcJi1ty4Gy1
 B0tk449CeczVU/Xm5lLqbg6rMPmVeuoYee0CJDWg+DgzYyg1V5Hh4F1l6HNhnJdj5mpmYpSYlwL
 fLyRpFOW5FMLRRocQ+ZcPrnZoG9gbJRCZkHVw==
X-Received: by 2002:a05:6102:a4d:b0:7c0:cdd9:31c1 with SMTP id
 ada2fe7eead31-7cb3722de08mr738480137.12.1791556725780; 
 Fri, 09 Oct 2026 07:38:45 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99003f230b8sm1729449241.8.2026.10.09.07.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:38:45 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Fri, 09 Oct 2026 11:38:23 -0300
Subject: [PATCH v2] board: sophgo: milkv_duo_256m: fix fdtfile quoting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-256m-fixes-v2-1-33405d040636@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02PzW7DIBCEX8Xi3K0A2/z4lPeocgC8NLQhTgFbj
 SK/e7FdqT2Odna+mSfJmAJmMjRPknAJOUy3KvhLQ9zF3N4Rwlg14ZQLqrkG3osIPnxjBs20pNQ
 ZKbgn9eGecD9U/9v50Hm2H+jKlvDrSPg1V0o5bH+QytwQknKI4fq5wDhPMN9zSWgijCWD7TuDY
 8e8E2xY+i3PmozgphhDGRqv0Lad0MgMk05qSztpWz+2yqDiFJViwjDWk63bJeQypce+e2F7lWN
 iS/9PXBhQELrvhJLCe65O1jyuwSZ8rVhyXtf1B3EudRJDAQAA
X-Change-ID: 20260929-256m-fixes-919700ca762f
To: Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
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

CONFIG_DEFAULT_DEVICE_TREE is a quoted string, so the quotes end up in
the environment:

  fdtfile="sg2002-milkv-duo256m".dtb

Use DEFAULT_DEVICE_TREE instead, which the build passes to the
environment preprocessor without the quotes:

  fdtfile=sophgo/sg2002-milkv-duo256m.dtb

Fixes: 98b59e181daa ("board: sophgo: add support for Milk-V Duo 256M")
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
This is a continuation of
https://lore.kernel.org/all/20260930-256m-fixes-v1-0-69546876ff28@baylibre.com/,
as asked by Yao Zi.

Tested on the Milk-V Duo 256M (SG2002).
---
Changes in v2:
- Drop "riscv: cpu: cv1800b: keep U-Boot out of reserved memory". The
  coprocessor reserved-memory nodes are being dropped from the upstream
  Milk-V Duo devicetrees, which makes the workaround unnecessary.
- Link to v1: https://lore.kernel.org/all/20260930-256m-fixes-v1-0-69546876ff28@baylibre.com/

To: Hiago De Franco <hfranco@baylibre.com>
To: Leo Yu-Chi Liang <leo.liang@sifive.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
---
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sophgo/milkv_duo_256m/milkv_duo_256m.env b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
index 4c1e17b53ca..4c9f53d0811 100644
--- a/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
+++ b/board/sophgo/milkv_duo_256m/milkv_duo_256m.env
@@ -1,5 +1,5 @@
 fdt_addr_r=0x84000000
-fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+fdtfile=DEFAULT_DEVICE_TREE.dtb
 kernel_addr_r=0x80200000
 kernel_comp_addr_r=0x88000000
 kernel_comp_size=0x4000000

---
base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
change-id: 20260929-256m-fixes-919700ca762f
prerequisite-change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61:v5
prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae

Best regards,
--  
Hiago

