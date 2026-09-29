Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1EACA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 09:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5278680D6A;
	Tue, 29 Sep 2026 09:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkjJtvwpFVh5; Tue, 29 Sep 2026 09:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B2D1480CC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790675016;
	b=q/Sql+CI+uenrPdagZm7b3H1fVl/+cI5Y/soZ6W4SuiGak0VJ+uh2n21JW2KmEriS5xJ
	 9XoSAyiJuxWiIYbJiQM0vnnTvuGsq/JpTb4dvhonhQHzwnaAS1kaE1xOVcCYPjJItDCpT
	 Y2/W0joez0mM4igO7ribYhgvjf/jyNKaEqvQuj17MxIQNJkEnSYEiMCOph+SSCoFK9zhx
	 yhKQfPFNXFpxFwMJHdyniUlhGpBqgoq8YvNehelk0Vi6Rgx0KKwMVmRC01DLsRzA+kvDH
	 dMHkk3QPTvzbjDlRBZd6N3aEQaFnEClR7wyq4HOMF6Jf3Le2uq7sWHlnkMS4RPKY+yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790675016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3jqMhJXehUfpMx0Td0dTbSCIr9T1WkAUx24g/yyWzCI=;
	b=A8m06lBspUYbHrR49hMPDrc63BCNaDONpr6O+5ro7R5+OdX51lCSDOslRQ4AXnVxCR5f
	 cU0Cji2sooK1m+qkCEOCx/TbLp2ydTMzyBULP7nJKpaZ7+FEVjnlvuAV3uBvMMDmCWOwu
	 4yHk9VlErgpi1gEp4+BxT4oJFQlNiSzld1DOtPMCT4kKCTCgAaKxBhXZ7OvmDpHmlvcRV
	 joG62M8NpebzsO5Cqc35iI8k9Nk6emWO9o70ewBQBfgj/46RklxOH1SruyaTNZFJXDk5t
	 BkdwqWjOQVO2CHm/rIo2bfdM0D3tWb/Meqn9inpYuOh2/ZUcazEcNwCobCCNHAp+cMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790675016;
	bh=3jqMhJXehUfpMx0Td0dTbSCIr9T1WkAUx24g/yyWzCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nbqb/9rE/r4Ud/VY4Fg9S9X783YHLHYh+nmq7N6D3bk5OGTKq/f7Q8EatbXNgTwtl
	 4dxyCePOv7xZDi3ywD+R3n7jh1QvM9zpP/dZjg4IOqi5yzViyMHwbYM70mtvdrRydT
	 Xm0bYHyWEbXlJgbMGPNaBiezMgMlcoDJSd0KvIw9EccVOixMDy6huD2XxCjh/zsDa7
	 sHjaWmsAPEEDKwJKB2R1BJvDQsDZGU6jy4B9UYOdRR+ruA5imgys/B9GIDKH5jXJv6
	 7dNjHDizgNoK4YUEzhWYaAyjcrTSt77JPhf/jh24MyY1kpBnwxAZaXy5jNYM6p4RgQ
	 4U8W/eyE6nE9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2D1480CC4;
	Tue, 29 Sep 2026 09:43:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5769CD1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CD7E4027A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CeQq9gFNIHMt for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 09:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 813DA400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790675013;
 b=UzJMm6C1wh0/in9o0uDfCUdPezSitGHhfevGTxgbZ+3fgN97hnNj/UNZfDHTRHCFVyBo
 okCJkJeFGuEW0uWR2iPjUzKVTPZFwTY7sihlixNyYM/d4zv+1SbMAR96/lzVRED5ohhBl
 o6MdO+eCtOPfbapOHtDe2P07AsiJCKG9eT6hSanYnLBj//9YzGEgcgWORiqxa9/xuyWdw
 +yW1qMWY2iQfPaRfWKI0Hqng27Xr1++f7bl0Wv7Gh683QnLAC6nyGGsXll51+n+VRcx73
 +rx3v5JMKuJWSumeZFprtdnvRRujVidcR9+jNdRfDjd0LoSDhYWlRgWn+MaTKkfcnzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790675013;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=3jqMhJXehUfpMx0Td0dTbSCIr9T1WkAUx24g/yyWzCI=;
 b=p0JI74JuhQONXvCV7FcRQu2vpGKfYb1dsspbv3yaDLYv0lOFyAZoc55ldSzUC1aMO8Zq
 NoFfY5vCPU0fSdJuf8XiEt9LQRi9sJcJZ4KjVZ5pX/9VIFSRdX7QGJf5Cu91FqCjO4Sq9
 mwL9jTTomtvF4gG9jHvi+i5WD+XSAb2XI3hEBKWLef5fO3p+jq3m7I2I38jKq6DJbytvP
 rqUFpdR5rnL/PgvIvKPVvo3iy9LLkRTcWZiSOSj2WIrbkde3hCv1yV9ueu94XPwH+UCO2
 VBl4a4dRKE4G/CSHmKB/nV+8Uwqo76IHrb41SiK0TsBgv9To2lNOI7aVCikty/NEVYA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=oILu27BC; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=oILu27BC
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 813DA400A2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790675004;
 bh=3jqMhJXehUfpMx0Td0dTbSCIr9T1WkAUx24g/yyWzCI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oILu27BCKyZDBXp8K8TZZOVmV3ZkOoTcmL3EQMFqGu61pJbdOdg2dNjopzZyOvrIj
 1NLm/BIFVkNU3d40g702LPRKM7b7KFZyWQv5OR1/yCUUI+Gp30Zvh+TyLH/HvswkPL
 pUuINF5jpWBa5LVWnVuKVVhSDAKjB/dEeI6jaertz0MLRit+TIs4ku4k8722Pg/9yG
 OnVgN3kc6TQ/SQpjYAus09PXkEZgkI2ZZEAB4chA9yUWOVfddHNr+W3HlWRA7P1PLl
 NOu3KIo/HbtVMzU4IsELzMB9i4REZqVQGzMeW8n0xp80OernywFQJDzyxMKZqw2I4J
 AlzrqbEzfqi0g==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0AE36B220251;
 Tue, 29 Sep 2026 11:43:22 +0200 (CEST)
