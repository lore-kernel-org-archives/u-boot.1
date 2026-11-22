Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BE606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O/l40Ir8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=zMVchTLb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=V8z2lYgP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B2D7405F9;
	Sun, 22 Nov 2026 22:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jEdCJXcYVSbN; Sun, 22 Nov 2026 22:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15734405EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795385542;
	b=XTXLcMgu1tR6SuaMfYozVyKdgGL26v+98DvrGJ0c7tYvUNUkSygl+Ta7vQ4OpPipsgC6
	 dY/xP6fmR7cwUOnSUQi2dbTXYio2QvTtNubNWmGSfj6+aIX3U4tAjpV20SGgxHGiKx50x
	 CZrPw/2wa6fO1FJTiJjzSdCPZZY+BY2iYSs9nQD8qqd/2QuIPkwmdN+yQCNEpJ+059GYU
	 35nZOTEtpZSER8CqwNH+fwCi4akgrWI9IVlatHtNurqX8ElY+pOPHly/fVytrnW8I/M7B
	 bD6UzjENA3l5pVkW+40pnsSKXNbXPfey11s79xdFG81zpVpk5KvGN5KLn/bgY7cAAjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795385542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nk5bhBdYkMjObpcLtpuefZmB/qp/g4MKUxfSqkGbY0o=;
	b=nO9+Pvk0FM7cOlU9sEcExn29/EJQA+wss966L3TuA7MdICbkNVqIGir+Va2hK7Rorv80
	 fJoNPzhjQVevukz+iqbjgzn8HSqNI7H4XH0JY/uUxZPpM0jOW4Q7O99bofpLU3b/4rwQO
	 ZFXl37UhOfMcWI5wlKnrlrNOKNu1OYBmb2fMCgbiM+e5oa1I/qA/N8HRv/lQIUcMFDToj
	 U65H8wz5wu2iqz6GW2oR/V7cXzkDuP5eJ20DgCfh/Bhfe7eKRlQtu4U52kqWU87Yy7WuP
	 F07F6LOz++83XbEEZfZuAkwGylF4Zw5ibcwH66v7ebNpT/7ulkJ/FF0GNI3p4VPdlJg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=zMVchTLb;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=V8z2lYgP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795385542;
	bh=Nk5bhBdYkMjObpcLtpuefZmB/qp/g4MKUxfSqkGbY0o=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O/l40Ir8c9XTAKRaWzpMaUzt2oSFulidwDioTK0SsklcYspoOjkd0JrZZbETCrJEe
	 kggG5mdmtTmVnoF6aTE/DJNeOB8IpIoy9jOUG2J0RvAmEPwGYj/KjOUjtWCeh+98uI
	 9T2xNKBUMTHvmeH94uF1GHTCzW2jSx/G+KlMjabNpyvoBTSmiLnNzArbI2n45Z45Cy
	 seXgdchjCkd1xDsyhHezPsiC4VBA/xseBG5q1d06eQo50QV43QZayQcFWMfKQf5J/1
	 nEn4moGFBsc+JmJVKyfGD4Rvor3/n0RZZvg0Omip8XuEa6bae3+fI908F02bVZCUts
	 b+jeeH0zAdDKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15734405EE;
	Sun, 22 Nov 2026 22:12:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9886022B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95A85405EF
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsO7uCJMVAim for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 22:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 140A1405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.9;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=zMVchTLb; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=V8z2lYgP
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 140A1405E6
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:From:Reply-To:List-Unsubscribe;
 bh=Nk5bhBdYkMjObpcLtpuefZmB/qp/g4MKUxfSqkGbY0o=; b=zMVchTLbNZ2Ik8rBm96PdgK3hm
 DJEDCZN0pqhcP1sPVXqt1WWkH6pL2BQyJeu2zY+T6OIqQP1mOxWWfZNqFPkXHidkylFNEym2qLnA7
 +aZ9pbYuJ7by5aha76QpNSITRHBVafg6XSfr5QgORtpl/FltDo6AULyVcMlPgjpi5L8Q=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVFnD-0000000A08k-3XmV
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 22:12:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=Nk5bhBdYkMjObpcLtpuefZmB/qp/g4MKUxfSqkGbY0o=; b=V8z2lYgPAuMYAHetqjeQfs3fdx
 bgeejqkT9GX9Z6PuPjFDFQHsxr5MrY53NO4EkUWg7/orm+REfKZm3Stw/NEiIG7wkLPQuxkqacKa7
 20S3sTYlHBtXSZ0f6nbPfAbb/fVNQ7/3xkz22JVSG9GheCufbATfjopcko7+68GrwfVE=;
