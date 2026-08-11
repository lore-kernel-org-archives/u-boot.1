Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD768C5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 12:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5DB0605F0;
	Tue, 11 Aug 2026 12:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70HwYoIqWEXf; Tue, 11 Aug 2026 12:42:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDC026062D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786452157;
	bh=yjViXrxMKkm6QCbKndkpOQYdTW4uuSbeDGjlmTCW910=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0iUDmG71+B+zub1bjA462cHfe/6dPUW1OOwX42dQpsFTmD7P2aGknkRECw+IVzEHR
	 YBHwGNfOsxRMqAhFJ3KihEyCF9+/i87uMH2JucIfYJOEaixvScDIHtHW4KU0omn2Ru
	 1vsYyll9gvsnaciyqTEC7NujDq/Fbvg4dnbHBIbJROTLmqbIfP7yZAFWw2OGh2xiQO
	 O85MrZceQLBknQi0WuI/fIWnv+7mwm9mYyxk7hQZPUWKVMbrd0iZvxI+O5Gda9o9zU
	 CZoXjf+kFD7JoUs39aYli76WfAZgcpsAMCLe/9pUpzqMV3ejKZXDydsdF3gbDhr/u4
	 LhoHSEP6Je98w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDC026062D;
	Tue, 11 Aug 2026 12:42:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A5B36345
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92071401E3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:42:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RUZGyAB8ePc for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 12:42:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AE556401BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE556401BE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE556401BE
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:42:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49EC943448;
 Tue, 11 Aug 2026 12:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB251F00A3A;
 Tue, 11 Aug 2026 12:42:34 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Arthur Chan <arthur.chan@adalogics.com>, u-boot@lists.u-boot-project.org
Cc: David Korczynski <david@adalogics.com>, Adam Korczynski
 <adam@adalogics.com>, "security-cvd@anthropic.com"
 <security-cvd@anthropic.com>, mkorpershoek@kernel.org,
 jerome.forissier@arm.com, trini@konsulko.com
Subject: Re: [security] Report of possible global heap overflow in U-Boot's
 fastboot-over-TCP server by authenticated peer (ANT-2026-5D7F7SAQ)
In-Reply-To: <acd869c3-d3c4-4ef3-9c06-4be29481f957@adalogics.com>
References: <acd869c3-d3c4-4ef3-9c06-4be29481f957@adalogics.com>
Date: Tue, 11 Aug 2026 14:42:32 +0200
Message-ID: <87y0ec25hj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786452155;
 bh=yjViXrxMKkm6QCbKndkpOQYdTW4uuSbeDGjlmTCW910=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=IReJI+8mlQs7chA+qpG1CFgLWmYv5Tfub1ei2nBlIjsE+YmrDhXJF9Zi+n0l6E9nr
 HvYjyPbIIJTF2LidtZGySHltuilhDF0F6CKQ681Ebi2MQJvXL3wUyJG1RAuio0Y9P0
 fxtCN7Sb+TKuMpUX2Qj9bgM6nL1rdJvLXSNEBZAMLiz+EL5GorGAgOSUce7GqTmU8S
 gZm8mWyjCljrBOJPZ2zXJ4iyPxacu4XQiuPVgIoCA2kPnLphIdbJi8wlK0heSgzXzZ
 fG9w2oA1gwYQhMqIHgbTQUsC83y4LHKyC3F6+M8wNKWWrH92B6IJVhesmz3VffSkFi
 vkZFJUR4Bdr2A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IReJI+8m
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Arthur,

Thank you for the report.

On Thu, Aug 06, 2026 at 14:40, Arthur Chan <arthur.chan@adalogics.com> wrote:

> Hello U-Boot maintainers,
>
> I'd like to report a High-severity security issue in U-Boot (https://github.com/u-boot/u-boot / https://git.u-boot-project.org/u-boot/u-boot) related to possible global heap overflow in U-Boot's fastboot-over-TCP server by authenticated peer.
>
> I have attached 3 files with this email as described below.
> 1) report.md: A full description of the vulnerability and how to reproduce it, together with suggested fix of the issue.
> 2) Dockerfile: A Dockerfile for demonstrating the issue.
> 3) driver.c: Work with the Dockerfile to demonstrate the issue.
>
> Attribution
> -----------
> Please attribute Claude and Ada Logics. This issue was found by Anthropic from using agents to study security of open source projects, and I am from Ada Logics helping validate the found issues and creating the report manually and notify the maintainers.
>
> Disclosure
> ----------
> This report follows a 90-day coordinated disclosure deadline. I'm happy to coordinate on the exact timing and to provide any further detail you need.

If you wish to help the U-Boot community, please consider contributing a
patch to fix this.

See
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#sending-patches

Thanks
Mattijs

