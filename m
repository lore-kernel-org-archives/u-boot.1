Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639B606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T0zVGXrn;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=klorzuSH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC75D60A4B;
	Sat,  7 Nov 2026 09:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAAsIP7gPUdw; Sat,  7 Nov 2026 09:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7EAD60A3E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042157;
	b=I2hO0/gwkBaIsKGiUWli9JK0PBx7AvmFn7Ajjobv1ATjnJ4o4LTzA9yEXrbnnMjEBPc8
	 4uhHMH21SxI7qzWXODGnuBR6utPFyAuOVOPTf/kpr6skspm5L3cWlALej5LgKlI0NUz5N
	 m6TzwS0YnYVxjL/Rc2VUxy3Xwb6LNzmVMYMZE84hoCWbFQMah5I+lqEbi/AcXdpQkcXtd
	 N4olqE+zaVggxI5wIB2KDbU1G3KR06KvlK4mQUkYwNYTO+2DDUZPP6LQ4L8i6w7/zz+pz
	 rkxHU7kpsu6zbmIPWoZYD1qTVnqyocF4OzR8SZCeatl+LuH+YmAusQIa3OtLzk8TfEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DTSeTczEoVUy/nw/x37dw+Zv/DDzEmN9zkRGfVYKrNo=;
	b=jhSE3aE40eYyAnZTXc3jhZj/ZnuK4FWs8Kvv7h44Kk6L16HbI2yVo00s+HeQ9MGgN+/W
	 8IHgpJdI2f0/QY5BMi3hNa+q+ZGFo4RaONYnuSM3VNA+SsRbqXSHz4PGp/DAMW+q1zFDq
	 MZpffhym1xz8OO0Py+uvmaMU8gxxe7rUtOpVJ0S+BysGA63GxlfEvNdZPASiKGAvp3wCU
	 CbhiaI4ZewqfV1H8GEnXx2VsYkodjgxClyOviBQywxA5imf2ZerBC3Kv93NxgKUmr6/iY
	 Sjq83fQZ3Xvou1wE1nEEqyv76IG6ge4CoVJ7XwYdw/XWgfce3Csa1Pm7u1q51aY2NKg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042157;
	bh=DTSeTczEoVUy/nw/x37dw+Zv/DDzEmN9zkRGfVYKrNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0zVGXrn80poctfAKaKjkCPSU5OgHbn7wRFLASDWAulEKQbyOobDeuhCf82AIAF5I
	 QYOp0oFdsA2y6g59IoPdR9+IZd+zAPVt2+3lg4TZo/nYrIf85lrExa+dlWrQlHpYnV
	 vA2CXVH+UNEs+27HISm9Xys8d2s2NUrhg4w3mAbq2jKyjUg4DMibvmZEyO6BhQgseK
	 oeJbS/d+rk/UK6bos8a1LZ7XllEEu2xA2ozgqyQus0VfPtQddnOPenTTe06bnFqam4
	 WCnhyW0vg7DsL8tQ9A/t7DhE6hSxzTFrFV0M8WKdK3nYPib02qUUlRLBkrTfk85/0k
	 E1HAl+BHOPMeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7EAD60A3E;
	Sat,  7 Nov 2026 09:02:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF28937D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D291240081
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Us7BuYdUPTxN for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:02:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D7CC140042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=klorzuSH
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7CC140042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:02:23 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jM96M13hJz8v5f;
 Sat, 07 Nov 2026 10:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794042139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTSeTczEoVUy/nw/x37dw+Zv/DDzEmN9zkRGfVYKrNo=;
 b=klorzuSHpcQvVy/HbryZ055HjXTRUyq51Y0zhpwlI1d33zydle0pEJC0oIRc/P96qLr1ru
 bnW7QDddJ0cvqYTCU3oUOPGtngrQJRWiOcl0jbx7gLpv4ndtekuhR1S6TLwx0J0B4h83gM
 QMyPBvIxVptel4jGwV0VwagSiNDvWsFUD7Y4jSWE5cnsdnLvRXAR9zbxAxmDvMqurLuTTE
 yfe8r6c5oU41zzFVw9eUtT3tabJ+vTmmiV3jM7vXcDkowBEhV9xij4cfbQNqsCWibX4fNJ
 vTyGSyR5skumeG0z+92HgpgxQ/f0Mnp/rBmL+0301t28ja8dRRh7npVzGotKIQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v4 1/3] watchdog: Add support for i6300esb
Date: Sat,  7 Nov 2026 10:02:04 +0100
Message-ID: <20261107090206.2015512-10-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <ac8707e106b9fc91326ce64d983e9b12cd0a61a3.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
 <ac8707e106b9fc91326ce64d983e9b12cd0a61a3.1792320756.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: whsdszzcw7bgy1qrsixnoxkqe3tqskoy
X-MBO-RS-ID: 54376dd33dfa520982a
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

On 10/18/26 12:52, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> While the real hardware might be in the museum now, this allows to test
> watchdog integrations against QEMU virtual machines (-device i6300esb).
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

Applied to u-boot-watchdog/main, with a fixup while applying:

  [sr: use void __iomem *base]

Thanks,
Stefan
