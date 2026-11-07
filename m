Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B7606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QGI/eiYI;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=QTAG72L4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AE54608D1;
	Sat,  7 Nov 2026 09:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmnPIL7qf3IV; Sat,  7 Nov 2026 09:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FB416081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042144;
	b=cwmQ7xC2i1ztjrNARtoB2WFRVIvRP+KGV+M3tzdl60V2eC7q8LhkCUm9tJ8jDTZHNLpF
	 gPvE551FNYS4ukNJpaXTQIm3HXixDYyRyApT7XtOoOlKXcPMbckcNuPItPWsudrQEinCv
	 87bh1xUN2djO83/SvMuMZeVBFUQtsm3EIlcBua9PxZpfaboyvYT53m8F82OcmgGcpqy0P
	 6eLks+ISgXcZ6JaybzNbOBorUI5D1v5QMQVP0kbD2vDT07V5BLizxhsP0VpofUTD0etHx
	 yVidTS5GUMIyMcLFJlFuPO9S+HeNfNkf67gd8dRmPHfUvfQH3/8jd44Q77FW6Zj9LYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QxrL/t/mb/GgFlxjaE7gtLOAbYCWEaujUhxfw6bfXgc=;
	b=VAmDb7NtVDoiBkJE3jmB/H9KJdRIXtm11Ofq9KM59akv+xxVWhVJs8F/y3qngI1SKrXI
	 QC/3Pq1koQ+UOSNv6MK1TBq13SCrfiZhtxO29xrEw4vUsjy7P/wn24ezRVpoaYCvnkIYw
	 TcFo+Kibju674nuahm6MZYGYtp3Q039Vn3n8Nv2l2lsi41QiZD8/m+XWYaMDVq8rbhbRe
	 9vCRaspklf3l7vFXvzs3CNNW9sCnZGbIIXUaMrBYbIWyRf5F16QYezW8d1Nblc5gMG7bn
	 G0pNewMob/PugOEKv6VJtRORE2RULSlty/kZjqYjyzeyY1B9n+Z6Qg6EBklpTVl/sNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042144;
	bh=QxrL/t/mb/GgFlxjaE7gtLOAbYCWEaujUhxfw6bfXgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QGI/eiYItW0Ai5iJ89IDNGoqBiVgjh/wZ2JG81Z19t/VL30v/CAhkl/zD9+yigsU1
	 NA274txTpUqs9mgoG+yOfINHmTtMi1+gy16RXz1X/zPu9SZ2lNHNypj4BD9Pyaxul/
	 n5RAUNZnFaQKNSQy2Web8lyD87QzuvytXILfhfZ3LKVs9uM1MK3ySn/vHNya5i1agz
	 q0Yxqt5w1hR56ufZ9h0338VtAqwCMqcXAeAVTiZyzLtBdz8R5b7sYk09iv6hefGaPu
	 HSBIi2elNz7Oh7fGqLi3znxTp3Jzpg+Al3O10y6TxFpK1oKOxrnw8DSiz4IPw4T4lH
	 Raam6ap0JfbwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FB416081A;
	Sat,  7 Nov 2026 09:02:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8C652FE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6A864005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUsTOXu3gPea for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AAFB840042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=QTAG72L4
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAFB840042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jM96D1rg2zKmYj;
 Sat, 07 Nov 2026 10:02:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxrL/t/mb/GgFlxjaE7gtLOAbYCWEaujUhxfw6bfXgc=;
 b=QTAG72L4z36X6q0NSf9sCX/oCrHri7ca63bX66Rfx0p0kPxtBf7f7ItRmLXnZUyaxuXLbB
 LgRxKUAv7FRPr+nj2zNy8Dpx1EkfdYErlrcN0QkEV6DzlTDcf0q13Flp72f0nW2j6q+211
 uvXvTuGeUcGiUveldCpWMNEje0Maja17M95pCDJ8FIJ9tW6vljLSRpKcG0Db9D8S5NL8Ur
 SHOsP/ErZ9NWW+loWCMpG8GowLeQM+j9sTE7ELH6XfXrx4AiUMQPruqbQd876YMGsCTY2l
 hiApkiZ2MWqbhhtxFBy9DHCBCv4fa8Jy8cIjMuztkakJWkXIKd2QvM2QmTQ0cA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>,
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, "Maxin B. John" <maxin.john@gmail.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 4/9] cmd: wdt: add gettimeout command
Date: Sat,  7 Nov 2026 10:01:58 +0100
Message-ID: <20261107090206.2015512-4-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-4-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
 <20261106-rinta-watchdog-gettimeout-v2-4-07de25b6312a@nokia.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e7592184799b9943388
X-MBO-RS-META: 66mjwt8g69rhjajcr9e4knfmz8qjbq9y
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:34, Juuso Rinta wrote:

> Add support for the subcommand wdt gettimeout in the U-Boot shell.
> The command exposes the wdt_get_timeout() helper to the shell interface.
>
> Command reports 'not supported' (-ENOSYS) and 'not running' (-ENODATA)
> distinctly from other errors.
>
> Add the command to the documentation.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
