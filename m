Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEB606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ayucR/3v;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=esSjNm4/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9963940B0B;
	Sat, 31 Oct 2026 06:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1676zp64lLKb; Sat, 31 Oct 2026 06:17:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E739C40B0A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793427420;
	b=lidnfiIc1ZGJBjug4C4KuenGL2kKf/GhmGlR4UDzCajLbemPRujwa4Ma+GH9v9pGqzXY
	 /eO90y7LQ+CHuD/iQZTqIPURYFFpglKy+drW/v6TxJhCACSWjUzqZRsrBC+RitmPxEARz
	 WEZAB1ugm09CFr16ZF7DSfmtz6Cy8+WhFxpBjuf0X6NWbYxPOkJsCT7ZpixuxlaQsgMrH
	 vgnUUvn7A80adbGdLHFrufrh5mtUoDLLMcO5FtmAX8vLBUqknIxOrbV3igTOvQvoMigfq
	 2WvjUsNimYUInJm90G0P6Yf+LwhMLU8JHZ343vGy5lIKxdZkItUFFwMIP/xIY9dtZPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793427420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1sNU8kHnPvR0o6JZF1oO93s2+fN5yV//dXwl/65c0uU=;
	b=iJpPOnUEBVaolkksg+p1TuySdc10KBE9TE3soVJgDkSdybcuvD5tFcXBmnX4F5TdingH
	 NoQcjDYJ7HcVSvOofT/3byB5/nY1YHJpJnaShlB06x0B7ScdRDJ3g5udjfKPvBnLyhY4p
	 Lr5LLuPHJgilJ2Wh8uSVYk/SV2/+QHqtPFFiAvjgjNymDy8icT4rdXgtHxO/tV3ds+7EM
	 XdcMg4SYsTpbUXiJK97wmVTxPhagbpQQKkiAVpxa00f67XYiuoVJTqmEI713nB7CGAReW
	 Kk2FdP40jTz/BF+NvEWql3RbRHKbSjGpIvXmXPpPPX29iciuDTpDyPHqsgey26DQfWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793427420;
	bh=1sNU8kHnPvR0o6JZF1oO93s2+fN5yV//dXwl/65c0uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ayucR/3vkQ4wNwlmp1V7U7WhvE0Iy9Z/i+8/mlgejBx+yRSzdq7rFXxiwnTjjYu3W
	 Wyi4Xs7mMY/4TqfMofWRoytyfsDDie+obxbuY/zW84GilrKq3EoDPP416ELU4hhgW6
	 72BZ4B7DKMUok1DuroRpbaspqZFYgwxDZ57UID5KNLF/Jv3h6xgh6U39Kx7kF90JRH
	 Fa+UF9SSYr5Yvt422F+qxecXbl6J1fUMS20SSZSDDKueUG35qBgPc1npb9A2VcZSUC
	 pbiqiMuFE6UP/pLPWq/+69O0j/2a0V89fQ8YWs4T7ewAiM8dkwin4+r66a4QkPfWmJ
	 N88P8EQLvhxww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E739C40B0A;
	Sat, 31 Oct 2026 06:16:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A0B9E235
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 864AB8116F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id imss6KCpaRzm for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE1B18116E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793427418;
 b=qaGEYBJETvFYyRWaPD26wzhLaFZmWZhVvqbae8vnG2udfr2DXK3eUK4TCr5dgUuLtn+q
 XWaHya8e6ZdE+1RDej/pKhxHPjhhjdoO85W9uNJMWKk8Ma5olWX17mC7vQBFMe5NIow2O
 1Ym9ePoOnIHvKbthqX+TDNHPS2P5CuhkZm8moNwvZQlrMPn32xid9c0Hgp0FvNbcG4Hse
 Y+4s4xXF9V+B5LeioS7ahvzTywKk8/0nRM/WS7+YnEqXMbs4xvJ4oE2mWOIyynbEPFmT2
 l9XbMpLym/3n0x6FzIuwaxEkkuNSjqnLxXVerBPAg8MMPaTCRte6eLjkNAqr21s1dPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793427418;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=1sNU8kHnPvR0o6JZF1oO93s2+fN5yV//dXwl/65c0uU=;
 b=hGC9sEp/PXwFS7D99EjZPUCvR6mbjMQbBRnZEmBo3HphyB98fNs3SrrSquG6nRm+r+ul
 VquNUmXLwAbz9pPPE8w8nYm82MeOowH1qtFz1flTeBpGrJLe+tkpLQBVPtnevX9PBfsgz
 0UTYYHLmJNnfCLKbUtHAn3150AFDBdMn8n9sngURfqXUgHY4Lb0H4b/ACDYaCNrU3Q69e
 tK+W5N05dQU7PvPoqiEVwMdSLkZBzTyRwyya/D3Rus5nr7hZ9JBiwKStV1y0vGNDebjpu
 nhB+8YqTs9rMI0LrCz27Qg32mcst2QoaQqCNYAG2bu035Frm3CLFa3UaEddCLIbykwQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="esSjNm4/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=esSjNm4/
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE1B18116E
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:16:57 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so13803255e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793427415; x=1794032215;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1sNU8kHnPvR0o6JZF1oO93s2+fN5yV//dXwl/65c0uU=;
 b=esSjNm4/oR2a1yd+D0ne6tUQJwqCT79Dh5YbqUx2736aw5H8rhVyCulz8v3a4Y4F4a
 Jrj1mefFPaJAK8SEA0AWt2ZihMT+E8GmB62/MD1CjkQK4L6Ph80ZEgzFVqknYVzxUicJ
 bWWxoVe5JrAGtiRPToC9O62EnYevG9PukZUEezHpIdvkCn0nwW/eD/ob3CRS5SldU6l+
 Dk8o70rO/cFrUQ6Xpp2+fjoSdfLck/Q/MU8a+1nPYXHpN4SUuHChb56A+asgM4VFUK4f
 0OJf39slvO7XnPQ8p/EFNRz2OjnQaQBsi6q67j0Fh96ARyYJA1E/JfIznUDExy2fX4iG
 7FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427415; x=1794032215;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1sNU8kHnPvR0o6JZF1oO93s2+fN5yV//dXwl/65c0uU=;
 b=UNg4n6vWny66OLermjy02WOPBiFm2s5lBD1nW3NZf/HYQ+uLAuu5zrXifeNedReVA/
 9LrvBCCFUVeyJ4oQXxK5Yy6+/wlE+zeLOVuM09D9k2YYy8nRBhTCMWk20kz+g941CWaw
 vfvKG4aWUTGXuS2k6trCRcp3xHjo1d8WqrBCjIsYJP0fBflSJTHpVImpw2dWmJKeEKaQ
 ncFN0uyz3KcaEe8MQtXJGtk/sIyypDeC0qlpvMBVeVX9zKQ9MBlXXVeXsx6XNJa5iJhy
 1DQU9a3YexXGCLuqi3xvcIs3l0PQrkW5s1ZxWviwNJdAR00agDy4a2XP0nvmiyLlaIeR
 +4Aw==
