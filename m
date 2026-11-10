Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A2606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nfCANLY/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCoL3qHa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D0B160836;
	Tue, 10 Nov 2026 10:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uljGchC7UPbg; Tue, 10 Nov 2026 10:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 94AC760642
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794306751;
	b=RGz0FsZdJeHx3iPnuiYOrE31L9kMOO+5yGs0ECciLaOwPvWHbnhyE6iVF11yFw+PyGrv
	 WVlzSpQhFK/I6G7njY8rpPiILrPxQqzjEa8Ysydnstn318fXz1GBu/27zTqNJLFk+RG1G
	 ie8If9UzTYXISoUOWx6tTh6YL7Se8XyFjS7UzKx4dXoNRMDstPYblC9FB/dtnx8Os6Ab4
	 3oiADkskvElBR4WeFOss0+j81bMtTBSC0HO2jaUvzX2tDP2dEtj/4juS+UbNPAsLoRYoL
	 bZLE6F/uXfHv8O4mtlgihH4zFyVIAjkOa27FplCWJpuXYbqnaZ/uG3aZ6nzc+9a8Ppg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794306751;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KL1KAjSDpBb+ZGNGo5hkGHJbHfTS/kuuwsaeZBwuJnM=;
	b=simqnz7XG/tYvTR53EZrJDlJO/Ieu3VlCo+WbvKPU2Q/tqYfnavSOnySbgCcyWL7wAn/
	 lAHbcKceRXTE8ozBFOFtNNsYQ2BgsjtbXXR4A7MPHzdO0912g/CD4bMFuimiPvsScKAVA
	 F32hba3hy7vh8txetnEU1IaPE6Vgm44A0jRUDNxGejXw3PfHEYtEtUBAttqjzvbAFUX0/
	 EB1auOzxRRa0TZlad7igIAikZwun9Jn3nZv+POUftsiaXaebgkUppChGlSXYcb59vcP+3
	 5RGJvNptYtrqWqNiXp0KS2mGEtDNAVZR1iCvQH6nGCDBqdwUBnituChF8KxUoz5Oa3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794306751;
	bh=KL1KAjSDpBb+ZGNGo5hkGHJbHfTS/kuuwsaeZBwuJnM=;
	h=From:To:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfCANLY/vn30qeh7mKSP6mOjw+5+HwocRlaxcSIj4ad3WFOacWM6Y804Ea2ygyAQk
	 SpVcuueGqGu0Ai97fgZfEJtGLuiSMN1MwQj2qMR3hQg/rH3sHRZYXUKzyw5yzkH7ZN
	 MIXzhn4UXkCy9C2Q5i9zVnoCexaen7YbfDAE1KTwmcFS/gRdlIIREASFE0IhQv0p4I
	 sHaDSBQc4UA/+sx3BLWP1w0iRbnrkaQayC9XHk7AV7dPtB9LS/b7RjXwq0PVxofCvn
	 av1p4TLZMj5HxoA/kna9CHy3GXTyVw5s9l+eSueH7Ls6NKH+5lUrDo236R9kPCSYQ5
	 vvizl/pX7io9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94AC760642;
	Tue, 10 Nov 2026 10:32:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C918C2FE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BADBE80D2B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHTG3lwnJRUY for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 10:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C268A80D29
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gCoL3qHa
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C268A80D29
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:32:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 856C0417B1;
 Tue, 10 Nov 2026 10:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BB21F0089F;
 Tue, 10 Nov 2026 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794306747;
 bh=KL1KAjSDpBb+ZGNGo5hkGHJbHfTS/kuuwsaeZBwuJnM=;
 h=From:To:Subject:In-Reply-To:References:Date;
 b=gCoL3qHaF4pbVDZFK/9/1V49X34Gpn9Fsshl/rJ2C9XNRP+1XwWHjY7vIhWj5iORB
 4jt7HDlggeE9h2l1xG2mpnvyJOsAfD+whRfDXRIpHtSyyKr6t72PYaMR0BlkYpj8/U
 FSjXxh8Njj+a4qMubuLo0+DeHWfz4aH1nEljJnmCancuOKZWt4bTuYJ4ncXTuUtPkb
 ad5dO5T5nrX69pf/NxYLXfr394SAruBrP5ppFpUdP4JPXK6YJoignkSsMlxFRrCmKq
 YpVQ+0uZd9A338gX9YF5SY6iNuCis5Kue8RzhW4xQjyX6viQBKzZ2Ums8XDiX/n58z
 ykXSVszVOd8Xg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [RFH] Writing a project Code of Conduct
In-Reply-To: <20261103172036.GS3309461@bill-the-cat>
References: <20261103172036.GS3309461@bill-the-cat>
Date: Tue, 10 Nov 2026 11:32:25 +0100
Message-ID: <xhkdbcxsdvux2.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Tue, Nov 03, 2026 at 11:20, Tom Rini <trini@konsulko.com> wrote:

> Hey all,
>
> Getting back on track with project administrative tasks, one thing I
> have talked about the project needing for some time is a code of
> conduct. In my mind, the best starting point here is, are there code of
> conducts in other projects that people use and they feel would be a good
> example for us to adopt? Thanks!

Have you considered the Contributor Covenant Code of Conduct?
That's the one Linux uses, see:
https://docs.kernel.org/process/code-of-conduct.html

>
> -- 
> Tom
