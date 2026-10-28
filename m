Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qv61Uhv8;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=LwYiEuFp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D74A880F32;
	Wed, 28 Oct 2026 10:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-nMRxrttfqD; Wed, 28 Oct 2026 10:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5B2380E13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793181806;
	b=ZRHhrU1yKAkAxMxeN0TksLqUunXZW7DXgRbgl32/FHb/bTZ23Gty+2mJcJrlwlyri1HS
	 y2fm+0/5NTHoZxdgdgOR2SiphyzXO+DWdapLvkYj8XJ4quF0IPZGF5nyV1mUpCby9jTPg
	 lkR2RrAf88DReTHKLyrldMQ+bFBGkaST9H32xQikFHZDV2x/qAW/CRJzfm01xRLINxXDN
	 5a3IlwWsCxAbUcn+AXQjfDBcAoO79ROgoXm1/Kt3UuNmL9nKlSsRDO6isgY496bMZybzA
	 zeZZxMLIV/28Bhuh1ySUpekcTpiVXkB9lze2isWSGDFVO5uWJqLGLntGDE5eLj+IQdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793181806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6nlaA34mSGtvLcVLuqHqOOv/Ppe0AEBN93GAjGMSOmI=;
	b=Sk83qr/iehJJZhHRU9U12/l8M+guFfEDmTG4/t6cDq5A0uU/DlSzIy1ehNp+5cw57HXW
	 fizldyqWaZDlxr3N3epOFQ6e2shLC3eAwmcgtgV99KBae4Vki5yVLoAw4CoUxx4TDhjuF
	 mVxKNlkRY+6a6gifXW7IRu2l9TBhgLjyZthUoh6A817ZOpHtBLiRqGHLclV69z1SsGsFk
	 PzoKUUjzZZE5xheDLTYkdeC4+ID6Aw8Tn2COc3yk8D21J63ijLjEZGfHHWsdgcMCMGg5D
	 bqXiSI687sakOfNCVGZAeaY+jOl+YpVNxxbDe4MpPbH5KPlZR74Trm2xHzD9EMWPy3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793181806;
	bh=6nlaA34mSGtvLcVLuqHqOOv/Ppe0AEBN93GAjGMSOmI=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qv61Uhv8WwGM8auiklt/cT9o4eEih5+Zn+7eSfQ0gQ7t5AJoCWUl4Ns62ZReeQ7jq
	 kcUmQX+ENxo4CVz/Qux27bM06dcd0RYE6WpewTYOH7OPg+hfCWuzxHSGX/SBt5Ic1P
	 86fzS6xQw1C+DSOMOX39fJtH07SNJ68LsA89bqOf0t0Lo7rioX6jkgr1qiUgi8hbIg
	 Nw5zyTFkY9QW/KgjjjUoEOXXTdo/e0Q50MkUKU7ko/z+eLH6KC9FNZ/rx3dhWKxsXU
	 Iu65i19ixtr/JWqs8xlQg/h032UBzlrgoy91CS2WbUo6pp2yV7cSck065rjniiqps0
	 0Zf6PAg7HWncQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5B2380E13;
	Wed, 28 Oct 2026 10:03:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8390D235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 750F0605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOjHaGNjWr8p for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93C09605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793181802;
 b=AKY9jDY37RcV0W7fW5Lqy+prRY63XGol39KG64isFFduB++3mdvPiOb//kR834qLSJsU
 4jz3e3vvOFDTAGQ0DdQ3AeGte4VYPTRqN0jcDg+J4/PZLyiNtXHg0zwmxy8msaNS8qd0E
 VajRDrMwP4UYGmt6cB6SgZ7K5yrPtxluCUY+IIYp0+Lm5/ys2CaQQl2FsrJAHGyg317bS
 noRgjthyA6k0XEb0V4Ig116sUJPq3Y978YCKkJlS2QfK3Gy0PWQ9xxyC2g7qoQihJXv9n
 aoaAej3N/1i/H1Wl7QJ2fiVqJAMVZPo2yXIVsCu+Z53E1HX52d2z3vTxTdYpMVbJ84w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793181802;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
 bh=6nlaA34mSGtvLcVLuqHqOOv/Ppe0AEBN93GAjGMSOmI=;
 b=jA0CmNmlewY28hq4pFdYW3ogX9bmzCkmoODc3/M7zacdRZmZF8h47MwhJ04sJC7IlZHW
 jfLMd1OllWsVV9JuJVj9SUQ14pflvBRZZwnkyDQE4m0tIWYyeeVsQHNR49ufsJ7UAGAJn
 W45RM19dZMZperoR4gtvxOiEBoOeqbE34zgY6CWg1SBnpB/jW0rxm0ItnYp75jk8gwgDc
 ZalmJ9Rb2Q6Nzr3xHJNZ5HLSTyYhrpu9oy9tlbu7n5rwkYaN9r6DeA9xJm3VnDGpwdqCv
 tMKSnBtklc/+D2mHiM2XNb0hOd8FxKEm8fFUbLJBkQD6k9ucTKpMHgmRAbyFYY7jUbw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=marvell.com;
 dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=LwYiEuFp; 
 arc=none smtp.remote-ip=67.231.148.174
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.148.174;
 helo=mx0a-0016f401.pphosted.com;
 envelope-from=prvs=2761532eb6=akashn@marvell.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=marvell.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com
 header.a=rsa-sha256 header.s=pfpt0220 header.b=LwYiEuFp
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93C09605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:03:21 +0000 (UTC)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SA1BNv3929820; Wed, 28 Oct 2026 03:03:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=6nlaA34mSGtvLcVLuqHqOOv
 /Ppe0AEBN93GAjGMSOmI=; b=LwYiEuFpUD+WU+3n5l8ASe7yhkrXXUGSrLxqWFw
 sLBD6TfOSXCYXO/zuMBnDjhJsLNcXN5EGSnM2jECh5C75+dHJrm2z1ewKIksP6l6
 lWus/d953bJq7r2XqmQYV66ex+i7Ud+yOaS1DEoS4/nHu7+KrKDODUY8J12v/dIF
 j8kaHtvC4BTNY4SrYKgJ8Y+o9x84cf0f2/H6aFi97OyXxTni/HKRVn0Rj007BKIg
 hrjAmTitO/JACORW1pY9sU/63CLQ17WRyYCCWpImcvOa1rh/uyiBED73h7VCi8a3
 2n36BITS3DhDVBqcWgKucIHQ/DQGDMMUz0jbk0s2o+V4yWA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hkeky83hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 03:03:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 Oct 2026 03:03:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 28 Oct 2026 03:03:04 -0700
