Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727FD606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cFkIMgq5;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=al6mrmmK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FFB040A3E;
	Tue, 10 Nov 2026 22:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3CKwERfKRFX0; Tue, 10 Nov 2026 22:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8572440A2E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794350894;
	b=XHbpSVKc5fyf4/yP7GGjMtArQyiGhIvzQEpQ2KGCF1PtQEdUJEMCLHQRQcX8NdJWtV2+
	 2nPL5HCes8bz20NPR82xodg6KvTnR00r/9n9FUEvv5N80yD2qXWKQhmsF5CfhN8eBZ/h5
	 wr+cAz/FlwytyQSX1U4Hf/SOGEfB0qyj9aZcjvhFRquk+tpIWs/MpZZoux3bkHz5faXmy
	 WLDLgeSq0UJ/LG2K/SxGL0Tq0BIxFX77lfVLJnsS/iI/hpUrTINzMUdn6KOnAs12M3FGl
	 hygaRvv9W1T0Z6nbduYkIScTyf5E0p8aEMI4GKTM0Z93HTE1JYJFc2PuC1XgHoVWKPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794350894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pUnL52DF2dGLw96Tfdf8uaqoqspVVESteyYm/iNrc8A=;
	b=Z+Ri+FJVvJVn54dSx+OoLmXDT/PrgrAuG9ZF8wF0Sxj840Fcq3tLcGMShJ+Uilo1PSIo
	 hKGvxnNoVg5o5iPRkg7/bFQGu4nHnuy3X7Rsh1SCEMmUev/0xc9+auS2tdYL9BbFllNBq
	 LCxFpJIW8vhhY0/mUhOPpZk/eqW12Yq7OeOXysn0xs5YnsU4piLvOUe7V3b3Ko92XXonB
	 ym7gi3Qcx7ueKOZyXsHyUyxDk6qlHYiihrYW7slVy85Dr6XvS4zBf6eeva5i6kSgh1I5P
	 NIo9xM/XFoZnoURgD3n97pnkj9/FL5LIHrxc1OTDKFITOqQLLuUQpDY6Xfr43TFYB7Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794350894;
	bh=pUnL52DF2dGLw96Tfdf8uaqoqspVVESteyYm/iNrc8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFkIMgq5SdFGmVYUK5tgxllA4MZAHijRB4ukKGq0LxUpuskFd5avSdtmOXMPvE9OB
	 OHsekl8PUlc9Egwka99Jq9H1t1PIIaJM6TiHLZEmKabsNMvR4JOlOzVvBZrFRweYfS
	 k7CAasH3c56wu1pK821wry1L5wzrgUbk5bpIYfZgFx4bgk8HnS1DiKe+x9tKsSEMMO
	 OeBH6FrM9nM806puhcnHRlQjE/Z4a8fNnS5Zk3Qg20PL4Lx3jvoS/ty4mrxsLF7pTO
	 ImBe43T5SSZc2Ly3oto2Ln2v7TYn9yVeidU4RN56u89sytaD21I7Hg8Gn7XPXVWluv
	 vqDB6Zw7l5d8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8572440A2E;
	Tue, 10 Nov 2026 22:48:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E51FF731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2A404041F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yZOA7fHK4Fe for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 22:48:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7283840336
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=al6mrmmK
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7283840336
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:48:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6799C10DCF7; Tue, 10 Nov 2026 23:48:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794350883;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pUnL52DF2dGLw96Tfdf8uaqoqspVVESteyYm/iNrc8A=;
 b=al6mrmmKfqxY2bLnW5SB8jwP3DzfvvyiSR0VnCiEvggEVkDrT6Hy9b+X7Gyedoe2fXUBAz
 CrKxEZH7kUNEBk3fd/l6KAaOxkHwTdIJmxDjY3iqzX0HP0nYDwuFrQSNADfPeKNzFr7L9R
 TbAcd/00Ss83G9AxjEImhX+Qj4+uIoUunoH6plkLeHDDOIk5tjIFhqhIKN3eui03Qd6dMh
 oJOHWvju3s5gJElEoRX4YA5QDpIikHuFTk+b1/B9IMySf4reIzzCW7gq/oetlfQzdno9ej
 zOF+1beIyBj3/hGT4ZUORu2ZVBdd9KWgg7ImLpVj2in9DV5TK1WdEHKqBKusiQ==
Message-ID: <373e3ff7-ec93-49b7-9bc4-64672ffd3420@nabladev.com>
Date: Tue, 10 Nov 2026 23:48:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx: Switch Data Modul i.MX8M eDM SBC to
 OF_UPSTREAM
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260902163748.1003274-1-marex@nabladev.com>
 <a6365f6f-b87c-4d6a-8be3-c315931bf36b@nabladev.com>
 <CAOMZO5B=PRD-miBT8HASshW5FaStdVGXDx9Vxbnw19z9Afwzjg@mail.gmail.com>
 <CAOMZO5Aff7dXwXjRr7Tk7JwsjXcJ_UVvAOeas6tKMcJnbf4VTQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAOMZO5Aff7dXwXjRr7Tk7JwsjXcJ_UVvAOeas6tKMcJnbf4VTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 7:30 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Mon, Nov 9, 2026 at 11:09 PM Fabio Estevam <festevam@gmail.com> wrote:
> 
>> It will be part of my next pull request to Tom.
>>
>> Sorry about that.
> 
> This patch does not pass in CI:
> 
> $ ./scripts/check_maintainers_files.sh
> error: board/data_modul/imx8mm_edm_sbc/MAINTAINERS references
> non-existing file: arch/arm/dts/imx8mm-data-modul-edm-sbc.dts
> error: board/data_modul/imx8mp_edm_sbc/MAINTAINERS references
> non-existing file: arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
> Cleaning up project directory and file based variables
> 00:00
> ERROR: Job failed: exit code 1
> 
> I'll fix it locally by removing these two lines.

Thank you
