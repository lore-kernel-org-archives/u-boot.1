Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9D9C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5522260668;
	Tue, 22 Sep 2026 02:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBkXQnxlUR2J; Tue, 22 Sep 2026 02:44:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 32DC56066A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790045083;
	b=TH/5zloWNR3oGQOQ2xC2Y86fBRnVKat6esQq4nBrkfFy6vqTfQC5LDGNV9nQk9l6IDH2
	 Eup2VZiFDVx4MZ94Q7vTeOBEFt/rd7umxpQHl1RfdqWAHpp65FXQj2WpLnr6i+hhP30to
	 FqCNMLJYzbXFCUkM3i15oY9w1YzhBbCXj7X9a/ZMzb/j6sVdlGeER7xqb9c8UBRMcv0n0
	 gPHCTAl//IjQEevZP9j3CCQZB77M5bJEAyCr1G6KAW2z5fSw3w4PJmdweDaG8uaYAjafS
	 QS2JXKXkvDLHOluLULPVoyucOP6213cH9w9uvWCCt0o1ILL/7r+KeU8JGxSk9BqnUTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790045083;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WCEs0fCCjU6RmWOr4DyqD+h+5au4LZVPan7QxV/HKC0=;
	b=taAQuiuFD0CdSL0I+7QAtQBRewN0OGtxKXuhhPghotlSACKaC1S1zCKAGCutWd0YUul+
	 1sxyjvAss+YV15I//n0KhSH/4LQcFCfHilf+DpIlXkKKCNP5uoGCbRocsN1p37dc6/W2d
	 sJH0kkt0IIJpDd5k7gHW1Rz/CgkxHN/0myUzsc2LoLYpUPmtVMPMs17lkMmrsf+c4+tcW
	 cRu9tVr8Ymme7zQHEt2bZ3MQIszbjg3KMYRsRBF2gJkH+k/n7HdE2OtkuMRL8lcnyOn5P
	 yvH5WGXQOmlGGsPU4czT+4m9CxjGD54ZS+lEiSjqm5EJ2DoOre0S6+/vnCcgs2x64yA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790045083;
	bh=WCEs0fCCjU6RmWOr4DyqD+h+5au4LZVPan7QxV/HKC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UMfGqBHHZQ2gidHrK9JFiQ9Nvfy6YzEu+cB0sy2JuTM17ddxusHCXMi4qb/tixuhQ
	 cOP/exN2uG6Bftx1+68hRpjNob6NuhDcZWLC6t28cI8nXhASB7tKzEjNtt6LLkCfdf
	 wgXE9BNy9Vc4lk6WXNORwRGxbvOoVuPhq/gyvZ96MtmabxqsR2gg6iAvmOkqIKoKSu
	 FstfaE0W4ex6j8js9JPHcaSfEod9qJ6F8vhkhxd9xde5QMFpCNJ6Jtvqc5S3B79uJt
	 /ceCpJKeplCqDGatx/OWfRNHci3HSEl2D6VAMqs69D5U2i15SMHmQ4jQVNxmAkp6Xx
	 eEaFYbcEIy6AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32DC56066A;
	Tue, 22 Sep 2026 02:44:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8648CA20
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C44B40780
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuCZZ9N4EezQ for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 885E04077F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790045080;
 b=V/+X4UVcG7OWKBvqZR/1Wql67LIuxLL/EZqoRF9FHj3N6ArjRVf2jprob4aKYUWk+rV5
 Qme60a6C8RFHW7m8PHqWVh9zqfgK91UcEG7l3cqhWVSOwWMtzG+PWabUpWxr4cdITbd5G
 O3ZQkBVf7RUmvuPOsRlXA3aDi6jEPrEEOQjU268t8dMRszUl7VFMaGlhcYg87c/ryavPc
 9aHd1sEuRkMLUU2p6W54s4lLyUyHprgOSXTpOCij0oNRj82c4oKqil83QqKWCsfi8HTx2
 wrRGaqwP111ZfMhEODNDjGM7DV33/45k+8IQfr1C5YILAOuNj4/pWe1FIK3KK9+BXRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790045080;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=WCEs0fCCjU6RmWOr4DyqD+h+5au4LZVPan7QxV/HKC0=;
 b=aPmzzCyjbZpUvqI6l6eLJNocSNq4q4+lGgCz2/buh1Gh2VViqI6WsxNFVYmhP8JR9Ef5
 5nXpFjpKxoUx9JPwTZo2e+IwgkDzCY3nAQ42yFPGN2n/Mzamj8DUgg2u9Uh/bR8GC5KhI
 fsiFtxtpjJxvECvcIFEYfN2hz/K1d1O9EfCTtw1DSNPk3QV9qgeUHmYyq+03BPx4xLh8S
 uhoxMim/66gmP5B39/x+X1KwOXuwOq6ZdTHvKAIXugruIHrPJVJhNiKdbDQz4vD/zqctg
 YiB4tTcO5eunZ0nW+qA68630pC+XYgrti9FwZFSDcyRWFd/bT2AkSf+QMaZsvDwjmKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=psBTLY59; 
 arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=psBTLY59
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 885E04077F
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:44:38 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hpkvl3SG9zMlGB;
 Tue, 22 Sep 2026 04:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790045075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCEs0fCCjU6RmWOr4DyqD+h+5au4LZVPan7QxV/HKC0=;
 b=psBTLY59w+okZiMDW6knyNjSy4/sLyPcTeMdOKx9uQ6ItQBvW5g6wwdOEg5qx2pZQNC+wF
 TeOMsG+KEfHUMc/U2T6/eExEMT+4LcmZBvIV1uJwGJo5nNT2QZW7uQ32Pm/HkJsrdcyrcy
 oPU8KbeZQrdGq1me1c0Uj0PP7A6QIoXCjuL4XGPFW4LAe3f9bUZbV0DkPuELTc2XQdxUrx
 /9vzveCPD0iH/IcdtMAyRqzbKg0Yi+MeLbp0Rpvgw8rV7kgvcWOEp1NTavTH9lP17nDwqo
 8YtloCIVWW4++RD4ujYlkLPshzrw4Rt1INsu3t+X+dSjwkvFFE57y36w9BHYOQ==
