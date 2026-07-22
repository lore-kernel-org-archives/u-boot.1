Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128F5C4451C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8AAD40703;
	Wed, 22 Jul 2026 07:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HkwkYw-L0wJD; Wed, 22 Jul 2026 07:01:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F27C405CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784703692;
	bh=N7NcEH34YHFEk1TYpCIqZaMWDK06Jm71YunkD/jWNYg=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cFEkK2vDZlkvamMLYJltNftzqWmK3Z1vW5h+s7PoYLtOQyMNZhPIZeRkykSqHRrwg
	 KpEUq/p2oRouLaBwSh82t7E+N3+JXoTD1DwnA3YS8QEhJMwWYFS4sNZs7oSM3LZcVj
	 tWQRvuYojxRfupUOu+Nir1diAhHkAVksGje0w7gZjzV/dUEfwL3aWPG5rB4fkEBBKH
	 rfrFwSVQfUlsDCWjBmTsuZ7xBjvxDMoWOSYiM1bXs6fg20iO1rqCvoSfAyNvN3AxyS
	 BBgooh5g9WkGKPyPDsF1eBPK+VPTnQPaFRp8mTlXw3RaB/naD4IPFga0FXJqSEVbph
	 E/Xez2olib2Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F27C405CE;
	Wed, 22 Jul 2026 07:01:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 296CD9E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B4CB60692
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:01:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfhDE40M7XVv for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:01:29 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 13CD560632
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13CD560632
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13CD560632
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:01:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C856848BA; Wed, 22 Jul 2026 09:01:26 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F25803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:01:23 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0CDB60A65;
 Wed, 22 Jul 2026 07:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EEF1F000E9;
 Wed, 22 Jul 2026 07:01:21 +0000 (UTC)
To: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] cmd: ums: Set Device Descriptor iSerial based on
 serial# env variable
In-Reply-To: <178470329369.163835.10555173122638201570.b4-ty@b4>
References: <20260626142840.305478-1-marex@nabladev.com>
 <178470329369.163835.10555173122638201570.b4-ty@b4>
Date: Wed, 22 Jul 2026 09:01:19 +0200
Message-ID: <87pl0fik3k.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784703682;
 bh=N7NcEH34YHFEk1TYpCIqZaMWDK06Jm71YunkD/jWNYg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=cyK6Aa9QnSrjycYvfwUm3s+3uxt0skgDnSzIeFR5TPPD2qBdS5EPOhSCo682VlPsu
 m/XCBiev8bXqNaNWbKB0Ns1+M6er2ViQDzUveTqF7x6PB+eN+2QH0tsFtsuC1YzBa4
 +izRXEctuL3DUnCe9tebocJ3wgk32yXfdyzomIVrbjiCSSEbMfFKKWllD3L8rX3jFg
 TIlVCCNAW6BzhfbwfGfXVBzuf9AZvJou+SkF4Vkx/xLE+PCf7Pk/Y+z1aZggs3tM7K
 RkWPooy+9KanBiAuMXnlePEHBV4p5nm2zjMO9kTvy5m471EUPRj12bVR6d1C7nXXZn
 QUkafKry7RdXw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cyK6Aa9Q
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="cyK6Aa9Q"; 
 dkim-atps=neutral
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
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jul 22, 2026 at 08:54, Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org> wrote:

> Hi,
>
> On Fri, 26 Jun 2026 16:28:17 +0200, Marek Vasut wrote:
>> The DFU code currently sets the content of "serial#" environment
>> variable into Device Descriptor iSerial field. This is useful when
>> there are multiple devices connected to the same host PC and they
>> have to be told apart. Replicate the same behavior in the UMS code.
>> 
>> Example without serial# set, which is the original behavior:
>> "
>> u-boot=> ums 0 mmc 1
>> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)
>
> [1/1] cmd: ums: Set Device Descriptor iSerial based on serial# env variable
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3caa8f42e1f657177780be5a445502cbb9181e43

Err, I forgot to update my automation. This patch has been applied to
the new source location:
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git

See: https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/3caa8f42e1f657177780be5a445502cbb9181e43

>
> --
> Mattijs
