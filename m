Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40CECA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5166940607;
	Mon, 12 Oct 2026 12:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1TAvQYpK4s-A; Mon, 12 Oct 2026 12:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1003F405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808610;
	b=Ray9vFwF60sZoYKZj9TUev3R9MshVQFtDXeQD7SmOu66cKQx4+QyTzaoFa7SKba7AOgT
	 IHrh6aTCi4anxDHuGRx2PuIIq2y66kwyepWyUZiyPfFsuRYXBPW0z8h38ADoX/ClqHKGk
	 U+1nvPd4+U8y4CRDX4q1A6wBx+ONyA/FOCSge4r8X6WnWhrFdRcH8kKD60Whr05QfF3P5
	 s51FmC0zUDm+Khvukvm8sEoZTJZXg1pGrVQao5KsrCCfKpI2oS3iwXXYrgP57jCOjwVhF
	 rvsJ3ndxaPW0+oTwZwOKd/CrFkzoMub/ujXiRfGoLuXqGgQsr6zb4s569M+fi3vLWAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SHFskS/OIfBXsuETvXk+TfZsyz8HTPkY4EM6C53u+Yw=;
	b=IvBOhM4e6XmEAC9tQbxGBUA82TguTTrMBse3Vs1NbZnlhAihKUz7uqhomHXEHXqf7U52
	 yYJCXxmjt1N7iJR/672NDqspQxKggzAMy1XxeCCeZ4tYCuGYt1ugEmtC9eAx0GCopxYwJ
	 kCghJntOo6vj+VpHA16KG3/XZUKMloyqWQN/TE0vuLYWn+R7SKk5oGQ5gEos7YvCiu5e7
	 I0gN7YtLeQbOxgCEZfiDOIYWbfE5UMYH4uCGNwYzhCPB08H315OSvE+dFa6GH/+fYqdxb
	 Z1JKVOLPvw6G/KTAnu4QOc2VG9v8cbj10p4SX8I2CVR5oxCuOkhpjSB/mJsjKc09eXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=aUJ4toXv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808610;
	bh=SHFskS/OIfBXsuETvXk+TfZsyz8HTPkY4EM6C53u+Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NlxYWpYhbAC2wfpk9Ay5Hol8KXCSjpc5cMjeUyj+cnHdivpUt7xk46ypEjLrva9z7
	 1w0tEmDQtvXHfPPb4fNgbPOKGNGOAusk5kUb7RDbJUZIiNhIFW1Va43+FTG8NTFXx0
	 FdEII4wa/2g8Hz8n5HNgvHgjMIJtqpNG5elkqIbCNU3HTtMZKnqGhgTHhh/cyr79c6
	 YLNh3uVacDQrHAp3XKmyco/8lGUU/XfPuo3O4bjbjz/4ROZe1n5vZSxOpO7JUthVS8
	 SUdy9lyGGo4MrGvblmnTNmvCiBP4k6HcGVilCeM3vT2/l+cqRTjxgfNr9xJHC+ZVDq
	 grwTA+fCiD+Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1003F405E6;
	Mon, 12 Oct 2026 12:36:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C0032E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31B534059A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HIR5l5ldKer3 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8512740599
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791799861;
 b=cPXJZOOseoHw/c9Fy8wmZ7MfdfoD6brv8Rqsix/1HHOKIovwaKL02dee0iwn8yFkC6UR
 rMhpoPi1oMKcXmGHCGU4GMBkThE7vQLzPRyM3l/nxx0r0xeZ4fKcHkyBfzppIYDGVNOFG
 k2qMyDiTmYeB9QhmR8aYkHhX86hn1yerrbmSQRnpSL0se8Kib1amjHlZNwSEtYEs8XM5T
 GSb9xbUmrKI7lmsjCtxCazZg16fVTyL/ksk1e3Gep7Cu03AOiWf9ycugASZw8ZyZQBebm
 bt3kfPXXr30y+R0GSBwNB1Wrx6F/WBCISpt29MeBpT+9JkPe3SZrN2pv6Zh8fvRiOMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791799861;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SHFskS/OIfBXsuETvXk+TfZsyz8HTPkY4EM6C53u+Yw=;
 b=cRTSaa2ojpyLB6Z1nEknieKqGWSBd/JOwEpNiRnCvn2yKrqX1RQDIeUyX22DXk97UO2m
 eQU+7rowkmL1bf536jhG+5X1hNwgWz7dRQpcIlIBdpfRMZ0gebyjziX/6a0BwtLWcIWnt
 YsFH682W8o+NqxMxMOTHE0OJ2HOSBKjSoGH8E7zL9liiAVzWoFHLDyc6YmjYvNgyOk8XQ
 lAoMgnxzsJFr8KNgd1wHLEz8wI8uZWSiq2owZGYweoKST+QLkPpT0kqdG4FeJ0ANVuwUR
 KFckay7lENT+g/H/yN6aBny0npPttb2vwmIDUF2urJqIqyrnh70Mb0flJ70JBwVj8CA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=aUJ4toXv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=aUJ4toXv
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8512740599
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:10:59 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so16751915e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1791799857; x=1792404657;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SHFskS/OIfBXsuETvXk+TfZsyz8HTPkY4EM6C53u+Yw=;
 b=aUJ4toXvWVxM8B4IXHAT6TeH29DaG075OxKIT1/aSmVzhu+Q8QiUqGC4SEDWOkAkBq
 Je/prkzXdC+aL38K/8wDuCWt0an6tmqwkIihBHFZYbPTG/tq6odqY5lBrvqbWnSkEbaO
 zyjNun/t8dTQCVXqqRV00E/wXbL325oW42rFnCn8Pc+AGJGnkoWe1UFFSBTfikiTw4pU
 NGJUfO9+ccE9qJbQ5Eo+C5SwcOiEiieXLndcLt9LbhytG+IsYCiAloas1Iz3D7dGUTUm
 DUNdyvUVsCXjgQ1V0qURZogqxeaP5vB8x/er6I+z3psHTiPs1gE2wfzB/WSbWuwjkcsa
 nofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791799857; x=1792404657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SHFskS/OIfBXsuETvXk+TfZsyz8HTPkY4EM6C53u+Yw=;
 b=vkC79PeUW/iaODyvkepbpw4pzdeS9sFOOBta7EDzDzKsk+UQQNm0U9qGueUtXRMLz4
 aTtUaMIpVMq82ve7CMgqEbngahE6oI5zByxvEQxEMP+NccSQVNFhFx1FjfCs1mcwh0Lx
 c+08/M8h21hhd+Jwv8s9L0Gb5QxwlZXneHJVMWQjVD9ylIIXLfm+zF5j7gslHCZxC1wJ
 tzC7LISzGSQVRMUyaIKiR6T0XnadxAlzdbLkmFqd4rTFjBJ5fpDJjIwBondmOuV9nmIy
 K53kr2v04klUvydQPMJ0nsNSJ76EuHHzweKf4U3NEePeuBBqJvLWNXrjorn55unzCZEH
 FJCg==