Received: from [79.28.115.6] (port=61029 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVFmu-000000004nS-01bz; Sun, 22 Nov 2026 22:11:56 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/2] Exclude TPS65219 drivers from SPL by default
Date: Sun, 22 Nov 2026 23:11:35 +0100
Message-Id: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g00UYfqVUoXdow2RcZhYkUQ7
 95pXb7F/zuYJBWDttghyaqmc8igSwH+1YVRUPts4Cs7ImZcLLqaqUGLE/o5DDoa9q6ispNb1bg
 SchqTDLr9t/fHafs83+KX3wuO4wvjaF6ceAAAAA==
X-Change-ID: 20261122-tsp65219-spl-configs-d6413ae84963
To: "Kumar, Udit" <u-kumar1@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=francesco@valla.it;
 h=from:subject:message-id; bh=6glyYGWQyF0e9lGmpDMw6gIYxnGGJzgZKLdbrt/jIqY=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMGQsbHDcl7zpuP8Pmq06D52/uHh951bKk2t/rpzbuM
 bpt0H+wo5SFQYyLQVZMkSVk3Y17e+aaf0vbwPgIZg4rE8gQBi5OAZjIjpWMDEtO1k2VLJsnH1bA
 8L58AUfv+8RSLuUr7wo0X00xyTwrcoHhn3HAP9v8I/u1Jl0ocmbiND5bp5Vx+N/moJNbFpRoftk
 UwwIA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: a4903abe7c577ae74275092abfd051ae
X-AntiAbuse: ID - a4903abe7c577ae74275092abfd051ae
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVFnD-0000000A08k-3XmV-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

this small patch series fixes a boot hang observed on the BeagleY-AI and
that also affects (at least theoretically, as I don't have one) the
PocketBeagle 2. The hang is a direct (albeit unwanted) consequence of
commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is
missing"), after which the "regulators" DT sub-node of the TPS65219 PMIC
became mandatory. All platforms that lack the bootph-all on such node but
have the driver built-in hang at SPL startup; if early debug is enabled,
the following message can be observed:

  spl_early_init() failed: -6

  resetting ...
  no sysreset
  ### ERROR ### Please RESET the board ###

Instead of adding the bootph-all tagsi to regulators, make the TPS65219
config options phase-dependant, with a (implicit) default to N for SPL.
Because these PMICs are fixed-function ones, there is no need to
manipulate them in SPL.

The second patch drops the aforementioned tags - no more required - for
the Beagleplay, which introduction was not accepted for the Linux kernel
[1].

Regards,
Francesco

[1] https://lore.kernel.org/all/04ef3762-86d5-4d61-93f4-202f0c120433@ti.com/

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (2):
      drivers: power: add SPL_ config options for TPS65219 and its regulators
      arm: dts: k3-am625-beagleplay: drop bootph-all tags for regulators

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 28 ----------------------------
 drivers/power/pmic/Kconfig                   |  7 +++++++
 drivers/power/pmic/Makefile                  |  2 +-
 drivers/power/regulator/Kconfig              |  9 +++++++++
 drivers/power/regulator/Makefile             |  2 +-
 5 files changed, 18 insertions(+), 30 deletions(-)
---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
change-id: 20261122-tsp65219-spl-configs-d6413ae84963

Best regards,
--  
Francesco Valla <francesco@valla.it>