Received: from hyd1-dt91330.caveonetworks.com (unknown [10.29.36.146])
 by maili.marvell.com (Postfix) with ESMTP id 8515D3F70D0;
 Wed, 28 Oct 2026 03:03:02 -0700 (PDT)
From: Akash Nair <akashn@marvell.com>
To: <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <jerome.forissier@arm.com>, <akashn@marvell.com>,
 <rkannoth@marvell.com>, <naveenm@marvell.com>
Subject: [PATCH RFC 0/2] net: pcs: Add generic PCS interface and Synopsys DW
 XPCS driver
Date: Wed, 28 Oct 2026 10:02:56 +0000
Message-ID: <20261028100259.2491887-1-akashn@marvell.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfX1Fcgltye+bWt
 16P/5YyzZMM5fd7X1M23JedJ9QNoXdaT1HF/mIq9PkE9ZVGurDEerPyIKJsB+LFFKV8/rhALGZy
 DvYq9or1uUFAwdr6kyzMdSsW4bCFFMceFIljVp440iBczGvd2dDi5I9OBKgR+pM/S82dat52Ruf
 5Sp9VAtMLSq0CjjeCAYgDJsyVj+eBi144OQgyfpUQiQNwCtwBUBldLVPHvN1xPr/+9Pj8Ay4jEd
 /zbJ5HIwOCQDiujh2TC9xCOaje8Gm/Jrv9MTO712vTPZ/ESTpFLzT0xx1Rg79cmJ8LtOZEI2GT/
 DLqou7QIF9uFjUWJ3hP+W+bDMs++wfrDHaUmQ78suc522GhxH6IO7MlpY9KssWJY4PHEHwWOg4I
 Qejzt9HujPqCtUWvJRHrH5UsLdTLCMMwgaHVrBlASbYMDKg8ZAszaFVflDsYtxaP6WyKAaUEE8C
 yaGOzaNz7plXpEBR9/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOSBTYWx0ZWRfX/S4tHSFJCDWn
 pJqDCvVQXJAY7Y2/CQ5IxUyU/kNqqb+pKSnxWlfc7gmxfapzDMxdknYacng5mGPs1Es6DCMeFgd
 nZQbWIfXMPSKJ+rRk89/KzLiMcEtJoY=
