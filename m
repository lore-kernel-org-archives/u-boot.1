Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C37CA6004
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 12:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66A4340969;
	Sat, 10 Oct 2026 12:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Y9N88nfB0Mb; Sat, 10 Oct 2026 12:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 941854095F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634879;
	b=mjAnKYg2A4n7tQ3/HDe+q/AVB/Izwa75KYmpU9+g3SuInibvQGbBqxvrqAqPdW1y7myc
	 tjig/yTsoXXIj/rBP2ge+5BQtZGQbR1g5WUpVONMsjEeFAOoazv6CHDHFc0V7XsruQzqg
	 oEZks7NZA7nfgr6CDKmwXgihZPnnJoblcz13AZrXhfP5ERkHvyv1I1jLRCQz0z1oUj4kx
	 0+P10+yITiae/3NohBm7VOuMeUl9vvUpze/gTO53ak8t2szrtmjAOmsDyaMV8k/PERF/I
	 r83nrUCVBmO/Xn7QigZ8ThXWjVPssCxEPt3OeZ/v+IFFGIa2ywpWIkInlUwg++8F+5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:DKIM2-Signature:
	 X-DKIM2-Info:Message-Instance:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=na/BOmLKDniLwyc8Q8jmYwNKwSfft9HwW6LZwntSZ60=;
	b=i2ef/gvKvRkjcY9ewPQkvq6cs+9q028Jjbz6/b/05HU/mS9uBBoLV720jvMCQliOJClK
	 QzJi5kqOXwlRU/gmgNp/XorEJ1WpsVllD+xj/ePDuWBmVcCBJgACD+YF3dybXfadW8b4k
	 4KXeex3ML4L2pEH/q3MTBpsCgu/CjkLGF0oKirovXPKYrbN9MEjZj0Es1ygGEB8piz0HU
	 gvhfrz8diY8M2/PFuKmCitafP5rf3KVByY5yYr7kNnQu3I9uGG38cflrtkgmTSUdIZ8ie
	 N0Vz2Z92JF1q/EekjMPGa+6lkbr3Ipjgi5wUlpPxU+PXtlBa9ZieEztsUK/lWIgjrxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791634879;
	bh=na/BOmLKDniLwyc8Q8jmYwNKwSfft9HwW6LZwntSZ60=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Mag2RcsrSqCKoxW2GCThsX6Pcwg0RhZYN1CepKrnEU4fII/FHwk/2sLhIlt05JWb8
	 70EPs4jsCznnYohVf3GXD2TZbATYfXEaXL3DKX2q7L0jA9J1hBMWYRQBFrNRNnKK9k
	 6GFUxdT9xYlOdsHaSSl6CEj4v9MmIpD9pfRr7bxiVi0J5Kq1+pKrL5WxcRQF38tqDp
	 p4FlrN1mF/h8cDHoY3hBZqiR4ikvxsQMJIaE5ULDLHC6533vK46XyluX3czKkQz3qn
	 MQoyQVxvqP5g41c7k3GqSLCxnYH2zOiBUDdYEdQ82y+Q2Iso57ixBcEAfiqtYIk2th
	 wwvU13Zas6Sxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 941854095F;
	Sat, 10 Oct 2026 12:21:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F3C2156
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00DCD4010A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5lmJ5WfA774 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:21:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5CDDB40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634876;
 b=bmhL+75S531ghksr+awy8mUztA1njqO5RKULvF8grsNoF0n9nztprVFh6vB1qTzQRNkq
 wYL76mIq1pPxp3AY2aOLY6KvjbjzRlpOAwUwCwXxaDkxkp0KvZUkvuM9JVugNBqbHO48r
 VdzJztF85FlskKHHvMk7pjRRQnajH0uFYE8XOwC1VFQHYpXhoh0nWIOrLAO3svvC77whh
 uTVxH5zlJ3IIwAqVTMRP9WOLCXK8sHHJLoFzu9/vwkqLHzXogreKg7RDFJVsr7LPBHv5E
 3/fsphHc0ZaULIDzrOWFi0ypJgThEdcLWhkzI469gDD8cIVRR4ra3t6R4YoOwTQFz4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634876;
 h=Received-SPF:Received:Received:DKIM-Signature:DKIM-Signature:
 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=na/BOmLKDniLwyc8Q8jmYwNKwSfft9HwW6LZwntSZ60=;
 b=SJSl8G1oE89UeXOcqgxUxoPlfWVFa6W337nPTHRwEdXzOGzC1mvuPWZW7ODTzZhp5v32
 53qXD/JrO7MhUEpSK9b2XkxOC/Sa7tPkhLh7RNzuzOo/v8zL83JYgGafKotAwM5q1LeA0
 umzG7YzAoDlpj3cHjik50LTWYfdlhvi/oNxsDaSzg8QOoEegDMbuPmJlFXUxyczoZ+rhI
 wGLTulRcc8kGcj1tJZZBPGwkD1ne2m2zqaYvG+9ejYXKylOmBtpq3xnB9ozHbsszYBZbr
 hEd9TlodtGKWdmUZCjkxmwpAWkwti5RxmM2jgesB6Xck8OwP0bVAJ9qTByPVhOLj07g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=jannau.net;
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm3 header.b=QIfzrkoe; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=q4AYigQI; 
 arc=none smtp.remote-ip=202.12.124.148
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.148;
 helo=fout-b5-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm3 header.b=QIfzrkoe; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=q4AYigQI
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CDDB40061
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:15 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 5FF331D0008F
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:14:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sat, 10 Oct 2026 08:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1791634451; x=1791720851; bh=na
 /BOmLKDniLwyc8Q8jmYwNKwSfft9HwW6LZwntSZ60=; b=QIfzrkoeM7VILVFsyR
 fY8JFRBPgYEAaIrA7ntK8Zg/QHZqFxjMOrEmh5MQIOiDh1UrxXwV58YW5qSquHDF
 SsPDw8X+7WdPt1ez3fHY3JdMZUq3k0uvifjRHOVcD7AjQwJNjICkEL8PsRl5Xja9
 IA8lhHefZMWK0DuCWBS527gXGlkf4XdzuynnXSVufr/V0sN0VIXRHFBIffSQlnCD
 UKUEh0stJfJsP2GbxLeYuC0mm1gW3ghq98I92khHAufoOpKriDxVSXp4A1mhRiFG
 F08VZjI66Ec6w0QnNb2MmY4Ko5vFTz2wyxQQx4Xg4p57PAZPE84Xcaq+2K/W5z+1
 4KFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1791634451; x=1791720851; bh=na/BOmLKDniLwyc8Q8jmYwNKwSff
 t9HwW6LZwntSZ60=; b=q4AYigQIyyTggFdlzrTEwQTMP1wYxneqsMK1Wg/biaXd
 8ycqvNtiWxUDDPQ74mPuOyc0xcrtroKgqh2mEccajxG/Ascbfb8OAqNMrawfbOsb
 Xlp+XQkJbb/fxd0W6AoUXdSGDHGwuYZGxCr6Fkd75B/Gjc6m+I0ZVTgdtFZz81O/
 6PWmBfZA0fKHx9AsOHTpmxIqN4573EiofhgNwvIZ1JhK++x+nfViUG2DA3ICTCdc
 KXUVRObRSgpm4ljBbDT2zLeOL5PcWyPUMwiSxaDlyZ0NzDjFnN2z1aRnd2ZWX0E/
 kyZfirtp+FfW5LlZO4dJwUErQIgidU5XqcYa41sLSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791634451; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm3:rsa-sha256:iEBcbHJLkdVx7IKarsQ8gkX2tZyzA01Ti/WoCW8dE+AhYFG
 kYwP0MaDBwsh6SNS7cBuOAnzZoIYp398AYPtNP0xSvzFSJRO7U70Q3LN+hjLWGgV
 aFdsROTkEpYVS2LQAOvddJk8GuKtdmeeyMwlAH7xH7sJM/Mfn6Pg3MbC3zgcUItG
 XmZHRVPrq+P9dr9JoY8lDS4806tlu/+HFJ7A147HKQ6HLI+bZSqROXbQzDqntuSr
 LUZ8myB1MZM7K3O+TVGX0Ow5ADUyf4yIqLQKvoSGM9Eiyw0IuCGLmAkIzNJqBE6L
 ULMJnoCpy7IKLx6KjjlYMOlEk37PcCHr49GqRRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:14RfFmW7QchgVoNqEA1i5FIA/oKLPd3AnV629dFr6lc=:9uoNm3loMti+a1kl9gOqZSP8Y1r91wz7x2gxRJI8IXA=;
