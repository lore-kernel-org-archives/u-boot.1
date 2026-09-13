Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E769C88E63
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 18:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D732405AB;
	Sun, 13 Sep 2026 18:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id viIHook_KO9N; Sun, 13 Sep 2026 18:49:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9AB93405A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789325350;
	b=o6B4uiaNMM6JB+n5mjISYEejay2n8DGtA7OnZqgHVVX38/oG06JQKMS8wH51h41B67gh
	 /Bu74TQFwfULv0eduFjwYfv+T0/AOJhB+C915QErUBiTcClVhTT4+ww7/GgDdNNy0PLdt
	 OWObyC8UxTmiS7VkPxc2mUxTNbBY3fBwgXIOikYLiAcNZmO1QMKjN0vOSvnN6oGuzJxOO
	 puls5Lsz1Gt8WYjlvfvGzhvOCWNT7DsFURBNSKwHg4XWETyXT4eIrZFNQjloishDc6y0j
	 uNooPvG1Li45V+8mdglSdOl5nFkB24HcvwRMe75L35x9C5wTfEdbR2M43//g7A9QExA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789325350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tRJxxqFtXNmVdJDRC/n+bnljh6bEu+c1sFy84gmSTno=;
	b=EkBAv2r7lwArpafC3PsWOSUzVI+xvc4D2HjYMNxOeLeeEu/Iz1y+WoLYVMINSDLIM1jw
	 PDD1pPn41Q2E7KcYZTDNz6OJ+PbmpUwlPxBsxkftCSeCtM8VrtrSC6u2r2tCW2Ccuf2LW
	 KKUya9D8gisLQeBdQeQubgbYI7Eo/ecoxL6UxErdBCGRyDRlM/ag7VblvtVSI+RkyDhL0
	 POfkFwwE3n7ICGBq3O8SulAmZcTlr9M0v374AxWf0J93dxchGJRaSiJxFp3m4TzEUUCmF
	 aPO6iplPKlVJu20yV1C6xFqsgUzniFkYsJQ7UbWQ4RGAAyDOarweKE7UkEkRrpb+u5A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789325350;
	bh=tRJxxqFtXNmVdJDRC/n+bnljh6bEu+c1sFy84gmSTno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TP41xoItrTXhgyeCWH5HJc11OuZ107Qs7vl8+LyhMbfA+EFXFu6yT+yK+6umupHfd
	 wD+mqQ/6n6jfK3B+b76J5xZQVUPKVOesnraCre4pPEEiVzMH5XZIItfDUa1RTwRNN6
	 VieKsbTFiRgwUvqiaDapzEdOufS1PraDNeDJZ1sNzWU0PrNNf3vuDV8tpI2dqwVrrV
	 sZQgRyQ93KY2aOQCG1IbEe/iGmq+qyL4Y45PK8nXiowVmFei+dS6YZP8ZQBdfQvCbV
	 ZZBB2pxM9n1F4uMVXoTuCEEq13OfpqyB64TRBja1G+lYCdoAM8mYigkNvwhXy/cCqq
	 PmHdj4ZwfLGwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AB93405A4;
	Sun, 13 Sep 2026 18:49:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5252E24D
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 18:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F75F605F3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 18:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brFhK7iGPqUp for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 18:49:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C4CD605CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789325347;
 b=V6FwpH1n6CePlcJMG1nH26zQTH9Ke4YV/bQJfh6+B2IhV01anxuLhIAGMKuznOh/nFFY
 IT22csBYYO64mSYIl+VpwFiSU2R3NZbBlqylmiZQt/Z6koyaE8Janeos3WexnqnfBu7ph
 PpsC7dyVnn3ugHLEZmUH7UTtiRjig0khCE717kFoEMPl3mkKeqE/815fr1OGSSYSFQ6ns
 Usyg2PKYKB5A4JZCiKmJvBhYRDhi5IGUk70di67rlbnfmUPEVxaLkQfc3iZcv0n2toK/r
 Mh8+3fFam3+m3XeFrZ6Aa6XpPI3YFV3w8UMYaSCTdTKOaYEmNnbpbBjCgHHF90sHAFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789325347;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=tRJxxqFtXNmVdJDRC/n+bnljh6bEu+c1sFy84gmSTno=;
 b=b+hUoamcUIi6xEbuZh0jHjF8bBdYjJQxjl5ye+rFWRNpqZy9N2e61ePcoKLxU06lFMfE
 0Vk3/XPFU/Xotd3XHnur9UDPzS+6VCuReitQb4EdZ0JbGsrRpNL2Y2DnbW8PnKc4gkTaF
 q8Ov4clPd3IoOdw7HUxdRE7gVfTQRlfGde/p+NBQ1E9tx0GBAX/pIRSHnnZL79Uacq7uv
 7f2MT719GBTGbcMk+/krLRfQDAcPuOLGkZTBNqzm9IQt1Md9WVR/hLWyBtTm4RR2UfyZN
 L2WUwgDfaiTPOPm0ums6urvACQwUK26Zuw+r4AQ+rucjPByY8ixuMb5LdEPazlk030Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=MNXc+AqO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=MNXc+AqO
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C4CD605CE
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 18:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789325333; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cnfZXo5I6rs38Zi2kTgJltnm8Qfa8D2wSzGpgILgg4pC3vIlRdSIK3EXAmjk9Hlk0HqQMoFVrAYctGgQguKFbkRgaTDTEmFoqlBmHDukPN9Dno4NaJZvdOMThILXzSzgCPATLLmQNWQDR70dHVEWuZl31EWnQw9Tspr4oauUyyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789325333;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tRJxxqFtXNmVdJDRC/n+bnljh6bEu+c1sFy84gmSTno=; 
 b=JOyYc+cELpGv5Xk4NEofJeSu4+R28jdKEnUHRlDS2wDnnOJeM+XDKB6KbxZKa5uPktieDy6qDagx2+3Mkui1zuwHlUUFl/TT/B0jc55h8m+r4frgp05PYTNiVd+rzV5hkfQQetbXtgaqvSOfdXtTnWp/OqiRMr7AWYWMBU6SJS8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789325333; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=tRJxxqFtXNmVdJDRC/n+bnljh6bEu+c1sFy84gmSTno=;
 b=MNXc+AqOf3v744r76fcvGhaQGVi4hlIbUVqham3EfiKHoWTbb2dQ3luM6TzSNfrt
 QW2fyzFC9Vl9iHCCThwBrlOSPFUtMb4l3gDAXQctBkYFrGQvhzWmQoC6cElZFpSu21l
 hD3ipHXJ6g5TSEtADfJEsbyhkUkAXlz5FmKlOBug=