X-Proofpoint-ORIG-GUID: 1J0rwp13_DeQoZvhd7RuRYtlQopYwkGh
X-Authority-Analysis: v=2.4 cv=bv7Zl0ai c=1 sm=1 tr=0 ts=6ae1c858 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=XIB7Ul_szJEgLjLbTt4A:9
X-Proofpoint-GUID: 1J0rwp13_DeQoZvhd7RuRYtlQopYwkGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This RFC adds an interface for Ethernet PCS (Physical Coding
Sublayer) devices and a driver for the Synopsys DesignWare Ethernet
PCS (DW XPCS) that implements it. I would like feedback on the
interface and on how the driver is structured before I post the MAC
driver that uses it.

Background
----------
On SoCs with a DW XPCS between the MAC and the SerDes, the MAC driver
has to configure the PCS and read back its link and auto-negotiation
state to bring up 1000BASE-KX, 10GBASE-R and 10GBASE-KR links in
U-Boot, for example for network boot.

U-Boot has no reusable driver for this IP.

What is in the series
---------------------
  1/2 net: pcs: Add generic PCS interface
  2/2 net: pcs: Add Synopsys DesignWare XPCS driver

Patch 1 adds include/pcs.h. Patch 2 adds the driver in
drivers/net/pcs/ with its Kconfig and Makefile, and hooks them into
drivers/net.

Architecture
------------
  +--------------------+
  | MAC driver         |  (follow-up patch, not in this series)
  +---------+----------+
            | pcs_set_config()  pcs_get_state()  pcs_disable()
            v
  +--------------------+
  | include/pcs.h      |  patch 1: struct pcs_ops, pcs_config,
  |                    |           pcs_state
  +---------+----------+
            | ops of the PCS device
            v
  +--------------------+
  | pcs-xpcs.c         |  patch 2: UCLASS_MISC, "snps,dw-xpcs"
  | indirect window:   |  page register + register offset
  +---------+----------+
            | MMIO  reg-names = "indirect", reg-io-width = <4>
            v
  +--------------------+       +--------------+
  | DW XPCS            |<----->| PMA / SerDes |<--> link partner
  +--------------------+       +--------------+
   1000BASE-KX: C37 AN   10GBASE-R: no AN   10GBASE-KR: C73 AN

Interface (patch 1)
-------------------
include/pcs.h defines struct pcs_ops with three operations, and an
inline wrapper for each one. A wrapper returns -ENOSYS if the driver
does not provide the operation.

  pcs_set_config()  select the interface mode, the auto-negotiation
                    type (none, Clause 37 or Clause 73) and the
                    speed, using struct pcs_config
  pcs_get_state()   report link, auto-negotiation complete and speed,
                    using struct pcs_state
  pcs_disable()     stop auto-negotiation and power the PCS down

Semantics:
  - set_config() can be called again later, including after
    pcs_disable(). If it fails, the PCS is left unconfigured.
  - get_state() reports the speed as soon as the PCS is configured,
    not when the link comes up. A powered down or unconfigured PCS
    reports link, an_complete and speed as 0.
  - A negative return from get_state() is an error, for example a
    failed Clause 73 negotiation.
  - Calling pcs_disable() again has no effect.

Driver (patch 2)
----------------
drivers/net/pcs/pcs-xpcs.c is a driver model driver for the
"snps,dw-xpcs" compatible. It is a UCLASS_MISC device and is enabled
with PCS_XPCS, which depends on MISC.

The XPCS registers are Clause 45 registers in the PMA/PMD, PCS, AN and
vendor MMDs. They are reached through the memory mapped indirect
window: the driver writes the page number of the register to the page
register of the window, then accesses the register at its offset in
the page. The selected page is cached to avoid redundant writes.

At probe the driver waits for the PCS to come out of reset and checks
the Clause 45 device ID. It does not configure a mode. The MAC driver
does that with pcs_set_config(). The driver checks the whole request
before it touches the hardware, so a bad request does not leave the
PCS half configured. It then stops auto-negotiation, programs the
mode, power cycles the PCS to latch it, and starts auto-negotiation if
the mode uses it.

