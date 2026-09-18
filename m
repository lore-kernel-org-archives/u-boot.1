Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26595C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 13:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB58560DB7;
	Fri, 18 Sep 2026 13:28:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSncfuGdmoE5; Fri, 18 Sep 2026 13:28:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 09B4260DC5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738111;
	b=D1TApCg6cCKvYTTUSXzdH1jceOY8AQqZN9kjunPYex9hnukCD6jBXMAltNmPcP3E3UyY
	 GZ1ZYG18j6CZi+/ndQxrmz95yEDA8vl/MalSzIMHNYDqhjcAvRXCpz/iWDgoJLFc5Mrox
	 MWLJ98DKyN+JoZabn5fuLT3GkT9f7ecN2GLIq52V0QBjWdZ+Y4lOpufNG4jw1gJGj7r27
	 UnqMimj/8BX23KBIB1yaskQWF+Rrq1hclWPYCuC0wAoRyLmo5twHLuin2gNnXPyfHqvgc
	 hQEd5V3vt0nlPT7mytryjtDtiF66D97bvdJ2gnI7EUEAS3GGIx05eSqNe1IGPUhlFEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=bGf1TghBLFgcJvQW986x5Gqd+nDbqAgNq4od2hV0x5o=;
	b=LhoEdZtNXdCOAkXPSAlhYmU+XglNei+2ebLYVUAikh4/0+4ifbKsTXVNnzHBxf0JdPlh
	 6Dnkq/+9hTeDWH23E4setFcg8kURKbnCbgjaM5meAtG1OfDMLaySImwd2jrCT1o4YXunb
	 xRv0ADFaXPSQQFilG3t3v1bZsnm+cqSSQQW9k24SI//jZI7zauBpu9UVSVoxwHwySlLUr
	 joa9Q2mDKMENQPsS4SKLT+C/phOyM0DTkfzLgs5TZLKFOPIx0jMuTDaqaBHz+WtdwKJO3
	 B0cjkxRXKORzfR2+FjLPEkOpcWbd9j/aiUkBdn0Vtd7eIbpv067QJTNll0A39vNy0pQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789738111;
	bh=bGf1TghBLFgcJvQW986x5Gqd+nDbqAgNq4od2hV0x5o=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=nftBiXXS9sTUQ2Q4QQlFud0rUO8X97Kdkc/n33rCv/fpz5x55H+q3zitpfSCfinZO
	 ye3/JpkWOORJjnQ2yWdQ0jWJ7jRse7xl+KnQkCpL+Tytf9mQYpmuHRNypFL16r5keU
	 0kr3M/2WK3FS2M57z9hw9Dua2lTMOO1IchY0BddhwNy6Y/PgWoHhjt2E20ylXLrzVO
	 tU7NLUjM5rQCWtTXe1qV0tDvnOgN6ksxjqHyAxUPl2fNjOBMALI9nXz1TedtGrk0Cg
	 yluJxXy1lszQPBOh4//Uo1/4nJdc4kzZjYG0gMqgVXaYXnsvO00LLr15S4ciOLl2UI
	 QbHAsp4MBWu3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09B4260DC5;
	Fri, 18 Sep 2026 13:28:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7857213D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A68B404E6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0a22wk-7RLwG for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9AF5140048
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789726317;
 b=mkmT3FzvuxWFsxIUS3OVrpgGaqG+NkwMSpgXGUswNwrAEnejs4lNiORTp7RlwXeiP5IF
 oRB3S5fdSKP2DejkM9Ej6RjpPTNHvue8ZWyUsbjJXtg8kJap7ViDeX+Ft889tFGP6cdEa
 gJ0ju5PEYm8S6pB2anYziZfy7FJ/E6pqdKZmtRBXcqI57dbhNbKEK+KKNhAyncdOnzRTe
 lohFLtxwsfE0i9RWT8pqzl88CtAMaAPsrDKk6W1822621POctrE6Te7Cmt1ff5vIJFjzr
 b00Pe8jc3t1GCAwKioqE5R0gyawPgImgmsJ4i3oTclc+r2kJeCC4MZiQs4G+3GqOS3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789726317;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=bGf1TghBLFgcJvQW986x5Gqd+nDbqAgNq4od2hV0x5o=;
 b=ALjDus4a2e3nMzMOdmoaSpxNPNUh74OlzTXDLD5Vo7wcCQLwVTEqD+rWwaF0+OXMTOaX
 HnOM6dBf8FG27puqWhzlaS3QSnqWqv8xnN6wpceE0RefaYtcRXn8DABFu3H1UN4GB5h9u
 HcZukRpAnay1M+HON8kqHEn0bHpOCcAaFpflNs9f33GGLrDUzxem6iiXb3ujG/5kEbUf9
 R7Kmb54EWeIWzNfAwnKhJv8eh4IYET0hLTlcpLrMcxjy+KjOYKSKxHaKSfiJCKCvjNgNi
 1WpOPJbTkm2mL6b7BTfM34HmOyHUHVEHS3tO9bo9+aRNK4+BMB/LjFA7zO0HkP3EIrw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B6Otts6y; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+stevenjoezhang.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B6Otts6y
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AF5140048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:11:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7429F60A5F;
 Fri, 18 Sep 2026 10:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D79CC2BCB8;
 Fri, 18 Sep 2026 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789726314;
 bh=UuauIgWSAwpZPljkGEgeldZ7z11uc6YYnvEhnKg8uNM=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=B6Otts6yeSUkaJB7cUp6maKAZRD0beHHdnoaDzliCFPEh/I9IXbnlqZ5CChG+8122
 f5TNzyMehVMlb5OWHVujdbg7OwNv8bwY3gGQTeWg4O8d2tOjtera/RCyYLm4Li9p77
 RdEPDMsTx6/2eeFdRKD4wHX0cOcKXwavdaCtV4HkNIY3x7WnSnhEHBdAX26pEeYowz
 9OlK2qk02+o/1yVVaG7cF7KSflxFtllGvd29j3kQ7dHHiP4PjvmgWXw6oWhKvRBi+A
 SGFkQio+3pO8TSKSQE4CEq/UwBLbEoWyvBZQTusx9rWB8hvWy6LfEuMoHWqJRrRTMQ
 0/4EASsveVzSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 086D4C982D9;
 Fri, 18 Sep 2026 10:11:54 +0000 (UTC)