X-ME-Sender: <xms:EyzKahOFuf2vqtH-oK99IeQIviMIWCyPM7BlpV-vIRvIal3hkvm88w>
 <xme:EyzKat_Y-VFrQwLUXwanQY2zMdYC0IStO8W873XzN-bD1ahujGS1hgQluV8O9CcCC
 D3mtXgpF3pmFIPm3eqGVzh-LdvgR7ddV08vOah8qqv2gnD7DggkkHM7>
X-ME-Received: <xmr:EyzKam4_DNhSUle9QzWfV9as0NKycafBSWPjhDoP-uzwwZR0V8wCY99xXQLPaeCt7lsruITb6XXx2oFy2Tw1H3RtS_4Q6nv-IRsRHg>
X-ME-Proxy-Cause: dmFkZTGOlfd9lxVbZAbksuK2c3UdHBuGHviZPozcrkd7LYgtcn/b2BciY8cQiL/N+8ygvS
 M57BxIQ5TLDJcfOGkiJCDKQGyKps5QcATwThgBWYdbHGrne9gVnHVZSZWsX7C9w5XojJFP
 cJYRibGt65K8YAJpAyjGW5Czz7r59O0e7YK4VNbIcXolmHUorgFyZ6wTU7lPDn/pa5ReWL
 bdNE0XzHukPP05YkRuuB/yplItnAiNZGrrgREZpqMkIYqIKszNv1Z1oup4jxEEGIEpsGmw
 h3mIu1u7+uA0psXqfSsQwubOHxi61mKef5oqizd3qJF23CteO5Br1NOT/n3H70ZnsTr7PL
 vDK/p4XSXyrlP4ni0AucgigCAgkQ8ct0GfPx2eP6QT7QRaG76bYmTxsB3YVO+ywqZMIe/a
 M9ADEJGArnxIinsfEBBzbbbvSXX5J0myYzKKFWiqGC0MqGTMhPSenz5GxPQSC/Wti6cwmV
 RDua6tyTs/hpdwWlaNiSaPqADX+y6ukMGLJ5EGy9AetTKJswWr0RCbVe//LEej8vdoy8gR
 GJsUGGkHz3PsMSHqouAvuh6pU3Xe9PQRbIpTsRM5xiBLACryusUliJVLQV7R52ph8/5Byf
 vN2EYW+/PMfgnvsXMPBJW4AYsAwZpz69MhAdBfIQnD5DT/Rxj44ze6zuFAGQ