Supported modes:
  1000BASE-KX  Clause 37 auto-negotiation
  10GBASE-R    fixed speed, no auto-negotiation
  10GBASE-KR   Clause 73 auto-negotiation

pcs_set_config() accepts only these combinations. Anything else is
rejected before the hardware is touched, with -EOPNOTSUPP for a wrong
auto-negotiation type and -EINVAL for a wrong speed or interface.

  iface         an_mode        speed_mbps
  1000BASE-KX   PCS_AN_C37     0 or 1000
  10GBASE-R     PCS_AN_FORCED  10000 (required)
  10GBASE-KR    PCS_AN_C73     0 or 10000

Auto-negotiation completion is polled from pcs_get_state(). The link
status bit is latched low, so it is read twice and the second value is
reported. For Clause 73, pcs_get_state() returns an error if the link
partner cannot do 10GBASE-KR or uses Next Pages.

Devicetree
----------
The driver uses the existing "snps,dw-xpcs" binding from dts/upstream
(Bindings/net/pcs/snps,dw-xpcs.yaml), so no binding change is needed.
Only part of the binding is implemented. reg-names must be "indirect",
the window must be at least 1 KiB, and reg-io-width must be <4>. The
binding default of 2 is rejected, so the property cannot be left out.
The clocks and the interrupt are not used. The driver does not enable
clocks, so they must already be running when it probes. The gen*-PMA
compatibles are not matched.

Example node:

  pcs@1f05d000 {
          compatible = "snps,dw-xpcs";
          reg = <0x1f05d000 0x1000>;
          reg-names = "indirect";
          reg-io-width = <4>;
  };

Origin of the code
------------------
Some parts of the driver are influenced by the Linux XPCS driver
(drivers/net/pcs/pcs-xpcs*.c).

Design choices
--------------
UCLASS_MISC: a PCS is a UCLASS_MISC device and the MAC driver is
expected to get it by phandle. This is what the Airoha PCS driver and
airoha_eth do today. A dedicated UCLASS_PCS would be cleaner, but I
left it out of this series on purpose to keep the scope small.

No in-tree user yet: the MAC driver that calls this interface will
follow as a separate patch in about a month. Until then PCS_XPCS is
not selected by anything and not enabled in any defconfig. This is
why this is an RFC.

Questions for reviewers
-----------------------
 1. Is UCLASS_MISC with the ops in include/pcs.h acceptable as a
    starting point?
 2. Are struct pcs_config and struct pcs_state enough for other PCS
    drivers, or is something missing?
 3. Auto-negotiation completion is polled from get_state() and the
    interrupt is not used. Is that fine for U-Boot?

Testing
-------
Not tested on hardware yet.
Build tested with CONFIG_PCS_XPCS=y on qemu_arm64.
checkpatch.pl --strict reports no errors.

Not done
--------
 - Interface modes other than the three above. More modes are planned
   once this is approved.
 - Clause 73 Next Pages: a link partner that uses them is rejected
 - Register access over MDIO and the "direct" mapping
 - Clocks and the interrupt from the binding
 - PMA/SerDes initialisation: not done by this driver, it must be set
   up before pcs_set_config() is called
 - SPDX tags and a MAINTAINERS entry (checkpatch warnings)
 - Sandbox emulation and a dm test
 - A dedicated UCLASS_PCS

Akash Nair (2):
  net: pcs: Add generic PCS interface
  net: pcs: Add Synopsys DesignWare XPCS driver

 drivers/net/Kconfig        |   1 +
 drivers/net/Makefile       |   1 +
 drivers/net/pcs/Kconfig    |  12 +
 drivers/net/pcs/Makefile   |   1 +
 drivers/net/pcs/pcs-xpcs.c | 881 +++++++++++++++++++++++++++++++++++++
 include/pcs.h              | 140 ++++++
 6 files changed, 1036 insertions(+)
 create mode 100644 drivers/net/pcs/Kconfig
 create mode 100644 drivers/net/pcs/Makefile
 create mode 100644 drivers/net/pcs/pcs-xpcs.c
 create mode 100644 include/pcs.h

-- 
2.43.0