From: Shuqiao Zhang via B4 Relay <devnull+stevenjoezhang.gmail.com@kernel.org>
Date: Fri, 18 Sep 2026 18:11:43 +0800
Subject: [PATCH] usb: gadget: rockusb: terminate full-speed descriptors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-rockusb-fs-descriptor-terminator-v1-1-144ffc0f3d33@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWdukYKjoVYyLdjroaGzJTDEmh
 LtTdPe+zf8WUBImhUuzgNCHlXOqaA8N4MOnOxmO1dDZztlzOxjJ+Jo1mFFNJEXhqWQxheTNye/
 TRjr2Dk/B+QFqZhIa+fu7uN7+1jk8CcvehXXdAFw0Pj2EAAAA
X-Change-ID: 20260918-rockusb-fs-descriptor-terminator-0de356c7b6a8
To: Simon Glass <sjg@chromium.org>, Eddie Cai <eddie.cai.linux@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789726312; l=1530;
 i=stevenjoezhang@gmail.com; s=u-boot-shuqiao; h=from:subject:message-id;
 bh=297HYVzWoQyzaKEMPkmjlbobrcxRs62BISXqTzaxyhU=;
 b=0IkVa0ol1WYBkuYIIcm93Tk73Ux9PcG1uzhB8eTMJJmP9r3Wl2azNrlE5qSAhoKoIZghK+Ysf
 L+VVUgA3WQIDA8aktY9FyHPX/dGNUiS5a7C9mr7unsxIgMLokI5FmlW
X-Developer-Key: i=stevenjoezhang@gmail.com; a=ed25519;
 pk=Cbf095HhBi2UNpPtxc2MTfm3SXCBMpGzqw/m9h+Ykco=
X-Endpoint-Received: by B4 Relay for
 stevenjoezhang@gmail.com/u-boot-shuqiao with auth_id=1036
X-Original-From: Shuqiao Zhang <stevenjoezhang@gmail.com>
X-Mailman-Approved-At: Fri, 18 Sep 2026 13:28:29 +0000
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
Reply-To: stevenjoezhang@gmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Shuqiao Zhang <stevenjoezhang@gmail.com>

usb_descriptor_fillbuf() expects descriptor arrays to end with NULL.
The high-speed RockUSB array does, but the full-speed array does not.
Full-speed enumeration therefore reads beyond the array and treats
adjacent data as another descriptor pointer.

On a Luckfox Lyra Ultra (RK3506B), the adjacent interface descriptor
started with bytes 09 04 00 00. They were interpreted as pointer
0x00000409, causing a data abort in usb_descriptor_fillbuf().

Add the missing NULL terminator, matching the high-speed descriptor
array. After this change, RockUSB enumerates at full speed and
upgrade_tool can successfully read the eMMC.

Fixes: bf2b72bef14b ("usb: rockchip: add the rockusb gadget")
Signed-off-by: Shuqiao Zhang <stevenjoezhang@gmail.com>
---
 drivers/usb/gadget/f_rockusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index d679cdae97c..77a89b47d99 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -71,6 +71,7 @@ static struct usb_descriptor_header *rkusb_fs_function[] = {
 	(struct usb_descriptor_header *)&interface_desc,
 	(struct usb_descriptor_header *)&fs_ep_in,
 	(struct usb_descriptor_header *)&fs_ep_out,
+	NULL,
 };
 
 static struct usb_descriptor_header *rkusb_hs_function[] = {

---
base-commit: 211de43d0f954a00a490220c1aac9db298287c40
change-id: 20260918-rockusb-fs-descriptor-terminator-0de356c7b6a8

Best regards,
--  
Shuqiao Zhang <stevenjoezhang@gmail.com>


