Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620E606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iNMz2NQg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EI1GRgZ9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A49081094;
	Fri,  6 Nov 2026 13:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqCs3VNv3men; Fri,  6 Nov 2026 13:48:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 885C4811AA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793972918;
	b=LoQSHfQMctTe7OzcivnD2/pBGs1DYTNtEf9Gni7JsUO+I2aWu05ff+ifNlvsRYbO60Dt
	 GOIp5N9YjsjAZAwCcsT/nD4E+G6by906ZKQufi0cK5trBjyDlV6UdLcpjUJdpvxHXzHso
	 0nM7qcjauKwzMDr8DWQEtwvuBrkS2yeR5znUamDKQo1WcQ5/m7Xs/ZicQluhjf0afHSPj
	 4srllPNqFfTMZGPVOSlps4JUd1KLCim/rpfH4z44x0UBJN1zG8RxC4vFMEiDFKwr80Q/b
	 lzL2lFLUCJhHjm7BgLcoqj290B3nEvrPRiylXyxn8ZBJi/SqJSzdcF9pDaMRrRyUxEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793972918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XlFntNhfN9dOCBrZrnAVh+haXJVRKmF1Jj2LJKj/ZMQ=;
	b=M7Tb2bAh0WV3B+9cQDEGzDVnEaxMWcn7ZiarZupYbDC1FV0u890C7/DjUpWwRwNJwjTr
	 aMJNdnkh0pNsyWTFAJfpFNCkioXl+78F1PM15x0HwjjS5w/EgJR8stvFoHj/gY5WjzjJL
	 CnIfTYIfPiI0OTGVu+W1B5fmNHQYxqtpyBKLkjK73W58wGdBxX8gFSKvsSlKNKiGbQ9xA
	 sBmDRr3lGyEm09CrVPUi0KUrANklL1bUmIBnrVQvJlIuQXqrgyaoxrEFTRcEfuC5kSHYB
	 CrimkRPQLwyLDzmje7Us4//glZR0gwUQpfYMZ4xFyCyAw8YvNogwgHz1VqHIrsOdYbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EI1GRgZ9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793972918;
	bh=XlFntNhfN9dOCBrZrnAVh+haXJVRKmF1Jj2LJKj/ZMQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNMz2NQgGxEFPbme1vGFVb6/GtdcVzkVxX7CQ5/80HnnnSisTnygIgwxOeATB4CDl
	 +HHYa6D6CYeeaTMJ7DHJUzTkHYf3LTEPHYXtuWvaQKW5FAZ8PBHg24nm/r1pTKeZCc
	 9WmUZutM9Jtc1leTWGDCS9WWoYzzBbV3EPHZdCNTRL2nYj3PubUKabrpQdEZ/13fVG
	 D/a28ltS+AeU5C2t/E3YrVqZAIWfsjQwqV9UBufkOchR8jeWLb3UmrmxZaVwRi/r+L
	 gRbsKWcgYqEt3vjveRnV05tbeON6VO7/pqjZlWsWz4lhG84TcbXv81B1ufE01EODcE
	 Rpl4JIZddqfGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 885C4811AA;
	Fri,  6 Nov 2026 13:48:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37A52362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D548811AA
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:48:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wq9bLsEDQ1qm for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:48:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DC6181094
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EI1GRgZ9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DC6181094
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:48:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7722B40726;
 Fri,  6 Nov 2026 13:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D974F1F0089F;
 Fri,  6 Nov 2026 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972915;
 bh=XlFntNhfN9dOCBrZrnAVh+haXJVRKmF1Jj2LJKj/ZMQ=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=EI1GRgZ9/q2aUa6dDz0hVE1Yfy1KzMs/gunUt/ZwKhuz1ITUbJcEnutTfA4L48+1C
 1LK2yUeHYKIlYVRvuDhS5tghK9r/RO8nqiqoKoBbc3tBseEFJNKuD89BhPZgEDwhDP
 ckOH0o8A8jBL1VTgDFt8yMUaocESIaT+dWtyA7GLjjaS8Hv1zO1DgfcxQdlUHgOXSR
 uuBJUWXW6c40qOMfv9Pfw6lrxZMGumIQ6W96AaPNFBgXjwAvxgt/0D/IHagNRaz54P
 ElpvWdUJmX2A4annsdn6/IBiuMSSz687W3Y3Bz5y2YBCKmXCcMyImNzqyy+iZ33Gx3
 fAYfnEucfGB+g==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] cmd: fastboot: default the buffer address to
 $fastboot_addr_r
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io, 
 E Shattow <e@freeshell.de>
In-Reply-To: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
References: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:48:31 +0100
Message-Id: <179397291101.1028119.696632246148374414.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=689;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=AFgfhEy9L6ASZFvwBZrI9BcP1VqooTrdoN6uZrVJ/HU=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7dqwDGOIet9/UJ6LNvXNlCstJgQu1rdqmsZ9F
 zVVrt7WdQmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3asAAKCRAZDR20Zk4Z
 NZw5B/9ValvFsMqHTp51LPbc4eu5KDDQBO871+EMBNedSj5/8vXIj00Lc1c3+aeMS+3T+N6hg7c
 IWyjf9cH/qoEaCnAKl64O24QhzsATd1+n3y/GHbzkfWNa3JdGekL3VdgC7tE7VRVoeFUAXX3awL
 NlIcKfaLSz6JqhssHnGmYmuXhP0cpOFnG2seTqHN+ATOVfmjErz0ZYjQaOGvJu5/mDM4iQ/tzxa
 EqoOscRmGZ2373XSpiLPfnEDZnjMHoRl2vfbEKznU83+zElbeQadcykukj+ow9v47YIYlzpCMmL
 244QIgHkSNH7pCmYQADWaQpiKNG7Nw4PTytxQ9bneysNhhP3
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 23:08:00 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The fastboot command downloads to CONFIG_FASTBOOT_BUF_ADDR unless -l is
> given. Platforms that only know a usable address at run time leave that
> at 0 and put the address in the fastboot_addr_r environment variable:
> mach-snapdragon allocates the buffer from free memory, and so does the
> Samsung exynos-mobile board. Their environments wrap the command in
> "fastboot -l $fastboot_addr_r usb 0", but a plain "fastboot usb 0"
> still downloads to address 0.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