X-Gm-Message-State: AFq9FYICT5SZpzmRXxhsNk+QG0qu1rHnWGi+Def0uQlT6RlAzgeT94eO
 x/CUvb9jnXsFkerXpyF+TZaQfHNdIRkfUPjOmpYNN9Bn2BISXSPf0suM
X-Gm-Gg: AYBFou2vqhvHwo6EFDEaZczdSHUISweQrUCZGVBM6bY78g+UK7r4WqlFo8Ut477cVVg
 4XY+m2j3UaPtjdU2EQapCoKZcFLmOTFfeBf9xPJ3lFXSgC4YOdyPkSQ0mI+s6DDURwqD6wyGASe
 +lRPKVW30+LnFyxO4E0i709ehBQemQm+7prPn4pSsDvAObDA/0Ywf1WJMxrdBdIxMTz+6eRbyLX
 VYpg89+x3x3dIYJtlet9/KEV1KCUT82m9YU+jUjEEHdNG7b52ijIPLUliCb0UXv98JokLFc1E6q
 VtbU682Bj+4O+Oq1adD6T7cLUr21unhrV9SNmWGRRCP4WBtgf55T4/Z+qr3CCc32HRVD+eMMU7h
 9Jz+8UOxw6pARpyGGMYsn2tIpqF5IDpnloM4AJp5ovQpI4HYrbH1d+r0vH5nWSJ/QEZO8JtlhiI
 Cr5ShJX4VEZpk3Wve/gSP8XCDuxSmsA46mzujhoK9qMGh1Vbw0OklvQ7DXObawe3PiB13jgdqij
 tUeMJ0FrYlgX5rkGTB51Nn9laB3zRfhL/66d4fgGpbKGID2zNuwDf8Hxa6SzQbcPbWMWg1J6OSn
 F35Py/iTyvj3yyd6Siuq0ZymjsOcbd+UKWiuC3snDhyqaHVuTf30
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id
 5b1f17b1804b1-4acda922e24mr49016025e9.1.1793427415454; 
 Fri, 30 Oct 2026 23:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b286a0sm90360675e9.4.2026.10.30.23.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 23:16:54 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/6] usb: raise USB_MAXCHILDREN to 31
Date: Sat, 31 Oct 2026 06:16:53 +0000
Message-ID: <a37483d4-31d4-49ee-b0f0-a96110055873@gmail.com>
In-Reply-To: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
References: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

A hub's per-port state is sized by USB_MAXCHILDREN: the DeviceRemovable
and PortPowerCtrlMask bitmaps and overcurrent_count[] in struct
usb_hub_device, and children[] in struct usb_device without driver
model. At 8 this is below the port count of many root hubs. An xHCI root
hub reports every USB 2 and USB 3 port of its controller (HCS_MAX_PORTS),
more than 8 on many PC chipsets, and usb_scan_port() then counts
over-current events past the end of overcurrent_count[] for the higher
ports.

Use 31, as Linux does: the port bitmaps, with their bit for the hub
itself, then fill four bytes. A following patch keeps
usb_hub_configure() from using more ports than this.

This grows struct usb_hub_device by 96 bytes and, without driver model,
children[] by 23 pointers: about 4.4 KiB more BSS on a 32-bit board
without driver model (USB_MAX_DEVICE devices, USB_MAX_HUB hubs).

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 include/usb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/usb.h b/include/usb.h
index dab23753f0c..76a3efa49d3 100644
--- a/include/usb.h
+++ b/include/usb.h
@@ -38,7 +38,7 @@ extern bool usb_started; /* flag for the started/stopped USB status */
 #define USB_MAXCONFIG			8
 #define USB_MAXINTERFACES		8
 #define USB_MAXENDPOINTS		16
-#define USB_MAXCHILDREN			8	/* This is arbitrary */
+#define USB_MAXCHILDREN			31	/* As Linux: the port bitmaps fit 4 bytes */
 #define USB_MAX_HUB			16
 
 #define USB_CNTL_TIMEOUT 100 /* 100ms timeout */
