Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6436CA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 10:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49936408E8;
	Sat, 10 Oct 2026 10:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcBHfewRW2mq; Sat, 10 Oct 2026 10:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 12ABC408EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791628602;
	b=RbqbssIi4QXqDiGSRJGy23CPrmhVjUNXnT2Xn7rnC5Zc7p+9Vzfhu7IQlvQJBgKREPuc
	 XfL5/E/EMLpeubniBIq/DAKTvVCM7v1IEViQtIWglipMcT2lzUz7OU6fTVpxvdxmt2oMD
	 JbXWpOJ0jnWFzlO+74KUzD2QJoZbn3PCSDfgs0x/Wn3yws3Y8E9aha6dwJSs0EVVAbx45
	 BZc51qLXHby8sTFQnQ40DllwsG/Iq28MuwGNMzDgtV4o7al1sUWyhLzOfKq8x9qN7zkq5
	 +8aD1pF5LupJj05aIA2xPzhUnZaGO4KVxKPuenvsEgmM8VqbSgBvgs0oO1hYOZiq5rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791628602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5O83XHBre9qgYII00oYlCWGk+d+KTr4+959G/u6bXNc=;
	b=O9lisBbYt7rIXZpNw7Dm/Yx5ae/0/fq+hM4o8K8x1dcTiSKBWQOymldxhebG12SMbrv7
	 9fQTnvl+YWK+bGmQg9+qAII/40s79wNAmaSTiKNsh+2WP+ApO9niqF4JGSyxWbnw4rUhG
	 JDkseULu5OSLj9pmbvj76oV6YGKJQpqbJau5mtnjeqRpfZAuVY9lc0weX4a+wLUvVYTUu
	 fBL/2OJtmJa3x848XmPEAL5wG3Iu8dHu5XbXhmu0hbQozGNeoC5Ey8Kpavb89dOgduZqD
	 81Vv85mjLKI8CbshSWkoxxxHgI0SVPfAE5531N/wBKwopkjrJmeNm1eoDSL1blhNkGA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791628602;
	bh=5O83XHBre9qgYII00oYlCWGk+d+KTr4+959G/u6bXNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VpSraNiUGccuMopa63VqoqL7KucxYLR/dkPZi7jdtf7ALbrcHB0d4zVVz3m3jjdqe
	 HfqX9zTI1UslxnOuMXLXa02IDCxSSzSJUBXT/DfKV7ESseZ8gnLnyMjFZKiRDp858f
	 M+w8UuvHgZfsiHcbhbOr/2oQBlIvYlF08781JmBPcRiorxi1hkRuFuofDflNgAzMGG
	 ZYRYUasKx5bi3eM1QJ2phB2PW1AA95vDWcgmRvaji17FJoEm5E5EtDKKE8iygFi21j
	 Gj/vziVeck4PoPA4arN6OzUlK0AhYeWQGZg9FhPJJj1nfTAZ1731+r+Rsn1BnPg0wA
	 TDStAOMmek1Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12ABC408EB;
	Sat, 10 Oct 2026 10:36:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FDFA105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 119C26066F
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Wb7zxEH0nXn for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 10:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51BB460622
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=43.163.128.53
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791628598;
 b=BakO8pN80D7McwopVSoZUzkE5EQK7RBr+AyVGx/zurEGJQB+9RjoSMnucsTuS+E7Yl3Z
 oXo7M89l9klQowNMT+tXGMkje8UgULRLACJ68QXw1TEmPXNtQ1iwWUG8H3vIhrJPp6LQ9
 JM2wotv+8/qAPChjfuz3U1FTS5hNlcXn1Pefdg8PwWcZlU+zXRbqn599G99a6V2+aNbnx
 PrVToUHE++9CvtkNQPVowdbPybFzziH2AnH7ukmUicFO6g6/PWX/yd7dW/B/y+NF16KFW
 MyL3IfLHxxp9pkun0SWXpa9GaASCXCZqhQBg3V1JgMnWVZCqpcGORTYILRcQ+tJd2ZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791628598;
 h=Received-SPF:DKIM-Signature:Received:X-QQ-mid:Message-ID:
 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5O83XHBre9qgYII00oYlCWGk+d+KTr4+959G/u6bXNc=;
 b=jIuOxtXj7BDtNW7P+zVcZRnFqzZDJv0pfGobaa/tujD3LhsSnPlfVVwmhMnloG2DxO9p
 HZ9Ms//aQEXiZRc2+cuHLleAvrKTCUlCt+8zppm2JNzRafAhFcVfrvouGLvPHgudYf8fU
 hU7VIhx5y3kHN6MKSDk0aFfElX8v1FGF6MN7yyPx7fIuAYNrOAHjvl3J5ZTtBz6qUc9D1
 QTzDP4eA4DLI3VtqgaxLOt2b4idrvIdK8ahKDOGvk1xvkZN7rqJCPuyT1E/jgpz7uCTsr
 CyxjdoK9xgoUHdyz6uBLP0K2sXponC5R6HGlESRzSPskv/HyTMENZ3yy9BZkj6RymYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=qq.com;
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=sTWZJpJd; 
 arc=none smtp.remote-ip=43.163.128.53
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.163.128.53;
 helo=xmbghk7.mail.qq.com; envelope-from=3305708832@qq.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=sTWZJpJd
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51BB460622
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1791628587; bh=5O83XHBre9qgYII00oYlCWGk+d+KTr4+959G/u6bXNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sTWZJpJdApcKFL9aaDrzzhVf7+NvE88npi54oeJvTXdAnEFB84ZhGVUa21OdJf1Cd
 qS+t9lT4HyMXQmzKdQJ12TFddbY1zxXCdhj4F0BIZ5k2GDk2s3cBD9AZgyxWcElhAq
 K7PtFN2/5PumAUJmXK/YLcLvxJ75cfzjO0hGKWAs=
