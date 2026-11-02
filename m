Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E6606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RFseTRxQ;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=V+ro3Fsw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C51740567;
	Mon,  2 Nov 2026 19:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sleyynOBIShQ; Mon,  2 Nov 2026 19:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 80F5C40515
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793649106;
	b=g9YoN0Qv3vB8DQNreodr4cRLCNCanGeKWnZdF/NrZLbfxqNBxhWyPaEfU1h+q3IrclMW
	 2sW2rPl276Do/MBl1P3jA1EVMVA9lywUIf0srqcpO5/k999i3wpAYx1xtr6KZiDiCUtK8
	 ukJVjthDzokYA8ksbMsp/sP0o2meigV4BHZGAgff0Jc3qAw24WJdo/kyeacMF5uP5oY2l
	 mALgtMeRjGd6kkfDi31FZjLaBiWKhr2d51vyP6XQCw3eOWMjXvyHOHRyEwyABC1r2eRtG
	 63dAvfaAVW4y0wcIve/dZSxxJfoxzGdf/wJ/Sm2sThK6SnE8OcyOnA4zeFPdYHqtovg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793649106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rQgvfykeYFD6DFwfUXryIjfPjjbR6ptm9WDWBDd+D8w=;
	b=P//Oh4m62Z1Gd2JCYQArKfUpcfNYu287o+ilCEeTtrK7ohuoNPBSD5UhT8KFeL9N/6Fj
	 dlaigGd4iVtwYKoYoNXm2tv8+e0xlcrBsKMGE9J2GOpRP3Je94WJRZk/910plUulyzf1f
	 Huyp70LGeulwTsxHLzCOCrITY7ryWpFAL9d9ZEHAoL274B6Vdmoe9xcMaK0OcBKT23rHd
	 UqZYaDTfdNm+2Kr/8t0CKBzW8mA6TEkwopt76n3xAdFWkiItpmfElZ+3tJSBwLkYYJGjo
	 bNdo8UQP9G6S/v29X0VUFtjOqpJz81qwdc0k5JSDXPJl1SWI9bI57nFqqqx3gir965w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793649106;
	bh=rQgvfykeYFD6DFwfUXryIjfPjjbR6ptm9WDWBDd+D8w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RFseTRxQRkbuejbnQ8E3FnG1PnyJt3O6OFgSG57oQOV9HP1iqhwvuVDKVbZ0id7KX
	 CBGIRL4L8oXPW+ADQj0dlGFbyyJ4bGxA1gRbxlnHdGzynNHxbMDztnlhp9qHkunhRt
	 KytXFq10hdAcbWEMOUDbbYrqQ2kL9P/J9G5tMsUTl5RV1cLrNk74L+A4VAt/dTBJRy
	 jNQGBexOtBQ6Yu1IQ4FsleqMSh2tfg5Uk29lxqkdqka9qf2O72zS8MNBVJYb7An0qn
	 5L2C7MXgbxI/xxtgFfKPB8i5HNbsj0YoSRFRL8HV85taogn8Zj3HCGjFbzO7/e89uy
	 T2Niwe/2lj5aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80F5C40515;
	Mon,  2 Nov 2026 19:51:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A2862AC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C26E605ED
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQg54qjELtUU for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 19:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB35860600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793649102;
 b=b8dUtGoqdQTfgRjGWX3f4vd3fufyqdvV0V8Uq2KIHPgIjF3J8FwOJY7mX4vWIdpmfPiI
 g9/oS6VXprbJRCe2R9inMOuCTq7k6LdCzX1EgMwVMslFWE5OKZzeK7v+by9lOYvpHfN/S
 vAxko/oYkE018T283int+JU+VKMjOkyf7dBbF6f7/kEOlOKr1YXCs8DR7cQqNHAQPEuwQ
 Dti5C3HftkZSngzmqPTmxpARzHG9TOfYt5P5l4HwZw71knRmEKxVN4dKBx8ehvumHvA7Z
 1ctvmFi2C+jcqjhsSGkxOTgN+lQ7wb5Z+RnAhm3RKTEVHi0jIKcQWzcyrAq0fwQihRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793649102;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=rQgvfykeYFD6DFwfUXryIjfPjjbR6ptm9WDWBDd+D8w=;
 b=gLlEwgJVdifu+ASq3WemcCX6FhTrwafGLv4KjquCmGT+KpJqh1xBzLf6GIeCdpg6pFjP
 oVFdwoIwenfoIocA9qauiRflBlxJdj+5AslA069A60ZfqvwpjQbkFfjRMaN/ZXf7PgFq/
 3HNCV8QHXS4B1JFvMtNUNzDk5968wIze3pbHoyLOGy8hITlMsQYhuXSzGQAbYRsojZ6Nt
 HmyqOlD8BcLoGZ343YAC6FEhifxSPQhFZk993d2HloBsoV7gWimqLflkTsj7cbNcIvVhx
 zdwR9vPfUvQwM0bfabKHFU54/bmVbJHBcCyE/ddVRLFu3S2V5Gv7dWBVpbESLuLFceQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=V+ro3Fsw; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=V+ro3Fsw
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB35860600
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793649091;
 bh=rQgvfykeYFD6DFwfUXryIjfPjjbR6ptm9WDWBDd+D8w=;
 h=From:To:Cc:Subject:Date:From;
 b=V+ro3Fsw+RZKvp1Kt+TsEtEZfm99YbtwshqO/+ADTnFDGuyczZV2C+i2FzQ+kbHet
 NLLfpNb5rsja54OK5oeAKmBl+UZ6KqiCdQaCdxk3Hi6PBTtLl5U8Ig/5+pNQBmpHH5
 d1YQf6aImZriuRNgDoQgBFRUThm+uers1RiyaPbyoeBg5FzWr/Lee0adOFkTlKXtWS
 xOb328XEjW8vArBP0nSdgKp/i7jmLyTy60k9rWw9BEHnSGIe0cI+QMs1M/CfOR3gwX
 947GcbnXkSB4DgZCDOrJnlfYbuAJ6Yc4eSi8yztbWGhj1j9RjISq9DJBV8Xx+M0yoC
 +kepR+A0lEMGA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7E9DBB220ED0;
 Mon,  2 Nov 2026 20:51:30 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v2 0/3] Spacemit K3 enable Linux boot
