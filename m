Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89D5C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 07:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F1087C86;
	Mon, 18 Mar 2024 08:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="uo4XYLKi";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDmvo87o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900E987D66; Mon, 18 Mar 2024 08:39:27 +0100 (CET)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72422879F4
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 08:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 5282B1140103;
 Mon, 18 Mar 2024 03:39:24 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Mon, 18 Mar 2024 03:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1710747564; x=1710833964; bh=GL5eTyq/gh
 M8ruv4aBZUbBh7Tfa6AIdjjtaJD33iocY=; b=uo4XYLKiYXY/MycozEI6wlS+N+
 ZBp8P7yUhstoyFw18Czun/wwwIDmdqmI39g59lOMrrBpA9I9my5XYk2WZul0OuuO
 7R4o/nPVGO/teZrp9vnINdS1juKS4GiDkIPJPgaImbIE+hm9c0mpmJsgazCxPMDW
 BJ4SEPDFkUh7L1NoVJ5i4f+nfbhc7YdrwYjVrLc28OemH5i2VnEbU6gfITlsfCQV
 ohpYo3uJsSA5AQ2Kyj0qBU578I6XU7zjogdgzXU7dTlGWfY+Ez37uC2GOI2i3QlD
 9/iErJhgb00CkLFBGiJuF1jcRKObaT3sbFsJeM38pK7rCsdVzGGjBv3e/CAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1710747564; x=1710833964; bh=GL5eTyq/ghM8ruv4aBZUbBh7Tfa6
 AIdjjtaJD33iocY=; b=VDmvo87ofvzC/3X6VV2XJKx2EgCZa/RoR/mL0pre5Sni
 /mPymy82QnCSRdZV+rzOQVOPCoytX8iFZUIUv0ZX080pPW8B2c5AEITUtVLlE5aW
 pWLzIs7inpSMg595DVqbdTTDRU3Xj7Y1HDglwW0PGGZQZEJpweTKUgYv1syoheVd
 LWw0b8IM49/fbIXIyhSSz/Hwqolm9py5w7QRqPzEu9FKulMLbxitK2dhSaDR3Qm7
 Isrtfyi6qKW+mVQ/kTb7nzRq8NV2Awpce9veYTHb7gSy67Rs6EdS8PNhQ7+NbeNe
 1QiBiJj3dmLc6VOOOUzpvRVAkQgjDN83WAeqRwU1Fw==
X-ME-Sender: <xms:rO_3Zb7gYaFssMtiKljViE6UcRLGO9mmYrrcb0pIQLQT94R2qqGj4Q>
 <xme:rO_3ZQ6BteEGc3qcbRdfEznUaq6XJjhkEKhTqorCdKFJZSXw87xucnj2Wz6XurjBp
 KY4YZpy1-IA53QA5VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeeigdduuddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
 dtredtreertdenucfhrhhomhepfdflrghnnhgvucfirhhunhgruhdfuceojhesjhgrnhhn
 rghurdhnvghtqeenucggtffrrghtthgvrhhnpeevvdfhtddvvddtgffggfeuteduhfeige
 evfeffueekheetffekjeehjeefhfeitdenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:rO_3ZSffgkDPFWkakFGxzIMhe_R_xBa8fihq-0ciQwScQJWhUNqREQ>
 <xmx:rO_3ZcJ5DdsYu4_Bjr5NH8ESb7PEEaldjWYX6oJ51mGtwBYipP-CQg>
 <xmx:rO_3ZfLnPBek6fC63h7GDIsd1TRVki1Nn0YRlC9MnxYUrQ4x7KGQoA>
 <xmx:rO_3ZVzKUM33SXyQuI77bNxEriYsBUhV62z2bUEo8OiastKD0pMUhA>
 <xmx:rO_3ZWVBrmMia31FY9rpkyUaFUFp9z6EAHB2nxuE5sIEh6I9oFJZvw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1B14A36400B9; Mon, 18 Mar 2024 03:39:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
MIME-Version: 1.0
Message-Id: <aa39aec0-ff84-4bc2-8146-c299fa608123@app.fastmail.com>
In-Reply-To: <CANV2PTPfth7Z=BYah6xLT3BoparckKzG=dtJAEhea1PdtibMWg@mail.gmail.com>
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
 <CANV2PTPfth7Z=BYah6xLT3BoparckKzG=dtJAEhea1PdtibMWg@mail.gmail.com>
Date: Mon, 18 Mar 2024 08:39:03 +0100
From: "Janne Grunau" <j@jannau.net>
To: "E Shattow" <lucent@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Content-Type: text/plain
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

Hej,

On Sun, Mar 17, 2024, at 22:39, E Shattow wrote:
> Should be usb_denylist, since "block devices" is ambiguous meaning if
> it is a list of data chunks (blocks) or if it blocks (deny). There is
> no question what a denylist is.

I briefly thought of that concluded that the spelling "blocklist" removed
the ambiguity. I not sure about "denylist". It sounds weird to me in the
context of probing USB devices. I'd rather use "ignorelist" as alternative.

Janne
