Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62177606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kfEi4fNr;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Uo5rC9ao
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 092C360661;
	Wed, 28 Oct 2026 00:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wLD4NdctFGMo; Wed, 28 Oct 2026 00:47:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 649CC60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793148448;
	b=ImjaX2qu4CcqSUFxfFuvv0agpBEgCR7Gs2jSU4oQ/qxl7+cEe0+49FZoo+QftAeRUSyO
	 oZlmiHTIn5HEVCJAP9Wn9WHLYin+vv16xbjr6x1VRHGQ1sDHE/9M4X9eA0Y7GVqaQMSMW
	 LrJRxbjyiNvz7zd/Qqmx9QMmgohtve1cQl6wreHOpby9QN6ZGFftap+4aXDbvlWgWFiBM
	 e1ea8n+QKI+PFZA6+8ZILkFitaOnkKaTcBGQrkFiPtD/r2kqxxLp0msOsRx9Uw3Kj3dgC
	 JpehnHM3iGaXAKLxU/CPz36+BnmqDbq09W3TI4tWIxhgdE3nz54SncNcOmhvpQVOmhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793148448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/3mgv/ucPDd6hIayN5PRfGrrVTRfYxvnJjR6f4O9198=;
	b=iGJFUcT+zFvn9f6Irb5cwy3yA+HRNJDk1QGpdYqIDgt18BG9dxQdIgbKGDMrAAAlHih7
	 XS0uesgm+Vt7SCt5EyZWs38QE+7Q0JguL3nNwMjXp8XbXcevE9iM5Mj+H2SfIweenIGoV
	 4j5QT8zrbhR2rZ2F7sO1/gfngy7fuv9S3NLjS5O0mHIFoZ+ytuJeHKqzxYbxiTFA0qVAU
	 m4BPEmB6fMOYaTGRLpnIas7FJ+sFNtzoHxG1CZyy+GjLhujZyx44+pCVSWwDk9fWFt3QI
	 B7mYZEg6zy3NJWG2koDP2VeJddMCAoiR8cCYB01dfHYkAhaKDU+4Yu0dhhWkp62pCbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Uo5rC9ao;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793148448;
	bh=/3mgv/ucPDd6hIayN5PRfGrrVTRfYxvnJjR6f4O9198=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfEi4fNrpDrWVaV76MhEIP0Jds0jN6QHNudUwj4+IJrLV/1MfEo9XPRcmb7nhG71H
	 Yb/mTGPHW+zZWUiBDJEcHcR+KSVUikBBrpusvxpJylEAY6+5svo8mhsxFx2AS5cbZi
	 jo+Kpe9Jbt+XUC6zfth82HE6i1sfcrNVA1Pt9wVhQy7layEGKSPjNJInAmB0Qu3Pmx
	 ZZfs5yC24gWeGX0CCjxVB9vJqrD6iqM9HEofrPjoCAd9XRjSr8rqQ1+/Z10mR6bybr
	 ArHb0nZbwZv76Lu639ojs9k7fZSP2l4DFu8unaXoOgNmQwJ/Kpwdd9Zle2d3dkwub0
	 pmehQHmvYo/Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 649CC60613;
	Wed, 28 Oct 2026 00:47:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 782C1529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EA0760611
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_OtCSM_1x7w for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 00:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 962DB6066C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793148444;
 b=YOBKxBq8fyHrjrVYjEW8BeJ5xDeLaazuRZsqYoyZzLGXzC761JBCenaLszNKRdNJW9i4
 vy6mg+E3Ri57x8Fhvzx3G8BxtmrR7nBBiXUooeZP8XIpV5EfVkuKSeCD2UOkUlpVzTXX+
 EsXgRVnaNWUL3/NlqupIoviuq+hl+quRm7fZxDllC/01jdPXRqzD0ORkx7CIotbYmpzdF
 52gSXssc0BIxB0CzyOv1phNbCf0OgDtmbvlBfKSDwnvXhn+45vGDvcKDmXgblv0U5/dBi
 aEa/pk0dkVru/def9uG7fUJdgqp/aPlf0Rjc1v78RUc36BD5j3YrNkknWPt3hNY5+eA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793148444;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=/3mgv/ucPDd6hIayN5PRfGrrVTRfYxvnJjR6f4O9198=;
 b=ByKdQ7OL4olHutW0DTTwaagvLkehsyjGDkn/jzCvdIQz95wqIcwfNRSfTs+H3tsAk/yA
 LqjoYWDfnxlXgJJZiTt9CZZblSA+yq0bjt6IFdlf1EKOO1Sp4IJN4nwdyHYdjHMRKfYgr
 raSS89HYlDFBhp5CCA4rfwRbJ3sYYjgdNQJ4+j7mRv915cob2HOd8dkTXKbYSnnf/P9cp
 B4ktyEQzBRp6gx86jRqqLZIx9isX8zvMJP43hYNiM5h59P2GBsehL/Ts8DPbThtTUo3pe
 6CHnUCZmQJYAdwpZyLjVPQf4Lx3/TzzbCkl9ZiXeyP/gybk/VLn9d8RBAKfUUyriWdQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Uo5rC9ao; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Uo5rC9ao
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 962DB6066C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:47:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6291410BA4D; Wed, 28 Oct 2026 01:47:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793148442;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/3mgv/ucPDd6hIayN5PRfGrrVTRfYxvnJjR6f4O9198=;
 b=Uo5rC9ao5xEmHxCcC4bieRrlo12tcFpFqjhLxuJcNQ2CIde53Zr1XFwyko+YA8zPsHpSIX
 I43GbOd7aRoC8WbYqzfjZkiVehVkG+tqmQsqr+KNBOdKUv+4hDjUDHSdOOJE1Mg1jYoPoV
 doOjZE9BgutCKnfN4sdlj1xBK5DmeR+es7rdQO5SmJMUNRRRilV7vocfn0LaDzl5KflLMm
 qclRFNmle9QsKispvwxujOrSKEfMzJUxq2j7PMb7VoVwwBpdOaDpmgNbyXh4QLZCMPsynU
 /ZP2If6gOszi736te6HkZW2p1930pbXqCg7BzmvdXKGJoaJ+1JiGax4nQzxHdQ==
Message-ID: <523b0b3b-f260-41bf-8455-b58acca52b03@nabladev.com>
Date: Tue, 27 Oct 2026 18:25:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <9a416f0664c8594c0af0573b5385dc4cef7e2dcf.1793091394.git.nora.schiffer@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <9a416f0664c8594c0af0573b5385dc4cef7e2dcf.1793091394.git.nora.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 10:39 AM, Nora Schiffer wrote:
> On i.MX6/7, VBUS enable and OC polarity is configured in the usbmisc;
> there is no PHY driver handling this. Always run usb_oc_config() when a
> fsl,usbmisc exists.
Would it make sense to add usbmisc PHY driver ?