Date: Mon,  2 Nov 2026 11:50:39 -0800
Message-ID: <20261102195101.103363-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adopt some fixes needed for Linux v7.2.10+ boot and enable
BOOTSTD_FULL together with minimal env addr variable defaults.

Build and test only with vendor BSP k3-br-v1.0.10 having reduced [1]
configuration to avoid a memory resource conflict. The vendor BSP SPL
in its default configuration attempts to load opensbi separately from
u-boot main app, and also attempts to load an embedded controller OS
image, neither of which is useful for mainline opensbi, mainline
Linux, and mainline U-Boot.

Changes since v1:
- Patch 1/3 apply tags; discussion continues upstream [2] about
  whether this should be enabled in S-mode Linux or only enabled by
  M-mode firmware (e.g. U-Boot SPL and OpenSBI).
- Patch 2/3 replaced by corresponding cherry-pick from Linux v7.4-rc1

1: https://lore.kernel.org/u-boot/20261029003327.1890979-1-e@freeshell.de/
2: https://lore.kernel.org/lkml/20261029162343.1896134-1-e@freeshell.de/

E Shattow (2):
  riscv: dts: spacemit: k3: override reserved status of mimsic and
    maplic
  configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL

Junhui Liu (1):
  riscv: dts: spacemit: k3: Drop guest properties from M-level IMSIC

 arch/riscv/dts/spacemit-k3-u-boot.dtsi  | 4 ++++
 configs/spacemit_k3_defconfig           | 9 +--------
 dts/upstream/src/riscv/spacemit/k3.dtsi | 2 --
 include/configs/spacemit-k3.h           | 6 ++++++
 4 files changed, 11 insertions(+), 10 deletions(-)


base-commit: e43c38e00218eae1a7b4a683c0fef8973d838fa3
-- 
2.53.0