Received: by mx.zohomail.com with SMTPS id 1789325331946561.8356656380412;
 Sun, 13 Sep 2026 11:48:51 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:48:28 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v5 0/2] riscv: timer: Fix M-mode early timer support
Message-ID: <aqbv_KSwVDmn3z46@pie>
References: <20260911-riscv_fix_early_timer_mmode-v5-0-98e7aaf91396@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-riscv_fix_early_timer_mmode-v5-0-98e7aaf91396@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.312.11
X-ZohoMailClient: External
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

On Fri, Sep 11, 2026 at 04:35:22PM +0300, Nikita Shubin wrote:
> This series addresses two issues with the generic RISC-V timer driver.
> 
> Patch 1 marks timer_early_get_rate() and timer_early_get_count() as __weak
> to prevent link conflicts with other drivers (e.g., ACLINT MTIMER) that may
> also provide their own implementation.
> 
> Patch 2 adds proper M‑mode support: timer_early_get_rate() is now defined
> for M‑mode using RISCV_MMODE_TIMER_FREQ, and timer_early_get_count() is
> no longer guarded by RISCV_SMODE, making it available whenever
> CONFIG_TIMER_EARLY is enabled. This is necessary because functions like
> net_random_ethaddr() rely on get_ticks() which uses timer_early_get_count().

For the whole series,

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks for your work!

Regards,
Yao Zi

> ---
> Nikita Shubin (2):
>       riscv: timer: Make RISCV_TIMER definitions weak
>       riscv: timer: Enable early timer for M‑mode
> 
>  drivers/timer/Kconfig       |  9 +++++++--
>  drivers/timer/riscv_timer.c | 16 +++++++++++-----
>  2 files changed, 18 insertions(+), 7 deletions(-)
> ---
> base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> change-id: 20260904-riscv_fix_early_timer_mmode-174f3ee4e106
> 
> Best regards,
> -- 
> Nikita Shubin
> 
