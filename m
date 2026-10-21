Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B87606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T9VNZYD7;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=j5wJ+cnD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD9DE607F3;
	Wed, 21 Oct 2026 02:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0W9Qg8TTS6Z9; Wed, 21 Oct 2026 02:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5CB66082C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549313;
	b=DUerivWdqocQL8u2CbQBn8RC6eHiXcgX+l0pl04wCZitXDBI3HZr/ZUfYTkn2K5MR9El
	 UVwannNTJg8jIJa+uaxHn+l75JM7fcXboe5weh8klLSjw7zv+5384jz91gj3dZQvtz+vd
	 xcYxi7Iili8wdU3KpR7VWM2vC7DlRMvDdX2PJpib1a0gI83dh12Nyhh7mDr7+3kVWqpPh
	 nF/U4C6GqYSL7NBDZTTI7uN6lJFnvny11K7SibhtW91LjxJ6Eoi0zp/Rj2pINcamuQJw5
	 4EfK+9XS17cUmTm/GLWD0x9xRjJo0VWslWRDb3sS3nKokdFlSxYWEC09woX69VmLbbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xfqid3upKjeQC8IW7ROBjj7J4OcmKX7scK8VXwYZll8=;
	b=TYYurwFlULH75p6s0ssqcxctDZX8oNLByaenhFZpKvRKT4egDxUF0Xwnee28Zu39oB4r
	 XW1uvl6VhrOp/yTuOv9VoPxVCbFL+s+MIsYYR7X5dmvoqsf2U5xSzVU012l87tnUz5TjM
	 XVuL5E482ZRUOzu/sMPVEjdBtwjVgj1Vnz0fvfNus7B8BlZW0kae/hHeoa90wqRcFEpxw
	 FPVD0aTPBZ8fa6Rj3gzo3kb37MjQYix+WFpqOT3X8z7D8iqM5IflfQj2jZ6lhSLlUg+U5
	 wnIt3Usm1Lh1i0ZAR355FgnPe+eEU+zduDb5MGKj6HKopUbiw2IDm6hCmjo2SwhUvnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549313;
	bh=xfqid3upKjeQC8IW7ROBjj7J4OcmKX7scK8VXwYZll8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9VNZYD7zNxFckqp2pF5zcqfFSQSb8upIWpUEEePviyBA0QmSxPSh2kWWWN/1MKlz
	 FhTKJ58+tLcbTH3iKgcnI81uYW3lZ5rrzJ3dSgluUo4zbyLInPeshymtZgTWS+C0+g
	 r2y4cYlHsgGYzd1f60ZKIbbXhRtA619/UBTnJZ6WgsA2/rXsnFnR3mlc5WT/nh+p/A
	 3rZfBpKpOc9NAyvb9GO3RIt5M6RFVorUJE7FN7Dx1bPp4KeOKWJOQdRn0j6Sxm2y5y
	 OWWwl96+LMLDzbNQtubufmYbxg4+sSg/h2IY1i4IWfDlza5r3T1I5s3x/QLclJFimn
	 e4GnLZsZW5S2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5CB66082C;
	Wed, 21 Oct 2026 02:21:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9696D1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88A5440261
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7bn2jbnHj4I6 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 65E2340060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792549309;
 b=dmgNnDrnVPDE82/OKLTXi4e07nwWTx0HyqGI/GUOZmemo+043Vn/ggd2VOoNL4k4gEWf
 grGMOVscDmAuVIpYDQGsibGzavWlNNG0mA5m3B0ffgX6rbSy+9QRV2Wbe0CKbmzj4+YO4
 G3aWeqqiY/L0ULdMdOb7v+LDv00AQCRe7awo7eQpi7C0+50wusrXpB/KFS/WdrhTx0O3U
 9C/GrXvcrBcs78+4JT1MC5Ow2pqxUh8YQTERyPEbVf7/yjQLE4NRXBLllHgyrCwv07Uzt
 rvVWyEAhwkEotwzIQpAIXz+jDKLr/b+de5TtFSQr22t8+qDvaAUZnWeVxzF9w6wHwHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549309;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=xfqid3upKjeQC8IW7ROBjj7J4OcmKX7scK8VXwYZll8=;
 b=EWVhSlDcNucBBKbodTHBkCOYFDXcsdrvffup7WKkTmh8/Y6LOk/EOGO7aXFlbaaaNbBS
 Gufgu+/o6fqmE8wCiC31y/iTZJNp1MqaRGc/xzIbg9h21UoPqEdgCnrM9iYJrw1A6HMjV
 7klHGq8msVcZtX9Dj8Mp5X0o5jCpD2hy2nSZr4GxdH1TB7Jn5H7Awh4YC4KkmdCdy1rjX
 sKxZvVPk6n8bvcfPr6MIU7W4bLQuFpIUdgTlHs+wLrhn7xkJ+FAGxUeo1DaiPKIgzLfH0
 GerZMMQAQRgkIDK5rJ/BAkgM1TsU4JjsmL/apIoCygGa9tUbLVuU7/dy2BnS3LU6lOw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=j5wJ+cnD; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=j5wJ+cnD
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65E2340060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:49 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j8Y214Tp2zMlq9;
 Wed, 21 Oct 2026 04:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792549305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfqid3upKjeQC8IW7ROBjj7J4OcmKX7scK8VXwYZll8=;
 b=j5wJ+cnDBEBq4DpfJa2ufgR82K4eQaAb+kRDt0Fb5pMOy7sq92XAwl/HJuqbcb7UgNP+8A
 JqiAkPc6bWKUiDzaREEmUk5P4vt5GZN+JVqud+Ya6eOu91QpvZvppTbQO/SpLPBRxA44Xm
 erSM9byRG9mhKdseLnYax5flpv8uhPokzBuFl6c3QL3OnBZVM0jtkuoDLJnRbz0QosRu5Q
 pjwlhba94JdcHmxyT4xikDU0D+H44wq/7nFj/IkDciKw8kE4BHqbm6fMwqGwfa6jUWJkO8
 YV+/74F+OqbHG+GUiu48blxKlzY+1jEimZ/JVx15GwHuK/Bfb9bAmaUIGG6AWA==
Message-ID: <b73ad828-b418-4fb8-8839-7789880f8a86@mailbox.org>
Date: Wed, 21 Oct 2026 02:10:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] usb: ehci-vf: request the ID detect gpio through
 the device
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
 <20261020101608.2818265-8-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020101608.2818265-8-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d5bd96f44453a2e0a16
X-MBO-RS-META: uxuhke3hb1ncqej8ma1pik3iqow48pr5
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
> The ID detect gpio of an OTG port is requested through the flat node,
> the result is never checked and the gpio is never freed: a bad gpio
> description or a failing read silently leaves the port in device mode,
> and every probe after a "usb stop" fails to request the pin again and
> reads it only because the failed request left the descriptor pointing
> at it.
> 
> Request it through the device in the probe and fail the probe on any
> error but a missing property, which keeps the port in device mode as
> before. Free it in a remove hook and on the failing probe paths, so
> that the probe after a "usb stop" can request it again.
> 
> The flat tree access was the last user of the global data pointer:
> drop it.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
