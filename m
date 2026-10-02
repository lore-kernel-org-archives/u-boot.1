Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94808CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BDC460BD3;
	Fri,  2 Oct 2026 16:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XBzzJDF0eJGo; Fri,  2 Oct 2026 16:47:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C49460880
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959648;
	b=KJcKZmcpZlNocYHMabi7RSnZ8uhBECc4/SD2AbaBNpdLGLLIZZX7WmCBtG8LWgYKim1q
	 QXGM+6GgKHbdi7ZyKSZa4QZ6H2vaEyIjMLleSl4F+WxHiU503mdm0743eqsmytEBLyvjB
	 K34qul1J16O4xJwGHbdYZqZqRfQqRg++xHJ1Lejd6bDDwrNA2xJ4gC24YJvtho2mAokYM
	 Hz4RBXarBQNZdQ0O6OSmEhEkcmXBwQpEyOSpSd47kTy7MaHrHEE19NXR5zil4PauAYCgc
	 4Aew02zgXfHe9jj5ZpOc6fFTlfWMuuNyrEX1sqIi4jCaR1jg53g11vB5pDAU6HkuJpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k51gsnXu4C7kOv4Ei2Ns8eHyajTwfbVr+I8tGSDtYR4=;
	b=ORqVk88qG9G66xsZn6OjYfdShpNZy7OyaZN8zrqq1reiA6G9guBZ82byM073BVnTE5qD
	 BfDvBmmocvHia4ISkWeQxZTuX2KPHjjO5MFRLzSma+HxTgqNTb4pSF/YZ5qat+f0dPJGG
	 ZIudGbr9ZHBs3loD4jBWYHRYwGgUgliZEiIRws8OO3wIB1c1Z7PxDPnLDzAd5VcOupOQG
	 S6l7/HaJcRbuUe7QrV1n73s6E1VfzWVlpZ5d61OiwtlTsniGRzQvKN1DST5xm7vsJkL0y
	 QxfVxAKYVtzsDhZsvtHqn/BirJ9Ex5nPPFZKZiDtfcVVR/gwYVtyA40dH71vgsSGyow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959648;
	bh=k51gsnXu4C7kOv4Ei2Ns8eHyajTwfbVr+I8tGSDtYR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ShVBNjUTGnmd0uuJjIz3ONAIJuaP97G578GR1FG1kgxIeTSWwDm3a2LZ6a2fuF1vi
	 FR1xLhovaVLCvE3ru/ARCg7RMAxTyDj/EuZ0+CGkiO2C+MmUV0fWGJ8EJX5Q1XFNK8
	 Ks7t6Rk6XCk9xyn4cB9PM1m37G9qhJdt5FJTK5qHY89gM/JL9H7VjWpw228rNjafCV
	 Mlp0gbvtOL2w/o6m1CwuGULlLTX12T00NqOh1ZEZSukXwwSUVXQV2c6iQxkHPXyUuS
	 U15Lbmrfutv91pG9G0lSYXeVtdl86J+KR1m59ZJhC61Nb/OD/t01SPSWpuAp3lKcks
	 BRIN910qclCPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C49460880;
	Fri,  2 Oct 2026 16:47:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45627435
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BA108115D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5Xl7r72G1xG for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:13:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E230A810B9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946827;
 b=cKetq5A0jD3PZp5AXuqApGG2qk3Wr9JsFmWlgPBDcJjCQz/AYShg6m+AzPIqzDV38wf+
 VycCh1agbtP5Yex+tPpZnYT2aUO/8PzmV2ldc4gEFkhpdOqHuBonkZtLrMUQuFiVCYB1X
 S/8sGvtv16jWqgrrBQdRkh9qpuwRQjEnCGd78aATDnrXQC6jeQWHs6fG+sRUzZMP9RXVq
 sFtsPloHlhZt6Q76rcSlI+a8l0+bMPXKwiPKly4COgLkcSsB+r6WAKz9NBvFiNdRIRWGK
 pIgvsBsFd75NoixJI8cP7+mDfVc1YycwE976bzlSdcooOpSXHXUy7HkdGJJdQGeXm4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946827;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=k51gsnXu4C7kOv4Ei2Ns8eHyajTwfbVr+I8tGSDtYR4=;
 b=dR3fdcrEkYFrd0FffXvlAUbbzVOKYNFETRQLEeAGX5LEdVuzgU3acJotpTnYrd+ODK2c
 xbWzpx/+NH0OX3MD2ulnOvmi+KH/lpYQk2tWCnWGdX+woIljbM4wxj8hJRhZF7TLe/1yC
 qP/Qu13wPi6LWxMghkjTYIVWPyssH6Ux/x6tIFBuqOTN5PWp3hY5bNE0G+YNTghBlyYLo
 CUtPRG1pocNIMN+pt4hkvydK1Vc9dTuD/2JVoAI+9wz3piczReGd36b0xP8GX+cXUWgN4
 6+ooI+DhVO6VhJ4mxaOQ+euPmQUZ2vxAlj2yix5oRFV/ydM5pMfkM/iX5Po+jq6NfLA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=xooaldW5; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=xooaldW5
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E230A810B9
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:13:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8EAB41A10E0;
 Fri,  2 Oct 2026 13:13:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 61FD6603DC;
 Fri,  2 Oct 2026 13:13:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4975C103281E3; 
 Fri,  2 Oct 2026 15:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=k51gsnXu4C7kOv4Ei2Ns8eHyajTwfbVr+I8tGSDtYR4=;
 b=xooaldW5ofOOlksFIykU8iu2485ycC9B+6n+ar49Ri13phQ/BpfBADtoZdZCG/eu3zOv6A
 8Q7fgC/1J/1vx2v4CU+qW039Ebz3R4zvn5UNtSAJpSnvYekmqlgBHtc6VPJyYcU0iVTQ8w
 LNQl3M2tGsQbKlZNscoUlIFsrag7O86aHYIUubd4Q4io8qOXjxUJcK6riavnUWVMXY/5A0
 010ujNuWQURBmOgJZIE+v61ZuYtISoDn8vZECOKAzTPiLVf1pmKiq7h57uleNa3usyJJuJ
 VmpQXrC7ILDrus1Yd2hMUMPU8ohkcuo4njJgvN1wvcZHV/lHIkIS04YJlos0Rw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:19 +0200
Subject: [PATCH 01/10] iopoll: Add readw_poll_sleep_timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-1-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

The readl poll API with sleep and timeout support was introduced by
commit ce786ae3913f ("iopoll: Add readl_poll_sleep_timeout"), add the
16-bit variant.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 include/linux/iopoll.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 0ee2bddaa83..ab2f363f277 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -46,6 +46,9 @@
 #define readx_poll_sleep_timeout(op, addr, val, cond, sleep_us, timeout_us) \
 	read_poll_timeout(op, val, cond, sleep_us, timeout_us, addr)
 
+#define readw_poll_sleep_timeout(addr, val, cond, sleep_us, timeout_us) \
+	readx_poll_sleep_timeout(readw, addr, val, cond, sleep_us, timeout_us)
+
 #define readl_poll_sleep_timeout(addr, val, cond, sleep_us, timeout_us) \
 	readx_poll_sleep_timeout(readl, addr, val, cond, sleep_us, timeout_us)
 

-- 
2.55.0