Message-ID: <e97b4f04-6cb3-4dcb-844b-ae49c72ecb7e@freeshell.de>
Date: Tue, 29 Sep 2026 02:43:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2026.10-rc5 released
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260921221325.GF858934@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260921221325.GF858934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tom, I found a regression going back to sometime after v2026.04,

On 9/21/26 15:13, Tom Rini wrote:
> Hey all,
> 
> Once again  it's release day and I have tagged and pushed things out.
> 
> Things seem to be working well on our new infrastructure but if anyone
> has found issues please bring them up.
> 
> I believe overall things are looking on track for the v2026.10 release
> itself, and things are moving along in the next branch at the moment.
> 
> So, the git tag has been pushed to
> https://git.u-boot-project.org/u-boot/u-boot and the release itself is
> also under https://git.u-boot-project.org/u-boot/u-boot/-/releases/
> 
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=Z2IwbHR2NjZhMzZkOThqNHJoc2sxZG04MzJfMjAyNjA3MjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com&scp=ALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/jwj-pqka-bnj
> September 22nd, 2026. 9am (GMT -06:00)
> 
> To join by phone:
> Or dial: (US) +1 929-277-5781 PIN: 115 674 167
> More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=2145803234090
> 
> In terms of a rough changelog:
> - Platform updates for Renesas R-Carand STM32
> - Fixes in our NVMe, PCI, networking and DFU subsystems / drivers.
> - A few other assorted bug fixes / hardenings.
> 
> We should have one final rc release in two week, prior to the final
> release on 05 October 2026.
> 
> Thanks all!
> 

U-Boot fails to boot EFI/BOOT/BOOTRISCV64.EFI from EFI System Partition
of USB storage on Pine64 Star64 board. Config is
starfive_visionfive2_defconfig and OPENSBI= path is to compiled OpenSBI
v1.9 'PLATFORM=generic' fw_dynamic.bin

-E