Received: from kongchen-VMware-Virtual-Platform ([39.144.83.23])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 918A92F5; Sat, 10 Oct 2026 18:36:24 +0800
X-QQ-mid: xmsmtpt1791628584tsnieci31
Message-ID: <tencent_924BE60D577A36C3C73341C86BDA51838E05@qq.com>
X-QQ-XMAILINFO: NmhoXJR/eu5xrg8TfJ+P0wSAiWC9SrMGvGH/s/ciZ8GnwlrbIZyAg3wBZi0yj4
 BroIT09mRcLrntUrggnEigdJCsBSg58vdCwOrMZCvhoxAx4MRcPQ50pty0kE7tomiMV3urskNDKk
 IsmRd/WFIMf6UW32yHezuq3WEZwHlvHogjY4/uJrWUG7uPHvEW2sXHi5fG47rFJjS+tm24Qtsdmd
 3lCSP65AJ5Jp/+rfQWiyoRQ9cpcKwYnyCG3+AjopiNg40gZY51/05UNPZ46wNPos4kZTAEru1Nmt
 U3zu0trA3DHO9qEP6kEHxQyaqK8HdpH97pRJ+mqXV00K1nfLCkug2vxrc6hMhjYuWkJZrkx+y4sn
 c8cRGnGyXPfR/7ot8mnykob8vpdbvn4oWkyo0D5IpSU1AKYJPEO9MHza77oW+TdR2oXvI6jPHJYK
 kkxrS+Hhbfn/7Ol7nbwFNEYdxmp1EsTZydHIe3W9GBo5pP5eCN/G+vtEHBqMTTRaTPVcv/k4ab9Y
 V5dg/LjfvF/KXN2TRcr1eVOQ31G7Nin7/K3m6uAJjKJU8kFYaKxbxCa1z1s+M13HaCguTfsDK/jk
 d0J57RNt08NZkavxOlbg3W13KrXFu6SASopIsBBIhgJUhGUOyQ0LH/r2VcyitrB3tJzNXxnp77hH
 PyR3rq6o7V5J5Do/11pzJdKoboAZqxwTnknhm/CYTTQ2iTXBiPsKefMLQrd36+ZLRIPGrmlM8EcP
 gB1K1QqwWSax14qpKkGKAsN4QfI/Pt/1Y9T++Pv8+2ReUFSJb1IrJ+I4E0mBGQ9aYF9BPCRJz92q
 1Rr5knRxY87EXIRd55jURrs5EFvvwSWU+pNUFo0NtG+0GRca9QKjYZ3+uKQgAUsZmku+BMH3ezLZ
 eqWXhJRBVnSknne6IPmOE6mEODfWqfdCQYTkfWehZE7TnFFuPkQ+bFQ2gZQEBGALEdOWgYc1Seax
 LEIP7bmvnWeVmFukHBP6ZYX3Dt98U6fUZzbWYrqlen/3RvpOnR33NhhxCUi7nbbJ6YxxOE/Sp3km
 oe5eRRv+xT5j7N4qwFNj/3SY1bbVIR6HXYpLhAy3/Bu/1XgqvbbpHKCe2nZ2Q=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: kongchen <3305708832@qq.com>
To: jerome.forissier@arm.com
Cc: quentin.schulz@cherry.de, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] net: dwc_eth_qos: bring PHY up before triggering DMA
 soft reset
Date: Sat, 10 Oct 2026 18:36:24 +0800
X-OQ-MSGID: <20261010103624.6747-1-3305708832@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <057aab81-4cc0-43c2-9d16-36c36f221e8c@arm.com>
References: <057aab81-4cc0-43c2-9d16-36c36f221e8c@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Jerome Forissier <jerome.forissier@arm.com> wrote:
> Applied to u-boot-net branch for-next, thanks!
>
> [1/2] net: dwc_eth_qos: bring PHY up before triggering DMA soft reset
>       commit 1a5da2d56fbd9027ceb7977599d5d793ffd1eb7f
> [2/2] net: phy: add support for Maxio MAE0621A Ethernet PHYs
>       commit 8f3113936ba37844cf39574ea7914e3fbc723172

Thank you for reviewing and applying the series. This is my first
contribution to U-Boot and I really appreciate the smooth process.
I look forward to contributing more in the future.

Best regards,
kongchen