X-Gm-Message-State: AFq9FYJGN1PCuJzUSHXbEBDEvwYWpb1dKJEm8QZLlwRWjabEiM6zi5KQ
 AnEm1wbQRad+8vlESJy/hdzp1jo9zLr0Ed4+NdTl2SAMudOx+hnYwA7QV2CS6Tx/5k256KSRC9b
 1tUdRmF4Dkg==
X-Gm-Gg: AYBFou1581MUnIZO09NrxksBC4+YbLePbI57UibG5qlEFqW4fx9JsNfq/6SCMtnjUsB
 mrJxQb41hnh9GcJparv8GiNZ0Sbeuq4oIVeGy8kbOE6kSgiYv9uVN1Z/6X+h8KIPMTaiwcmabw3
 3NeDWvmJXVJ3Yvt2XfpkNPDKPek676bchRUWYds+TGlnzgczv+2i1duyyuIswFJfktdnSiVsjpr
 uYfQn+rrLNpOo7HsS2PEJ4Po8n7K7y6MSydAE9+Q4fm56CDcggM2PFgjgR9FqovZp8QxDC1NKP5
 DZoXpSefrF/X+MnrzVQEWmGH6HQ+QZrqBKMQwHSf2Dx00Btr3d0QWDY5FDPXxHB2ad5zzC7B1pj
 oc07f4lZ7ISuET21OSbp0TnBp2xPBaWcdtXhxS2M6+XLl8t6OdUKKD6tPo1hTPbzVFr3vsFxtjI
 vOQy++KrqnJqWBpzffE2ZGNOfvfn5jgN0ZXWF06nwhnnq6Ddi0/2c5mcAoUWmux/JBhV9L8xNq4
 dJJ2uOLFA==
X-Received: by 2002:a05:600c:6285:b0:4a1:70da:3350 with SMTP id
 5b1f17b1804b1-4a18e4b8c6emr166085465e9.32.1791799857245; 
 Mon, 12 Oct 2026 03:10:57 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd57fsm18064559f8f.37.2026.10.12.03.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:10:56 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH v2 0/4] binman: pre-load: Allow signing with an OpenSSL engine
Date: Mon, 12 Oct 2026 12:10:50 +0200
Message-ID: <20261012101054.2104707-1-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917065545.1989088-1-lorenz@sigma-star.at>
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 12:36:48 +0000
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

The pre-load entry type signs with Cryptodome, which has no PKCS#11
support, so the private key must be a file. Keys held in an HSM or on a
smart card cannot be used.

Add an optional 'engine' property. When set, binman signs by running
openssl with that engine and takes 'key-name' as the engine-specific key
identifier.

Tested with SoftHSM via the new tests (both paddings) and with an RSA-2048
key on a YubiKey PIV slot.

Simon, thank you for reviewing v1. I hope this version addresses
your feedback.

Changes in v2:
- Reject a missing engine key-name before attempting to sign.
- Remove automatic PKCS#11 URI construction. Pass the engine key
  identifiers unchanged.
- Explain that, when OpenSSL is missing, _sign_engine() returns
  exactly RSAS[sign_name] zero-filled bytes so binman can report
  the missing tool without failing the signature-size check.
- Move the change to the testPreLoadInvalidKey() test to patch 1.
- Add a separate SoftHSM setup refactor (patch 3).
- Use one device-tree for both paddings.
- Add tests for a missing engine key name and an incorrect signature
  size.

Lorenz Kofler (4):
  binman: pre-load: Move signing into its own function
  binman: pre-load: Allow signing with an OpenSSL engine
  binman: tests: Share SoftHSM token setup
  binman: pre-load: Test signing with an OpenSSL engine

 tools/binman/btool/openssl.py                 |  28 +++
 tools/binman/etype/pre_load.py                | 131 +++++++++---
 tools/binman/ftest.py                         | 189 +++++++++++++-----
 .../test/security/pre_load_engine_pkcs11.dts  |  24 +++
 4 files changed, 291 insertions(+), 81 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_engine_pkcs11.dts

-- 
2.55.0

