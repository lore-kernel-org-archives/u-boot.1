Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC1606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LsLcg8tX;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ag8X/FYN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C701E81377;
	Tue, 10 Nov 2026 13:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CKJXdT9i8_XD; Tue, 10 Nov 2026 13:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54C588134B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315958;
	b=Y4YB/x2EmT/j/rTICalStQVNd3auZsH3t8wcxv97Kpp6fTwjqKHMEJt118BjWdhlpTGi
	 BJRDXL1PIP9R0GAq2QRv1DE1v6944xBjnKAkq5QTEei1Nd4UQysnzlU5lWrMU5yNEJDpK
	 f/leQ3SPe84pDHypQkK/sgv1cTE0iHPOFxLkUpITOQm6Noy7pTZJ4zWyu8QhxHEGSzdIG
	 IvVgohdxWNDEDFewE5G0vpIGe3titZ9GeGqveeNC03j4JWYdobnTyE6OQvFDGY1g5edro
	 MFa78qRk0tdzb6F/FjR47DbteN0vn3ZoNp+umZBKx/HGTqkKMy2uGTzrBmgKWqX0p0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lRYafvtGmQrCoVNJ29/TvmV7n1mb+nQeUQvatdDYtak=;
	b=XY/1kJ3EAnabuMvKdUGPc8lKu9N80afd2HaWa/H28UA3mFFQuIUNaAAmXKgTbzumFAvO
	 ivJ5JEcchqPz/Jh6FoOJBvtnfqp+OpUeMyldfe6znjdbEzMb6eiXP4XLHlh2xdv5vmKaA
	 vAsmZfnr/bM6M+qWd89Llhz928Pk1RSig4ck05FCoWu9OgIYpTi07w8VL/QoirC1G5IMj
	 ZjQSiGt1E/c1D5XV8PGHsA5z+K3XVvGgCTft/KqbucUCJxAEjxXwnOovqS5UdW/GoQD3p
	 gZcm9U7K07HMjFRYOxwPVBOiS+GgyZEpUip7VDN1tE13dDRqM7CCnYDDcobEwxb5QsA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="ag8X/FYN";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315958;
	bh=lRYafvtGmQrCoVNJ29/TvmV7n1mb+nQeUQvatdDYtak=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LsLcg8tXObhtJc/mp1sin++B/qDBtl3UVibQXvGZGZFxFNLgc/4cW0Z74j1pOgHJn
	 B4KnKaPsCOid0g3oDrAtymqHLVObfdFkGh/yDVAqRhZZMw2A+hAkBobdba4Z0KpAbv
	 PQdqTkDcXQcKwSddM7EdvYjkSnIF4H9oC5rNyCuuIVzLl+byx78so/dHmz9Gz/oExV
	 dm1bJAIca221xgSKvkGuNUmRtuZ0I254oFt0j9koOtWSbSQAArPHnX/kBGpPDAFAzu
	 DdV1APe15nJia3rX/EJepLRDcfxqM+4PxE6UZpxbarWOy+SMC/E/Es64DHbI1rDo6d
	 GbWiStO5whZRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54C588134B;
	Tue, 10 Nov 2026 13:05:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D256FAF2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC33680DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ai9L2W8EGJpc for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:57:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A4F380E11
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=ag8X/FYN
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A4F380E11
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:55 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA94C3F9C8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794297472;
 bh=lRYafvtGmQrCoVNJ29/TvmV7n1mb+nQeUQvatdDYtak=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ag8X/FYNp2OpKAcwanCZL+nAMrkQh0Y3DppJaJD6krg5GF97tITDm6brsHrIR3Lt0
 KsXh3jZEXW47yCp56a8BY5vAxfo1o/ti04/MDDDXN2MokGzBtaaxXLChoFkmcTPMF+
 5U2TXA3mDBELNR6B9Eg8dGo9LaxkLMRdEKErO7h/PqSe/lSZ2asS0y8eU3r94HFB9r
 bdjfL9VLI0qE48fiXOiQG/cYbK12o/7xps1xaRz6ssw4J09xPLoZhBR0l4S9dRcnZ9
 A7GbgSj3gNAt8PWBstRC6l40bNJ/rrrWyq03J/jIELyVP9KJF/knRKZgwc5TyamSrj
 QDtz5RJaSdP8KdN1FU53ea+PMoYwG1uYAmw0vxU2dnc3piwmV7OcypRD3acXsHqFsx
 tHrQyM1WL5aPlCaRmbwoN6EnYy714KMVHBNGpbsJqToQoSAY728IOQmrV8+q4M+8Jz
 KhT6Khz/hwdK5Rl8DLE4Lrsj0Erw7/J1yGtbuhPDzZPDDMbINCDUN2jceYjswMH/zy
 g0CzJ0oxFQXaxq2tEa4HaLOVSz6et8p6CO1b7phOPtv1kB40/x0YTy13JbuAapM0O0
 HpUqP13Xa1fO98pS1Vcvt19/fmOa9lbJQ6AyeL0KS3RVChrV0U2t6A4xEVnRbfH9yY
 ifsRwao0LaC1dGMyzVYQ7iFE=
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so2324985eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 23:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794297471; x=1794902271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lRYafvtGmQrCoVNJ29/TvmV7n1mb+nQeUQvatdDYtak=;
 b=OkGua0Mth1Cu+dxlUuSnW1j0PQ78oHIBoj+jYM2SoTYrzvxnE+vwDN0OQfv550+HPb
 dQonLMgaKs+ID5agyHRVbWAlJDxirGY9lCB4NBekrZuscik/iEccceFM5RphuDCZi1+9
 HXtXNygFNIL4SRjFd/KKvoMYpOh2k/Xk4ccRs/XaMcMc6TmUTNpfDivuhHAf2A3ZVmx3
 AspV7U/yAbybdMwhrRJUm2KUO7vTka7NEz6dQ9Cwk6pdTNagwSrp2RaBfFepRaAMpZ+m
 eLnUgEfByvCFYrkRj13jKSE2ZkTgoIXI0N/H0PDjuB3lMDnN0B+afx/T0gy8X+vH3OXP
 o32Q==
