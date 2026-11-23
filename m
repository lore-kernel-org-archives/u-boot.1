Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94476606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i5AwJG7f;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=b1P12wTh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFB1D40635;
	Mon, 23 Nov 2026 04:11:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AFk6gm_-EBsG; Mon, 23 Nov 2026 04:11:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B4D0540620
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795407095;
	b=BEmNCNx1Gla5rPgOygDQpyswUf//G2/lCu4I9v5iS0fUbcE/nfkBGswPDESbeLxTR01c
	 /ufRigh+TN7MhKDQTLqQEJhREoGrB/sP585eGZO24Oz4OXUF5PkpBqioyb5tsYv6r52yp
	 whKntXFZ3IlkSlbVaEpe1JfQFtuqbBk4AV1e5QXTUpovjmJQi8E0MLAQt4xE88AeaLqGI
	 Bm9P8ojbEDdSA8M1tfdsT0G9stpDN0eGRYjedU8ArOEMrLgDil34lsTE2RKnqBm/bU9r7
	 e64eKNIumyYGCOyxHtAWpsVhBIm/ukSMDLrEfRoEV/1JrqWiJWIWwGklp+0rtff6ExQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795407095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6ljkPl23ckr5Di7MP4ahGw1M2G293FvCXRlsnYCUQrY=;
	b=fG/LcqAP6qh2BlmMrC7Gu8B6/cQklOok2J8jqTwtski2637dPtVsqWyiLZUdH1MWoWmg
	 mggwVABx/LS74SepUQ8z9pb6dArUIPiBtd/iZSpGNeT/6X6IUTf8/QQrWdNZIk84w8+uN
	 Gy6m0fCpQJrk3v0HkrKnV695Zcem4MAFTaent8q4LFQDRXdHaaGtElrDF8FvqqnBh2Sm1
	 OEjJ/0dy7y0s34MoTsXCIpmMMqQ4QiB+205LFVFcec4iiiwGGNuI9yzwJtSj4PPxnmUnp
	 UnVg0UE2EILEUqi2zyQlptZcVnh3TNNgATyTzobyxEcLGZigwi+fnXPzE91qcW953jg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795407095;
	bh=6ljkPl23ckr5Di7MP4ahGw1M2G293FvCXRlsnYCUQrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5AwJG7fBvgwMOA0FNkmq6WJ2EwOjdv1SlrpiEo0OLIDlDxSwQWF48YKnb4q/nDKm
	 qugdhOdLkSbeRUrwVEd4p93wsfLzvZUfB8tpl7/JTOMUA00+4JMzz2aCRqIfajzhSt
	 KyHSbqfW5Rcim5ZBFOdS7qvq2XHIC/A9vMgOZeYv+OCZb33+oVFfN4EhwfcuZ8KxUa
	 7Mp5NE4vAkDKDVGceVz7m/sMVmsEU/CUMYbnjH4IVlYGBA1Lob8s4QN0hzGM16A5sT
	 f28ywpry+le//AidWWDa31PQvHe0uRoj52maDjivBSi/eKQYSNn932K9ao/9KwJ1iE
	 iPF7RzsTveAnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4D0540620;
	Mon, 23 Nov 2026 04:11:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC0A8499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD9DA400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1k8beSHP8fVN for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:11:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 550CB40081
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=b1P12wTh
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 550CB40081
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:11:30 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=b1P12wTh0dALbOGIqvThm1VQMdqilppOHq/GM88ruJonCFnLBhmBGIJFP9+NrIl2c+ksUf5j7rwxqRkrj/gVFO310Wy7hj7KIdhjfoBB49pzkXoZhSINK9RH5znd+zCNqN0zC6sFFpgDeB2HvSXHHMfOn46K7KQyAn3PH+UbMQM=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=6ljkPl23ckr5Di7MP4ahGw1M2G293FvCXRlsnYCUQrY=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795407081045758.8070611453353;
 Mon, 23 Nov 2026 05:11:21 +0100 (CET)
Date: Mon, 23 Nov 2026 06:11:19 +0200
From: Igor Velkov <iav@iav.lv>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, E Shattow <e@freeshell.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
Message-ID: <20261123-re-tom-wget-blk-v2@iav.lv>
In-Reply-To: <20261116200413.GI554944@bill-the-cat>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <20261116200413.GI554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 02:04:13PM -0600, Tom Rini wrote:
> Maybe just
> add a few more examples to the cover (not just whole block device), and
> assume the default buffer is correct, which is what -b 400000 is there,
> yes?

Yes: -b 400000 sets a 4 MiB write buffer instead of the default 1 MiB.
The v2 cover drops it and shows the other target forms: an offset, a
partition by number and by name, a hardware partition:
https://lore.kernel.org/r/20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv

Igor
