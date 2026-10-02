Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1792CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 09:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D96D681167;
	Fri,  2 Oct 2026 09:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6s3RgH6ycndB; Fri,  2 Oct 2026 09:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 211068116C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790934109;
	b=jDYz57bN/DGEKu4OdRm/TtE4B9f1v/Tu9mf1Qg4V8SIwsJ8YdUjatJHGrMDjkBmhb4vq
	 gYTq+6d0dZwEXI5zJmAV2iHHzzAAKTxMAEI0FZ4QpRoGAow/0GVqwknYuiZY4sajOIMPr
	 RSaHJYtaN7t7CQOYgRgn5pUoKrzH0JkVsRVUh2s2rhe63UDeEPxZ+4T6TNDlsCfSB4Wua
	 rBygRehi9pAuuZJeBTRW7El3NWQBHzeI9JgHzL+laXsvKP7JrReBhPb2Jnz1oUR2tn8Do
	 y5/mHfHBMBMMcw8qrgfBxEydqBJTWYvl0hvFDz2/404hkU/a73dkJjpQI+RtgFU5LLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790934109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z0gIa65QH/DpTy9w2irHAMgQGUaey/pgHtAVAWUWHeI=;
	b=i7nAuxl+ZkBsVBWRM65WQpy+Gcp8JX8IacsgpJUNPHZaxAUPHH+J1E+TDO/vx3kWy65E
	 gVMZ9zUrmOT4yqrlfEtvtR+5NsHCZt/+SHx8piBLqe0xTFyckVos+93XAyvc5IAnL/QB7
	 quZC+aeQhNwBJM/vNwtlIMhTk8TUtZTofF/SKYm2rMlN/+NEMuxw14fBGoYgUJPQe3u0S
	 piDsokq14RS6FIZig5IFoaWCak5uiC770KoF9BAAvGIrcWhmzos5UXeeLkXes3MSGeJqD
	 1hTI5dQZ0QW5UBmlGQ9lnHUiL5gJgt/1LHLp3LfkZIopDFELVI7SFDdi7sR9O5z6C7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790934109;
	bh=z0gIa65QH/DpTy9w2irHAMgQGUaey/pgHtAVAWUWHeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KnObW3enTFLszwKI261pbsCXWFwIf11Efk2IsP0kux81VnM3KG5Mg+PqmcCOelQQQ
	 vYNaIrcxNbtaGeTngNPzt7RSPw5vmBAJd6gi/uRhJ8eOdsRLDUmOkM6yDNAVk6/XZT
	 wjNzZegmTsxxLv8lEvFUv+M3vwbBtSg80ShxTSDWhJvS1xwkkDBGcqDDdzVXgVj5xF
	 mitmi8nCaQnWkKYNd3mWhThLQ2Sh06lC9MrjB4VFyaYAVkKjuiOFCRta7JMbRND5Jo
	 dYNQ/C/dwPgwtq5pYMKYo9OYZsskWAEq0VsGtsz8G8y8nDq5R+Y8TYKWF34NcICvnQ
	 WBz5/OE8Tfd1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 211068116C;
	Fri,  2 Oct 2026 09:41:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 698EF34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 500AD400B3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFQKgeVbbSQB for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 09:41:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DAEF84004A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790934105;
 b=G1KS5Sjv1mRAPX4BKJFZh4DZEQabMFVwT73c8XUE4CPc/4yqZHeOe1iutK070iNjVfVM
 YHwb1BGt70OICwZbThaG+Qwgb46gJQ+RF9vEM+UdOmEY+a6v70ThJMQM1bg2xW+/baVGD
 t8rXjLab2vDyAUgnDzr0bSyXMqV3EzZcQAeS2k14nspbyQhAWztXGKm4rcyos8mGEqp8A
 ddkZn02TrrpS/uxy3+JpbNkDr1tB9TFGu9MnIfEzHeCqO4x7+a5ftQCHd/CgrkOj02fpO
 gbhB4suO5COIHvxrqtn/K5suUwxDSt7MO6n++ZCNbYnMq/H3MNSSSFkWEXPNxfJGiJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790934105;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=z0gIa65QH/DpTy9w2irHAMgQGUaey/pgHtAVAWUWHeI=;
 b=QkLrvIr2cvJ8/VYDsP2s2+vZLI195eFCE//8bn8/4SpWSAA9tj3Gd0ZqycbUOfywgY7W
 auP6FeiS0PfKMbjDGbhd0DXVbt1780HjVl4pNjNIOcJRJYVrsHSUa1tN6isDC/HB+K91Q
 ysihj1E7yeW6pLlmM6Xqgf5FFUr38UQ3ejd3uYETl4YbTmDTZoxLTPqGSaz4Hwei7xUI1
 dMUXp4HaqbVWkjZ3Pat4zFgFy6rsJOWYE8IjZBoYgpv5vIRY+jPTPvb8YlJAIrYkxs2Ri
 dV6uwoFwwD7OelCq9xf2v3ZmZxy7CK2WOqgSD7DeKc5c2IQ6k1ZLqVUzqm2DFs67l8w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="ko444e/S"; 
 arc=none smtp.remote-ip=80.241.56.151
X-Greylist: delayed 583 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 09:41:44 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ko444e/S
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAEF84004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 09:41:44 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hx3TD3kYRz8vFf;
 Fri, 02 Oct 2026 11:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790933520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0gIa65QH/DpTy9w2irHAMgQGUaey/pgHtAVAWUWHeI=;
 b=ko444e/S5KDSz++awFwBl5M3Zt5RLlvN9mDSZ3KiMC1xNHZDv0a/dskY3Iu42Ffc+zlzRH
 bE46qhqTMAMf9j4MBzkSldJ/Oc0BRvYnm/yLbBz1SrVBzOuXUFnQM5U8AbGFQhOQlUZeXa
 IHR+Pmi8TuLBpJiwqAenw0kgfjhY4VDJ0Fq6FeC0lJToe/p9jZA99oFdZwebg/UK5okxA8
 sCe9RpB0twSQypEGw+C2ZNef+NwQBcXrjMM6CzBrg4HfvapuoiBpYAyMi/Vm+hExheJxW9
 H3MhgiVcvCrNM+OFkusbgWBMvfpLZn8K6eVc2MWT0DI/vBH65pAU2OX7n1mLPA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: u-boot@lists.u-boot-project.org,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 2/2] board: qemu: arm/riscv: Probe watchdogs late
Date: Fri,  2 Oct 2026 11:31:54 +0200
Message-ID: <20261002093156.2238815-3-stefan.roese@mailbox.org>
In-Reply-To: <d25423772d51278dae4631f4f22923bfed1f8bdb.1788526864.git.jan.kiszka@siemens.com>
References: <cover.1788526864.git.jan.kiszka@siemens.com>
 <d25423772d51278dae4631f4f22923bfed1f8bdb.1788526864.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: prisg4opw899qpymi56f6ynimmrdzpch
X-MBO-RS-ID: 84e7f650bcb92689ffe
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

Hi Jan,

On 04.09.26 15:01, Jan Kiszka wrote:
> +	/* watchdog may come via PCI but was probed too early */
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();

initr_watchdog() walks all WDT devices again, not only the new PCI
one. A watchdog that was already started in the first pass gets
wdt_start() a second time, and with SYSRESET_WATCHDOG_AUTO
sysreset_register_wdt() binds a second wdt_reboot device for it.

On qemu virt there is no other watchdog today, so this is harmless
right now. But I'd rather not rely on that. Either skip devices that
are already running in init_watchdog_dev(), or only handle the
i6300esb here.

Thanks,
Stefan