X-Gm-Message-State: APuU4Z/CXJwkxi5OfVIiqCQ+KotPJppW1sZO5sTdZH8xG7DAhgH7yUv/
 kpTOENEChEqa4xMtc9Fvs5yrorRQzZoSWAjVeMtv0BTpnKTcj1S7BBWvjkxIAxj/uEjhaVvH5Yc
 dOKobWUohwhWW/WOUHacd8mvs+i1+cktVP3pgWm9r+WSxG7lrlcM4fGntjb2f7CjoU5XxE27dAv
 XiUoohoIK2oRdCkUC9I84i
X-Gm-Gg: AYBFou0lfjBTVm8aCmpjJJ84qiFbdFRFBH4ZrgZ/w0DiJLlMUoduaNLxF9QMY8AtoeO
 aXHeUgCPgJ5U2bQKGN4Ca7/04DMlKtpajMQ77OTfHm/UrL9iUJgSyovzbKsGkAnqptPOVrmNd2P
 yvLL02iVpVDVc/JJRuZU2eA/ufdYXBxQIaS+xnD4PdJl2cpxwS7Yu62ODYImMQLOXwtgKdBVYO9
 cewwAbq1t5xXQcRvhprEY0Unc8bqt/RaJi1zK7Mwn9waw9LTnh5n8yidKAet/QhXme1dWapRIHm
 U6KW2lS0hDGEtdgOilCPxKCnpdv8fyY8ItXzUHrJ0mMzs9asMTnMYmpc5pWD5O7MsuvOKav52Y4
 5oJ3T2xtA9yKnd8pNNR9YWjrOBN4QcAWqq3BNK0nyXsf0ElpSqIpsqlWeqhD3p9qI/KJ6KDGAyL
 lzgSNPbIbHBL029YxJS0TGZ0UO
