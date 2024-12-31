Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC10E7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 13:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139F78039A;
	Tue, 31 Dec 2024 14:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kevin.km6g.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=km6g.us header.i=@km6g.us header.b="NR5Iz+EW";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kzaf76a6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B5580383; Tue, 31 Dec 2024 13:05:08 +0100 (CET)
Received: from flow-a1-smtp.messagingengine.com
 (flow-a1-smtp.messagingengine.com [103.168.172.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD1380379
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 13:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kevin.km6g.us
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lists.u-boot@kevin.km6g.us
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id ED6602005D1
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 07:05:04 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
 by phl-compute-05.internal (MEProxy); Tue, 31 Dec 2024 07:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=km6g.us; h=cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1735646704; x=1735653904; bh=9bgqUVZBj5JZ1MLMWdqN7ZWHJEXkSf2E
 AB79ghSlar4=; b=NR5Iz+EWJ7ILT+AkTwyrXjPIxwBzZieR+w6jiC+W1cIMnZ9I
 ZRpZkeXWD1jIqdkp6UUgc+/KbGiCR1YE68eHLHPX44Fo3BM8bOaCKALRCoM7DjnL
 BJIT3DHJuEbHnVtmCjxiOzAXfitDFRKMbpjFEl9pakbaMPLdvCGQn1Z7W3nr4X6k
 w6hYdlCVsYg/I2i1RdtH+1yQiRnqWiL5mQ2tK2rSeXfKmHI0zw50wQYeiOWQ/E/K
 WByuuBwQg7j8ZBX6NYrrJnlSlcObJy0Q5oMunHA0YjrQZgso4FEzFdzgaaqRbixT
 B34obxJACHexUL5rY9R6jsqb8UZQHm2O87/hfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735646704; x=
 1735653904; bh=9bgqUVZBj5JZ1MLMWdqN7ZWHJEXkSf2EAB79ghSlar4=; b=k
 zaf76a6Ml014A9DznkUFldrih6hhFRnwbqTu2/eraaSyuA1JW7AJn6k8cZzlSh6h
 b86TJl+KEAgJhAvvxcLQiCXIXH1ThinyL177JMwAeD2y4cOfsbMzHVwbadc3pqrp
 gZj26azYK7djb0wHYr/yRWMn5H8YOqLGxK7iKYCT1reKUQc/uUpi3WhT/Lmau9oM
 U9uh4e9a5Ke9Q5Nk8xaH0rQCF6MLDBiBRS5ecvfSMBhuVP+rH1QgMcyGiPETbFVs
 6w2poBQntkHU4TawA+prJoitCNGoKWl71s1nt7G178Lp7KqbjxWRzjTNY0KtPOzN
 3aejBy5HrfL3J29ojoBnA==
X-ME-Sender: <xms:8N1zZ1ZNZBCzCXv70S80gvfTTH7ckfUyY95ART4K1Gc01wIQNf3jCA>
 <xme:8N1zZ8ZNbj-gXrN63xM-NuJFiRHnwEWZCBxZx5Elg6rzgWgZ6hnRxMQV_JdYwCN1Q
 1MVmWRXncjqJCHt-dU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvkedgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
 fvkffutgesrgdtreerredttdenucfhrhhomhepfdfmvghvihhnucfrrdcuhfhlvghmihhn
 ghdfuceolhhishhtshdruhdqsghoohhtsehkvghvihhnrdhkmheighdruhhsqeenucggtf
 frrghtthgvrhhnpefhhfdvleffkeejvdelgfeuveekuedtvdduueekkedvffelheffkeeu
 veefvefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehlihhsthhsrdhuqdgsohhotheskhgvvhhinhdrkhhmiehgrdhushdpnhgspghrtghp
 thhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdqsghoohhtsehlih
 hsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:8N1zZ39Zv3n1LlJEa9wF0ylvP8uLFn9VtHUIAQlIJNh1aHF9kIGAIA>
 <xmx:8N1zZzqh2KgEzi8Qmy0KSUb_r2n06zPoa1oBhGkus5lJu66sIoukWw>
 <xmx:8N1zZwqG0q4he8LHxxAhrjsO0-uTHXBzHgJqeQfn7j0ZRIwobSQgFw>
 <xmx:8N1zZ5SqLlKd9H4spxLyfJMI92psQoYjUl8fNvcw9eHwy140uZAiOg>
 <xmx:8N1zZ2Ez6FbR4FZ5AXF3UUjzJhv9ldOG-k_cWmU75EunANf934MGXgZ->
Feedback-ID: i1309466e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id AA13B18A0068; Tue, 31 Dec 2024 07:05:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 31 Dec 2024 07:04:44 -0500
From: "Kevin P. Fleming" <lists.u-boot@kevin.km6g.us>
To: u-boot@lists.denx.de
Message-Id: <b47e98b5-f273-430e-b882-d99e0e306334@app.fastmail.com>
Subject: UEFI ConOut with systemd-boot: attributes aren't working
X-Mailman-Approved-At: Tue, 31 Dec 2024 14:27:06 +0100
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

I've got a couple of Traverse ten64 machines, which have serial consoles and are using U-Boot 2023.07-rc2 (a bit old, granted). I connect to their consoles using Minicom on a Debian machine.

If I stop the U-Boot autoboot process, the U-Boot menu itself is displayed as expected, with 'reverse' highlighting on the currently-selected item in the menu. If I continue the boot process, then systemd-boot displays its menu (using the UEFI ConOut interface), but there is no highlighting on the menu items. I've tried both VT102 and ANSI emulation modes in Minicom.

Can anyone suggest steps for troubleshooting this?