Message-ID: <898ceb98-5e56-40be-a916-77a4133d838d@mailbox.org>
Date: Mon, 21 Sep 2026 11:40:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
To: Stefan Eichenberger <eichest@gmail.com>, Tom Hsieh <hungen3108@gmail.com>
Cc: marek.vasut+usb@mailbox.org, stefan.eichenberger@toradex.com,
 trini@konsulko.com, hayashi.kunihiko@socionext.com,
 u-boot@lists.u-boot-project.org
References: <eab9d4af-6f01-4963-8fea-49a53abea2e9@mailbox.org>
 <20260921054432.2978558-1-hungen3108@gmail.com>
 <arD0gD8AMpO_B6kT@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <arD0gD8AMpO_B6kT@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 925e28754d25d0667ce
X-MBO-RS-META: 7xsg9qbag39kx58m7we5pkbz75wtscgm
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

On 9/21/26 11:10 AM, Stefan Eichenberger wrote:

Hello everyone,

> However, if we have to handle this corner case, wouldn't it be better
> that probe fails entirely when dwc3_generic_probe is not called by a
> dwc3 wrapper driver? Or asking differently, is it supposed to work that
> the "snps,dwc3" node can be used without a wrapper driver?

arch/arm/boot/dts/nxp/ls/ls1021a.dtsi

792                 usb3: usb@3100000 {
793                         compatible = "snps,dwc3";

It seems snps,dwc3 can be used without a wrapper ?

> If that's not supposed to work, I would propose something like this at
> the top of dwc3_generic_probe:
> if (!strstr(dev->parent->driver->name, "dwc3"))
> 	return -EINVAL;

The parent driver name check sounds good !

-- 
Best regards,
Marek Vasut
