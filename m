Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8A606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sCRSG6Ld;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brXBcm1m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0840E812C3;
	Wed, 11 Nov 2026 09:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIYAZ5E2GnfH; Wed, 11 Nov 2026 09:46:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C5A3811B1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794390364;
	b=N9crYI0viiOmWb2tXPAKh2rJZraVqXrEsSarlwsScs6J5YD529FyUnvSBe1kYeCRIZbb
	 1baw/i21x3kG7q31X8C4Oqpy9kCelP4vYuJNKxrKLCbpoGXspFWhYoaeMxYYOIIlRQb2G
	 paB0lfQdMg6VXjsOqD5ayTmQgntd3Taq87e6EVo0UfF3bSDWVBSPktTVq3TAg5YA9Iip/
	 VevuYRxQ0lVFiqOWI3wPejhST9GotaQOH+NG5B+O9I2AdnzWM0nU/ewLQ0C0ufSHz13Vj
	 d8UNuyMp303QwuIwQzXlwhcRdfXslpxum0YJnQf8TmYCpCZnLOYx6jElKl/+rnPlOoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794390364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9jMYc1tjjmq+cpPP4HdGRErKdzcA9XY7JqfkwuRFhTE=;
	b=c8AkH5M+StGXgQ9ULuTJjsPOvrLrhv2USgOM/vPnkJ2pfUVnAJ0x5doMROBuoRXG4p0C
	 +INJgiUrDSi4PNRp2aJmEVbrjlYyLtWzNLLq0pQ2/RFmqmT4ef6IsF8EJe35Mdm/hVEB8
	 wCWjzaXQOrYsh4UpMbkXC8wKTMcYP/QCuRvkwHS9qdjsV872ohlh2EV8ecM/trUzyBPIh
	 /S+l0P9tZwQ+wbPPHkEd0TJccwLysfBnb6pm5BgWWH9Iexy/BUF8RYWCgt/atYjLfSs58
	 oBBBCzkfuJqgA8xcXG0vCaFL74SGUlxLIwTGc5nvWb8Rqcqpl8HYlTPI47+vfN4jcCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brXBcm1m;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794390364;
	bh=9jMYc1tjjmq+cpPP4HdGRErKdzcA9XY7JqfkwuRFhTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCRSG6LdhEf/xRwDSYW56EtN38GRCmSRTwSWiPiVaFph4MSYwLFT90B1tMNtic1Cj
	 7TB0zD7zaQT44tc/jTX1R/Bhtazn8Hi4VF+TtF79FCRahz0q9PV6dMkRemt0GnJhp1
	 7KbVqGprAZrjatx6lZGMNwr0IvSAqFIzd33ipTfUMoUUtZkFKIC4norWvIn14DP7lK
	 /NWDbeuoT6pXq5pY1ok0JQ0H9TA9hmHbCF7wHy3hJjGcpemviviIdQU5yIfmbnQQrw
	 B1dhY0CC0AaY/29GAh3KJx38GBApzjK5Q/lUMKgAvqeq/SutLMwjkX4vSYWKD0Md7X
	 8A0N4V2S4RKCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C5A3811B1;
	Wed, 11 Nov 2026 09:46:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC6F71A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE1A7811B1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KRr-g6aqUTZm for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:46:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E77A78111C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=brXBcm1m
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E77A78111C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:46:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8516455FA;
 Wed, 11 Nov 2026 09:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39BE1F00A05;
 Wed, 11 Nov 2026 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794390360;
 bh=9jMYc1tjjmq+cpPP4HdGRErKdzcA9XY7JqfkwuRFhTE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=brXBcm1m4MRMLDx7zxf44trY9K4fF+j5houLrVrYYCKvt4qQxoeD6NwYXgL0A/m+/
 vJoogWnBGpGhegERqLdY2iJys+nBAL5hErPNfJT8CGOH8S5fVnvL1441R0f5E0rrPf
 br3VhJROmwIWqjEXpk3eY9ChmYMTMSgRZBmFzbx4900djBmgGv3i3ck4KiM0Ftm4bF
 rX4SmqNwXvpskgidbFGxaLrnurmGrJxa19PXJGkVSI/aHii0K2z3O6elFJoUTH8pxm
 3+FKueiIcY3jwDqGNuZnmkGC9ns5vNLB54Pvkt9E05wevoSlyJE0S/7iq381QSwFWl
 W1CeoJgQsHaTQ==
From: Yixun Lan <dlan@kernel.org>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-spacemit@groups.io, Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v3 0/4] mmc: k1: multi-block SD reads in SPL and a probe
 failure fix
Date: Wed, 11 Nov 2026 09:45:47 +0000
Message-ID: <179439016604.2567679.2044939136511954679.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, 31 Oct 2026 14:54:48 -0700, Tanmay Kathpalia wrote:
> I am taking this series over from Dave (thanks, Dave).
> 
> Testing v2 2/3 on a Banana Pi BPI-F3 and a Milk-V Jupiter showed that
> multi-block SD reads in the SPL fail because the SD I/O rail (PMIC
> aldo1) is at 1.8 V: set_vdd_mmc() sets it, and without
> SPL_MMC_IO_VOLTAGE the MMC core never sets it back to 3.3 V. Patch 1
> lets the MMC core set the rail, patch 2 drops set_vdd_mmc(), patch 3
> is Dave's multi-block change, and patch 4 is Dave's probe error path
> fix, narrowed to the resets because, as Yixun pointed out, the clocks
> are reference counted.
> 
> [...]

Applied, thanks! Queued in SpacemiT custodian tree, for-main branch

[1/4] configs: k1: enable SPL_MMC_IO_VOLTAGE
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/cfc62cc2890b2795ba8d8e32e63892179a7cec0b
[2/4] spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/e07305ad26367d8128a66d7c5b4f21e6427df25d
[3/4] mmc: k1: let the SPL read SD cards more than one block at a time
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/f0c22effafb3a03f6c3aecb231dd729864497404
[4/4] mmc: k1: do not assert the shared AXI reset on probe failure
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/3e9ab282be08a120ffc681406e72deaa7798e453

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
