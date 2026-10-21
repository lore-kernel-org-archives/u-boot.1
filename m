Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FA606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wy5sZTfA;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lxfieAlH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75A9760852;
	Wed, 21 Oct 2026 02:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7hmoPZ-3r-u; Wed, 21 Oct 2026 02:21:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A81FC60851
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549316;
	b=ZPn38RuRTs7DgotHige7sSTJblh6vnJBMWO2qaPEDSmV2D4JXUxt6ycATDqTNbwaSwqc
	 tX29EJmzksqJ206sMKBHrkWkTvq7tbxAIYdbkUZFxL2ITOzsdLqAVbdLxkPGEBl11Q7Tw
	 4cYSbRV+f2iOS4K1WRj0EXaJzXSZrqfnIZgd+MoiSH+LZUcGtCPZ0D9oGrlgEIq1mRUQ6
	 3nnhaXG9kF4Q6L10pv+IxcN2fPB9KBFu6SvQklU3mClD3L9GYgUWR7zsvuyEXEIk45EYQ
	 mtYe8DLidcwwjUGZ5zP4dSWZd5QMek8Oja00tBfjNo3stYYtUDfFyJpBHrDLOFUODuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FDQR3jPOrSQCOc0SelaQg7UELwW1YemfxG2+P/jIEcQ=;
	b=JRc7xwREokZ/QbbAzpv43JJ4r//I3bt+Qu2A24fX+pbbimou88rVPBUFCIgM6E+cLA34
	 mBF+s3VOGTRQ3qy9jU7f2HfmPoCIIZZTVvPVVhlm7uoyV3syUXBunO04UCVAN/Stl36wc
	 rvT58HklwIS0FKTVvX9yJNPBLKztLRVcKqmb3BdvMlOImpqIx5V1ZE+USeDY7PmHyv+S4
	 kZtZ6kZsBXIyY8YUg7CHLGqAbHh74+QfgmfUAMZQ1tFSWYL8maAEAXPydBDA+X6alcIgk
	 MqrcMa8XWtTLg8Na58vU1OxvNkRjZ+UAF0mvx8V6h/0vFKDJfZbbfnCyJiqKxuFbFXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lxfieAlH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549316;
	bh=FDQR3jPOrSQCOc0SelaQg7UELwW1YemfxG2+P/jIEcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wy5sZTfALQ1qjF+fAF74h/1fA2krSh7xSS60Qb9gzGeCWnITCxKHsjqE4NVos9v74
	 zGIHC8bDzyzHxNNT8UbvFO0J4mepJhF7p7Y70iIzK5btSUY78cy1tT5GsW5FZd64zD
	 8y/CCV3Ph9YzrodQo2ps4zz78yn0tQksclwCQAKCnaJTCpQyJk8G5bgnm0JseqwoK4
	 1ZQtlRaxRdpcChuoIZiLkQiTsHo9JHUpmeYNilbPAzUoxvTG2J3b6DILglwXitvGTK
	 HAvJ56iYka8PLRsPl4y0n2v4zoLHNvo31Hf1K/LRc3SWILu4Dn2SpUHG3sdny9M2bk
	 fQpmsozvNmeDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A81FC60851;
	Wed, 21 Oct 2026 02:21:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 782F61AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C50160834
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wAwA03WLwZKj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EC10F60755
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792549312;
 b=PY60lxqInl9gs3VQ6SfM/hELzA4uNRZgMEqjfjFEMbwktgEUpZedYfuZR/smLT39e9p1
 lkAK3hrV6lZrSNSEC8rloHObQX1I7uG+TOr2vYUCV9R5bPGEjDing9datBLGVqU2RizB5
 1RInPgAiab41zpwJ28rkhxs85HlpoxO6DfgxSlv2nV+7rkwXshG8/18R6rlOSg45DNFgI
 zlsM9oRlOVqBH5XSWKrv5NAj4P0TYIcqO/246DWRWLCbAd8vDcFaKPelX8kq5uW7nE7de
 u0wig1U093YDH2WCs6IfRxob8dhqd2ynVlJvw3rWBuMkW31Q1z/FAdp/OmbpfK3p8rQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549312;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=FDQR3jPOrSQCOc0SelaQg7UELwW1YemfxG2+P/jIEcQ=;
 b=Xgk6ewmsTg/rs5LcPV5o0cCKKTIiPXWxWJ6bcu/LFQgLTfzD1aV4XGkVbxYFPFqJs/vN
 8Vb1ySE+IK/BWmFsh/gCuV1uolMvqRhHAup+h6pm1weFYzZUCPpCt44Dm1ycusXWP0WLj
 dAzk7nAFgmWLf2K2h4DE/rRArIE5no6rfdsjH0EopNhzyQUlViuf0RRz+FCBawun2tXov
 +NzzA8ppfzJzPCTzabhZHLKFnTt0LDgIe5XsrVWyURXSZam0SZ9BbF3FVx1JtzR8rH5uO
 RX1C/CUc/iWQb8ap4OWlK8ZEfDB/eQZJfr/VAK4QncIVWo1Wba1nKnfoeRq1kDfRMVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lxfieAlH; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lxfieAlH
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC10F60755
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:51 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j8Y240hfwzKwBx;
 Wed, 21 Oct 2026 04:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792549308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDQR3jPOrSQCOc0SelaQg7UELwW1YemfxG2+P/jIEcQ=;
 b=lxfieAlHOTE/l9VXlRdbOAAZeGQQwHH40CGwpfb52JsB7dY83IOSFtx2OJhSmCybvxLBEL
 d2nLIVKs1Z3wEF12r7zcWMTGSCx6hLj/2bhh/Y0UJMwPY81NJIxoPFTL7hfsvNfI8xa56l
 0pA35pK0W77Tnxw1o307rNmu5w69r4S7ZMvVu0zhKRhE0aUA7sCk3nvaXCAfAQ2Npig+05
 mkhdXzV5cmS+wNATMIKcgdnKwqlivYkhokbKM1WvQw3sMVnUyDmYO5h4VYueEdo6ZS40J4
 FpXdpwdwjaS/6blMR5tAP3Ids5Ne6sihsv1GGCn0ZdK8fqyZ8IM68Fp74xvSyw==
Message-ID: <218e94b0-4a3a-48a3-8b68-57686738b9de@mailbox.org>
Date: Wed, 21 Oct 2026 02:13:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/9] usb: ehci-vf: take the register bases from the
 device tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
 <20261020101608.2818265-9-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020101608.2818265-9-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a2a50f3f6a4d5b54556
X-MBO-RS-META: 9afuee77uey7i63193tj5w6iz7dxydcn
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 12:16 PM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> The driver keeps its own tables of PHY and controller base addresses
> and reaches the anatop block through a hardcoded address, although the
> device tree describes all three: the controller points at its PHY and
> usbmisc nodes, and the PHY at its anatop.
> 
> Read them from there and drop the tables: the two phandles of the
> controller node through dev_read_phandle_with_args(), the anatop one
> from the PHY node. The helpers take the private data instead of single
> addresses. The port number stays only for the choice between PLL3 and
> PLL7, which the device tree does not express, and now comes from the
> usbphy alias of the PHY node.
> 
> The usbmisc node already starts at the non-core registers, so the
> driver no longer adds an offset to reach them.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