X-ME-Proxy: <xmx:EyzKar7TU7zDGT4Wt3F0VIkO0XntAZynvVsAfmKwwmcVRD_441Bk-w>
 <xmx:EyzKanos2fm7N6Z3DnNE2h4ejj3zGzWKj-Sstjxoh7BW9aTSw0RySQ>
 <xmx:EyzKakNsmX7NUpw1lC9behILJlbrozseno18iAdA9FR_1fJy97ayMA>
 <xmx:EyzKan0feS3XLCC-jFj8oIoEj-4eWKT8XLgycwN1kfrLyBa6D8Eu9Q>
 <xmx:EyzKam_VKMUG-orFlurEv82l3dwrovfDMYkA34TDuvzB1wjTsMlO6Xzg>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 08:14:10 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/3] Apple M3 Pro, Max and Ultra support
Date: Sat, 10 Oct 2026 14:13:56 +0200
Message-Id: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQpAQBCA4VfRnE0NYvEqclgMpsS0u6Tk3W2O3
 +H/H/DshD20yQOOL/Fy7BFZmsC42n1hlCkacsorasigVd0YQ0XFjf5UPVzAho0ZLA1zXZYQS3U
 8y/1fu/59Pwd1Kk5lAAAA
X-Change-ID: 20260907-apple-t603x-support-9e77ba0bf855
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=9uoNm3loMti+a1kl9gOqZSP8Y1r91wz7x2gxRJI8IXA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxTOgLeVxIY1FMvnj3Wa10yO+1iuIjy9h05cQrlqd5ev
 oZbPE52lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmIj6fUaGNplZb/20Px/Pi397
 0jz4vkGX+8nZ834HshRUKc8t3mHVzcgwxfNvg8p05QWPbplafhJ+Ntl1hoCQj7+U88obXHcmnb7
 OCQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Hej,

this series adds memory maps of M3 Pro (T6030), M3 Max (T6032 and T6034)
and M3 Ultra (T6032) to arch/arm/mach-apple/board.c and lists the SoCs
as supported. It contains a missed documentation update for M3 (T8122).

The memory maps for the SoCs are becoming long (alomst 1000 lines) and
Apple releases multiple new SoCs each year. I'd propose to move the
arrays to headers (one per generation, i.e. "mem_map_m1.h", ...) meant
to included only from mach-apple/board.c.
I Can do that either as v2 of this patchset or when starting with the
M4 generation.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (3):
      doc: apple: Add Apple M3 as supported SoC
      arm: apple: Add Apple M3 Pro and Max (t603[014]) support
      arm: apple: Add Apple M3 Ultra (t6032) support

 arch/arm/mach-apple/board.c | 224 ++++++++++++++++++++++++++++++++++++++++++++
 doc/board/apple/m1.rst      |  14 ++-
 2 files changed, 236 insertions(+), 2 deletions(-)
---
base-commit: 5508406582f6f7120dce0c4b3059819a41788db2
change-id: 20260907-apple-t603x-support-9e77ba0bf855

Best regards,
-- 
Janne Grunau <j@jannau.net>

