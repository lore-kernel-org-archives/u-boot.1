Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9670CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D4F360E1A;
	Fri,  2 Oct 2026 22:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vc8mX8ds5rt8; Fri,  2 Oct 2026 22:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A31D660E1C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979019;
	b=RrAI5rFk/5j6NyEFbL/Zdpugym/1CB7bVmPNMPBZYQALlAYfE0yhcdjl+1SpCmNTq0cQ
	 Q6e12yX07t267Z0W+84+CcreuORdjwYq8NdQg1iCpD7IlC7r2CwOYFkdmGo1EvM/VDGnI
	 ps17+yojExd/EvtfW9gnUcYgNoteVMT586UwB19ByKSsKK4jp/Qs78heFy/6nqhf+29jZ
	 3GZO4TYkSfOX+nlQpCi8nUjDn5GJ9mWy6zc8TG7/LZ7NZNPdWkln2R3eUEjQ7Mi0Zt+ow
	 PrVN1o5Z5GV70ZRDmeRohrhlMFxj01Ol13i6leCuH9zh8z58MCGfePe4KvBnk6C0k+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ogpDbgqvPCFCmRHcDJrGSGBL9UxJCowK/eRuY5VfrVo=;
	b=UsuB8vu9AQyN58Rp2cdb70kUAUwKkB6cn1JYcN/3M8b8JrfKoEoqXofRf3dJbi/P+B1F
	 g1WH3/55J13q1Fck9fGtCcwwzLMwI8DTiz4TyvDFsB3/Xnq/BMDoJiVa552rX314i0o/2
	 OUWsQ4ui0TUSD7PsPAYHD/gX65u0ZL5xmyJgu+sTRacEg16txuzQqpsG6uIJqpodVNUDV
	 hbYJTZJrWu0W0TM1FiyIxq36lQuR3tQMm/fP9IfL20VwnVourJVuK4a5+QxLYvkDoIiOs
	 OHAI2Gy+6xgjNTya6sOIUgEAOgjayZp8wA+ZLRcOT6Xzk1Oz1CBsulP422PY/VbfpKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=tUq3UV9+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979019;
	bh=ogpDbgqvPCFCmRHcDJrGSGBL9UxJCowK/eRuY5VfrVo=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GyGlBvwbiR6TGdtdU8/Kz3kJWCpC6T23UzcC93j3F6cVZ5+p/ZAZI0QAJCghX4sin
	 btD4E5OcubCzzVmaxMmMDzQmon3aZuvp48Ju/dfc6aPzlbqLl2QjSRGIZDV4/Uuy4p
	 JTLyY4f+XKjIRgGbg1xZO1HlAhmS9C9+bwSCpsllwj/1x8tDQ31bBBn8ia1OfKXuZO
	 cUjq3t3zG8o23yHTKQ380aEU1HlzeQPvexsL+C8AmNIuy3BMVtqqOdquFKAEsBBXcq
	 gRSx77TlxBGEGeP5K3zfLP7yjfvVc2UjLsye88Yu7zls+76sLul/2s4XLU3qOiyZ9V
	 XZ5j8i3YYYOGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A31D660E1C;
	Fri,  2 Oct 2026 22:10:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E93134E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8D4F60D9A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aApxjDatKe7b for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 22:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A378F60D70
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790978816;
 b=K3JJ5xG9VXP6O27ssLE1oowpYuVMbBxt7PoszH7Yc+5Q1fllnjzA3Kf7PRDCQklEd4Ty
 RVX18FZX9gyjx/FPXgo9M8Y1e1AZOCi32XW67AsDAtrxKY6odm4Nnhc7eivPVmThlkvGh
 leIAqgH0/ZyIC7f5B+hq380jBsaxjOwCm+El8FiLPr0LlrarCcpvLueevykyZzpdOm6mD
 BkyQl9TmeXKKHLFLKvBToSk72VxeF2kbnFn5tbsKMmaE/x4nNsuHudceaH3G0T4D76kAZ
 JbGcNJZ39rQGM94WtNYlB62VUFPdZlGPOV0Nu4Cl4Y50DI9jGVJn/EsiAUWM1E2XDrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790978816;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=ogpDbgqvPCFCmRHcDJrGSGBL9UxJCowK/eRuY5VfrVo=;
 b=AcHeIt9puImSY5KP1dGBY2CW5ZWxGyiVR5mI+dF/BvSFK722d3xxNsk25NuN4xyvCqJi
 icewJ7G1A4Bjb+gB/XkRwRGr5MGmDH7dDiWmCln4WExBHnymIvAZgvJeJ+vf61/rgL96x
 z7thYK2I1oVddojd1+bRo9VHWlzxm7HC2m4bHaV0aQTfjkkwVaDLT3IiIRxVvivkzb3Ll
 adZE9JxVNXArXqpS13XEK8IQm89IP/IYzC3OBM2YSxu7KhBzx0Bpxm9k8xfIGZMTPWL7G
 UXBPjxsSUZ78+qOVTlMsTt1/psk5/G51jPEzg68ButgWFqaIdeY0NZ/X/NvB/BlFmmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=tUq3UV9+; 
 arc=none smtp.remote-ip=79.135.106.121
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.121;
 helo=mail-106121.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=tUq3UV9+
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch
 [79.135.106.121])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A378F60D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790978813; x=1791238013;
 bh=ogpDbgqvPCFCmRHcDJrGSGBL9UxJCowK/eRuY5VfrVo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=tUq3UV9+zfC5r86/iZGebIQsWoGIgjPcNtQcL8RaEeI1Qliz1WRvgWl02oc1ToUv3
 9+uYBMWvB24LJmfyOTva7Q+vlb6MRRprk4Yc1y+uNyChL+eTsOv5YiIYsePbkWLTDs
 KihkEGIzTdq1KTAgEA1SgyzwPa7W+t8f2um+fLE/vjc2UENebmngDuda3pRMwZ4t/U
 y1pDFHnLU8JSXrfE6UPTAo4MAIrmy3cSV3IEdinYwXAJpJosH31eE3tf6o3UBR0nlw
 o1mLDph5NbUhJ8R0/qM6/BOULbfXI64XJQJaW48+QcxQvsdKoY2RRE0ic6I4ssmgT0
 Xp5HDN6dXCOoA==
Date: Fri, 02 Oct 2026 22:06:47 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: Re: [PATCH 0/7] phy: spacemit: k1: fix the PCIe and combo PHY driver
Message-ID: <20261002220642.314419-1-DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: c9fedc0f55d27aca0fd8de382ab44a1a98982f4e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 22:10:03 +0000
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

Also tested on an OrangePi R2S (K1, 2 GiB, boots from eMMC), with the
same tree as the RV2 runs (upstream next plus these series and board
support that is not posted yet):

- the combo PHY is calibrated at probe and switched to USB 3, the PLL
  locks and the xHCI starts ("Bus usb@c0a00000: 1 USB Device(s) found");
- nothing was plugged into the port, so no SuperSpeed device was
  enumerated on this board (the RV2 enumerated one at 5 Gb/s);
- the PCIe PHYs are not used by U-Boot on this board.