X-Received: by 2002:a05:693c:639c:20b0:36e:2b8b:a098 with SMTP id
 5a478bee46e88-37520215e38mr2574168eec.31.1794297471201; 
 Mon, 09 Nov 2026 23:57:51 -0800 (PST)
X-Received: by 2002:a05:693c:639c:20b0:36e:2b8b:a098 with SMTP id
 5a478bee46e88-37520215e38mr2574126eec.31.1794297470468; 
 Mon, 09 Nov 2026 23:57:50 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe3261csm4212914eec.4.2026.11.09.23.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 23:57:49 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/6] cmd: pstore: find the zones where Linux puts them
Date: Tue, 10 Nov 2026 07:56:36 +0000
Message-ID: <20261110075707.1409824-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pstore display and pstore save look for the records where they expect
the Linux ramoops driver to have put them. This series makes them use
the layout of ramoops_probe() in Linux, including the zone order that
changed in Linux 6.2. Each fix is followed by a test in test_pstore.py
that fails without it.

Patch 1 checks that the buffer for the records is allocated. With a
record size larger than the malloc pool, pstore display and pstore save
copied the first valid record to address 0. Patch 2 sets such a size.

Patch 3 computes the zones once, as Linux does, for both commands.
Linux rounds each size down to a power of two, and splits the memory
left for the dump records into as many zones as there is room for
records, so a dump zone is larger than the record size when memory is
left over. U-Boot used the sizes as given and zones of the record size,
and pstore display and pstore save did not even agree on where the
console zone starts. With a record size of 0, Linux makes no dump
zones, while both commands looped forever. pstore set now checks the
rounded sizes, in 64 bits, and pstore display dump <n> no longer reads
past the dump zones. The default sizes are not affected by any of this.
This is the layout of Linux 4.10 and later, with the dump zone size
rounded down to an even number as in Linux 6.8 and the stable kernels
that got the same change; the commit message says how other kernels
differ. Patch 4 checks such layouts, a record size of 0 and the checks
in pstore set.

Patch 5 handles the order of the user space (pmsg) and ftrace zones.
Linux 6.2 moved the user space zone before the ftrace zone, so with
current kernels U-Boot shows and saves the user space record as the
ftrace one and does not find the ftrace record, the default sizes
included. The new order is now the default, and the old one is used
when the zone after the console zone has an ftrace signature, 'DBGC'
XORed with LINUX_VERSION_CODE. Patch 6 writes the two records in both
orders, and checks that a user space header without a signature, next
to ftrace data that looks like a user space record, does not mislead
that check.

Without patch 1, the test in patch 2 crashes U-Boot. Without patch 3,
pstore display loops forever in the second test of patch 4, which
test.py treats as a lab failure that stops the whole run instead of
failing one test.

Each commit builds for sandbox and sandbox64, and cmd/pstore.c builds
without warnings with W=1 for pinephone (arm64), r8a78000_ironhide_cm33
(32-bit) and rpi_4_32b with CMD_PSTORE enabled (32-bit with a 64-bit
phys_size_t, which also links). All pstore tests pass on sandbox.

Aristo Chen (6):
  cmd: pstore: check that the buffer for the records is allocated
  test: pstore: check that a buffer allocation failure is reported
  cmd: pstore: lay out the zones as Linux does
  test: pstore: check that the zones are found where Linux puts them
  cmd: pstore: find the user space zone where Linux 6.2 puts it
  test: pstore: check the ftrace and user zones in both orders

 cmd/pstore.c                 | 203 +++++++++++++++++++++++++----------
 test/py/tests/test_pstore.py | 196 ++++++++++++++++++++++++++++++++-
 2 files changed, 341 insertions(+), 58 deletions(-)

-- 
2.43.0

