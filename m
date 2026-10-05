Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61004CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22B544063A;
	Mon,  5 Oct 2026 11:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id okhZJXbw14TN; Mon,  5 Oct 2026 11:48:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 58CB44064F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200900;
	b=QpMvQ9QvV8OYcmsvZbT9f5R490tY6V4/aHEYJGLdJPYsAKGmMsZ89VvWGl2USTIljSRc
	 L3zbQiQGXG7KZqp828F3dcOiEvhZtDVTQY4/hwlw79gQcbswRKlEsN/KCSAtWTF82t71N
	 vqjQx6qgBkBRjTpB20tSLMQS+rj5m9cExM7h6Uyv0jYsrfoprtPfGnUEwbfynqAVwlO3b
	 hFHNV/pyJEs13A/pE6Dv8pcouB6Zp428/uyBky27Pc8fVX7gTyXIP95VgJijaNPtJHrtJ
	 sWrU8RNP+znDXGurz/+1FV6erwUXF3ijlYeVvY2m0W0Dd14htJcbbiLENmq0rxECQzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SlOjQpAxr563Or8fG5V5FZ4ccVK8pvFWYcBhDPn4uug=;
	b=sJUnzcGGa17xp5RUunjVp1Z8c2BnEtv/632kP+GG3X8/BVMMKwjX8k8KMOeGdSHXm7sG
	 1tAF1VmLZYAp1R03CsXsSzsYEikCvQohT8xsuF02/oFHkDS6SNPeMYmsmcK0mVOXSf+ne
	 W1LUI08bGrmt0xNlchXvgSclbMV5onekZujSNxvfNGCVQkII7HFdMioJLRxqYlTYYMIhv
	 fuIzG1k+iF2voke5XPgNpzNZQUFdCpVlMw4bKfQGKisDPA7SOhVSnAxzQMv2cod6Eq+ea
	 Fjq4tKciGtucPYoQvZ8C0mpsaPXd+ZsO9AkkTh/ZMwlfdaTnLfeKkBgC90fvcqFijbw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=h2gb3JkM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200900;
	bh=SlOjQpAxr563Or8fG5V5FZ4ccVK8pvFWYcBhDPn4uug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qvNKIIjfYqk7Np05/aXvR6Ss8uotDr1DXCuWAJUP66/FVA9k2axcIeMeIT5lV7kr3
	 83sNm+/u3w/QyW7UElbpijwWngkMSRX8pzTaLLev++/bRrDePQ164SmyLilg53t6AD
	 TrH+7mK5BDydWV57NdGjvKmHkGnE2uzhQmVElpU+3WPmQFARnZcjg6zTpiL94/i+B2
	 VacfgJB+GZgcp0LSel2cHaXyknh7bnUl7uN/b/qxCp2QLbrcD9lP9s+jsUInr3PEU0
	 x46z0217f6XE7MBTM5Sbz//lQ3C5VFbPywOPVPD2laY0PdmnsBljiMa+H2fu8xK81N
	 gOxh4IjxvQBtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58CB44064F;
	Mon,  5 Oct 2026 11:48:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5661B32F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47DE740609
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ffv_9UFoZUNQ for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:46:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7EEFE40608
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791200782;
 b=te7H+iG2XSzJIvHc41b0F05H5hUeG0U/keBnD0kn1bfTWuvoFFdwdqT1U0yaH0cpl6se
 qg65CYOvR8rtJgLY78Cqg8DU9E6qFchKmZuBCeFPne6YoPJeErxlWdAP6L8ej3bHYqj5v
 e0yRPFGa/5EueGWS5iBc2DEAsTDtW+679LEDj+/8VRKWkmUM40aIKbL5629jxrXqXuR9D
 VJcDotnudFTa0TP8YCZv0d5VMmwo1B8JKvSFAvX78+W68BI3PnUficd0pm0sKN/tgA3MF
 TYuYtaw9NNed6vc3ikwKCHE47zkXU7wWCijIxs6MTb/lcSmLk9ULdGB0/nokHSOVS7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200782;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=SlOjQpAxr563Or8fG5V5FZ4ccVK8pvFWYcBhDPn4uug=;
 b=cszTskutALSfbaof134DzHISXkkqDtXZatrM+Neu9xHo7i8B3PTOO96kH8suskr9Gu9T
 nAdcZNJNoICoRTE5DxVr8RdK5e8ebU4MBgeJD6rkbV5JP02j9c/43actkvDepBDH0yGOI
 GrEYuRR/1yNj/Q3gjDgM2EroEQ9LTbNKQlDOuzljiEBp+p4QpuAsuZMOEGMqAWRrVQn2j
 OBEVk6dwBHai+62sp3iEe5k8fpOyLmxpB0c7nlBxV+JpJdBMP6SfGjVsq92Mt0V754d6m
 P7H1BV7cV6Y9u1d2RIdzutZwNSnZ35sqR3kbzd/P4w28gyNw1qOoo7pMaLkSUYH6h7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=h2gb3JkM; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=h2gb3JkM
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EEFE40608
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:21 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hyyJn5g3hzMlVB;
 Mon, 05 Oct 2026 13:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlOjQpAxr563Or8fG5V5FZ4ccVK8pvFWYcBhDPn4uug=;
 b=h2gb3JkMqptj4Px1ViD+ry1XWCEORB/zgHnrmsnOoR0qmWbrk9rd7tVD1GIsrJPp3Km8wK
 ubV+ZgDtVI8MyLujZlMTxBlUpuKwIP+T0aEqT/cxyO7MfhG4BBS6pSACje6Whn00RmChAX
 TfWYt+GctO9/LMq4HYGf8H8Qb6GY1hZ0POPQFQq40mB62w9v9H4FGOYnHBwP6xAdJqxZDV
 O9F8+lieM3wLM9P6//b9m9FlTUsfm4u0o+ApCc0Lc21XN1Zm9EdLIz5NeSoDve0k9m64oT
 zE5Dq0IqOLyDL5+9Dxh1NQxbq6OpKprq4kqMXwNKdLVqf4zw0KMOQMoD3QswMw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>,
 Dennis Gilmore <dgilmore@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] arm: mvebu: helios4_defconfig: enable the RTC
Date: Mon,  5 Oct 2026 13:46:09 +0200
Message-ID: <20261005114611.743343-4-stefan.roese@mailbox.org>
In-Reply-To: <20260930-helios4-rtc-v1-1-0e6ea4ce400b@iav.lv>
References: <20260930-helios4-rtc-v1-1-0e6ea4ce400b@iav.lv>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hrqktsya8bta7ewuek1nbtf4u57a6mph
X-MBO-RS-ID: ebc5573583977bc55c3
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

On 9/30/26 17:26, Igor Velkov via B4 Relay wrote:

> From: Igor Velkov <iav@iav.lv>
>
> Helios4 has the Armada 38x internal RTC, with a battery on the board.
> Enable its driver so that the date command reads it.
>
> Based on a patch by Aditya Prayoga in Armbian.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Applied to u-boot-marvell/next

Thanks,
Stefan
